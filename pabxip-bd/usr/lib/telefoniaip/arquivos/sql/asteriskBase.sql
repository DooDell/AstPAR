SET client_encoding = 'ISO-8859-1';
SET check_function_bodies = false;
SET client_min_messages = warning;

COMMENT ON SCHEMA public IS 'Standard public schema';

SET search_path = public, pg_catalog;
SET default_tablespace = '';
SET default_with_oids = false;


CREATE TABLE execacao (
    id serial NOT NULL,
    datahora timestamp with time zone DEFAULT now() NOT NULL,
    idusuario integer NOT NULL,
    login character varying(32),
    ip character varying(16),
    nomeacao character varying(32),
    request text
);
ALTER TABLE public.execacao OWNER TO sa_asterisk;

CREATE TABLE alerta (
    id serial NOT NULL,
    tipo integer NOT NULL,
    numero integer NOT NULL,
    dthora timestamp without time zone NOT NULL,
    param character varying(32)
);
ALTER TABLE public.alerta OWNER TO sa_asterisk;

CREATE TABLE aviso (
    id serial NOT NULL,
    acao character varying(32) NOT NULL
);
ALTER TABLE public.aviso OWNER TO sa_asterisk;

CREATE TABLE backup (
    id serial NOT NULL,
    data timestamp without time zone NOT NULL,
    arquivo character varying(64) NOT NULL
);
ALTER TABLE public.backup OWNER TO sa_asterisk;

CREATE TABLE bancoramais (
    id serial NOT NULL,
    nome character varying(80),
    marcamodelo character varying(32),
    canais integer NOT NULL,
    tipo integer NOT NULL,
    ip character varying(16),
    nomeserv character varying(32),
    numplaca integer,
    pa character varying(256),
    descricao character varying(128)
);
ALTER TABLE public.bancoramais OWNER TO sa_asterisk;

CREATE TABLE cadastrodestinos (
    id serial NOT NULL,
    tipo integer NOT NULL,
    numero integer NOT NULL
);
ALTER TABLE public.cadastrodestinos OWNER TO sa_asterisk;

CREATE TABLE categoriachamada (
    id serial NOT NULL,
    datahora timestamp without time zone DEFAULT now() NOT NULL,
    numero character(10) UNIQUE NOT NULL,
    tipo character(1) NOT NULL,
    nome character varying(64) NOT NULL,
    justific character varying(64) NOT NULL,
    flag character(1) NOT NULL,
    idusuario integer
);
ALTER TABLE public.categoriachamada OWNER TO sa_asterisk;

CREATE TABLE cc_historico (
    id serial NOT NULL,
    tipoevento integer NOT NULL,
    datahora timestamp without time zone NOT NULL,
    data date,
    hora time without time zone,
    campo1 character varying(64),
    campo2 character varying(64),
    campo3 character varying(64),
    campo4 character varying(64),
    campo5 character varying(64)
);
ALTER TABLE public.cc_historico OWNER TO sa_asterisk;

CREATE TABLE cc_tipoevento (
    id integer NOT NULL,
    nome character varying(32),
    campo1 character varying(32),
    campo2 character varying(32),
    campo3 character varying(32),
    campo4 character varying(32),
    campo5 character varying(32)
);
ALTER TABLE public.cc_tipoevento OWNER TO sa_asterisk;

CREATE TABLE cc_relatendgrupo (
    id serial NOT NULL,
    idrel character varying(32),
    nome character varying(32),
    rec character varying(32),
    atend character varying(32),
    aband character varying(32),
    tmatend character varying(32),
    tmdisp character varying(32),
    tmchaemesperafila character varying(32),
    tmaband character varying(32),
    tmchamando character varying(32),
    tmchamcolespera character varying(32),
    tmpausa100 character varying(32),
    tmpausa character varying(32),
    tmlaboral character varying(32),
    tmclt character varying(32),
    tmtrabalho character varying(32),
    tmlanche character varying(32),
    tmtreinamento character varying(32),
    tmindisp character varying(32),
    datainicial character varying(32),
    datafinal character varying(32),
    periodoinicial character varying(32),
    periodofinal character varying(32),
    data date
);
ALTER TABLE public.cc_relatendgrupo OWNER TO sa_asterisk;

CREATE TABLE cc_relresumidoagente (
    id serial NOT NULL,
    idrel character varying(32),
    nome character varying(32),
    entrante character varying(32),
    tempototal character varying(32),
    qtdadeentrantedireto character varying(32),
    entrantedireto character varying(32),
    sainte character varying(32),
    chamando character varying(32),
    chamadaespera character varying(32),
    disp character varying(32),
    indisp character varying(32),
    pausa character varying(32),
    totalpausa character varying(32),
    laboral character varying(32),
    clt character varying(32),
    trabalho character varying(32),
    lanche character varying(32),
    treinamento character varying(32),
    totalentsai character varying(32),
    tempomedio character varying(32),
    datainicial character varying(32),
    datafinal character varying(32),
    periodoinicial character varying(32),
    periodofinal character varying(32),
    data date,
    desl character varying(32)
);
ALTER TABLE public.cc_relresumidoagente OWNER TO sa_asterisk;

CREATE TABLE cc_relresumidoagentetemporal (
    id serial NOT NULL,
    idrel character varying(32),
    idordem character varying(32),
    nome character varying(32),
    entrante character varying(32),
    tempototal character varying(32),
    qtdadeentrantedireto character varying(32),
    entrantedireto character varying(32),
    sainte character varying(32),
    chamando character varying(32),
    chamadaespera character varying(32),
    disp character varying(32),
    indisp character varying(32),
    pausa character varying(32),
    totalpausa character varying(32),
    laboral character varying(32),
    clt character varying(32),
    trabalho character varying(32),
    lanche character varying(32),
    treinamento character varying(32),
    totalentsai character varying(32),
    tempomedio character varying(32),
    datainicial character varying(32),
    datafinal character varying(32),
    periodoinicial character varying(32),
    periodofinal character varying(32),
    periodo character varying(32),
    data date,
    horainiperiodo character(32),
    desl character varying(32)
);
ALTER TABLE public.cc_relresumidoagentetemporal OWNER TO sa_asterisk;

CREATE TABLE cc_reltemporal (
    id serial NOT NULL,
    idrel character varying(32),
    idordem integer,
    nome character varying(32),
    atend character varying(32),
    sainte character varying(32),
    tmatend character varying(32),
    tmaband character varying(32),
    aband character varying(32),
    datai character varying(32),
    dataf character varying(32),
    horai character varying(32),
    horaf character varying(32),
    horainiperiodo character varying(32),
    total character varying(32),
    periodo character varying(32),
    data date
);
ALTER TABLE public.cc_reltemporal OWNER TO sa_asterisk;

CREATE TABLE cc_tabulacao (
    id serial NOT NULL,
    data date,
    uniqueid character varying(32) DEFAULT '' NOT NULL,
    idtipo integer NOT NULL,
    idfila integer NOT NULL
);
ALTER TABLE public.cc_tabulacao OWNER TO sa_asterisk;

CREATE TABLE cc_tipotabulacao (
    id serial NOT NULL,
    idfila integer NOT NULL,
    descricao character varying(80) NOT NULL,
    flag integer -- bit0 => desativado
);
ALTER TABLE public.cc_tipotabulacao OWNER TO sa_asterisk;

CREATE TABLE cdr (
    id serial NOT NULL,
    calldate timestamp with time zone DEFAULT now() NOT NULL,
    clid character varying(80) DEFAULT '' NOT NULL,
    src character varying(80) DEFAULT '' NOT NULL,
    dst character varying(80) DEFAULT '' NOT NULL,
    dcontext character varying(80) DEFAULT '' NOT NULL,
    channel character varying(80) DEFAULT '' NOT NULL,
    dstchannel character varying(80) DEFAULT '' NOT NULL,
    lastapp character varying(80) DEFAULT '' NOT NULL,
    lastdata character varying(80) DEFAULT '' NOT NULL,
    duration bigint DEFAULT 0::bigint NOT NULL,
    billsec bigint DEFAULT 0::bigint NOT NULL,
    disposition character varying(45) DEFAULT '' NOT NULL,
    amaflags bigint DEFAULT 0::bigint NOT NULL,
    accountcode character varying(20) DEFAULT '' NOT NULL,
    uniqueid character varying(32) DEFAULT '' NOT NULL,
    userfield character varying(255) DEFAULT '' NOT NULL,
    estrela character varying(8),
    rota character varying(32),
    categoria character varying(32),
    valor numeric DEFAULT 0,
    tarifa character varying(8),
    volume character varying(8),
    numdisc character varying(80),
    direcao character(1),
    localidade character varying(64),
    callback character varying(32),
    fila character varying(8),
    gravacao character(1)
);
ALTER TABLE public.cdr OWNER TO sa_asterisk;

