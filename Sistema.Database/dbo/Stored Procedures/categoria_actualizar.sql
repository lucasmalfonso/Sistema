--Procedimiento Actualizar
create proc categoria_actualizar
@idcategoria int,
@nombre varchar(50),
@descripcion varchar(255)
as
update categoria set nombre=@nombre,descripcion=@descripcion
where idcategoria=@idcategoria
