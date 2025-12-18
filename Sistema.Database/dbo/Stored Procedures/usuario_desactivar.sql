--Procedimiento Desactivar
create proc usuario_desactivar
@idusuario integer
as
update usuario set estado=0
where idusuario=@idusuario
