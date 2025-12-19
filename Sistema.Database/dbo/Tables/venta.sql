CREATE TABLE [dbo].[venta] (
    [idventa]           INT             IDENTITY (1, 1) NOT NULL,
    [idcliente]         INT             NOT NULL,
    [idusuario]         INT             NOT NULL,
    [tipo_comprobante]  VARCHAR (20)    NOT NULL,
    [serie_comprobante] VARCHAR (7)     NULL,
    [num_comprobante]   VARCHAR (10)    NOT NULL,
    [fecha]             DATETIME        NOT NULL,
    [impuesto]          DECIMAL (4, 2)  NOT NULL,
    [total]             DECIMAL (11, 2) NOT NULL,
    [estado]            VARCHAR (20)    NOT NULL,
    [forma_pago]        VARCHAR (50)    NULL,
    [cuota]             VARCHAR (20)    NULL,
    PRIMARY KEY CLUSTERED ([idventa] ASC),
    FOREIGN KEY ([idcliente]) REFERENCES [dbo].[persona] ([idpersona]),
    FOREIGN KEY ([idusuario]) REFERENCES [dbo].[usuario] ([idusuario])
);

