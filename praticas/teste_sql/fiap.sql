CREATE TABLE empregados (
    id INT PRIMARY KEY,
    nome VARCHAR(50),
    salario DECIMAL(10, 2),
    departamento VARCHAR(50)
);

INSERT ALL
    INTO empregados (id, nome, salario, departamento) VALUES (1, 'Alice', 5000.00, 'TI')
    INTO empregados (id, nome, salario, departamento) VALUES (2, 'Maria', 6000.00, 'PSICOLOGIA')
    INTO empregados (id, nome, salario, departamento) VALUES (3, 'Felipe', 7000.00, 'TI')
    INTO empregados (id, nome, salario, departamento) VALUES (4, 'Guilherme', 3000.00, 'TI')
    INTO empregados (id, nome, salario, departamento) VALUES (5, 'Beatriz', 6000.00, 'PSICOLOGIA')
SELECT * FROM dual;

