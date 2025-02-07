SELECT t1.Country, t1.Product, t1.SalePrice, t1.ManufacturingPrice, t2.exchange_rate
FROM
    FinancialSample t1
JOIN
    Currencies t2 ON t1.Country = t2.country
WHERE
    t1.country = 'México'
    AND t1.Date BETWEEN '01/01/2014' AND '02/28/2014'
ORDER BY
    t1.Date, t1.Product;