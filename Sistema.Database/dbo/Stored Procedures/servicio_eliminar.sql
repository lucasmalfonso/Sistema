--Procedimiento Eliminar
create proc servicio_eliminar
@idservicio integer
as
delete from servicio
where idservicio=@idservicio