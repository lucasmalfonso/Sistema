--Procedimiento Insertar
create proc categoria_insertar
@nombre varchar(50),
@descripcion varchar(255)
as
insert into categoria (nombre,descripcion) values (@nombre,@descripcion)
