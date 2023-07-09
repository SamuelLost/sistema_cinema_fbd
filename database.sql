--CREATE DATABASE sistema_cinema;
SET datestyle TO SQL, DMY;
-- CREATE EXTENSION pgcrypto;
CREATE EXTENSION IF NOT EXISTS pgcrypto;
-- Tabela Cinema
CREATE TABLE Cinema (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(255) NOT NULL,
  endereco VARCHAR(255) NOT NULL,
  cidade VARCHAR(255) NOT NULL,
  uf VARCHAR(2) DEFAULT 'CE',
  cep VARCHAR(10) NOT NULL
);

-- Tabela Diretor
CREATE TABLE Diretor (
  id_diretor SERIAL PRIMARY KEY,
  nome_diretor VARCHAR(255) NOT NULL
);

-- Tabela Categoria
CREATE TABLE Categoria (
  id_cat SERIAL PRIMARY KEY,
  nome_cat VARCHAR(255) NOT NULL
);

-- Tabela Usuario
CREATE TABLE Usuario (
  id_usuario SERIAL PRIMARY KEY,
  cpf VARCHAR(11) UNIQUE NOT NULL,
  nome VARCHAR(255) NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  senha VARCHAR(255) NOT NULL,
  dt_nasc DATE NOT NULL,
  telefone VARCHAR(20) NOT NULL,
  genero CHAR(1) DEFAULT ' '
);

-- Tabela Sala
CREATE TABLE Sala (
  id_sala SERIAL PRIMARY KEY,
  qntd_assento INT  NOT NULL,
  nome VARCHAR(255) NOT NULL,
  id_cinema INT NOT NULL,
  FOREIGN KEY (id_cinema) REFERENCES Cinema (id)
);

-- Tabela Filme
CREATE TABLE Filme (
  id_filme SERIAL PRIMARY KEY,
  nome_original VARCHAR(255)  NOT NULL,
  nome_ptBR VARCHAR(255) DEFAULT ' ',
  ano_lanc INT NOT NULL,
  id_sala  INT NOT NULL,
  sessao TIMESTAMP NOT NULL,
  id_diretor INT NOT NULL,
  id_cat INT,
  sinopse TEXT NOT NULL,
  FOREIGN KEY (id_sala) REFERENCES Sala (id_sala),
  FOREIGN KEY (id_diretor) REFERENCES Diretor (id_diretor),
  FOREIGN KEY (id_cat) REFERENCES Categoria (id_cat)
);

-- Tabela Ingresso
CREATE TABLE Ingresso (
  id_ingresso SERIAL PRIMARY KEY,
  valor INT NOT NULL,
  data_de_compra TIMESTAMP NOT NULL,
  cpf_usuario VARCHAR(11) NOT NULL,
  id_filme INT NOT NULL,
  id_cinema INT NOT NULL,
  id_sala INT NOT NULL,
  FOREIGN KEY (cpf_usuario) REFERENCES Usuario (cpf),
  FOREIGN KEY (id_filme) REFERENCES Filme (id_filme),
  FOREIGN KEY (id_cinema) REFERENCES Cinema (id),
  FOREIGN KEY (id_sala) REFERENCES Sala (id_sala)
);

INSERT INTO Cinema (nome, endereco, cidade, uf, cep)
VALUES
  ('Cinema Francisco Lucena', 'Rua Herbas Cavalcante Pinheiro, 50', 'Limoeiro do Norte', 'CE', '62930-000'),
  ('Cinema Pinheiro Quixadá', 'Rua José de Queiroz Pessoa, 2500', 'Quixadá', 'CE', '63900-000'),
  ('CineCity', 'Rua C', 'Porto Alegre', 'RS', '87654-321'),
  ('CineTop', 'Avenida D', 'Belo Horizonte', 'MG', '54321-987'),
  ('CineStar', 'Rua E', 'Brasília', 'DF', '98765-432'),
  ('Cinema Deluxe', 'Avenida F', 'Salvador', 'BA', '45678-901'),
  ('CineMax', 'Rua G', 'Curitiba', 'PR', '89012-345'),
  ('CinePlus', 'Avenida H', 'Recife', 'PE', '21098-765'),
  ('CineFest', 'Rua I', 'Fortaleza', 'CE', '65432-109'),
  ('CineArt', 'Avenida J', 'Manaus', 'AM', '32109-876');

  -- Inserção de dados na tabela Diretor
