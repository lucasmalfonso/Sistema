-- =============================================
-- Script para reemplazar columna Email por Usuario
-- Fecha: Reemplazo de Email por Usuario en tabla usuario
-- =============================================

USE [Sistema]
GO

-- =============================================
-- 1. REEMPLAZAR COLUMNA 'email' POR 'usuario'
-- =============================================

-- Verificar si la columna email existe
IF EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[usuario]') AND name = 'email')
BEGIN
    PRINT 'Reemplazando columna email por usuario...'
    
    -- Si ya existe la columna usuario, copiar datos y eliminar email
    IF EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[usuario]') AND name = 'usuario')
    BEGIN
        PRINT 'La columna usuario ya existe. Copiando datos de email a usuario...'
        UPDATE [dbo].[usuario]
        SET [usuario] = [email]
        WHERE [usuario] IS NULL OR [usuario] = '';
        
        PRINT 'Eliminando columna email...'
        ALTER TABLE [dbo].[usuario]
        DROP COLUMN [email];
        
        PRINT 'Columna email eliminada. La columna usuario contiene los datos.'
    END
    ELSE
    BEGIN
        -- Si no existe usuario, renombrar email a usuario
        PRINT 'Renombrando columna email a usuario...'
        
        -- Crear columna usuario con los datos de email
        ALTER TABLE [dbo].[usuario]
        ADD [usuario] VARCHAR(50) NULL;
        
        PRINT 'Copiando datos de email a usuario...'
        UPDATE [dbo].[usuario]
        SET [usuario] = [email];
        
        -- Hacer NOT NULL
        ALTER TABLE [dbo].[usuario]
        ALTER COLUMN [usuario] VARCHAR(50) NOT NULL;
        
        -- Eliminar columna email
        PRINT 'Eliminando columna email...'
        ALTER TABLE [dbo].[usuario]
        DROP COLUMN [email];
        
        PRINT 'Columna email reemplazada por usuario exitosamente.'
    END
END
ELSE IF EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[usuario]') AND name = 'usuario')
BEGIN
    PRINT 'La columna email ya fue reemplazada por usuario. No se requiere acción.'
END
ELSE
BEGIN
    PRINT 'ERROR: No se encontró ni la columna email ni usuario. Verifique la estructura de la tabla.'
END
GO

-- =============================================
-- 2. ACTUALIZAR STORED PROCEDURE: usuario_insertar
-- =============================================

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usuario_insertar]') AND type in (N'P', N'PC'))
    DROP PROCEDURE [dbo].[usuario_insertar]
GO

CREATE PROCEDURE [dbo].[usuario_insertar]
    @idrol INTEGER,
    @nombre VARCHAR(100),
    @tipo_documento VARCHAR(20),
    @num_documento VARCHAR(20),
    @direccion VARCHAR(70),
    @telefono VARCHAR(20),
    @usuario VARCHAR(50),
    @clave VARCHAR(50)
AS
BEGIN
    INSERT INTO usuario (idrol, nombre, tipo_documento, num_documento, direccion, telefono, usuario, clave)
    VALUES (@idrol, @nombre, @tipo_documento, @num_documento, @direccion, @telefono, @usuario, HASHBYTES('SHA2_256', @clave))
END
GO

PRINT 'Stored procedure usuario_insertar actualizado (sin parámetro email).'
GO

-- =============================================
-- 3. ACTUALIZAR STORED PROCEDURE: usuario_actualizar
-- =============================================

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usuario_actualizar]') AND type in (N'P', N'PC'))
    DROP PROCEDURE [dbo].[usuario_actualizar]
GO

CREATE PROCEDURE [dbo].[usuario_actualizar]
    @idusuario INTEGER,
    @idrol INTEGER,
    @nombre VARCHAR(100),
    @tipo_documento VARCHAR(20),
    @num_documento VARCHAR(20),
    @direccion VARCHAR(70),
    @telefono VARCHAR(20),
    @usuario VARCHAR(50),
    @clave VARCHAR(50)
AS
BEGIN
    IF @clave <> ''
    BEGIN
        UPDATE usuario 
        SET idrol = @idrol,
            nombre = @nombre,
            tipo_documento = @tipo_documento,
            num_documento = @num_documento,
            direccion = @direccion,
            telefono = @telefono,
            usuario = @usuario,
            clave = HASHBYTES('SHA2_256', @clave)
        WHERE idusuario = @idusuario;
    END
    ELSE
    BEGIN
        UPDATE usuario 
        SET idrol = @idrol,
            nombre = @nombre,
            tipo_documento = @tipo_documento,
            num_documento = @num_documento,
            direccion = @direccion,
            telefono = @telefono,
            usuario = @usuario
        WHERE idusuario = @idusuario;
    END
