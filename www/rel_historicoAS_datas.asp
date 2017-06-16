<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<%
Dim s, objRS
Dim anterior : anterior = 0

call ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Histórico de Agendamentos - Listagem de AS por ordem de datas", "location.href='sislab.asp'", "")

Server.ScriptTimeout = 1000
Response.buffer = True
response.flush

s = "SELECT AG_NUMERO, HE_DATAINICIO, HE_DATATERMINO, " & _
	"CONVERT(VARCHAR, HE_DATAINICIO, 103) + ' ' + LEFT(CONVERT(VARCHAR, HE_DATAINICIO, 114),5) AS HE_DATAINICIO_C, " & _
	"CONVERT(VARCHAR, HE_DATATERMINO, 103) + ' ' + LEFT(CONVERT(VARCHAR, HE_DATATERMINO, 114),5) AS HE_DATATERMINO_C, " & _
	"HE_MOTIVO, s.S_DESCRICAO " & _
	"FROM Historico_Eventos he INNER JOIN Situacoes s " & _
	"ON he.ID_SITUACAO = s.ID_SITUACAO " & _
	"ORDER BY AG_NUMERO, HE_DATAINICIO --, HE_ID"
call Env.RecordSet(true, objRS, s)

if not (objRS.Eof and objRS.Bof) then 
	anterior = ""
	primeiro = true
	response.write "<br>"

	while not objRS.Eof
		if anterior <> objRS("AG_NUMERO") then%>
<%			if not primeiro then%>
</table>
<br><br>
<%			end if
			primeiro = false
%>
<span class="Texto1" style="font-size: 12px;">
	<b>AS: <%if not primeiro then response.write objRS("AG_NUMERO") else response.write anterior end if%></b>
</span>

<table width="100%" cellpadding="2" cellspacing="0" border="0" class="tabela1" style="border-top: solid thin;">
<tr>
	<th width="120px">Data Inicial</th>
	<th width="120px">Data Término</th>
	<th width="120px">Situação</th>
	<th align="left">Motivo</th>
</tr>
<%		end if%>
<tr valign="top">
	<td align="center"><%=objRS("HE_DATAINICIO_C")%>&nbsp;</td>
	<td align="center"><%=objRS("HE_DATATERMINO_C")%>&nbsp;</td>
	<td align="center"><%=objRS("S_DESCRICAO")%>&nbsp;</td>
	<td><%=objRS("HE_MOTIVO")%>&nbsp;</td>
</td>
</tr>
<%		anterior = objRS("AG_NUMERO")
		objRS.MoveNext
		response.flush
	wend
end if
%>
</table>
<br><br>
<%
call Env.RecordSet(false, objRS, null)
call imprimeRodape(RODAPE_OFF)
%>