CREATE TABLE conferencia (
    id serial NOT NULL,
    dono integer NOT NULL,
    nome character varying(64) NOT NULL,
    contexto character varying(64) NOT NULL,
    sala integer NOT NULL,
    pin integer NOT NULL,
    dataini timestamp without time zone NOT NULL,
    datafim timestamp without time zone NOT NULL,
    numeros character varying(256) NOT NULL
);
ALTER TABLE public.conferencia OWNER TO sa_asterisk;

CREATE TABLE custo (
    id serial NOT NULL,
    nome character varying(128) NOT NULL,    
    sigla character varying(16) NOT NULL,
    pai character varying(16) NOT NULL,
    idchefe integer
);
ALTER TABLE public.custo OWNER TO sa_asterisk;

CREATE TABLE dvdsgravacoes (
    id serial NOT NULL,
    totgravacoes integer,
    dataini timestamp without time zone NOT NULL,
    datafim timestamp without time zone NOT NULL,
    espacolivre integer
);
ALTER TABLE public.dvdsgravacoes OWNER TO sa_asterisk;

CREATE TABLE fila (
    id serial NOT NULL,
    name character varying(128) NOT NULL,
    musiconhold character varying(128),
    announce character varying(128),
    context character varying(128),
    timeout integer,
    timeoutfila integer DEFAULT 0,
    autofill integer DEFAULT 1,
    autopause integer DEFAULT 2,
    "monitor-type" character varying(32),
    "monitor-format" character varying(128),
    "announce-frequency" integer,
    "announce-round-seconds" integer DEFAULT 0,
    "announce-holdtime" character varying(128),
    "periodic-announce" character varying(128),
    "periodic-announce-frequency" integer,
    ringinuse integer,
    setinterfacevar integer,
    retry integer,
    wrapuptime integer,
    maxlen integer,
    servicelevel integer,
    strategy character varying(128),
    joinempty character varying(128),
    leavewhenempty character varying(128),
    eventmemberstatus integer,
    eventwhencalled character varying(128),
    reportholdtime integer,
    memberdelay integer,
    weight integer,
    timeoutrestart integer,
    announcecli character varying(128),
    entrada character varying(16) NOT NULL,
    ramal character varying(32),
    maxagspausa integer DEFAULT 0,
    urlpopup character varying(256),
    urlpopupfim character varying(256),
    indispna integer,
    callback integer DEFAULT 0,
    callbackdisp integer DEFAULT 0,
    callbackmin integer DEFAULT 0,
    callbackmax integer DEFAULT 0,
    callbackstriplocal integer DEFAULT 1,
    callbackaddlocal character varying(2),
    callbackaddddd character varying(16),
    announcecb character varying(128),
    horarioini character varying(8),
    horariofim character varying(8),
    horarioinisab character varying(8),
    horariofimsab character varying(8),
    horarioinidom character varying(8),
    horariofimdom character varying(8),
    horarioinifer character varying(8),
    horariofimfer character varying(8),
    horarioanuncio character varying(128),
    horariopiloto character varying(16),
    timeoutanuncio character varying(128),
    timeoutpiloto character varying(16),
    filacheiaanuncio character varying(128),
    filacheiapiloto character varying(16),
    filavaziaanuncio character varying(128),
    filavaziapiloto character varying(16),
    flags integer
);
ALTER TABLE public.fila OWNER TO sa_asterisk;

CREATE TABLE filacusto (
    id serial NOT NULL,
    idfila integer,
    idcusto integer
);
ALTER TABLE public.filacusto OWNER TO sa_asterisk;

CREATE TABLE filtrochamada (
		id serial NOT NULL, 
		radiofiltro char(2), 
 		chamadaccusto character varying(32),
 		idccusto character varying(10),
 		ramaissel 	character varying(255),
 		chamadames character varying(32),
 		chamadadata1 character varying(10),
 		chamadadata2 character varying(10),
 		radiodirecao char(2), 		
 		chktipolocal char(2),
 		chktipoddd char(2),
		chktipocel char(2),
 		chktipocelddd char(2), 
 		chktipoddi char(2),
 		chktipo0x00 char(2),	
 		chamadatempomin character varying(10),
 		chamadatempomax character varying(10), 	
 		regporpagina char (2), 		
 		pagatual char (3),
 		ordem character varying(10)
 );
ALTER TABLE public.filtrochamada OWNER TO sa_asterisk; 

CREATE TABLE flagsparametro (
    id integer NOT NULL,
    nome character varying(32) NOT NULL
);
ALTER TABLE public.flagsparametro OWNER TO sa_asterisk;

CREATE TABLE grupo (
    id serial NOT NULL,
    nome character varying(32) NOT NULL
);
ALTER TABLE public.grupo OWNER TO sa_asterisk;

CREATE TABLE grupomoh (
    id serial NOT NULL,
    nome character varying(32) NOT NULL
);
ALTER TABLE public.grupomoh OWNER TO sa_asterisk;

CREATE TABLE iax (
    id serial NOT NULL,
    name character varying(30) NOT NULL,
    username character varying(30),
    "type" character varying(6) NOT NULL,
    secret character varying(50),
    host character varying(31) DEFAULT 'dynamic'::character varying NOT NULL,
    context character varying(100),
    callerid character varying(100),
    callgroup character varying(10) DEFAULT '1'::character varying,
    pickupgroup character varying(10),
    cancallforward character(3) DEFAULT 'yes'::bpchar,
    canreinvite character(3) DEFAULT 'yes'::bpchar,
    md5secret character varying(32),
    dbsecret character varying(100),
    notransfer character varying(10),
    inkeys character varying(100),
    outkey character varying(100),
    auth character varying(100),
    accountcode character varying(100),
    amaflags character varying(100),
    defaultip character varying(15),
    "language" character(5),
    mailbox character varying(50),
    deny character varying(95),
    permit character varying(95),
    qualify character varying(4),
    disallow character varying(100),
    allow character varying(100),
    ipaddr character varying(15),
    port integer DEFAULT 0,
    regseconds integer DEFAULT 0
);
ALTER TABLE public.iax OWNER TO sa_asterisk;

CREATE TABLE membrosfila (
    uniqueid serial NOT NULL,
    idagente integer,
    membername character varying(80),
    queue_name character varying(128) DEFAULT ''::character varying NOT NULL,
    interface character varying(128) DEFAULT ''::character varying NOT NULL,
    paused integer,
    penalty integer
);
ALTER TABLE public.membrosfila OWNER TO sa_asterisk;

CREATE TABLE mohgrupomoh (
    id serial NOT NULL,
    idGrupo integer NOT NULL,
    nomeMOH character varying(128)
);
ALTER TABLE public.mohgrupomoh OWNER TO sa_asterisk;

CREATE TABLE parametro (
    id serial NOT NULL,
    nome character varying(40),
    valor character varying(128),
    nomeparam character varying(32),
    flags integer DEFAULT 0 NOT NULL,
    info character varying(128)
);
ALTER TABLE public.parametro OWNER TO sa_asterisk;

CREATE TABLE pa (
    id serial NOT NULL,
    nome character varying(80),
    tipo character varying(3),
    senha character varying(32),
    descricao character varying(80),
    modelotel character varying(80),
    ip character varying(16),
    nat character(1)
);
ALTER TABLE public.pa OWNER TO sa_asterisk;

CREATE TABLE pasfila (
    id serial NOT NULL,
    chan character varying(80),
    idpa integer,
    idfila integer,
    nomepa character varying(80),
    nomefila character varying(128),
    descricao character varying(80)
);
ALTER TABLE public.pasfila OWNER TO sa_asterisk;

CREATE TABLE rota (
    id serial PRIMARY KEY NOT NULL,
    padrao integer,
    nome character varying(32) NOT NULL,
    descricao character varying(64),
    mascara character varying(64),
    strip integer,
    prefixo character varying(64),
    idtronco integer NOT NULL,
    tarifa integer,
    link integer,
    canalini integer,
    canalfim integer,
    idtroncobak integer NOT NULL,
    tarifabak integer,
    linkbak integer,
    canalinibak integer,
    canalfimbak integer,
    stripbak integer,
    prefixobak character varying(64),
    gravar integer DEFAULT 0 NOT NULL,
    cadeado integer DEFAULT 0 NOT NULL,
    cobrar integer,
    prioridadefilas integer DEFAULT 0 NOT NULL,
    categoria character varying(20) NOT NULL,
    ordem integer NOT NULL
);
ALTER TABLE public.rota OWNER TO sa_asterisk;

