create proc venta_insertar
@idusuario int,
@idcliente int,
@tipo_comprobante varchar(20),
@serie_comprobante varchar(7),
@num_comprobante varchar(10),
@impuesto decimal(4,2),
@total decimal(11,2),
@detalle type_detalle_venta READONLY
as
begin
	insert into venta (idusuario,idcliente,tipo_comprobante,serie_comprobante,
	num_comprobante,fecha,impuesto,total,estado)
	values (@idusuario,@idcliente,@tipo_comprobante,@serie_comprobante,
	@num_comprobante,getdate(),@impuesto,@total,'Aceptado');
	
	insert detalle_venta (idventa,idarticulo,cantidad,precio,descuento)
	select @@IDENTITY,d.idarticulo,d.cantidad,d.precio,d.descuento
	from @detalle d;
end