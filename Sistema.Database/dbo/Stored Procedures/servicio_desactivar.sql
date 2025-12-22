--Procedimiento Desactivar
create proc servicio_desactivar
@idservicio integer
as
update servicio set estado=0
where idservicio=@idservicio