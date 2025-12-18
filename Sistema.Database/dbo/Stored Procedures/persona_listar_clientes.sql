--Procedimiento Listar Clientes
create proc persona_listar_clientes
as
select idpersona as ID, tipo_persona as Tipo_Persona,nombre as Nombre,
tipo_documento as Tipo_Documento,num_documento as Num_Documento,
direccion as Direccion,telefono as Telefono,email as Email
from persona
where tipo_persona='Cliente'
order by idpersona desc
