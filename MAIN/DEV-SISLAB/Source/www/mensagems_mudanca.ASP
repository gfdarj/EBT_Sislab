<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/controleshtml.asp" -->
<!--#include file="includes/funcoes.asp" -->
<%
Call Tela.ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Alteração das mensagens de e-mails automáticas", "location.href='sislab.asp'", "")

Dim objSiteRS, objSiteMail, objArquivos, contte, contat, sSQL, tot,auxbarq, objsiteCRT
Dim auxareateste,auxtipoteste,auxsituacaoteste,auxdiasteste, auxdescricao, auxsolicitante
Dim auxRT, auxRAT, auxusername, EH_CRT, aux_Sigilo, auxorgao, auxtecnologia, auxorgaosel,auxAs

EH_CRT = Env.UsuarioCRT
%>
<div class="margem-10">
    <form name="formteste" method="post" action="">
        <table style="width: 100%;">
	        <tr>
                <td>
			        Situação: &nbsp;
		            <select name="s_descricao"  onchange="mudamsg()">
		            <option value="">--</option>
			            <%call comboBD(Env.oConn,"Select distinct S_DESCRICAO as valor,S_DESCRICAO as descricao from situacoes WHERE S_OS = 0 order by S_DESCRICAO asc;")%>
		            </select>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			        Tipo:&nbsp;
			        <select name="s_os" onchange="mudamsg()">
				        <%call comboBD(Env.oConn,"Select '0' as valor,'           AS           ' as descricao union Select '1' as valor,'           OS           ' as descricao order by descricao;")%>
			        </select>
		            &nbsp;
		        </td>
            </tr>
            <tr><td>&nbsp;</td></tr>
		    <tr>
		        <td>
		            Mensagem:<br>
		            <textarea cols="120" rows="17" name="mensagem"></textarea>
		        </td>
		    </tr>
            <tr><td>&nbsp;</td></tr>
		    <tr>
		        <td>
			        <input type="button" name="botao" value="    Ok    " onclick="envia();">
		        </td>
	        </tr>
        </table>
        <input type="hidden" name="hdnevento" value="3">
    </form>
    <br />
    <iframe width="770" height="200" name="escondido" style="display: none;"></iframe>
</div>

<script type="text/javascript">
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
</script>
<%
Call Tela.MostraRodape()
%>
