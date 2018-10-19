<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/controlesHTML.asp" -->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/funcoes.asp" -->
<%
Tela.SetMostraMenu = MENU_ON
Tela.SetMostraImagem = True
Tela.SetNomeTela = "Manutenção de dados: De - Para"
Tela.SetLinkVoltar = "location.href='sislab.asp'"
Call Tela.MostraCabecalho()
'''''call imprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Manutenção de dados: De - Para", "location.href='sislab.asp'", "")

if not Env.ehRAT then RESPONSE.REDIRECT "INDEX.ASP"

TABELA = REQUEST("depara")
sSQLDEPARA1 = "SELECT '' AS valor,'' AS descricao"
sSQLDEPARA2 = sSQLDEPARA1
TIPOCAMPO = "COMBO"
SELECT CASE TABELA
	CASE "Testes"
		sSQLDEPARA1 = "select CONVERT(VARCHAR,T_ID) + ' | ' +  T_TITULO as valor,CONVERT(VARCHAR,T_ID) + ' | ' +  T_TITULO as descricao from TESTES"
		sSQLDEPARA2 = "select T_ID as valor,CONVERT(VARCHAR,T_ID) + ' | ' +  T_TITULO as descricao from TESTES"
	CASE "Tecnologia"
		sSQLDEPARA1 = "select CONVERT(VARCHAR,TEC_ID) + ' | ' + TEC_NOME as valor,CONVERT(VARCHAR,TEC_ID) + ' | ' + TEC_NOME as descricao from TECNOLOGIA"
		sSQLDEPARA2 = "select TEC_ID AS valor,CONVERT(VARCHAR,TEC_ID) + ' | ' + TEC_NOME as descricao from TECNOLOGIA"
	CASE "TipoAtividade"
		sSQLDEPARA1 = "select CONVERT(VARCHAR,ta_id) + ' | ' +  ta_descricao as valor,CONVERT(VARCHAR,ta_id) + ' | ' +  ta_descricao as descricao from tipo_atividade"
		sSQLDEPARA2 = "select ta_id as valor,CONVERT(VARCHAR,ta_id) + ' | ' +  ta_descricao as descricao from tipo_atividade"
	CASE "Orgao"
		sSQLDEPARA1 = "SELECT distinct ag_orgao + ' | ' + ag_orgao AS valor,ag_orgao AS descricao from agendamento where ag_orgao is not null and ag_orgao <> ''"
		TIPOCAMPO = "TEXTO"
	CASE "ClienteExterno"
		sSQLDEPARA1 = "SELECT distinct AG_CLIENTEEXTERNO + ' | ' +  AG_CLIENTEEXTERNO AS valor,AG_CLIENTEEXTERNO AS descricao from agendamento where AG_CLIENTEEXTERNO is not null and AG_CLIENTEEXTERNO <> ''"
		TIPOCAMPO = "TEXTO"
	CASE "LB_TipoOcorrencia"
		sSQLDEPARA1 = "select CONVERT(VARCHAR,LBTO_id) + ' | ' +  LBTO_descricao as valor,CONVERT(VARCHAR,LBTO_id) + ' | ' +  LBTO_descricao as descricao from LB_TipoOcorrencia"
		sSQLDEPARA2 = "select LBTO_id as valor,CONVERT(VARCHAR,LBTO_id) + ' | ' +  LBTO_descricao as descricao from LB_TipoOcorrencia"
	CASE "TipoArquivo"
		sSQLDEPARA1 = "select CONVERT(VARCHAR, TAR_CODTIPOARQUIVO) + ' | ' +  TAR_TIPOARQUIVO as valor, CONVERT(VARCHAR, TAR_CODTIPOARQUIVO) + ' | ' +  TAR_TIPOARQUIVO as descricao from TipoArquivo"
		sSQLDEPARA2 = "select TAR_CODTIPOARQUIVO as valor,CONVERT(VARCHAR, TAR_CODTIPOARQUIVO) + ' | ' +  TAR_TIPOARQUIVO as descricao from TipoArquivo"
	CASE "OrgaoInterno"
		sSQLDEPARA1 = "SELECT CONVERT(VARCHAR, orga_id) + ' | ' + orga_sigla + ' - ' + orga_descricao AS valor, CONVERT(VARCHAR, orga_id) + ' | ' + orga_sigla + ' - ' + orga_descricao AS descricao from Orgao order by orga_sigla, orga_descricao"
		sSQLDEPARA2 = "SELECT orga_id AS valor, orga_sigla + ' - ' + orga_descricao AS descricao from Orgao order by orga_sigla, orga_descricao"
	CASE "TipoTeste"
		sSQLDEPARA1 = "SELECT CONVERT(VARCHAR, tit_id) + ' | ' + tit_descricao AS valor, CONVERT(VARCHAR, tit_id) + ' | ' + tit_descricao AS descricao from Tipo_Teste order by tit_descricao;"
		sSQLDEPARA2 = "SELECT tit_id AS valor, tit_descricao AS descricao from Tipo_Teste order by tit_descricao;"
	CASE "Servicos"
		sSQLDEPARA1 = "SELECT CONVERT(VARCHAR, s_id) + ' | ' + s_descricao AS valor, CONVERT(VARCHAR, s_id) + ' | ' + s_descricao AS descricao from Servicos_Plataformas where s_servico = 1 order by s_descricao;"
		sSQLDEPARA2 = "SELECT s_id AS valor, s_descricao AS descricao from Servicos_Plataformas where s_servico = 1 order by s_descricao;"
	CASE "Plataformas"
		sSQLDEPARA1 = "SELECT CONVERT(VARCHAR, s_id) + ' | ' + s_descricao AS valor, CONVERT(VARCHAR, s_id) + ' | ' + s_descricao AS descricao from Servicos_Plataformas where s_servico = 0 order by s_descricao;"
		sSQLDEPARA2 = "SELECT s_id AS valor, s_descricao AS descricao from Servicos_Plataformas where s_servico = 0 order by s_descricao;"
END SELECT
%>
<body bgcolor="#FFFFFF" topmargin=0 leftmargin=0>
<script language="javascript" src="includes/anexo.js"></script>
<script>
function Buscar(){
	var frm = document.forms[0];
	frm.action = "CadDePara.asp";
	frm.method = "POST";
	frm.target = "_parent";
	frm.submit();

}
function Cancela(){
	var frm = document.forms[0];
	frm.action = "sislab.asp";
	frm.method = "POST";
	frm.target = "_parent";
	frm.submit();
}


function ValidaCampos(){
	var frm = document.forms[0];

	if (frm.strDE.value == ""){
		alert("Selecione pelo menos um valor no campo 'Valores a substituir'")
		return false;
	}

	if (frm.para.value == ""){
		alert("Selecione um valor no campo 'Para'")
		return false;
	}
	frm.action = "CadDeParaA.asp";
	frm.method = "POST";
	frm.target = "_parent";
	frm.submit();
}

</script>
<form method="post" action="CadDeParaA.asp" name="frm">

  <table border="0" width="100%">
  <tr> 
		<td bordercolor="#cccccc">
		  <font class="Fonttit3Cad"><b>&nbsp;<font color=#FF0000>*</font>&nbsp; Indica um Campo Obrigatório</td>
  </tr>
  </table>
	<table border="0" width="100%%" cellspacing="0">
	<tr>
		<td width="10%"></td>
		<td width="10%"></td>
		<td width="10%"></td>
		<td width="10%"></td>
		<td width="10%"></td>
		<td width="10%"></td>
		<td width="10%"></td>
		<td width="10%"></td>
		<td width="10%"></td>
		<td width="10%"></td>
	</tr>
	<TR>
		<td class="azul1Bg" colspan="10">
			<font face="tahoma" color="#222222" style="font-size: 10pt; font-weight: bold;">
			&nbsp;&nbsp;Ferramenta De - Para</font>
		</td>
	</tr>

	<tr height="34"> 
    	<td colspan="2"><font class="item"><b>&nbsp;&nbsp;</b>De - Para Disponíveis :
		</td>
		<td colspan="8">
		<%call comboDePara("depara", objConn,"N")%>&nbsp;&nbsp;
		<input  class="combo" type="Button" value="Buscar" onclick="Buscar();"></input>
		</td>
	</tr>
	<tr> 
		<%CALL ControleComboMultiplo2("DE","Valores a substituir","Disponíveis para substituição",sSQLDEPARA1,"2",TIPOCAMPO)%>
	</TR>
	<tr>
    	<td colspan="1"><font class="item"><b>&nbsp;&nbsp;</b>Para :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<%
		IF TIPOCAMPO = "COMBO" THEN
			call comboBDSQL( "para", objConn,sSQLDEPARA2, "", "N")%>&nbsp;&nbsp;<%
		ELSE%>
			<input type="text" class="texto1" name="para" SIZE=93"></input>
		<%END IF%>
		</td>
	</tr>

	<tr height="34">
		<td colspan="10" align="left">&nbsp;<input class="texto1" type="Button" onclick="ValidaCampos()" value=" &nbsp;&nbsp;Substituir&nbsp;&nbsp;" name="btnSalvar"/>
		</td>
	</tr>
	</tr>
</table>
</form>
<iframe width="770" height="200" name="escondido" style="display: none;"></iframe>
<script>
var frm = document.forms[0]
var frmAll = document.all
frm.depara.value = '<%=TABELA%>'
</script>
<%
Call Tela.MostraRodape()
%>
