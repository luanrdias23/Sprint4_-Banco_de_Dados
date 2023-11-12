DROP TABLE tb__motorista CASCADE CONSTRAINTS;

DROP TABLE tb_bairro CASCADE CONSTRAINTS;

DROP TABLE tb_cidade CASCADE CONSTRAINTS;

DROP TABLE tb_cliente_veiculo CASCADE CONSTRAINTS;

DROP TABLE tb_endereco_problema CASCADE CONSTRAINTS;

DROP TABLE tb_endereco_usuario CASCADE CONSTRAINTS;

DROP TABLE tb_estado CASCADE CONSTRAINTS;

DROP TABLE tb_guincho CASCADE CONSTRAINTS;

DROP TABLE tb_guincho_solicitado CASCADE CONSTRAINTS;

DROP TABLE tb_logradouro CASCADE CONSTRAINTS;

DROP TABLE tb_problema CASCADE CONSTRAINTS;

DROP TABLE tb_solicitacao_atendimento CASCADE CONSTRAINTS;

DROP TABLE tb_telefone_usuario CASCADE CONSTRAINTS;

DROP TABLE tb_usuario CASCADE CONSTRAINTS;

DROP TABLE tb_veiculo CASCADE CONSTRAINTS;

DROP SEQUENCE SEQ_TELEFONE;

-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE
CREATE SEQUENCE SEQ_TELEFONE
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;


CREATE TABLE tb__motorista (
    id_motorista     NUMBER(8) NOT NULL,
    id_guincho       NUMBER(6) NOT NULL,
    nm_motorista     VARCHAR2(100) NOT NULL,
    cd_motorista     VARCHAR2(10) NOT NULL,
    nr_cnh           NUMBER(14) NOT NULL,
    nm_categoria_cnh VARCHAR2(20) NOT NULL,
    dt_validade_cnh  DATE NOT NULL
);

ALTER TABLE tb__motorista ADD CONSTRAINT tb__motorista_pk PRIMARY KEY (id_motorista);


CREATE TABLE tb_bairro (
    id_bairro      NUMBER(8) NOT NULL,
    id_cidade      NUMBER(8) NOT NULL,
    nm_bairro      VARCHAR2(45) NOT NULL,
    nm_zona_bairro VARCHAR2(20) NOT NULL,
    dt_cadastro    DATE NOT NULL
);

ALTER TABLE tb_bairro
    ADD CONSTRAINT uk_t_pkd_bairro_zona CHECK ( nm_zona_bairro IN ( 'CENTRO', 'ZONA LESTE', 'ZONA NORTE', 'ZONA OESTE', 'ZONA SUL' ) )
    ;

COMMENT ON COLUMN tb_bairro.id_bairro IS
    'Esta coluna ir? receber o codigo interno para garantir o cadastro dos  Bairros da Cidade do Estado do Brasil. Seu conte?do ? obrigat?rio e ?nico ser? preenchido automaticamente pelo sistema.'
    ;

COMMENT ON COLUMN tb_bairro.nm_bairro IS
    'Esta coluna ir? receber o nome do Bairro  pertencente Cidade do Estado Brasileiro. O padr?o de armazenmento ?  InitCap e seu conte?do ? obrigat?rio. Essa tabela j? ser? preenchida pela ?rea respons?vel. Novas inse??es necessitam ser avaladas pelos gestores.'
    ;

COMMENT ON COLUMN tb_bairro.nm_zona_bairro IS
    'Esta coluna ir? receber a localiza??o da zona onde se encontra o bairro. Alguns exemplos: Zona Norte, Zona Sul, Zona Leste, Zona Oeste, Centro.'
    ;

ALTER TABLE tb_bairro ADD CONSTRAINT pk_bairro PRIMARY KEY ( id_bairro );

CREATE TABLE tb_cidade (
    id_cidade   NUMBER(8) NOT NULL,
    id_estado   NUMBER(2) NOT NULL,
    nm_cidade   VARCHAR2(60) NOT NULL,
    cd_ibge     NUMBER(8) NOT NULL,
    nr_ddd      NUMBER(3) NOT NULL,
    dt_cadastro DATE NOT NULL
);

COMMENT ON COLUMN tb_cidade.id_cidade IS
    'Esta coluna ir? receber o codigo da cidade e seu conte?do ? obrigat?rio e ser? preenchido automaticamente pelo sistema.

';

COMMENT ON COLUMN tb_cidade.id_estado IS
    'Esta coluna ir? receber o codigo interno para garantir unicidade dos Estados do Brasil. Seu conte?do ? obrigat?rio e ?nico ser? preenchido automaticamente pelo sistema.'
    ;

COMMENT ON COLUMN tb_cidade.nm_cidade IS
    'Esta coluna ir? receber o nome do Cidade pertencente ao Estado Brasileiro. O padr?o de armazenmento ?  InitCap e seu conte?do ? obrigat?rio. Essa tabela j? ser? preenchida pela ?rea respons?vel. Novas inse??es necessitam ser avaladas pelos gestores.'
    ;

COMMENT ON COLUMN tb_cidade.cd_ibge IS
    'Esta coluna ir? receber o c?digo do IBGE que fornece informa??es para gera??o da NFe.';

ALTER TABLE tb_cidade ADD CONSTRAINT pk_cidade PRIMARY KEY ( id_cidade );

CREATE TABLE tb_cliente_veiculo (
    id_usuario      NUMBER(6) NOT NULL,
    id_veiculo      NUMBER(6) NOT NULL,
    id_cliente      NUMBER(10) NOT NULL,
    nm_cliente_func VARCHAR2(30) NOT NULL,
    dt_inicio       DATE NOT NULL,
    dt_fim          DATE NOT NULL,
    cd_slc_atend    NUMBER(10) NOT NULL
);

COMMENT ON COLUMN tb_cliente_veiculo.id_cliente IS
    'Est? coluna se refere h? identifica??o do cliente que ? dona do ve?culo.';

COMMENT ON COLUMN tb_cliente_veiculo.nm_cliente_func IS
    'Est? coluna ir? identificar o nome da pessoa em posse do ve?cuilo.';

COMMENT ON COLUMN tb_cliente_veiculo.dt_inicio IS
    'Este atributo informa a data de inicio';

COMMENT ON COLUMN tb_cliente_veiculo.dt_fim IS
    'Este atributo informa uma data final 
';

ALTER TABLE tb_cliente_veiculo ADD CONSTRAINT pk_cliente_veiculo PRIMARY KEY ( id_veiculo,
                                                                               id_cliente );

CREATE TABLE tb_endereco_problema (
    id_end_problema       NUMBER(6) NOT NULL,
    id_logradouro         NUMBER(6) NOT NULL,
    nr_logradouro         NUMBER(7),
    ds_complemento_numero VARCHAR2(30),
    ds_ponto_referencia   VARCHAR2(50)
);

COMMENT ON COLUMN tb_endereco_problema.id_end_problema IS
    'Esse atributo ir? receber a chave prim?ria do endereco do problema. Esse n?mero ? sequencia e gerado automaticamente pelo sistema. Seu conte?do ? obrigat?rio.'
    ;

COMMENT ON COLUMN tb_endereco_problema.id_logradouro IS
    'Esta coluna ir? receber o codigo interno para garantir o lograouro, que esta localizado no  cadastro dos  Bairros da Cidade do Estado do Brasil. Seu conte?do ? obrigat?rio e ?nico ser? preenchido automaticamente pelo sistema.'
    ;

COMMENT ON COLUMN tb_endereco_problema.nr_logradouro IS
    'Esse atributo ir? receber o n?mero do logradouro do endereco do problema.  Seu conte?do ? opcional.';

COMMENT ON COLUMN tb_endereco_problema.ds_complemento_numero IS
    'Esse atributo ir? receber o complemeneto  do logradouro do endereco do problema. Seu conte?do ? opcional.';

COMMENT ON COLUMN tb_endereco_problema.ds_ponto_referencia IS
    'Esse atributo ir? receber o ponto de refer?ncia do logradouro do endereco do problema.  Seu conte?do ? opcional.';

ALTER TABLE tb_endereco_problema ADD CONSTRAINT pk_end_problema PRIMARY KEY ( id_end_problema );

CREATE TABLE tb_endereco_usuario (
    id_usuario            NUMBER(6) NOT NULL,
    id_logradouro         NUMBER(10) NOT NULL,
    id_end_usuario        NUMBER(6) NOT NULL,
    nr_logradouro         NUMBER(7) NOT NULL,
    ds_complemento_numero VARCHAR2(30),
    ds_ponto_referencia   VARCHAR2(50)
);

COMMENT ON COLUMN tb_endereco_usuario.id_usuario IS
    'Esta coluna ir? receber o codigo do usu?rio e seu conte?do ? obrigat?rio e ser? preenchido automaticamente pelo sistema.';

COMMENT ON COLUMN tb_endereco_usuario.id_logradouro IS
    'Esta coluna ir? receber o codigo interno para garantir o lograouro, que esta localizado no  cadastro dos  Bairros da Cidade do Estado do Brasil. Seu conte?do ? obrigat?rio e ?nico ser? preenchido automaticamente pelo sistema.'
    ;

COMMENT ON COLUMN tb_endereco_usuario.id_end_usuario IS
    'Esta coluna ir? receber o codigo do endere?o do usu?rio e seu conte?do ? obrigat?rio e ser? preenchido automaticamente pelo sistema.'
    ;

COMMENT ON COLUMN tb_endereco_usuario.nr_logradouro IS
    'Esta coluna ir? receber o numero do endere?o do usuario e seu conte?do ? obrigat?rio.';

COMMENT ON COLUMN tb_endereco_usuario.ds_complemento_numero IS
    'Esta coluna ir? receber o complemento do endere?o do usuario e seu conte?do ? opcional.';

COMMENT ON COLUMN tb_endereco_usuario.ds_ponto_referencia IS
    'Esta coluna ir? receber o ponto de referencia do endere?o e seu conte?do ? opcional.';

ALTER TABLE tb_endereco_usuario ADD CONSTRAINT pk_end_usuario PRIMARY KEY ( id_end_usuario );

CREATE TABLE tb_estado (
    id_estado   NUMBER(2) NOT NULL,
    sg_estado   CHAR(2) NOT NULL,
    nm_estado   VARCHAR2(30) NOT NULL,
    dt_cadastro DATE NOT NULL,
    nm_usuario  VARCHAR2(30) NOT NULL
);

COMMENT ON COLUMN tb_estado.id_estado IS
    'Esta coluna ir? receber o codigo interno para garantir unicidade dos Estados do Brasil. Seu conte?do ? obrigat?rio e ?nico ser? preenchido automaticamente pelo sistema.'
    ;

COMMENT ON COLUMN tb_estado.sg_estado IS
    'Esta coluna ira receber a siga do Estado. Esse conte?do ? obrigat?rio.';

COMMENT ON COLUMN tb_estado.nm_estado IS
    'Esta coluna ir? receber o nome do estado. O padr?o de armazenmento ?  InitCap e seu conte?do ? obrigat?rio. Essa tabela j? ser? preenchida pela ?rea respons?vel. Novas inse??es necessitam ser avaladas pelos gestores.'
    ;

ALTER TABLE tb_estado ADD CONSTRAINT pk_estado PRIMARY KEY ( id_estado );

CREATE TABLE tb_guincho (
    id_guincho NUMBER(6) NOT NULL,
    tp_guincho NUMBER(8) NOT NULL,
    nm_guincho VARCHAR2(50) NOT NULL,
    nr_guincho NUMBER(10) NOT NULL
);

COMMENT ON COLUMN tb_guincho.id_guincho IS
    'Esta coluna irá receber o código do guincho e seu conteúdo é obrigatório e será preenchido automaticamente pelo sistema.';

ALTER TABLE tb_guincho ADD CONSTRAINT pk_guincho PRIMARY KEY (id_guincho);

CREATE TABLE tb_guincho_solicitado (
    id_guincho_solicitado NUMBER(6) NOT NULL,
    id_veiculo            NUMBER(6) NOT NULL,
    id_guincho            NUMBER(6) NOT NULL,
    id_solicitacao        NUMBER(10) NOT NULL,
    cd_guincho            NUMBER(10) NOT NULL
);

COMMENT ON COLUMN tb_guincho_solicitado.id_guincho_solicitado IS
    'Esta coluna ir? receber o codigo do guincho escolhido e seu conte?do ? obrigat?rio e ser? preenchido automaticamente pelo sistema.'
    ;

COMMENT ON COLUMN tb_guincho_solicitado.id_veiculo IS
    'Esta coluna ir? receber o codigo do ve?culo e seu conte?do ? obrigat?rio e ser? preenchido automaticamente pelo sistema.';

COMMENT ON COLUMN tb_guincho_solicitado.id_guincho IS
    'Esta coluna ir? receber o codigo do guincho e seu conte?do ? obrigat?rio e ser? preenchido automaticamente pelo sistema.';

ALTER TABLE tb_guincho_solicitado ADD CONSTRAINT pk_guincho_solicitado PRIMARY KEY ( id_guincho_solicitado );

ALTER TABLE tb_guincho_solicitado ADD CONSTRAINT uk_cd_guincho UNIQUE ( cd_guincho );

CREATE TABLE tb_logradouro (
    id_logradouro NUMBER(10) NOT NULL,
    id_bairro     NUMBER(8) NOT NULL,
    nm_logradouro VARCHAR2(100) NOT NULL,
    nr_cep        NUMBER(8) NOT NULL,
    dy_cadastro   DATE NOT NULL
);

COMMENT ON COLUMN tb_logradouro.id_logradouro IS
    'Esta coluna ir? receber o codigo interno para garantir o lograouro, que esta localizado no  cadastro dos  Bairros da Cidade do Estado do Brasil. Seu conte?do ? obrigat?rio e ?nico ser? preenchido automaticamente pelo sistema.'
    ;

COMMENT ON COLUMN tb_logradouro.id_bairro IS
    'Esta coluna ir? receber o codigo interno para garantir o cadastro dos  Bairros da Cidade do Estado do Brasil. Seu conte?do ? obrigat?rio e ?nico ser? preenchido automaticamente pelo sistema.'
    ;

COMMENT ON COLUMN tb_logradouro.nm_logradouro IS
    'Esta coluna ir? receber o nome do lograoduro. O padr?o de armazenmento ?  InitCap e seu conte?do ? obrigat?rio. Essa tabela j? ser? preenchida pela ?rea respons?vel. Novas inse??es necessitam ser avaladas pelos gestores.'
    ;

COMMENT ON COLUMN tb_logradouro.nr_cep IS
    'Esta coluna ir? receber o n?mero do CEP do lograoduro. O padr?o de armazenmento ?  num?rico  e seu conte?do ? obrigat?rio. Essa tabela j? ser? preenchida pela ?rea respons?vel. Novas inse??es necessitam ser avaladas pelos gestores.'
    ;

ALTER TABLE tb_logradouro ADD CONSTRAINT pk_logradouro PRIMARY KEY ( id_logradouro );

CREATE TABLE tb_problema (
    id_problema     NUMBER(6) NOT NULL,
    id_end_problema NUMBER(6) NOT NULL,
    id_usuario      NUMBER(6) NOT NULL,
    nm_problema     VARCHAR2(50) NOT NULL,
    dt_problema     DATE NOT NULL
);

COMMENT ON COLUMN tb_problema.id_problema IS
    'Esta coluna ir? receber o codigo do problema e seu conte?do ? obrigat?rio e ser? preenchido automaticamente pelo sistema.';

COMMENT ON COLUMN tb_problema.id_end_problema IS
    'Esse atributo ir? receber a chave prim?ria do endereco do problema. Esse n?mero ? sequencia e gerado automaticamente pelo sistema. Seu conte?do ? obrigat?rio.'
    ;

COMMENT ON COLUMN tb_problema.id_usuario IS
    'Esta coluna ir? receber o codigo do usu?rio e seu conte?do ? obrigat?rio e ser? preenchido automaticamente pelo sistema.';

COMMENT ON COLUMN tb_problema.dt_problema IS
    'Esse atributo ir? receber a data do problema. Seu conte?do ? obrigat?rio.';

CREATE UNIQUE INDEX tb_problema__idx ON
    tb_problema (
        id_end_problema
    ASC );

ALTER TABLE tb_problema ADD CONSTRAINT pk_problema PRIMARY KEY ( id_problema );

CREATE TABLE tb_solicitacao_atendimento (
    id_solicitacao NUMBER(10) NOT NULL,
    id_problema    NUMBER(6) NOT NULL,
    id_veiculo     NUMBER(6) NOT NULL,
    id_cliente     NUMBER(10) NOT NULL,
    cd_solicitacao NUMBER(10) NOT NULL,
    nm_solicitacao VARCHAR2(100) NOT NULL
);

COMMENT ON COLUMN tb_solicitacao_atendimento.id_solicitacao IS
    'Essa coluna ir? receber a solicita??o do problema e ir? gerar um pedido de um guincho.';

COMMENT ON COLUMN tb_solicitacao_atendimento.cd_solicitacao IS
    'Essa coluna recebe o codigo da solicita??o. feita pelo cliente, ap?s a ocorrencia de ';

ALTER TABLE tb_solicitacao_atendimento ADD CONSTRAINT pk_solicitacao_atendimento PRIMARY KEY ( id_solicitacao );

ALTER TABLE tb_solicitacao_atendimento ADD CONSTRAINT uk_cd_solicitacao UNIQUE ( cd_solicitacao );

CREATE TABLE tb_telefone_usuario (
    id_telefone NUMBER(9) NOT NULL,
    id_usuario  NUMBER(6) NOT NULL,
    nr_ddi      NUMBER(3) NOT NULL,
    nr_ddd      NUMBER(3) NOT NULL,
    nr_telefone NUMBER(10) NOT NULL,
    tp_telefone VARCHAR2(20),
    st_telefone VARCHAR2(1) NOT NULL
);

ALTER TABLE tb_telefone_usuario
    ADD CONSTRAINT ck_st_telefone CHECK ( st_telefone IN ( 'A', 'I' ) );

COMMENT ON COLUMN tb_telefone_usuario.id_telefone IS
    'Esse atributo irá receber a chave primária do telefone do paciente. Esse número é sequencial iniciando com 1 a partir do id do paciente e é gerado automaticamente pelo sistema. Seu conteúdo é obrigatório.';

COMMENT ON COLUMN tb_telefone_usuario.id_usuario IS
    'Esta coluna irá receber o código do usuário e seu conteúdo é obrigatório e será preenchido automaticamente pelo sistema.';

COMMENT ON COLUMN tb_telefone_usuario.nr_ddi IS
    'Este atributo irá receber o número do DDI do telefone do paciente. Seu conteúdo é obrigatório.';

COMMENT ON COLUMN tb_telefone_usuario.nr_ddd IS
    'Esse atributo irá receber o número do DDD do telefone paciente.  Seu conteúdo é obrigatório.';

COMMENT ON COLUMN tb_telefone_usuario.nr_telefone IS
    'Esse atributo irá receber o número do telefone do DDD do telefone paciente.  Seu conteúdo é obrigatório.';

COMMENT ON COLUMN tb_telefone_usuario.tp_telefone IS
    'Esse atributo irá receber o tipo do telefone do telefone paciente.  Seu conteúdo é obrigatório e os valores possíveis são: Comercial, Residencial, Recado e Celular';

COMMENT ON COLUMN tb_telefone_usuario.st_telefone IS
    'Esse atributo irá receber o status do telefone do paciente.  Seu conteúdo é obrigatório e deve possuir os seguintes valores: (A)tivo ou (I)nativo.';

ALTER TABLE tb_telefone_usuario ADD CONSTRAINT pk_telefone_usuario PRIMARY KEY ( id_telefone );


CREATE TABLE tb_usuario (
    id_usuario        NUMBER(6) NOT NULL,
    nr_cpf            NUMBER(12) NOT NULL,
    nm_usuario        VARCHAR2(80) NOT NULL,
    dt_nascimento     DATE NOT NULL,
    nm_rg             VARCHAR2(15) NOT NULL,
    fl_sexo_biologico CHAR(2) NOT NULL,
    ds_email          VARCHAR2(30) NOT NULL,
    ds_senha          VARCHAR2(30) NOT NULL
);

COMMENT ON COLUMN tb_usuario.id_usuario IS
    'Esta coluna ir? receber o codigo do usu?rio e seu conte?do ? obrigat?rio e ser? preenchido automaticamente pelo sistema.';

COMMENT ON COLUMN tb_usuario.nr_cpf IS
    'Esta coluna ir? receber o CPF do usu?rio e seu conte?do ? obrigat?rio.';

COMMENT ON COLUMN tb_usuario.nm_usuario IS
    'Esta coluna ir? receber o nome do usu?rio e seu conte?do ? obrigat?rio.';

COMMENT ON COLUMN tb_usuario.dt_nascimento IS
    'Esta coluna ir? receber o data de nascimento do usu?rio e seu conte?do ? obrigat?rio.';

COMMENT ON COLUMN tb_usuario.nm_rg IS
    'Esta coluna ir? receber o RG do usu?rio e seu conte?do ? obrigat?rio.';

COMMENT ON COLUMN tb_usuario.fl_sexo_biologico IS
    'Esta coluna ir? receber o sexo biologico do usu?rio e seu conte?do ? obrigat?rio.';

COMMENT ON COLUMN tb_usuario.ds_email IS
    'Esta coluna ir? receber o email do usu?rio e seu conte?do ? obrigat?rio.';

COMMENT ON COLUMN tb_usuario.ds_senha IS
    'Esta coluna ir? receber a senha do usu?rio e seu conte?do ? obrigat?rio.';

ALTER TABLE TB_USUARIO MODIFY DS_EMAIL VARCHAR2(50); 

ALTER TABLE tb_usuario ADD CONSTRAINT pk_usuario PRIMARY KEY ( id_usuario );

ALTER TABLE tb_usuario ADD CONSTRAINT uk_cpf UNIQUE ( nr_cpf );

CREATE TABLE tb_veiculo (
    id_veiculo     NUMBER(6) NOT NULL,
    tp_veiculo     VARCHAR2(50) NOT NULL,
    dt_fabrica     DATE NOT NULL,
    nr_eixo        NUMBER(10) NOT NULL,
    nr_peso        NUMBER(5) NOT NULL,
    nr_altura      NUMBER(5) NOT NULL,
    nr_comprimento NUMBER(5) NOT NULL,
    tp_chassi      NUMBER(5) NOT NULL,
    dt_inicio      DATE NOT NULL,
    dt_fim         DATE NOT NULL
);

COMMENT ON COLUMN tb_veiculo.id_veiculo IS
    'Esta coluna ir? receber o codigo do ve?culo e seu conte?do ? obrigat?rio e ser? preenchido automaticamente pelo sistema.';

COMMENT ON COLUMN tb_veiculo.tp_veiculo IS
    'Esta coluna ir? receber o tipo de ve?culo  e seu conte?do ? obrigat?rio.';

COMMENT ON COLUMN tb_veiculo.dt_fabrica IS
    'Esta coluna ir? receber a data de fabrica??o e seu conte?do ? obrigat?rio.';

COMMENT ON COLUMN tb_veiculo.nr_eixo IS
    'Esta coluna ir? receber o n?mero de eixos do ve?culo e seu conte?do ? obrigat?rio.';

COMMENT ON COLUMN tb_veiculo.nr_peso IS
    'Esta coluna ir? receber o peso do ve?culo e seu conte?do ? obrigat?rio.';

COMMENT ON COLUMN tb_veiculo.nr_altura IS
    'Esta coluna ir? receber a altura do ve?culo e seu conte?do ? obrigat?rio.';

COMMENT ON COLUMN tb_veiculo.nr_comprimento IS
    'Esta coluna ir? receber o comprimento do ve?culo e seu conte?do ? obrigat?rio.';

COMMENT ON COLUMN tb_veiculo.tp_chassi IS
    'Esta coluna ir? receber o tipo de chassi  do ve?culo e seu conte?do ? obrigat?rio.';

ALTER TABLE tb_veiculo ADD CONSTRAINT pk_veiculo PRIMARY KEY ( id_veiculo );

ALTER TABLE tb_bairro
    ADD CONSTRAINT fk_cidade_bairro FOREIGN KEY ( id_cidade )
        REFERENCES tb_cidade ( id_cidade );

ALTER TABLE tb_problema
    ADD CONSTRAINT fk_end_prob FOREIGN KEY ( id_end_problema )
        REFERENCES tb_endereco_problema ( id_end_problema );

