CREATE TABLE [dbo].[rol] (
    [idrol]       INT           IDENTITY (1, 1) NOT NULL,
    [nombre]      VARCHAR (30)  NOT NULL,
    [descripcion] VARCHAR (255) NULL,
    [estado]      BIT           DEFAULT ((1)) NULL,
    PRIMARY KEY CLUSTERED ([idrol] ASC)
);

