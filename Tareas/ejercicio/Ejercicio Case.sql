DELIMITER //

CREATE PROCEDURE sp_new_currency_case(
    IN p_currency_name VARCHAR(45),
    IN p_currency_symbol VARCHAR(45),
    IN p_exchange_rate DECIMAL(15,2),
    IN p_country VARCHAR(45),
    IN p_iso_code VARCHAR(45)
)
BEGIN
    /* Declaración de variables */
    DECLARE v_currency_name VARCHAR(45);
    DECLARE v_currency_symbol VARCHAR(45);
    DECLARE v_exchange_rate DECIMAL(15,2);
    DECLARE v_country VARCHAR(45);
    DECLARE v_iso_code VARCHAR(45);

    -- Asignación de valores a las variables
    SET v_currency_name = p_currency_name;
    SET v_currency_symbol = p_currency_symbol;
    SET v_exchange_rate = p_exchange_rate;
    SET v_country = p_country;
    SET v_iso_code = p_iso_code;


    CASE
        WHEN p_currency_name LIKE '%yen%' THEN 
            SET v_currency_symbol = '¥';  -- Símbolo del yen
        WHEN p_currency_name LIKE '%dolar%' THEN 
            SET v_currency_symbol = '$';  -- Símbolo del dólar
        WHEN p_currency_name LIKE '%peso%' THEN 
            SET v_currency_symbol = '₱';  -- Símbolo del peso
        WHEN p_currency_name LIKE '%euro%' THEN 
            SET v_currency_symbol = '€';  -- Símbolo del euro
        ELSE 
            SET v_currency_symbol = p_currency_symbol;  
    END CASE;


    INSERT INTO currencies (
        currency_name, 
        currency_symbol, 
        exchange_rate, 
        country, 
        iso_code
    )
    VALUES (
        v_currency_name, 
        v_currency_symbol, 
        v_exchange_rate, 
        v_country, 
        v_iso_code
    );

    COMMIT;

END //



