
--Procedimiento Desactivar
create proc categoria_desactivar
@idcategoria int
as
update categoria set estado=0
where idcategoria=@idcategoria
