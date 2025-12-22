-- =============================================
-- EJEMPLO: Script para cambiar el orden de parámetros
-- en el stored procedure venta_insertar
-- =============================================
-- Este script muestra cómo reordenar los parámetros
-- Puedes adaptarlo según tus necesidades
-- =============================================

-- =============================================
-- ORDEN ACTUAL de parámetros (ejemplo):
-- =============================================
-- 1. @idusuario
-- 2. @idcliente
-- 3. @total
-- 4. @forma_pago
-- 5. @cuota
-- 6. @moneda
-- 7. @detalle
-- =============================================

-- Eliminar el stored procedure existente
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[venta_insertar]') AND type in (N'P', N'PC'))
    DROP PROCEDURE [dbo].[venta_insertar];
GO

-- =============================================
-- NUEVO ORDEN de parámetros (ejemplo):
-- Puedes cambiar el orden según lo necesites
-- =============================================
CREATE PROCEDURE [dbo].[venta_insertar]
    -- Orden nuevo: primero los datos de pago
    @forma_pago varchar(50),        -- Movido de posición 4 a 1
    @cuota varchar(20),              -- Movido de posición 5 a 2
    @moneda varchar(20),             -- Movido de posición 6 a 3
    -- Luego los datos principales
    @idcliente int,                  -- Movido de posición 2 a 4
    @idusuario int,                  -- Movido de posición 1 a 5
    @total decimal(11,2),            -- Movido de posición 3 a 6
    -- Al final el detalle
    @detalle type_detalle_venta READONLY  -- Se mantiene al final
AS
BEGIN
    -- IMPORTANTE: Asegúrate de que el orden en el INSERT
    -- coincida con el orden de las columnas en la tabla,
    -- NO con el orden de los parámetros
    
    INSERT INTO venta (
        idusuario,      -- Columna en la tabla
        idcliente,      -- Columna en la tabla
        fecha,          -- Columna en la tabla
        total,          -- Columna en la tabla
        estado,         -- Columna en la tabla
        forma_pago,     -- Columna en la tabla
        cuota,          -- Columna en la tabla
        moneda          -- Columna en la tabla
    )
    VALUES (
        @idusuario,     -- Usa el parámetro, no importa su posición en la definición
        @idcliente,     -- Usa el parámetro, no importa su posición en la definición
        GETDATE(),      -- Valor automático
        @total,         -- Usa el parámetro, no importa su posición en la definición
        'Aceptado',     -- Valor fijo
        @forma_pago,    -- Usa el parámetro, no importa su posición en la definición
        @cuota,         -- Usa el parámetro, no importa su posición en la definición
        @moneda         -- Usa el parámetro, no importa su posición en la definición
    );
    
    INSERT detalle_venta (idventa,idarticulo,cantidad,precio,descuento)
    SELECT @@IDENTITY,d.idarticulo,d.cantidad,d.precio,d.descuento
    FROM @detalle d;
END
GO

-- =============================================
-- NOTAS IMPORTANTES:
-- =============================================
-- 1. El orden de los parámetros en la definición del SP
--    solo afecta cómo se llaman desde el código
-- 
-- 2. El orden en el INSERT debe coincidir con el orden
--    de las COLUMNAS en la tabla, no con los parámetros
--
-- 3. Si usas nombres de parámetros al llamar el SP,
--    el orden no importa:
--    EXEC venta_insertar 
--        @detalle = @miDetalle,
--        @total = 1000,
--        @idusuario = 1,
--        @idcliente = 2,
--        @forma_pago = 'Efectivo',
--        @cuota = '1',
--        @moneda = 'PEN'
--
-- 4. Si NO usas nombres de parámetros, debes respetar
--    el orden definido en el SP:
--    EXEC venta_insertar 
--        'Efectivo',  -- @forma_pago (posición 1)
--        '1',         -- @cuota (posición 2)
--        'PEN',       -- @moneda (posición 3)
--        2,           -- @idcliente (posición 4)
--        1,           -- @idusuario (posición 5)
--        1000,        -- @total (posición 6)
--        @miDetalle   -- @detalle (posición 7)
-- =============================================

PRINT 'Stored procedure venta_insertar actualizado con nuevo orden de parámetros.';
PRINT 'IMPORTANTE: Actualiza también las llamadas al SP en tu código C# si no usas nombres de parámetros.';
GO