CREATE TABLE sip (
    id serial NOT NULL,
    name character varying(80) DEFAULT ''::character varying NOT NULL,
    secret character varying(80),
    port character varying(8) DEFAULT ''::character varying NOT NULL,
    "type" character varying(16) DEFAULT 'friend'::character varying NOT NULL,
    host character varying(31) DEFAULT 'dynamic'::character varying NOT NULL,
    dtmfmode character varying(7) DEFAULT 'rfc2833'::character varying,
    disallow character varying(100) DEFAULT 'all'::character varying,
    allow character varying(100) DEFAULT 'g729;ulaw'::character varying,
    nat character varying(5) DEFAULT 'no'::character varying NOT NULL,
    accountcode character varying(20),
    amaflags character varying(13),
    callgroup character varying(10) DEFAULT '1'::character varying,
    callerid character varying(80),
    cancallforward character(3) DEFAULT 'yes'::bpchar,
    canreinvite character(3) DEFAULT 'no'::bpchar,
    context character varying(80) DEFAULT 'default'::character varying,
    defaultip character varying(15),
    fromuser character varying(80),
    fromdomain character varying(80),
    insecure character varying(4),
    "language" character(2),
    mailbox character varying(50),
    md5secret character varying(80),
    deny character varying(95),
    permit character varying(95),
    mask character varying(95),
    musiconhold character varying(100),
    pickupgroup character varying(10),
    qualify character(3),
    regexten character varying(80),
    restrictcid character(3),
    rtptimeout character(3),
    rtpholdtimeout character(3),
    setvar character varying(100),
    fullcontact character varying(80) DEFAULT ''::character varying NOT NULL,
    ipaddr character varying(15) DEFAULT ''::character varying NOT NULL,
    regseconds integer DEFAULT 0 NOT NULL,
    regserver character varying(128),
    username character varying(80) DEFAULT ''::character varying NOT NULL,
    "call-limit" character varying(10) DEFAULT '5'::character varying,
    descricao character varying(100),
    lastms character varying(11),
    defaultuser character varying(10),
    useragent character varying(20)    
);
ALTER TABLE public.sip OWNER TO sa_asterisk;

CREATE TABLE telefone (
    id serial NOT NULL,
    "login" character varying(64) NOT NULL,
    senha character varying(64) NOT NULL,
    descricao character varying(64) NOT NULL,
    tipochan integer DEFAULT 1 NOT NULL,
    br integer,
    pa integer,
    cadeado integer DEFAULT 0 NOT NULL,
    cadeadopadrao integer DEFAULT 0 NOT NULL,
    mac character varying(18)
);
ALTER TABLE public.telefone OWNER TO sa_asterisk;

CREATE TABLE tipocanal (
    id integer NOT NULL,
    nome character varying(16) NOT NULL
);
ALTER TABLE public.tipocanal OWNER TO sa_asterisk;

CREATE TABLE tipocategoria (
    id integer NOT NULL,
    nome character varying(20) NOT NULL,
    descricao character varying(32) NOT NULL
);
ALTER TABLE public.tipocategoria OWNER TO sa_asterisk;

CREATE TABLE tipodestino (
    id serial NOT NULL,
    descricao character varying(32) NOT NULL
);
ALTER TABLE public.tipodestino OWNER TO sa_asterisk;

CREATE TABLE tipodirecao (
    id integer NOT NULL,
    descricao character varying(32) NOT NULL
);
ALTER TABLE public.tipodirecao OWNER TO sa_asterisk;

CREATE TABLE tipoentrada (
    id integer NOT NULL,
    nome character varying(16) NOT NULL,
    sintaxe character varying(128) NOT NULL
);
ALTER TABLE public.tipoentrada OWNER TO sa_asterisk;

CREATE TABLE tipostatusagente (
    id serial PRIMARY KEY NOT NULL,
    descricao character varying(32) NOT NULL
);
ALTER TABLE public.tipostatusagente OWNER TO sa_asterisk;

CREATE TABLE tipohorario (
    hora integer NOT NULL,
    diasemana integer NOT NULL,
    horariofixo integer NOT NULL,
    horariocelular integer NOT NULL
);
ALTER TABLE public.tipohorario OWNER TO sa_asterisk;

CREATE TABLE tipotronco (
    id integer NOT NULL,
    descricao character varying(32) NOT NULL
);
ALTER TABLE public.tipotronco OWNER TO sa_asterisk;

CREATE TABLE tipotroncodir (
    id integer NOT NULL,
    descricao character varying(32) NOT NULL
);
ALTER TABLE public.tipotroncodir OWNER TO sa_asterisk;

CREATE TABLE tronco (
    id serial PRIMARY KEY NOT NULL,
    nome character varying(32) UNIQUE NOT NULL,
    descricao character varying(64),
    direcao integer NOT NULL,
    tipo integer NOT NULL,
    modelo character varying(64),
    tiporotaentrada integer,
    contexto character varying(128),
    ramal character varying(64),
    detalhes text,
    idfilho integer
);
ALTER TABLE public.tronco OWNER TO sa_asterisk;

CREATE TABLE troncovoip (
    id serial PRIMARY KEY NOT NULL,
    servidor character varying(128),
    usuario character varying(64),
    senha character varying(64),
    porta integer,
    canaissimult integer
);
ALTER TABLE public.troncovoip OWNER TO sa_asterisk;

CREATE TABLE troncotdm400 (
    id serial PRIMARY KEY NOT NULL,
    tdm400_desc1 character varying(128),
    tdm400_desc2 character varying(128),
    tdm400_desc3 character varying(128),
    tdm400_desc4 character varying(128),
    tdm400_tre1 integer,
    tdm400_tre2 integer,
    tdm400_tre3 integer,
    tdm400_tre4 integer,
    tdm400_ctx1 character varying(128),
    tdm400_ctx2 character varying(128),
    tdm400_ctx3 character varying(128),
    tdm400_ctx4 character varying(128),
    tdm400_ramal1 character varying(16),
    tdm400_ramal2 character varying(16),
    tdm400_ramal3 character varying(16),
    tdm400_ramal4 character varying(16)
);
ALTER TABLE public.troncotdm400 OWNER TO sa_asterisk;

CREATE TABLE troncok1e1 (
    id serial PRIMARY KEY NOT NULL,
    k1e1_desc character varying(128),
    k1e1_tre character varying(128),
    k1e1_detalhes_tre text,
    k1e1_ctx character varying(128),
    k1e1_ramal character varying(128),
    k1e1_numplaca integer
);
ALTER TABLE public.troncok1e1 OWNER TO sa_asterisk;

CREATE TABLE troncok2e1 (
    id serial PRIMARY KEY NOT NULL,
    k2e1_desc1 character varying(128),
    k2e1_desc2 character varying(128),
    k2e1_tre1 character varying(128),
    k2e1_detalhes_tre1 text,
    k2e1_tre2 character varying(128),
    k2e1_detalhes_tre2 text,
    k2e1_ctx1 character varying(128),
    k2e1_ctx2 character varying(128),
    k2e1_ramal1 character varying(128),
    k2e1_ramal2 character varying(128),
    k2e1_numplaca integer
);
ALTER TABLE public.troncok2e1 OWNER TO sa_asterisk;

CREATE TABLE troncokgsm (
    id serial PRIMARY KEY NOT NULL,
    kgsm_ativo1 integer,
    kgsm_desc1 character varying(128),
    kgsm_ramal1 character varying(8),
    kgsm_sms1 character varying(8),
    kgsm_detalhes_tre1 text,
    kgsm_ativo2 integer,
    kgsm_desc2 character varying(128),
    kgsm_ramal2 character varying(8),
    kgsm_sms2 character varying(8),
    kgsm_detalhes_tre2 text,
    kgsm_ativo3 integer,
    kgsm_desc3 character varying(128),
    kgsm_ramal3 character varying(8),
    kgsm_sms3 character varying(8),
    kgsm_detalhes_tre3 text,
    kgsm_ativo4 integer,
    kgsm_desc4 character varying(128),
    kgsm_ramal4 character varying(8),
    kgsm_sms4 character varying(8),
    kgsm_detalhes_tre4 text,    
    kgsm_numplaca integer
);
ALTER TABLE public.troncokgsm OWNER TO sa_asterisk;

CREATE TABLE troncote110p (
    id serial PRIMARY KEY NOT NULL,
    te110p_numplaca integer,
    te110p_tre character varying(128),
    te110p_ctx character varying(128),
    te110p_ramal character varying(128)
);
ALTER TABLE public.troncote110p OWNER TO sa_asterisk;

