CREATE SCHEMA escola;

CREATE TABLE escola.dim_professor (
    professor_id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    titulo VARCHAR(50),
    data_contratacao DATE,
    email VARCHAR(100)
);

CREATE TABLE escola.dim_curso (
    curso_id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    departamento_id INTEGER,
    duracao INTEGER, -- duração em meses
    tipo VARCHAR(50) -- graduação, pós-graduação, etc.
);

CREATE TABLE escola.dim_departamento (
    departamento_id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    localizacao VARCHAR(100)
);

CREATE TABLE escola.dim_data (
    data_id SERIAL PRIMARY KEY,
    data DATE NOT NULL,
    ano INTEGER,
    mes INTEGER,
    dia INTEGER,
    trimestre INTEGER,
    semestre INTEGER
);

CREATE TABLE escola.fato_professor (
    fato_id SERIAL PRIMARY KEY,
    professor_id INTEGER REFERENCES escola.dim_professor(professor_id),
    curso_id INTEGER REFERENCES escola.dim_curso(curso_id),
    departamento_id INTEGER REFERENCES escola.dim_departamento(departamento_id),
    data_id INTEGER REFERENCES escola.dim_data(data_id),
    horas_ensino INTEGER,
    salario DECIMAL(10, 2)
);

INSERT INTO escola.dim_data (data, ano, mes, dia, trimestre, semestre)
VALUES
('2024-01-01', 2024, 1, 1, 1, 1),
('2024-01-02', 2024, 1, 2, 1, 1),
('2024-01-03', 2024, 1, 3, 1, 1);
-- continue inserindo os dados necessários


SELECT
    f.fato_id,
    p.nome AS professor_nome,
    c.nome AS curso_nome,
    d.nome AS departamento_nome,
    dt.data AS data,
    f.horas_ensino,
    f.salario
FROM
    escola.fato_professor f
JOIN
    escola.dim_professor p ON f.professor_id = p.professor_id
JOIN
    escola.dim_curso c ON f.curso_id = c.curso_id
JOIN
    escola.dim_departamento d ON f.departamento_id = d.departamento_id
JOIN
    escola.dim_data dt ON f.data_id = dt.data_id;
