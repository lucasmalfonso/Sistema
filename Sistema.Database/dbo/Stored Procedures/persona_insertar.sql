CREATE PROCEDURE persona_insertar
    @tipo_persona VARCHAR(50),
    @nombre VARCHAR(100),
    @tipo_documento VARCHAR(50),
    @num_documento VARCHAR(50),
    @direccion VARCHAR(200),
    @telefono VARCHAR(20),
    @email VARCHAR(100),
    @fecha_nacimiento DATETIME
AS
BEGIN
    INSERT INTO Persona (
        Tipo_Persona,
        Nombre,
        Tipo_Documento,
      Num_Documento,
        Direccion,
        Telefono,
        Email,
        Fecha_Nacimiento
    )
    VALUES (
        @tipo_persona,
  @nombre,
        @tipo_documento,
   @num_documento,
        @direccion,
        @telefono,
    @email,
        @fecha_nacimiento
    )
END