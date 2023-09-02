-- Criação do banco de dados
CREATE DATABASE oficinaDio;

-- Usar o banco de dados
USE oficinaDio;

-- Criação das tabelas
CREATE TABLE Cliente (
  idCliente INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(50),
  telefone VARCHAR(10)
);

CREATE TABLE Veiculo (
  idVeiculo INT AUTO_INCREMENT PRIMARY KEY,
  idCliente INT,
  modelo VARCHAR(50),
  ano INT,
  FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente)
);

CREATE TABLE Mecanico (
  idMecanico INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(50),
  especialidade VARCHAR(50)
);

CREATE TABLE Servico (
  idServico INT AUTO_INCREMENT PRIMARY KEY,
  idVeiculo INT,
  descricao VARCHAR(255),
  data DATE,
  valor DECIMAL(10, 2),
  FOREIGN KEY (idVeiculo) REFERENCES Veiculo(idVeiculo)
);

CREATE TABLE OrdemDeServico (
  idOrdemServico INT AUTO_INCREMENT PRIMARY KEY,
  idMecanico INT,
  idServico INT,
  data DATE,
  FOREIGN KEY (idMecanico) REFERENCES Mecanico(idMecanico),
  FOREIGN KEY (idServico) REFERENCES Servico(idServico)
);

CREATE TABLE Pagamento (
  idPagamento INT AUTO_INCREMENT PRIMARY KEY,
  valor DECIMAL(10, 2),
  data DATE,
  idServico INT,
  FOREIGN KEY (idServico) REFERENCES Servico(idServico)
);



-- Popular tabela Cliente
INSERT INTO Cliente (nome, telefone) VALUES
('João', '1234567890'),
('Maria', '9876543210'),
('Carlos', '5555555555');

-- Popular tabela Veiculo
INSERT INTO Veiculo (idCliente, modelo, ano) VALUES
(1, 'Gol', 2010),
(1, 'Civic', 2015),
(2, 'Uno', 2012),
(3, 'Fiesta', 2018);

-- Popular tabela Mecanico
INSERT INTO Mecanico (nome, especialidade) VALUES
('Pedro', 'Motor'),
('Ana', 'Suspensão'),
('Paulo', 'Freios');

-- Popular tabela Servico
INSERT INTO Servico (idVeiculo, descricao, data, valor) VALUES
(1, 'Troca de óleo', '2023-08-01', 100.00),
(2, 'Revisão completa', '2023-08-05', 300.00),
(3, 'Alinhamento', '2023-08-10', 50.00),
(4, 'Troca de pastilhas de freio', '2023-08-15', 80.00);

-- Popular tabela OrdemDeServico
INSERT INTO OrdemDeServico (idMecanico, idServico, data) VALUES
(1, 1, '2023-08-02'),
(2, 2, '2023-08-06'),
(3, 3, '2023-08-11'),
(1, 4, '2023-08-16');

-- Popular tabela Pagamento
INSERT INTO Pagamento (valor, data, idServico) VALUES
(100.00, '2023-08-02', 1),
(300.00, '2023-08-06', 2),
(50.00, '2023-08-11', 3),
(80.00, '2023-08-16', 4);



-- Recuperar todos os clientes
SELECT * FROM Cliente;

-- Recuperar todos os serviços
SELECT * FROM Servico;


-- Recuperar veículos com modelo 'Gol'
SELECT * FROM Veiculo WHERE modelo = 'Gol';

-- Recuperar serviços com valor acima de 100
SELECT * FROM Servico WHERE valor > 100.00;


-- Calcular o valor total pago em pagamentos
SELECT idServico, SUM(valor) AS valor_total_pago FROM Pagamento GROUP BY idServico;

-- Recuperar veículos ordenados por ano de forma decrescente
SELECT * FROM Veiculo ORDER BY ano DESC;

-- Recuperar serviços ordenados por data de forma crescente
SELECT * FROM Servico ORDER BY data;

-- Recuperar serviços com valor médio acima de 150
SELECT idVeiculo, AVG(valor) AS valor_medio FROM Servico GROUP BY idVeiculo HAVING valor_medio > 150.00;


-- Recuperar nome do cliente e modelo do veículo
SELECT c.nome, v.modelo FROM Cliente c
JOIN Veiculo v ON c.idCliente = v.idCliente;


-- Recuperar descrição do serviço e valor pago
SELECT s.descricao, p.valor FROM Servico s
JOIN Pagamento p ON s.idServico = p.idServico;


-- Recuperar modelo do veículo, descrição do serviço e data da ordem de serviço
SELECT v.modelo, s.descricao, o.data FROM Veiculo v
JOIN Servico s ON v.idVeiculo = s.idVeiculo
JOIN OrdemDeServico o ON s.idServico = o.idServico;