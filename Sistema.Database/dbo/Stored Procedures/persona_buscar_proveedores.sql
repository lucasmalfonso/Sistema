CREATE PROCEDURE persona_buscar_proveedores
    @valor VARCHAR(100)
AS
BEGIN
    SELECT
        IdPersona AS ID,
        Tipo_Persona,
        Nombre,
        Tipo_Documento,
        Num_Documento,
        Direccion,
        Telefono,
        Email,
        Fecha_Nacimiento
    FROM Persona
    WHERE Tipo_Persona = 'Proveedor'
        AND (Nombre LIKE '%' + @valor + '%'
            OR Num_Documento LIKE '%' + @valor + '%'
  OR Email LIKE '%' + @valor + '%')
    ORDER BY Nombre
END