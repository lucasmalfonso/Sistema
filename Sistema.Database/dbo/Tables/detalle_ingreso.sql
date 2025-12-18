CREATE TABLE [dbo].[detalle_ingreso] (
    [iddetalle_ingreso] INT             IDENTITY (1, 1) NOT NULL,
    [idingreso]         INT             NOT NULL,
    [idarticulo]        INT             NOT NULL,
    [cantidad]          INT             NOT NULL,
    [precio]            DECIMAL (11, 2) NOT NULL,
    PRIMARY KEY CLUSTERED ([iddetalle_ingreso] ASC),
    FOREIGN KEY ([idarticulo]) REFERENCES [dbo].[articulo] ([idarticulo]),
    FOREIGN KEY ([idingreso]) REFERENCES [dbo].[ingreso] ([idingreso]) ON DELETE CASCADE
);


GO
CREATE TRIGGER Ingreso_ActualizarStock
   ON detalle_ingreso
   FOR INSERT
   AS
   UPDATE a SET a.stock=a.stock+d.cantidad
   FROM articulo AS a INNER JOIN
   INSERTED AS d ON d.idarticulo=a.idarticulo
