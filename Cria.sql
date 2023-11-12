-- Gerado por Oracle SQL Developer Data Modeler 23.1.0.087.0806
--   em:        2023-11-10 16:25:29 BRT
--   site:      Oracle Database 11g
--   tipo:      Oracle Database 11g





-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE tb__motorista (
    id_motorista     NUMBER(10) NOT NULL,
    id_guincho       NUMBER(6) NOT NULL,
    nm_motorista     NUMBER(10) NOT NULL,
    cd_motorista     NUMBER(10) NOT NULL,
    nr_cnh           NUMBER(14) NOT NULL,
    nm_categoria_cnh NUMBER(70) NOT NULL,
    dt_validade_cnh  DATE NOT NULL
);

ALTER TABLE tb__motorista ADD CONSTRAINT tb__motorista_pk PRIMARY KEY ( id_motorista );

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
    'Esta coluna irá receber o codigo interno para garantir o cadastro dos  Bairros da Cidade do Estado do Brasil. Seu conteúdo é obrigatório e único será preenchido automaticamente pelo sistema.'
    ;

COMMENT ON COLUMN tb_bairro.nm_bairro IS
    'Esta coluna irá receber o nome do Bairro  pertencente Cidade do Estado Brasileiro. O padrão de armazenmento é  InitCap e seu conteúdo é obrigatório. Essa tabela já será preenchida pela área responsável. Novas inseções necessitam ser avaladas pelos gestores.'
    ;

COMMENT ON COLUMN tb_bairro.nm_zona_bairro IS
    'Esta coluna irá receber a localização da zona onde se encontra o bairro. Alguns exemplos: Zona Norte, Zona Sul, Zona Leste, Zona Oeste, Centro.'
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
    'Esta coluna irá receber o codigo da cidade e seu conteúdo é obrigatório e será preenchido automaticamente pelo sistema.

';

COMMENT ON COLUMN tb_cidade.id_estado IS
    'Esta coluna irá receber o codigo interno para garantir unicidade dos Estados do Brasil. Seu conteúdo é obrigatório e único será preenchido automaticamente pelo sistema.'
    ;

COMMENT ON COLUMN tb_cidade.nm_cidade IS
    'Esta coluna irá receber o nome do Cidade pertencente ao Estado Brasileiro. O padrão de armazenmento é  InitCap e seu conteúdo é obrigatório. Essa tabela já será preenchida pela área responsável. Novas inseções necessitam ser avaladas pelos gestores.'
    ;

COMMENT ON COLUMN tb_cidade.cd_ibge IS
    'Esta coluna irá receber o código do IBGE que fornece informações para geração da NFe.';

ALTER TABLE tb_cidade ADD CONSTRAINT pk_cidade PRIMARY KEY ( id_cidade );

CREATE TABLE tb_cliente_veiculo (
    id_usuario      NUMBER(6) NOT NULL,
    id_veiculo      NUMBER(6) NOT NULL,
    id_cliente      NUMBER(10) NOT NULL,
    nm_cliente_func VARCHAR2(10) NOT NULL,
    dt_inicio       DATE NOT NULL,
    dt_fim          DATE NOT NULL,
    cd_slc_atend    NUMBER(10) NOT NULL
);

COMMENT ON COLUMN tb_cliente_veiculo.id_cliente IS
    'Está coluna se refere há identificação do cliente que é dona do veículo.';

COMMENT ON COLUMN tb_cliente_veiculo.nm_cliente_func IS
    'Está coluna irá identificar o nome da pessoa em posse do veícuilo.';

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
    'Esse atributo irá receber a chave primária do endereco do problema. Esse número é sequencia e gerado automaticamente pelo sistema. Seu conteúdo é obrigatório.'
    ;

COMMENT ON COLUMN tb_endereco_problema.id_logradouro IS
    'Esta coluna irá receber o codigo interno para garantir o lograouro, que esta localizado no  cadastro dos  Bairros da Cidade do Estado do Brasil. Seu conteúdo é obrigatório e único será preenchido automaticamente pelo sistema.'
    ;

COMMENT ON COLUMN tb_endereco_problema.nr_logradouro IS
    'Esse atributo irá receber o número do logradouro do endereco do problema.  Seu conteúdo é opcional.';

COMMENT ON COLUMN tb_endereco_problema.ds_complemento_numero IS
    'Esse atributo irá receber o complemeneto  do logradouro do endereco do problema. Seu conteúdo é opcional.';

