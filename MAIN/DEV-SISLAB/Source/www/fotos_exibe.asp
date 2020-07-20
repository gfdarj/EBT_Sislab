<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/controleshtml.asp" -->
<%
Dim id_Arq
Dim chr_SQL
Dim chr_Link
Dim chr_Desc
Dim chr_URL

id_Arq = Request("arq")

chr_SQL = _
	"SELECT ARQ_NOMEARQ, ARQ_LINK, ARQ_CODARQ, ARQ_DESCRICAO " & _
	"FROM Arquivos " & _
	"WHERE ARQ_CODARQ = " & id_Arq
Call Env.RecordSet(True, RS, chr_SQL)
If Not (RS.Eof And RS.Bof) Then
	chr_URL = RS(0)
	chr_Link = RS(1)
	id_Arq = RS(2)
	chr_Desc = RS(3)
Else
	chr_Desc = "Arquivo não encontrado"
End If

Call Tela.ImprimeCabecalho2(TITULO_SITE, MENU_OFF, False, "", "Fotos", "javascript:window.close();", "")
%>
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" align="center">
<tr>
	<td width="100%" height="100%" valign="middle" align="center">
		<center1>
			<br><br>
			<b><%=chr_Link%></b>
			<br><br>
			<img border="0" title="<%=chr_Link%>" src="arquivos/<%=chr_URL%>">
			<br><br>
			<i><%=chr_Desc%></i>
			<br><br>
			<input type="button" class="btn btn-primary" value=" Fechar " onclick="javascript:window.close();">
			<br><br>
		</center1>
	</td>
</tr>
</table>
<%
Call Tela.MostraRodape()
%>
