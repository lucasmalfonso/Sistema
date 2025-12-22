--Procedimiento Insertar
create proc servicio_insertar
@idcategoria integer,
@nombre varchar(100),
@precio_venta decimal(11,2),
@descripcion varchar(255),
@imagen varchar(20)
as
insert into servicio (idcategoria,nombre,precio_venta,descripcion,imagen)
values (@idcategoria,@nombre,@precio_venta,@descripcion,@imagen)