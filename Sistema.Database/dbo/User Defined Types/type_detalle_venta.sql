CREATE TYPE [dbo].[type_detalle_venta] AS TABLE (
    [idarticulo] INT             NULL,
    [articulo]   VARCHAR (100)   NULL,
    [stock]      INT             NULL,
    [cantidad]   INT             NULL,
    [precio]     DECIMAL (11, 2) NULL,
    [descuento]  DECIMAL (11, 2) NULL,
    [importe]    DECIMAL (11, 2) NULL);

