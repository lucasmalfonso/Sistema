create proc articulo_buscar_nombre_venta
@valor varchar(50)
as
select idarticulo,nombre,precio_venta,stock
from articulo
where nombre=@valor and stock>0
