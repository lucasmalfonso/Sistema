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