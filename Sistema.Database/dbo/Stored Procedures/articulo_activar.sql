--Procedimiento Activar
create proc articulo_activar
@idarticulo integer
as
update articulo set estado=1
where idarticulo=@idarticulo
