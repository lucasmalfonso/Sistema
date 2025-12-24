-- =============================================
-- Script para actualizar tabla usuario y stored procedures
-- Mantiene Email como información de contacto
-- Usuario se usa para login
-- =============================================

USE [Sistema]
GO

-- =============================================
-- 1. VERIFICAR/AGREGAR COLUMNA 'email' A LA TABLA
-- =============================================

-- Verificar si la columna email existe
IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[usuario]') AND name = 'email')
BEGIN
    PRINT 'Agregando columna email a la tabla usuario...'
    ALTER TABLE [dbo].[usuario]
    ADD [email] VARCHAR(50) NULL;
    PRINT 'Columna email agregada exitosamente.'
END
ELSE
BEGIN
    PRINT 'La columna email ya existe en la tabla.'
END
GO

-- =============================================
-- 2. VERIFICAR/AGREGAR COLUMNA 'usuario' A LA TABLA
-- =============================================

-- Verificar si la columna usuario existe
IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[usuario]') AND name = 'usuario')
BEGIN
    PRINT 'Agregando columna usuario a la tabla usuario...'
    
    -- Si hay datos existentes, usar email como usuario temporal
    IF EXISTS (SELECT TOP 1 1 FROM [dbo].[usuario])
    BEGIN
        PRINT 'La tabla tiene datos existentes. Agregando columna como NULL temporalmente...'
        ALTER TABLE [dbo].[usuario]
        ADD [usuario] VARCHAR(50) NULL;
        
        -- Actualizar los registros existentes usando el email como usuario temporal
        PRINT 'Actualizando registros existentes: usando email como usuario temporal...'
        UPDATE [dbo].[usuario]
        SET [usuario] = [email]
        WHERE [usuario] IS NULL;
        
        -- Ahora hacer la columna NOT NULL
        PRINT 'Cambiando columna a NOT NULL...'
        ALTER TABLE [dbo].[usuario]
        ALTER COLUMN [usuario] VARCHAR(50) NOT NULL;
    END
    ELSE
    BEGIN
        -- Si no hay datos, agregar directamente como NOT NULL
        PRINT 'La tabla está vacía. Agregando columna como NOT NULL...'
        ALTER TABLE [dbo].[usuario]
        ADD [usuario] VARCHAR(50) NOT NULL;
    END
    
    PRINT 'Columna usuario agregada exitosamente.'
END
ELSE
BEGIN
    PRINT 'La columna usuario ya existe en la tabla.'
END
GO

-- =============================================
-- 3. ACTUALIZAR STORED PROCEDURE: usuario_insertar
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
    @email VARCHAR(50),
    @usuario VARCHAR(50),
    @clave VARCHAR(50)
AS
BEGIN
    INSERT INTO usuario (idrol, nombre, tipo_documento, num_documento, direccion, telefono, email, usuario, clave)
    VALUES (@idrol, @nombre, @tipo_documento, @num_documento, @direccion, @telefono, @email, @usuario, HASHBYTES('SHA2_256', @clave))
END
GO

PRINT 'Stored procedure usuario_insertar actualizado.'
GO

-- =============================================
-- 4. ACTUALIZAR STORED PROCEDURE: usuario_actualizar
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
    @email VARCHAR(50),
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
            email = @email,
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
            email = @email,
            usuario = @usuario
        WHERE idusuario = @idusuario;
    END
END
GO

PRINT 'Stored procedure usuario_actualizar actualizado.'
GO

-- =============================================
-- 5. ACTUALIZAR STORED PROCEDURE: usuario_listar
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
           u.telefono AS Telefono,
           u.email AS Email,
           u.usuario AS Usuario,
           u.estado AS Estado
    FROM usuario u 
    INNER JOIN rol r ON u.idrol = r.idrol
    ORDER BY u.idusuario DESC
END
GO

PRINT 'Stored procedure usuario_listar actualizado.'
GO

-- =============================================
-- 6. ACTUALIZAR STORED PROCEDURE: usuario_buscar
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
           u.telefono AS Telefono,
           u.email AS Email,
           u.usuario AS Usuario,
           u.estado AS Estado
    FROM usuario u 
    INNER JOIN rol r ON u.idrol = r.idrol
    WHERE u.nombre LIKE '%' + @valor + '%' 
       OR u.email LIKE '%' + @valor + '%' 
       OR u.usuario LIKE '%' + @valor + '%'
    ORDER BY u.nombre ASC
END
GO

PRINT 'Stored procedure usuario_buscar actualizado.'
GO

-- =============================================
-- 7. ACTUALIZAR STORED PROCEDURE: usuario_login
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

PRINT 'Stored procedure usuario_login actualizado (usa usuario para login).'
GO

-- =============================================
-- 8. ACTUALIZAR STORED PROCEDURE: usuario_existe
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

PRINT 'Stored procedure usuario_existe actualizado (busca por usuario).'
GO

-- =============================================
-- RESUMEN
-- =============================================

PRINT ''
PRINT '============================================='
PRINT 'Actualización completada exitosamente!'
PRINT '============================================='
PRINT 'Cambios aplicados:'
PRINT '1. Columna "email" agregada/verificada (información de contacto)'
PRINT '2. Columna "usuario" agregada/verificada (para login)'
PRINT '3. Stored procedure usuario_insertar actualizado'
PRINT '4. Stored procedure usuario_actualizar actualizado'
PRINT '5. Stored procedure usuario_listar actualizado'
PRINT '6. Stored procedure usuario_buscar actualizado'
PRINT '7. Stored procedure usuario_login actualizado (usa usuario)'
PRINT '8. Stored procedure usuario_existe actualizado (busca por usuario)'
PRINT '============================================='
PRINT ''
PRINT 'NOTA:'
PRINT '- Email se mantiene como información de contacto'
PRINT '- Usuario se usa para login'
PRINT '============================================='
GO

