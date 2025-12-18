CREATE TABLE [dbo].[detalle_venta] (
    [iddetalle_venta] INT             IDENTITY (1, 1) NOT NULL,
    [idventa]         INT             NOT NULL,
    [idarticulo]      INT             NOT NULL,
    [cantidad]        INT             NOT NULL,
    [precio]          DECIMAL (11, 2) NOT NULL,
    [descuento]       DECIMAL (11, 2) NOT NULL,
    PRIMARY KEY CLUSTERED ([iddetalle_venta] ASC),
    FOREIGN KEY ([idarticulo]) REFERENCES [dbo].[articulo] ([idarticulo]),
    FOREIGN KEY ([idventa]) REFERENCES [dbo].[venta] ([idventa]) ON DELETE CASCADE
);


GO
CREATE TRIGGER Venta_ActualizarStock
   ON detalle_venta
   FOR INSERT
   AS
   UPDATE a SET a.stock=a.stock-d.cantidad
   FROM articulo AS a INNER JOIN
   INSERTED AS d ON d.idarticulo=a.idarticulo
