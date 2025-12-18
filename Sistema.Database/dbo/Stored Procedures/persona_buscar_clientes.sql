
--Procedimiento Buscar Clientes
create proc persona_buscar_clientes
@valor varchar(50)
as
select idpersona as ID, tipo_persona as Tipo_Persona,nombre as Nombre,
tipo_documento as Tipo_Documento,num_documento as Num_Documento,
direccion as Direccion,telefono as Telefono,email as Email
from persona
where (nombre like '%' +@valor + '%' Or email like '%' +@valor + '%')
and tipo_persona='Cliente'
order by nombre asc
