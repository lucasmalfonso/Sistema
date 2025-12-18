create proc articulo_buscar_nombre
@valor varchar(50)
as
select idarticulo,nombre,precio_venta,stock from articulo
where nombre=@valor
