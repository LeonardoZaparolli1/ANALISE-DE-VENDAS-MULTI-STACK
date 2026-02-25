-- consultas na tabela vendas

-- 1. Total de vendas por estado
SELECT estado, COUNT(*) as total_vendas, SUM(total_venda) as valor_total
FROM vendas 
GROUP BY estado 
ORDER BY valor_total DESC;

-- 2. Produtos mais vendidos
SELECT produto, SUM(quantidade) as quantidade_total, COUNT(*) as num_vendas
FROM vendas 
GROUP BY produto 
ORDER BY quantidade_total DESC;

-- 3. Vendas por categoria
SELECT categoria, COUNT(*) as total_vendas, SUM(total_venda) as faturamento
FROM vendas 
GROUP BY categoria 
ORDER BY faturamento DESC;

-- 4. Top 10 clientes por valor de compra
SELECT nome_cliente, SUM(total_venda) as valor_total, COUNT(*) as num_compras
FROM vendas 
GROUP BY id_cliente, nome_cliente 
ORDER BY valor_total DESC 
LIMIT 10;

-- 5. Vendas por mês
SELECT ano, mes, COUNT(*) as total_vendas, SUM(total_venda) as faturamento_mensal
FROM vendas 
GROUP BY ano, mes 
ORDER BY ano, mes;

-- consulta na tabela clientes

-- 1. Listar todos os clientes ordenados por nome
SELECT id_cliente, nome_cliente, email, celular, idade, data_cadastro
FROM clientes 
ORDER BY nome_cliente;

-- 2. Clientes por faixa etária
SELECT 
    CASE 
        WHEN idade < 25 THEN '18-24 anos'
        WHEN idade < 35 THEN '25-34 anos'
        WHEN idade < 45 THEN '35-44 anos'
        ELSE '45+ anos'
    END as faixa_etaria,
    COUNT(*) as total_clientes
FROM clientes 
GROUP BY 
    CASE 
        WHEN idade < 25 THEN '18-24 anos'
        WHEN idade < 35 THEN '25-34 anos'
        WHEN idade < 45 THEN '35-44 anos'
        ELSE '45+ anos'
    END
ORDER BY total_clientes DESC;

-- 3. Clientes cadastrados por mês
SELECT 
    strftime('%Y-%m', data_cadastro) as mes_cadastro,
    COUNT(*) as novos_clientes
FROM clientes 
GROUP BY strftime('%Y-%m', data_cadastro)
ORDER BY mes_cadastro;

-- 4. Idade média dos clientes
SELECT 
    ROUND(AVG(idade), 1) as idade_media,
    MIN(idade) as idade_minima,
    MAX(idade) as idade_maxima
FROM clientes;

-- 5. Buscar cliente por email
SELECT id_cliente, nome_cliente, celular, idade
FROM clientes 
WHERE email = 'brenda.monteiro@email.com';

-- Query para relacionar dados de clientes com vendas

SELECT 
    c.nome_cliente,
    c.email,
    c.celular,
    c.idade,
    COUNT(v.id) as total_compras,
    SUM(v.total_venda) as valor_total_compras,
    ROUND(AVG(v.total_venda), 2) as ticket_medio
FROM clientes c
LEFT JOIN vendas v ON c.id_cliente = v.id_cliente
GROUP BY c.id_cliente, c.nome_cliente, c.email, c.celular, c.idade
ORDER BY valor_total_compras DESC;

-- colsulta tabelas Produtos

-- 1. Verificar produtos com estoque baixo
SELECT nome_produto, categoria, quantidade_estoque, estoque_minimo,
       CASE 
           WHEN quantidade_estoque <= estoque_minimo THEN 'CRÍTICO'
           WHEN quantidade_estoque <= (estoque_minimo * 1.5) THEN 'BAIXO'
           ELSE 'NORMAL'
       END as status_estoque
FROM produtos
ORDER BY quantidade_estoque;

-- 2. Produtos por categoria com informações de armazenagem
SELECT categoria, 
       COUNT(*) as total_produtos,
       AVG(margem_lucro) as margem_media,
       SUM(custo_armazenagem) as custo_total_armazenagem
FROM produtos
GROUP BY categoria
ORDER BY custo_total_armazenagem DESC;

-- 3. Produtos mais lucrativos (por margem)
SELECT nome_produto, categoria, preco_unitario, margem_lucro,
       ROUND(preco_unitario * (margem_lucro/100), 2) as lucro_unitario
FROM produtos
ORDER BY margem_lucro DESC;

-- 4. Consulta de relacionamento: Vendas x Produtos 

SELECT v.data_venda, v.nome_cliente, v.estado, 
       p.nome_produto, p.categoria, v.quantidade,
       p.preco_unitario, v.total_venda,
       p.quantidade_estoque, p.localizacao_estoque
FROM vendas v
INNER JOIN produtos p ON v.produto = p.nome_produto
ORDER BY v.data_venda DESC;
*/

-- 5. Análise de estoque vs vendas

SELECT p.nome_produto, p.categoria,
       p.quantidade_estoque,
       COALESCE(SUM(v.quantidade), 0) as total_vendido,
       COUNT(v.id) as num_vendas
FROM produtos p
LEFT JOIN vendas v ON p.nome_produto = v.produto
GROUP BY p.id_produto, p.nome_produto, p.categoria
ORDER BY total_vendido DESC;
