--Procedimiento lista rol
create proc rol_listar
as
select idrol,nombre from rol
where estado=1
