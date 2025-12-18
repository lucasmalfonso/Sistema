--Procedimiento Actualizar
create proc persona_actualizar
@idpersona integer,
@tipo_persona varchar(20),
@nombre varchar(100),
@tipo_documento varchar(20),
@num_documento varchar(20),
@direccion varchar(70),
@telefono varchar(20),
@email varchar(50)
as
update persona set tipo_persona=@tipo_persona,nombre=@nombre,
tipo_documento=@tipo_documento,num_documento=@num_documento,direccion=@direccion,
telefono=@telefono,email=@email
where idpersona=@idpersona
