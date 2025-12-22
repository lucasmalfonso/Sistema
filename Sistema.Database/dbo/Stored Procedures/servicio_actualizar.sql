--Procedimiento Actualizar
create proc servicio_actualizar
@idservicio integer,
@idcategoria integer,
@nombre varchar(50),
@precio_venta decimal(11,2),
@descripcion varchar(255),
@imagen varchar(20)
as
update servicio set idcategoria=@idcategoria,
nombre=@nombre,precio_venta=@precio_venta,
descripcion=@descripcion,imagen=@imagen
where idservicio=@idservicio