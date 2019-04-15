<!------- SCE ------->
<!--#include file="includes/global_SCE.asp"-->
<!------- SISLAB ---->
<!--#include file="../includes/bib_str.asp"-->
<!--#include file="../includes/padraoHTML.asp"-->
<!--#include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="../includes/Geral_Lib.asp"-->
<!--#include file="../includes/Sislab_Lib.asp"-->
<!------- LIB ------->
<!--#include file="../Classes/Classe_Combo.asp"-->
<%
Server.ScriptTimeout = 360000

if UCase(request("abrir_como")) = "REL" then _
	Tela.SetNomeTela = "SCE > Relatório > Reserva de Equipamento" _
else _
	Tela.SetNomeTela = "SCE > Consulta > Reserva de Equipamento"

Tela.SetCaminhoRelativo = "../"
Call Tela.MostraCabecalho()

If Env.UsuarioSCE() Then
    Dim Combo
    Set Combo = New TCombo

    Call Tela.ImprimeMenuSce()
%>
<script type="text/javascript">
	<!--#include file="includes/vform.js"-->
	<!--#include file="includes/montacnpj.inc"-->
	<!--#include file="includes/estado.asp"-->
</script>
<div class="margem-10">
<form name="formulario" method="post" action="sel_cad_reserva2.asp">
<input type="hidden" name="abrir_como" value="<%=ucase(request("abrir_como"))%>">
<table class="largura-total">
<tr>
	<td colspan="2">
<%		if request("msg") <> "" then
			if request("msg") = 1 then response.write " Reserva incluída com sucesso!"
			if request("msg") = 2 then response.write " Ítem alterada com sucesso!"
			if request("msg") = 3 then response.write " Reserva excluída com sucesso!"
			if request("msg") = 4 then response.write " É necessário selecionar algum campo de busca!"
			response.write "<BR><BR>"
		end if%>
	</td>
</tr>
<tr><th colspan="2">Selecione o Item</th></tr>
<tr><td>&nbsp;</td></tr>
<tr>
	<td colspan="2">Agendamento:&nbsp;<%RW Combo.MeusAgendamentos(False, "txtAS", "ag_numero", cstr(ag_numero), "N")%></td>
</tr>
<tr><td>&nbsp;</td></tr>
<tr>
	<td colspan="2">
        Responsável Técnico:&nbsp;
		<%RW Combo.PadraoSql("ag_responsavel", "select upper(USERID) as VALOR, CAST(NOME as VARCHAR(40)) as DESCRICAO from USERCRT where EXIBIR = 1 order by Nome", responsavel, "N")%>
	</td>
</tr>
<tr><td>&nbsp;</td></tr>
<tr>
	<td colspan="2" >
		Per&iacute;odo:&nbsp;
		<%RW Combo.Data("inicio")%>
		&nbsp;at&eacute;&nbsp;
		<%RW Combo.Data("termino")%>
	</td>
</tr>
<tr><td>&nbsp;</td></tr>
<tr>
	<td>Código Barras:&nbsp;<input type="text"  name="codbarras" size="25" maxlength="20"></td>
	<td>
        Fabricantes:&nbsp;
	    <%RW Combo.PadraoSql( "fabricante", "select fab_id as VALOR, fab_nome as DESCRICAO from sce_fabricantes order by fab_nome", "", "N")%>
	</td>
</tr>
<tr><td>&nbsp;</td></tr>
<tr>
	<td>Modelo:&nbsp;<input type="text" name="modelo" ></td>
	<td>Descri&ccedil;&atilde;o:&nbsp;<input type="text" name="desc_modelo"  size="50"></td>
</tr>
<tr><td>&nbsp;</td></tr>
<tr>
	<td colspan="2">
		<%RW Combo.EquipamentoConforme("conforme", true)%>
		&nbsp;&nbsp;&nbsp;
		<%RW Combo.SituacaoEquipamento("status", true, true, true, "")%>
		&nbsp;&nbsp;&nbsp;
		<%RW Combo.SimNaoInstrumental("instrumental", true)%>
		&nbsp;&nbsp;&nbsp;
		<%RW Combo.AmostraEquipamento("amostra", true)%>
	</td>
</tr>
<tr><td>&nbsp;</td></tr>
<tr>
	<td>
		Número de Série:&nbsp;
		<input type="text"  name="numeroserie" maxlength="50">
	</td>
	<td>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<%RW Combo.PropriedadeEquipamento("propriedade", True)%>
	</td>
</tr>
</table>
<br />
<p><input type="submit" name="buscar" value="Pesquisar"></p>
</form>
</div>

<script type="text/javascript">document.formulario.txtAS.focus();</script>
<%
Else
    RW Tela.Mensagem.AcessoRestritoSCE()
End If

Call Tela.MostraRodape()
%>
