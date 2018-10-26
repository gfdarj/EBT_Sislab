<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/controleshtml.asp" -->
<!--#include file="includes/funcoes.asp" -->
<%
call ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Alteração das mensagens de e-mails automáticas", "location.href='sislab.asp'", "")

Dim objSiteRS, objSiteMail, objArquivos, contte, contat, sSQL, tot,auxbarq, objsiteCRT
Dim auxareateste,auxtipoteste,auxsituacaoteste,auxdiasteste, auxdescricao, auxsolicitante
Dim auxRT, auxRAT, auxusername, EH_CRT, aux_Sigilo, auxorgao, auxtecnologia, auxorgaosel,auxAs

EH_CRT = Env.UsuarioCRT
%>
<form name="formteste" method="post" action="">
<table width=100% class="table-bordered">
	<tr><td width=11%></td>
		<td width=10%></td>
		<td width=10%></td>
		<td width=7%></td>
		<td width=10%></td>
		<td width=13%></td>
		<td width=10%></td>
		<td width=10%></td>
		<td width=5%></td>
		<td width=14%></td>
	</tr>
	<tr><td colspan=3 align=left valign=top>
			<B>&nbsp;Situação : </B>&nbsp;
		<select name="s_descricao"  class="combo" onchange="mudamsg()">
		<option value="">--</option>
			<%call comboBD(Env.oConn,"Select distinct S_DESCRICAO as valor,S_DESCRICAO as descricao from situacoes WHERE S_OS = 0 order by S_DESCRICAO asc;")%>
		</select>
			</Font>
		</td>
		<td colspan=7 align=left valign=middle>
			<B>&nbsp;Tipo :</B>&nbsp;
			<select name="s_os"  class="combo" onchange="mudamsg()">
				<%call comboBD(Env.oConn,"Select '0' as valor,'           AS           ' as descricao union Select '1' as valor,'           OS           ' as descricao order by descricao;")%>
			</select>

		&nbsp;
		</td>
		<tr>
		<td colspan=10 align=left valign="top">
		<B>&nbsp;Mensagem : </B><br>
		&nbsp;<textarea class="texto1" cols="120" rows="17" name="mensagem"></textarea>
		</td>
		</tr>
		<tr>
		<td colspan=10>
			&nbsp;<input type="button" class="texto1" name="botao" value="    Ok    " onclick="envia();">
		</td>
	</tr>
</table>
<input type="hidden" name="hdnevento" value="3">
</form>
<iframe width="770" height="200" name="escondido" style="display: none;"></iframe>
<script language="javascript">
function mudamsg() {
	var frm = document.forms[0]
	frm.botao.disabled = true;
	frm.hdnevento.value = "3"
	frm.mensagem.value = "Pesquisando....";
	frm.action = "eventosInternos.asp"
	frm.method = "post";
	frm.target = "escondido";
	frm.submit();
}
function envia(){
	var frm = document.forms[0]
	frm.hdnevento.value = "4"
	frm.action = "eventosInternos.asp"
	frm.method = "post";
	frm.target = "escondido";
	frm.submit();
}
</SCRIPT>
<%
Call imprimeRodape(RODAPE_OFF)
%>
