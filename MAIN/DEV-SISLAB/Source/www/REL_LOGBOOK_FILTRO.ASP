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
<div class="margem-10">
    <form name="formteste" method="post" action="rel_logbook.asp">
        <input type="hidden" name="doformteste" value="1">

        <table class="" style="width: 100%;">
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
		            <span class="texto-vermelho-bold">&raquo;</span>&nbsp;Selecione uma das opções de filtro para consulta
	            </td>
            </tr>
            <tr><td colspan="10">&nbsp;</td></tr>
            <tr>
	            <td colspan=1  align=left valign=top>
		            <B>N&deg; OC</B><br>
		            <input type="text" class="texto1" name="ocorrencia" size="5">
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
            <tr><td colspan="10">&nbsp;</td></tr>
	        <tr>
		        <td colspan="3">
			        <B>RAT :</B><br>
			        <%call comboRatTodos("rat",Env.oconn,true)%>
			
		        </td>
		        <td colspan="7">
			        <B>Responsável :</B><br>
			        <%call comboUserCRTVivoEMortos("responsavel",Env.oConn,true)%>
			
		        </td>
	        </tr>
            <tr><td colspan="10">&nbsp;</td></tr>
            <tr>
		        <td colspan="4">
			        <B>Descrição :</B><br>
			        <input type="text" class="texto1" name="desc" size="60">
		        </td>
		        <td colspan="5">
			        <B>Cadastrado por :</B><br>
			        <%call comboUSERCRT("cadastrante",Env.oConn,true)%>
		        </td>
            </tr>
            <tr><td colspan="10">&nbsp;</td></tr>
            <tr>
	            <td colspan="2">
		            <B>Tipo da Ocorrência :</B><br>
		            <%call comboBDSQL( "tipoOcorrencia", Env.oConn,"select LBTO_ID AS VALOR,lBTO_DESCRICAO AS DESCRICAO from LB_TipoOcorrencia", null, true)%>
		
	            </td>
	            <td colspan="2">
		            <B>&nbsp;Somente Vencidas <br><input type="Checkbox" name="chkOcVencida"></B>
	            </td>
	            <td colspan="2">
		            <B>Criticidade :</B><br>
		            <%call comboCriticidade("criticidade")%>
		
	            </td>
	            <td colspan="4">
		            <B>Estado da Ocorrência :</B><br>
		            <%call comboEstadoOCorrencia("estado")%>
	            </td>
            </tr>
            <tr><td colspan="10">&nbsp;</td></tr>
            <tr>				
	            <td colspan="10">
		            <B>Ocorrido Entre :</B><br>
			        Data Inicial:&nbsp;<%call comboData("dataIniCad")%>
                    &nbsp;&nbsp;Data Final:&nbsp;<%call comboData("dataFimCad")%>
			    </td>
            </tr>
            <tr><td colspan="10">&nbsp;</td></tr>
            <tr>
	            <td colspan="10">
		            <input type="button" name="Filtro" Value="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Ok&nbsp;&nbsp;&nbsp;&nbsp;" onclick="envia();">
	            </td>
            </tr>
        </table>
    </form>
</div>

<script type="text/javascript">
    function envia() { document.forms[0].submit(); }
</script>
<%
Call Tela.MostraRodape()
%>
