<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/funcoes.asp" -->
<!--#include file="includes/controleshtml.asp" -->
<%
'On Error Resume Next

Tela.SetMostraMenu = MENU_ON
Tela.SetMostraImagem = True
Tela.SetNomeTela = "Consulta Pesquisa de Satisfação"
Call Tela.MostraCabecalho()
''''''Call Tela.ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Consulta Pesquisa de Satisfação", "", "")

Dim objSiteRS, objSiteMail, objArquivos, contte, contat, sSQL, tot,auxbarq, objsiteCRT
Dim auxtipoteste,auxsituacaoteste, auxdiasteste, auxdescricao, auxsolicitante
Dim auxRT, auxRAT, auxusername, EH_CRT, aux_Sigilo, auxorgao, auxtecnologia, auxorgaosel,auxAs

EH_CRT = Env.UsuarioCRT

contte=0
contat=0

if (request.QueryString("rat")<>"") then
	auxRAT=Ucase(request.QueryString("rat"))
end if

auxRT=request.form("rt")
auxRAT=request.form("rat")
auxtipoteste=request.form("tipoteste")
auxsituacaoteste=request.form("situacaoteste")
auxdiasteste=request.form("diasteste")
auxdescricao=request.form("descricao")
auxsolicitante=request.form("solicitante")
auxtecnologia=request.form("tecnologia")
auxorgaosel=request.form("orgao")
auxAs=request.form("auxAs")
auxClientes = (request.form("chkClientes")="on")
%>
<div class="margem-10">
    <form name="formteste" method="post" action="cons_ind_pesqsCR.asp">
    <input type="hidden" name="doformteste" value="1">
    <table border="0" width="100%" class="table-condensed" cellpadding="3" cellspacing="3">
    <tr>
	    <td>
		    &nbsp;<span class="texto-vermelho-bold" >&raquo;</span>&nbsp;<span class="texto1b" style="font-size: 12px; font-weight: bold;">
			    Selecione uma das opções de filtro para consulta
		    </span></b>
	    </td>
    </tr>
    <tr>
	    <td>
		    Nº AS:&nbsp;<input type="text" name="auxAS" size="3" >
	    </td>
    </tr>
    <tr>
	    <td>
		    Tipo de Teste:&nbsp;<%call comboBDSQL ("tipoteste", Env.oConn, "Select TA_ID as valor,TA_Descricao as descricao from Tipo_Atividade order by TA_ID asc", "", true)%>
	    </td>
    </tr>
    <tr>
	    <td>
		    Tecnologia:&nbsp;
		    <select name="tecnologia" >
			    <option value="">Todos as Tecnologias</option>
			    <%call comboBD(Env.oConn,"Select Tec_ID as valor,left(Tec_Nome,35) as descricao from Tecnologia order by Tec_nome asc")%>
		    </select>	
	    </td>
    </tr>
    <tr>
	    <td>
		    Agendado nos últimos <input  name="diasteste" value="<%=auxdiasteste%>" size="2" maxlength="3"> dias
	    </td>
    </tr>
    <tr>
	    <td>
		    Responsável Técnico:&nbsp;<%call comboBDSQL( "rt",Env.oConn, "Select Userid as valor,left(nome,35) as descricao from UserCRT where RT=1 order by nome asc", "", true)%>
	    </td>
    </tr>
    <tr>
	    <td>
		    RAT:&nbsp;<%call comboBDSQL( "rat",Env.oConn, "Select Upper(Userid) as valor,left(Nome,35) as descricao from UserCRT where RAT=1 order by nome asc", "", true)%>
	    </td>
    </tr>
    <tr>
	    <td>
		    Solicitante:&nbsp;<input type="text" size="9" name="solicitante" >
	    </td>
    </tr>
    <tr>
	    <td>
		    Cliente Embratel:&nbsp;<input type="Checkbox" name="chkClientes">
	    </td>
    </tr>
    <tr>
	    <td>
		    Órgão Solicitante:
		    &nbsp;
		    <select name="orgao" >
			    <option value="">Todos os Órgãos</option>
			    <%call comboBD(Env.oConn,"Select distinct AG_ORGAO, rtrim(ltrim(AG_ORGAO)) as valor,rtrim(ltrim(AG_ORGAO)) as descricao from agendamento where not(AG_ORGAO is null) and ag_orgao <> '' order by AG_ORGAO asc")%>
		    </select>
	    </td>
    </tr>
    <tr>
	    <td>
		    Cadastrada entre&nbsp;<%call comboData("Ini")%>&nbsp;e&nbsp;<%call comboData("Fim")%>
	    </td>
    </tr>
    <tr>
	    <td>
		    <input type="submit" Value="Aplicar filtro">
	    </td>
    </tr>
    </table>
    </form>
</div>

<script type="text/javascript">
formteste.rt.value='<%=request.form("rt")%>'
formteste.rat.value='<%=request.form("rat")%>'
formteste.tipoteste.value='<%=request.form("tipoteste")%>'
formteste.solicitante.value='<%=request.form("solicitante")%>'
formteste.orgao.value='<%=request.form("orgao")%>'
formteste.tecnologia.value='<%=request.form("tecnologia")%>'
formteste.auxAS.value='<%=request.form("auxAs")%>'
<%if auxClientes then%>
	formteste.chkClientes.checked = true;
<%else%>
	formteste.chkClientes.checked = false;
<%end if%>
</script>
<%
Call Tela.MostraRodape()
%>