INSERT INTO Diretor (nome_diretor) VALUES
  ('Steven Spielberg'),
  ('Christopher Nolan'),
  ('Quentin Tarantino'),
  ('David Fincher'),
  ('Joaquim Dos Santos'),
  ('Greta Gerwing'),
  ('Daniel Kwan'),
  ('James Cameron'),
  ('Bong Joon-ho'),
  ('James Gunn'),
  ('Todd Phillips'),
  ('Alfred Hitchcock');
  
-- Inserção de dados na tabela Categoria
INSERT INTO Categoria (nome_cat) VALUES
  ('Ação'),
  ('Comédia'),
  ('Drama'),
  ('Ficção Científica'),
  ('Terror'),
  ('Romance'),
  ('Animação'),
  ('Aventura'),
  ('Suspense'),
  ('Crime');

-- Inserção de dados na tabela Sala
INSERT INTO Sala (id_sala, qntd_assento, nome, id_cinema) VALUES
  (1, 100, 'Sala 1', 1),
  (2, 80, 'Sala 2', 1),
  (3, 120, 'Sala 1', 2),
  (4, 90, 'Sala 2', 2),
  (5, 150, 'Sala 1', 3),
  (6, 110, 'Sala 2', 3),
  (7, 130, 'Sala 1', 4),
  (8, 95, 'Sala 2', 4),
  (9, 140, 'Sala 1', 5),
  (10, 105, 'Sala 2', 5);

-- Inserção de dados na tabela Usuario
INSERT INTO Usuario (cpf, nome, email, senha, dt_nasc, telefone, genero) VALUES
  ('11111111111', 'João', 'joao@example.com', crypt('joao123', gen_salt('md5')), '01/02/1990', '123456789', 'M'),
  ('22222222222', 'Maria', 'maria@example.com', crypt('joao123', gen_salt('md5')), '02/03/1988', '88985895254', DEFAULT),
  ('33333333333', 'José', 'jose@example.com', crypt('jose123', gen_salt('md5')), '01/12/1998', '123456789', 'M'),
  ('44444444444', 'Samuel Henrique', 'samuelhenriq12@gmail.com', crypt('samuel123', gen_salt('md5')), '29/12/2000', '88982187279', 'M'),
  ('55555555555', 'Larissa Matos', 'larissa@example.com', crypt('larilarinomi', gen_salt('md5')), '12/01/2002', '94981519473', 'F'),
  ('66666666666', 'Mariana Lima', 'mariana@example.com', crypt('abcxyz', gen_salt('md5')), '1991-09-05', '123456789', 'F'),
  ('77777777777', 'Fernando Santos', 'fernando@example.com', crypt('senha789', gen_salt('md5')), '1987-12-08', '987654321', 'M'),
  ('88888888888', 'Carolina Costa', 'carolina@example.com', crypt('password123', gen_salt('md5')), '1993-06-30', '654321987', 'F'),
  ('99999999999', 'Lucas Oliveira', 'lucas@example.com', crypt('123456', gen_salt('md5')), '1986-04-15', '123456789', 'M'),
  ('12345678900', 'Camila Sousa', 'camila@example.com', crypt('qweasd', gen_salt('md5')), '1994-08-12', '987654321', 'F'),
  ('67667899899', 'Ana Clara', 'anaclara@example.com', crypt('qweasd', gen_salt('md5')), '14-10-2000', '9825684665', 'F');

