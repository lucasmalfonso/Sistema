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