END
GO

PRINT 'Stored procedure usuario_actualizar actualizado (sin parámetro email).'
GO

-- =============================================
-- 4. ACTUALIZAR STORED PROCEDURE: usuario_listar
-- =============================================

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usuario_listar]') AND type in (N'P', N'PC'))
    DROP PROCEDURE [dbo].[usuario_listar]
GO

CREATE PROCEDURE [dbo].[usuario_listar]
AS
BEGIN
    SELECT u.idusuario AS ID,
           u.idrol,
           r.nombre AS Rol,
           u.nombre AS Nombre,
           u.tipo_documento AS Tipo_Documento,
           u.num_documento AS Num_Documento,
           u.direccion AS Direccion,
           u.telefono AS Telefono,
           u.usuario AS Usuario,
           u.estado AS Estado
    FROM usuario u 
    INNER JOIN rol r ON u.idrol = r.idrol
    ORDER BY u.idusuario DESC
END
GO

PRINT 'Stored procedure usuario_listar actualizado (sin columna email).'
GO

-- =============================================
-- 5. ACTUALIZAR STORED PROCEDURE: usuario_buscar
-- =============================================

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usuario_buscar]') AND type in (N'P', N'PC'))
    DROP PROCEDURE [dbo].[usuario_buscar]
GO

CREATE PROCEDURE [dbo].[usuario_buscar]
    @valor VARCHAR(50)
AS
BEGIN
    SELECT u.idusuario AS ID,
           u.idrol,
           r.nombre AS Rol,
           u.nombre AS Nombre,
           u.tipo_documento AS Tipo_Documento,
           u.num_documento AS Num_Documento,
           u.direccion AS Direccion,
           u.telefono AS Telefono,
           u.usuario AS Usuario,
           u.estado AS Estado
    FROM usuario u 
    INNER JOIN rol r ON u.idrol = r.idrol
    WHERE u.nombre LIKE '%' + @valor + '%' 
       OR u.usuario LIKE '%' + @valor + '%'
    ORDER BY u.nombre ASC
END
GO

PRINT 'Stored procedure usuario_buscar actualizado (sin búsqueda por email).'
GO

-- =============================================
-- 6. ACTUALIZAR STORED PROCEDURE: usuario_login
-- =============================================

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usuario_login]') AND type in (N'P', N'PC'))
    DROP PROCEDURE [dbo].[usuario_login]
GO

CREATE PROCEDURE [dbo].[usuario_login]
    @usuario VARCHAR(50),
    @clave VARCHAR(50)
AS
BEGIN
    SELECT u.idusuario,
           u.idrol,
           r.nombre AS rol,
           u.nombre,
           u.estado
    FROM usuario u 
    INNER JOIN rol r ON u.idrol = r.idrol
    WHERE u.usuario = @usuario 
      AND u.clave = HASHBYTES('SHA2_256', @clave)
END
GO

PRINT 'Stored procedure usuario_login actualizado (usa usuario en lugar de email).'
GO

-- =============================================
-- 7. ACTUALIZAR STORED PROCEDURE: usuario_existe
-- =============================================

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usuario_existe]') AND type in (N'P', N'PC'))
    DROP PROCEDURE [dbo].[usuario_existe]
GO

CREATE PROCEDURE [dbo].[usuario_existe]
    @valor VARCHAR(100),
    @existe BIT OUTPUT
AS
BEGIN
    IF EXISTS (SELECT usuario FROM usuario WHERE usuario = LTRIM(RTRIM(@valor)))
    BEGIN
        SET @existe = 1
    END
    ELSE
    BEGIN
        SET @existe = 0
    END
END
GO

PRINT 'Stored procedure usuario_existe actualizado (busca por usuario en lugar de email).'
GO

-- =============================================
-- RESUMEN
-- =============================================

PRINT ''
PRINT '============================================='
PRINT 'Actualización completada exitosamente!'
PRINT '============================================='
PRINT 'Cambios aplicados:'
PRINT '1. Columna "email" reemplazada por "usuario"'
PRINT '2. Stored procedure usuario_insertar actualizado (sin @email)'
PRINT '3. Stored procedure usuario_actualizar actualizado (sin @email)'
PRINT '4. Stored procedure usuario_listar actualizado (sin columna email)'
PRINT '5. Stored procedure usuario_buscar actualizado (sin búsqueda por email)'
PRINT '6. Stored procedure usuario_login actualizado'
PRINT '7. Stored procedure usuario_existe actualizado (busca por usuario)'
PRINT '============================================='
PRINT ''
PRINT 'NOTA: Recuerde actualizar el código C# para eliminar referencias al campo Email.'
PRINT '============================================='
GO