-- Inserção de dados na tabela Filme
INSERT INTO Filme (nome_original, nome_ptBR, ano_lanc, id_sala, sessao, sinopse, id_diretor, id_cat) VALUES
  ('Joker', 'Coringa', 2019, 1, '20/06/2023 10:00', 'Arthur Fleck trabalha como palhaço para uma agência de talentos e, toda semana, precisa comparecer a uma agente social, devido aos seus conhecidos problemas mentais. Após ser demitido, Fleck reage mal à gozação de três homens em pleno metrô e os mata. Os assassinatos iniciam um movimento popular contra a elite de Gotham City, da qual Thomas Wayne é seu maior representante.', 11, 9),
  ('Parasite', 'Parasita', 2019, 2, '20/06/2023 10:00', 'Toda a família de Ki-taek está desempregada, vivendo num porão sujo e apertado. Uma obra do acaso faz com que o filho adolescente da família comece a dar aulas de inglês à garota de uma família rica. Fascinados com a vida luxuosa destas pessoas, pai, mãe, filho e filha bolam um plano para se infiltrarem também na família burguesa, um a um. No entanto, os segredos e mentiras necessários à ascensão social custarão caro a todos.', 9, 3),
  ('Oppenheimer', 'Oppenheimer', 2023, 1, '20/06/2023 13:00', 'O físico J. Robert Oppenheimer trabalha com uma equipe de cientistas durante o Projeto Manhattan, levando ao desenvolvimento da bomba atômica.', 2, 3),
  ('Interstellar', 'Interestelar', 2014, 2, '20/06/2023 13:00', 'As reservas naturais da Terra estão chegando ao fim e um grupo de astronautas recebe a missão de verificar possíveis planetas para receberem a população mundial, possibilitando a continuação da espécie.', 2, 4),
  ('Se7en', 'Se7ven - Os Sete Crimes Capitais', 1995, 1, '20/06/2023 16:00', 'A ponto de se aposentar, o detetive William Somerset pega um último caso, com a ajuda do recém-transferido David Mills. Juntos, descobrem uma série de assassinatos e logo percebem que estão lidando com um assassino que tem como alvo pessoas que ele acredita representar os sete pecados capitais.', 4, 9),
  ('Fight Clube', 'Clube da Luta', 1999, 2, '20/06/2023 16:00', 'Um homem deprimido que sofre de insônia conhece um estranho vendedor chamado Tyler Durden e se vê morando em uma casa suja depois que seu perfeito apartamento é destruído. A dupla forma um clube com regras rígidas onde homens lutam. A parceria perfeita é comprometida quando uma mulher, Marla, atrai a atenção de Tyler.', 4, 1),
  ('Catch Me If You Can', 'Prenda-me se For Capaz', 2003, 1, '21/06/2023 19:00', 'Frank Abagnale Jr. já trabalhou como médico, advogado e copiloto, tudo isso antes de completar 18 anos. Mestre na arte do disfarce, ele aproveita suas habilidades para viver a vida como quer e praticar golpes milionários, que fazem com que se torne o ladrão de banco mais bem-sucedido da história dos Estados Unidos com apenas 17 anos.', 1, 10),
  ('Spider-Man: Across the Spider-verse', 'Homem-Aranha: Através do Aranhaverso', 2023, 2, '21/06/2023 19:00', 'Depois de se reunir com Gwen Stacy, Homem-Aranha é jogado no multiverso, onde ele encontra uma equipe encarregada de proteger sua própria existência.', 5, 7),
  ('Everything Everywhere All at Once', 'Tudo em Todo o Lugar ao Mesmo Tempo', 2022, 1, '21/06/2023 22:00', 'Depois de se reunir com Gwen Stacy, Homem-Aranha é jogado no multiverso, onde ele encontra uma equipe encarregada de proteger sua própria existência.', 7, 2),
  ('Guardians of the Galaxy Vol. 3', 'Guardiões da Galáxia Vol. 3', 2023, 2, '21/06/2023 22:00', 'Peter Quill deve reunir sua equipe para defender o universo e proteger um dos seus. Se a missão não for totalmente bem-sucedida, isso pode levar ao fim dos Guardiões.', 10, NULL)
  ;

