<?php
	include(''.'/usr/lib/telefoniaip/classes/control/classeUtil.php');

	$execSQL  = (strstr($argv[1], 'EXECSQL'));
	$arqTeste = "/usr/lib/telefoniaip/arquivos/sql/asteriskBase.sql";
	
	$connData = Util::getAstPgConnData();
	$host = $connData['dbhost'];
	$name = $connData['dbname'];
	$user = $connData['dbuser'];
	$pass = $connData['dbpass'];
	
	$conn = pg_connect("host=$host dbname=$name user=$user password=$pass")
		or die ("Problemas ao conectar ao banco de dados PostgreSQL!");
	pg_query($conn, "SET NAMES 'LATIN1'");
	
	echo "Executando [ dropdb teste1234 ] (como postgres): ";
	exec("su --command=\"dropdb teste1234\" postgres &> /dev/null", $lins, $codRet);
	if(!$codRet) echo "OK\n"; else return 1;
	
	echo "Executando [ createdb -O $user teste1234 ] (como postgres): ";
	exec("su --command=\"createdb -O $user teste1234\" postgres &> /dev/null", $lins, $codRet);
	if(!$codRet) echo "OK\n"; else return 2;
	
	echo "Executando [ psql teste1234 < $arqTeste ] (como postgres): ";
	exec("su --command=\"psql teste1234 < $arqTeste\" postgres &> /dev/null", $lins, $codRet);
	if(!$codRet) echo "OK\n"; else return 3;
	
	$connTeste = pg_connect("host=localhost dbname=teste1234 user=$user password=$pass")
		or die ("Problemas ao conectar ao banco de dados TESTE PostgreSQL!");

	$sql = "SELECT table_name FROM information_schema.tables WHERE table_schema = 'public' ORDER BY table_name";
			
	$tabelas = array();
	$res = pg_query($conn, $sql);
	while($data = pg_fetch_row($res))
		$tabelas[] = $data[0];
	pg_free_result($res);
	
	$tabelasTeste = array();
	$res = pg_query($connTeste, $sql);
	while($data = pg_fetch_row($res))
		$tabelasTeste[] = $data[0];
	pg_free_result($res);
	
	$atributos = array();
	foreach($tabelas as $tabela) {
		$sql = "SELECT column_name,udt_name,character_maximum_length FROM information_schema.columns " .
			"WHERE table_name = '$tabela' ORDER BY ordinal_position";
		$res = pg_query($conn, $sql);
		while($data = pg_fetch_row($res))
			$atributos[$tabela][$data[0]] = $data[1] . ((!empty($data[2])) ? "(" . $data[2] . ")" : '');
		pg_free_result($res);
	}
	
	$atributosTeste = array();
	foreach($tabelasTeste as $tabela) {
		$sql = "SELECT column_name,udt_name,character_maximum_length FROM information_schema.columns " .
			"WHERE table_name = '$tabela' ORDER BY ordinal_position";
		$res = pg_query($connTeste, $sql);
		while($data = pg_fetch_row($res))
			$atributosTeste[$tabela][$data[0]] = $data[1] . ((!empty($data[2])) ? "(" . $data[2] . ")" : '');
		pg_free_result($res);
	}
	pg_close($connTeste);
	
	$sql = "";
	$linhasArqTeste = null;
	$tabelas = array_keys($atributos);
	foreach($atributosTeste as $tabela => $atrs) {
		 $pega = false;
		 if(!in_array($tabela, $tabelas)) {
		 	echo "Tabela $tabela nao existe no banco.\n";
		 	if(!$linhasArqTeste) $linhasArqTeste = file($arqTeste);
		 	foreach($linhasArqTeste as $lin) {
		 		$l = 13 + strlen($tabela);
		 		if(substr($lin, 0, $l) == "CREATE TABLE $tabela") $pega = true;
		 		if($pega) {
		 			$sql .= $lin;
		 			if(substr($lin, 0, 11) == 'ALTER TABLE') break;
		 		}
		 	}
		 }
	}
	if(!empty($sql)) $sql .= "\n";
	
	foreach($atributosTeste as $tabela => $atrs) {
		 if(in_array($tabela, $tabelas)) {
		 	$tit = false;
		 	$atrsBD = array_keys($atributos[$tabela]);
		 	foreach($atrs as $nomeAt => $at) {
		 		if(in_array($nomeAt, $atrsBD)) {
		 			$atBD = $atributos[$tabela][$nomeAt];
		 			if($atBD != $at) {
		 				if(!$tit) { echo "Tabela $tabela:\n"; $tit = true; }
		 				echo " ** Atributo $nomeAt diff - BD = $atBD - arqTest = $at.\n";
		 				if($at == 'bpchar(1)') $at = 'char(1)';
		 				$sql .= "ALTER TABLE ONLY $tabela ALTER COLUMN \"$nomeAt\" TYPE $at;\n";
		 			}
		 		} else {
		 			if(!$tit) { echo "Tabela $tabela:\n"; $tit = true; }
		 			$atBD = $atributosTeste[$tabela][$nomeAt];
		 			if($atBD == 'bpchar(1)') $atBD = 'char(1)';
		 			echo " ++ Atributo $nomeAt($atBD) faltando.\n";
		 			$sql .= "ALTER TABLE ONLY $tabela ADD COLUMN \"$nomeAt\" $atBD;\n";
		 		}
		 	}
		 	$nomeAtrs = array_keys($atrs);
		 	foreach($atrsBD as $nomeAtBD) {
		 		if(!in_array($nomeAtBD, $nomeAtrs)) {
		 			echo " -- Atributo $nomeAtBD da tabela $tabela SOBRANDO.\n";
		 			$sql .= "ALTER TABLE ONLY $tabela DROP COLUMN \"$nomeAtBD\";\n";
		 		}
		 	}
		 }
	}
	
	// tabela parametro
	$sqlArq = array();
	$linhasArqTeste = file($arqTeste);
	foreach($linhasArqTeste as $lin) {
		if(substr($lin, 0 , 21) == 'INSERT INTO parametro') {
			list($d,$d,$d,$d,$d,$nomeParam) = explode("'", $lin);
			$sqlArq[$nomeParam] = $lin;
		}
	}
	
	$noBD = array();
	$res = pg_query($conn, "SELECT * FROM parametro");
	while($data = pg_fetch_assoc($res))
		$noBD[] = $data['nomeparam'];
	
	if(!empty($sql)) $sql .= "\n\n";
	foreach($sqlArq as $nomeArq => $valorArq) {
		if(!in_array($nomeArq, $noBD)) {
			echo "+++ Parametro $nomeArq faltando\n";
			$sql .= $valorArq;
		}
	}
	
	// TODO tabelas tipo*, cc_tipoevento ...	E tarifacao
	
	if(empty($sql)) {
		echo "Nenhuma alteracao no banco\n";
	} else {
		echo "[\n$sql\n]\n";
		if($execSQL) {
			echo "Executando SQL: ";
			pg_query($conn, $sql);
			echo "OK\n";
		}
	}
	pg_close($conn);
?>