create proc categoria_existe
@valor varchar(100),
@existe bit output
as
	if exists (select nombre from categoria where nombre = ltrim(rtrim(@valor)))
		begin
		 set @existe=1
		end
	else
		begin
		 set @existe=0
		end