CREATE TABLE usuario (
    id serial NOT NULL,
    idgrupo character varying(32),
    "login" character varying(32) NOT NULL,
    senha character varying(32) NOT NULL,
    ramal integer NOT NULL,
    contexto character varying(64),
    permissoes text NOT NULL,
    nome character varying(64),
    nomeguerra character varying(64),
    email character varying(128),
    celular integer,
    funcionalidades integer NOT NULL,
    datacadastro timestamp without time zone DEFAULT now(),
    modelotel character varying(32),
    senhatel character varying(20),
    iptel character varying(20),
    mactel character varying(20),
    canaltel integer,
    numero1 character varying(20),
    nome1 character varying(64),
    numero2 character varying(20),
    nome2 character varying(64),
    numero3 character varying(20),
    nome3 character varying(64),
    numero4 character varying(20),
    nome4 character varying(64),
    numero5 character varying(20),
    nome5 character varying(64),
    numero6 character varying(20),
    nome6 character varying(64),
    numero7 character varying(20),
    nome7 character varying(64),
    numero8 character varying(20),
    nome8 character varying(64),
    numero9 character varying(20),
    nome9 character varying(64),
    campoadd1 character varying(64),
    campoadd2 character varying(64),
    campoadd3 character varying(64),
    campoadd4 character varying(64),
    ramalocupado integer,
    ramalna integer,
    status integer,
    idsfilas character varying(128),
    telefone character varying(64),
    secretaria character varying(128),
    filasecretaria character varying(128),
    nomesfilas character varying(128)
);
ALTER TABLE public.usuario OWNER TO sa_asterisk;

CREATE TABLE usuarioadicional (
    id serial NOT NULL,
    ramal integer,
    nome character varying(64),
    nomeguerra character varying(64),
    email character varying(128),
    celular integer,
    pin integer
);
ALTER TABLE public.usuarioadicional OWNER TO sa_asterisk;

CREATE TABLE usuariocusto (
    id serial NOT NULL,
    idusuario integer,
    idcusto integer
);
ALTER TABLE public.usuariocusto OWNER TO sa_asterisk;

CREATE TABLE valortarifa (
    id serial  PRIMARY KEY NOT NULL,
    nome character varying(32),
    tipo character varying(32),
    tempo1 integer DEFAULT 30,
    tempo2 integer DEFAULT 6 NOT NULL,
    vm numeric,
    datafinal timestamp,
    taxah2 numeric,
    taxavc2 numeric,
    taxavc3 numeric,
    ignorataxas integer DEFAULT 0
);
ALTER TABLE public.valortarifa OWNER TO sa_asterisk;

CREATE TABLE voicemail (
    id serial NOT NULL,
    customer_id serial NOT NULL,
    context character varying(50) DEFAULT ''::character varying NOT NULL,
    mailbox integer DEFAULT 0 NOT NULL,
    "password" character varying(10) DEFAULT '0'::character varying NOT NULL,
    fullname character varying(50) DEFAULT ''::character varying NOT NULL,
    email character varying(50) DEFAULT ''::character varying NOT NULL,
    pager character varying(50) DEFAULT ''::character varying NOT NULL,
    uniqueid character varying(11)
);
ALTER TABLE public.voicemail OWNER TO sa_asterisk;


INSERT INTO cc_tipoevento VALUES (1, 'Login', 'Código do Usuário', 'Ramal', 'Telefone', '', '');
INSERT INTO cc_tipoevento VALUES (2, 'Logoff', 'Código do Usuário', 'Ramal', '', '', '');
INSERT INTO cc_tipoevento VALUES (3, 'Status', 'Código do Agente', 'Status Anterior', 'Status Novo', 'Código do usuário', '');
INSERT INTO cc_tipoevento VALUES (4, 'Entra na Chamada', 'Código do Ouvinte', 'Telefone Ouvinte', 'Código do Ouvido', 'Telefone do Ouvido', '');
INSERT INTO cc_tipoevento VALUES (5, 'Escuta Chamada', 'Código do Ouvinte', 'Telefone Ouvinte', 'Código do Ouvido', 'Telefone do Ouvido', '');
INSERT INTO cc_tipoevento VALUES (6, 'Conferencia', 'Código do Usuário', 'Telefone do usuario', 'Número do Destino', '', '');
INSERT INTO cc_tipoevento VALUES (7, 'Adicionar em Fila', 'Código do Supervisor', 'Código do Agente', 'Código da Fila', 'Nome da Fila', '');
INSERT INTO cc_tipoevento VALUES (8, 'Remover de Fila', 'Código do Supervisor', 'Código do Agente', 'Código da Fila', 'Nome da Fila', '');
INSERT INTO cc_tipoevento VALUES (9, 'Discagem', 'Código do Usuário', 'Telefone', 'Número Discado', 'UniqueID', '');
INSERT INTO cc_tipoevento VALUES (10, 'Transferencia', 'Código do Usuário', 'Telefone', 'Número Origem', 'Número Destino', '');
INSERT INTO cc_tipoevento VALUES (11, 'Em Espera', 'Código do Usuário', 'Telefone', 'Número Origem', '', '');
INSERT INTO cc_tipoevento VALUES (12, 'Captura Espera', 'Código do Usuário', 'Telefone', 'Número Origem', '', '');
INSERT INTO cc_tipoevento VALUES (13, 'Registro de PA', 'Código do Usuário', 'Telefone', 'MAC Address', '', '');
INSERT INTO cc_tipoevento VALUES (14, 'Login de Supervisor', 'Ramal', 'Telefone', '', '', '');
INSERT INTO cc_tipoevento VALUES (15, 'Contagem de Chamadas Diária', 'Código do Usuário', 'Recebidas', 'Efetuadas', 'TMA', '');
INSERT INTO cc_tipoevento VALUES (16, 'Hangup', 'Código do Usuário', 'Ramal', 'UniqueID do CDR', '', '');
INSERT INTO cc_tipoevento VALUES (17, 'Atendimento', 'Nome Fila', 'Tempo em Fila', 'Nome Agente', '', '');
INSERT INTO cc_tipoevento VALUES (18, 'Abandono', 'Nome Fila', 'Tempo em Fila', '', '', '');
INSERT INTO cc_tipoevento VALUES (19, 'Entrante nao ACD', 'Ramal', 'CallerID', 'UniqueID', '', '');
INSERT INTO cc_tipoevento VALUES (20, 'Mudanca de Estado', 'Codigo do Usuario', 'Estado Anterior', 'Estado Novo', 'Tempo no Estado Anterior');
INSERT INTO cc_tipoevento VALUES (21, 'Agente nao Atendeu', 'Ramal do Usuario', '', '', '', 'Nome da Fila');
INSERT INTO cc_tipoevento VALUES (22, 'Ligação foi para CallBack', 'CallerID', '', '', '', 'Nome da Fila');

INSERT INTO flagsparametro VALUES ( 1, 'Texto');
INSERT INTO flagsparametro VALUES ( 2, 'Checkbox');
INSERT INTO flagsparametro VALUES ( 4, 'Combo');
INSERT INTO flagsparametro VALUES ( 8, 'AstDB');
INSERT INTO flagsparametro VALUES (16, 'soAdmin');

INSERT INTO grupo VALUES (1, 'Todos');

INSERT INTO parametro(nome,valor,nomeparam,flags,info) VALUES ('Versão do PABX',           '3.4',                              'versaoPABX',       0, NULL);
INSERT INTO parametro(nome,valor,nomeparam,flags,info) VALUES ('Senha do Admin',           'e10adc3949ba59abbe56e057f20f883e', 'admPass',          0, NULL);
INSERT INTO parametro(nome,valor,nomeparam,flags,info) VALUES ('Rota de Entrada Padrão',   'p:0',                              'rota_entrada',     0, NULL);
INSERT INTO parametro(nome,valor,nomeparam,flags,info) VALUES ('Status do grgr',           'espera',                           'statusGravador',   0, NULL);
INSERT INTO parametro(nome,valor,nomeparam,flags,info) VALUES ('Erro do grgr',             '',                                 'erroGravador',     0, NULL);
INSERT INTO parametro(nome,valor,nomeparam,flags,info) VALUES ('Ultima execução do grgr',  '',                                 'dthrExecGravador', 0, NULL);
INSERT INTO parametro(nome,valor,nomeparam,flags,info) VALUES ('Total em Disco Gravações', '0',                                'totalGrs',         0, NULL);
INSERT INTO parametro(nome,valor,nomeparam,flags,info) VALUES ('Total em Disco GrFilas',   '0',                                'totalGrFilas',     0, NULL);
INSERT INTO parametro(nome,valor,nomeparam,flags,info) VALUES ('Dispositivo de Gravação',  'IMAGEM-DVD',                       'tipoDispGr',       0, NULL);


