create proc categoria_seleccionar
as
select idcategoria, nombre from categoria
where estado=1
