--Procedimiento Activar
create proc usuario_activar
@idusuario integer
as
update usuario set estado=1
where idusuario=@idusuario