INSERT INTO parametro(nome,valor,nomeparam,flags,info) VALUES ('Email do Admin',                 'admin@pabx.ip', 'admEmail',        17, NULL);
INSERT INTO parametro(nome,valor,nomeparam,flags,info) VALUES ('Nome deste PABX',                'PABX IP',   'nomePABX',             1, NULL);
INSERT INTO parametro(nome,valor,nomeparam,flags,info) VALUES ('IP válido internet',             '',          'externip',             1, 'Digite se houver um IP internet válido no PABX');
INSERT INTO parametro(nome,valor,nomeparam,flags,info) VALUES ('Rede Local',                     '',          'localnet',             1, 'Ex.: 192.168.0.0/255.255.255.0');
INSERT INTO parametro(nome,valor,nomeparam,flags,info) VALUES ('DDD Local',                      '41',        'DDDLocal',             1, NULL);
INSERT INTO parametro(nome,valor,nomeparam,flags,info) VALUES ('Prefixo Local',                  '3350',      'prefixoLocal',         1, NULL);
INSERT INTO parametro(nome,valor,nomeparam,flags,info) VALUES ('Intervalo de Ramais',            '1200-1299', 'range',                1, NULL);
INSERT INTO parametro(nome,valor,nomeparam,flags,info) VALUES ('Operadora DDD Padrão',           '14',        'opDDD',                1, NULL);
INSERT INTO parametro(nome,valor,nomeparam,flags,info) VALUES ('Ramais para FAX',                '',          'ramaisFAX',            1, 'Ramais reservados para FAX, separe por vírgula');
INSERT INTO parametro(nome,valor,nomeparam,flags,info) VALUES ('Piloto da telefonista',          '1200',      'pilotoTelefonista',    1, NULL);
INSERT INTO parametro(nome,valor,nomeparam,flags,info) VALUES ('Piloto do Serviço Noturno',      '',          'svcnot_ramal',         1, 'Pode-se utilizar um ramal, um piloto de fila ou de URA');
INSERT INTO parametro(nome,valor,nomeparam,flags,info) VALUES ('Serviço Noturno Ativado',        '0',         'svcnot_ativo',        10, NULL);
INSERT INTO parametro(nome,valor,nomeparam,flags,info) VALUES ('Permitir ramais compartilhados', '0',         'ramaiscompartilhados', 2, NULL);
INSERT INTO parametro(nome,valor,nomeparam,flags,info) VALUES ('Identificador do PABX',          '1234',      'ID',                  17, NULL);
INSERT INTO parametro(nome,valor,nomeparam,flags,info) VALUES ('Nome de máquina ou IP Asterisk', 'localhost', 'hostAsterisk',        17, 'Digite [localhost] caso o Apache e o Asterisk estejam no mesmo servidor');
INSERT INTO parametro(nome,valor,nomeparam,flags,info) VALUES ('Tamanho do RamDrive de Gravações (MB)', '60', 'tamRamDrive',         17, 'Calcule: n. gravações simultâneas X 6%%ALERTA%%ALERTA: Gravações em andamento serão PERDIDAS ao alterar');
INSERT INTO parametro(nome,valor,nomeparam,flags,info) VALUES ('Nome de Domínio',   'pabx.ip', 'dominio', 1, 'Utilizado no Email de origem das mensagens do Correio de Voz');
INSERT INTO parametro(nome,valor,nomeparam,flags,info) VALUES ('Nome ou IP da interface web',   'www.pabx.ip', 'nomeWeb', 1, 'Utilizado nos links dos Emails das mensagens do Correio de Voz');
INSERT INTO parametro(nome,valor,nomeparam,flags,info) VALUES ('Campo Adicional 1', '', 'campAddUsu1', 1, 'Campo adicional de informações do usuário');
INSERT INTO parametro(nome,valor,nomeparam,flags,info) VALUES ('Campo Adicional 2', '', 'campAddUsu2', 1, 'Campo adicional de informações do usuário');
INSERT INTO parametro(nome,valor,nomeparam,flags,info) VALUES ('Campo Adicional 3', '', 'campAddUsu3', 1, 'Campo adicional de informações do usuário');
INSERT INTO parametro(nome,valor,nomeparam,flags,info) VALUES ('Campo Adicional 4', '', 'campAddUsu4', 1, 'Campo adicional de informações do usuário');
INSERT INTO parametro(nome,valor,nomeparam,flags,info) VALUES ('Servidor LDAP', '', 'hostLDAP', 17, 'Usado para a primeira autenticação. Vazio = Desligado');
INSERT INTO parametro(nome,valor,nomeparam,flags,info) VALUES ('BaseDN LDAP', '', 'basednLDAP', 17, 'Ex. dc=com,dc=br');
INSERT INTO parametro(nome,valor,nomeparam,flags,info) VALUES ('Usuário LDAP', '', 'userLDAP', 17, 'Usado para atualização de ramal. Vazio = Desligado');
INSERT INTO parametro(nome,valor,nomeparam,flags,info) VALUES ('Senha LDAP', '', 'passLDAP', 273, NULL);

INSERT INTO parametro(nome,valor,nomeparam,flags,info) VALUES ('Agentes simultêneos', '40', 'filaAgsSimult', 161, 'Número máximo de agentes simultâneos%%ALERTA%%O sistema será reiniciado e os agentes deslogados');
INSERT INTO parametro(nome,valor,nomeparam,flags,info) VALUES ('Tempo de máximo de KeepAlive', '15', 'filaTempoKA', 161, 'Tempo decorrido para deslogar agente sem resposta%%ALERTA%%O controleCC será reiniciado');

INSERT INTO parametro(nome,valor,nomeparam,flags,info) VALUES ('é MASTER', '0', 'ucarpMASTER', 512, NULL);
INSERT INTO parametro(nome,valor,nomeparam,flags,info) VALUES ('Hostname Master', '', 'ucarpHostMaster', 512, NULL);
INSERT INTO parametro(nome,valor,nomeparam,flags,info) VALUES ('Hostname Slave', '', 'ucarpHostSlave', 512, NULL);
INSERT INTO parametro(nome,valor,nomeparam,flags,info) VALUES ('IP Virtual', '', 'ucarpIPVirtual', 512, NULL);
INSERT INTO parametro(nome,valor,nomeparam,flags,info) VALUES ('IP Master', '', 'ucarpIPMaster', 512, NULL);
INSERT INTO parametro(nome,valor,nomeparam,flags,info) VALUES ('IP Slave', '', 'ucarpIPSlave', 512, NULL);
INSERT INTO parametro(nome,valor,nomeparam,flags,info) VALUES ('ID do cluster', '', 'ucarpID', 512, NULL);
INSERT INTO parametro(nome,valor,nomeparam,flags,info) VALUES ('Senha do cluster', '', 'ucarpPass', 512, NULL);
INSERT INTO parametro(nome,valor,nomeparam,flags,info) VALUES ('Gateway', '', 'ucarpGW', 512, NULL);
INSERT INTO parametro(nome,valor,nomeparam,flags,info) VALUES ('Interface de rede', '', 'ucarpIface', 512, NULL);
INSERT INTO parametro(nome,valor,nomeparam,flags,info) VALUES ('Intervalo de PING', '', 'ucarpIntervalo', 512, NULL);
INSERT INTO parametro(nome,valor,nomeparam,flags,info) VALUES ('Máx. PINGs perdidos', '', 'ucarpMaxPerdas', 512, NULL);

