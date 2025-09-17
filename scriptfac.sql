-- *******************************
-- * Autor: Grupo ADSO 3171727   *
-- * Inst.: CARLOS EDUARDO PEREZ *
-- * Fecha: Septiembre de 2025   *
-- * Versión: 1.1                *
-- *******************************
--sdsssdsds
-----------------------------------------
-- SECCIÓN DDL DE SQL
-- MOSTRANDO CÓMO FUNCIONA EL SUBLENGUAJE
---------------------------------
DROP TABLE IF EXISTS tab_det_fac;
DROP TABLE IF EXISTS tab_enc_fac;
DROP TABLE IF EXISTS tab_ciudades;
DROP TABLE IF EXISTS tab_clientes;
DROP TABLE IF EXISTS tab_prod;

--TABLA DE PRODUCTOS

CREATE TABLE IF NOT EXISTS tab_prod
(
    id_prod     VARCHAR         NOT NULL, -- IDENTIFICADOR DE PRODUCTO
    ref_prod    VARCHAR,
    nom_prod    VARCHAR         NOT NULL, -- NOMBRE DE PRODUCTO
    val_costo   DECIMAL(8,0)    NOT NULL    DEFAULT 0,
    val_venta   DECIMAL(8,0)    NOT NULL    DEFAULT 0,
    PRIMARY KEY (id_prod)
);
--ALTER TABLE tab_prod ADD COLUMN ref_prod VARCHAR;
CREATE UNIQUE INDEX idx_ref_producto ON tab_prod(ref_prod);

CREATE TABLE IF NOT EXISTS tab_ciudades(
    id_ciudad   INTEGER     PRIMARY KEY,
    nom_ciudad  VARCHAR     NOT NULL
);

--TABLA DE CLIENTES
CREATE TABLE IF NOT EXISTS tab_clientes
(
    id_cliente  VARCHAR         NOT NULL, -- IDENTIFICADOR DE CLIENTE
    nom_cliente VARCHAR         NOT NULL, -- NOMBRE DE CLIENTE
    dir_cliente VARCHAR         NOT NULL,
    tel_cliente BIGINT          NOT NULL,
    cel_cliente BIGINT          NOT NULL,
    id_ciudad   INTEGER         NOT NULL,
    PRIMARY KEY (id_cliente),
    FOREIGN KEY (id_ciudad) REFERENCES tab_ciudades(id_ciudad)
);
CREATE INDEX idx_nom_cliente ON tab_clientes(nom_cliente);

--TABLA ENCABEZADO DE FACTURA HECHO POR MI
CREATE TABLE IF NOT EXISTS tab_enc_fac
(
    id_factura  DECIMAL(5,0)    NOT NULL,
    id_cliente  VARCHAR         NOT NULL,
    fec_factura DATE            NOT NULL,
    nom_ciudad  VARCHAR         NOT NULL,
    PRIMARY KEY(id_factura),
    FOREIGN KEY(id_cliente)     REFERENCES tab_clientes(id_cliente)
);

--TABLA DETALLE DE FACTURA
CREATE TABLE IF NOT EXISTS tab_det_fac
(
    id_factura  DECIMAL(5,0)    NOT NULL,
    id_prod     VARCHAR         NOT NULL,
    val_cant    DECIMAL(2,0)    NOT NULL,
    val_bruto   DECIMAL(8,0)    NOT NULL,
    PRIMARY KEY(id_factura,id_prod),
	FOREIGN KEY(id_factura)     REFERENCES tab_enc_fac(id_factura),
	FOREIGN KEY(id_prod)        REFERENCES tab_prod(id_prod)
);

-- OTRAS COSITAS DE SQL CON DDL
-- ALTER TABLE tab_clientes DROP COLUMN cel_cliente;
-- ALTER TABLE tab_clientes ADD COLUMN cel_cliente DECIMAL(10,0) NOT NULL;

-----------------------------------------
-- SECCIÓN DML DE SQL
-- MOSTRANDO CÓMO FUNCIONA EL SUBLENGUAJE
-----------------------------------------
INSERT INTO tab_ciudades (id_ciudad, nom_ciudad) VALUES (1,'Bogotá');
INSERT INTO tab_ciudades (id_ciudad, nom_ciudad) VALUES (2,'Bucaramanga');

INSERT INTO tab_clientes (id_cliente,nom_cliente,dir_cliente,tel_cliente,cel_cliente,id_ciudad) VALUES ('1','Carlos Eduardo Perez Rueeda','Calle 1',3101111111, 3101111112,1);
INSERT INTO tab_clientes VALUES ('2','Paula Sofia Perez','Calle 2',3102222222, 3102222223,1);
INSERT INTO tab_clientes VALUES ('3','Laura Juliana Perez','Calle 3',3103333333, 3103333334,1);

UPDATE tab_clientes 
SET nom_cliente = 'Paula Sofía Pérez'
WHERE tab_clientes.nom_cliente='Paula Sofia Perez';
