--Procedimiento Listar
create proc categoria_listar
as
select idcategoria as ID,nombre as Nombre,descripcion as Descripcion,estado as Estado
from categoria
order by idcategoria desc