CREATE TABLE [dbo].[ingreso] (
    [idingreso]         INT             IDENTITY (1, 1) NOT NULL,
    [idproveedor]       INT             NOT NULL,
    [idusuario]         INT             NOT NULL,
    [fecha]             DATETIME        NOT NULL,
    [total]             DECIMAL (11, 2) NOT NULL,
    [estado]            VARCHAR (20)    NOT NULL,
    PRIMARY KEY CLUSTERED ([idingreso] ASC),
    FOREIGN KEY ([idproveedor]) REFERENCES [dbo].[persona] ([idpersona]),
    FOREIGN KEY ([idusuario]) REFERENCES [dbo].[usuario] ([idusuario])
);

