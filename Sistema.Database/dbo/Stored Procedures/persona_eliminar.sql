
--Procedimiento Eliminar
create proc persona_eliminar
@idpersona integer
as
delete from persona
where idpersona=@idpersona
