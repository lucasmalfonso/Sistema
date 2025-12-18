--Procedimiento Eliminar
create proc categoria_eliminar
@idcategoria int
as
delete from categoria
where idcategoria=@idcategoria
