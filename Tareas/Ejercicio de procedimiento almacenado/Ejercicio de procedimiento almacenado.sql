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
VALUES ('200001', 'SAd', 0.00, 0.00, 1000.00);

/* registrar transaccciones */
CALL registrar_transaccion('200001', 'credito', 500.00);


/* visalizar todos los datos */
SELECT * FROM cuentas;
SELECT * FROM transacciones;


/* visualizar datos especificos de la tabla cuentas como en la imagen*/
SELECT 
    numero_cuenta,
    total_creditos,
    total_debitos,
    saldo
FROM cuentas;
/* visualizar datos especificos de la tabla transacciones  como en la imagen*/
SELECT 
    numero_cuenta,
    fecha,
    tipo,
    monto
FROM transacciones
WHERE tipo = 'credito';




