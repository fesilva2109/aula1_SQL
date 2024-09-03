DROP TABLE t_ckp_categoria CASCADE CONSTRAINTS;

DROP TABLE t_ckp_livro CASCADE CONSTRAINTS;

DROP TABLE t_ckp_autor_livro CASCADE CONSTRAINTS;

DROP TABLE t_ckp_autor CASCADE CONSTRAINTS;


CREATE TABLE t_ckp_categoria (
    cd_categoria          NUMBER(3)     NOT NULL,
    ds_sigla_categoria    CHAR(3)       NOT NULL,
    ds_categoria          VARCHAR2(30)  NOT NULL
);


ALTER TABLE t_ckp_categoria 
    ADD CONSTRAINT pk_ckp_categoria PRIMARY KEY (cd_categoria);

ALTER TABLE t_ckp_categoria 
    ADD CONSTRAINT un_ckp_categoria_sigla UNIQUE (ds_sigla_categoria);

ALTER TABLE t_ckp_categoria 
    ADD CONSTRAINT un_ckp_categoria_desc UNIQUE (ds_categoria);


CREATE TABLE t_ckp_livro (
    nr_isbn       NUMBER(8)     NOT NULL,
    cd_categoria  NUMBER(3)     NOT NULL,
    nm_titulo     VARCHAR2(50)  NOT NULL,
    ds_sinopse    VARCHAR2(200) NOT NULL,
    nr_edicao     NUMBER(2)     NOT NULL,
    nr_ano        NUMBER(4)     NOT NULL
);


ALTER TABLE t_ckp_livro 
    ADD CONSTRAINT pk_ckp_livro PRIMARY KEY (nr_isbn);

ALTER TABLE t_ckp_livro 
    ADD CONSTRAINT fk_ckp_livro_categoria FOREIGN KEY (cd_categoria) REFERENCES t_ckp_categoria(cd_categoria);

ALTER TABLE t_ckp_livro 
    ADD CONSTRAINT ck_ckp_livro_edicao CHECK (nr_edicao > 0);

ALTER TABLE t_ckp_livro 
    ADD CONSTRAINT ck_ckp_livro_ano CHECK (nr_ano > 0);


CREATE TABLE t_ckp_autor (
    cd_autor           NUMBER(3)     NOT NULL,
    nm_primeiro_autor  VARCHAR2(20)  NOT NULL,
    nm_segundo_autor   VARCHAR2(40)  NOT NULL
);


ALTER TABLE t_ckp_autor 
    ADD CONSTRAINT pk_ckp_autor PRIMARY KEY (cd_autor);


CREATE TABLE t_ckp_autor_livro (
    nr_isbn             NUMBER(8)     NOT NULL,
    cd_autor            NUMBER(3)     NOT NULL,
    st_autor_principal  NUMBER(1)     NOT NULL
);


ALTER TABLE t_ckp_autor_livro 
    ADD CONSTRAINT pk_ckp_autor_livro PRIMARY KEY (nr_isbn, cd_autor);

ALTER TABLE t_ckp_autor_livro 
    ADD CONSTRAINT fk_ckp_autor_livro FOREIGN KEY (nr_isbn) REFERENCES t_ckp_livro(nr_isbn);

ALTER TABLE t_ckp_autor_livro 
    ADD CONSTRAINT fk_ckp_autor_livro_autor FOREIGN KEY (cd_autor) REFERENCES t_ckp_autor(cd_autor);

ALTER TABLE t_ckp_autor_livro 
    ADD CONSTRAINT ck_ckp_autor_livro_status CHECK (st_autor_principal IN (1, 2));


-- 2.1
ALTER TABLE t_ckp_categoria RENAME COLUMN ds_sigla_categoria TO ds_sigla_categ;
DESC t_ckp_categoria;
-- 2.2 
ALTER TABLE t_ckp_categoria RENAME CONSTRAINT un_ckp_categoria_desc TO un_ckp_categ_desc;
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, SEARCH_CONDITION
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'T_CKP_CATEGORIA';

-- 2.3 
ALTER TABLE t_ckp_autor MODIFY (nm_segundo_autor VARCHAR2(30));
DESC t_ckp_autor;
-- 2.4
ALTER TABLE t_ckp_autor ADD (ds_email VARCHAR2(40) NOT NULL);
DESC t_ckp_autor;
-- 2.5
ALTER TABLE t_ckp_autor MODIFY (ds_email VARCHAR2(60) NULL);
DESC t_ckp_autor;
-- 2.6
ALTER TABLE t_ckp_autor_livro MODIFY (nr_isbn NUMBER(13));
DESC t_ckp_autor_livro;
-- 2.7
ALTER TABLE t_ckp_livro MODIFY (nr_isbn NUMBER(13));
DESC t_ckp_livro;
-- 2.8
ALTER TABLE t_ckp_autor ADD (nm_pais_origem VARCHAR2(30));
DESC t_ckp_autor;
-- 2.9
ALTER TABLE t_ckp_livro ADD CONSTRAINT un_ckp_livro_titulo UNIQUE (nm_titulo);
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, SEARCH_CONDITION
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'T_CKP_LIVRO';
-- 2.10
ALTER TABLE t_ckp_autor_livro DROP CONSTRAINT fk_ckp_autor_livro_autor;
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, SEARCH_CONDITION
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'T_CKP_AUTOR_LIVRO';
-- 2.11
ALTER TABLE t_ckp_livro DROP CONSTRAINT pk_ckp_livro CASCADE;
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, SEARCH_CONDITION
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'T_CKP_LIVRO';
-- 2.12
ALTER TABLE t_ckp_categoria DISABLE CONSTRAINT un_ckp_categoria_sigla;
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, SEARCH_CONDITION
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'T_CKP_CATEGORIA';