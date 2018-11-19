<!------- LIB ------->
<!--#include file="../Classes/Classe_Combo.asp"-->
<!------- SCE ------->
<!--#include file="includes/global_SCE.asp"-->
<!------- SISLAB ---->
<!--#include file="../includes/bib_str.asp"-->
<!--#include file="../includes/padraoHTML.asp"-->
<!--#include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="../includes/Geral_Lib.asp"-->
<!--#include file="../includes/Sislab_Lib.asp"-->
<%
Tela.SetNomeTela = "SCE > Consulta > Modelo" : Tela.SetCaminhoRelativo = "../"
Call Tela.MostraCabecalho()

If Env.UsuarioSCE() Then
    Dim Combo
    Set Combo = New TCombo

    Call Tela.ImprimeMenuSce()
%>
<div class="margem-10">
<form name="formulario" method="post" action="busca_modelo.asp">
<%  if request("msg") <> "" Then %>
	<div >
<%		if cint(request("msg")) =1 then response.write "<br>Modelo atualizado com sucesso!<br><br>"
		if cint(request("msg")) =2 then response.write "<br>Modelo excluído com sucesso!<br><br>" %>
	</div>
<%	end if %>
<table>
<tr valign="top">
	<th colspan="3">Editar / Excluir Modelo Cadastrado</th>
</tr>
<tr>
	<td>
	<table width="100%">
		<tr><td >&nbsp;</td></tr>
		<tr >
			<td>
				Busque por Modelo<br /><input type="text" name="modelo" >
			</td>
		</tr>
		<tr><td >&nbsp;</td></tr>
		<tr >
			<td>
				Busque por Part Number<br /><input type=text name="partnumber" >
			</td>
		</tr>
		<tr><td >&nbsp;</td></tr>
		<tr >
			<td>
			Busque por Fabricante<br />
			<%RW Combo.PadraoSql( "fab_id", "select fab_id as VALOR, fab_nome as DESCRICAO from sce_fabricantes order by fab_nome", "", "N")%>
			</td>
		</tr>
		<tr><td >&nbsp;</td></tr>
		<tr >
			<td>
			Busque por Descrição<br /><input type="text" name="descricao"  size="50">
			</td>
		</tr>
		<tr><td >&nbsp;</td></tr>
		<tr><td align="center"></td></tr>
	</table>
	</td>
	<td width="50px">&nbsp;</td>
	<td></td>
</tr>
</table>
<p>
    <input type="button"  value="Pesquisar" onclick="javascript:validaCampos();">
</p>
</form>
</div>
<script type="text/javascript">
    var f = document.all.formulario;
    function validaCampos() {
	    if((f.modelo.value == '') && (f.partnumber.value == '') && (f.fab_id.value == '') && (f.descricao.value == ''))
		    alert('Preencha pelo menos um dos campos da pesquisa.');
	    else
		    f.submit();
    }
    f.modelo.focus();
</script>
<%
Else
    RW Tela.Mensagem.AcessoRestritoSCE()
End If

Call Tela.MostraRodape()
%>
