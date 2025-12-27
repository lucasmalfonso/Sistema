CREATE PROCEDURE persona_listar_proveedores
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
 ORDER BY Nombre
END