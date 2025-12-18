--Procedimiento Existe
create proc persona_existe
@valor varchar(100),
@existe bit output
as
if exists (select nombre from persona where nombre = ltrim(rtrim(@valor)))
	begin
		set @existe=1
	end
else
	begin
		set @existe=0
	end
