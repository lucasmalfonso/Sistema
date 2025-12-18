CREATE TABLE [dbo].[articulo] (
    [idarticulo]   INT             IDENTITY (1, 1) NOT NULL,
    [idcategoria]  INT             NOT NULL,
    [nombre]       VARCHAR (100)   NOT NULL,
    [precio_venta] DECIMAL (11, 2) NOT NULL,
    [stock]        INT             NOT NULL,
    [descripcion]  VARCHAR (255)   NULL,
    [imagen]       VARCHAR (20)    NULL,
    [estado]       BIT             DEFAULT ((1)) NULL,
    PRIMARY KEY CLUSTERED ([idarticulo] ASC),
    FOREIGN KEY ([idcategoria]) REFERENCES [dbo].[categoria] ([idcategoria]),
    UNIQUE NONCLUSTERED ([nombre] ASC)
);

