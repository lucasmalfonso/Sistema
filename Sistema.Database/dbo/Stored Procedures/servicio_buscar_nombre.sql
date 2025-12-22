--Procedimiento Buscar Nombre
create proc servicio_buscar_nombre
@valor varchar(50)
as
select idservicio,nombre,precio_venta from servicio
where nombre=@valor



