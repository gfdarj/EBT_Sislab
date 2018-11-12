<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<%
Dim s, objRS
Dim anterior : anterior = 0
Dim conta, ordem
Dim dt_ini_anterior, dt_fim_anterior, data_invalida, conta_data_invalida

ordem = Trim(Request("Ord"))

If ordem = "" Then
    Call Tela.ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Histórico de Agendamentos - Listagem de AS por ordem de datas", "location.href='sislab.asp'", "")
Else
    Call Tela.ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Histórico de Agendamentos - Listagem de AS por ordem de cadastro", "location.href='sislab.asp'", "")
End If

Server.ScriptTimeout = 1000
Response.buffer = True
Response.Flush

s = "SELECT AG_NUMERO, HE_DATAINICIO, HE_DATATERMINO, " & _
	"CONVERT(VARCHAR, HE_DATAINICIO, 103) + ' ' + LEFT(CONVERT(VARCHAR, HE_DATAINICIO, 114),5) AS HE_DATAINICIO_C, " & _
	"CONVERT(VARCHAR, HE_DATATERMINO, 103) + ' ' + LEFT(CONVERT(VARCHAR, HE_DATATERMINO, 114),5) AS HE_DATATERMINO_C, " & _
	"HE_MOTIVO, s.S_DESCRICAO " & _
	"FROM Historico_Eventos he INNER JOIN Situacoes s " & _
	"ON he.ID_SITUACAO = s.ID_SITUACAO "

If ordem = "" Then
	s = s & "ORDER BY AG_NUMERO, HE_DATAINICIO --, HE_ID"
Else
	s = s & "ORDER BY AG_NUMERO, HE_ID"
End If

Call Env.RecordSet(true, objRS, s)
%>
<div class="margem-10">
<%
if not (objRS.Eof and objRS.Bof) then 
    conta = 0
	anterior = ""
	primeiro = true
	response.write "<br>"

	while not objRS.Eof
		if anterior <> objRS("AG_NUMERO") then
			dt_ini_anterior = objRS("HE_DATAINICIO")
			dt_fim_anterior = objRS("HE_DATATERMINO")

			If Not primeiro Then %>
</table>
<br /><br />
<%			End If
			primeiro = False
%>
<span>
	<strong>AS: <%if not primeiro then response.write objRS("AG_NUMERO") else response.write anterior end if%></strong>
</span>

<table class="table-bordered table-condensed table-striped" style="width:100%;">
<tr>
	<th style="width: 140px; text-align: center;">Data Inicial</th>
	<th style="width: 140px; text-align: center;">Data Término</th>
	<th style="width: 130px; text-align: center;">Situação</th>
	<th align="left">Motivo</th>
</tr>
<%		end if

		if dt_ini_anterior > objRS("HE_DATAINICIO") then
			data_invalida = true 
			conta_data_invalida = conta_data_invalida + 1
		else
			data_invalida = false
		end if %>

<tr style="vertical-align: top;" class="<%if data_invalida then response.write "bg-danger"%>">
	<td style="text-align: center;"><%=objRS("HE_DATAINICIO_C")%>&nbsp;</td>
	<td style="text-align: center;"><%=objRS("HE_DATATERMINO_C")%>&nbsp;</td>
	<td style="text-align: center;"><%=objRS("S_DESCRICAO")%>&nbsp;</td>
	<td><%=objRS("HE_MOTIVO")%>&nbsp;</td>
</tr>
<%		anterior = objRS("AG_NUMERO")
		dt_ini_anterior = objRS("HE_DATAINICIO")
		dt_fim_anterior = objRS("HE_DATATERMINO")
        conta = conta + 1
        If conta Mod 100 Then response.flush
		objRS.MoveNext
	WEnd
End If
%>
</table>
<%
If conta_data_invalida > 0 Then %>
    <br />
	<p><small>Foram encontradas <%=conta_data_invalida%> datas inválidas</small></p>
	<p><small>Observação: As linhas destacadas estão inválidas em relação ao histórico do seu respectivo agendamento</small></p>
<%
End If
%>
</div>
<br />
<%
Call Env.RecordSet(false, objRS, null)
Call Tela.MostraRodape()
%>
