DELIMITER //

CREATE PROCEDURE db_demo.sp_simulador_ahorro(
  IN p_monto DECIMAL(10,2),
  IN p_meses INT,
  IN p_tasa_interes DECIMAL(10,2)
)
BEGIN
  -- Declaración de variables
  DECLARE v_meses INT DEFAULT 0;
  DECLARE v_contr INT DEFAULT 0;
  DECLARE v_monto DECIMAL(10,2) DEFAULT 0;
  DECLARE v_tasa_interes DECIMAL(10,2) DEFAULT 0;
  DECLARE v_saldo DECIMAL(10,2) DEFAULT 0;
  DECLARE v_promedio DECIMAL(10,2) DEFAULT 0;
  DECLARE v_devengado DECIMAL(10,2) DEFAULT 0;
  DECLARE v_total DECIMAL(10,2) DEFAULT 0;
  DECLARE v_acumulador DECIMAL(10,2) DEFAULT 0;

  SET v_meses = p_meses;
  SET v_monto = p_monto;

  WHILE v_contr <= v_meses DO
      SET v_saldo = v_saldo + v_monto;

      -- Crear registro
      INSERT INTO db_demo.transacciones (Monto, Saldo, Promedio, Devengado, Total)
      VALUES (v_monto, v_saldo, v_promedio, v_devengado, v_total);

      -- Variable de control
      SET v_contr = v_contr + 1;
  END WHILE;

  SELECT "total", v_saldo;
END //

DELIMITER ;

/* Ejecutar el procedimiento */
CALL db_demo.sp_simulador_ahorro(350, 5, 0);

/* Mostrar  los resultados */
SELECT * FROM db_demo.transacciones;

/* para Eliminar el procedimiento existente y volver a crearlo


DROP PROCEDURE IF EXISTS db_demo.sp_simulador_ahorro;


*/