CREATE TABLE [dbo].[persona] (
    [idpersona]      INT           IDENTITY (1, 1) NOT NULL,
    [tipo_persona]   VARCHAR (20)  NOT NULL,
    [nombre]         VARCHAR (100) NOT NULL,
    [tipo_documento] VARCHAR (20)  NULL,
    [num_documento]  VARCHAR (20)  NULL,
    [direccion]      VARCHAR (70)  NULL,
    [telefono]       VARCHAR (20)  NULL,
    [email]          VARCHAR (50)  NULL,
    PRIMARY KEY CLUSTERED ([idpersona] ASC)
);

