--Procedimiento Insertar
create proc persona_insertar
@tipo_persona varchar(20),
@nombre varchar(100),
@tipo_documento varchar(20),
@num_documento varchar(20),
@direccion varchar(70),
@telefono varchar(20),
@email varchar(50)
as
insert into persona (tipo_persona,nombre,tipo_documento,num_documento,direccion,telefono,email)
values (@tipo_persona,@nombre,@tipo_documento,@num_documento,@direccion,@telefono,@email)