-- Inserção de dados na tabela Ingresso
INSERT INTO Ingresso (valor, data_de_compra, cpf_usuario, id_filme, id_cinema, id_sala) VALUES
  (20, '15/06/2023 10:00:00', '11111111111', 1, 1, 1),
  (20, '15/06/2023 10:00:00', '44444444444', 1, 1, 1),
  (20, '15/06/2023 10:00:00', '11111111111', 1, 1, 1),
  (20, '15/06/2023 10:00:00', '11111111111', 1, 1, 1),
  (20, '15/06/2023 10:00:00', '11111111111', 1, 1, 1),
  (20, '15/06/2023 10:00:00', '11111111111', 1, 1, 1),
  (20, '15/06/2023 10:00:00', '11111111111', 1, 1, 1),
  (20, '15/06/2023 10:00:00', '11111111111', 1, 1, 1),
  (20, '15/06/2023 10:00:00', '11111111111', 1, 1, 1),
  (20, '15/06/2023 10:00:00', '11111111111', 1, 1, 1),
  (20, '15/06/2023 10:00:00', '11111111111', 1, 1, 1),
  (20, '15/06/2023 12:00:00', '22222222222', 1, 1, 1),
  (20, '15/06/2023 12:00:00', '22222222222', 1, 1, 1),
  (20, '15/06/2023 12:00:00', '22222222222', 1, 1, 1),
  (20, '15/06/2023 12:00:00', '22222222222', 1, 1, 1),
  (20, '15/06/2023 12:00:00', '22222222222', 1, 1, 1),
  (20, '15/06/2023 12:00:00', '22222222222', 1, 1, 1),
  (20, '15/06/2023 12:00:00', '22222222222', 1, 1, 1),
  (20, '15/06/2023 12:00:00', '22222222222', 1, 1, 1),
  (20, '15/06/2023 12:00:00', '22222222222', 1, 1, 1),
  (20, '15/06/2023 12:00:00', '22222222222', 1, 1, 1),
  (20, '15/06/2023 14:00:00', '33333333333', 1, 1, 1),
  (20, '15/06/2023 14:00:00', '33333333333', 2, 1, 2),
  (20, '15/06/2023 14:00:00', '44444444444', 2, 1, 2),
  (20, '15/06/2023 14:00:00', '44444444444', 2, 1, 2),
  (20, '15/06/2023 14:00:00', '44444444444', 2, 1, 2),
  (20, '15/06/2023 14:00:00', '44444444444', 2, 1, 2),
  (20, '15/06/2023 14:00:00', '44444444444', 2, 1, 2),
  (20, '15/06/2023 14:00:00', '44444444444', 2, 1, 2),
  (20, '15/06/2023 14:00:00', '44444444444', 2, 1, 2),
  (20, '15/06/2023 14:00:00', '44444444444', 2, 1, 2),
  (20, '15/06/2023 14:00:00', '44444444444', 2, 1, 2),
  (20, '15/06/2023 14:00:00', '44444444444', 2, 1, 2),
  (20, '15/06/2023 14:00:00', '44444444444', 2, 1, 2),
  (20, '15/06/2023 14:00:00', '44444444444', 2, 1, 2),
  (20, '15/06/2023 14:00:00', '44444444444', 2, 1, 2),
  (20, '15/06/2023 14:00:00', '44444444444', 2, 1, 2),
  (20, '15/06/2023 14:00:00', '55555555555', 2, 1, 2),
  (20, '15/06/2023 14:00:00', '55555555555', 2, 1, 2);


-- Informação sobre os filmes cadastrados
SELECT f.nome_ptBR, dir.nome_diretor, f.ano_lanc, cat.nome_cat 
from filme f
JOIN Diretor dir ON f.id_diretor = dir.id_diretor
LEFT JOIN Categoria cat ON f.id_cat = cat.id_cat
ORDER BY f.ano_lanc DESC;

-- Quantos ingressos cada pessoa comprou para cada filme
-- SELECT u.nome, f.nome_ptBR, f.sessao, COUNT(*) as qntd, i.id_cinema, s.nome AS sala
-- FROM ingresso i
-- JOIN sala s ON s.id_sala = i.id_sala
-- JOIN usuario u ON u.cpf = i.cpf_usuario
-- JOIN filme f ON i.id_filme = f.id_filme
-- GROUP BY u.nome, i.valor,f.nome_ptBR, i.id_cinema, s.nome, f.sessao
-- ORDER BY u.nome;

