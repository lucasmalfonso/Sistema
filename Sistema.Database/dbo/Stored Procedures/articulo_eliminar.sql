--Procedimiento Eliminar
create proc articulo_eliminar
@idarticulo integer
as
delete from articulo
where idarticulo=@idarticulo