INSERT INTO rota(padrao,nome,descricao,mascara,strip,prefixo,idtronco,tarifa,idtroncobak,tarifabak,gravar,cadeado,prioridadefilas,categoria,ordem) VALUES ('2', 'liberado-1XX', 'Ligações 1XX', '01XX', '1', '', '1', '3', '2', '3', '0', '1', '0', 'restrito', '1');
INSERT INTO rota(padrao,nome,descricao,mascara,strip,prefixo,idtronco,tarifa,idtroncobak,tarifabak,gravar,cadeado,prioridadefilas,categoria,ordem) VALUES ('3', 'liberado-1XXXX', 'Ligações 1XXXX', '01XXXX', '1', '', '1', '3', '2', '3', '0', '1', '0', 'restrito', '2');
INSERT INTO rota(padrao,nome,descricao,mascara,strip,prefixo,idtronco,tarifa,idtroncobak,tarifabak,gravar,cadeado,prioridadefilas,categoria,ordem) VALUES ('1', 'restrito-0800', 'Ligações 0800', '00800XXXXXXX', '1', '', '1', '0', '2', '0', '0', '0', '0', 'restrito', '3');
INSERT INTO rota(padrao,nome,descricao,mascara,strip,prefixo,idtronco,tarifa,idtroncobak,tarifabak,gravar,cadeado,prioridadefilas,categoria,ordem) VALUES ('10', 'liberado-fixo', 'Ligações Locais Fixas', '0[2-5]XXXXXXX', '1', '', '1', '1', '2', '1', '0', '0', '0', 'liberado-fixo', '1');
INSERT INTO rota(padrao,nome,descricao,mascara,strip,prefixo,idtronco,tarifa,idtroncobak,tarifabak,gravar,cadeado,prioridadefilas,categoria,ordem) VALUES ('10', 'liberado-celular', 'Ligações Locais Celular', '0[6-9]XXXXXXX', '1', '', '1', '2', '2', '2', '0', '1', '0', 'liberado-celular', '1');
INSERT INTO rota(padrao,nome,descricao,mascara,strip,prefixo,idtronco,tarifa,idtroncobak,tarifabak,gravar,cadeado,prioridadefilas,categoria,ordem) VALUES ('10', 'liberado-ddd', 'Ligações DDD Fixas', '00XXXX[2-5]XXXXXXX', '1', '', '1', '1', '2', '1', '0', '1', '0', 'liberado-ddd', '1');
INSERT INTO rota(padrao,nome,descricao,mascara,strip,prefixo,idtronco,tarifa,idtroncobak,tarifabak,gravar,cadeado,prioridadefilas,categoria,ordem) VALUES ('10', 'liberado-celular-ddd', 'Ligações DDD Celular', '00XXXX[6-9]XXXXXXX', '1', '', '1', '2', '2', '2', '0', '1', '0', 'liberado-celular-ddd', '1');
INSERT INTO rota(padrao,nome,descricao,mascara,strip,prefixo,idtronco,tarifa,idtroncobak,tarifabak,gravar,cadeado,prioridadefilas,categoria,ordem) VALUES ('10', 'irrestrito', 'Ligações DDI', '000XXXXXXX.', '1', '', '1', '4', '2', '4', '0', '1', '0', 'irrestrito', '1');
INSERT INTO rota(padrao,nome,descricao,mascara,strip,prefixo,idtronco,tarifa,idtroncobak,tarifabak,gravar,cadeado,prioridadefilas,categoria,ordem) VALUES ('4', 'liberado-034900', 'Ligações 0300, 0400 e 0900', '00[349]00XXXXXXX', '1', '', '1', '3', '2', '3', '0', '1', '0', 'inativa', '2');

INSERT INTO tipocanal VALUES (1, 'SIP');
INSERT INTO tipocanal VALUES (2, 'IAX');

INSERT INTO tipocategoria VALUES (1, 'restrito', 'Restrito');
INSERT INTO tipocategoria VALUES (2, 'liberado-fixo', 'Fixo Local');
INSERT INTO tipocategoria VALUES (3, 'liberado-celular', 'Celular Local');
INSERT INTO tipocategoria VALUES (4, 'liberado-ddd', 'Fixo DDD');
INSERT INTO tipocategoria VALUES (5, 'liberado-celular-ddd', 'Celular DDD');
INSERT INTO tipocategoria VALUES (6, 'irrestrito', 'Irrestrito');

INSERT INTO tipodestino VALUES (1, 'Outros');
INSERT INTO tipodestino VALUES (2, 'Fornecedor');
INSERT INTO tipodestino VALUES (3, 'Governo');
INSERT INTO tipodestino VALUES (4, 'Domicilio');
INSERT INTO tipodestino VALUES (5, 'Funcionario');

INSERT INTO tipodirecao VALUES (1, 'Entrante');
INSERT INTO tipodirecao VALUES (2, 'Sainte');
INSERT INTO tipodirecao VALUES (3, 'Interna');
INSERT INTO tipodirecao VALUES (4, 'Passante Entrante');
INSERT INTO tipodirecao VALUES (5, 'Passante Sainte');

INSERT INTO tipoentrada VALUES (1, 'E1', 'ZAP');
INSERT INTO tipoentrada VALUES (2, 'FXO', 'FXO');

INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(0, 0, 4, 2); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(0, 1, 4, 2); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(0, 2, 4, 2); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(0, 3, 4, 2); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(0, 4, 4, 2); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(0, 5, 4, 2); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(0, 6, 4, 2); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(1, 0, 4, 2); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(1, 1, 4, 2); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(1, 2, 4, 2); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(1, 3, 4, 2); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(1, 4, 4, 2); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(1, 5, 4, 2); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(1, 6, 4, 2); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(2, 0, 4, 2); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(2, 1, 4, 2); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(2, 2, 4, 2); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(2, 3, 4, 2); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(2, 4, 4, 2); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(2, 5, 4, 2); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(2, 6, 4, 2); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(3, 0, 4, 2); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(3, 1, 4, 2); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(3, 2, 4, 2); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(3, 3, 4, 2); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(3, 4, 4, 2); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(3, 5, 4, 2); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(3, 6, 4, 2); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(4, 0, 4, 2); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(4, 1, 4, 2); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(4, 2, 4, 2); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(4, 3, 4, 2); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(4, 4, 4, 2); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(4, 5, 4, 2); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(4, 6, 4, 2); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(5, 0, 4, 2); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(5, 1, 4, 2); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(5, 2, 4, 2); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(5, 3, 4, 2); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(5, 4, 4, 2); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(5, 5, 4, 2); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(5, 6, 4, 2); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(6, 0, 3, 2); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(6, 1, 3, 2); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(6, 2, 3, 2); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(6, 3, 3, 2); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(6, 4, 3, 2); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(6, 5, 3, 2); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(6, 6, 3, 2); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(7, 0, 3, 1); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(7, 1, 1, 1); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(7, 2, 1, 1); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(7, 3, 1, 1); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(7, 4, 1, 1); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(7, 5, 1, 1); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(7, 6, 1, 2); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(8, 0, 3, 1); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(8, 1, 1, 1); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(8, 2, 1, 1); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(8, 3, 1, 1); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(8, 4, 1, 1); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(8, 5, 1, 1); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(8, 6, 1, 2); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(9, 0, 3, 1); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(9, 1, 2, 1); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(9, 2, 2, 1); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(9, 3, 2, 1); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(9, 4, 2, 1); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(9, 5, 2, 1); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(9, 6, 1, 2); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(10, 0, 3, 1); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(10, 1, 2, 1); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(10, 2, 2, 1); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(10, 3, 2, 1); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(10, 4, 2, 1); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(10, 5, 2, 1); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(10, 6, 1, 2); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(11, 0, 3, 1); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(11, 1, 2, 1); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(11, 2, 2, 1); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(11, 3, 2, 1); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(11, 4, 2, 1); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(11, 5, 2, 1); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(11, 6, 1, 2); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(12, 0, 3, 1); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(12, 1, 1, 1); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(12, 2, 1, 1); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(12, 3, 1, 1); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(12, 4, 1, 1); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(12, 5, 1, 1); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(12, 6, 1, 2); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(13, 0, 3, 1); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(13, 1, 1, 1); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(13, 2, 1, 1); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(13, 3, 1, 1); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(13, 4, 1, 1); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(13, 5, 1, 1); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(13, 6, 1, 2); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(14, 0, 3, 1); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(14, 1, 2, 1); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(14, 2, 2, 1); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(14, 3, 2, 1); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(14, 4, 2, 1); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(14, 5, 2, 1); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(14, 6, 3, 2); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(15, 0, 3, 1); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(15, 1, 2, 1); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(15, 2, 2, 1); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(15, 3, 2, 1); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(15, 4, 2, 1); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(15, 5, 2, 1); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(15, 6, 3, 2); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(16, 0, 3, 1); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(16, 1, 2, 1); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(16, 2, 2, 1); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(16, 3, 2, 1); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(16, 4, 2, 1); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(16, 5, 2, 1); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(16, 6, 3, 2); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(17, 0, 3, 1); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(17, 1, 2, 1); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(17, 2, 2, 1); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(17, 3, 2, 1); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(17, 4, 2, 1); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(17, 5, 2, 1); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(17, 6, 3, 2); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(18, 0, 3, 1); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(18, 1, 1, 1); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(18, 2, 1, 1); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(18, 3, 1, 1); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(18, 4, 1, 1); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(18, 5, 1, 1); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(18, 6, 3, 2); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(19, 0, 3, 1); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(19, 1, 1, 1); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(19, 2, 1, 1); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(19, 3, 1, 1); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(19, 4, 1, 1); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(19, 5, 1, 1); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(19, 6, 3, 2); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(20, 0, 3, 1); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(20, 1, 1, 1); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(20, 2, 1, 1); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(20, 3, 1, 1); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(20, 4, 1, 1); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(20, 5, 1, 1); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(20, 6, 3, 2); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(21, 0, 3, 2); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(21, 1, 3, 2); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(21, 2, 3, 2); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(21, 3, 3, 2); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(21, 4, 3, 2); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(21, 5, 3, 2); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(21, 6, 3, 2); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(22, 0, 3, 2); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(22, 1, 3, 2); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(22, 2, 3, 2); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(22, 3, 3, 2); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(22, 4, 3, 2); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(22, 5, 3, 2); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(22, 6, 3, 2); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(23, 0, 3, 2); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(23, 1, 3, 2); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(23, 2, 3, 2); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(23, 3, 3, 2); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(23, 4, 3, 2); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(23, 5, 3, 2); 
INSERT INTO tipohorario(hora, diasemana, horariofixo, horariocelular) VALUES(23, 6, 3, 2); 

