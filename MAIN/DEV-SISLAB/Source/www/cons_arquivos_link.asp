<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/controleshtml.asp" -->
<script language="javascript" src="includes/anexo.js"></script>
<% 
Call ImprimeCabecalho2(TITULO_SITE, MENU_ON, False, "2000px", "Validação dos Arquivos", "location.href='sislab.asp'", "")

Dim RS
Dim chr_SQL
Dim chr_Arquivo
Dim int_Conta
Dim int_ContaOk
Dim int_ContaErro
Dim objFSO
Dim chr_Folder
Dim bln_Existe
Dim chr_Situacao

chr_Situacao = RQ("situacao")

If Not VVVN(RQ("Excel")) Then
	'RW "<META HTTP-EQUIV=""Content-Type"" CONTENT=""application/vnd.ms-excel"">"
	Response.ContentType = "application/excel"
	Response.Clear
	'Se tirarmos o attachment da linha baixo, ele não vai pedir 2 vezes pra abrir, mas vai abrir na própria janela...
	Response.AddHeader "Content-Disposition", "filename=" & chr(34) & "validacao_arquivos.xls" & chr(34)
End If

Set objFSO = Server.CreateObject("Scripting.FileSystemObject")
'Set Folder = ObjFso.GetFolder(Server.mapPath(".") & "\arquivos\")

chr_Folder = Server.mapPath(".") & "\arquivos\"
'RW chr_Folder & "<BR>"

chr_SQL = "" & _
	"SELECT a.arq_codarq, a.arq_codarqtipo, a.arq_link, a.arq_nomearq, a.arq_responsavel," & VbCrLf & _
	"	ta.tar_tipoarquivo, d.ag_numero" & VbCrLf & _
	"FROM arquivos a INNER JOIN TipoArquivo ta ON ta.tar_codtipoarquivo = a.arq_codarqtipo" & VbCrLf & _
	"LEFT JOIN diagramas d ON d.arq_codarq = a.arq_codarq" & VbCrLf & _
	"/*WHERE a.arq_codarq = 3256*/ " & VbCrLf & _
	"ORDER BY ta.tar_tipoarquivo, d.ag_numero DESC, a.arq_link "

Set RS = Env.oConn.Execute(chr_SQL)

'chr_arquivo = "arquivo de maçã doce.pdf"
'RW chr_arquivo & "<BR>"
'RW ValidaNomeArquivo(chr_arquivo, true) & "<BR>"
'RW chr_arquivo & "<BR>"
int_Conta = 0
int_ContaOk = 0
int_ContaErro = 0
%>
<form action="" method="post">
<input type="Hidden" name="Excel" value="">
<span class="texto1">
Situação:
	<select name="situacao" onchange="document.forms[0].Excel.value=''; document.forms[0].submit();" class="texto1">
		<option value="" <%If VVVN(chr_Situacao) Then RW "selected" End If%>>Todos</option>
		<option value="OK" <%If chr_Situacao = "OK" Then RW "selected" End If%>>Apenas OK</option>
		<option value="ERRO" <%If chr_Situacao = "ERRO" Then RW "selected" End If%>>Apenas com ERRO</option>
	</select>
<!--	&nbsp;&nbsp;&nbsp;
	<a href="#" onclick="javascript:document.forms[0].Excel.value='1'; document.forms[0].submit();">Exportar para o Excel</a>-->
</span>
<BR><BR>
<table width="*" border="1" class="tabela1">
<tr>
	<th align="center">*</th>
	<th align="center">ID</th>
	<th>Tipo</th>
	<th>Arquivo</th>
	<th align="center">Responsável</th>
	<th align="center">AS</th>
</tr>
<%
While Not RS.Eof
	chr_Arquivo = Replace(RS("arq_nomearq"), "\\", "\")
	bln_Existe = objFSO.FileExists(chr_Folder & chr_Arquivo)
	If bln_Existe Then
		If (chr_Situacao = "") Or (chr_Situacao = "OK") Then int_ContaOk = int_ContaOk + 1
	Else
		If (chr_Situacao = "") Or (chr_Situacao = "ERRO") Then int_ContaErro = int_ContaErro + 1
	End If

	If (chr_Situacao = "") Or (chr_Situacao = "OK" And bln_Existe) Or (chr_Situacao = "ERRO" And Not bln_Existe) Then%>
<tr>
	<td align="center" bgcolor="<%=IIf(bln_Existe, "green", "red")%>"><font color="#ffffff"><%=IIf(bln_Existe, "OK", "ERRO")%></font></td>
	<td align="center"><%=RS("arq_codarq")%></td>
	<td><%=RS("tar_tipoarquivo")%></td>
	<td>
		<%=RS("arq_link")%><BR><BR>
		<%=RS("arq_nomearq")%>
	</td>
	<td align="center"><%=RS("arq_responsavel")%>&nbsp;</td>
	<td align="center"><%=RS("ag_numero")%>&nbsp;</td>
</tr>
<%		int_Conta = int_Conta + 1
	End If

	RS.MoveNext
WEnd
%>
</table>
</form>
<%
RW "<BR><b>Total encontrado: " & int_Conta & "&nbsp;&nbsp&nbsp;&nbsp;"
RW "Total OK: " & int_ContaOK & "&nbsp;&nbsp&nbsp;&nbsp;"
RW "Total com ERRO: " & int_ContaErro & "</b><BR><BR>"

Set objFSO = Nothing

Call imprimeRodape(RODAPE_OFF)
%>