COMMENT ON COLUMN tb_endereco_problema.ds_ponto_referencia IS
    'Esse atributo irá receber o ponto de referência do logradouro do endereco do problema.  Seu conteúdo é opcional.';

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
    'Esta coluna irá receber o codigo do usuário e seu conteúdo é obrigatório e será preenchido automaticamente pelo sistema.';

COMMENT ON COLUMN tb_endereco_usuario.id_logradouro IS
    'Esta coluna irá receber o codigo interno para garantir o lograouro, que esta localizado no  cadastro dos  Bairros da Cidade do Estado do Brasil. Seu conteúdo é obrigatório e único será preenchido automaticamente pelo sistema.'
    ;

COMMENT ON COLUMN tb_endereco_usuario.id_end_usuario IS
    'Esta coluna irá receber o codigo do endereço do usuário e seu conteúdo é obrigatório e será preenchido automaticamente pelo sistema.'
    ;

COMMENT ON COLUMN tb_endereco_usuario.nr_logradouro IS
    'Esta coluna irá receber o numero do endereço do usuario e seu conteúdo é obrigatório.';

COMMENT ON COLUMN tb_endereco_usuario.ds_complemento_numero IS
    'Esta coluna irá receber o complemento do endereço do usuario e seu conteúdo é opcional.';

COMMENT ON COLUMN tb_endereco_usuario.ds_ponto_referencia IS
    'Esta coluna irá receber o ponto de referencia do endereço e seu conteúdo é opcional.';

ALTER TABLE tb_endereco_usuario ADD CONSTRAINT pk_end_usuario PRIMARY KEY ( id_end_usuario );

CREATE TABLE tb_estado (
    id_estado   NUMBER(2) NOT NULL,
    sg_estado   CHAR(2) NOT NULL,
    nm_estado   VARCHAR2(30) NOT NULL,
    dt_cadastro DATE NOT NULL,
    nm_usuario  VARCHAR2(30) NOT NULL
);

COMMENT ON COLUMN tb_estado.id_estado IS
    'Esta coluna irá receber o codigo interno para garantir unicidade dos Estados do Brasil. Seu conteúdo é obrigatório e único será preenchido automaticamente pelo sistema.'
    ;

COMMENT ON COLUMN tb_estado.sg_estado IS
    'Esta coluna ira receber a siga do Estado. Esse conteúdo é obrigatório.';

COMMENT ON COLUMN tb_estado.nm_estado IS
    'Esta coluna irá receber o nome do estado. O padrão de armazenmento é  InitCap e seu conteúdo é obrigatório. Essa tabela já será preenchida pela área responsável. Novas inseções necessitam ser avaladas pelos gestores.'
    ;

ALTER TABLE tb_estado ADD CONSTRAINT pk_estado PRIMARY KEY ( id_estado );

CREATE TABLE tb_guincho (
    id_guincho NUMBER(6) NOT NULL,
    tp_guincho NUMBER(8) NOT NULL,
    nm_guincho NUMBER(10) NOT NULL,
    nr_guincho NUMBER(8) NOT NULL
);

COMMENT ON COLUMN tb_guincho.id_guincho IS
    'Esta coluna irá receber o codigo do guincho e seu conteúdo é obrigatório e será preenchido automaticamente pelo sistema.';

ALTER TABLE tb_guincho ADD CONSTRAINT pk_guincho PRIMARY KEY ( id_guincho );

CREATE TABLE tb_guincho_solicitado (
    id_guincho_solicitado NUMBER(6) NOT NULL,
    id_veiculo            NUMBER(6) NOT NULL,
    id_guincho            NUMBER(6) NOT NULL,
    id_solicitacao        NUMBER(10) NOT NULL,
    cd_guincho            NUMBER(10) NOT NULL
);

COMMENT ON COLUMN tb_guincho_solicitado.id_guincho_solicitado IS
    'Esta coluna irá receber o codigo do guincho escolhido e seu conteúdo é obrigatório e será preenchido automaticamente pelo sistema.'
    ;

COMMENT ON COLUMN tb_guincho_solicitado.id_veiculo IS
    'Esta coluna irá receber o codigo do veículo e seu conteúdo é obrigatório e será preenchido automaticamente pelo sistema.';

COMMENT ON COLUMN tb_guincho_solicitado.id_guincho IS
    'Esta coluna irá receber o codigo do guincho e seu conteúdo é obrigatório e será preenchido automaticamente pelo sistema.';

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
    'Esta coluna irá receber o codigo interno para garantir o lograouro, que esta localizado no  cadastro dos  Bairros da Cidade do Estado do Brasil. Seu conteúdo é obrigatório e único será preenchido automaticamente pelo sistema.'
    ;

