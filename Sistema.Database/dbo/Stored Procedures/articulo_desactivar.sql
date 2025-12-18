--Procedimiento Desactivar
create proc articulo_desactivar
@idarticulo integer
as
update articulo set estado=0
where idarticulo=@idarticulo
