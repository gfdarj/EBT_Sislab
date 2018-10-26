<!--#include file="includes/Sislab_Lib.asp"-->
<!-- #include file="includes/PadraoHTML.asp" -->
<!-- #include file="includes/global.asp" -->
<%
Dim s, objRS
Dim anterior : anterior = 0
Dim dt_ini_anterior, dt_fim_anterior, data_invalida, conta_data_invalida

call ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Histórico de Agendamentos - Listagem de AS por ordem de cadastro", "location.href='sislab.asp'", "")

Server.ScriptTimeout = 1000
Response.buffer = True
response.flush

s = "SELECT AG_NUMERO, HE_DATAINICIO, HE_DATATERMINO, " & _
	"CONVERT(VARCHAR, HE_DATAINICIO, 103) + ' ' + LEFT(CONVERT(VARCHAR, HE_DATAINICIO, 114),5) AS HE_DATAINICIO_C, " & _
	"CONVERT(VARCHAR, HE_DATATERMINO, 103) + ' ' + LEFT(CONVERT(VARCHAR, HE_DATATERMINO, 114),5) AS HE_DATATERMINO_C, " & _
	"HE_MOTIVO, s.S_DESCRICAO " & _
	"FROM Historico_Eventos he INNER JOIN Situacoes s " & _
	"ON he.ID_SITUACAO = s.ID_SITUACAO " & _
	"ORDER BY AG_NUMERO, HE_ID"
call Env.RecordSet(true, objRS, s)

if not (objRS.Eof and objRS.Bof) then 
	anterior = ""
	primeiro = true
	response.write "<br>"
	conta_data_invalida = 0

	while not objRS.Eof
		if anterior <> objRS("AG_NUMERO") then

			dt_ini_anterior = objRS("HE_DATAINICIO")
			dt_fim_anterior = objRS("HE_DATATERMINO")

			if not primeiro then%>
</table>
<br><br>
<%			end if

			primeiro = false
%>
<span class="Texto1" style="font-size: 12px;">
	<b>AS: <%if not primeiro then response.write objRS("AG_NUMERO") else response.write anterior end if%></b>
</span>

<table width="100%" cellpadding="2" cellspacing="0" border="0" class="table-bordered" style="border-top: solid thin;">
<tr>
	<th width="15px">&nbsp;</th>
	<th width="130px">Data Inicial</th>
	<th width="130px">Data Término</th>
	<th width="110px">Situação</th>
	<th width="*" align="left">Motivo</th>
</tr>
<%		end if

		if dt_ini_anterior > objRS("HE_DATAINICIO") then
			data_invalida = true 
			conta_data_invalida = conta_data_invalida + 1
		else
			data_invalida = false
		end if
%>
<tr valign="top" <%if data_invalida then response.write "class='vermelho1bg' style='font: bold italic;'"%>>
	<td align="center" class="cinza1" style="font-weigth: normal; font-style: none;"><%if data_invalida then response.write "&raquo;" else response.write "&nbsp;"%></td>
	<td align="center"><%=objRS("HE_DATAINICIO_C")%>&nbsp;</td>
	<td align="center"><%=objRS("HE_DATATERMINO_C")%>&nbsp;</td>
	<td align="center"><%=objRS("S_DESCRICAO")%>&nbsp;</td>
	<td><%=objRS("HE_MOTIVO")%>&nbsp;</td>
</td>
</tr>
<%		anterior = objRS("AG_NUMERO")
		dt_ini_anterior = objRS("HE_DATAINICIO")
		dt_fim_anterior = objRS("HE_DATATERMINO")
		objRS.MoveNext
		response.flush
	wend
end if
%>
</table>
<br><br>
<%
if conta_data_invalida > 0 then
	response.write "<span class='texto1' style='font-size: 12px; font-style: italic;'>"
	response.write "&nbsp;&nbsp;Foram encontradas " & conta_data_invalida & " datas inválidas<br><br>"
	response.write "&nbsp;&nbsp;Observação: As datas marcadas (&raquo;) estão inválidas em relação ao histórico do seu respectivo agendamento<br><br>"
	response.write "</span>"
end if

call Env.RecordSet(false, objRS, null)
call imprimeRodape(RODAPE_OFF)
%>