COMMENT ON COLUMN tb_logradouro.id_bairro IS
    'Esta coluna irá receber o codigo interno para garantir o cadastro dos  Bairros da Cidade do Estado do Brasil. Seu conteúdo é obrigatório e único será preenchido automaticamente pelo sistema.'
    ;

COMMENT ON COLUMN tb_logradouro.nm_logradouro IS
    'Esta coluna irá receber o nome do lograoduro. O padrão de armazenmento é  InitCap e seu conteúdo é obrigatório. Essa tabela já será preenchida pela área responsável. Novas inseções necessitam ser avaladas pelos gestores.'
    ;

COMMENT ON COLUMN tb_logradouro.nr_cep IS
    'Esta coluna irá receber o número do CEP do lograoduro. O padrão de armazenmento é  numérico  e seu conteúdo é obrigatório. Essa tabela já será preenchida pela área responsável. Novas inseções necessitam ser avaladas pelos gestores.'
    ;

ALTER TABLE tb_logradouro ADD CONSTRAINT pk_logradouro PRIMARY KEY ( id_logradouro );

CREATE TABLE tb_problema (
    id_problema     NUMBER(6) NOT NULL,
    id_end_problema NUMBER(6) NOT NULL,
    id_usuario      NUMBER(6) NOT NULL,
    dt_problema     DATE NOT NULL
);

COMMENT ON COLUMN tb_problema.id_problema IS
    'Esta coluna irá receber o codigo do problema e seu conteúdo é obrigatório e será preenchido automaticamente pelo sistema.';

COMMENT ON COLUMN tb_problema.id_end_problema IS
    'Esse atributo irá receber a chave primária do endereco do problema. Esse número é sequencia e gerado automaticamente pelo sistema. Seu conteúdo é obrigatório.'
    ;

COMMENT ON COLUMN tb_problema.id_usuario IS
    'Esta coluna irá receber o codigo do usuário e seu conteúdo é obrigatório e será preenchido automaticamente pelo sistema.';

COMMENT ON COLUMN tb_problema.dt_problema IS
    'Esse atributo irá receber a data do problema. Seu conteúdo é obrigatório.';

CREATE UNIQUE INDEX tb_problema__idx ON
    tb_problema (
        id_end_problema
    ASC );

ALTER TABLE tb_problema ADD CONSTRAINT pk_problema PRIMARY KEY ( id_problema );

CREATE TABLE tb_solicitacao_atendimento (
    id_solicitacao NUMBER(10) NOT NULL,
    id_problema    NUMBER(6) NOT NULL,
    cd_solicitacao VARCHAR2(10) NOT NULL,
    id_veiculo     NUMBER(6) NOT NULL,
    id_cliente     NUMBER(10) NOT NULL,
    nm_solicitacao NUMBER(10) NOT NULL
);

COMMENT ON COLUMN tb_solicitacao_atendimento.id_solicitacao IS
    'Essa coluna irá receber a solicitação do problema e irá gerar um pedido de um guincho.';

COMMENT ON COLUMN tb_solicitacao_atendimento.cd_solicitacao IS
    'Essa coluna recebe o codigo da solicitação. feita pelo cliente, após a ocorrencia de ';

ALTER TABLE tb_solicitacao_atendimento ADD CONSTRAINT pk_solicitacao_atendimento PRIMARY KEY ( id_solicitacao );

ALTER TABLE tb_solicitacao_atendimento ADD CONSTRAINT uk_cd_solicitacao UNIQUE ( cd_solicitacao );

CREATE TABLE tb_telefone_usuario (
    id_telefone NUMBER(9) NOT NULL,
    id_usuario  NUMBER(6) NOT NULL,
    nr_ddi      NUMBER(3) NOT NULL,
    nr_ddd      NUMBER(3) NOT NULL,
    nr_telefone NUMBER(10) NOT NULL,
    tp_telefone VARCHAR2(20),
    st_telefone CHAR(1) NOT NULL
);

ALTER TABLE tb_telefone_usuario
    ADD CONSTRAINT ck_st_telefone CHECK ( st_telefone IN ( 'A', 'I' ) );

COMMENT ON COLUMN tb_telefone_usuario.id_telefone IS
    'Esse atributo irá receber a chave primária do telefone do paciente. Esse número é sequencial iniciando com 1 a partir do id do paciente e é  gerado automaticamente pelo sistema. Seu conteúdo é obrigatório.'
    ;

