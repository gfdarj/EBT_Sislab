<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/controleshtml.asp" -->
<!--#include file="includes/funcoes.asp" -->

<!--#inc	lude file="includes/emailHTML.asp" -->
<%
Dim RS

If Not (Env.EhRat Or Env.EhRT) Then
	RR "index.asp"
End If

Tela.SetMostraMenu = MENU_ON
Tela.SetMostraImagem = True
Tela.SetNomeTela = "Mensagens de automáticas de email"
Tela.SetLinkVoltar = "location.href='sislab.asp'"
Call Tela.MostraCabecalho()
''''Call ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Mensagens de automáticas de email", "location.href='sislab.asp'", "")

'EH_CRT = Env.UsuarioCRT
%>
<form name="formteste" method="post" action="">

<script type="text/javascript" src="ajax/max_ajax_ref.js" ></script>

<script type="text/javascript">
    function TestarMensagem(idMensagem, email) {
        var url = "ajax/sislab_testaenvioemail.asp?id=" + idMensagem + "&email=" + email;

        var maxAjaxObj = new max.Ajax(url, { update: "", onComplete:
			function(texto, xml) {
			    if (texto == "OK")
			        alert("Email enviado com sucesso!");
			    else
			        alert("Ocorreu um erro ao enviar o email.");
			}
        });
        maxAjaxObj.get();
        return true;
    }
</script>

<table width=100% class="tabela1">
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
			<B>&nbsp;Email: </B>&nbsp;
		<select name="s_descricao"  class="combo" onchange="mudamsg()">
		<option value="">--</option>
<%			Set RS = Env.oConn.Execute("SELECT CodMensagem, DeMensagem FROM Mensagem ORDER BY DeMensagem;")
			While Not RS.Eof
				RW "<option value='" & RS(0) & "'>" & RS(1) & "</option>"
				RS.MoveNext
			WEnd
			Set RS = Nothing
%>
		</select>
			</Font>
		</td>
		<td colspan=7 align=left valign=middle>
		&nbsp;
		</td>
		<tr>
		<td colspan=10 align=left valign="top">
		<B>&nbsp;Texto da Mensagem: </B><br>
		&nbsp;<textarea class="texto1" cols="120" rows="17" name="mensagem"></textarea>
		</td>
		</tr>
		<tr>
		<td colspan=10>
			&nbsp;<input type="button" class="texto1" name="botao" value="    Ok    " onclick="envia();">
			&nbsp;<input type="button" class="texto1" name="botao" value="  Preview " onclick="preview(document.forms[0].s_descricao.value);">
		</td>
	</tr>
</table>

<p class="texto"><i><b>Legenda:</b></i></p>
<p class="texto"><i><u>%PARAMETRO_n%</u>: indica a sequencia dos parâmetros utilizados em um endereço da intranet/internet.</i></p>
<p class="texto"><i><u>n</u>: é o número do parâmetro.</i></p>

<input type="Hidden" name="hdnevento" value="3">

<br />

<!-- COMENTEI PORQUE NAO QUER FUNCIONAR !!!-->
<table class="texto1" border="0" align="left">
<tr>
	<td>Enviar um teste para o email:</td>
	<td>
	    <input type="text" class="texto1" name="txtEmail" size="40" maxlength="80" value="" />&nbsp;
	    <input type="button" class="texto1" name="btnTeste" value="Enviar" onclick="javascript:return TestarMensagem(document.forms[0].s_descricao.value, document.forms[0].txtEmail.value);" />
	</td>
</tr>
</table>

</form>
<iframe width="770" height="200" name="escondido" style="display: none;"></iframe>
<script language="javascript">
function mudamsg() {
	var frm = document.forms[0]
	frm.botao.disabled = true;
	frm.hdnevento.value = "15"
	frm.mensagem.value = "Pesquisando....";
	frm.action = "eventosInternos.asp"
	frm.method = "post";
	frm.target = "escondido";
	frm.submit();
}
function envia(){
	var frm = document.forms[0]
	frm.hdnevento.value = "16"
	frm.action = "eventosInternos.asp"
	frm.method = "post";
	frm.target = "escondido";
	frm.submit();
}
function preview(idMensagem, email) {
    window.open("CadMensagemPreview.asp?id=" + idMensagem, 'PreviewMensagem', 'toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,copyhistory=no');
}
</SCRIPT>
<%
'rw "TESTE OK ?!?!"
'call EnviaEmailRespondaPesquisa(Env.oConn, 3328)

Call Tela.MostraRodape()
%>
