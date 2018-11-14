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
Tela.SetNomeTela = "SCE > Relatório > Equipamento" : Tela.SetCaminhoRelativo = "../"
Call Tela.MostraCabecalho()

If Env.UsuarioSCE() Then
    Dim Combo

    Set Combo = New TCombo

    Call Tela.ImprimeMenuSce()
%>
<form name="formulario" action="rel_equipamento2.asp" method="post">
<table >
<tr><td colspan="2" valign="middle" class="destaque">Selecione o Item:</td></tr>
<tr><td>&nbsp;</td></tr>
<tr>
	<td width="40%">
		Código Barras:&nbsp;<input type="text"  name="codbarras" size="25">
	</td>
	<td>
		Fabricantes:&nbsp;
		<%=Combo.PadraoSql("fabricante", "select fab_id as VALOR, fab_nome as DESCRICAO from sce_fabricantes order by fab_nome", "", "N")%>
	</td>
</tr>
	
<tr><td>&nbsp;</td></tr>

<tr>
	<td>Modelo:&nbsp;<input type=text name=modelo ></td>
	<td>Descri&ccedil;&atilde;o:&nbsp;<input type="text" name="desc_modelo"  size="50"></td>
</tr>

<tr class="texto"><td>&nbsp;</td></tr>

<tr>
	<td colspan="2">
		Número de Série:&nbsp;<input type="text"  name="numeroserie" maxlength="50">
		&nbsp;&nbsp;&nbsp;&nbsp;
		Controle do Instrumental:&nbsp;
		<select name="controle" >
			<option value="">--</option>
			<option value="<%=CONTROLE_CALIBRACAO%>">Calibra&ccedil;&atilde;o</option>
			<option value="<%=CONTROLE_MANUTENCAO%>">Manuten&ccedil;&atilde;o</option>
			<option value="<%=CONTROLE_QUALIFICACAO%>">Qualifica&ccedil;&atilde;o</option>
		</select>
		&nbsp;&nbsp;&nbsp;&nbsp;
	Registro/Certificado/CDE/RMA:&nbsp;<input type="text"  name="cde_equip" size="10">
	</td>
</tr>

<tr class="texto"><td>&nbsp;</td></tr>

<tr>
	<td colspan="2">
		Instrumental:&nbsp;
		<select name="instrumental" >
			<option value="">Todos</option>
			<option value="1">Sim</option>
			<option value="0">Não</option>
		</select>
		&nbsp;&nbsp;&nbsp;&nbsp;
		Conforme:&nbsp;
		<select name="conforme" >
			<option value="">Todos</option>
			<option value="1">Sim</option>
			<option value="0">Não</option>
		</select>
		&nbsp;&nbsp;&nbsp;&nbsp;
		Situa&ccedil;&atilde;o:&nbsp;
		<select name="status" >
			<option value="">Todos</option>
			<option value="<%=STATUS_EM_ESTOQUE%>">Em estoque</option>
			<option value="<%=STATUS_EM_USO%>">Em uso</option>
			<option value="<%=STATUS_EXPEDIDO%>">Expedido</option>
			<option value="<%=STATUS_EXPEDIDO_SUBST%>">Substituído</option>
		</select>
		&nbsp;&nbsp;&nbsp;&nbsp;
		<%=Combo.PropriedadeEquipamento("propriedade", true)%>
	</td>	
</tr>

<tr ><td>&nbsp;</td></tr>

<tr>
	<td colspan="2">
		Plataforma: <%=Combo.ServicosPlataformas("plataforma", "N", "P")%>
	</td>	
</tr>

<tr class="texto"><td>&nbsp;</td></tr>

<tr>
	<td colspan="2">
		Período:&nbsp;
		<%=Combo.Data("Ini")%>&nbsp;&nbsp;até&nbsp;&nbsp;<%=Combo.Data("Fim")%>
	</td>
</tr>

<tr ><td>&nbsp;</td></tr>

<tr>
	<td>&nbsp;</td>
	<td align="center">
		<input type="submit" name="buscar" value="próximo &gt;&gt;" >
	</td>
</tr>
</table>
</form>
</form>
<%
Else
    RW Tela.Mensagem.AcessoRestritoSCE()
End If

Call Tela.MostraRodape()
%>
