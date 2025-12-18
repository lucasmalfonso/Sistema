CREATE TABLE [dbo].[categoria] (
    [idcategoria] INT           IDENTITY (1, 1) NOT NULL,
    [nombre]      VARCHAR (50)  NOT NULL,
    [descripcion] VARCHAR (255) NULL,
    [estado]      BIT           DEFAULT ((1)) NULL,
    PRIMARY KEY CLUSTERED ([idcategoria] ASC),
    UNIQUE NONCLUSTERED ([nombre] ASC)
);