INSERT INTO tipostatusagente VALUES (0, 'Deslogado');
INSERT INTO tipostatusagente VALUES (1, 'Disponível');
INSERT INTO tipostatusagente VALUES (100, 'Em Pausa');
INSERT INTO tipostatusagente VALUES (200, 'Indisponível');
INSERT INTO tipostatusagente VALUES (101, 'CLT');
INSERT INTO tipostatusagente VALUES (102, 'Trabalho');
INSERT INTO tipostatusagente VALUES (103, 'Laboral');
INSERT INTO tipostatusagente VALUES (104, 'Lanche');
INSERT INTO tipostatusagente VALUES (105, 'Treinamento');
INSERT INTO tipostatusagente VALUES (201, 'Indisponivel Agente');

INSERT INTO tipotronco VALUES (1, 'Placa');
INSERT INTO tipotronco VALUES (2, 'SIP');
INSERT INTO tipotronco VALUES (3, 'IAX');

INSERT INTO tronco VALUES (1, 'Provedor VoIP', 'Provedor VoIP Exemplo', 3, 2, 'generica', 1, 'ramais-internos', '0', '; Config adicional do sip.conf', 1);
INSERT INTO troncovoip VALUES (1, 'voip.exemplo.com.br', 'user', 'pass', 5060);
INSERT INTO tronco VALUES (2, 'Provedor VoIP 2', 'Provedor VoIP Exemplo 2', 3, 2, 'generica', 2, 'ramais-internos', '0', '; Config adicional do sip.conf 2', 2);
INSERT INTO troncovoip VALUES (2, 'voip.exemplo2.com.br', 'user', 'pass', 5060);

INSERT INTO valortarifa(id, nome, tipo, tempo1, tempo2, vm, datafinal) VALUES(1, 'fixo', 1, 30, 6, 0.13819, '01-01-2038 00:00:00');
INSERT INTO valortarifa(id, nome, tipo, tempo1, tempo2, vm, datafinal, taxah2, taxavc2, taxavc3) VALUES(2, 'movel', 2, 30, 6, 0.8810, '01-01-2038 00:00:00', 0.70, 1.59, 1.11);
INSERT INTO valortarifa(id, nome, tipo, tempo1, tempo2, vm, datafinal) VALUES(3, 'especial', 3, 30, 6, 0, '01-01-2038 00:00:00');

SELECT setval('alerta_id_seq', max(id)) FROM alerta;
SELECT setval('backup_id_seq', max(id)) FROM backup;
SELECT setval('cadastrodestinos_id_seq', max(id)) FROM cadastrodestinos;
SELECT setval('cdr_id_seq', max(id)) FROM cdr;
SELECT setval('conferencia_id_seq', max(id)) FROM conferencia;
SELECT setval('custo_id_seq', max(id)) FROM custo;
SELECT setval('fila_id_seq', max(id)) FROM fila;
SELECT setval('grupo_id_seq', max(id)) FROM grupo;
SELECT setval('grupomoh_id_seq', max(id)) FROM grupomoh;
SELECT setval('iax_id_seq', max(id)) FROM iax;
SELECT setval('membrosfila_uniqueid_seq', max(uniqueid)) FROM membrosfila;
SELECT setval('mohgrupomoh_id_seq', max(id)) FROM mohgrupomoh;
SELECT setval('parametro_id_seq', max(id)) FROM parametro;
SELECT setval('rota_id_seq', max(id)) FROM rota;
SELECT setval('sip_id_seq', max(id)) FROM sip;
SELECT setval('telefone_id_seq', max(id)) FROM telefone;
SELECT setval('tipostatusagente_id_seq', max(id)) FROM tipostatusagente;
SELECT setval('tronco_id_seq', max(id)) FROM tronco;
SELECT setval('troncotdm400_id_seq', max(id)) FROM troncotdm400;
SELECT setval('troncok2e1_id_seq', max(id)) FROM troncok2e1;
SELECT setval('troncovoip_id_seq', max(id)) FROM troncovoip;
SELECT setval('usuario_id_seq', max(id)) FROM usuario;
SELECT setval('usuariocusto_id_seq', max(id)) FROM usuariocusto;
SELECT setval('valortarifa_id_seq', max(id)) FROM valortarifa;
SELECT setval('voicemail_id_seq', max(id)) FROM voicemail;



ALTER TABLE ONLY alerta ADD CONSTRAINT alerta_pkey PRIMARY KEY (id);

ALTER TABLE ONLY cadastrodestinos ADD CONSTRAINT cadastrodestinos_pkey PRIMARY KEY (id);

ALTER TABLE ONLY cdr ADD CONSTRAINT cdr_pkey PRIMARY KEY (id);

ALTER TABLE ONLY conferencia ADD CONSTRAINT conferencia_pkey PRIMARY KEY (id);

ALTER TABLE ONLY custo ADD CONSTRAINT custo_pkey PRIMARY KEY (id);

ALTER TABLE ONLY dvdsgravacoes ADD CONSTRAINT dvdsgravacoes_pkey PRIMARY KEY (id);

ALTER TABLE ONLY fila ADD CONSTRAINT fila_pkey PRIMARY KEY (id);

ALTER TABLE ONLY grupo ADD CONSTRAINT grupo_nome_key UNIQUE (nome);
ALTER TABLE ONLY grupo ADD CONSTRAINT grupo_pkey PRIMARY KEY (id);

ALTER TABLE ONLY grupomoh ADD CONSTRAINT grupomoh_pkey PRIMARY KEY (id);

ALTER TABLE ONLY iax ADD CONSTRAINT iax_pkey PRIMARY KEY (id);
ALTER TABLE ONLY iax ADD CONSTRAINT iax_username_key UNIQUE (username);

ALTER TABLE ONLY membrosfila ADD CONSTRAINT mfpk PRIMARY KEY (uniqueid, queue_name, interface);

ALTER TABLE ONLY parametro ADD CONSTRAINT parametro_pkey PRIMARY KEY (id);

ALTER TABLE ONLY sip ADD CONSTRAINT sip_name_key UNIQUE (name);
ALTER TABLE ONLY sip ADD CONSTRAINT sip_pkey PRIMARY KEY (id);

ALTER TABLE ONLY telefone ADD CONSTRAINT telefone_login_key UNIQUE ("login");
ALTER TABLE ONLY telefone ADD CONSTRAINT telefone_pkey PRIMARY KEY (id);

ALTER TABLE ONLY tipocanal ADD CONSTRAINT tipocanal_pkey PRIMARY KEY (id);

ALTER TABLE ONLY tipodestino ADD CONSTRAINT tipodestino_pkey PRIMARY KEY (id);

ALTER TABLE ONLY tipoentrada ADD CONSTRAINT tipoentrada_pkey PRIMARY KEY (id);

ALTER TABLE ONLY flagsparametro ADD CONSTRAINT flagsparametro_pkey PRIMARY KEY (id);

ALTER TABLE ONLY usuario ADD CONSTRAINT usuario_pkey PRIMARY KEY (id);

ALTER TABLE ONLY usuarioadicional ADD CONSTRAINT usuarioadicional_pkey PRIMARY KEY (id);

ALTER TABLE ONLY usuariocusto ADD CONSTRAINT usuariocusto_pkey PRIMARY KEY (id);

ALTER TABLE ONLY voicemail ADD CONSTRAINT voicemail_pkey PRIMARY KEY (id);


-- Triggers e Functions
CREATE LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION convertSegundosToHora(nseg numeric) RETURNS character(8) AS
$BODY$
DECLARE
	aux      numeric;
	horas    numeric;
	minutos  numeric;
	segundos numeric;

	divisao1 real;
	divisao2 real;
	divisao3 real;

	hora_geral  character varying(8);
	strhoras    character varying(5);
	strminutos  character varying(5);
	strsegundos character varying(5);

BEGIN
	
	aux = mod(nseg, 3600);
	segundos = mod(aux,60);
	divisao1 = aux/60;
	minutos = trunc(divisao1);
	divisao2 = nseg/60;
	divisao3 = divisao2/60;
	horas = trunc(divisao3);
	
	IF horas < 10 THEN
	  strhoras = '0' || horas;
	ELSE
	   strhoras = horas;
	END IF;
	
	IF minutos < 10 THEN
	   strminutos = '0' || minutos;
	ELSE
	   strminutos = minutos;
	END IF;
	
	IF segundos < 10 THEN
	   strsegundos = '0' || segundos;
	ELSE
	   strsegundos = segundos;
	END IF;
	
	hora_geral =  strhoras || ':' || strminutos || ':' || strsegundos;
	
	RETURN hora_geral;  
