CREATE DATABASE IF NOT EXISTS techshop;
USE techshop;

CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    data_cadastro DATE DEFAULT (CURRENT_DATE),
    CONSTRAINT pk_clientes PRIMARY KEY (id_cliente),
    CONSTRAINT unq_email_cliente UNIQUE (email)
);

CREATE TABLE produtos (
    id_product INT AUTO_INCREMENT, 
    nome_produto VARCHAR(100) NOT NULL,
    preco DECIMAL(10, 2) NOT NULL,
    estoque INT NOT NULL,
    CONSTRAINT pk_produtos PRIMARY KEY (id_product)
);

CREATE TABLE pedidos (
    id_pedido INT AUTO_INCREMENT,
    id_cliente INT NOT NULL,
    data_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status_pedido VARCHAR(20) DEFAULT 'Pendente',
    CONSTRAINT pk_pedidos PRIMARY KEY (id_pedido),
    CONSTRAINT fk_pedidos_clientes FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente) ON DELETE CASCADE
);

CREATE TABLE itens_pedido (
    id_pedido INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10, 2) NOT NULL,
    CONSTRAINT pk_itens_pedido PRIMARY KEY (id_pedido, id_produto),
    CONSTRAINT fk_itens_pedido FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido) ON DELETE CASCADE
);

ALTER TABLE produtos CHANGE id_product id_produto INT AUTO_INCREMENT;
ALTER TABLE itens_pedido ADD CONSTRAINT fk_itens_produtos FOREIGN KEY (id_produto) REFERENCES produtos(id_produto);
ALTER TABLE produtos ADD categoria VARCHAR(50) NOT NULL DEFAULT 'Geral';

INSERT INTO clientes (nome, email, data_cadastro) VALUES
('Ana Silva', 'ana.silva@email.com', '2026-01-10'),
('Bruno Costa', 'bruno.costa@email.com', '2026-02-15'),
('Carlos Souza', 'carlos.souza@email.com', '2026-03-01'),
('Diana Souza', 'diana.souza@email.com', '2026-03-15');

INSERT INTO produtos (nome_produto, preco, estoque, categoria) VALUES
('Notebook Gamer', 4500.00, 10, 'Eletrônicos'),
('Smartphone 5G', 2500.00, 25, 'Eletrônicos'),
('Mouse Sem Fio', 150.00, 50, 'Acessórios'),
('Teclado Mecânico', 350.00, 0, 'Acessórios'),
('Cadeira Ergonômica', 1200.00, 8, 'Móveis');

INSERT INTO pedidos (id_cliente, status_pedido) VALUES
(1, 'Concluído'),
(2, 'Concluído'),
(3, 'Pendente'),
(1, 'Concluído');

INSERT INTO itens_pedido (id_pedido, id_produto, quantidade, preco_unitario) VALUES
(1, 1, 1, 4500.00),
(1, 3, 2, 150.00),
(2, 2, 1, 2500.00),
(3, 4, 1, 350.00),
(4, 5, 1, 1200.00);

UPDATE produtos SET preco = preco * 1.10 WHERE categoria = 'Acessórios';

INSERT INTO clientes (nome, email) VALUES ('Teste Apagar', 'teste@apagar.com');
DELETE FROM clientes WHERE email = 'teste@apagar.com';

ALTER TABLE clientes ADD telefone VARCHAR(15);

-- 2. Manipulação: Atualizar o telefone da cliente 'Ana Silva'
UPDATE clientes SET telefone = '(11) 99999-9999' WHERE nome = 'Ana Silva';

SELECT c.id_cliente, c.nome, c.email
FROM clientes c
LEFT JOIN pedidos p ON c.id_cliente = p.id_cliente
WHERE p.id_pedido IS NULL;
