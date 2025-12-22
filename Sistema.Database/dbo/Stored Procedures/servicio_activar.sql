--Procedimiento Activar
create proc servicio_activar
@idservicio integer
as
update servicio set estado=1
where idservicio=@idservicio