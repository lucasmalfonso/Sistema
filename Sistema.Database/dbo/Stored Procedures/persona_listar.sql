CREATE PROCEDURE persona_listar
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
    ORDER BY Nombre
END