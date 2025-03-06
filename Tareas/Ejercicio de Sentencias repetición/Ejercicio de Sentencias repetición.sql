DELIMITER //

CREATE PROCEDURE db_demo.sp_simulador_ahorro(
  IN p_monto DECIMAL(10,2),
  IN p_meses INT,
  IN p_tasa_interes DECIMAL(10,2)
)
BEGIN
  -- Declaración de variables
  DECLARE v_mes INT DEFAULT 1;
  DECLARE v_contr INT DEFAULT 0;
  DECLARE v_monto DECIMAL(10,2) DEFAULT 0;
  DECLARE v_saldo DECIMAL(10,2) DEFAULT 0;
  DECLARE v_promedio DECIMAL(10,2) DEFAULT 0;
  DECLARE v_devengado DECIMAL(10,2) DEFAULT 0;
  DECLARE v_total DECIMAL(10,2) DEFAULT 0;
  DECLARE v_acumulador DECIMAL(10,2) DEFAULT 0;

  SET v_monto = p_monto;

  -- Borrar registros anteriores en la tabla transacciones
  DELETE FROM db_demo.transacciones;

  -- Empezar ciclo para simular los meses
  WHILE v_contr < p_meses DO
      -- Acumulación del saldo
      SET v_saldo = v_saldo + v_monto;
      
      -- Calcular el promedio, devengado, y total (podrías ajustarlo según lo que necesites)
      SET v_promedio = v_saldo / (v_contr + 1);  -- Esto es solo un ejemplo
      SET v_devengado = v_saldo * (p_tasa_interes / 100);  -- Interés simple
      SET v_total = v_saldo + v_devengado;  -- Total con devengado

      -- Insertar un registro por cada mes
      INSERT INTO db_demo.transacciones (Mes, Monto, Saldo, Promedio, Devengado, Total)
      VALUES (v_mes, v_monto, v_saldo, v_promedio, v_devengado, v_total);

      -- Incrementar el mes y la variable de control
      SET v_mes = v_mes + 1;
      SET v_contr = v_contr + 1;
  END WHILE;

  -- Mostrar el total acumulado al final
  SELECT "total", v_saldo;

END //

DELIMITER ;

/* Ejecutar el procedimiento */
CALL db_demo.sp_simulador_ahorro(350, 5, 0);

/* Mostrar los resultados */
SELECT * FROM db_demo.transacciones;


/* para Eliminar el procedimiento existente y volver a crearlo


DROP PROCEDURE IF EXISTS db_demo.sp_simulador_ahorro;


*/