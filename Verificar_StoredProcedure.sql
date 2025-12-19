-- Script para verificar que el stored procedure venta_insertar tiene los parámetros correctos
-- Ejecutar este script para verificar

-- Verificar que las columnas existen en la tabla
SELECT 
    COLUMN_NAME,
    DATA_TYPE,
    CHARACTER_MAXIMUM_LENGTH,
    IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'venta' 
    AND COLUMN_NAME IN ('forma_pago', 'cuota')
ORDER BY COLUMN_NAME;

-- Verificar los parámetros del stored procedure
SELECT 
    p.name AS ParameterName,
    t.name AS ParameterType,
    p.max_length AS MaxLength,
    p.is_nullable AS IsNullable
FROM sys.parameters p
INNER JOIN sys.types t ON p.user_type_id = t.user_type_id
WHERE p.object_id = OBJECT_ID('venta_insertar')
ORDER BY p.parameter_id;

-- Ver el texto completo del stored procedure
SELECT 
    OBJECT_DEFINITION(OBJECT_ID('venta_insertar')) AS ProcedureDefinition;

