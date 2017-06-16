<!--#include file="includes/abre.asp"-->
<%
data = year(now)&"/"&right(month(now)+100,2)&"/"&right(day(now)+100,2)&" "&right(hour(now)+100,2)&":"&right(minute(now)+100,2)&":"&right(second(now)+100,2)
prazo = request("diarep")
prazo2 = request("anor") &"/"& right(request("mesr")+100,2) &"/"& right(request("diar")+100,2)

if prazo2 < data then%>
	<html>
		<head></head>
		<body>
			<script>
				alert('A Data de Retirada não pode ser inferior à data atual');
				history.back();
			</script>
		</body>
	</html>
	<%response.end
end if
eq_id = request("eq_id")
if instr(eq_id,",") then
	vet = split(eq_id,",")
	for i=0 to ubound(vet)
		ssql = "insert into sce_movimentacao (mov_data,eq_id,no_id,mov_despachante,mov_solicitante,"
		ssql = ssql &"status,tipo,cde,defeito,prazo,asa,reserva,saida) values "
		ssql = ssql &"('"& data &"',"& trim(vet(i)) &","& request("noid") &","& session("user_id") &",'"& request("solicitante") &"',"
		ssql = ssql & request("status") &",2,'"& request("cde") &"','"& request("def") &"',"
		ssql = ssql &"'"& prazo &"','"& request("asa") &"',1,"& request("saida") &")"
		conn.execute(ssql)
'		response.write ssql
		ssql = "select mov_id as id from sce_movimentacao order by mov_id desc"
		set rec = conn.execute(Ssql)
		ssql = "insert into sce_historico_reserva (mov_id,data,usuario,prazo) values "
		ssql = ssql&"("& rec("id") &",'"& data &"',"& session("user_id") &",'"& prazo2 &"')"
		conn.execute(ssql)
	next
else
	ssql = "insert into sce_movimentacao (mov_data,eq_id,no_id,mov_despachante,mov_solicitante,"
	ssql = ssql &"status,tipo,cde,defeito,prazo,asa,reserva,saida) values "
	ssql = ssql &"('"& data &"',"& eq_id &","& request("noid") &","& session("user_id") &",'"& request("solicitante") &"',"
	ssql = ssql & request("status") &",2,'"& request("cde") &"','"& request("def") &"',"
	ssql = ssql &"'"& prazo &"','"& request("asa") &"',1,"& request("saida") &")"
'	response.write ssql
'	response.end
	conn.execute(ssql)
	ssql = "select mov_id as id from sce_movimentacao order by mov_id desc"
	set rec = conn.execute(Ssql)
	data = year(date) &"/"& right(month(date)+100,2) &"/"& right(day(date)+100,2) &" "& right(hour(now)+100,2)&":"&right(minute(now)+100,2)&":"& right(second(now)+100,2)
	ssql = "insert into sce_historico_reserva (mov_id,data,usuario,prazo) values "
	ssql = ssql&"("& rec("id") &",'"& data &"',"& session("user_id") &",'"& prazo2 &"')"
'	response.write ssql
'	response.end
	conn.execute(ssql)
end if

response.redirect "reserva.asp?msg=1"%>