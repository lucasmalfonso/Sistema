CREATE PROC [dbo].[ingreso_listar]
AS
BEGIN
    SELECT i.idingreso AS ID,i.idproveedor,i.idusuario,
    u.nombre AS Usuario,p.nombre AS Proveedor,
    i.fecha AS Fecha,i.total AS Total,
    i.estado AS Estado
    FROM ingreso i
    INNER JOIN persona p ON i.idproveedor=p.idpersona
    INNER JOIN usuario u ON i.idusuario=u.idusuario
    ORDER BY i.idingreso DESC;
END;