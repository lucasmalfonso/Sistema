CREATE TYPE [dbo].[types_detalle_ingreso] AS TABLE (
    [idarticulo] INT             NULL,
    [articulo]   VARCHAR (100)   NULL,
    [cantidad]   INT             NULL,
    [precio]     DECIMAL (11, 2) NULL,
    [importe]    DECIMAL (11, 2) NULL);

