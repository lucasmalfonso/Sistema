--Procedimiento Listar
create proc usuario_listar
as
select u.idusuario as ID,u.idrol, r.nombre as Rol,u.nombre as Nombre,
u.tipo_documento as Tipo_Documento,u.num_documento as Num_Documento,
u.direccion as Direccion,u.telefono as Telefono,u.email as Email,
u.estado as Estado
 from usuario u inner join rol r on u.idrol=r.idrol
 order by u.idusuario desc