-- Quantos ingressos cada pessoa comprou para cada filme
SELECT u.nome, f.nome_ptBR, COUNT(*) as qntd 
FROM ingresso i
JOIN sala s ON s.id_sala = i.id_sala
JOIN usuario u ON u.cpf = i.cpf_usuario
JOIN filme f ON i.id_filme = f.id_filme
GROUP BY u.nome, f.nome_ptBR
ORDER BY u.nome;


-- Top 3 de maiores compradores naquele cinema
-- Sem a cláusula WHERE a query mostra os maiores compradores do sistema
-- Com a cláusula WHERE a query mostra os maiores compradores daquele cinema específico
SELECT u.nome AS nome_usuario, SUM(i.valor) AS total_gasto
FROM usuario u
JOIN ingresso i ON u.cpf = i.cpf_usuario
JOIN cinema c ON c.id = i.id_cinema
--WHERE c.nome = 'Cinema Francisco Lucena'
GROUP BY u.nome
ORDER BY total_gasto DESC
LIMIT 3;

-- Filmes e seus ingressos vendidos 
SELECT f.nome_ptBR, COUNT(i.id_ingresso) AS quantidade_ingressos, sum(i.valor) as valor_arrecadado
FROM filme f
INNER JOIN ingresso i ON f.id_filme = i.id_filme
GROUP BY f.nome_ptBR
ORDER BY quantidade_ingressos DESC;

-- Quantas poltronas livres existem para aquele filme, sessão e Cinema.
SELECT c.nome, f.nome_ptBR, f.sessao, s.id_sala, s.qntd_assento - COUNT(i.id_ingresso) as poltronas_livres
FROM cinema c
JOIN sala s ON c.id = s.id_cinema
JOIN ingresso i ON i.id_sala = s.id_sala
JOIN filme f ON f.id_filme = i.id_filme
WHERE c.nome = 'Cinema Francisco Lucena' and f.nome_ptBR = 'Parasita'
GROUP BY c.nome, f.nome_ptBR, s.id_sala, f.id_filme
ORDER BY f.id_filme;

-- Cliente com idade maior que a média dos clientes 
-- Cliente são só aqueles que compraram ingresso
with idade_cliente AS (
SELECT u.nome, EXTRACT('year' FROM AGE(u.dt_nasc)) AS idade
FROM ingresso i 
JOIN usuario u ON i.cpf_usuario = u.cpf
GROUP BY u.nome, u.dt_nasc)

select ic.nome, ic.idade from idade_cliente ic
GROUP BY idade, nome
HAVING idade > (SELECT AVG(idade) FROM idade_cliente);

-- Diretores cadastrados, que tem algum filme vinculados a eles.
SELECT d.nome_diretor, f.nome_ptBR
FROM diretor d
JOIN filme f ON d.id_diretor = f.id_diretor
WHERE d.id_diretor IN (SELECT f.id_diretor FROM filme f)
GROUP BY d.nome_diretor, f.nome_ptBR;

SELECT f.nome_ptBR
FROM filme f
JOIN sala s ON f.id_sala = s.id_sala
JOIN cinema c ON c.id = s.id_cinema
WHERE c.nome = 'Cinema Francisco Lucena';

SELECT f.nome_ptBR, s.id_sala, f.sessao, s.qntd_assento - COUNT(i.id_ingresso) AS poltronas_livres
FROM filme f
JOIN sala s ON f.id_sala = s.id_sala
JOIN cinema c ON c.id = s.id_cinema
LEFT JOIN ingresso i ON i.id_filme = f.id_filme
WHERE c.nome = 'Cinema Francisco Lucena'
GROUP BY f.nome_ptBR, s.qntd_assento, f.sessao, s.id_sala, f.ano_lanc
ORDER BY f.ano_lanc DESC;

SELECT f.nome_ptBR, u.nome, i.data_de_compra, i.valor, s.id_sala
FROM filme f
JOIN ingresso i ON f.id_filme = i.id_filme
JOIN usuario u ON u.cpf = i.cpf_usuario
JOIN sala s ON s.id_sala = i.id_sala
WHERE f.nome_ptBR = 'Guardiões da Galáxia Vol. 3' and s.id_sala = 2;
