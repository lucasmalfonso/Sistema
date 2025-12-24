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