CREATE PROCEDURE [dbo].[usuario_existe]
    @valor VARCHAR(100),
    @existe BIT OUTPUT
AS
BEGIN
    IF EXISTS (SELECT usuario FROM usuario WHERE usuario = LTRIM(RTRIM(@valor)))
    BEGIN
        SET @existe = 1
    END
    ELSE
    BEGIN
        SET @existe = 0
    END
END