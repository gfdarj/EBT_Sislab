<!------- SISLAB ---->
<!------- LIB ------->
<!--#include file="../Lib/Classe_Combo.asp"-->
<!------- SCE ------->
<!--#include file="includes/SCE_Lib.asp"-->
<%
'-- GERA UMA LISTAGEM DE EQUIPAMENTOS
'-- RELATORIO DE EQUIPAMENTOS/INSTRUMENTAIS COM BASE NA NOVA FORMA DE GERENCIAR AS CALIBRAÇÔES E MANUTENÇÔES

Tela.SetNomeTela = "SCE > Relatório > Controle de Equipamento e Instrumental (NOVO)"
Call Tela.MostraCabecalho()

If Env.UsuarioSCE() Then
    Dim Combo
    Set Combo = New TCombo

    Call Tela.ImprimeMenuSce()
%>
<form name="formulario" action="rel_instrumentalnovo2.asp" method="post">
<input type="hidden" value="" name="exportaExcel">

<table width="750px" class="texto1">
<tr><td colspan="2" valign="middle" class="destaque">Selecione as opções de filtro</td></tr>
<tr><td>&nbsp;</td></tr>
<tr>
	<td>
		Código Barras:&nbsp;<input type="text" class="texto1" name="codbarras" size="25">
	</td>
	<td>
		Fabricantes:&nbsp;
		<%=Combo.PadraoSql("fabricante", "select fab_id as VALOR, fab_nome as DESCRICAO from sce_fabricantes order by fab_nome", "", "N")%>
	</td>
</tr>
	
<tr><td>&nbsp;</td></tr>

<tr>
	<td>Modelo:&nbsp;<input type=text name=modelo class="texto1"></td>
	<td>Descri&ccedil;&atilde;o:&nbsp;<input type="text" name="desc_modelo" class="texto1" size="50"></td>
</tr>

<tr class="texto1"><td>&nbsp;</td></tr>

<tr>
	<td>Número de Série:&nbsp;<input type="text" class="texto1" name="numeroserie" maxlength="50"></td>
	<td>
		Instrumental:&nbsp;
		<select name="instrumental" class="texto1">
			<option value="">Todos</option>
			<option value="1" selected>Sim</option>
			<option value="0">Não</option>
		</select>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		Conforme:&nbsp;
		<select name="conforme" class="texto1">
			<option value="">Todos</option>
			<option value="1">Sim</option>
			<option value="0">Não</option>
		</select>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		Situação:&nbsp;
		<select name="status" class="texto1">
			<option value="">Todos</option>
			<option value="<%=STATUS_EM_ESTOQUE%>">Em estoque</option>
			<option value="<%=STATUS_EM_USO%>">Em uso</option>
			<option value="<%=STATUS_EXPEDIDO%>">Expedido</option>
			<option value="<%=STATUS_EXPEDIDO_SUBST%>">Substituído</option>
		</select>
	</td>	
</tr>

<tr class="texto1"><td>&nbsp;</td></tr>

<tr>
	<td colspan="2">
		Plataforma: <%=Combo.ServicosPlataformas("plataforma", "N", "P")%>
	</td>	
</tr>

<tr class="texto1"><td>&nbsp;</td></tr>

<tr>
	<td>
		Controle do Instrumental:&nbsp;
		<select name="controle" class="texto1">
			<option value="">--</option>
			<option value="<%=CONTROLE_CALIBRACAO%>">Calibração</option>
			<option value="<%=CONTROLE_MANUTENCAO%>">Manutenção</option>
		</select>
	</td>
	<td>A vencer em até <input type="Text" class="texto1" name="vencimento" size="5"> dias</td>
</tr>

<tr class="texto1"><td>&nbsp;</td></tr>
<tr>
	<td colspan="2">
		Período:&nbsp;
		<%=Combo.Data("Ini")%>&nbsp;&nbsp;até&nbsp;&nbsp;<%=Combo.Data("Fim")%>
	</td>
</tr>

<tr class="texto1"><td>&nbsp;</td></tr>

<tr>
	<td>&nbsp;</td>
	<td align="center">
	    <script language="javascript">
	    function exportaParaExcel()
	    {
		    document.formulario.target = "_blank";
		    document.formulario.exportaExcel.value = 'S';
		    document.formulario.submit();
	    }
	    function envia()
	    {
		    document.formulario.target = "_self";
		    document.formulario.exportaExcel.value = '';
		    document.formulario.submit();
	    }
	    </script>
		<input type="button" name="buscar" value="próximo &gt;&gt;" class="texto1" onclick='javascript: envia();'>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" name="buscar" value="Exportar para Excel" class="texto1" onclick="javascript:exportaParaExcel();">
	</td>
</tr>
</table>
</form>
<%
Else
    RW Tela.Mensagem.AcessoRestritoSCE()
End If

Call Tela.MostraRodape()
%>
