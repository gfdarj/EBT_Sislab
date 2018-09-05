<!--#include file="includes/Sislab_Lib.asp" -->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/PadraoHTML.asp" -->
<%
Dim objSiteRS
Dim cont
Dim sSQL
Dim int_Cols
Dim int_SizeCols
Dim int_Contador
Dim chr_Buf
Dim bln_Primeiro

call ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Equipe / Estrutura Interna", "", "")

sSQL="Select COUNT(DISTINCT ORGA_HIERARQUIA) from Orgao WHERE ORGA_EXIBIR = 1"
call Env.RecordSet(True, objSiteRS, sSQL)
int_Cols = objSiteRS(0)
call Env.RecordSet(False, objSiteRS, sSQL)
%>

<table border="0" cellpadding="2" cellspacing="4" class="tabela1" width="100%">
<tr>
	<td colspan="<%=int_Cols%>" class='texto1' align="center">
		<span class='texto1b' style='font-size: 15px;'>ESTRUTURA INTERNA</span><br>
		<a href="http://ntspo901/portalrh/organograma/embrapar.htm" target="_blank"><i>(veja o organograma da empresa aqui)</i></a>
	</td>
</tr>
</table>
<table border="0" cellpadding="2" cellspacing="4" class="tabela1" align="center">
<tr>
<%
	int_Cols = int_Cols * 1.5
	int_SizeCols = Round(100/int_Cols)
	For i = 1 To (int_Cols - 1)
		RW "	<td width='" & int_SizeCols & "%'></td>" & VbCrLf
	Next
	RW "<td width='*'></td>"
%>
</tr>
<%
sSQL="Select * from Orgao WHERE ORGA_EXIBIR = 1 ORDER BY ORGA_HIERARQUIA ASC;"
call Env.RecordSet( true, objSiteRS, sSQL)

If Not objSiteRS.EOF Then
    objSiteRS.Movefirst
%>
<%
	int_Contador = int_Cols + 1
	int_Hierarq = objSiteRS("ORGA_HIERARQUIA")
	bln_Primeiro = True
	While Not objSiteRS.Eof

		chr_Buf = chr_Buf & _
				"<tr class='texto1b'>"

		If (int_Hierarq <> objSiteRS("ORGA_HIERARQUIA")) Or (bln_Primeiro) Then
			int_Contador = int_Contador - 1
			If int_Contador = int_Cols Then
				chr_Buf = chr_Buf & _
					"	<td width='100%' colspan='" & int_Cols & "'><span class='vermelho2'><b>*</span>&nbsp;<span style='font-size: 11px; color: Navy;'>" & objSiteRS("ORGA_DESCRICAO") & "</span><br>&nbsp;&nbsp;&nbsp;<i>" & objSiteRS("ORGA_USERIDCHEFE") & "</i><br>&nbsp;&nbsp;&nbsp;<i><span style='font-weight: normal; font-size: 9px;'>" & Env.Ebt.AchaNomeEmbratel(objSiteRS("ORGA_USERIDCHEFE")) & "</span></i></td>"
			Else
				chr_Buf = chr_Buf & _
					"	<td colspan='" & (int_Cols - int_Contador) & "'>&nbsp;</td>" & _
					"	<td colspan='" & int_Cols - (int_Cols - int_Contador) & "' width='" & (int_SizeCols * int_Contador) & "%'><span class='vermelho2'><b>*</span>&nbsp;<span style='font-size: 11px; color: Navy;'>" & objSiteRS("ORGA_DESCRICAO") & "</span><br>&nbsp;&nbsp;&nbsp;<i>" & objSiteRS("ORGA_USERIDCHEFE") & "</i><br>&nbsp;&nbsp;&nbsp;<i><span style='font-weight: normal; font-size: 9px;'>" & Env.Ebt.AchaNomeEmbratel(objSiteRS("ORGA_USERIDCHEFE")) & "</span></i></td>"
			End If
			bln_Primeiro = False
		Else
			chr_Buf = chr_Buf & _
				"	<td colspan='" & (int_Cols - int_Contador) & "'>&nbsp;</td>" & _
				"	<td colspan='" & int_Cols - (int_Cols - int_Contador) & "' width='" & (int_SizeCols * int_Contador) & "%'><span class='vermelho2'><b>*</span>&nbsp;<span style='font-size: 11px; color: Navy;'>" & objSiteRS("ORGA_DESCRICAO") & "</span><br>&nbsp;&nbsp;&nbsp;<i>" & objSiteRS("ORGA_USERIDCHEFE") & "</i><br><i>&nbsp;&nbsp;&nbsp;<span style='font-weight: normal; font-size: 9px;'>" & Env.Ebt.AchaNomeEmbratel(objSiteRS("ORGA_USERIDCHEFE")) & "</span></i></td>"
		End If

		chr_Buf = chr_Buf & _
			"</tr>" & VbCrLf

		int_Hierarq = objSiteRS("ORGA_HIERARQUIA")

		objSiteRS.MoveNext
	WEnd

	RW chr_Buf
End If

Call Env.RecordSet(False, objSiteRS, sSQL)
%>
</table>

<br>

<table border="0" cellpadding="2" cellspacing="4" class="tabela1" align="center">
<tr>
	<td></td>
	<td></td>
	<td></td>
	<td></td>
</tr>
<tr>
	<td colspan="4" align="center">
		<span class='texto1b' style='font-size: 15px;'>EQUIPE CRT</span><br>
		<a target="_blank" href="http://ntspo901/PORTALVPR/ProjetosEAdmRede/EstrategiaPortifTec/SISLAB1/arquivos/DO%205.2-002_09%20-%20DESIGNAÇÃO%20DE%20FUNCOES%2010-07-06.pdf"><i>(veja o quadro com a designação de funções)</i></a>
	</td>
</tr>
<tr class="texto1b">
	<td bgcolor="#FFFFBB">&nbsp;Matrícula</td>
	<td bgcolor="#FFFFBB">&nbsp;Empregado</td>
	<td bgcolor="#FFFFBB">&nbsp;Ramal</td>
	<td bgcolor="#FFFFBB">&nbsp;Username</td>
</tr>
<%
sSQL="Select * from UserCRT where exibir=1 and not matricula is null order by nome asc ;"
call Env.RecordSet( true, objSiteRS, sSQL)

If Not objSiteRS.EOF Then
    objSiteRS.Movefirst

	Do while not(objSiteRS.eof)
%>
<tr>
	<td>&nbsp;<%=objSiteRS("MATRICULA")%></td>
	<td>&nbsp;<%=objSiteRS("NOME")%></td>
	<td>&nbsp;<%=objSiteRS("RAMAL")%></td>
	<td>&nbsp;<%=Ucase(objSiteRS("UserID"))%></td>
</tr>
<%
	objSiteRS.MoveNext
	Loop

	'-- Fechar Objetos abertos
	objSiteRS.Close
	Set objSiteRS = Nothing

End If
%>
</table>
<br><br>
<%
Call imprimeRodape(RODAPE_OFF)
%>