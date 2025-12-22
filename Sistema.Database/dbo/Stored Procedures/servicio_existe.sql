-- Procedimiento existe
create proc servicio_existe
@valor varchar(100),
@existe bit output
as
if exists (select nombre from servicio where nombre = ltrim(rtrim(@valor)))
	begin
		set @existe=1
	end
else
	begin
		set @existe=0
	end