-- =============================================
-- Script para corregir usuario_actualizar
-- Elimina referencias a la columna 'email' que ya no existe
-- =============================================

USE [Sistema]
GO

-- Eliminar el stored procedure existente
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usuario_actualizar]') AND type in (N'P', N'PC'))
    DROP PROCEDURE [dbo].[usuario_actualizar]
GO

-- Recrear el stored procedure sin referencias a 'email'
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

PRINT 'Stored procedure usuario_actualizar corregido exitosamente.'
GO

