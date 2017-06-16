<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/controlesHTML.asp" -->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/funcoes.asp" -->
<%
Dim rs_teste, strSQL
Dim num_erro, desc_erro

call imprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Atualização de Testes", "location.href='sislab.asp'", "")
%>
<script language="javascript">
function abre(codigo, excluir)
{
	document.formulario.cod_teste.value = codigo;
	if(excluir) {
		document.formulario.action = "form_especifica_testeA.asp";
		document.formulario.excluir.value= '1';
	}
	else
		document.formulario.action = "form_especifica_teste.asp";

	document.formulario.submit();
}
</script>
<form name="formulario" action="form_especifica_teste.asp" method="post">
<input type="hidden" name="cod_teste">
<input type="hidden" name="excluir" value="">
</form>
<p class="texto1">
	&nbsp;<span class="vermelho2">&raquo;</span>&nbsp;<span class="texto1b" style="font-size: 12px;">Testes Disponíveis</span>
</p>
<table border="1" cellSpacing="0" cellpadding="2" width="100%" class="tabela1">
<tr>
	<th>Título</th>
	<th>Disponível</th>
	<th>Tipo</th>
	<th>&nbsp;</th>
	<th>&nbsp;</th>
</tr>
<tr>
<%
	set rs_teste = Server.CreateObject("ADODB.RecordSet")
	Set rs_teste.ActiveConnection = Env.oConn

	strSQL = "select T_ID, T_TITULO, T_DISPONIVEL, TIT_DESCRICAO from testes t inner join tipo_teste tt on t.TIT_ID = tt.TIT_ID "
	strSQL = strSQL & " order by TIT_DESCRICAO, T_TITULO, T_DISPONIVEL"

	rs_teste.Source = strSQL
	rs_teste.Open
	if Env.oConn.Errors.Count <> 0 then
		Response.Clear 
		rs_teste.Close
		set rs_teste = nothing
		num_erro = Server.URLEncode(Err.number)
		desc_erro = Server.URLEncode(Err.Description)
		Env.oConn.Close
		Response.Redirect "erro.asp?perro=" & num_erro & "&pdescricao=" & desc_erro
	end if

	conta = 1
	while not rs_teste.EOF
%>
		<TR <%if (conta mod 2) = 0 then response.write "class='cinza3Bg'"%>>
			<TD>
				<a href="javascript:abre(<%= rs_teste("T_ID")%>, false)"><%= rs_teste("T_TITULO")%></a>
			</TD>
			<TD align="center">
				<%if rs_teste("T_DISPONIVEL") then
					response.write "Sim"
				else
					response.write "Não"
				end if%>
			</TD>
			<TD align="center" width="100px">
				<%=rs_teste("TIT_DESCRICAO")%>
			</TD>
			<td><a href="javascript:abre(<%=rs_teste("T_ID")%>, false);">Editar</a></td>
			<td><a href="javascript:abre(<%=rs_teste("T_ID")%>, true);">Excluir</a></td>
		</TR>
<%		rs_teste.MoveNext()
		conta = conta + 1
	wend
	rs_teste.Close
	set rs_teste = nothing
%>
</tr>
</table>
<br>
<%
call imprimeRodape(RODAPE_ON)
%>
