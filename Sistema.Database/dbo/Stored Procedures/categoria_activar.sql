--Procedimiento Activar
create proc categoria_activar
@idcategoria int
as
update categoria set estado=1
where idcategoria=@idcategoria
