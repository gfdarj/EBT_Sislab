<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/controleshtml.asp" -->
<!--#include file="includes/funcoes.asp" -->
<%
Dim objSiteRS, objSiteMail, objArquivos, contte, contat, sSQL, tot,auxbarq, objsiteCRT
Dim auxareateste,auxtipoteste,auxsituacaoteste,auxdiasteste, auxdescricao, auxsolicitante
Dim auxRT, auxRAT, auxusername, EH_CRT, aux_Sigilo, auxorgao, auxtecnologia, auxorgaosel,auxAs

Call Tela.ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Relatório de LOGBOOK", "", "")

EH_CRT = Env.UsuarioCRT()
%>
<form name="formteste" method="post" action="rel_logbook.asp">
<input type=hidden name="doformteste" value=1>
<table width=100% class="table-bordered" cellpadding="2" cellspacing="2">
	<tr><td width=10%></td>
		<td width=10%></td>
		<td width=10%></td>
		<td width=10%></td>
		<td width=10%></td>
		<td width=10%></td>
		<td width=10%></td>
		<td width=10%></td>
		<td width=10%></td>
		<td width=10%></td>
	</tr>
<tr>
	<td colspan="10">
		&nbsp;<span class="texto-vermelho-bold">&raquo;</span>&nbsp;<span class="texto1b" style="font-size: 12px;">Selecione uma das opções de filtro para consulta</span>
	</td>
</tr>
<tr><td colspan="10">&nbsp;</td></tr>
<tr>
	<td colspan=1  align=left valign=top>
		<B>&nbsp;N&deg; OC</B><br>
		&nbsp;&nbsp;<input type="text" class="texto1" name="ocorrencia" size="5">
	</td>
	<td colspan=1  align=left valign=top>
		<B>OPM <br><input type="Checkbox" name="chkOPM"></B>
	</td>
	<td colspan=8  align=left valign=top>
		<B>Possui Ações...</B><BR>
		<input type="Checkbox" name="chkAI"> Imediatas
		&nbsp;&nbsp;&nbsp;
		<input type="Checkbox" name="chkAP"> Preventivas
		&nbsp;&nbsp;&nbsp;
		<input type="Checkbox" name="chkAC"> Corretivas
		&nbsp;&nbsp;&nbsp;
		<input type="Checkbox" name="chkAM"> De Melhoria
	</td>
</tr>

	<tr>
		<td colspan=3 align=left valign=top>
			<B>&nbsp;RAT :</B><br>
			&nbsp;
			<%call comboRatTodos("rat",Env.oconn,true)%>
			
		</td>
		<td colspan=7  align=left valign=top>
			<font face="tahoma" class="fontmenu1"><B>
			&nbsp;Responsável :</B><br>
			&nbsp;
			<%call comboUserCRTVivoEMortos("responsavel",Env.oConn,true)%>
			
		</td>
		</tr>
<tr>
		<td colspan=4  align=left valign=top>
			<font face="tahoma" class="fontmenu1"><B>
			&nbsp;Descrição :</B><br>
			&nbsp;
			<input type="text" class="texto1" name="desc" size="60">
		</td>
		<td colspan=5  align=left valign=top>
			<B>&nbsp;Cadastrado por :</B><br>
			&nbsp;
			<%call comboUSERCRT("cadastrante",Env.oConn,true)%>
		</td>
</tr>
<tr>
	<td colspan=2  align=left valign=top>
		<B>
		&nbsp;Tipo da Ocorrência :</B><br>
		&nbsp;
		<%call comboBDSQL( "tipoOcorrencia", Env.oConn,"select LBTO_ID AS VALOR,lBTO_DESCRICAO AS DESCRICAO from LB_TipoOcorrencia", null, true)%>
		
	</td>
	<td colspan=2  align=left valign=top>
		<B>
		&nbsp;Somente Vencidas <br><input type="Checkbox" name="chkOcVencida"></B>
	</td>
	<td colspan=2  align=left valign=top>
		<B>
		&nbsp;Criticidade :</B><br>
		&nbsp;
		<%call comboCriticidade("criticidade")%>
		
	</td>
	<td colspan=4  align=left valign=top>
		<B>
		&nbsp;Estado da Ocorrência :</B><br>
		&nbsp;
		<%call comboEstadoOCorrencia("estado")%>
	</td>
</tr>
<tr>				
	<td colspan=10  align=left valign=top>
		<B>&nbsp;Ocorrido Entre :</B><br>
			&nbsp;Data Inicial : 
			<%call comboData("dataIniCad")%>&nbsp;&nbsp;Data Final :
			<%call comboData("dataFimCad")%>
			
	</td>
</tr>
<tr><td colspan="10">&nbsp;</td></tr></tr>
<tr>
	<td colspan="10">
		<input type=button name="Filtro" class="texto1" Value="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Ok&nbsp;&nbsp;&nbsp;&nbsp;" onclick="envia();">
	</td>
</tr>
</table>
</form>
<script>
function envia(){
	document.forms[0].submit();
}
</script>
<%
Call Tela.MostraRodape()
%>
