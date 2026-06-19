-- ====================================================================
-- 1. CRIAÇÃO DAS TABELAS INDEPENDENTES
-- ====================================================================

CREATE TABLE projeto (
    id_projeto INTEGER NOT NULL,
    nome VARCHAR(255),
    numero_processo VARCHAR(100), -- Número do pen-sie
    numero_projeto VARCHAR(100),  -- Registro nacional / portal
    data_inicio TIMESTAMP,
    data_termino TIMESTAMP,
    -- Simulação do ENUM via CHECK CONSTRAINT no DB2
    portal_projetos_classificacao VARCHAR(50) CONSTRAINT chk_classificacao 
        CHECK (portal_projetos_classificacao IN ('pesquisa', 'extensão', 'ensino', 'desenvolvimento institucional')),
    portal_projetos_resumo VARCHAR(2000),
    portal_projetos_objetivo VARCHAR(2000),
    portal_projetos_justificativa VARCHAR(2000),
    portal_projetos_resultados_esperados VARCHAR(2000),
    PRIMARY KEY (id_projeto)
);

CREATE TABLE fonte (
    id_fonte INTEGER NOT NULL,
    orgao_financiador VARCHAR(255), 
    valor_total_recebido FLOAT,
    PRIMARY KEY (id_fonte)
);

CREATE TABLE fundacao (
    id_fundacao INTEGER NOT NULL,
    cnpj VARCHAR(20),
    nome VARCHAR(255),
    endereco VARCHAR(255), 
    cidade VARCHAR(100),
    uf VARCHAR(2),
    cep VARCHAR(15),
    ddd_fax_fone VARCHAR(50),
    PRIMARY KEY (id_fundacao)
);
-- TODO talvez cpf seja melhor como chave primária. apesar de ser varchar
CREATE TABLE pessoas (
    id_pessoa INTEGER NOT NULL,
    nome VARCHAR(255),
    matricula VARCHAR(50) DEFAULT NULL,
    cpf VARCHAR(20) DEFAULT NULL,
    rg VARCHAR(20) DEFAULT NULL,
    PRIMARY KEY (id_pessoa)
);

CREATE TABLE papeis (
    id_papel INTEGER NOT NULL,
    nome VARCHAR(255),
    PRIMARY KEY (id_papel)
);

-- ====================================================================
-- 2. CRIAÇÃO DAS TABELAS DEPENDENTES
-- ====================================================================

CREATE TABLE uso (
    id_uso INTEGER NOT NULL,
    id_projeto INTEGER,
    percentual_custeio INTEGER,
    percentual_investimento INTEGER,
    percentual_fundacao INTEGER,
    percentual_ufsm INTEGER,
    PRIMARY KEY (id_uso),
    FOREIGN KEY (id_projeto) REFERENCES projeto(id_projeto)
);
-- Lista de onde o recurso está sendo aplicado, ou seja, onde o recurso está sendo gasto.
CREATE TABLE aplicacao (
    id_aplicacao INTEGER NOT NULL,
    id_projeto INTEGER,
    nome_aplicacao VARCHAR(255),
    valor_executado_ufsm FLOAT,
    valor_executado_fundacao FLOAT,
    valor_executado_outros FLOAT,
    valor_total_executado FLOAT,
    PRIMARY KEY (id_aplicacao),
    FOREIGN KEY (id_projeto) REFERENCES projeto(id_projeto)
);

CREATE TABLE instrumento (
    id_instrumento INTEGER NOT NULL,
    -- Simulação do ENUM via CHECK CONSTRAINT
    tipo VARCHAR(20) CONSTRAINT chk_tipo_instrumento 
        CHECK (tipo IN ('convênio', 'contrato')),
    id_projeto INTEGER NOT NULL,
    id_fundacao INTEGER DEFAULT NULL,
    id_fonte INTEGER DEFAULT NULL,
    recursos_totais FLOAT, -- valor do presente instrumento
    -- dados fiscais do instrumento(convenio/contrato), sempre são únicos para cada instrumento
    funcional_programatica VARCHAR(18),
    ptres VARCHAR(6), -- é um código de 6 dígitos
    fonte VARCHAR(12), -- é um código de 12 dígitos
    empenho VARCHAR(12), -- é um código de 12 dígitos
    PRIMARY KEY (id_instrumento),
    FOREIGN KEY (id_projeto) REFERENCES projeto(id_projeto),
    FOREIGN KEY (id_fundacao) REFERENCES fundacao(id_fundacao),
    FOREIGN KEY (id_fonte) REFERENCES fonte(id_fonte)
);

-- Tabela associativa com chave primária composta
    -- funcao_dirigente existe porque cada fundação tem uma numenclatura diferente pro cargo do seu dirigente
    -- id_fundacao existe para fazer o vinculo com a tabela fundacao
CREATE TABLE pessoas_para_papeis (
    id_pessoa INTEGER NOT NULL,
    id_projeto INTEGER NOT NULL,
    id_papel INTEGER NOT NULL,
    id_fundacao INTEGER,
    inicio_vinculo DATE NOT NULL,
    fim_vinculo DATE NOT NULL,
    remuneracao_mensal FLOAT,
    carga_horaria INTEGER,
    funcao_dirigente VARCHAR(255) DEFAULT NULL,
    PRIMARY KEY (id_pessoa, id_projeto, id_papel),
    FOREIGN KEY (id_pessoa) REFERENCES pessoas(id_pessoa),
    FOREIGN KEY (id_projeto) REFERENCES projeto(id_projeto),
    FOREIGN KEY (id_papel) REFERENCES papeis(id_papel),
    FOREIGN KEY (id_fundacao) REFERENCES fundacao(id_fundacao)
);