END; 
$BODY$
LANGUAGE 'plpgsql' VOLATILE;


CREATE FUNCTION tarifacdr() RETURNS "trigger" AS
$BODY$
DECLARE
	-- Para o funcionamento da trigger as rotas que serao tarifadas devem:
	-- Comecar com 1 zero  e ter o numero nos ultimos 8 digitos para chamadas locais
	-- Comecar com 2 zeros e ter o DDD+numero nos ultimos 10 digitos para chamadas DDD
	tarifa     RECORD;
	tarifaOK   INTEGER;
	valSec     FLOAT;
	result     FLOAT;
	
	lenNumDisc INTEGER;
	horarios   RECORD;
	
	dddLocal   VARCHAR;
	dddDest    VARCHAR;
	prefLocal  VARCHAR;
	deg        INTEGER;
	vc         INTEGER;
	dest       VARCHAR;
	numero     VARCHAR;
BEGIN
--RAISE WARNING 'NUM: %', NEW.dst;
	-- Ajustar o numero discado para o formato XXXXXXXX (local) ou DDXXXXXXXX (DDD)
	lenNumDisc := char_length(NEW.dst);
	IF substr(NEW.dst, 1, 3) = '000' THEN
		-- Nao tarifa DDI
		NEW.localidade := 'DDI';
		NEW.tarifa     := '0';
		NEW.valor      := '0';
		return NEW;
	ELSEIF substr(NEW.dst, 1, 2) = '00' THEN
		numero := substr(NEW.dst, (lenNumDisc - 9), 10);
	ELSEIF substr(NEW.dst, 1, 1) = '0' THEN
		numero := substr(NEW.dst, (lenNumDisc - 7), 8);
	ELSEIF lenNumDisc = 10 AND substr(NEW.dst, 1, 1) != '0' THEN
		-- Caso especial, para mascara de discagem DDXXXXXXXX (para o redial do siemens)
		numero := NEW.dst;
	END IF;

	-- Pré calcular o tamanho do numero discado
	lenNumDisc := char_length(numero);

	-- Chamadas internas nao sao tarifadas
	IF lenNumDisc IS NULL OR lenNumDisc < 8 OR NEW.direcao = '3' THEN
		NEW.localidade := '-CH. INTERNA-';
		NEW.tarifa     := '0';
		NEW.valor      := '0';
		return NEW;
	END IF;
	
	-- buscar o DDD local
	SELECT valor INTO dddLocal  FROM parametro where nomeparam = 'DDDLocal';
	IF lenNumDisc = 8 THEN
		-- Chamada Local, concaternar o DDD local
		numero := dddLocal || numero;
	END IF;
	-- Setar DDD+Prefixo de destino
	dest := substr(numero, 1, 6);
	-- Setar numdisc
	NEW.numdisc = numero;
	
	-- Buscar a tarifa
	tarifaOK := 0;
	IF NEW.tarifa != '' AND NEW.tarifa != '0' THEN
		SELECT * INTO tarifa FROM valortarifa WHERE id = NEW.tarifa and datafinal > NEW.calldate order by datafinal ASC LIMIT 1;
		IF tarifa.tipo > 0 THEN
			tarifaOK := tarifa.id;
		END IF;
	END IF;

	-- Buscar a Localidade
	IF tarifaOK > 0 THEN
		IF tarifa.tipo = '3' THEN
			-- Tarifa ESPECIAL nao tem localidade
			NEW.localidade := 'NAO IDENT';
		END IF;
	END IF;

	IF NEW.localidade IS NULL THEN
		IF cast(substr(dest, 3, 1) as integer) > 5 THEN
			-- 3o digito > 5 = Celular
			NEW.localidade := 'CELULAR';
		ELSE
			-- Busca a localidade
			SELECT m.nome INTO NEW.localidade FROM prefixo p, municipio m, localidade_prefixo lp, localidade l WHERE p.prefixo = dest AND p.prefixo = cast(lp.prefixo as varchar) AND lp.codigo_cnl = l.codigo_cnl AND l.id_municipio = m.id;
		END IF;	
	END IF;
	
	-- Sem tarifa
	IF tarifaOK = 0 OR NEW.billsec = 0 THEN
		result     := '0';
	ELSE
		-- Calculo valor sem taxas 
		valSec := tarifa.vm / 60;
		IF NEW.billsec < tarifa.tempo1 THEN
			-- Valor minimo
			result := valSec * tarifa.tempo1;
		ELSE
			result := valSec * (NEW.billsec + (tarifa.tempo2 - (NEW.billsec % tarifa.tempo2)));
		END IF;
--RAISE WARNING 'tempo: %s - valSec: % - ValM: % - T1: % - T2: % - result: % - MOD: %', NEW.billsec, valSec, tarifa.vm, tarifa.tempo1, tarifa.tempo2, result, NEW.billsec % tarifa.tempo2;

		--Verificar o tipo da tarifa para aplicar as taxas
		IF tarifa.ignorataxas = '0' THEN -- Varificar se devemos ignorar as taxas
			-- Achar os tipos de horário para fixo e móvel
			SELECT horariofixo,horariocelular INTO horarios FROM tipohorario WHERE diasemana = EXTRACT(DOW FROM NEW.calldate) AND hora = date_part('hour', NEW.calldate);
				
			IF tarifa.tipo = '2' THEN
				-- CELULAR
				dddDest := substr(dest, 1, 2);
				IF dddLocal != dddDest THEN
					IF substr(dddLocal, 1, 1) = substr(dddDest, 1, 1) THEN
						--Taxa VC2
						vc := 2;
						result := (result * tarifa.taxavc2);
					ELSE
						--Taxa VC3
						vc := 3;
						result := (result * tarifa.taxavc3);
					END IF;
				ELSE
					vc := 1;
				END IF;
			
				--Taxa HORARIO
				IF horarios.horariocelular = 2 THEN
					NEW.valor := (result * tarifa.taxah2);
				END IF;
			
				--RAISE WARNING 'Chamada Celular, destino: %, vc: %, horario: %', dest, vc, horarios.horariocelular;
			ELSE
				-- FIXO -- Buscar o prefixo local	
				SELECT valor INTO prefLocal FROM parametro where nomeparam = 'prefixoLocal';
				-- Achar o DEGRAU
				SELECT degrau INTO deg FROM matriztarifacao WHERE cnlorigem = (SELECT codigo_area FROM prefixo WHERE prefixo = dddLocal || prefLocal) AND cnldestino = (SELECT codigo_area FROM prefixo WHERE prefixo = dest);
				--Taxa DEGRAU 
				IF     deg = 1 THEN result := (result * 1.3);  -- +30%
				ELSEIF deg = 2 THEN result := (result * 1.5);  -- +50%
				ELSEIF deg = 3 THEN result := (result * 1.75); -- +75%
				ELSEIF deg = 4 THEN result := (result * 2);    -- +100%
				END IF;
		
				--Taxa HORARIO
				IF     horarios.horariofixo = 2 THEN result := (result * 2);    -- +100%
				ELSEIF horarios.horariofixo = 3 THEN result := (result * 0.5);  -- -50%
				ELSEIF horarios.horariofixo = 4 THEN result := (result * 0.25); -- -75%
				END IF;
				
				--RAISE WARNING 'Chamada DDD, destino: %, degrau: %, horario: %', dest, deg, horarios.horariofixo;
			END IF;
		END IF;
	END IF;
		
	NEW.valor := result;
	--RAISE WARNING 'Discado: % - Dest: % - Localidade: %, IDtarifa: % - BillSec: % - Valor: %', NEW.dst, dest, NEW.localidade, tarifaOK, NEW.billsec, NEW.valor;
	return NEW;
	
	EXCEPTION
        WHEN others THEN
            RAISE WARNING 'Trigger de tarifacao -> Erro! NUM:%, DETAILS:%', SQLSTATE, SQLERRM;
            return NEW;
END
$BODY$
LANGUAGE 'plpgsql';
ALTER FUNCTION tarifacdr() OWNER TO sa_asterisk;

CREATE TRIGGER tarifacdr_trigger BEFORE INSERT ON cdr FOR EACH ROW EXECUTE PROCEDURE tarifacdr();

CREATE VIEW vw_usuario AS SELECT * FROM usuario;

CREATE USER sa_panoramisk LOGIN NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE PASSWORD 'panoramisk';

REVOKE ALL ON SCHEMA public FROM sa_panoramisk;
REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;
GRANT SELECT ON vw_usuario TO sa_panoramisk;
GRANT SELECT ON parametro TO sa_panoramisk;