ALTER TABLE tb_cidade
    ADD CONSTRAINT fk_estado_cidade FOREIGN KEY ( id_estado )
        REFERENCES tb_estado ( id_estado );

ALTER TABLE tb_guincho_solicitado
    ADD CONSTRAINT fk_guin_sol FOREIGN KEY ( id_guincho )
        REFERENCES tb_guincho ( id_guincho );

ALTER TABLE tb_endereco_problema
    ADD CONSTRAINT fk_lograd_prob FOREIGN KEY ( id_logradouro )
        REFERENCES tb_logradouro ( id_logradouro );

ALTER TABLE tb_endereco_usuario
    ADD CONSTRAINT fk_lograd_user FOREIGN KEY ( id_logradouro )
        REFERENCES tb_logradouro ( id_logradouro );

ALTER TABLE tb_logradouro
    ADD CONSTRAINT fk_pkd_bairro_logradouro FOREIGN KEY ( id_bairro )
        REFERENCES tb_bairro ( id_bairro );

ALTER TABLE tb_endereco_usuario
    ADD CONSTRAINT fk_user_end FOREIGN KEY ( id_usuario )
        REFERENCES tb_usuario ( id_usuario );

ALTER TABLE tb_problema
    ADD CONSTRAINT fk_user_prob FOREIGN KEY ( id_usuario )
        REFERENCES tb_usuario ( id_usuario );

ALTER TABLE tb_telefone_usuario
    ADD CONSTRAINT fk_user_tel FOREIGN KEY ( id_usuario )
        REFERENCES tb_usuario ( id_usuario );

ALTER TABLE tb_guincho_solicitado
    ADD CONSTRAINT fk_veic_guin FOREIGN KEY ( id_veiculo )
        REFERENCES tb_veiculo ( id_veiculo );

ALTER TABLE tb_guincho_solicitado
    ADD CONSTRAINT pk_atendimento_guincho FOREIGN KEY ( id_solicitacao )
        REFERENCES tb_solicitacao_atendimento ( id_solicitacao );

ALTER TABLE tb_solicitacao_atendimento
    ADD CONSTRAINT pk_cliente_atendimento FOREIGN KEY ( id_veiculo,
                                                        id_cliente )
        REFERENCES tb_cliente_veiculo ( id_veiculo,
                                        id_cliente );

ALTER TABLE tb__motorista
    ADD CONSTRAINT pk_guincho_motorista FOREIGN KEY ( id_guincho )
        REFERENCES tb_guincho ( id_guincho );

ALTER TABLE tb_solicitacao_atendimento
    ADD CONSTRAINT pk_probl_atendimento FOREIGN KEY ( id_problema )
        REFERENCES tb_problema ( id_problema );

ALTER TABLE tb_cliente_veiculo
    ADD CONSTRAINT pk_usuario_veiculo FOREIGN KEY ( id_usuario )
        REFERENCES tb_usuario ( id_usuario );

ALTER TABLE tb_cliente_veiculo
    ADD CONSTRAINT pk_veiculo_cliente FOREIGN KEY ( id_veiculo )
        REFERENCES tb_veiculo ( id_veiculo );
        
        
INSERT INTO tb_estado (id_estado, sg_estado, nm_estado, dt_cadastro, nm_usuario)
VALUES
    (1, 'AC', 'Acre', SYSDATE, 'Admin');

INSERT INTO tb_estado (id_estado, sg_estado, nm_estado, dt_cadastro, nm_usuario)
VALUES
    (2, 'AL', 'Alagoas', SYSDATE, 'Admin');
INSERT INTO tb_estado (id_estado, sg_estado, nm_estado, dt_cadastro, nm_usuario)
VALUES
    (3, 'AP', 'Amap�', SYSDATE, 'Admin');

INSERT INTO tb_estado (id_estado, sg_estado, nm_estado, dt_cadastro, nm_usuario)
VALUES
    (4, 'AM', 'Amazonas', SYSDATE, 'Admin');

INSERT INTO tb_estado (id_estado, sg_estado, nm_estado, dt_cadastro, nm_usuario)
VALUES
    (5, 'BA', 'Bahia', SYSDATE, 'Admin');

INSERT INTO tb_estado (id_estado, sg_estado, nm_estado, dt_cadastro, nm_usuario)
VALUES
    (6, 'CE', 'Cear�', SYSDATE, 'Admin');

INSERT INTO tb_estado (id_estado, sg_estado, nm_estado, dt_cadastro, nm_usuario)
VALUES
    (7, 'DF', 'Distrito Federal', SYSDATE, 'Admin');

INSERT INTO tb_estado (id_estado, sg_estado, nm_estado, dt_cadastro, nm_usuario)
VALUES
    (8, 'ES', 'Esp�rito Santo', SYSDATE, 'Admin');

INSERT INTO tb_estado (id_estado, sg_estado, nm_estado, dt_cadastro, nm_usuario)
VALUES
    (9, 'GO', 'Goi�s', SYSDATE, 'Admin');

INSERT INTO tb_estado (id_estado, sg_estado, nm_estado, dt_cadastro, nm_usuario)
VALUES
    (10, 'MA', 'Maranh�o', SYSDATE, 'Admin');

INSERT INTO tb_estado (id_estado, sg_estado, nm_estado, dt_cadastro, nm_usuario)
VALUES
    (11, 'MT', 'Mato Grosso', SYSDATE, 'Admin');

INSERT INTO tb_estado (id_estado, sg_estado, nm_estado, dt_cadastro, nm_usuario)
VALUES
    (12, 'MS', 'Mato Grosso do Sul', SYSDATE, 'Admin');

INSERT INTO tb_estado (id_estado, sg_estado, nm_estado, dt_cadastro, nm_usuario)
VALUES
    (13, 'MG', 'Minas Gerais', SYSDATE, 'Admin');

INSERT INTO tb_estado (id_estado, sg_estado, nm_estado, dt_cadastro, nm_usuario)
VALUES
    (14, 'PA', 'Par�', SYSDATE, 'Admin');

INSERT INTO tb_estado (id_estado, sg_estado, nm_estado, dt_cadastro, nm_usuario)
VALUES
    (15, 'PB', 'Para�ba', SYSDATE, 'Admin');

INSERT INTO tb_estado (id_estado, sg_estado, nm_estado, dt_cadastro, nm_usuario)
VALUES
    (16, 'PR', 'Paran�', SYSDATE, 'Admin');

INSERT INTO tb_estado (id_estado, sg_estado, nm_estado, dt_cadastro, nm_usuario)
VALUES
    (17, 'PE', 'Pernambuco', SYSDATE, 'Admin');

INSERT INTO tb_estado (id_estado, sg_estado, nm_estado, dt_cadastro, nm_usuario)
VALUES
    (18, 'PI', 'Piau�', SYSDATE, 'Admin');

INSERT INTO tb_estado (id_estado, sg_estado, nm_estado, dt_cadastro, nm_usuario)
VALUES
    (19, 'RJ', 'Rio de Janeiro', SYSDATE, 'Admin');

INSERT INTO tb_estado (id_estado, sg_estado, nm_estado, dt_cadastro, nm_usuario)
VALUES
    (20, 'RN', 'Rio Grande do Norte', SYSDATE, 'Admin');

INSERT INTO tb_estado (id_estado, sg_estado, nm_estado, dt_cadastro, nm_usuario)
VALUES
    (21, 'RS', 'Rio Grande do Sul', SYSDATE, 'Admin');

INSERT INTO tb_estado (id_estado, sg_estado, nm_estado, dt_cadastro, nm_usuario)
VALUES
    (22, 'RO', 'Rond�nia', SYSDATE, 'Admin');

INSERT INTO tb_estado (id_estado, sg_estado, nm_estado, dt_cadastro, nm_usuario)
VALUES
    (23, 'RR', 'Roraima', SYSDATE, 'Admin');

INSERT INTO tb_estado (id_estado, sg_estado, nm_estado, dt_cadastro, nm_usuario)
VALUES
    (24, 'SC', 'Santa Catarina', SYSDATE, 'Admin');

INSERT INTO tb_estado (id_estado, sg_estado, nm_estado, dt_cadastro, nm_usuario)
VALUES
    (25, 'SP', 'S�o Paulo', SYSDATE, 'Admin');

INSERT INTO tb_estado (id_estado, sg_estado, nm_estado, dt_cadastro, nm_usuario)
VALUES
    (26, 'SE', 'Sergipe', SYSDATE, 'Admin');

INSERT INTO tb_estado (id_estado, sg_estado, nm_estado, dt_cadastro, nm_usuario)
VALUES
    (27, 'TO', 'Tocantins', SYSDATE, 'Admin');




-- Inserir dados para o estado do Acre (AC)
INSERT INTO tb_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro)
VALUES
    (1, 1, 'Rio Branco', 1200401, 68, SYSDATE);

-- Inserir dados para o estado de Alagoas (AL)
INSERT INTO tb_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro)
VALUES
    (2, 2, 'Macei�', 2704302, 82, SYSDATE);

-- Inserir dados para o estado do Amap� (AP)
INSERT INTO tb_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro)
VALUES
    (3, 3, 'Macap�', 1600303, 96, SYSDATE);
-- Inserir dados para o estado do Amazonas (AM)
INSERT INTO tb_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro)
VALUES
    (4, 4, 'Manaus', 1302603, 92, SYSDATE);

-- Inserir dados para o estado da Bahia (BA)
INSERT INTO tb_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro)
VALUES
    (5, 5, 'Salvador', 2927408, 71, SYSDATE);

-- Inserir dados para o estado do Cear� (CE)
INSERT INTO tb_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro)
VALUES
    (6, 6, 'Fortaleza', 2304400, 85, SYSDATE);

-- Inserir dados para o estado do Distrito Federal (DF)
INSERT INTO tb_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro)
VALUES
    (7, 7, 'Bras�lia', 5300108, 61, SYSDATE);

-- Inserir dados para o estado do Esp�rito Santo (ES)
INSERT INTO tb_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro)
VALUES
    (8, 8, 'Vit�ria', 3205309, 27, SYSDATE);

-- Inserir dados para o estado de Goi�s (GO)
INSERT INTO tb_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro)
VALUES
    (9, 9, 'Goi�nia', 5208707, 62, SYSDATE);

-- Inserir dados para o estado do Maranh�o (MA)
INSERT INTO tb_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro)
VALUES
    (10, 10, 'S�o Lu�s', 2111300, 98, SYSDATE);

-- Inserir dados para o estado do Mato Grosso (MT)
INSERT INTO tb_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro)
VALUES
    (11, 11, 'Cuiab�', 5103403, 65, SYSDATE);

-- Inserir dados para o estado do Mato Grosso do Sul (MS)
INSERT INTO tb_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro)
VALUES
    (12, 12, 'Campo Grande', 5002704, 67, SYSDATE);
-- Inserir dados para o estado de Minas Gerais (MG)
INSERT INTO tb_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro)
VALUES
    (13, 13, 'Belo Horizonte', 3106200, 31, SYSDATE);

-- Inserir dados para o estado do Par� (PA)
INSERT INTO tb_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro)
VALUES
    (14, 14, 'Bel�m', 1501402, 91, SYSDATE);

-- Inserir dados para o estado da Para�ba (PB)
INSERT INTO tb_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro)
VALUES
    (15, 15, 'Jo�o Pessoa', 2507507, 83, SYSDATE);

-- Inserir dados para o estado do Paran� (PR)
INSERT INTO tb_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro)
VALUES
    (16, 16, 'Curitiba', 4106902, 41, SYSDATE);

-- Inserir dados para o estado de Pernambuco (PE)
INSERT INTO tb_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro)
VALUES
    (17, 17, 'Recife', 2611606, 81, SYSDATE);

-- Inserir dados para o estado do Piau� (PI)
INSERT INTO tb_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro)
VALUES
    (18, 18, 'Teresina', 2211001, 86, SYSDATE);

-- Inserir dados para o estado do Rio de Janeiro (RJ)
INSERT INTO tb_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro)
VALUES
    (19, 19, 'Rio de Janeiro', 3304557, 21, SYSDATE);

-- Inserir dados para o estado do Rio Grande do Norte (RN)
INSERT INTO tb_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro)
VALUES
    (20, 20, 'Natal', 2408102, 84, SYSDATE);

-- Inserir dados para o estado do Rio Grande do Sul (RS)
INSERT INTO tb_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro)
VALUES
    (21, 21, 'Porto Alegre', 4314902, 51, SYSDATE);
-- Inserir dados para o estado de Rond�nia (RO)
INSERT INTO tb_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro)
VALUES
    (22, 22, 'Porto Velho', 1100205, 69, SYSDATE);

-- Inserir dados para o estado de Roraima (RR)
INSERT INTO tb_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro)
VALUES
    (23, 23, 'Boa Vista', 1400100, 95, SYSDATE);

-- Inserir dados para o estado de Santa Catarina (SC)
INSERT INTO tb_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro)
VALUES
    (24, 24, 'Florian�polis', 4205407, 48, SYSDATE);

-- Inserir dados para o estado de S�o Paulo (SP)
INSERT INTO tb_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro)
VALUES
    (25, 25, 'S�o Paulo', 3550308, 11, SYSDATE);

-- Inserir dados para o estado de Sergipe (SE)
INSERT INTO tb_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro)
VALUES
    (26, 26, 'Aracaju', 2800308, 79, SYSDATE);

-- Inserir dados para o estado do Tocantins (TO)
INSERT INTO tb_cidade (id_cidade, id_estado, nm_cidade, cd_ibge, nr_ddd, dt_cadastro)
VALUES
    (27, 27, 'Palmas', 1721000, 63, SYSDATE);

-- Inserir dados para bairros na cidade de Rio Branco (AC)
-- Inserir dados para bairros na cidade de Rio Branco (AC)
INSERT INTO tb_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro)
VALUES
    (1, 1, 'Centro', 'CENTRO', SYSDATE);

INSERT INTO tb_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro)
VALUES
    (2, 1, 'Bosque', 'ZONA NORTE', SYSDATE);


-- Inserir dados para bairros na cidade de Macei� (AL)
INSERT INTO tb_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro)
VALUES
    (3, 2, 'Paju�ara', 'ZONA NORTE', SYSDATE);
    INSERT INTO tb_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro)
VALUES
    (4, 2, 'Jati�ca', 'ZONA LESTE', SYSDATE);

-- Inserir dados para bairros na cidade de Macap� (AP)
INSERT INTO tb_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro)
VALUES
    (5, 3, 'Buritizal', 'ZONA SUL', SYSDATE);
INSERT INTO tb_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro)
VALUES    
    (6, 3, 'Santa In�s', 'ZONA LESTE', SYSDATE);

-- Inserir dados para bairros na cidade de Manaus (AM)
INSERT INTO tb_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro)
VALUES
    (7, 4, 'Centro', 'CENTRO', SYSDATE);

INSERT INTO tb_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro)
VALUES
    (8, 4, 'Cidade Nova', 'ZONA NORTE', SYSDATE);

-- Inserir dados para bairros na cidade de Salvador (BA)
INSERT INTO tb_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro)
VALUES
    (9, 5, 'Pelourinho', 'CENTRO', SYSDATE);

INSERT INTO tb_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro)
VALUES
    (10, 5, 'Itapu�', 'ZONA LESTE', SYSDATE);

-- Inserir dados para bairros na cidade de Fortaleza (CE)
INSERT INTO tb_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro)
VALUES
    (11, 6, 'Centro', 'CENTRO', SYSDATE);

INSERT INTO tb_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro)
VALUES
    (12, 6, 'Aldeota', 'ZONA OESTE', SYSDATE);

-- Inserir dados para bairros na cidade de Bras�lia (DF)
INSERT INTO tb_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro)
VALUES
    (13, 7, 'Plano Piloto', 'CENTRO', SYSDATE);

INSERT INTO tb_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro)
VALUES
    (14, 7, 'Lago Sul', 'ZONA SUL', SYSDATE);

-- Inserir dados para bairros na cidade de Vit�ria (ES)
INSERT INTO tb_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro)
VALUES
    (15, 8, 'Jardim Camburi', 'ZONA NORTE', SYSDATE);

INSERT INTO tb_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro)
VALUES
    (16, 8, 'Jardim da Penha', 'ZONA LESTE', SYSDATE);

-- Inserir dados para bairros na cidade de Goi�nia (GO)
INSERT INTO tb_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro)
VALUES
    (17, 9, 'Setor Bueno', 'ZONA SUL', SYSDATE);

INSERT INTO tb_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro)
VALUES
    (18, 9, 'Setor Oeste', 'ZONA OESTE', SYSDATE);

-- Inserir dados para bairros na cidade de S�o Lu�s (MA)
INSERT INTO tb_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro)
VALUES
    (19, 10, 'Renascen�a', 'ZONA SUL', SYSDATE);

INSERT INTO tb_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro)
VALUES
    (20, 10, 'Cohama', 'ZONA LESTE', SYSDATE);

-- Inserir dados para bairros na cidade de Cuiab� (MT)
INSERT INTO tb_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro)
VALUES
    (21, 11, 'Centro Sul', 'CENTRO', SYSDATE);

INSERT INTO tb_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro)
VALUES
    (22, 11, 'Ara�s', 'ZONA NORTE', SYSDATE);

-- Inserir dados para bairros na cidade de Campo Grande (MS)
INSERT INTO tb_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro)
VALUES
    (23, 12, 'Centro', 'CENTRO', SYSDATE);

INSERT INTO tb_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro)
VALUES
    (24, 12, 'Jardim dos Estados', 'ZONA SUL', SYSDATE);

-- Inserir dados para bairros na cidade de Belo Horizonte (MG)
INSERT INTO tb_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro)
VALUES
    (25, 13, 'Centro', 'CENTRO', SYSDATE);

INSERT INTO tb_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro)
VALUES
    (26, 13, 'Savassi', 'ZONA SUL', SYSDATE);

-- Inserir dados para bairros na cidade de Bel�m (PA)
INSERT INTO tb_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro)
VALUES
    (27, 14, 'Umarizal', 'CENTRO', SYSDATE);

INSERT INTO tb_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro)
VALUES
    (28, 14, 'Nazar�', 'ZONA SUL', SYSDATE);

-- Inserir dados para bairros na cidade de Jo�o Pessoa (PB)
INSERT INTO tb_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro)
VALUES
    (29, 15, 'Centro', 'CENTRO', SYSDATE);

INSERT INTO tb_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro)
VALUES
    (30, 15, 'Mana�ra', 'ZONA LESTE', SYSDATE);

-- Inserir dados para bairros na cidade de Curitiba (PR)
INSERT INTO tb_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro)
VALUES
    (31, 16, 'Centro', 'CENTRO', SYSDATE);

INSERT INTO tb_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro)
VALUES
    (32, 16, 'Batel', 'ZONA SUL', SYSDATE);

-- Inserir dados para bairros na cidade de Recife (PE)
INSERT INTO tb_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro)
VALUES
    (33, 17, 'Boa Viagem', 'ZONA SUL', SYSDATE);

INSERT INTO tb_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro)
VALUES
    (34, 17, 'Boa Vista', 'CENTRO', SYSDATE);

-- Inserir dados para bairros na cidade de Teresina (PI)
INSERT INTO tb_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro)
VALUES
    (35, 18, 'Centro', 'CENTRO', SYSDATE);

INSERT INTO tb_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro)
VALUES
    (36, 18, 'J�quei', 'ZONA LESTE', SYSDATE);

-- Inserir dados para bairros na cidade de Natal (RN)
INSERT INTO tb_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro)
VALUES
    (37, 20, 'Petr�polis', 'ZONA LESTE', SYSDATE);

INSERT INTO tb_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro)
VALUES
    (38, 20, 'Lagoa Nova', 'ZONA SUL', SYSDATE);

-- Inserir dados para bairros na cidade de Porto Alegre (RS)
INSERT INTO tb_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro)
VALUES
    (39, 21, 'Centro Hist�rico', 'CENTRO', SYSDATE);

INSERT INTO tb_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro)
VALUES
    (40, 21, 'Moinhos de Vento', 'ZONA NORTE', SYSDATE);

-- Inserir dados para bairros na cidade de Florian�polis (SC)
INSERT INTO tb_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro)
VALUES
    (41, 24, 'Centro', 'CENTRO', SYSDATE);

INSERT INTO tb_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro)
VALUES
    (42, 24, 'Trindade', 'ZONA LESTE', SYSDATE);

-- Inserir dados para bairros na cidade de Aracaju (SE)
INSERT INTO tb_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro)
VALUES
    (43, 25, 'Centro', 'CENTRO', SYSDATE);

INSERT INTO tb_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro)
VALUES
    (44, 25, 'Grageru', 'ZONA SUL', SYSDATE);

-- Inserir dados para bairros na cidade de Palmas (TO)
INSERT INTO tb_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro)
VALUES
    (45, 27, 'Plano Diretor Norte', 'ZONA NORTE', SYSDATE);

INSERT INTO tb_bairro (id_bairro, id_cidade, nm_bairro, nm_zona_bairro, dt_cadastro)
VALUES
    (46, 27, 'Plano Diretor Sul', 'ZONA SUL', SYSDATE);

INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro) 
    VALUES (1, 1, 'Rua Trevo J�lia Barros', 62873480, TO_DATE('2023-05-30', 'YYYY-MM-DD'));  


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)   
    VALUES (2, 1, 'Avenida Vereda de Caldeira', 37640622, TO_DATE('2022-12-07', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)   
    VALUES (3, 2, 'Rua Conjunto de Pereira', 77464101, TO_DATE('2023-10-31', 'YYYY-MM-DD'));   


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (4, 2, 'Avenida Esta��o Oliveira', 78086484, TO_DATE('2023-05-12', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (5, 3, 'Rua Largo Campos', 3552099, TO_DATE('2023-03-14', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (6, 3, 'Avenida Trecho de da Mota', 36641724, TO_DATE('2023-05-07', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (7, 4, 'Rua Viela Gabrielly Lopes', 78275514, TO_DATE('2023-06-20', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (8, 4, 'Rua Campo da Luz', 24496510, TO_DATE('2023-08-31', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (9, 5, 'Rua Conjunto Isadora Ferreira', 38502107, TO_DATE('2023-03-28', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (10, 5, 'Rua Quadra Costa', 63768432, TO_DATE('2023-04-22', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (11, 6, 'Avenida S�tio de da Rosa', 42674622, TO_DATE('2023-08-17', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (12, 6, 'Rua Lago de Cavalcanti', 95669303, TO_DATE('2023-06-26', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (13, 7, 'Avenida Residencial Yuri Caldeira', 2191079, TO_DATE('2022-12-22', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (14, 7, 'Avenida Lago Nina Campos', 68168314, TO_DATE('2023-06-20', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (15, 8, 'Avenida Setor Cec�lia Mendes', 12337837, TO_DATE('2023-08-14', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (16, 8, 'Rua Trevo Jesus', 15947391, TO_DATE('2022-11-27', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (17, 9, 'Avenida Jardim de Cavalcanti', 7558422, TO_DATE('2023-07-27', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (18, 9, 'Avenida Largo de Correia', 94484342, TO_DATE('2023-08-09', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (19, 10, 'Rua Estrada Gustavo Barros', 81988000, TO_DATE('2023-07-07', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (20, 10, 'Avenida Setor Emanuella Alves', 76558133, TO_DATE('2023-04-18', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (21, 11, 'Avenida Estrada Moraes', 90719482, TO_DATE('2023-08-02', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (22, 11, 'Avenida Vale de Mendes', 47811144, TO_DATE('2023-03-02', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (23, 12, 'Rua Avenida de Gomes', 57499468, TO_DATE('2023-07-06', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (24, 12, 'Avenida N�cleo Costa', 42520991, TO_DATE('2023-10-15', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (25, 13, 'Rua Recanto Jo�o Vieira', 2483591, TO_DATE('2023-06-07', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (26, 13, 'Rua Lagoa Vitor Gabriel Freitas', 37137430, TO_DATE('2023-07-01', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (27, 14, 'Rua Alameda de Souza', 67499377, TO_DATE('2023-04-17', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (28, 14, 'Avenida Distrito da Concei��o', 16072803, TO_DATE('2023-04-30', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (29, 15, 'Rua Recanto de Barbosa', 37707905, TO_DATE('2022-11-15', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (30, 15, 'Rua Distrito Cardoso', 47595894, TO_DATE('2023-06-11', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (31, 16, 'Rua Recanto Rodrigues', 97923888, TO_DATE('2023-09-19', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (32, 16, 'Rua �rea de Moura', 91314256, TO_DATE('2022-12-18', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (33, 17, 'Avenida Quadra Nogueira', 12967505, TO_DATE('2023-04-05', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (34, 17, 'Avenida Morro de Viana', 67966397, TO_DATE('2023-09-16', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (35, 18, 'Avenida Trecho Ana Luiza das Neves', 36872202, TO_DATE('2023-05-25', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (36, 18, 'Rua Campo Isabel Barbosa', 90001075, TO_DATE('2023-08-03', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (37, 19, 'Avenida �rea de Pereira', 51693305, TO_DATE('2023-10-23', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (38, 19, 'Rua P�tio Ana Beatriz Pereira', 61593515, TO_DATE('2023-07-21', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (39, 20, 'Avenida �rea Luiza Oliveira', 72282967, TO_DATE('2023-03-26', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (40, 20, 'Avenida Campo de Peixoto', 80767258, TO_DATE('2022-11-16', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (41, 21, 'Avenida Rua de Barbosa', 73827058, TO_DATE('2023-03-06', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (42, 21, 'Avenida Estrada Kamilly Correia', 2125495, TO_DATE('2023-06-27', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (43, 22, 'Rua Conjunto Catarina da Cruz', 69828002, TO_DATE('2023-08-04', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (44, 22, 'Rua Rodovia Cavalcanti', 9189903, TO_DATE('2023-04-04', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (45, 23, 'Rua N�cleo de Peixoto', 43834570, TO_DATE('2022-12-14', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (46, 23, 'Avenida Jardim Nicolas da Paz', 88600538, TO_DATE('2022-11-16', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (47, 24, 'Avenida Lago de Ferreira', 90211643, TO_DATE('2023-03-31', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (48, 24, 'Avenida Trevo Felipe Sales', 80512262, TO_DATE('2023-08-11', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (49, 25, 'Rua N�cleo Rebeca Moura', 33987837, TO_DATE('2023-05-27', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (50, 25, 'Avenida Esta��o Santos', 58321952, TO_DATE('2023-05-20', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (51, 26, 'Rua Via de Freitas', 85436630, TO_DATE('2022-12-16', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (52, 26, 'Avenida Avenida de Nunes', 89514039, TO_DATE('2023-01-16', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (53, 27, 'Avenida Lago de Cunha', 39061184, TO_DATE('2023-05-30', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (54, 27, 'Avenida Setor Pedro Miguel Nunes', 95629030, TO_DATE('2023-06-11', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (55, 28, 'Rua Fazenda Gustavo Cunha', 82566911, TO_DATE('2022-11-19', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (56, 28, 'Rua Ladeira Silva', 7676089, TO_DATE('2023-10-04', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (57, 29, 'Rua Col�nia Milena Freitas', 74363233, TO_DATE('2023-06-07', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (58, 29, 'Rua Pra�a Foga�a', 17697369, TO_DATE('2023-08-19', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (59, 30, 'Rua Alameda Ferreira', 7609579, TO_DATE('2023-04-12', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (60, 30, 'Avenida Lagoa de Costa', 66694664, TO_DATE('2023-10-01', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (61, 31, 'Rua Trecho de Rodrigues', 77495323, TO_DATE('2023-03-25', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (62, 31, 'Rua Parque Pietro Barros', 5532513, TO_DATE('2023-04-22', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (63, 32, 'Rua Alameda Campos', 35659359, TO_DATE('2023-08-11', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (64, 32, 'Rua N�cleo de Rezende', 30609019, TO_DATE('2023-01-30', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (65, 33, 'Rua Lago de Ramos', 61056920, TO_DATE('2023-06-24', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (66, 33, 'Rua Rodovia de Santos', 97771384, TO_DATE('2023-02-17', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (67, 34, 'Rua Pra�a da Cruz', 74412759, TO_DATE('2023-08-25', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (68, 34, 'Rua Viaduto de Ribeiro', 1103755, TO_DATE('2023-08-23', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (69, 35, 'Avenida Quadra Monteiro', 65332919, TO_DATE('2023-08-21', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (70, 35, 'Avenida Passarela da Luz', 23437746, TO_DATE('2023-09-21', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (71, 36, 'Rua Campo da Costa', 29209489, TO_DATE('2023-01-13', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (72, 36, 'Avenida Trecho Novaes', 27241383, TO_DATE('2022-11-20', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (73, 37, 'Rua Trecho Ana Luiza Almeida', 97161590, TO_DATE('2023-04-27', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (74, 37, 'Avenida Conjunto Augusto Jesus', 81691487, TO_DATE('2023-08-01', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (75, 38, 'Rua Travessa Sophia Barros', 86363667, TO_DATE('2023-04-28', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (76, 38, 'Avenida Vereda Lucca Martins', 23912924, TO_DATE('2023-01-17', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (77, 39, 'Rua Rodovia Emanuelly Lopes', 85123520, TO_DATE('2023-01-01', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (78, 39, 'Rua Trecho Maria Fernanda Gon�alves', 80538441, TO_DATE('2022-11-10', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (79, 40, 'Avenida Condom�nio de Monteiro', 60196144, TO_DATE('2023-05-24', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (80, 40, 'Avenida Condom�nio Cardoso', 85337150, TO_DATE('2023-06-11', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (81, 41, 'Rua Conjunto de da Concei��o', 74136938, TO_DATE('2023-03-03', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (82, 41, 'Rua Praia Emilly Carvalho', 17287091, TO_DATE('2023-09-21', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (83, 42, 'Rua Rua Vit�ria Pereira', 63864122, TO_DATE('2023-05-20', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (84, 42, 'Rua Quadra Azevedo', 85067441, TO_DATE('2023-04-27', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (85, 43, 'Avenida Vale de Rezende', 84992860, TO_DATE('2023-04-22', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (86, 43, 'Avenida Quadra de Cunha', 38837053, TO_DATE('2023-07-19', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (87, 44, 'Avenida Morro Barbosa', 48273412, TO_DATE('2023-01-23', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (88, 44, 'Avenida Aeroporto Costela', 50011696, TO_DATE('2023-06-13', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (89, 45, 'Avenida Ladeira de Nunes', 13431781, TO_DATE('2023-04-28', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (90, 45, 'Rua Aeroporto de Santos', 76203786, TO_DATE('2023-08-18', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (91, 46, 'Rua Alameda Ot�vio Santos', 62060289, TO_DATE('2023-07-01', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (92, 46, 'Avenida Rodovia Pinto', 63171997, TO_DATE('2022-12-25', 'YYYY-MM-DD'));


    INSERT INTO tb_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dy_cadastro)
    VALUES (93, 46, 'Rua Lagoa de Foga�a', 11106575, TO_DATE('2023-05-24', 'YYYY-MM-DD'));


    INSERT INTO tb_endereco_problema (id_end_problema, id_logradouro, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (1, 1, 4857, 'APTO 35', NULL);


    INSERT INTO tb_endereco_problema (id_end_problema, id_logradouro, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (2, 2, 7716, 'APTO 28', NULL);


    INSERT INTO tb_endereco_problema (id_end_problema, id_logradouro, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (3, 3, 4229, 'APTO 48', NULL);


    INSERT INTO tb_endereco_problema (id_end_problema, id_logradouro, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (4, 4, 7091, NULL, 'Ponto de referência 831');


    INSERT INTO tb_endereco_problema (id_end_problema, id_logradouro, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (5, 5, 5523, NULL, 'Ponto de referência 832');


    INSERT INTO tb_endereco_problema (id_end_problema, id_logradouro, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (6, 6, 9636, NULL, NULL);


    INSERT INTO tb_endereco_problema (id_end_problema, id_logradouro, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (7, 7, 6037, NULL, NULL);


    INSERT INTO tb_endereco_problema (id_end_problema, id_logradouro, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (8, 8, 87, 'APTO 50', NULL);


    INSERT INTO tb_endereco_problema (id_end_problema, id_logradouro, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (9, 9, 4910, 'APTO 5', 'Ponto de referência 836');


    INSERT INTO tb_endereco_problema (id_end_problema, id_logradouro, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (10, 10, 5062, 'APTO 13', NULL);


    INSERT INTO tb_endereco_problema (id_end_problema, id_logradouro, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (11, 12, 6018, NULL, NULL);


    INSERT INTO tb_endereco_problema (id_end_problema, id_logradouro, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (13, 13, 7220, NULL, NULL);


    INSERT INTO tb_endereco_problema (id_end_problema, id_logradouro, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (14, 14, 8582, NULL, NULL);


    INSERT INTO tb_endereco_problema (id_end_problema, id_logradouro, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (15, 15, 3480, NULL, NULL);

7
    INSERT INTO tb_endereco_problema (id_end_problema, id_logradouro, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (16, 16, 2239, NULL, 'Ponto de referência 842');


    INSERT INTO tb_endereco_problema (id_end_problema, id_logradouro, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (17, 17, 7125, NULL, NULL);


    INSERT INTO tb_endereco_problema (id_end_problema, id_logradouro, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (18, 18, 743, 'APTO 83', 'Ponto de referência 844');


    INSERT INTO tb_endereco_problema (id_end_problema, id_logradouro, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (19, 19, 1727, NULL, 'Ponto de referência 845');


    INSERT INTO tb_endereco_problema (id_end_problema, id_logradouro, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (20, 20, 4932, NULL, 'Ponto de referência 846');


    INSERT INTO tb_endereco_problema (id_end_problema, id_logradouro, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (21, 21, 3965, 'APTO 75', 'Ponto de referência 847');


    INSERT INTO tb_endereco_problema (id_end_problema, id_logradouro, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (22, 22, 9441, NULL, NULL);


    INSERT INTO tb_endereco_problema (id_end_problema, id_logradouro, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (23, 23, 1275, 'APTO 88', 'Ponto de referência 849');


    INSERT INTO tb_endereco_problema (id_end_problema, id_logradouro, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (24, 24, 7979, NULL, NULL);


    INSERT INTO tb_endereco_problema (id_end_problema, id_logradouro, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (25, 25, 1386, NULL, NULL);


    INSERT INTO tb_endereco_problema (id_end_problema, id_logradouro, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (26, 26, 871, 'APTO 2', NULL);


    INSERT INTO tb_endereco_problema (id_end_problema, id_logradouro, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (27, 27, 2234, NULL, NULL);


    INSERT INTO tb_endereco_problema (id_end_problema, id_logradouro, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (28, 28, 9193, NULL, 'Ponto de referência 854');


    INSERT INTO tb_endereco_problema (id_end_problema, id_logradouro, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (29, 29, 9161, NULL, 'Ponto de referência 855');


    INSERT INTO tb_endereco_problema (id_end_problema, id_logradouro, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (30, 30, 8895, NULL, 'Ponto de referência 856');


    INSERT INTO tb_endereco_problema (id_end_problema, id_logradouro, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (31, 31, 560, 'APTO 96', 'Ponto de referência 857');


    INSERT INTO tb_endereco_problema (id_end_problema, id_logradouro, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (32, 32, 9641, NULL, 'Ponto de referência 858');


    INSERT INTO tb_endereco_problema (id_end_problema, id_logradouro, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (33, 33, 4961, 'APTO 97', NULL);


    INSERT INTO tb_endereco_problema (id_end_problema, id_logradouro, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (34, 34, 5004, 'APTO 18', NULL);


    INSERT INTO tb_endereco_problema (id_end_problema, id_logradouro, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (35, 35, 9624, 'APTO 33', 'Ponto de referência 861');


    INSERT INTO tb_endereco_problema (id_end_problema, id_logradouro, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (36, 36, 4472, 'APTO 81', 'Ponto de referência 862');


    INSERT INTO tb_endereco_problema (id_end_problema, id_logradouro, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (37, 37, 4114, 'APTO 7', NULL);


    INSERT INTO tb_endereco_problema (id_end_problema, id_logradouro, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (38, 38, 1672, 'APTO 34', 'Ponto de referência 864');


    INSERT INTO tb_endereco_problema (id_end_problema, id_logradouro, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (39, 39, 1388, NULL, NULL);


    INSERT INTO tb_endereco_problema (id_end_problema, id_logradouro, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (40, 40, 4208, 'APTO 51', 'Ponto de referência 866');


    INSERT INTO tb_endereco_problema (id_end_problema, id_logradouro, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (41, 41, 6948, 'APTO 30', 'Ponto de referência 867');


    INSERT INTO tb_endereco_problema (id_end_problema, id_logradouro, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (42, 42, 5808, 'APTO 37', 'Ponto de referência 868');


    INSERT INTO tb_endereco_problema (id_end_problema, id_logradouro, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (43, 43, 2537, NULL, 'Ponto de referência 869');


    INSERT INTO tb_endereco_problema (id_end_problema, id_logradouro, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (44, 44, 6285, 'APTO 32', 'Ponto de referência 870');


    INSERT INTO tb_endereco_problema (id_end_problema, id_logradouro, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (45, 45, 1859, NULL, 'Ponto de referência 871');


    INSERT INTO tb_endereco_problema (id_end_problema, id_logradouro, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (46, 46, 8934, 'APTO 45', 'Ponto de referência 872');


    
    
    --Inserindo usuario
    
    INSERT INTO tb_usuario (id_usuario, nr_cpf, nm_usuario, dt_nascimento, nm_rg, fl_sexo_biologico, ds_email, ds_senha)
    VALUES (1, 77885823240, 'Leonardo Pereira', TO_DATE('1980-11-30', 'YYYY-MM-DD'), '577831867', 'M', 'oliviada-conceicao@example.org', '$3@6Cnu^');
    

    INSERT INTO tb_usuario (id_usuario, nr_cpf, nm_usuario, dt_nascimento, nm_rg, fl_sexo_biologico, ds_email, ds_senha)
    VALUES (2, 23107925310, 'Erick Vieira', TO_DATE('1951-05-26', 'YYYY-MM-DD'), '149960817', 'M', 'dcorreia@example.org', 'c)6H*vEl');     
    

    INSERT INTO tb_usuario (id_usuario, nr_cpf, nm_usuario, dt_nascimento, nm_rg, fl_sexo_biologico, ds_email, ds_senha)
    VALUES (3, 15024663563, 'Guilherme Fogaça', TO_DATE('1951-09-01', 'YYYY-MM-DD'), '683851542', 'F', 'nunesyuri@example.com', '7o%^9Wln');


    INSERT INTO tb_usuario (id_usuario, nr_cpf, nm_usuario, dt_nascimento, nm_rg, fl_sexo_biologico, ds_email, ds_senha)
    VALUES (4, 35129532336, 'Maria Fernanda Cunha', TO_DATE('1932-11-13', 'YYYY-MM-DD'), '825246609', 'M', 'alvesrodrigo@example.com', '@ia6uJXh');


    INSERT INTO tb_usuario (id_usuario, nr_cpf, nm_usuario, dt_nascimento, nm_rg, fl_sexo_biologico, ds_email, ds_senha)
    VALUES (5, 57031061542, 'Daniela Silva', TO_DATE('1941-06-27', 'YYYY-MM-DD'), '34631804', 'F', 'eduardacorreia@example.com', '(w1Z%hbD');


    INSERT INTO tb_usuario (id_usuario, nr_cpf, nm_usuario, dt_nascimento, nm_rg, fl_sexo_biologico, ds_email, ds_senha)
    VALUES (6, 54884477789, 'Sophia da Rocha', TO_DATE('2003-02-12', 'YYYY-MM-DD'), '192176750', 'F', 'da-cunhamaria-vitoria@example.com', '*XY2TO5x');


    INSERT INTO tb_usuario (id_usuario, nr_cpf, nm_usuario, dt_nascimento, nm_rg, fl_sexo_biologico, ds_email, ds_senha)
    VALUES (7, 43500974251, 'Ana Júlia Moura', TO_DATE('1971-04-12', 'YYYY-MM-DD'), '754045442', 'M', 'ibarros@example.org', 'y@l9p(Iy');


    INSERT INTO tb_usuario (id_usuario, nr_cpf, nm_usuario, dt_nascimento, nm_rg, fl_sexo_biologico, ds_email, ds_senha)
    VALUES (8, 11792583010, 'Bárbara Moura', TO_DATE('1960-10-03', 'YYYY-MM-DD'), '334461263', 'M', 'anaaraujo@example.com', '!&qV2Ip)');


    INSERT INTO tb_usuario (id_usuario, nr_cpf, nm_usuario, dt_nascimento, nm_rg, fl_sexo_biologico, ds_email, ds_senha)
    VALUES (9, 55049916240, 'Daniel Cavalcanti', TO_DATE('1956-04-17', 'YYYY-MM-DD'), '984968027', 'F', 'matheusnogueira@example.net', '^0z%G%Hq');


    INSERT INTO tb_usuario (id_usuario, nr_cpf, nm_usuario, dt_nascimento, nm_rg, fl_sexo_biologico, ds_email, ds_senha)
    VALUES (10, 58334130767, 'Maysa Campos', TO_DATE('1993-12-30', 'YYYY-MM-DD'), '434471674', 'F', 'isabel77@example.net', 'u(4yTAe!');


    INSERT INTO tb_usuario (id_usuario, nr_cpf, nm_usuario, dt_nascimento, nm_rg, fl_sexo_biologico, ds_email, ds_senha)
    VALUES (11, 40938134640, 'Yago Rezende', TO_DATE('1994-10-01', 'YYYY-MM-DD'), '939205660', 'F', 'camposnicolas@example.net', '+Z7rPXOe');


    INSERT INTO tb_usuario (id_usuario, nr_cpf, nm_usuario, dt_nascimento, nm_rg, fl_sexo_biologico, ds_email, ds_senha)
    VALUES (12, 97091250781, 'Brenda Campos', TO_DATE('1993-11-16', 'YYYY-MM-DD'), '598181900', 'F', 'da-motaleonardo@example.org', 'kDB!0Vk4');


    INSERT INTO tb_usuario (id_usuario, nr_cpf, nm_usuario, dt_nascimento, nm_rg, fl_sexo_biologico, ds_email, ds_senha)
    VALUES (13, 77651041799, 'Dra. Bianca Nascimento', TO_DATE('1946-12-22', 'YYYY-MM-DD'), '423502189', 'M', 'kamilly64@example.com', 'Z^A3#Qxa');


    INSERT INTO tb_usuario (id_usuario, nr_cpf, nm_usuario, dt_nascimento, nm_rg, fl_sexo_biologico, ds_email, ds_senha)
    VALUES (14, 81887869745, 'Anthony Pires', TO_DATE('1996-03-04', 'YYYY-MM-DD'), '89999891', 'F', 'igorrodrigues@example.com', '2f(1P1rl');


    INSERT INTO tb_usuario (id_usuario, nr_cpf, nm_usuario, dt_nascimento, nm_rg, fl_sexo_biologico, ds_email, ds_senha)
    VALUES (15, 52254192541, 'Maria Eduarda Caldeira', TO_DATE('1996-06-04', 'YYYY-MM-DD'), '548767091', 'F', 'paulo56@example.com', '1v(3Mln#');


    INSERT INTO tb_usuario (id_usuario, nr_cpf, nm_usuario, dt_nascimento, nm_rg, fl_sexo_biologico, ds_email, ds_senha)
    VALUES (16, 85167464716, 'Bruna Santos', TO_DATE('1976-10-04', 'YYYY-MM-DD'), '554897761', 'M', 'bryan48@example.com', '+2Z%u9rm');


    INSERT INTO tb_usuario (id_usuario, nr_cpf, nm_usuario, dt_nascimento, nm_rg, fl_sexo_biologico, ds_email, ds_senha)
    VALUES (17, 25662582298, 'Sr. Luiz Felipe da Cunha', TO_DATE('1954-12-29', 'YYYY-MM-DD'), '843531945', 'F', 'fsilveira@example.com', '(2HAc0lb');


    INSERT INTO tb_usuario (id_usuario, nr_cpf, nm_usuario, dt_nascimento, nm_rg, fl_sexo_biologico, ds_email, ds_senha)
    VALUES (18, 35504341654, 'Ana Lívia Jesus', TO_DATE('1992-06-09', 'YYYY-MM-DD'), '269438904', 'M', 'sofia65@example.org', '#58iaRjs');


    INSERT INTO tb_usuario (id_usuario, nr_cpf, nm_usuario, dt_nascimento, nm_rg, fl_sexo_biologico, ds_email, ds_senha)
    VALUES (19, 32608506113, 'Sarah Ferreira', TO_DATE('1988-02-24', 'YYYY-MM-DD'), '671315768', 'M', 'joao-guilhermeribeiro@example.com', '%4X)!PcT');


    INSERT INTO tb_usuario (id_usuario, nr_cpf, nm_usuario, dt_nascimento, nm_rg, fl_sexo_biologico, ds_email, ds_senha)
    VALUES (20, 42917648785, 'Maria Alice Silveira', TO_DATE('1990-01-05', 'YYYY-MM-DD'), '433759391', 'F', 'wfreitas@example.net', 'M)y^%2Tz');


    INSERT INTO tb_usuario (id_usuario, nr_cpf, nm_usuario, dt_nascimento, nm_rg, fl_sexo_biologico, ds_email, ds_senha)
    VALUES (21, 17441634095, 'Maria Vitória Pires', TO_DATE('2001-05-04', 'YYYY-MM-DD'), '743458453', 'F', 'lorenzoaragao@example.net', '$1Wv80ik');


    INSERT INTO tb_usuario (id_usuario, nr_cpf, nm_usuario, dt_nascimento, nm_rg, fl_sexo_biologico, ds_email, ds_senha)
    VALUES (22, 79632424001, 'Emanuella Rezende', TO_DATE('1966-12-26', 'YYYY-MM-DD'), '349793955', 'M', 'jda-cruz@example.org', ')E5xEwpP');


    INSERT INTO tb_usuario (id_usuario, nr_cpf, nm_usuario, dt_nascimento, nm_rg, fl_sexo_biologico, ds_email, ds_senha)
    VALUES (23, 68204085480, 'Bernardo Rocha', TO_DATE('1964-09-06', 'YYYY-MM-DD'), '861811797', 'M', 'dsilveira@example.org', 'V)2SOa5&');


    INSERT INTO tb_usuario (id_usuario, nr_cpf, nm_usuario, dt_nascimento, nm_rg, fl_sexo_biologico, ds_email, ds_senha)
    VALUES (24, 29519157145, 'Amanda Silva', TO_DATE('1939-02-12', 'YYYY-MM-DD'), '389433008', 'F', 'cunhakamilly@example.org', '!s0C1%g0');


    INSERT INTO tb_usuario (id_usuario, nr_cpf, nm_usuario, dt_nascimento, nm_rg, fl_sexo_biologico, ds_email, ds_senha)
    VALUES (25, 66635721583, 'Ana Laura Cardoso', TO_DATE('1941-12-05', 'YYYY-MM-DD'), '277228459', 'F', 'lopesfernanda@example.com', '$_^67I2t');


    INSERT INTO tb_usuario (id_usuario, nr_cpf, nm_usuario, dt_nascimento, nm_rg, fl_sexo_biologico, ds_email, ds_senha)
    VALUES (26, 77769123661, 'Sra. Helena Barbosa', TO_DATE('1968-09-02', 'YYYY-MM-DD'), '488118437', 'F', 'almeidamiguel@example.org', '$6CB^wDK');


    INSERT INTO tb_usuario (id_usuario, nr_cpf, nm_usuario, dt_nascimento, nm_rg, fl_sexo_biologico, ds_email, ds_senha)
    VALUES (27, 28940124852, 'Dra. Luana Gonçalves', TO_DATE('1986-09-06', 'YYYY-MM-DD'), '842063637', 'F', 'laura17@example.net', '$k37eUl6');


    INSERT INTO tb_usuario (id_usuario, nr_cpf, nm_usuario, dt_nascimento, nm_rg, fl_sexo_biologico, ds_email, ds_senha)
    VALUES (28, 67683940977, 'Srta. Juliana Ferreira', TO_DATE('1941-12-07', 'YYYY-MM-DD'), '877724950', 'F', 'ribeirocecilia@example.com', ')4JJFOsY');


    INSERT INTO tb_usuario (id_usuario, nr_cpf, nm_usuario, dt_nascimento, nm_rg, fl_sexo_biologico, ds_email, ds_senha)
    VALUES (29, 79536631253, 'Ana Clara Souza', TO_DATE('1998-02-27', 'YYYY-MM-DD'), '522859934', 'M', 'uteixeira@example.org', '$n4I!tjl');


    INSERT INTO tb_usuario (id_usuario, nr_cpf, nm_usuario, dt_nascimento, nm_rg, fl_sexo_biologico, ds_email, ds_senha)
    VALUES (30, 29573312791, 'Sr. Kevin Novaes', TO_DATE('1966-07-12', 'YYYY-MM-DD'), '136767370', 'F', 'otaviofogaca@example.net', ')xx!8PlK');


    INSERT INTO tb_usuario (id_usuario, nr_cpf, nm_usuario, dt_nascimento, nm_rg, fl_sexo_biologico, ds_email, ds_senha)
    VALUES (31, 61667070656, 'Carolina Dias', TO_DATE('1942-11-18', 'YYYY-MM-DD'), '765150119', 'F', 'psantos@example.org', 'D+5oPw$q');


    INSERT INTO tb_usuario (id_usuario, nr_cpf, nm_usuario, dt_nascimento, nm_rg, fl_sexo_biologico, ds_email, ds_senha)
    VALUES (32, 98780469658, 'Ana Vitória Araújo', TO_DATE('1996-02-20', 'YYYY-MM-DD'), '573620114', 'F', 'ian90@example.org', '%9Mj17Be');


    INSERT INTO tb_usuario (id_usuario, nr_cpf, nm_usuario, dt_nascimento, nm_rg, fl_sexo_biologico, ds_email, ds_senha)
    VALUES (33, 94798893644, 'João Lucas Castro', TO_DATE('1935-01-27', 'YYYY-MM-DD'), '154030266', 'M', 'juliana25@example.org', '##4ktGKw');


    INSERT INTO tb_usuario (id_usuario, nr_cpf, nm_usuario, dt_nascimento, nm_rg, fl_sexo_biologico, ds_email, ds_senha)
    VALUES (34, 73395306432, 'Augusto da Mata', TO_DATE('1999-11-21', 'YYYY-MM-DD'), '262860315', 'M', 'maria61@example.org', 'gU^$5S8n');


    INSERT INTO tb_usuario (id_usuario, nr_cpf, nm_usuario, dt_nascimento, nm_rg, fl_sexo_biologico, ds_email, ds_senha)
    VALUES (35, 87659501240, 'Lucas Gabriel Peixoto', TO_DATE('1971-02-13', 'YYYY-MM-DD'), '687311733', 'F', 'hbarbosa@example.net', 'Q5(9GIgc');


    INSERT INTO tb_usuario (id_usuario, nr_cpf, nm_usuario, dt_nascimento, nm_rg, fl_sexo_biologico, ds_email, ds_senha)
    VALUES (36, 49967639606, 'Fernanda Almeida', TO_DATE('1970-09-06', 'YYYY-MM-DD'), '282918406', 'M', 'mariamoura@example.net', '%^9Ly__Y');


    INSERT INTO tb_usuario (id_usuario, nr_cpf, nm_usuario, dt_nascimento, nm_rg, fl_sexo_biologico, ds_email, ds_senha)
    VALUES (37, 58877587256, 'Vitor Gabriel Moraes', TO_DATE('1990-10-20', 'YYYY-MM-DD'), '256049367', 'M', 'pietroda-cruz@example.com', '4(I99Q1k');


    INSERT INTO tb_usuario (id_usuario, nr_cpf, nm_usuario, dt_nascimento, nm_rg, fl_sexo_biologico, ds_email, ds_senha)
    VALUES (38, 17417658887, 'Marcelo Ferreira', TO_DATE('1971-08-21', 'YYYY-MM-DD'), '922874258', 'F', 'rodrigosales@example.net', '#*Hf9KeS');


    INSERT INTO tb_usuario (id_usuario, nr_cpf, nm_usuario, dt_nascimento, nm_rg, fl_sexo_biologico, ds_email, ds_senha)
    VALUES (39, 65739891899, 'Vicente Oliveira', TO_DATE('1975-06-23', 'YYYY-MM-DD'), '617024087', 'M', 'falmeida@example.net', '%!0ACH*a');


    INSERT INTO tb_usuario (id_usuario, nr_cpf, nm_usuario, dt_nascimento, nm_rg, fl_sexo_biologico, ds_email, ds_senha)
    VALUES (40, 70883172079, 'Lucca Carvalho', TO_DATE('1952-03-10', 'YYYY-MM-DD'), '444716443', 'M', 'bcostela@example.net', '4O(c7VNp');


    INSERT INTO tb_usuario (id_usuario, nr_cpf, nm_usuario, dt_nascimento, nm_rg, fl_sexo_biologico, ds_email, ds_senha)
    VALUES (41, 85324304432, 'Ana Carolina Novaes', TO_DATE('1963-11-15', 'YYYY-MM-DD'), '784561155', 'F', 'cunhaemanuelly@example.org', '$)4IbsgU');


    INSERT INTO tb_usuario (id_usuario, nr_cpf, nm_usuario, dt_nascimento, nm_rg, fl_sexo_biologico, ds_email, ds_senha)
    VALUES (42, 41941779983, 'Pedro Fogaça', TO_DATE('1946-04-06', 'YYYY-MM-DD'), '441830444', 'M', 'da-conceicaoana-carolina@example.com', '_t^wx1Et');


    INSERT INTO tb_usuario (id_usuario, nr_cpf, nm_usuario, dt_nascimento, nm_rg, fl_sexo_biologico, ds_email, ds_senha)
    VALUES (43, 84152714167, 'Augusto Castro', TO_DATE('1980-12-08', 'YYYY-MM-DD'), '921653295', 'F', 'luiz-gustavo63@example.org', '!3Ax7jqj');


    INSERT INTO tb_usuario (id_usuario, nr_cpf, nm_usuario, dt_nascimento, nm_rg, fl_sexo_biologico, ds_email, ds_senha)
    VALUES (44, 69627478652, 'Clara da Mota', TO_DATE('2000-01-12', 'YYYY-MM-DD'), '545781485', 'M', 'esther53@example.org', 'q%W5WkbE');


    INSERT INTO tb_usuario (id_usuario, nr_cpf, nm_usuario, dt_nascimento, nm_rg, fl_sexo_biologico, ds_email, ds_senha)
    VALUES (45, 90597850293, 'Guilherme Nogueira', TO_DATE('1988-04-12', 'YYYY-MM-DD'), '131740016', 'F', 'kda-rocha@example.com', '*!8Guern');


    INSERT INTO tb_usuario (id_usuario, nr_cpf, nm_usuario, dt_nascimento, nm_rg, fl_sexo_biologico, ds_email, ds_senha)
    VALUES (46, 17807730524, 'Carolina Teixeira', TO_DATE('1957-07-24', 'YYYY-MM-DD'), '421108482', 'F', 'luiz-felipe29@example.com', 'V8s^8Awq');

    
    
    INSERT INTO tb_endereco_usuario (id_usuario, id_logradouro, id_end_usuario, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (828, 10, 828, 8083, NULL, 'Ponto de referencia 828');


    INSERT INTO tb_endereco_usuario (id_usuario, id_logradouro, id_end_usuario, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (1, 36, 829, 9057, NULL, NULL);


    INSERT INTO tb_endereco_usuario (id_usuario, id_logradouro, id_end_usuario, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (2, 28, 830, 1004, NULL, NULL);


    INSERT INTO tb_endereco_usuario (id_usuario, id_logradouro, id_end_usuario, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (3, 41, 831, 3314, NULL, 'Ponto de referencia 831');


    INSERT INTO tb_endereco_usuario (id_usuario, id_logradouro, id_end_usuario, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (4, 43, 832, 9827, 'APTO 79', 'Ponto de referencia 832');


    INSERT INTO tb_endereco_usuario (id_usuario, id_logradouro, id_end_usuario, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (5, 37, 833, 3047, 'APTO 68', NULL);


    INSERT INTO tb_endereco_usuario (id_usuario, id_logradouro, id_end_usuario, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (6, 19, 834, 5395, NULL, NULL);


    INSERT INTO tb_endereco_usuario (id_usuario, id_logradouro, id_end_usuario, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (7, 31, 835, 7605, 'APTO 57', 'Ponto de referencia 835');


    INSERT INTO tb_endereco_usuario (id_usuario, id_logradouro, id_end_usuario, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (8, 8, 836, 6170, NULL, NULL);


    INSERT INTO tb_endereco_usuario (id_usuario, id_logradouro, id_end_usuario, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (9, 36, 837, 7741, NULL, NULL);


    INSERT INTO tb_endereco_usuario (id_usuario, id_logradouro, id_end_usuario, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (10, 20, 838, 9517, NULL, NULL);


    INSERT INTO tb_endereco_usuario (id_usuario, id_logradouro, id_end_usuario, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (11, 41, 839, 939, 'APTO 74', 'Ponto de referencia 839');


    INSERT INTO tb_endereco_usuario (id_usuario, id_logradouro, id_end_usuario, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (12, 5, 840, 1741, NULL, NULL);


    INSERT INTO tb_endereco_usuario (id_usuario, id_logradouro, id_end_usuario, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (13, 43, 841, 359, NULL, NULL);


    INSERT INTO tb_endereco_usuario (id_usuario, id_logradouro, id_end_usuario, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (14, 22, 842, 6917, 'APTO 49', 'Ponto de referencia 842');


    INSERT INTO tb_endereco_usuario (id_usuario, id_logradouro, id_end_usuario, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (15, 19, 843, 2064, NULL, 'Ponto de referencia 843');


    INSERT INTO tb_endereco_usuario (id_usuario, id_logradouro, id_end_usuario, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (16, 30, 844, 7771, NULL, NULL);


    INSERT INTO tb_endereco_usuario (id_usuario, id_logradouro, id_end_usuario, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (17, 36, 845, 9164, 'APTO 22', NULL);


    INSERT INTO tb_endereco_usuario (id_usuario, id_logradouro, id_end_usuario, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (18, 15, 846, 7853, NULL, 'Ponto de referencia 846');


    INSERT INTO tb_endereco_usuario (id_usuario, id_logradouro, id_end_usuario, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (19, 32, 847, 8266, 'APTO 4', NULL);


    INSERT INTO tb_endereco_usuario (id_usuario, id_logradouro, id_end_usuario, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (20, 7, 848, 6644, 'APTO 41', NULL);


    INSERT INTO tb_endereco_usuario (id_usuario, id_logradouro, id_end_usuario, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (21, 29, 849, 4177, NULL, NULL);


    INSERT INTO tb_endereco_usuario (id_usuario, id_logradouro, id_end_usuario, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (22, 41, 850, 6188, 'APTO 85', NULL);


    INSERT INTO tb_endereco_usuario (id_usuario, id_logradouro, id_end_usuario, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (23, 35, 851, 2986, NULL, 'Ponto de referencia 851');


    INSERT INTO tb_endereco_usuario (id_usuario, id_logradouro, id_end_usuario, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (24, 39, 852, 5826, NULL, NULL);


    INSERT INTO tb_endereco_usuario (id_usuario, id_logradouro, id_end_usuario, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (25, 25, 853, 8671, 'APTO 51', 'Ponto de referencia 853');


    INSERT INTO tb_endereco_usuario (id_usuario, id_logradouro, id_end_usuario, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (26, 41, 854, 7415, NULL, NULL);


    INSERT INTO tb_endereco_usuario (id_usuario, id_logradouro, id_end_usuario, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (27, 7, 855, 3382, 'APTO 10', 'Ponto de referencia 855');


    INSERT INTO tb_endereco_usuario (id_usuario, id_logradouro, id_end_usuario, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (28, 43, 856, 4407, NULL, NULL);


    INSERT INTO tb_endereco_usuario (id_usuario, id_logradouro, id_end_usuario, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (29, 38, 857, 5456, NULL, 'Ponto de referencia 857');


    INSERT INTO tb_endereco_usuario (id_usuario, id_logradouro, id_end_usuario, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (30, 30, 858, 8068, 'APTO 28', 'Ponto de referencia 858');


    INSERT INTO tb_endereco_usuario (id_usuario, id_logradouro, id_end_usuario, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (31, 9, 859, 3204, NULL, 'Ponto de referencia 859');


    INSERT INTO tb_endereco_usuario (id_usuario, id_logradouro, id_end_usuario, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (32, 46, 860, 6446, NULL, 'Ponto de referencia 860');


    INSERT INTO tb_endereco_usuario (id_usuario, id_logradouro, id_end_usuario, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (33, 41, 861, 3203, 'APTO 33', 'Ponto de referencia 861');


    INSERT INTO tb_endereco_usuario (id_usuario, id_logradouro, id_end_usuario, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (34, 23, 862, 9858, 'APTO 61', NULL);


    INSERT INTO tb_endereco_usuario (id_usuario, id_logradouro, id_end_usuario, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (35, 32, 863, 9768, 'APTO 98', NULL);


    INSERT INTO tb_endereco_usuario (id_usuario, id_logradouro, id_end_usuario, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (36, 31, 864, 1814, 'APTO 24', 'Ponto de referencia 864');


    INSERT INTO tb_endereco_usuario (id_usuario, id_logradouro, id_end_usuario, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (37, 36, 865, 1511, NULL, NULL);


    INSERT INTO tb_endereco_usuario (id_usuario, id_logradouro, id_end_usuario, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (38, 14, 866, 7454, NULL, 'Ponto de referencia 866');


    INSERT INTO tb_endereco_usuario (id_usuario, id_logradouro, id_end_usuario, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (39, 40, 867, 8813, NULL, NULL);


    INSERT INTO tb_endereco_usuario (id_usuario, id_logradouro, id_end_usuario, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (40, 31, 868, 3781, NULL, 'Ponto de referencia 868');


    INSERT INTO tb_endereco_usuario (id_usuario, id_logradouro, id_end_usuario, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (41, 41, 869, 3047, 'APTO 55', 'Ponto de referencia 869');


    INSERT INTO tb_endereco_usuario (id_usuario, id_logradouro, id_end_usuario, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (12, 33, 870, 6683, NULL, NULL);


    INSERT INTO tb_endereco_usuario (id_usuario, id_logradouro, id_end_usuario, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (43, 7, 871, 9766, NULL, NULL);


    INSERT INTO tb_endereco_usuario (id_usuario, id_logradouro, id_end_usuario, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (44, 22, 872, 6551, NULL, 'Ponto de referencia 872');


    INSERT INTO tb_endereco_usuario (id_usuario, id_logradouro, id_end_usuario, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (45, 35, 873, 4974, 'APTO 94', NULL);


    INSERT INTO tb_endereco_usuario (id_usuario, id_logradouro, id_end_usuario, nr_logradouro, ds_complemento_numero, ds_ponto_referencia)
    VALUES (46, 5, 874, 6104, 'APTO 40', 'Ponto de referencia 874');


    


    -- inseridno Motorista 

    
    
    INSERT INTO tb_guincho (id_guincho, tp_guincho, nm_guincho, nr_guincho)
    VALUES (1, 1, 'Guincho de cabo de aço', 7312892);
    

    INSERT INTO tb_guincho (id_guincho, tp_guincho, nm_guincho, nr_guincho)
    VALUES (2, 1, 'Guincho hidráulico', 3079391);
    

    INSERT INTO tb_guincho (id_guincho, tp_guincho, nm_guincho, nr_guincho)
    VALUES (3, 1, 'Guincho elétrico', 2624684);


    INSERT INTO tb_guincho (id_guincho, tp_guincho, nm_guincho, nr_guincho)
    VALUES (4, 1, 'Guincho de corrente', 8591134);


    INSERT INTO tb_guincho (id_guincho, tp_guincho, nm_guincho, nr_guincho)
    VALUES (5, 1, 'Guincho de tambor', 1657098);


    INSERT INTO tb_guincho (id_guincho, tp_guincho, nm_guincho, nr_guincho)
    VALUES (6, 1, 'Guincho de reboque', 1185525);


    INSERT INTO tb_guincho (id_guincho, tp_guincho, nm_guincho, nr_guincho)
    VALUES (7, 1, 'Guincho de plataforma', 2791860);


    INSERT INTO tb_guincho (id_guincho, tp_guincho, nm_guincho, nr_guincho)
    VALUES (8, 1, 'Guincho de rolo', 2807054);


    INSERT INTO tb_guincho (id_guincho, tp_guincho, nm_guincho, nr_guincho)
    VALUES (9, 1, 'Guincho de polia dupla', 3012215);


    INSERT INTO tb_guincho (id_guincho, tp_guincho, nm_guincho, nr_guincho)
    VALUES (10, 1, 'Guincho de rotação', 8780029);


    INSERT INTO tb_guincho (id_guincho, tp_guincho, nm_guincho, nr_guincho)
    VALUES (11, 1, 'Guincho de controle remoto', 4732244);


    INSERT INTO tb_guincho (id_guincho, tp_guincho, nm_guincho, nr_guincho)
    VALUES (12, 1, 'Guincho de emergência', 4720138);


    INSERT INTO tb_guincho (id_guincho, tp_guincho, nm_guincho, nr_guincho)
    VALUES (13, 1, 'Guincho para veículos todo-terreno (ATV)', 9852354);


    INSERT INTO tb_guincho (id_guincho, tp_guincho, nm_guincho, nr_guincho)
    VALUES (14, 1, 'Guincho para barcos', 7010905);


    INSERT INTO tb_guincho (id_guincho, tp_guincho, nm_guincho, nr_guincho)
    VALUES (15, 1, 'Guincho de acionamento manual', 1810238);


    INSERT INTO tb_guincho (id_guincho, tp_guincho, nm_guincho, nr_guincho)
    VALUES (16, 1, 'Guincho de veículo de serviço', 4657766);


    INSERT INTO tb_guincho (id_guincho, tp_guincho, nm_guincho, nr_guincho)
    VALUES (17, 1, 'Guincho de lança', 6404244);


    INSERT INTO tb_guincho (id_guincho, tp_guincho, nm_guincho, nr_guincho)
    VALUES (18, 1, 'Guincho de recuperação', 2852823);


    INSERT INTO tb_guincho (id_guincho, tp_guincho, nm_guincho, nr_guincho)
    VALUES (19, 1, 'Guincho de torre', 1869759);


    INSERT INTO tb_guincho (id_guincho, tp_guincho, nm_guincho, nr_guincho)
    VALUES (20, 1, 'Guincho de arraste', 1208315);


    INSERT INTO tb_guincho (id_guincho, tp_guincho, nm_guincho, nr_guincho)
    VALUES (21, 1, 'Guincho de elevação', 2711324);


    INSERT INTO tb_guincho (id_guincho, tp_guincho, nm_guincho, nr_guincho)
    VALUES (22, 1, 'Guincho de pára-choque', 3164284);


    INSERT INTO tb_guincho (id_guincho, tp_guincho, nm_guincho, nr_guincho)
    VALUES (23, 1, 'Guincho de montagem frontal', 8376943);


    INSERT INTO tb_guincho (id_guincho, tp_guincho, nm_guincho, nr_guincho)
    VALUES (24, 1, 'Guincho para caminhões pesados', 8344839);


    INSERT INTO tb_guincho (id_guincho, tp_guincho, nm_guincho, nr_guincho)
    VALUES (25, 1, 'Guincho industrial', 9217076);


    INSERT INTO tb_guincho (id_guincho, tp_guincho, nm_guincho, nr_guincho)
    VALUES (26, 1, 'Guincho de cabo sintético', 6519319);


    INSERT INTO tb_guincho (id_guincho, tp_guincho, nm_guincho, nr_guincho)
    VALUES (27, 1, 'Guincho de resgate', 1278383);


    INSERT INTO tb_guincho (id_guincho, tp_guincho, nm_guincho, nr_guincho)
    VALUES (28, 1, 'Guincho para mineração', 1192500);


    INSERT INTO tb_guincho (id_guincho, tp_guincho, nm_guincho, nr_guincho)
    VALUES (29, 1, 'Guincho para construção', 3952761);


    INSERT INTO tb_guincho (id_guincho, tp_guincho, nm_guincho, nr_guincho)
    VALUES (30, 1, 'Guincho de auto carregamento', 1329494);


    INSERT INTO tb_guincho (id_guincho, tp_guincho, nm_guincho, nr_guincho)
    VALUES (31, 1, 'Guincho para serviço pesado', 3649429);


    INSERT INTO tb_guincho (id_guincho, tp_guincho, nm_guincho, nr_guincho)
    VALUES (32, 1, 'Guincho de cabo de fibra', 7124757);


    INSERT INTO tb_guincho (id_guincho, tp_guincho, nm_guincho, nr_guincho)
    VALUES (33, 1, 'Guincho de elevação lateral', 3885671);


    INSERT INTO tb_guincho (id_guincho, tp_guincho, nm_guincho, nr_guincho)
    VALUES (34, 1, 'Guincho de tambor duplo', 6742644);


    INSERT INTO tb_guincho (id_guincho, tp_guincho, nm_guincho, nr_guincho)
    VALUES (35, 1, 'Guincho de controle automático', 5312013);


    INSERT INTO tb_guincho (id_guincho, tp_guincho, nm_guincho, nr_guincho)
    VALUES (36, 1, 'Guincho de plataforma deslizante', 1657435);


    INSERT INTO tb_guincho (id_guincho, tp_guincho, nm_guincho, nr_guincho)
    VALUES (37, 1, 'Guincho de alta capacidade', 3934622);


    INSERT INTO tb_guincho (id_guincho, tp_guincho, nm_guincho, nr_guincho)
    VALUES (38, 1, 'Guincho de tração', 9900384);


    INSERT INTO tb_guincho (id_guincho, tp_guincho, nm_guincho, nr_guincho)
    VALUES (39, 1, 'Guincho para veículos de emergência', 8985591);


    INSERT INTO tb_guincho (id_guincho, tp_guincho, nm_guincho, nr_guincho)
    VALUES (40, 1, 'Guincho de resgate florestal', 2733678);


    INSERT INTO tb_guincho (id_guincho, tp_guincho, nm_guincho, nr_guincho)
    VALUES (41, 1, 'Guincho de uso militar', 9634102);


    INSERT INTO tb_guincho (id_guincho, tp_guincho, nm_guincho, nr_guincho)
    VALUES (42, 1, 'Guincho para veículos de recreação', 6373399);


    INSERT INTO tb_guincho (id_guincho, tp_guincho, nm_guincho, nr_guincho)
    VALUES (43, 1, 'Guincho para transporte de carga', 5940186);


    INSERT INTO tb_guincho (id_guincho, tp_guincho, nm_guincho, nr_guincho)
    VALUES (44, 1, 'Guincho de roda', 6591668);


    INSERT INTO tb_guincho (id_guincho, tp_guincho, nm_guincho, nr_guincho)
    VALUES (45, 1, 'Guincho de plataforma giratória', 2836138);


    INSERT INTO tb_guincho (id_guincho, tp_guincho, nm_guincho, nr_guincho)
    VALUES (46, 1, 'Guincho de câmara de ar', 9930240);


    INSERT INTO tb_guincho (id_guincho, tp_guincho, nm_guincho, nr_guincho)
    VALUES (47, 1, 'Guincho de controle por joystick', 7614063);


    INSERT INTO tb_guincho (id_guincho, tp_guincho, nm_guincho, nr_guincho)
    VALUES (48, 1, 'Guincho para veículos off-road', 5444874);


    INSERT INTO tb_guincho (id_guincho, tp_guincho, nm_guincho, nr_guincho)
    VALUES (49, 1, 'Guincho de controle de velocidade variável', 1604887);


    INSERT INTO tb_guincho (id_guincho, tp_guincho, nm_guincho, nr_guincho)
    VALUES (50, 1, 'Guincho para veículos de serviço público', 3268869);
    


    -- inserindo Motorista
    INSERT INTO tb__motorista (id_motorista, id_guincho, nm_motorista, cd_motorista, nr_cnh, nm_categoria_cnh, dt_validade_cnh)
    VALUES (1, 1, 'Júlia Souza', '13168', '60311907378', 'B', TO_DATE('2024-04-26', 'YYYY-MM-DD'));
    

    INSERT INTO tb__motorista (id_motorista, id_guincho, nm_motorista, cd_motorista, nr_cnh, nm_categoria_cnh, dt_validade_cnh)
    VALUES (2, 2, 'Vitor Azevedo', '79765', '94134560313', 'C', TO_DATE('2023-07-10', 'YYYY-MM-DD'));
    

    INSERT INTO tb__motorista (id_motorista, id_guincho, nm_motorista, cd_motorista, nr_cnh, nm_categoria_cnh, dt_validade_cnh)
    VALUES (3, 3, 'Ian das Neves', '91861', '2215448193', 'C', TO_DATE('2023-02-19', 'YYYY-MM-DD'));


    INSERT INTO tb__motorista (id_motorista, id_guincho, nm_motorista, cd_motorista, nr_cnh, nm_categoria_cnh, dt_validade_cnh)
    VALUES (4, 4, 'Maria da Rosa', '95765', '26883755572', 'A', TO_DATE('2023-05-11', 'YYYY-MM-DD'));


    INSERT INTO tb__motorista (id_motorista, id_guincho, nm_motorista, cd_motorista, nr_cnh, nm_categoria_cnh, dt_validade_cnh)
    VALUES (5, 5, 'Helena da Rocha', '74315', '87298318341', 'E', TO_DATE('2025-06-16', 'YYYY-MM-DD'));


    INSERT INTO tb__motorista (id_motorista, id_guincho, nm_motorista, cd_motorista, nr_cnh, nm_categoria_cnh, dt_validade_cnh)
    VALUES (6, 6, 'Pedro Lucas Castro', '65564', '28966776738', 'E', TO_DATE('2023-12-29', 'YYYY-MM-DD'));


    INSERT INTO tb__motorista (id_motorista, id_guincho, nm_motorista, cd_motorista, nr_cnh, nm_categoria_cnh, dt_validade_cnh)
    VALUES (7, 7, 'Dr. Rodrigo Rocha', '90525', '95666124010', 'B', TO_DATE('2024-08-24', 'YYYY-MM-DD'));


    INSERT INTO tb__motorista (id_motorista, id_guincho, nm_motorista, cd_motorista, nr_cnh, nm_categoria_cnh, dt_validade_cnh)
    VALUES (8, 8, 'Pietro da Mata', '36827', '16440809801', 'A', TO_DATE('2025-06-21', 'YYYY-MM-DD'));


    INSERT INTO tb__motorista (id_motorista, id_guincho, nm_motorista, cd_motorista, nr_cnh, nm_categoria_cnh, dt_validade_cnh)
    VALUES (9, 9, 'Nathan Nascimento', '17781', '1655016256', 'E', TO_DATE('2025-04-16', 'YYYY-MM-DD'));


    INSERT INTO tb__motorista (id_motorista, id_guincho, nm_motorista, cd_motorista, nr_cnh, nm_categoria_cnh, dt_validade_cnh)
    VALUES (10, 10, 'Augusto Santos', '45870', '90247944364', 'E', TO_DATE('2024-05-11', 'YYYY-MM-DD'));


    INSERT INTO tb__motorista (id_motorista, id_guincho, nm_motorista, cd_motorista, nr_cnh, nm_categoria_cnh, dt_validade_cnh)
    VALUES (11, 11, 'Maria Julia Monteiro', '66587', '62401572890', 'B', TO_DATE('2024-01-02', 'YYYY-MM-DD'));


    INSERT INTO tb__motorista (id_motorista, id_guincho, nm_motorista, cd_motorista, nr_cnh, nm_categoria_cnh, dt_validade_cnh)
    VALUES (12, 12, 'Kevin Silva', '57283', '84017409686', 'A', TO_DATE('2025-05-28', 'YYYY-MM-DD'));


    INSERT INTO tb__motorista (id_motorista, id_guincho, nm_motorista, cd_motorista, nr_cnh, nm_categoria_cnh, dt_validade_cnh)
    VALUES (13, 13, 'Sophie da Paz', '12549', '43790205731', 'A', TO_DATE('2025-11-04', 'YYYY-MM-DD'));


    INSERT INTO tb__motorista (id_motorista, id_guincho, nm_motorista, cd_motorista, nr_cnh, nm_categoria_cnh, dt_validade_cnh)
    VALUES (14, 14, 'Laura Cardoso', '13600', '51781035867', 'C', TO_DATE('2025-10-27', 'YYYY-MM-DD'));


    INSERT INTO tb__motorista (id_motorista, id_guincho, nm_motorista, cd_motorista, nr_cnh, nm_categoria_cnh, dt_validade_cnh)
    VALUES (15, 15, 'Sra. Carolina Lopes', '24002', '69172762306', 'E', TO_DATE('2023-09-22', 'YYYY-MM-DD'));


    INSERT INTO tb__motorista (id_motorista, id_guincho, nm_motorista, cd_motorista, nr_cnh, nm_categoria_cnh, dt_validade_cnh)
    VALUES (16, 16, 'Alexia Alves', '257', '5743305229', 'E', TO_DATE('2023-08-05', 'YYYY-MM-DD'));


    INSERT INTO tb__motorista (id_motorista, id_guincho, nm_motorista, cd_motorista, nr_cnh, nm_categoria_cnh, dt_validade_cnh)
    VALUES (17, 17, 'Cecília Martins', '56029', '47508816050', 'D', TO_DATE('2023-07-22', 'YYYY-MM-DD'));


    INSERT INTO tb__motorista (id_motorista, id_guincho, nm_motorista, cd_motorista, nr_cnh, nm_categoria_cnh, dt_validade_cnh)
    VALUES (18, 18, 'Maria Luiza da Rocha', '14360', '7004215696', 'E', TO_DATE('2025-04-27', 'YYYY-MM-DD'));


    INSERT INTO tb__motorista (id_motorista, id_guincho, nm_motorista, cd_motorista, nr_cnh, nm_categoria_cnh, dt_validade_cnh)
    VALUES (19, 19, 'Enzo da Conceição', '93368', '70149670829', 'D', TO_DATE('2023-11-03', 'YYYY-MM-DD'));


    INSERT INTO tb__motorista (id_motorista, id_guincho, nm_motorista, cd_motorista, nr_cnh, nm_categoria_cnh, dt_validade_cnh)
    VALUES (20, 20, 'Otávio Alves', '19502', '69364216613', 'B', TO_DATE('2023-07-12', 'YYYY-MM-DD'));


    INSERT INTO tb__motorista (id_motorista, id_guincho, nm_motorista, cd_motorista, nr_cnh, nm_categoria_cnh, dt_validade_cnh)
    VALUES (21, 21, 'Maria Luiza Monteiro', '20065', '70061749235', 'D', TO_DATE('2024-05-16', 'YYYY-MM-DD'));


    INSERT INTO tb__motorista (id_motorista, id_guincho, nm_motorista, cd_motorista, nr_cnh, nm_categoria_cnh, dt_validade_cnh)
    VALUES (22, 22, 'Maria Luiza Novaes', '76026', '88896337936', 'E', TO_DATE('2025-12-18', 'YYYY-MM-DD'));


    INSERT INTO tb__motorista (id_motorista, id_guincho, nm_motorista, cd_motorista, nr_cnh, nm_categoria_cnh, dt_validade_cnh)
    VALUES (23, 23, 'Matheus Campos', '71360', '55944765959', 'C', TO_DATE('2023-09-18', 'YYYY-MM-DD'));


    INSERT INTO tb__motorista (id_motorista, id_guincho, nm_motorista, cd_motorista, nr_cnh, nm_categoria_cnh, dt_validade_cnh)
    VALUES (24, 24, 'Maria Sophia Cavalcanti', '74218', '97614053192', 'B', TO_DATE('2025-07-30', 'YYYY-MM-DD'));


    INSERT INTO tb__motorista (id_motorista, id_guincho, nm_motorista, cd_motorista, nr_cnh, nm_categoria_cnh, dt_validade_cnh)
    VALUES (25, 25, 'Vitor Correia', '67699', '6014197702', 'C', TO_DATE('2025-04-26', 'YYYY-MM-DD'));


    INSERT INTO tb__motorista (id_motorista, id_guincho, nm_motorista, cd_motorista, nr_cnh, nm_categoria_cnh, dt_validade_cnh)
    VALUES (26, 26, 'Heitor das Neves', '1643', '93012180491', 'A', TO_DATE('2024-10-09', 'YYYY-MM-DD'));


    INSERT INTO tb__motorista (id_motorista, id_guincho, nm_motorista, cd_motorista, nr_cnh, nm_categoria_cnh, dt_validade_cnh)
    VALUES (27, 27, 'Luiz Fernando Duarte', '36110', '86182866633', 'E', TO_DATE('2023-11-27', 'YYYY-MM-DD'));


    INSERT INTO tb__motorista (id_motorista, id_guincho, nm_motorista, cd_motorista, nr_cnh, nm_categoria_cnh, dt_validade_cnh)
    VALUES (28, 28, 'Sr. Otávio da Rosa', '95938', '22035025915', 'D', TO_DATE('2024-12-25', 'YYYY-MM-DD'));


    INSERT INTO tb__motorista (id_motorista, id_guincho, nm_motorista, cd_motorista, nr_cnh, nm_categoria_cnh, dt_validade_cnh)
    VALUES (29, 29, 'Pedro Costa', '93501', '68245930922', 'B', TO_DATE('2025-12-09', 'YYYY-MM-DD'));


    INSERT INTO tb__motorista (id_motorista, id_guincho, nm_motorista, cd_motorista, nr_cnh, nm_categoria_cnh, dt_validade_cnh)
    VALUES (30, 30, 'Marina da Luz', '84632', '81710290789', 'C', TO_DATE('2025-02-12', 'YYYY-MM-DD'));


    INSERT INTO tb__motorista (id_motorista, id_guincho, nm_motorista, cd_motorista, nr_cnh, nm_categoria_cnh, dt_validade_cnh)
    VALUES (31, 31, 'Alexandre Rezende', '12962', '96099962586', 'A', TO_DATE('2025-03-23', 'YYYY-MM-DD'));


    INSERT INTO tb__motorista (id_motorista, id_guincho, nm_motorista, cd_motorista, nr_cnh, nm_categoria_cnh, dt_validade_cnh)
    VALUES (32, 32, 'João Nascimento', '39324', '95287008789', 'C', TO_DATE('2024-07-10', 'YYYY-MM-DD'));


    INSERT INTO tb__motorista (id_motorista, id_guincho, nm_motorista, cd_motorista, nr_cnh, nm_categoria_cnh, dt_validade_cnh)
    VALUES (33, 33, 'Fernando Ferreira', '36786', '31183071007', 'B', TO_DATE('2023-09-02', 'YYYY-MM-DD'));


    INSERT INTO tb__motorista (id_motorista, id_guincho, nm_motorista, cd_motorista, nr_cnh, nm_categoria_cnh, dt_validade_cnh)
    VALUES (34, 34, 'Davi Lucca da Mata', '49793', '51070282066', 'E', TO_DATE('2023-11-28', 'YYYY-MM-DD'));


    INSERT INTO tb__motorista (id_motorista, id_guincho, nm_motorista, cd_motorista, nr_cnh, nm_categoria_cnh, dt_validade_cnh)
    VALUES (35, 35, 'João Gabriel das Neves', '63831', '85824177934', 'C', TO_DATE('2025-06-25', 'YYYY-MM-DD'));


    INSERT INTO tb__motorista (id_motorista, id_guincho, nm_motorista, cd_motorista, nr_cnh, nm_categoria_cnh, dt_validade_cnh)
    VALUES (36, 36, 'Sra. Lorena Souza', '78504', '46624526792', 'A', TO_DATE('2023-07-11', 'YYYY-MM-DD'));


    INSERT INTO tb__motorista (id_motorista, id_guincho, nm_motorista, cd_motorista, nr_cnh, nm_categoria_cnh, dt_validade_cnh)
    VALUES (37, 37, 'Sofia Souza', '3085', '64993180045', 'B', TO_DATE('2025-01-06', 'YYYY-MM-DD'));


    INSERT INTO tb__motorista (id_motorista, id_guincho, nm_motorista, cd_motorista, nr_cnh, nm_categoria_cnh, dt_validade_cnh)
    VALUES (38, 38, 'Kamilly Oliveira', '51629', '22489303846', 'D', TO_DATE('2024-12-05', 'YYYY-MM-DD'));


    INSERT INTO tb__motorista (id_motorista, id_guincho, nm_motorista, cd_motorista, nr_cnh, nm_categoria_cnh, dt_validade_cnh)
    VALUES (39, 39, 'Alexandre Fogaça', '75840', '74444129919', 'E', TO_DATE('2025-11-04', 'YYYY-MM-DD'));


    INSERT INTO tb__motorista (id_motorista, id_guincho, nm_motorista, cd_motorista, nr_cnh, nm_categoria_cnh, dt_validade_cnh)
    VALUES (40, 40, 'Yasmin Cardoso', '84763', '84610263960', 'B', TO_DATE('2023-10-14', 'YYYY-MM-DD'));


    INSERT INTO tb__motorista (id_motorista, id_guincho, nm_motorista, cd_motorista, nr_cnh, nm_categoria_cnh, dt_validade_cnh)
    VALUES (41, 41, 'Catarina Moreira', '43277', '99024532389', 'A', TO_DATE('2024-12-15', 'YYYY-MM-DD'));


    INSERT INTO tb__motorista (id_motorista, id_guincho, nm_motorista, cd_motorista, nr_cnh, nm_categoria_cnh, dt_validade_cnh)
    VALUES (42, 42, 'Sofia Vieira', '13255', '77688945624', 'A', TO_DATE('2024-05-15', 'YYYY-MM-DD'));


    INSERT INTO tb__motorista (id_motorista, id_guincho, nm_motorista, cd_motorista, nr_cnh, nm_categoria_cnh, dt_validade_cnh)
    VALUES (43, 43, 'Ana Beatriz da Rosa', '90321', '53667948575', 'C', TO_DATE('2023-09-13', 'YYYY-MM-DD'));


    INSERT INTO tb__motorista (id_motorista, id_guincho, nm_motorista, cd_motorista, nr_cnh, nm_categoria_cnh, dt_validade_cnh)
    VALUES (44, 44, 'Lara Caldeira', '28162', '56940683508', 'B', TO_DATE('2025-11-05', 'YYYY-MM-DD'));


    INSERT INTO tb__motorista (id_motorista, id_guincho, nm_motorista, cd_motorista, nr_cnh, nm_categoria_cnh, dt_validade_cnh)
    VALUES (45, 45, 'Emanuelly Azevedo', '8297', '41063716234', 'E', TO_DATE('2023-02-16', 'YYYY-MM-DD'));


    INSERT INTO tb__motorista (id_motorista, id_guincho, nm_motorista, cd_motorista, nr_cnh, nm_categoria_cnh, dt_validade_cnh)
    VALUES (46, 46, 'Diogo Gomes', '18093', '28663168259', 'D', TO_DATE('2023-09-17', 'YYYY-MM-DD'));


    INSERT INTO tb__motorista (id_motorista, id_guincho, nm_motorista, cd_motorista, nr_cnh, nm_categoria_cnh, dt_validade_cnh)
    VALUES (47, 47, 'Lucca Martins', '11724', '98667430939', 'D', TO_DATE('2025-08-25', 'YYYY-MM-DD'));


    INSERT INTO tb__motorista (id_motorista, id_guincho, nm_motorista, cd_motorista, nr_cnh, nm_categoria_cnh, dt_validade_cnh)
    VALUES (48, 48, 'Srta. Alice Peixoto', '74525', '48037869293', 'D', TO_DATE('2023-01-12', 'YYYY-MM-DD'));


    INSERT INTO tb__motorista (id_motorista, id_guincho, nm_motorista, cd_motorista, nr_cnh, nm_categoria_cnh, dt_validade_cnh)
    VALUES (49, 49, 'Vicente Lima', '94216', '94895705149', 'E', TO_DATE('2025-01-03', 'YYYY-MM-DD'));


    INSERT INTO tb__motorista (id_motorista, id_guincho, nm_motorista, cd_motorista, nr_cnh, nm_categoria_cnh, dt_validade_cnh)
    VALUES (50, 50, 'Francisco Mendes', '60545', '28199129583', 'E', TO_DATE('2025-05-27', 'YYYY-MM-DD'));

    
    
    -- inserindo veículos
    
    INSERT INTO tb_veiculo (id_veiculo, tp_veiculo, dt_fabrica, nr_eixo, nr_peso, nr_altura, nr_comprimento, tp_chassi, dt_inicio, dt_fim)
    VALUES (1, 'Trator', TO_DATE('2011-01-01', 'YYYY-MM-DD'), 8, 18842, 399, 733, 2, TO_DATE('2005-01-01', 'YYYY-MM-DD'), TO_DATE('2027-01-01', 'YYYY-MM-DD'));
    

    INSERT INTO tb_veiculo (id_veiculo, tp_veiculo, dt_fabrica, nr_eixo, nr_peso, nr_altura, nr_comprimento, tp_chassi, dt_inicio, dt_fim)
    VALUES (2, 'Veículo de defesa', TO_DATE('1998-01-01', 'YYYY-MM-DD'), 5, 11937, 363, 793, 3, TO_DATE('2013-01-01', 'YYYY-MM-DD'), TO_DATE('2027-01-01', 'YYYY-MM-DD'));
    

    INSERT INTO tb_veiculo (id_veiculo, tp_veiculo, dt_fabrica, nr_eixo, nr_peso, nr_altura, nr_comprimento, tp_chassi, dt_inicio, dt_fim)
    VALUES (3, 'Caminhão-guincho', TO_DATE('2001-01-01', 'YYYY-MM-DD'), 5, 16118, 237, 807, 1, TO_DATE('1997-01-01', 'YYYY-MM-DD'), TO_DATE('2029-01-01', 'YYYY-MM-DD')); 


    INSERT INTO tb_veiculo (id_veiculo, tp_veiculo, dt_fabrica, nr_eixo, nr_peso, nr_altura, nr_comprimento, tp_chassi, dt_inicio, dt_fim)
    VALUES (4, 'Caminhão-cegonha', TO_DATE('2021-01-01', 'YYYY-MM-DD'), 6, 30635, 375, 539, 3, TO_DATE('1996-01-01', 'YYYY-MM-DD'), TO_DATE('2025-01-01', 'YYYY-MM-DD'));


    INSERT INTO tb_veiculo (id_veiculo, tp_veiculo, dt_fabrica, nr_eixo, nr_peso, nr_altura, nr_comprimento, tp_chassi, dt_inicio, dt_fim)
    VALUES (5, 'Máquina de construção', TO_DATE('2002-01-01', 'YYYY-MM-DD'), 4, 47361, 317, 509, 1, TO_DATE('2013-01-01', 'YYYY-MM-DD'), TO_DATE('2026-01-01', 'YYYY-MM-DD'));


    INSERT INTO tb_veiculo (id_veiculo, tp_veiculo, dt_fabrica, nr_eixo, nr_peso, nr_altura, nr_comprimento, tp_chassi, dt_inicio, dt_fim)
    VALUES (6, 'Veículo de mineração', TO_DATE('2000-01-01', 'YYYY-MM-DD'), 2, 7564, 348, 682, 2, TO_DATE('2004-01-01', 'YYYY-MM-DD'), TO_DATE('2026-01-01', 'YYYY-MM-DD'));


    INSERT INTO tb_veiculo (id_veiculo, tp_veiculo, dt_fabrica, nr_eixo, nr_peso, nr_altura, nr_comprimento, tp_chassi, dt_inicio, dt_fim)
    VALUES (7, 'Veículo de mineração', TO_DATE('1999-01-01', 'YYYY-MM-DD'), 4, 21709, 283, 750, 4, TO_DATE('2000-01-01', 'YYYY-MM-DD'), TO_DATE('2027-01-01', 'YYYY-MM-DD'));


    INSERT INTO tb_veiculo (id_veiculo, tp_veiculo, dt_fabrica, nr_eixo, nr_peso, nr_altura, nr_comprimento, tp_chassi, dt_inicio, dt_fim)
    VALUES (8, 'Reboque', TO_DATE('2003-01-01', 'YYYY-MM-DD'), 5, 14649, 365, 742, 4, TO_DATE('2021-01-01', 'YYYY-MM-DD'), TO_DATE('2023-01-01', 'YYYY-MM-DD'));


    INSERT INTO tb_veiculo (id_veiculo, tp_veiculo, dt_fabrica, nr_eixo, nr_peso, nr_altura, nr_comprimento, tp_chassi, dt_inicio, dt_fim)
    VALUES (9, 'Caminhão-plataforma', TO_DATE('2014-01-01', 'YYYY-MM-DD'), 5, 45177, 230, 552, 3, TO_DATE('1992-01-01', 'YYYY-MM-DD'), TO_DATE('2025-01-01', 'YYYY-MM-DD'));


    INSERT INTO tb_veiculo (id_veiculo, tp_veiculo, dt_fabrica, nr_eixo, nr_peso, nr_altura, nr_comprimento, tp_chassi, dt_inicio, dt_fim)
    VALUES (10, 'Ônibus escolar', TO_DATE('1999-01-01', 'YYYY-MM-DD'), 3, 20585, 232, 506, 4, TO_DATE('2000-01-01', 'YYYY-MM-DD'), TO_DATE('2024-01-01', 'YYYY-MM-DD'));


    INSERT INTO tb_veiculo (id_veiculo, tp_veiculo, dt_fabrica, nr_eixo, nr_peso, nr_altura, nr_comprimento, tp_chassi, dt_inicio, dt_fim)
    VALUES (11, 'Veículo de resgate', TO_DATE('2001-01-01', 'YYYY-MM-DD'), 4, 42100, 214, 973, 4, TO_DATE('1991-01-01', 'YYYY-MM-DD'), TO_DATE('2029-01-01', 'YYYY-MM-DD'));


    INSERT INTO tb_veiculo (id_veiculo, tp_veiculo, dt_fabrica, nr_eixo, nr_peso, nr_altura, nr_comprimento, tp_chassi, dt_inicio, dt_fim)
    VALUES (12, 'Caminhão-baú', TO_DATE('1998-01-01', 'YYYY-MM-DD'), 5, 19663, 341, 816, 4, TO_DATE('2016-01-01', 'YYYY-MM-DD'), TO_DATE('2026-01-01', 'YYYY-MM-DD'));


    INSERT INTO tb_veiculo (id_veiculo, tp_veiculo, dt_fabrica, nr_eixo, nr_peso, nr_altura, nr_comprimento, tp_chassi, dt_inicio, dt_fim)
    VALUES (13, 'Caminhão frigorífico', TO_DATE('2005-01-01', 'YYYY-MM-DD'), 3, 28295, 337, 572, 1, TO_DATE('1998-01-01', 'YYYY-MM-DD'), TO_DATE('2030-01-01', 'YYYY-MM-DD'));


    INSERT INTO tb_veiculo (id_veiculo, tp_veiculo, dt_fabrica, nr_eixo, nr_peso, nr_altura, nr_comprimento, tp_chassi, dt_inicio, dt_fim)
    VALUES (14, 'Caminhão frigorífico', TO_DATE('2022-01-01', 'YYYY-MM-DD'), 6, 31267, 363, 676, 3, TO_DATE('2002-01-01', 'YYYY-MM-DD'), TO_DATE('2028-01-01', 'YYYY-MM-DD'));


    INSERT INTO tb_veiculo (id_veiculo, tp_veiculo, dt_fabrica, nr_eixo, nr_peso, nr_altura, nr_comprimento, tp_chassi, dt_inicio, dt_fim)
    VALUES (15, 'Reboque', TO_DATE('1993-01-01', 'YYYY-MM-DD'), 4, 36199, 385, 527, 3, TO_DATE('2016-01-01', 'YYYY-MM-DD'), TO_DATE('2030-01-01', 'YYYY-MM-DD'));


    INSERT INTO tb_veiculo (id_veiculo, tp_veiculo, dt_fabrica, nr_eixo, nr_peso, nr_altura, nr_comprimento, tp_chassi, dt_inicio, dt_fim)
    VALUES (16, 'Ônibus escolar', TO_DATE('1991-01-01', 'YYYY-MM-DD'), 2, 9563, 319, 920, 5, TO_DATE('2012-01-01', 'YYYY-MM-DD'), TO_DATE('2029-01-01', 'YYYY-MM-DD'));


    INSERT INTO tb_veiculo (id_veiculo, tp_veiculo, dt_fabrica, nr_eixo, nr_peso, nr_altura, nr_comprimento, tp_chassi, dt_inicio, dt_fim)
    VALUES (17, 'Van de transporte', TO_DATE('2012-01-01', 'YYYY-MM-DD'), 4, 5267, 269, 697, 4, TO_DATE('1999-01-01', 'YYYY-MM-DD'), TO_DATE('2030-01-01', 'YYYY-MM-DD'));


    INSERT INTO tb_veiculo (id_veiculo, tp_veiculo, dt_fabrica, nr_eixo, nr_peso, nr_altura, nr_comprimento, tp_chassi, dt_inicio, dt_fim)
    VALUES (18, 'Caminhão frigorífico', TO_DATE('2013-01-01', 'YYYY-MM-DD'), 5, 8994, 389, 944, 4, TO_DATE('2015-01-01', 'YYYY-MM-DD'), TO_DATE('2030-01-01', 'YYYY-MM-DD'));


    INSERT INTO tb_veiculo (id_veiculo, tp_veiculo, dt_fabrica, nr_eixo, nr_peso, nr_altura, nr_comprimento, tp_chassi, dt_inicio, dt_fim)
    VALUES (19, 'Caminhão', TO_DATE('2023-01-01', 'YYYY-MM-DD'), 2, 29879, 311, 513, 2, TO_DATE('1997-01-01', 'YYYY-MM-DD'), TO_DATE('2027-01-01', 'YYYY-MM-DD'));


    INSERT INTO tb_veiculo (id_veiculo, tp_veiculo, dt_fabrica, nr_eixo, nr_peso, nr_altura, nr_comprimento, tp_chassi, dt_inicio, dt_fim)
    VALUES (20, 'Caminhão frigorífico', TO_DATE('1996-01-01', 'YYYY-MM-DD'), 2, 39434, 346, 664, 3, TO_DATE('2022-01-01', 'YYYY-MM-DD'), TO_DATE('2025-01-01', 'YYYY-MM-DD'));


    INSERT INTO tb_veiculo (id_veiculo, tp_veiculo, dt_fabrica, nr_eixo, nr_peso, nr_altura, nr_comprimento, tp_chassi, dt_inicio, dt_fim)
    VALUES (21, 'Ônibus de turismo', TO_DATE('2010-01-01', 'YYYY-MM-DD'), 4, 36453, 358, 962, 2, TO_DATE('2020-01-01', 'YYYY-MM-DD'), TO_DATE('2026-01-01', 'YYYY-MM-DD'));


    INSERT INTO tb_veiculo (id_veiculo, tp_veiculo, dt_fabrica, nr_eixo, nr_peso, nr_altura, nr_comprimento, tp_chassi, dt_inicio, dt_fim)
    VALUES (22, 'Caminhão-guindaste', TO_DATE('1997-01-01', 'YYYY-MM-DD'), 7, 42292, 233, 696, 4, TO_DATE('1995-01-01', 'YYYY-MM-DD'), TO_DATE('2025-01-01', 'YYYY-MM-DD'));


    INSERT INTO tb_veiculo (id_veiculo, tp_veiculo, dt_fabrica, nr_eixo, nr_peso, nr_altura, nr_comprimento, tp_chassi, dt_inicio, dt_fim)
    VALUES (23, 'Veículo de transporte de carga perigosa', TO_DATE('2005-01-01', 'YYYY-MM-DD'), 8, 17370, 252, 616, 2, TO_DATE('2016-01-01', 'YYYY-MM-DD'), TO_DATE('2025-01-01', 'YYYY-MM-DD'));


    INSERT INTO tb_veiculo (id_veiculo, tp_veiculo, dt_fabrica, nr_eixo, nr_peso, nr_altura, nr_comprimento, tp_chassi, dt_inicio, dt_fim)
    VALUES (24, 'Máquina de construção', TO_DATE('2008-01-01', 'YYYY-MM-DD'), 3, 28032, 394, 676, 4, TO_DATE('2000-01-01', 'YYYY-MM-DD'), TO_DATE('2028-01-01', 'YYYY-MM-DD'));


    INSERT INTO tb_veiculo (id_veiculo, tp_veiculo, dt_fabrica, nr_eixo, nr_peso, nr_altura, nr_comprimento, tp_chassi, dt_inicio, dt_fim)
    VALUES (25, 'Caminhão de mudança', TO_DATE('2001-01-01', 'YYYY-MM-DD'), 6, 41663, 398, 686, 3, TO_DATE('1999-01-01', 'YYYY-MM-DD'), TO_DATE('2026-01-01', 'YYYY-MM-DD'));


    INSERT INTO tb_veiculo (id_veiculo, tp_veiculo, dt_fabrica, nr_eixo, nr_peso, nr_altura, nr_comprimento, tp_chassi, dt_inicio, dt_fim)
    VALUES (26, 'Caminhão de mudança', TO_DATE('2021-01-01', 'YYYY-MM-DD'), 3, 8877, 364, 774, 1, TO_DATE('1993-01-01', 'YYYY-MM-DD'), TO_DATE('2026-01-01', 'YYYY-MM-DD'));


    INSERT INTO tb_veiculo (id_veiculo, tp_veiculo, dt_fabrica, nr_eixo, nr_peso, nr_altura, nr_comprimento, tp_chassi, dt_inicio, dt_fim)
    VALUES (27, 'Caminhão-plataforma', TO_DATE('2010-01-01', 'YYYY-MM-DD'), 3, 17301, 224, 836, 4, TO_DATE('2017-01-01', 'YYYY-MM-DD'), TO_DATE('2029-01-01', 'YYYY-MM-DD'));


    INSERT INTO tb_veiculo (id_veiculo, tp_veiculo, dt_fabrica, nr_eixo, nr_peso, nr_altura, nr_comprimento, tp_chassi, dt_inicio, dt_fim)
    VALUES (28, 'Caminhão', TO_DATE('2014-01-01', 'YYYY-MM-DD'), 7, 23698, 389, 557, 2, TO_DATE('2015-01-01', 'YYYY-MM-DD'), TO_DATE('2024-01-01', 'YYYY-MM-DD'));


    INSERT INTO tb_veiculo (id_veiculo, tp_veiculo, dt_fabrica, nr_eixo, nr_peso, nr_altura, nr_comprimento, tp_chassi, dt_inicio, dt_fim)
    VALUES (29, 'Veículo de transporte de animais', TO_DATE('1998-01-01', 'YYYY-MM-DD'), 8, 19277, 396, 995, 1, TO_DATE('2021-01-01', 'YYYY-MM-DD'), TO_DATE('2026-01-01', 'YYYY-MM-DD'));


    INSERT INTO tb_veiculo (id_veiculo, tp_veiculo, dt_fabrica, nr_eixo, nr_peso, nr_altura, nr_comprimento, tp_chassi, dt_inicio, dt_fim)
    VALUES (30, 'Ônibus escolar', TO_DATE('2006-01-01', 'YYYY-MM-DD'), 3, 14383, 341, 702, 3, TO_DATE('2019-01-01', 'YYYY-MM-DD'), TO_DATE('2029-01-01', 'YYYY-MM-DD'));


    INSERT INTO tb_veiculo (id_veiculo, tp_veiculo, dt_fabrica, nr_eixo, nr_peso, nr_altura, nr_comprimento, tp_chassi, dt_inicio, dt_fim)
    VALUES (31, 'Veículo de defesa', TO_DATE('2007-01-01', 'YYYY-MM-DD'), 6, 39068, 340, 758, 5, TO_DATE('2021-01-01', 'YYYY-MM-DD'), TO_DATE('2025-01-01', 'YYYY-MM-DD'));


    INSERT INTO tb_veiculo (id_veiculo, tp_veiculo, dt_fabrica, nr_eixo, nr_peso, nr_altura, nr_comprimento, tp_chassi, dt_inicio, dt_fim)
    VALUES (32, 'Ônibus de turismo', TO_DATE('2003-01-01', 'YYYY-MM-DD'), 7, 8822, 291, 642, 1, TO_DATE('2006-01-01', 'YYYY-MM-DD'), TO_DATE('2025-01-01', 'YYYY-MM-DD'));


    INSERT INTO tb_veiculo (id_veiculo, tp_veiculo, dt_fabrica, nr_eixo, nr_peso, nr_altura, nr_comprimento, tp_chassi, dt_inicio, dt_fim)
    VALUES (33, 'Máquina de construção', TO_DATE('1995-01-01', 'YYYY-MM-DD'), 7, 43518, 260, 523, 3, TO_DATE('2009-01-01', 'YYYY-MM-DD'), TO_DATE('2024-01-01', 'YYYY-MM-DD'));


    INSERT INTO tb_veiculo (id_veiculo, tp_veiculo, dt_fabrica, nr_eixo, nr_peso, nr_altura, nr_comprimento, tp_chassi, dt_inicio, dt_fim)
    VALUES (34, 'Caminhão-plataforma', TO_DATE('1999-01-01', 'YYYY-MM-DD'), 4, 31706, 217, 643, 1, TO_DATE('2018-01-01', 'YYYY-MM-DD'), TO_DATE('2028-01-01', 'YYYY-MM-DD'));


    INSERT INTO tb_veiculo (id_veiculo, tp_veiculo, dt_fabrica, nr_eixo, nr_peso, nr_altura, nr_comprimento, tp_chassi, dt_inicio, dt_fim)
    VALUES (35, 'Veículo de transporte de carga perigosa', TO_DATE('1991-01-01', 'YYYY-MM-DD'), 5, 11895, 229, 767, 1, TO_DATE('1990-01-01', 'YYYY-MM-DD'), TO_DATE('2026-01-01', 'YYYY-MM-DD'));


    INSERT INTO tb_veiculo (id_veiculo, tp_veiculo, dt_fabrica, nr_eixo, nr_peso, nr_altura, nr_comprimento, tp_chassi, dt_inicio, dt_fim)
    VALUES (36, 'Máquina de construção', TO_DATE('1999-01-01', 'YYYY-MM-DD'), 6, 31475, 354, 933, 4, TO_DATE('2000-01-01', 'YYYY-MM-DD'), TO_DATE('2030-01-01', 'YYYY-MM-DD'));


    INSERT INTO tb_veiculo (id_veiculo, tp_veiculo, dt_fabrica, nr_eixo, nr_peso, nr_altura, nr_comprimento, tp_chassi, dt_inicio, dt_fim)
    VALUES (37, 'Veículo de resgate', TO_DATE('1990-01-01', 'YYYY-MM-DD'), 5, 5240, 327, 517, 4, TO_DATE('1996-01-01', 'YYYY-MM-DD'), TO_DATE('2028-01-01', 'YYYY-MM-DD'));


    INSERT INTO tb_veiculo (id_veiculo, tp_veiculo, dt_fabrica, nr_eixo, nr_peso, nr_altura, nr_comprimento, tp_chassi, dt_inicio, dt_fim)
    VALUES (38, 'Veículo para construção civil', TO_DATE('1991-01-01', 'YYYY-MM-DD'), 7, 33592, 371, 673, 5, TO_DATE('2020-01-01', 'YYYY-MM-DD'), TO_DATE('2029-01-01', 'YYYY-MM-DD'));


    INSERT INTO tb_veiculo (id_veiculo, tp_veiculo, dt_fabrica, nr_eixo, nr_peso, nr_altura, nr_comprimento, tp_chassi, dt_inicio, dt_fim)
    VALUES (39, 'Ônibus de turismo', TO_DATE('2012-01-01', 'YYYY-MM-DD'), 5, 47458, 317, 934, 5, TO_DATE('1992-01-01', 'YYYY-MM-DD'), TO_DATE('2026-01-01', 'YYYY-MM-DD'));


    INSERT INTO tb_veiculo (id_veiculo, tp_veiculo, dt_fabrica, nr_eixo, nr_peso, nr_altura, nr_comprimento, tp_chassi, dt_inicio, dt_fim)
    VALUES (40, 'Caminhão frigorífico', TO_DATE('2011-01-01', 'YYYY-MM-DD'), 4, 11864, 210, 803, 1, TO_DATE('1995-01-01', 'YYYY-MM-DD'), TO_DATE('2028-01-01', 'YYYY-MM-DD'));


    INSERT INTO tb_veiculo (id_veiculo, tp_veiculo, dt_fabrica, nr_eixo, nr_peso, nr_altura, nr_comprimento, tp_chassi, dt_inicio, dt_fim)
    VALUES (41, 'Máquina de construção', TO_DATE('1993-01-01', 'YYYY-MM-DD'), 5, 43809, 392, 925, 1, TO_DATE('1993-01-01', 'YYYY-MM-DD'), TO_DATE('2027-01-01', 'YYYY-MM-DD'));


    INSERT INTO tb_veiculo (id_veiculo, tp_veiculo, dt_fabrica, nr_eixo, nr_peso, nr_altura, nr_comprimento, tp_chassi, dt_inicio, dt_fim)
    VALUES (42, 'Veículo de resgate', TO_DATE('2021-01-01', 'YYYY-MM-DD'), 4, 11099, 296, 769, 3, TO_DATE('2014-01-01', 'YYYY-MM-DD'), TO_DATE('2023-01-01', 'YYYY-MM-DD'));


    INSERT INTO tb_veiculo (id_veiculo, tp_veiculo, dt_fabrica, nr_eixo, nr_peso, nr_altura, nr_comprimento, tp_chassi, dt_inicio, dt_fim)
    VALUES (43, 'Veículo para construção civil', TO_DATE('2017-01-01', 'YYYY-MM-DD'), 3, 12890, 200, 795, 3, TO_DATE('1990-01-01', 'YYYY-MM-DD'), TO_DATE('2028-01-01', 'YYYY-MM-DD'));


    INSERT INTO tb_veiculo (id_veiculo, tp_veiculo, dt_fabrica, nr_eixo, nr_peso, nr_altura, nr_comprimento, tp_chassi, dt_inicio, dt_fim)
    VALUES (44, 'Veículo para construção civil', TO_DATE('2021-01-01', 'YYYY-MM-DD'), 4, 44869, 300, 783, 4, TO_DATE('1991-01-01', 'YYYY-MM-DD'), TO_DATE('2024-01-01', 'YYYY-MM-DD'));


    INSERT INTO tb_veiculo (id_veiculo, tp_veiculo, dt_fabrica, nr_eixo, nr_peso, nr_altura, nr_comprimento, tp_chassi, dt_inicio, dt_fim)
    VALUES (45, 'Veículo de transporte de animais', TO_DATE('2003-01-01', 'YYYY-MM-DD'), 2, 26257, 367, 682, 3, TO_DATE('2004-01-01', 'YYYY-MM-DD'), TO_DATE('2024-01-01', 'YYYY-MM-DD'));


    INSERT INTO tb_veiculo (id_veiculo, tp_veiculo, dt_fabrica, nr_eixo, nr_peso, nr_altura, nr_comprimento, tp_chassi, dt_inicio, dt_fim)
    VALUES (46, 'Ônibus escolar', TO_DATE('2020-01-01', 'YYYY-MM-DD'), 8, 41998, 303, 566, 5, TO_DATE('2001-01-01', 'YYYY-MM-DD'), TO_DATE('2028-01-01', 'YYYY-MM-DD'));


    INSERT INTO tb_veiculo (id_veiculo, tp_veiculo, dt_fabrica, nr_eixo, nr_peso, nr_altura, nr_comprimento, tp_chassi, dt_inicio, dt_fim)
    VALUES (47, 'Caminhão-tanque', TO_DATE('2014-01-01', 'YYYY-MM-DD'), 6, 34864, 279, 537, 1, TO_DATE('2011-01-01', 'YYYY-MM-DD'), TO_DATE('2027-01-01', 'YYYY-MM-DD'));


    INSERT INTO tb_veiculo (id_veiculo, tp_veiculo, dt_fabrica, nr_eixo, nr_peso, nr_altura, nr_comprimento, tp_chassi, dt_inicio, dt_fim)
    VALUES (48, 'Veículo de transporte de animais', TO_DATE('2021-01-01', 'YYYY-MM-DD'), 7, 25974, 289, 689, 4, TO_DATE('2012-01-01', 'YYYY-MM-DD'), TO_DATE('2029-01-01', 'YYYY-MM-DD'));


    INSERT INTO tb_veiculo (id_veiculo, tp_veiculo, dt_fabrica, nr_eixo, nr_peso, nr_altura, nr_comprimento, tp_chassi, dt_inicio, dt_fim)
    VALUES (49, 'Caminhão de mudança', TO_DATE('1994-01-01', 'YYYY-MM-DD'), 4, 16221, 251, 680, 4, TO_DATE('1998-01-01', 'YYYY-MM-DD'), TO_DATE('2029-01-01', 'YYYY-MM-DD'));


    INSERT INTO tb_veiculo (id_veiculo, tp_veiculo, dt_fabrica, nr_eixo, nr_peso, nr_altura, nr_comprimento, tp_chassi, dt_inicio, dt_fim)
    VALUES (50, 'Caminhão-carga seca', TO_DATE('2004-01-01', 'YYYY-MM-DD'), 4, 8377, 284, 505, 2, TO_DATE('2008-01-01', 'YYYY-MM-DD'), TO_DATE('2025-01-01', 'YYYY-MM-DD')); 

    SELECT SEQ_TELEFONE.CURRVAL FROM DUAL;
    ALTER SEQUENCE SEQ_TELEFONE INCREMENT BY -1;
    SELECT SEQ_TELEFONE.NEXTVAL FROM DUAL;
    ALTER SEQUENCE SEQ_TELEFONE INCREMENT BY 1;
    SELECT id_usuario, st_telefone FROM tb_telefone_usuario WHERE id_usuario = 1;


    INSERT INTO tb_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone) VALUES (SEQ_TELEFONE.NEXTVAL, 1, 92, 73, 3702956258, 'Recado', 'A');
    INSERT INTO tb_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone) VALUES (SEQ_TELEFONE.NEXTVAL, 2, 52, 30, 4568196784, 'Celular', 'A');  
    INSERT INTO tb_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone) VALUES (SEQ_TELEFONE.NEXTVAL, 3, 14, 43, 9604250225, 'Comercial', 'I');
    INSERT INTO tb_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone) VALUES (SEQ_TELEFONE.NEXTVAL, 4, 49, 47, 2634106383, 'Recado', 'I');   
    INSERT INTO tb_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone) VALUES (SEQ_TELEFONE.NEXTVAL, 5, 53, 68, 7787978082, 'Celular', 'I');  
    INSERT INTO tb_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone) VALUES (SEQ_TELEFONE.NEXTVAL, 6, 68, 50, 5783295177, 'Comercial', 'I');
    INSERT INTO tb_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone) VALUES (SEQ_TELEFONE.NEXTVAL, 7, 7, 18, 4763152441, 'Celular', 'A');   
    INSERT INTO tb_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone) VALUES (SEQ_TELEFONE.NEXTVAL, 8, 12, 38, 1488110179, 'Celular', 'A');  
    INSERT INTO tb_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone) VALUES (SEQ_TELEFONE.NEXTVAL, 9, 11, 82, 8648236748, 'Celular', 'I');  
    INSERT INTO tb_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone) VALUES (SEQ_TELEFONE.NEXTVAL, 10, 8, 89, 1375077708, 'Comercial', 'A');
    INSERT INTO tb_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone) VALUES (SEQ_TELEFONE.NEXTVAL, 11, 25, 42, 9814529965, 'Comercial', 'A');
    INSERT INTO tb_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone) VALUES (SEQ_TELEFONE.NEXTVAL, 12, 59, 31, 4258009796, 'Recado', 'A');
    INSERT INTO tb_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone) VALUES (SEQ_TELEFONE.NEXTVAL, 13, 86, 28, 5558618207, 'Celular', 'I');
    INSERT INTO tb_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone) VALUES (SEQ_TELEFONE.NEXTVAL, 14, 90, 70, 5924887085, 'Comercial', 'I');
    INSERT INTO tb_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone) VALUES (SEQ_TELEFONE.NEXTVAL, 15, 8, 54, 1319912143, 'Comercial', 'A');
    INSERT INTO tb_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone) VALUES (SEQ_TELEFONE.NEXTVAL, 16, 76, 45, 2828927502, 'Celular', 'I');
    INSERT INTO tb_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone) VALUES (SEQ_TELEFONE.NEXTVAL, 17, 69, 47, 8332716688, 'Celular', 'A');
    INSERT INTO tb_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone) VALUES (SEQ_TELEFONE.NEXTVAL, 18, 78, 14, 9960836088, 'Recado', 'A');
    INSERT INTO tb_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone) VALUES (SEQ_TELEFONE.NEXTVAL, 19, 18, 7, 1666059800, 'Celular', 'A');
    INSERT INTO tb_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone) VALUES (SEQ_TELEFONE.NEXTVAL, 20, 25, 52, 2153327555, 'Residencial', 'I');
    INSERT INTO tb_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone) VALUES (SEQ_TELEFONE.NEXTVAL, 21, 65, 36, 6776904758, 'Celular', 'A');
    INSERT INTO tb_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone) VALUES (SEQ_TELEFONE.NEXTVAL, 22, 13, 61, 4279247931, 'Recado', 'I');
    INSERT INTO tb_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone) VALUES (SEQ_TELEFONE.NEXTVAL, 23, 13, 47, 1579558995, 'Celular', 'A');
    INSERT INTO tb_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone) VALUES (SEQ_TELEFONE.NEXTVAL, 24, 66, 86, 2461188250, 'Celular', 'I');
    INSERT INTO tb_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone) VALUES (SEQ_TELEFONE.NEXTVAL, 25, 12, 40, 9339255565, 'Celular', 'I');
    INSERT INTO tb_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone) VALUES (SEQ_TELEFONE.NEXTVAL, 26, 59, 29, 2790774644, 'Comercial', 'I');
    INSERT INTO tb_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone) VALUES (SEQ_TELEFONE.NEXTVAL, 27, 94, 32, 5277818427, 'Residencial', 'I');
    INSERT INTO tb_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone) VALUES (SEQ_TELEFONE.NEXTVAL, 28, 64, 50, 2270591577, 'Comercial', 'I');
    INSERT INTO tb_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone) VALUES (SEQ_TELEFONE.NEXTVAL, 29, 4, 25, 2614103842, 'Comercial', 'A');
    INSERT INTO tb_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone) VALUES (SEQ_TELEFONE.NEXTVAL, 30, 31, 48, 5288924008, 'Celular', 'I');
    INSERT INTO tb_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone) VALUES (SEQ_TELEFONE.NEXTVAL, 31, 61, 52, 6673155420, 'Recado', 'I');
    INSERT INTO tb_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone) VALUES (SEQ_TELEFONE.NEXTVAL, 32, 44, 49, 3792285830, 'Comercial', 'A');
    INSERT INTO tb_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone) VALUES (SEQ_TELEFONE.NEXTVAL, 33, 30, 17, 3294951374, 'Residencial', 'I');
    INSERT INTO tb_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone) VALUES (SEQ_TELEFONE.NEXTVAL, 34, 12, 93, 9125741243, 'Celular', 'I');
    INSERT INTO tb_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone) VALUES (SEQ_TELEFONE.NEXTVAL, 35, 74, 41, 7556478340, 'Residencial', 'A');
    INSERT INTO tb_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone) VALUES (SEQ_TELEFONE.NEXTVAL, 36, 33, 72, 7987116198, 'Celular', 'I');
    INSERT INTO tb_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone) VALUES (SEQ_TELEFONE.NEXTVAL, 37, 43, 35, 5562426130, 'Comercial', 'A');
    INSERT INTO tb_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone) VALUES (SEQ_TELEFONE.NEXTVAL, 38, 5, 85, 6541435414, 'Residencial', 'I');
    INSERT INTO tb_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone) VALUES (SEQ_TELEFONE.NEXTVAL, 39, 81, 35, 6131729708, 'Celular', 'I');
    INSERT INTO tb_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone) VALUES (SEQ_TELEFONE.NEXTVAL, 40, 37, 3, 7453167455, 'Recado', 'A');
    INSERT INTO tb_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone) VALUES (SEQ_TELEFONE.NEXTVAL, 41, 33, 4, 5238453865, 'Recado', 'I');
    INSERT INTO tb_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone) VALUES (SEQ_TELEFONE.NEXTVAL, 42, 3, 15, 3352297617, 'Residencial', 'A');
    INSERT INTO tb_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone) VALUES (SEQ_TELEFONE.NEXTVAL, 43, 65, 46, 3140034815, 'Celular', 'A');
    INSERT INTO tb_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone) VALUES (SEQ_TELEFONE.NEXTVAL, 44, 55, 11, 6996130001, 'Celular', 'A');
    INSERT INTO tb_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone) VALUES (SEQ_TELEFONE.NEXTVAL, 45, 71, 33, 8788464003, 'Comercial', 'I');
    INSERT INTO tb_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone) VALUES (SEQ_TELEFONE.NEXTVAL, 46, 51, 38, 1598703563, 'Comercial', 'I');
    



   INSERT INTO tb_problema (id_problema, id_end_problema, id_usuario, nm_problema, dt_problema)
   VALUES (1, 1, 1, 'Falhas no funcionamento do motor.', TO_DATE('2020-11-15', 'YYYY-MM-DD')); 
    

    INSERT INTO tb_problema (id_problema, id_end_problema, id_usuario, nm_problema, dt_problema)
    VALUES (2, 2, 2, 'Perda de potência.', TO_DATE('2023-04-16', 'YYYY-MM-DD'));


    INSERT INTO tb_problema (id_problema, id_end_problema, id_usuario, nm_problema, dt_problema)
    VALUES (3, 3, 3, 'Vazamentos de óleo ou líquido de arrefecimento.', TO_DATE('2022-02-21', 'YYYY-MM-DD'));


    INSERT INTO tb_problema (id_problema, id_end_problema, id_usuario, nm_problema, dt_problema)
    VALUES (4, 4, 4, 'Desgaste excessivo das pastilhas de freio.', TO_DATE('2020-10-28', 'YYYY-MM-DD'));


    INSERT INTO tb_problema (id_problema, id_end_problema, id_usuario, nm_problema, dt_problema)
    VALUES (5, 5, 5, 'Falha no sistema de freio antibloqueio (ABS).', TO_DATE('2020-08-03', 'YYYY-MM-DD'));


    INSERT INTO tb_problema (id_problema, id_end_problema, id_usuario, nm_problema, dt_problema)
    VALUES (6, 6, 6, 'Vazamento de fluido de freio.', TO_DATE('2022-04-12', 'YYYY-MM-DD'));


    INSERT INTO tb_problema (id_problema, id_end_problema, id_usuario, nm_problema, dt_problema)
    VALUES (7, 7, 7, 'Falhas nos sistemas de iluminação.', TO_DATE('2022-09-11', 'YYYY-MM-DD'));


    INSERT INTO tb_problema (id_problema, id_end_problema, id_usuario, nm_problema, dt_problema)
    VALUES (8, 8, 8, 'Falha nos sistema de freio antibloqueio.', TO_DATE('2022-06-08', 'YYYY-MM-DD'));


    INSERT INTO tb_problema (id_problema, id_end_problema, id_usuario, nm_problema, dt_problema)
    VALUES (9, 9, 9, 'Falha nos sistemas eletrônicos de controle.', TO_DATE('2022-06-08', 'YYYY-MM-DD'));


    INSERT INTO tb_problema (id_problema, id_end_problema, id_usuario, nm_problema, dt_problema)
    VALUES (10, 10, 10, 'Desgaste irregular dos pneus.', TO_DATE('2021-12-11', 'YYYY-MM-DD'));



    INSERT INTO tb_problema (id_problema, id_end_problema, id_usuario, nm_problema, dt_problema)
    VALUES (11, 11, 11, 'Falhas no funcionamento do motor.', TO_DATE('2023-02-23', 'YYYY-MM-DD'));


    INSERT INTO tb_problema (id_problema, id_end_problema, id_usuario, nm_problema, dt_problema)
    VALUES (12, 12, 12, 'Perda de potência.', TO_DATE('2023-08-01', 'YYYY-MM-DD'));


    INSERT INTO tb_problema (id_problema, id_end_problema, id_usuario, nm_problema, dt_problema)
    VALUES (13, 13, 13, 'Vazamentos de óleo ou líquido de arrefecimento.', TO_DATE('2023-05-29', 'YYYY-MM-DD'));


    INSERT INTO tb_problema (id_problema, id_end_problema, id_usuario, nm_problema, dt_problema)
    VALUES (14, 14, 14, 'Desgaste excessivo das pastilhas de freio.', TO_DATE('2022-07-26', 'YYYY-MM-DD'));


    INSERT INTO tb_problema (id_problema, id_end_problema, id_usuario, nm_problema, dt_problema)
    VALUES (15, 15, 15, 'Falha no sistema de freio antibloqueio (ABS).', TO_DATE('2021-10-16', 'YYYY-MM-DD'));


    INSERT INTO tb_problema (id_problema, id_end_problema, id_usuario, nm_problema, dt_problema)
    VALUES (16, 16, 16, 'Vazamento de fluido de freio.', TO_DATE('2023-03-15', 'YYYY-MM-DD'));


    INSERT INTO tb_problema (id_problema, id_end_problema, id_usuario, nm_problema, dt_problema)
    VALUES (17, 17, 17, 'Falhas nos sistemas de iluminação.', TO_DATE('2020-08-01', 'YYYY-MM-DD'));


    INSERT INTO tb_problema (id_problema, id_end_problema, id_usuario, nm_problema, dt_problema)
    VALUES (18, 18, 18, 'Problemas com baterias descarregadas.', TO_DATE('2022-10-23', 'YYYY-MM-DD'));


    INSERT INTO tb_problema (id_problema, id_end_problema, id_usuario, nm_problema, dt_problema)
    VALUES (19, 19, 19, 'Falha nos sistemas eletrônicos de controle.', TO_DATE('2020-06-14', 'YYYY-MM-DD'));


    INSERT INTO tb_problema (id_problema, id_end_problema, id_usuario, nm_problema, dt_problema)
    VALUES (20, 20, 20, 'Desgaste irregular dos pneus.', TO_DATE('2020-05-18', 'YYYY-MM-DD'));

    -- inserindo na tabela cliente_veiculo 
    
    
    INSERT INTO tb_cliente_veiculo (id_usuario, id_veiculo, id_cliente, nm_cliente_func, dt_inicio, dt_fim, cd_slc_atend)
    VALUES (1, 1, 1, 'Vitor', TO_DATE('2023-04-09', 'YYYY-MM-DD'), TO_DATE('2024-02-11', 'YYYY-MM-DD'), 4833440896);


    INSERT INTO tb_cliente_veiculo (id_usuario, id_veiculo, id_cliente, nm_cliente_func, dt_inicio, dt_fim, cd_slc_atend)
    VALUES (2, 2, 2, 'Larissa', TO_DATE('2021-01-29', 'YYYY-MM-DD'), TO_DATE('2021-03-14', 'YYYY-MM-DD'), 1577215756);


    INSERT INTO tb_cliente_veiculo (id_usuario, id_veiculo, id_cliente, nm_cliente_func, dt_inicio, dt_fim, cd_slc_atend)
    VALUES (3, 3, 3, 'Isadora', TO_DATE('2022-11-28', 'YYYY-MM-DD'), TO_DATE('2023-10-09', 'YYYY-MM-DD'), 6217116356);


    INSERT INTO tb_cliente_veiculo (id_usuario, id_veiculo, id_cliente, nm_cliente_func, dt_inicio, dt_fim, cd_slc_atend)
    VALUES (4, 4, 4, 'Luna', TO_DATE('2021-03-07', 'YYYY-MM-DD'), TO_DATE('2021-11-11', 'YYYY-MM-DD'), 5439653727);


    INSERT INTO tb_cliente_veiculo (id_usuario, id_veiculo, id_cliente, nm_cliente_func, dt_inicio, dt_fim, cd_slc_atend)
    VALUES (5, 5, 5, 'Maria Clara', TO_DATE('2023-11-02', 'YYYY-MM-DD'), TO_DATE('2024-03-06', 'YYYY-MM-DD'), 2315504567);


    INSERT INTO tb_cliente_veiculo (id_usuario, id_veiculo, id_cliente, nm_cliente_func, dt_inicio, dt_fim, cd_slc_atend)
    VALUES (6, 6, 6, 'João Guilherme', TO_DATE('2021-05-20', 'YYYY-MM-DD'), TO_DATE('2022-03-15', 'YYYY-MM-DD'), 9554594213);


    INSERT INTO tb_cliente_veiculo (id_usuario, id_veiculo, id_cliente, nm_cliente_func, dt_inicio, dt_fim, cd_slc_atend)
    VALUES (7, 7, 7, 'Ana Luiza', TO_DATE('2021-09-16', 'YYYY-MM-DD'), TO_DATE('2022-02-28', 'YYYY-MM-DD'), 595390237);


    INSERT INTO tb_cliente_veiculo (id_usuario, id_veiculo, id_cliente, nm_cliente_func, dt_inicio, dt_fim, cd_slc_atend)
    VALUES (8, 8, 8, 'Amanda', TO_DATE('2023-06-19', 'YYYY-MM-DD'), TO_DATE('2024-01-22', 'YYYY-MM-DD'), 4122742874);


    INSERT INTO tb_cliente_veiculo (id_usuario, id_veiculo, id_cliente, nm_cliente_func, dt_inicio, dt_fim, cd_slc_atend)
    VALUES (9, 9, 9, 'Emanuella', TO_DATE('2020-06-12', 'YYYY-MM-DD'), TO_DATE('2021-03-17', 'YYYY-MM-DD'), 3736907821);


    INSERT INTO tb_cliente_veiculo (id_usuario, id_veiculo, id_cliente, nm_cliente_func, dt_inicio, dt_fim, cd_slc_atend)
    VALUES (10, 10, 10, 'Brenda', TO_DATE('2022-01-30', 'YYYY-MM-DD'), TO_DATE('2022-11-11', 'YYYY-MM-DD'), 606202420);


    INSERT INTO tb_cliente_veiculo (id_usuario, id_veiculo, id_cliente, nm_cliente_func, dt_inicio, dt_fim, cd_slc_atend)
    VALUES (11, 11, 11, 'Breno', TO_DATE('2021-12-19', 'YYYY-MM-DD'), TO_DATE('2022-12-06', 'YYYY-MM-DD'), 377874697);


    INSERT INTO tb_cliente_veiculo (id_usuario, id_veiculo, id_cliente, nm_cliente_func, dt_inicio, dt_fim, cd_slc_atend)
    VALUES (12, 12, 12, 'Catarina', TO_DATE('2022-12-21', 'YYYY-MM-DD'), TO_DATE('2023-09-30', 'YYYY-MM-DD'), 1664918516);


    INSERT INTO tb_cliente_veiculo (id_usuario, id_veiculo, id_cliente, nm_cliente_func, dt_inicio, dt_fim, cd_slc_atend)
    VALUES (13, 13, 13, 'Laís', TO_DATE('2020-08-03', 'YYYY-MM-DD'), TO_DATE('2020-11-06', 'YYYY-MM-DD'), 4127197474);


    INSERT INTO tb_cliente_veiculo (id_usuario, id_veiculo, id_cliente, nm_cliente_func, dt_inicio, dt_fim, cd_slc_atend)
    VALUES (14, 14, 14, 'Cecília', TO_DATE('2021-06-13', 'YYYY-MM-DD'), TO_DATE('2021-09-15', 'YYYY-MM-DD'), 5024510741);


    INSERT INTO tb_cliente_veiculo (id_usuario, id_veiculo, id_cliente, nm_cliente_func, dt_inicio, dt_fim, cd_slc_atend)
    VALUES (15, 15, 15, 'Clarice', TO_DATE('2021-02-09', 'YYYY-MM-DD'), TO_DATE('2022-01-06', 'YYYY-MM-DD'), 8041309895);


    INSERT INTO tb_cliente_veiculo (id_usuario, id_veiculo, id_cliente, nm_cliente_func, dt_inicio, dt_fim, cd_slc_atend)
    VALUES (16, 16, 16, 'Rafael', TO_DATE('2021-11-20', 'YYYY-MM-DD'), TO_DATE('2022-01-30', 'YYYY-MM-DD'), 9842890349);


    INSERT INTO tb_cliente_veiculo (id_usuario, id_veiculo, id_cliente, nm_cliente_func, dt_inicio, dt_fim, cd_slc_atend)
    VALUES (17, 17, 17, 'Kamilly', TO_DATE('2021-11-10', 'YYYY-MM-DD'), TO_DATE('2022-09-21', 'YYYY-MM-DD'), 1458590318);


    INSERT INTO tb_cliente_veiculo (id_usuario, id_veiculo, id_cliente, nm_cliente_func, dt_inicio, dt_fim, cd_slc_atend)
    VALUES (18, 18, 18, 'Calebe', TO_DATE('2020-06-27', 'YYYY-MM-DD'), TO_DATE('2021-03-15', 'YYYY-MM-DD'), 7682293517);


    INSERT INTO tb_cliente_veiculo (id_usuario, id_veiculo, id_cliente, nm_cliente_func, dt_inicio, dt_fim, cd_slc_atend)
    VALUES (19, 19, 19, 'João Lucas', TO_DATE('2021-09-10', 'YYYY-MM-DD'), TO_DATE('2022-06-01', 'YYYY-MM-DD'), 7019272498);


    INSERT INTO tb_cliente_veiculo (id_usuario, id_veiculo, id_cliente, nm_cliente_func, dt_inicio, dt_fim, cd_slc_atend)
    VALUES (20, 20, 20, 'Juliana', TO_DATE('2021-07-23', 'YYYY-MM-DD'), TO_DATE('2021-09-15', 'YYYY-MM-DD'), 8678246419);


    INSERT INTO tb_cliente_veiculo (id_usuario, id_veiculo, id_cliente, nm_cliente_func, dt_inicio, dt_fim, cd_slc_atend)
    VALUES (21, 21, 21, 'Eloah', TO_DATE('2023-07-14', 'YYYY-MM-DD'), TO_DATE('2023-09-28', 'YYYY-MM-DD'), 2801442075);


    INSERT INTO tb_cliente_veiculo (id_usuario, id_veiculo, id_cliente, nm_cliente_func, dt_inicio, dt_fim, cd_slc_atend)
    VALUES (22, 22, 22, 'Ana Vitória', TO_DATE('2022-11-18', 'YYYY-MM-DD'), TO_DATE('2023-07-21', 'YYYY-MM-DD'), 7757328336);


    INSERT INTO tb_cliente_veiculo (id_usuario, id_veiculo, id_cliente, nm_cliente_func, dt_inicio, dt_fim, cd_slc_atend)
    VALUES (23, 23, 23, 'Gustavo', TO_DATE('2023-03-07', 'YYYY-MM-DD'), TO_DATE('2023-10-22', 'YYYY-MM-DD'), 1811208060);


    INSERT INTO tb_cliente_veiculo (id_usuario, id_veiculo, id_cliente, nm_cliente_func, dt_inicio, dt_fim, cd_slc_atend)
    VALUES (24, 24, 24, 'Luiz Felipe', TO_DATE('2021-07-20', 'YYYY-MM-DD'), TO_DATE('2021-10-08', 'YYYY-MM-DD'), 4004637970);


    INSERT INTO tb_cliente_veiculo (id_usuario, id_veiculo, id_cliente, nm_cliente_func, dt_inicio, dt_fim, cd_slc_atend)
    VALUES (25, 25, 25, 'Catarina', TO_DATE('2021-08-19', 'YYYY-MM-DD'), TO_DATE('2022-07-24', 'YYYY-MM-DD'), 9963095591);


    INSERT INTO tb_cliente_veiculo (id_usuario, id_veiculo, id_cliente, nm_cliente_func, dt_inicio, dt_fim, cd_slc_atend)
    VALUES (26, 26, 26, 'Rafael', TO_DATE('2022-07-04', 'YYYY-MM-DD'), TO_DATE('2023-02-24', 'YYYY-MM-DD'), 6219987122);


    INSERT INTO tb_cliente_veiculo (id_usuario, id_veiculo, id_cliente, nm_cliente_func, dt_inicio, dt_fim, cd_slc_atend)
    VALUES (27, 27, 27, 'Lívia', TO_DATE('2021-07-26', 'YYYY-MM-DD'), TO_DATE('2022-01-31', 'YYYY-MM-DD'), 3760435536);


    INSERT INTO tb_cliente_veiculo (id_usuario, id_veiculo, id_cliente, nm_cliente_func, dt_inicio, dt_fim, cd_slc_atend)
    VALUES (28, 28, 28, 'Luiz Miguel', TO_DATE('2022-02-12', 'YYYY-MM-DD'), TO_DATE('2022-11-07', 'YYYY-MM-DD'), 5900408208);


    INSERT INTO tb_cliente_veiculo (id_usuario, id_veiculo, id_cliente, nm_cliente_func, dt_inicio, dt_fim, cd_slc_atend)
    VALUES (29, 29, 29, 'Isis', TO_DATE('2021-08-15', 'YYYY-MM-DD'), TO_DATE('2022-03-12', 'YYYY-MM-DD'), 7296803222);


    INSERT INTO tb_cliente_veiculo (id_usuario, id_veiculo, id_cliente, nm_cliente_func, dt_inicio, dt_fim, cd_slc_atend)
    VALUES (30, 30, 30, 'Pedro', TO_DATE('2023-01-19', 'YYYY-MM-DD'), TO_DATE('2023-12-21', 'YYYY-MM-DD'), 7831630438);


    INSERT INTO tb_cliente_veiculo (id_usuario, id_veiculo, id_cliente, nm_cliente_func, dt_inicio, dt_fim, cd_slc_atend)
    VALUES (31, 31, 31, 'Heloísa', TO_DATE('2020-10-07', 'YYYY-MM-DD'), TO_DATE('2021-02-05', 'YYYY-MM-DD'), 7835768402);


    INSERT INTO tb_cliente_veiculo (id_usuario, id_veiculo, id_cliente, nm_cliente_func, dt_inicio, dt_fim, cd_slc_atend)
    VALUES (32, 32, 32, 'Clarice', TO_DATE('2020-08-29', 'YYYY-MM-DD'), TO_DATE('2020-10-15', 'YYYY-MM-DD'), 4793529007);


    INSERT INTO tb_cliente_veiculo (id_usuario, id_veiculo, id_cliente, nm_cliente_func, dt_inicio, dt_fim, cd_slc_atend)
    VALUES (33, 33, 33, 'Pedro Lucas', TO_DATE('2021-04-17', 'YYYY-MM-DD'), TO_DATE('2021-07-18', 'YYYY-MM-DD'), 6030161903);


    INSERT INTO tb_cliente_veiculo (id_usuario, id_veiculo, id_cliente, nm_cliente_func, dt_inicio, dt_fim, cd_slc_atend)
    VALUES (34, 34, 34, 'Lívia', TO_DATE('2020-01-30', 'YYYY-MM-DD'), TO_DATE('2020-04-20', 'YYYY-MM-DD'), 6113944679);


    INSERT INTO tb_cliente_veiculo (id_usuario, id_veiculo, id_cliente, nm_cliente_func, dt_inicio, dt_fim, cd_slc_atend)
    VALUES (35, 35, 35, 'Leandro', TO_DATE('2022-07-30', 'YYYY-MM-DD'), TO_DATE('2023-07-04', 'YYYY-MM-DD'), 7643853291);


    INSERT INTO tb_cliente_veiculo (id_usuario, id_veiculo, id_cliente, nm_cliente_func, dt_inicio, dt_fim, cd_slc_atend)
    VALUES (36, 36, 36, 'Luna', TO_DATE('2022-03-15', 'YYYY-MM-DD'), TO_DATE('2022-12-25', 'YYYY-MM-DD'), 5379242657);


    INSERT INTO tb_cliente_veiculo (id_usuario, id_veiculo, id_cliente, nm_cliente_func, dt_inicio, dt_fim, cd_slc_atend)
    VALUES (37, 37, 37, 'Raquel', TO_DATE('2020-06-08', 'YYYY-MM-DD'), TO_DATE('2021-05-12', 'YYYY-MM-DD'), 52017582);


    INSERT INTO tb_cliente_veiculo (id_usuario, id_veiculo, id_cliente, nm_cliente_func, dt_inicio, dt_fim, cd_slc_atend)
    VALUES (38, 38, 38, 'Beatriz', TO_DATE('2022-12-18', 'YYYY-MM-DD'), TO_DATE('2023-09-18', 'YYYY-MM-DD'), 3805720003);


    INSERT INTO tb_cliente_veiculo (id_usuario, id_veiculo, id_cliente, nm_cliente_func, dt_inicio, dt_fim, cd_slc_atend)
    VALUES (39, 39, 39, 'Rebeca', TO_DATE('2023-05-10', 'YYYY-MM-DD'), TO_DATE('2023-08-15', 'YYYY-MM-DD'), 3205723240);


    INSERT INTO tb_cliente_veiculo (id_usuario, id_veiculo, id_cliente, nm_cliente_func, dt_inicio, dt_fim, cd_slc_atend)
    VALUES (40, 40, 40, 'Luiz Gustavo', TO_DATE('2020-04-05', 'YYYY-MM-DD'), TO_DATE('2020-05-26', 'YYYY-MM-DD'), 8040154714);


    INSERT INTO tb_cliente_veiculo (id_usuario, id_veiculo, id_cliente, nm_cliente_func, dt_inicio, dt_fim, cd_slc_atend)
    VALUES (41, 41, 41, 'Olivia', TO_DATE('2023-03-02', 'YYYY-MM-DD'), TO_DATE('2023-04-05', 'YYYY-MM-DD'), 9606432165);


    INSERT INTO tb_cliente_veiculo (id_usuario, id_veiculo, id_cliente, nm_cliente_func, dt_inicio, dt_fim, cd_slc_atend)
    VALUES (42, 42, 42, 'Maria Eduarda', TO_DATE('2022-06-24', 'YYYY-MM-DD'), TO_DATE('2022-08-10', 'YYYY-MM-DD'), 1293292018);


    INSERT INTO tb_cliente_veiculo (id_usuario, id_veiculo, id_cliente, nm_cliente_func, dt_inicio, dt_fim, cd_slc_atend)
    VALUES (43, 43, 43, 'Helena', TO_DATE('2021-01-05', 'YYYY-MM-DD'), TO_DATE('2021-05-03', 'YYYY-MM-DD'), 8337962115);


    INSERT INTO tb_cliente_veiculo (id_usuario, id_veiculo, id_cliente, nm_cliente_func, dt_inicio, dt_fim, cd_slc_atend)
    VALUES (44, 44, 44, 'Heitor', TO_DATE('2020-01-25', 'YYYY-MM-DD'), TO_DATE('2020-09-03', 'YYYY-MM-DD'), 6193144391);


    INSERT INTO tb_cliente_veiculo (id_usuario, id_veiculo, id_cliente, nm_cliente_func, dt_inicio, dt_fim, cd_slc_atend)
    VALUES (45, 45, 45, 'Davi Lucas', TO_DATE('2020-07-25', 'YYYY-MM-DD'), TO_DATE('2020-12-21', 'YYYY-MM-DD'), 8864503136);


    INSERT INTO tb_cliente_veiculo (id_usuario, id_veiculo, id_cliente, nm_cliente_func, dt_inicio, dt_fim, cd_slc_atend)
    VALUES (46, 46, 46, 'Clarice', TO_DATE('2020-03-11', 'YYYY-MM-DD'), TO_DATE('2020-11-14', 'YYYY-MM-DD'), 5353690370);

    -- inserindo na tabela tb_solicitacao_atendimento

    INSERT INTO tb_solicitacao_atendimento (id_solicitacao, id_problema, id_veiculo, id_cliente, cd_solicitacao, nm_solicitacao)
    VALUES (1, 1, 1, 1, 41, 'Troca de Óleo para Caminhão Volvo FH16');
    

    INSERT INTO tb_solicitacao_atendimento (id_solicitacao, id_problema, id_veiculo, id_cliente, cd_solicitacao, nm_solicitacao)
    VALUES (2, 2, 2, 2, 43, 'Revisão do Sistema de Freios do Kenworth W990');
    

    INSERT INTO tb_solicitacao_atendimento (id_solicitacao, id_problema, id_veiculo, id_cliente, cd_solicitacao, nm_solicitacao)
    VALUES (3, 3, 3, 3, 56, 'Substituição das Pastilhas de Freio - Scania R730');


    INSERT INTO tb_solicitacao_atendimento (id_solicitacao, id_problema, id_veiculo, id_cliente, cd_solicitacao, nm_solicitacao)
    VALUES (4, 4, 4, 4, 74, 'Diagnóstico de Falha no Motor - Mercedes-Benz Actros');


    INSERT INTO tb_solicitacao_atendimento (id_solicitacao, id_problema, id_veiculo, id_cliente, cd_solicitacao, nm_solicitacao)
    VALUES (5, 5, 5, 5, 51, 'Alinhamento e Balanceamento para Peterbilt 389');


    INSERT INTO tb_solicitacao_atendimento (id_solicitacao, id_problema, id_veiculo, id_cliente, cd_solicitacao, nm_solicitacao)
    VALUES (6, 6, 6, 6, 11, 'Troca de Bateria do MAN TGX');


    INSERT INTO tb_solicitacao_atendimento (id_solicitacao, id_problema, id_veiculo, id_cliente, cd_solicitacao, nm_solicitacao)
    VALUES (7, 7, 7, 7, 46, 'Reparo no Sistema Elétrico do International LoneStar');


    INSERT INTO tb_solicitacao_atendimento (id_solicitacao, id_problema, id_veiculo, id_cliente, cd_solicitacao, nm_solicitacao)
    VALUES (8, 8, 8, 8, 31, 'Verificação de Vazamento de Fluidos - Mack Anthem');


    INSERT INTO tb_solicitacao_atendimento (id_solicitacao, id_problema, id_veiculo, id_cliente, cd_solicitacao, nm_solicitacao)
    VALUES (9, 9, 9, 9, 9, 'Inspeção do Sistema de Transmissão - Freightliner Cascadia');


    INSERT INTO tb_solicitacao_atendimento (id_solicitacao, id_problema, id_veiculo, id_cliente, cd_solicitacao, nm_solicitacao)
    VALUES (10, 10, 10, 10, 67, 'Troca de Filtro de Ar para DAF XF');


    INSERT INTO tb_solicitacao_atendimento (id_solicitacao, id_problema, id_veiculo, id_cliente, cd_solicitacao, nm_solicitacao)
    VALUES (11, 11, 11, 11, 37, 'Ajuste da Suspensão - Renault T Range');


    INSERT INTO tb_solicitacao_atendimento (id_solicitacao, id_problema, id_veiculo, id_cliente, cd_solicitacao, nm_solicitacao)
    VALUES (12, 12, 12, 12, 27, 'Manutenção da Embreagem - Iveco Stralis');


    INSERT INTO tb_solicitacao_atendimento (id_solicitacao, id_problema, id_veiculo, id_cliente, cd_solicitacao, nm_solicitacao)
    VALUES (13, 13, 13, 13, 20, 'Substituição das Lâmpadas - Western Star 5700');


    INSERT INTO tb_solicitacao_atendimento (id_solicitacao, id_problema, id_veiculo, id_cliente, cd_solicitacao, nm_solicitacao)
    VALUES (14, 14, 14, 14, 54, 'Troca de Pneus para FAW Jiefang J7');


    INSERT INTO tb_solicitacao_atendimento (id_solicitacao, id_problema, id_veiculo, id_cliente, cd_solicitacao, nm_solicitacao)
    VALUES (15, 15, 15, 15, 70, 'Reparo na Caixa de Direção - Kamaz 5490');


    INSERT INTO tb_solicitacao_atendimento (id_solicitacao, id_problema, id_veiculo, id_cliente, cd_solicitacao, nm_solicitacao)
    VALUES (16, 16, 16, 16, 84, 'Diagnóstico do Sistema de Injeção - Tata Prima');


    INSERT INTO tb_solicitacao_atendimento (id_solicitacao, id_problema, id_veiculo, id_cliente, cd_solicitacao, nm_solicitacao)
    VALUES (17, 17, 17, 17, 65, 'Limpeza do Sistema de Escape - Isuzu Giga');


    INSERT INTO tb_solicitacao_atendimento (id_solicitacao, id_problema, id_veiculo, id_cliente, cd_solicitacao, nm_solicitacao)
    VALUES (18, 18, 18, 18, 5, 'Atualização de Software - Hino 700');


    INSERT INTO tb_solicitacao_atendimento (id_solicitacao, id_problema, id_veiculo, id_cliente, cd_solicitacao, nm_solicitacao)
    VALUES (19, 19, 19, 19, 91, 'Calibragem de Pneus - Mitsubishi Fuso Super Great');


    INSERT INTO tb_solicitacao_atendimento (id_solicitacao, id_problema, id_veiculo, id_cliente, cd_solicitacao, nm_solicitacao)
    VALUES (20, 20, 20, 20, 72, 'Verificação da Suspensão - Dongfeng KX');


    INSERT INTO tb_solicitacao_atendimento (id_solicitacao, id_problema, id_veiculo, id_cliente, cd_solicitacao, nm_solicitacao)
    VALUES (21, 21, 21, 21, 61, 'Diagnóstico de Problemas Elétricos - Scania S730');


    INSERT INTO tb_solicitacao_atendimento (id_solicitacao, id_problema, id_veiculo, id_cliente, cd_solicitacao, nm_solicitacao)
    VALUES (22, 22, 22, 22, 57, 'Revisão Geral do Volvo VNL');


    INSERT INTO tb_solicitacao_atendimento (id_solicitacao, id_problema, id_veiculo, id_cliente, cd_solicitacao, nm_solicitacao)
    VALUES (23, 23, 23, 23, 75, 'Manutenção do Sistema de Arrefecimento - Mercedes-Benz Arocs');


    INSERT INTO tb_solicitacao_atendimento (id_solicitacao, id_problema, id_veiculo, id_cliente, cd_solicitacao, nm_solicitacao)
    VALUES (24, 24, 24, 24, 80, 'Ajuste na Suspensão - Kenworth T880');


    INSERT INTO tb_solicitacao_atendimento (id_solicitacao, id_problema, id_veiculo, id_cliente, cd_solicitacao, nm_solicitacao)
    VALUES (25, 25, 25, 25, 7, 'Troca de Óleo e Filtros - Peterbilt 579');


    INSERT INTO tb_solicitacao_atendimento (id_solicitacao, id_problema, id_veiculo, id_cliente, cd_solicitacao, nm_solicitacao)
    VALUES (26, 26, 26, 26, 48, 'Verificação do Sistema de Ar Condicionado - MAN TGS');


    INSERT INTO tb_solicitacao_atendimento (id_solicitacao, id_problema, id_veiculo, id_cliente, cd_solicitacao, nm_solicitacao)
    VALUES (27, 27, 27, 27, 77, 'Substituição do Filtro de Combustível - International LT Series');


    INSERT INTO tb_solicitacao_atendimento (id_solicitacao, id_problema, id_veiculo, id_cliente, cd_solicitacao, nm_solicitacao)
    VALUES (28, 28, 28, 28, 88, 'Troca do Fluido de Transmissão - Mack Pinnacle');


    INSERT INTO tb_solicitacao_atendimento (id_solicitacao, id_problema, id_veiculo, id_cliente, cd_solicitacao, nm_solicitacao)
    VALUES (29, 29, 29, 29, 90, 'Inspeção da Direção Hidráulica - Freightliner Coronado');


    INSERT INTO tb_solicitacao_atendimento (id_solicitacao, id_problema, id_veiculo, id_cliente, cd_solicitacao, nm_solicitacao)
    VALUES (30, 30, 30, 30, 85, 'Troca de Lâmpadas de Freio - DAF CF');


    INSERT INTO tb_solicitacao_atendimento (id_solicitacao, id_problema, id_veiculo, id_cliente, cd_solicitacao, nm_solicitacao)
    VALUES (31, 31, 31, 31, 89, 'Verificação da Embreagem - Renault K Range');


    INSERT INTO tb_solicitacao_atendimento (id_solicitacao, id_problema, id_veiculo, id_cliente, cd_solicitacao, nm_solicitacao)
    VALUES (32, 32, 32, 32, 19, 'Manutenção Preventiva - Iveco Eurocargo');


    INSERT INTO tb_solicitacao_atendimento (id_solicitacao, id_problema, id_veiculo, id_cliente, cd_solicitacao, nm_solicitacao)
    VALUES (33, 33, 33, 33, 42, 'Revisão da Barra Estabilizadora - Western Star 4900');


    INSERT INTO tb_solicitacao_atendimento (id_solicitacao, id_problema, id_veiculo, id_cliente, cd_solicitacao, nm_solicitacao)
    VALUES (34, 34, 34, 34, 98, 'Substituição de Componentes do Chassi - FAW Jiefang J6P');


    INSERT INTO tb_solicitacao_atendimento (id_solicitacao, id_problema, id_veiculo, id_cliente, cd_solicitacao, nm_solicitacao)
    VALUES (35, 35, 35, 35, 3, 'Verificação do Sistema de Injeção - Kamaz 65201');


    INSERT INTO tb_solicitacao_atendimento (id_solicitacao, id_problema, id_veiculo, id_cliente, cd_solicitacao, nm_solicitacao)
    VALUES (36, 36, 36, 36, 17, 'Lubrificação do Chassi - Tata Ultra');


    INSERT INTO tb_solicitacao_atendimento (id_solicitacao, id_problema, id_veiculo, id_cliente, cd_solicitacao, nm_solicitacao)
    VALUES (37, 37, 37, 37, 45, 'Troca do Sistema de Freio - Isuzu F-Series');


    INSERT INTO tb_solicitacao_atendimento (id_solicitacao, id_problema, id_veiculo, id_cliente, cd_solicitacao, nm_solicitacao)
    VALUES (38, 38, 38, 38, 50, 'Inspeção do Sistema de Direção - Hino 500');


    INSERT INTO tb_solicitacao_atendimento (id_solicitacao, id_problema, id_veiculo, id_cliente, cd_solicitacao, nm_solicitacao)
    VALUES (39, 39, 39, 39, 8, 'Atualização do Software da Central Eletrônica - Mitsubishi Fuso Fighter');



    INSERT INTO tb_solicitacao_atendimento (id_solicitacao, id_problema, id_veiculo, id_cliente, cd_solicitacao, nm_solicitacao)
    VALUES (40, 40, 40, 40, 6, 'Limpeza do Sistema de Admissão - Dongfeng KL');


    INSERT INTO tb_solicitacao_atendimento (id_solicitacao, id_problema, id_veiculo, id_cliente, cd_solicitacao, nm_solicitacao)
    VALUES (41, 41, 41, 41, 95, 'Revisão Geral do Scania G450');


    INSERT INTO tb_solicitacao_atendimento (id_solicitacao, id_problema, id_veiculo, id_cliente, cd_solicitacao, nm_solicitacao)
    VALUES (42, 42, 42, 42, 82, 'Troca de Óleo da Transmissão - Volvo FMX');


    INSERT INTO tb_solicitacao_atendimento (id_solicitacao, id_problema, id_veiculo, id_cliente, cd_solicitacao, nm_solicitacao)
    VALUES (43, 43, 43, 43, 87, 'Diagnóstico Avançado - Mercedes-Benz Axor');


    INSERT INTO tb_solicitacao_atendimento (id_solicitacao, id_problema, id_veiculo, id_cliente, cd_solicitacao, nm_solicitacao)
    VALUES (44, 44, 44, 44, 53, 'Ajuste na Suspensão - Kenworth W900');


    INSERT INTO tb_solicitacao_atendimento (id_solicitacao, id_problema, id_veiculo, id_cliente, cd_solicitacao, nm_solicitacao)
    VALUES (45, 45, 45, 45, 83, 'Verificação do Sistema de Injeção - Peterbilt 567');


    INSERT INTO tb_solicitacao_atendimento (id_solicitacao, id_problema, id_veiculo, id_cliente, cd_solicitacao, nm_solicitacao)
    VALUES (46, 46, 46, 46, 44, 'Troca do Filtro de Ar - MAN TG-M');

    -- inserindo na tabela tb_guincho_solicitado

    INSERT INTO tb_guincho_solicitado (id_guincho_solicitado, id_veiculo, id_guincho, id_solicitacao, cd_guincho)
    VALUES (1, 1, 1, 1, 1);


    INSERT INTO tb_guincho_solicitado (id_guincho_solicitado, id_veiculo, id_guincho, id_solicitacao, cd_guincho)
    VALUES (2, 2, 2, 2, 2);


    INSERT INTO tb_guincho_solicitado (id_guincho_solicitado, id_veiculo, id_guincho, id_solicitacao, cd_guincho)
    VALUES (3, 3, 3, 3, 3);


    INSERT INTO tb_guincho_solicitado (id_guincho_solicitado, id_veiculo, id_guincho, id_solicitacao, cd_guincho)
    VALUES (4, 4, 4, 4, 4);


    INSERT INTO tb_guincho_solicitado (id_guincho_solicitado, id_veiculo, id_guincho, id_solicitacao, cd_guincho)
    VALUES (5, 5, 5, 5, 5);


    INSERT INTO tb_guincho_solicitado (id_guincho_solicitado, id_veiculo, id_guincho, id_solicitacao, cd_guincho)
    VALUES (6, 6, 6, 6, 6);


    INSERT INTO tb_guincho_solicitado (id_guincho_solicitado, id_veiculo, id_guincho, id_solicitacao, cd_guincho)
    VALUES (7, 7, 7, 7, 7);


    INSERT INTO tb_guincho_solicitado (id_guincho_solicitado, id_veiculo, id_guincho, id_solicitacao, cd_guincho)
    VALUES (8, 8, 8, 8, 8);


    INSERT INTO tb_guincho_solicitado (id_guincho_solicitado, id_veiculo, id_guincho, id_solicitacao, cd_guincho)
    VALUES (9, 9, 9, 9, 9);


    INSERT INTO tb_guincho_solicitado (id_guincho_solicitado, id_veiculo, id_guincho, id_solicitacao, cd_guincho)
    VALUES (10, 10, 10, 10, 10);


    INSERT INTO tb_guincho_solicitado (id_guincho_solicitado, id_veiculo, id_guincho, id_solicitacao, cd_guincho)
    VALUES (11, 11, 11, 11, 11);


    INSERT INTO tb_guincho_solicitado (id_guincho_solicitado, id_veiculo, id_guincho, id_solicitacao, cd_guincho)
    VALUES (12, 12, 12, 12, 12);


    INSERT INTO tb_guincho_solicitado (id_guincho_solicitado, id_veiculo, id_guincho, id_solicitacao, cd_guincho)
    VALUES (13, 13, 13, 13, 13);


    INSERT INTO tb_guincho_solicitado (id_guincho_solicitado, id_veiculo, id_guincho, id_solicitacao, cd_guincho)
    VALUES (14, 14, 14, 14, 14);


    INSERT INTO tb_guincho_solicitado (id_guincho_solicitado, id_veiculo, id_guincho, id_solicitacao, cd_guincho)
    VALUES (15, 15, 15, 15, 15);


    INSERT INTO tb_guincho_solicitado (id_guincho_solicitado, id_veiculo, id_guincho, id_solicitacao, cd_guincho)
    VALUES (16, 16, 16, 16, 16);


    INSERT INTO tb_guincho_solicitado (id_guincho_solicitado, id_veiculo, id_guincho, id_solicitacao, cd_guincho)
    VALUES (17, 17, 17, 17, 17);


    INSERT INTO tb_guincho_solicitado (id_guincho_solicitado, id_veiculo, id_guincho, id_solicitacao, cd_guincho)
    VALUES (18, 18, 18, 18, 18);


    INSERT INTO tb_guincho_solicitado (id_guincho_solicitado, id_veiculo, id_guincho, id_solicitacao, cd_guincho)
    VALUES (19, 19, 19, 19, 19);


    INSERT INTO tb_guincho_solicitado (id_guincho_solicitado, id_veiculo, id_guincho, id_solicitacao, cd_guincho)
    VALUES (20, 20, 20, 20, 20);


    INSERT INTO tb_guincho_solicitado (id_guincho_solicitado, id_veiculo, id_guincho, id_solicitacao, cd_guincho)
    VALUES (21, 21, 21, 21, 21);


    INSERT INTO tb_guincho_solicitado (id_guincho_solicitado, id_veiculo, id_guincho, id_solicitacao, cd_guincho)
    VALUES (22, 22, 22, 22, 22);


    INSERT INTO tb_guincho_solicitado (id_guincho_solicitado, id_veiculo, id_guincho, id_solicitacao, cd_guincho)
    VALUES (23, 23, 23, 23, 23);


    INSERT INTO tb_guincho_solicitado (id_guincho_solicitado, id_veiculo, id_guincho, id_solicitacao, cd_guincho)
    VALUES (24, 24, 24, 24, 24);


    INSERT INTO tb_guincho_solicitado (id_guincho_solicitado, id_veiculo, id_guincho, id_solicitacao, cd_guincho)
    VALUES (25, 25, 25, 25, 25);


    INSERT INTO tb_guincho_solicitado (id_guincho_solicitado, id_veiculo, id_guincho, id_solicitacao, cd_guincho)
    VALUES (26, 26, 26, 26, 26);


    INSERT INTO tb_guincho_solicitado (id_guincho_solicitado, id_veiculo, id_guincho, id_solicitacao, cd_guincho)
    VALUES (27, 27, 27, 27, 27);


    INSERT INTO tb_guincho_solicitado (id_guincho_solicitado, id_veiculo, id_guincho, id_solicitacao, cd_guincho)
    VALUES (28, 28, 28, 28, 28);


    INSERT INTO tb_guincho_solicitado (id_guincho_solicitado, id_veiculo, id_guincho, id_solicitacao, cd_guincho)
    VALUES (29, 29, 29, 29, 29);


    INSERT INTO tb_guincho_solicitado (id_guincho_solicitado, id_veiculo, id_guincho, id_solicitacao, cd_guincho)
    VALUES (30, 30, 30, 30, 30);


    INSERT INTO tb_guincho_solicitado (id_guincho_solicitado, id_veiculo, id_guincho, id_solicitacao, cd_guincho)
    VALUES (31, 31, 31, 31, 31);


    INSERT INTO tb_guincho_solicitado (id_guincho_solicitado, id_veiculo, id_guincho, id_solicitacao, cd_guincho)
    VALUES (32, 32, 32, 32, 32);


    INSERT INTO tb_guincho_solicitado (id_guincho_solicitado, id_veiculo, id_guincho, id_solicitacao, cd_guincho)
    VALUES (33, 33, 33, 33, 33);


    INSERT INTO tb_guincho_solicitado (id_guincho_solicitado, id_veiculo, id_guincho, id_solicitacao, cd_guincho)
    VALUES (34, 34, 34, 34, 34);


    INSERT INTO tb_guincho_solicitado (id_guincho_solicitado, id_veiculo, id_guincho, id_solicitacao, cd_guincho)
    VALUES (35, 35, 35, 35, 35);


    INSERT INTO tb_guincho_solicitado (id_guincho_solicitado, id_veiculo, id_guincho, id_solicitacao, cd_guincho)
    VALUES (36, 36, 36, 36, 36);


    INSERT INTO tb_guincho_solicitado (id_guincho_solicitado, id_veiculo, id_guincho, id_solicitacao, cd_guincho)
    VALUES (37, 37, 37, 37, 37);


    INSERT INTO tb_guincho_solicitado (id_guincho_solicitado, id_veiculo, id_guincho, id_solicitacao, cd_guincho)
    VALUES (38, 38, 38, 38, 38);


    INSERT INTO tb_guincho_solicitado (id_guincho_solicitado, id_veiculo, id_guincho, id_solicitacao, cd_guincho)
    VALUES (39, 39, 39, 39, 39);


    INSERT INTO tb_guincho_solicitado (id_guincho_solicitado, id_veiculo, id_guincho, id_solicitacao, cd_guincho)
    VALUES (40, 40, 40, 40, 40);


    INSERT INTO tb_guincho_solicitado (id_guincho_solicitado, id_veiculo, id_guincho, id_solicitacao, cd_guincho)
    VALUES (41, 41, 41, 41, 41);


    INSERT INTO tb_guincho_solicitado (id_guincho_solicitado, id_veiculo, id_guincho, id_solicitacao, cd_guincho)
    VALUES (42, 42, 42, 42, 42);


    INSERT INTO tb_guincho_solicitado (id_guincho_solicitado, id_veiculo, id_guincho, id_solicitacao, cd_guincho)
    VALUES (43, 43, 43, 43, 43);


    INSERT INTO tb_guincho_solicitado (id_guincho_solicitado, id_veiculo, id_guincho, id_solicitacao, cd_guincho)
    VALUES (44, 44, 44, 44, 44);


    INSERT INTO tb_guincho_solicitado (id_guincho_solicitado, id_veiculo, id_guincho, id_solicitacao, cd_guincho)
    VALUES (45, 45, 45, 45, 45);


    INSERT INTO tb_guincho_solicitado (id_guincho_solicitado, id_veiculo, id_guincho, id_solicitacao, cd_guincho)
    VALUES (46, 46, 46, 46, 46);


 -- Instrução SQL 1: Retornar detalhes do guincho solicitado

   SELECT
    gs.id_guincho_solicitado,
    gs.cd_guincho,
    g.nm_guincho,
    g.nr_guincho,
    gs.id_veiculo,
    gs.id_solicitacao
   FROM
    tb_guincho_solicitado gs
   JOIN
    tb_guincho g ON gs.id_guincho = g.id_guincho;
 --Descrição:
 --Esta instrução SQL retorna informações detalhadas sobre guinchos solicitados. 
 --Ela faz um JOIN entre as tabelas tb_guincho_solicitado e tb_guincho usando a condição ON gs.id_guincho = g.id_guincho. Isso permite obter detalhes como o nome do guincho, 
 --o número do guincho, o veículo associado e a solicitação correspondente.
   

    -- Instrução SQL 2: Retornar guinchos sem solicitações
    SELECT
    g.id_guincho,
    g.nm_guincho,
    g.nr_guincho
    FROM
    tb_guincho g
    LEFT JOIN
    tb_guincho_solicitado gs ON g.id_guincho = gs.id_guincho
    WHERE
    gs.id_guincho_solicitado IS NULL;

    --Descrição:
    --Esta instrução SQL retorna guinchos que ainda não foram solicitados. 
    --Ela utiliza um LEFT JOIN entre as tabelas tb_guincho e tb_guincho_solicitado, 
    --associando-as pela condição ON g.id_guincho = gs.id_guincho. 
    --O WHERE gs.id_guincho_solicitado IS NULL filtra os registros onde não há correspondência na tabela tb_guincho_solicitado, ou seja, guinchos que não foram solicitados.
    
    
    
    --Instrução SQL 3: Retornar detalhes do veículo associado a um cliente
    SELECT
    v.*,
    cv.id_usuario,
    cv.id_cliente,
    cv.nm_cliente_func,
    cv.dt_inicio,
    cv.dt_fim,
    cv.cd_slc_atend
    FROM
    tb_veiculo v
    JOIN
    tb_cliente_veiculo cv ON v.id_veiculo = cv.id_veiculo;


    --Descrição:
    --Esta instrução SQL retorna detalhes de veículos associados a clientes. 
    --Ela faz um JOIN entre as tabelas tb_veiculo e tb_cliente_veiculo usando a condição ON v.id_veiculo = cv.id_veiculo. 
    --Isso permite obter informações sobre o veículo, como tipo, data de fabricação, número de eixos, etc., 
    --juntamente com os detalhes do cliente associado ao veículo, como nome, datas de início e fim da associação e código de solicitação de atendimento.

    --Instrução SQL 2: Retornar usuários e veículos associados a clientes
    SELECT
    u.id_usuario,
    u.nr_cpf,
    u.nm_usuario,
    u.dt_nascimento,
    u.nm_rg,
    u.fl_sexo_biologico,
    u.ds_email,
    v.id_veiculo,
    v.tp_veiculo,
    v.dt_fabrica,
    v.nr_eixo,
    v.nr_peso,
    v.nr_altura,
    v.nr_comprimento,
    v.tp_chassi,
    v.dt_inicio as dt_inicio_veiculo,
    v.dt_fim as dt_fim_veiculo,
    cv.id_cliente,
    cv.nm_cliente_func,
    cv.dt_inicio as dt_inicio_cliente,
    cv.dt_fim as dt_fim_cliente,
    cv.cd_slc_atend
    FROM
    tb_usuario u
    JOIN
    tb_cliente_veiculo cv ON u.id_usuario = cv.id_usuario
    JOIN
    tb_veiculo v ON cv.id_veiculo = v.id_veiculo;


    --Descrição:
    --Esta instrução SQL retorna detalhes de usuários, veículos e clientes associados. 
    --Ela faz JOIN entre as tabelas tb_usuario, tb_cliente_veiculo e tb_veiculo usando as condições de associação adequadas 
    --(u.id_usuario = cv.id_usuario e cv.id_veiculo = v.id_veiculo). Isso permite obter informações sobre o usuário, veículo e cliente associados, 
    --incluindo detalhes sobre o veículo e as datas de início e fim da associação.


    SELECT * FROM TB_SOLICITACAO_ATENDIMENTO








 