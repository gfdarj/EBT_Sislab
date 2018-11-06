<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/controlesHTML.asp" -->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/funcoes.asp" -->
<%
Dim rs_teste, strSQL
Dim num_erro, desc_erro

Call Tela.ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Atualização de Testes", "location.href='sislab.asp'", "")
%>
<script type="text/javascript">
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

<div class="margem-10">
    <form name="formulario" action="form_especifica_teste.asp" method="post">
        <input type="hidden" name="cod_teste">
        <input type="hidden" name="excluir" value="">
    </form>

    <p>&nbsp;<span class="texto-vermelho-bold">&raquo;</span>&nbsp;Testes Disponíveis</p>

    <table class="table-bordered table-condensed table-striped table-hover" style="width: 100%;">
    <tr>
	    <th>Título</th>
	    <th style="text-align: center;">Disponível</th>
	    <th style="text-align: center;">Tipo</th>
	    <th>&nbsp;</th>
	    <th>&nbsp;</th>
    </tr>
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
	While Not rs_teste.EOF
%>
	<tr>
		<td>
			<a href="javascript:abre(<%= rs_teste("T_ID")%>, false)"><%= rs_teste("T_TITULO")%></a>
		</td>
		<td style="text-align: center;">
			<% if rs_teste("T_DISPONIVEL") Then %>
            <span class="text-success">Sim</span>
			<% else %>
            <span class="text-danger">Não</span>
			<% end if%>
		</td>
		<td style="text-align: center;">
			<%=rs_teste("TIT_DESCRICAO")%>
		</td>
		<td style="text-align: center;"><a href="javascript:abre(<%=rs_teste("T_ID")%>, false);">Editar</a></td>
		<td style="text-align: center;"><a href="javascript:abre(<%=rs_teste("T_ID")%>, true);">Excluir</a></td>
	</tr>
<%		rs_teste.MoveNext()
		conta = conta + 1
	wend
	rs_teste.Close
	set rs_teste = nothing
%>
    </table>
    <br>
</div>
<%
Call Tela.MostraRodape()
%>