COMMENT ON COLUMN tb_telefone_usuario.id_usuario IS
    'Esta coluna irá receber o codigo do usuário e seu conteúdo é obrigatório e será preenchido automaticamente pelo sistema.';

COMMENT ON COLUMN tb_telefone_usuario.nr_ddi IS
    'Este atributo irá receber o número do DDI do telefone do  paciente. Seu conteudo é obrigatório.';

COMMENT ON COLUMN tb_telefone_usuario.nr_ddd IS
    'Esse atributo irá receber o número do DDD do telefone paciente.  Seu conteúdo é obrigatório.';

COMMENT ON COLUMN tb_telefone_usuario.nr_telefone IS
    'Esse atributo irá receber o número do telefone do  DDD do telefone paciente.  Seu conteúdo é obrigatório.';

COMMENT ON COLUMN tb_telefone_usuario.tp_telefone IS
    'Esse atributo irá receber o tipo do  telefone  do telefone paciente.  Seu conteúdo é obrigatório e os valores possiveis são: Comercial, Residencial, Recado e Celular'
    ;

COMMENT ON COLUMN tb_telefone_usuario.st_telefone IS
    'Esse atributo irá receber o status do telefone do paciente.  Seu conteúdo é obrigatório e deve possuir os seguintes valores: (A)tivo ou (I)nativo.'
    ;

ALTER TABLE tb_telefone_usuario ADD CONSTRAINT pk_telefone_usuario PRIMARY KEY ( id_telefone );

ALTER TABLE tb_telefone_usuario ADD CONSTRAINT ck_st_telefone UNIQUE ( st_telefone );

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
    'Esta coluna irá receber o codigo do usuário e seu conteúdo é obrigatório e será preenchido automaticamente pelo sistema.';

COMMENT ON COLUMN tb_usuario.nr_cpf IS
    'Esta coluna irá receber o CPF do usuário e seu conteúdo é obrigatório.';

COMMENT ON COLUMN tb_usuario.nm_usuario IS
    'Esta coluna irá receber o nome do usuário e seu conteúdo é obrigatório.';

COMMENT ON COLUMN tb_usuario.dt_nascimento IS
    'Esta coluna irá receber o data de nascimento do usuário e seu conteúdo é obrigatório.';

COMMENT ON COLUMN tb_usuario.nm_rg IS
    'Esta coluna irá receber o RG do usuário e seu conteúdo é obrigatório.';

COMMENT ON COLUMN tb_usuario.fl_sexo_biologico IS
    'Esta coluna irá receber o sexo biologico do usuário e seu conteúdo é obrigatório.';

COMMENT ON COLUMN tb_usuario.ds_email IS
    'Esta coluna irá receber o email do usuário e seu conteúdo é obrigatório.';

COMMENT ON COLUMN tb_usuario.ds_senha IS
    'Esta coluna irá receber a senha do usuário e seu conteúdo é obrigatório.';

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
    'Esta coluna irá receber o codigo do veículo e seu conteúdo é obrigatório e será preenchido automaticamente pelo sistema.';

COMMENT ON COLUMN tb_veiculo.tp_veiculo IS
    'Esta coluna irá receber o tipo de veículo  e seu conteúdo é obrigatório.';

COMMENT ON COLUMN tb_veiculo.dt_fabrica IS
    'Esta coluna irá receber a data de fabricação e seu conteúdo é obrigatório.';

COMMENT ON COLUMN tb_veiculo.nr_eixo IS
    'Esta coluna irá receber o número de eixos do veículo e seu conteúdo é obrigatório.';

COMMENT ON COLUMN tb_veiculo.nr_peso IS
    'Esta coluna irá receber o peso do veículo e seu conteúdo é obrigatório.';

COMMENT ON COLUMN tb_veiculo.nr_altura IS
    'Esta coluna irá receber a altura do veículo e seu conteúdo é obrigatório.';

COMMENT ON COLUMN tb_veiculo.nr_comprimento IS
    'Esta coluna irá receber o comprimento do veículo e seu conteúdo é obrigatório.';

COMMENT ON COLUMN tb_veiculo.tp_chassi IS
    'Esta coluna irá receber o tipo de chassi  do veículo e seu conteúdo é obrigatório.';

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



-- Relatório do Resumo do Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            15
-- CREATE INDEX                             1
-- ALTER TABLE                             38
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
