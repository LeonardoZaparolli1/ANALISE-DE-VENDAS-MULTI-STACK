-- Baseada nos produtos existentes na tabela VENDAS
-- Mantendo exatamente os mesmos nomes, categorias e preços unitários
-- Criação da tabela PRODUTOS

CREATE TABLE produtos (
    id_produto INTEGER PRIMARY KEY AUTOINCREMENT,
    nome_produto TEXT NOT NULL UNIQUE,
    categoria TEXT NOT NULL,
    preco_unitario DECIMAL(10,2) NOT NULL,
    quantidade_estoque INTEGER NOT NULL,
    estoque_minimo INTEGER NOT NULL,
    localizacao_estoque TEXT NOT NULL,
    setor_estoque TEXT NOT NULL,
    margem_lucro DECIMAL(5,2) NOT NULL, -- Percentual de margem de lucro
    custo_armazenagem DECIMAL(8,2) NOT NULL, -- Custo mensal de armazenagem
    fornecedor TEXT NOT NULL,
    data_ultima_entrada DATE NOT NULL,
    status_produto TEXT NOT NULL CHECK (status_produto IN ('Ativo', 'Inativo', 'Descontinuado')),
    peso_kg DECIMAL(6,2) NOT NULL,
    dimensoes TEXT NOT NULL -- formato: "LxAxP em cm"
);

-- Criação da tabela de clientes e inserção dos dados complementares
-- Baseada nos clientes existentes na tabela VENDAS
-- Dados fictícios criados com IA
-- Criação da tabela de clientes

CREATE TABLE clientes (
    id_cliente INTEGER PRIMARY KEY,
    nome_cliente TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    celular TEXT NOT NULL,
    idade INTEGER NOT NULL,
    data_cadastro DATE NOT NULL
);

-- Criação da tabela e inserção de registros de amostra 
-- Criação baseada no excel origem do projeto

CREATE TABLE vendas (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    data_venda DATE NOT NULL,
    id_cliente INTEGER NOT NULL,
    nome_cliente TEXT NOT NULL,
    estado TEXT NOT NULL,
    categoria TEXT NOT NULL,
    produto TEXT NOT NULL,
    quantidade INTEGER NOT NULL,
    preco_unitario DECIMAL(10,2) NOT NULL,
    total_venda DECIMAL(10,2) NOT NULL,
    Status_Cliente TEXT NOT NULL,
    ano INTEGER NOT NULL,
    mes INTEGER NOT NULL,
    dia INTEGER NOT NULL,
    dia_semana INTEGER NOT NULL,
    Ano_mês TEXT NOT NULL,
    lucro DECIMAL(10,2) NOT NULL,
    gastos DECIMAL(10,2) NOT NULL
);


-- Criação de índices para melhor performance
CREATE INDEX idx_produtos_categoria ON produtos(categoria);
CREATE INDEX idx_produtos_nome ON produtos(nome_produto);
CREATE INDEX idx_produtos_preco ON produtos(preco_unitario);
CREATE INDEX idx_produtos_estoque ON produtos(quantidade_estoque);
CREATE INDEX idx_produtos_localizacao ON produtos(localizacao_estoque);

-- Criação de índices para melhor performance
CREATE INDEX idx_clientes_email ON clientes(email);
CREATE INDEX idx_clientes_nome ON clientes(nome_cliente);
CREATE INDEX idx_clientes_idade ON clientes(idade);
CREATE INDEX idx_clientes_data_cadastro ON clientes(data_cadastro);

-- Criação de índices para melhor performance
CREATE INDEX idx_vendas_data ON vendas(data_venda);
CREATE INDEX idx_vendas_cliente ON vendas(id_cliente);
CREATE INDEX idx_vendas_estado ON vendas(estado);
CREATE INDEX idx_vendas_categoria ON vendas(categoria);
CREATE INDEX idx_vendas_produto ON vendas(produto);
