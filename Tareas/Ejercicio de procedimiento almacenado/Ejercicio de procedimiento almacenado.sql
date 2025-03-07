
DROP TABLE IF EXISTS transacciones;
DROP TABLE IF EXISTS cuentas;


/*Creación de la tabla de cuentas*/
CREATE TABLE cuentas (
    id_cuenta INT AUTO_INCREMENT PRIMARY KEY,
    numero_cuenta VARCHAR(20) UNIQUE NOT NULL,
    nombre_cliente VARCHAR(100) NOT NULL,
    total_debitos DECIMAL(10,2) DEFAULT 0.00,
    total_creditos DECIMAL(10,2) DEFAULT 0.00,
    saldo DECIMAL(10,2) DEFAULT 0.00
);

/*Creación de la tabla de transacciones*/
CREATE TABLE transacciones (
    id_transaccion INT AUTO_INCREMENT PRIMARY KEY,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    numero_cuenta VARCHAR(20) NOT NULL,
    tipo ENUM('debito', 'credito') NOT NULL,
    monto DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (numero_cuenta) REFERENCES cuentas(numero_cuenta)
);

/* Eliminar el procedimiento almacenado si ya existe */
DROP PROCEDURE IF EXISTS registrar_transaccion;

/* Crear el procedimiento almacenado */
DELIMITER $$

CREATE PROCEDURE registrar_transaccion(
    IN p_numero_cuenta VARCHAR(20),
    IN p_tipo ENUM('debito', 'credito'),
    IN p_monto DECIMAL(10,2)
)
BEGIN
    /* Insertar la transacción en la tabla transacciones */
    INSERT INTO transacciones (numero_cuenta, tipo, monto) 
    VALUES (p_numero_cuenta, p_tipo, p_monto);

    /* Actualizar la tabla cuentas según el tipo de transacción */
    IF p_tipo = 'credito' THEN
        UPDATE cuentas 
        SET total_creditos = total_creditos + p_monto,
            saldo = saldo + p_monto
        WHERE numero_cuenta = p_numero_cuenta;
    ELSEIF p_tipo = 'debito' THEN
        UPDATE cuentas 
        SET total_debitos = total_debitos + p_monto,
            saldo = saldo - p_monto
        WHERE numero_cuenta = p_numero_cuenta;
    END IF;
END $$

DELIMITER ;

/* registrar cuentas */
INSERT INTO cuentas (numero_cuenta, nombre_cliente, total_debitos, total_creditos, saldo) 
VALUES ('202100176', 'Kilvet', 0.00, 0.00, 0.00);
INSERT INTO cuentas (numero_cuenta, nombre_cliente, total_debitos, total_creditos, saldo) 
VALUES ('20010001', 'batman', 0.00, 0.00, 0.00);
INSERT INTO cuentas (numero_cuenta, nombre_cliente, total_debitos, total_creditos, saldo) 
VALUES ('20010002', 'Carlos', 0.00, 0.00, 0.00);
INSERT INTO cuentas (numero_cuenta, nombre_cliente, total_debitos, total_creditos, saldo) 
VALUES ('20010003', 'pedro', 0.00, 0.00, 0.00);
INSERT INTO cuentas (numero_cuenta, nombre_cliente, total_debitos, total_creditos, saldo) 
VALUES ('20010004', 'Saul', 0.00, 0.00, 0.00);
INSERT INTO cuentas (numero_cuenta, nombre_cliente, total_debitos, total_creditos, saldo) 
VALUES ('20010005', 'Robin', 0.00, 0.00, 0.00);

/* registrar transaccciones */
CALL registrar_transaccion('202100176', 'credito', 855.00);
CALL registrar_transaccion('20010001', 'credito', 800.00);
CALL registrar_transaccion('20010002', 'credito', 560.00);
CALL registrar_transaccion('20010003', 'credito', 1254.00);
CALL registrar_transaccion('20010004', 'credito', 15000.00);
CALL registrar_transaccion('20010005', 'credito', 256.00);


/* visalizar todos los datos */
SELECT * FROM cuentas;
SELECT * FROM transacciones;
/* visualizar datos especificos de la tabla transacciones  como en la imagen*/
SELECT 
    numero_cuenta,
    fecha,
    tipo,
    monto
FROM transacciones
WHERE tipo = 'credito';


/* visualizar datos especificos de la tabla cuentas como en la imagen*/
SELECT 
    numero_cuenta,
    total_creditos,
    total_debitos,
    saldo
FROM cuentas;




