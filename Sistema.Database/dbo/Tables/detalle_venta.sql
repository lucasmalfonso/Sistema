CREATE TABLE [dbo].[detalle_venta] (
    [iddetalle_venta] INT             IDENTITY (1, 1) NOT NULL,
    [idventa]         INT             NOT NULL,
    [idarticulo]      INT             NULL,
    [cantidad]        INT             NOT NULL,
    [precio]          DECIMAL (11, 2) NOT NULL,
    [descuento]       DECIMAL (11, 2) NOT NULL,
    [idservicio]      INT             NULL,
    PRIMARY KEY CLUSTERED ([iddetalle_venta] ASC),
    CONSTRAINT [CK_detalle_venta_articulo_servicio] CHECK ([idarticulo] IS NOT NULL AND [idservicio] IS NULL OR [idarticulo] IS NULL AND [idservicio] IS NOT NULL),
    FOREIGN KEY ([idarticulo]) REFERENCES [dbo].[articulo] ([idarticulo]),
    FOREIGN KEY ([idventa]) REFERENCES [dbo].[venta] ([idventa]) ON DELETE CASCADE,
    CONSTRAINT [FK_detalle_venta_articulo] FOREIGN KEY ([idarticulo]) REFERENCES [dbo].[articulo] ([idarticulo]),
    CONSTRAINT [FK_detalle_venta_servicio] FOREIGN KEY ([idservicio]) REFERENCES [dbo].[servicio] ([idservicio])
);




GO
CREATE TRIGGER [dbo].[Venta_ActualizarStock]
   ON [dbo].[detalle_venta]
   FOR INSERT
   AS
   UPDATE a SET a.stock=a.stock-d.cantidad
   FROM articulo AS a INNER JOIN
   INSERTED AS d ON d.idarticulo=a.idarticulo
   WHERE d.idarticulo IS NOT NULL;