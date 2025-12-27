CREATE PROCEDURE persona_listar_clientes
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
    WHERE Tipo_Persona = 'Cliente'
    ORDER BY Nombre
END