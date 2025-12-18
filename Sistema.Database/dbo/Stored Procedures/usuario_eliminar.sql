--Procedimiento Eliminar
create proc usuario_eliminar
@idusuario integer
as
delete from usuario
where idusuario=@idusuario
