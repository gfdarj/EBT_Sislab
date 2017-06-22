<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/funcoes.asp" -->
<!--#include file="includes/controleshtml.asp" -->
<%
call ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Acompanhamento e Resultado de Agendamento", "", "")

Dim objSiteRS, objSiteMail, objArquivos, contte, contat, sSQL, tot,auxbarq, objsiteCRT
Dim auxtipoteste,auxsituacaoteste,auxdiasteste, auxdescricao, auxsolicitante
Dim auxRT, auxRAT, auxusername, EH_CRT, aux_Sigilo, auxorgao, auxtecnologia, auxorgaosel,auxAs
Dim chr_EstiloTD
Dim msgData
Dim chr_BgColor

msgData = "AJUDA !\n\nSelecione uma data para pesquisa. Caso uma das datas estejam em branco é considerado apenas a data selecionada como limite inferior ou superior, conforme o preenchimento."

EH_CRT = Env.UsuarioCRT()

contte=0
contat=0

if (request("rat")<>"") then
	auxRAT=Ucase(request("rat"))
	auxdiasteste=90
end if

auxRT=request("rt")
auxRAT=request("rat")
auxtipoteste=request("tipoteste")
auxsituacaoteste=request("situacaoteste")
auxdiasteste=request("diasteste")
auxdescricao=request("descricao")
auxsolicitante=request("solicitante")
auxtecnologia=request("tecnologia")
auxorgaosel=request("orgao")
auxAs=request("auxAs")
auxClientes = (request("chkClientes")="on")
auxPadronizado = (request("chkPadronizado")="on")

chr_BgColor = "#E8E8E8"
chr_EstiloTD = "style='border-bottom: solid " & chr_BgColor & " thin;'"
%>
<script language="JavaScript" src="includes/anexo.js"></script>
<script language="javascript">
function chama_as(cod_as)
{
    sel.selecao.value=cod_as;
	sel.submit();
}
function proximaPagina()
{
	var frm = document.forms[0]
	frm.submit();
}
function chama_es(cod_es)
{
    sel2.selecao.value=cod_es;
	sel2.submit();
}
function validaCampos(f)
{
	if( //obriga o preenchimento de pelo menos 1 campo
		(trimJs(f.auxAS.value) == '') && (trimJs(f.situacaoteste.value) == '') && 
		(trimJs(f.diasteste.value) == '') && (f.chkClientes.checked == false) &&
		(f.chkRepeticao.checked == false) && (f.chkExecutanteCRT.checked == false) &&
		(f.chkTemOS.checked == false) && (f.chkTemComentario.checked == false) &&
		(trimJs(f.tipoteste.value) == '') && (trimJs(f.cmbTipoTeste.value) == '') &&
		(trimJs(f.orgao.value) == '') && (trimJs(f.sigilo.value) == '') &&
		(trimJs(f.tecnologia.value) == '') && (trimJs(f.rt.value) == '') &&
		(trimJs(f.rat.value) == '') && (trimJs(f.participante.value) == '') &&
		(trimJs(f.solicitante.value) == '') && (trimJs(f.teste.value) == '') &&
		(trimJs(f.servico.value) == '') && (trimJs(f.plataforma.value) == '') &&
		(trimJs(f.descricao.value) == '') && (trimJs(f.codigobarras.value) == '') &&
		(trimJs(f.ambiente.value) == '') &&
		((f.diadataIniCad.value == '') || (f.mesdataIniCad.value == '') || (f.anodataIniCad.value == '')) &&
		((f.diadataFimCad.value == '') || (f.mesdataFimCad.value == '') || (f.anodataFimCad.value == '')) &&
		((f.diadataIniCadSol.value == '') || (f.mesdataIniCadSol.value == '') || (f.anodataIniCadSol.value == '')) &&
		((f.diadataFimCadSol.value == '') || (f.mesdataFimCadSol.value == '') || (f.anodataFimCadSol.value == ''))
	)
	{
		alert('Preencha pelo menos um dos campos da consulta');
		return false;
	}
	else
		return true;
}
function controleClientes(eu)
{
	if(eu.checked == true)
		document.forms[0].clientes.disabled = false;
	else
	{
		document.forms[0].clientes.value = '';
		document.forms[0].clientes.disabled = true;
	}
}
</script>
<form name="formteste" method="post" action="rel_ativ_A.asp" onsubmit="javascript: if(validaCampos(this)) { showAguarde(); return true; } else return false;">
<input type=hidden name="doformteste" value="1">
<table border="0" width="100%" class="tabela1" cellpadding="3" cellspacing="3">
<tr>
	<td>
		&nbsp;<span class="texto1b" style="font-size: 12px;">Selecione uma das opções de filtro para consulta</span>
	</td>
</tr>
<tr>
	<td>
		<table border="0" width="100%" class="tabela1" cellpadding="3" cellspacing="0" style="background: <%=chr_BgColor%>;">
		<tr>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
		<tr>
			<td colspan="1" <%=chr_EstiloTD%>>
				Nº AS&nbsp;
				<input type="Text" name="auxAS" class="texto1" size="5" maxlength="10">
			</td>
			<td colspan="9" <%=chr_EstiloTD%>>
				Palavra-chave (Descrição./Objetivo/Título):&nbsp;
				<input type="text" size="60" maxlength="60" name="descricao" class="texto1">
			</td>
		</tr>
		<tr>
			<td colspan="1" <%=chr_EstiloTD%>>
				Cliente Embratel:&nbsp;<input class="texto1" type="Checkbox" name="chkClientes" onclick="javascript:controleClientes(this);">
			</td>
			<td colspan="4" <%=chr_EstiloTD%>>
				<select name="clientes" class="combo" disabled>
					<option value="">Todo os Clientes</option>
					<%call comboBD(Env.oConn, "Select DISTINCT AG_CLIENTEEXTERNO as valor, CASE WHEN LEN(AG_CLIENTEEXTERNO) > 40 THEN LEFT(AG_CLIENTEEXTERNO, 40) + '...' ELSE AG_CLIENTEEXTERNO END as descricao from Agendamento WHERE AG_CLIENTEEXTERNO IS NOT NULL order by AG_CLIENTEEXTERNO asc")%>
				</select>
			</td>
			<td colspan="6" <%=chr_EstiloTD%>>
				Tecnologia:&nbsp;
				<select name="tecnologia" class="combo">
					<option value="">Todas as Tecnologias</option>
					<%call comboBD(Env.oConn,"Select Tec_Nome as valor,left(Tec_Nome,35) as descricao from Tecnologia order by Tec_nome asc")%>
				</select>
			</td>
		</tr>
		<tr>
			<td colspan="10" <%=chr_EstiloTD%>>
				Solicitado pelo cliente entre&nbsp;
				<%call comboData("dataIniCad")%>&nbsp;e&nbsp;<%call comboData("dataFimCad")%>
				&nbsp;
				<a href="#" title="<%=msgData%>" onclick="javascript: alert('<%=msgData%>');"><img src="img/ajuda.gif" border="0"></a>
			</td>
		</tr>
		<tr>
			<td colspan="7" <%=chr_EstiloTD%>>
				Período agendado&nbsp;
				<%call comboData("dataIniCadSol")%>&nbsp;até&nbsp;<%call comboData("dataFimCadSol")%>
				&nbsp;
				<a href="#" title="<%=msgData%>" onclick="javascript: alert('<%=msgData%>');"><img src="img/ajuda.gif" border="0"></a>
			</td>
			<td colspan="3" <%=chr_EstiloTD%>>
				Agendado nos últimos <input class="texto1" name="diasteste" size="5" maxlength="10"> dias
			</td>
		</tr>
		<tr>
			<td colspan="3" <%=chr_EstiloTD%>>
				Username do Solicitante:&nbsp;
				<input type="text" size="9" name="solicitante" class="texto1">
			</td>
			<td colspan="7" <%=chr_EstiloTD%>>
				Situação do Agendamento:&nbsp;
				<select name="situacaoteste"  class="combo">
					<option value="">Todos as Situações</option>
					<option value="NC">Todas Não Concluídas</option>
					<%call comboBD(Env.oConn,"Select ID_Situacao as valor,left(S_DESCRICAO,35) as descricao from Situacoes where S_OS = 0 order by ID_Situacao asc;")%>
				</select>
			</td>
		</tr>
		</table>
<%
	If Env.UsuarioCRT Then
%>
		<BR><BR>
		<table border="0" width="100%" class="tabela1" cellpadding="3" cellspacing="0" style="background: <%=chr_BgColor%>;">
<%
	else
%>
		<table border="0" width="100%" class="tabela1" cellpadding="3" cellspacing="0" style="display: none;">
<%
	End If
%>
		<tr>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
		<tr>
			<td colspan="10"><b><span class="vermelho2">&raquo;</span>&nbsp;Filtros da Equipe CRT</b></td>
		</tr>
		<tr>
			<td colspan="6" <%=chr_EstiloTD%>>
				Username ou nome do participante:&nbsp;
				<input type="text" size="50" maxlength="60" name="participante" class="texto1">
			</td>
			<td colspan="4" <%=chr_EstiloTD%>>
				Sigilo:&nbsp;
				<%call comboBDSQL ("sigilo", Env.oConn, "Select TS_ID as valor, TS_DESCRICAO as descricao from TIPO_SIGILO order by TS_DESCRICAO asc", "", true)%>
			</td>
		</tr>
		<tr>
			<td colspan="5" <%=chr_EstiloTD%>>
				RT:&nbsp;
				<%
				Call comboRtTodos("rt", Env.oConn, True)
				'call comboBDSQL( "rt",Env.oConn, "Select Userid as valor,left(nome,35) as descricao from UserCRT where RT=1 order by nome asc", "", true)
				%>
			</td>
			<td colspan="5" <%=chr_EstiloTD%>>
				RAT:&nbsp;
				<%
				Call comboRatTodos("rat", Env.oConn, True)
				'call comboBDSQL( "rat",Env.oConn, "Select Upper(Userid) as valor,left(Nome,35) as descricao from UserCRT where RAT=1 order by nome asc", "", true)
				%>
			</td>
		</tr>
		<tr>
			<td colspan="3" <%=chr_EstiloTD%>>
				Tipo de Atividade:&nbsp;
				<%call comboBDSQL ("tipoteste", Env.oConn, "Select TA_ID as valor,TA_Descricao as descricao from Tipo_Atividade order by TA_ID asc", "", true)%>
			</td>
			<td colspan="3" <%=chr_EstiloTD%>>
				Tipo de Teste:&nbsp;<%call comboTipoTeste("cmbTipoTeste", Env.oConn, "", "N")%>
			</td>
			<td colspan="4" <%=chr_EstiloTD%>>
				Órgão Solicitante:&nbsp;
				<select name="orgao" class="combo">
					<option value="">Todos os Órgãos</option>
					<%call comboBD(Env.oConn,"Select distinct AG_ORGAO, rtrim(ltrim(AG_ORGAO)) as valor,rtrim(ltrim(AG_ORGAO)) as descricao from agendamento where not(AG_ORGAO is null) and ag_orgao <> '' order by AG_ORGAO asc")%>
				</select>
			</td>
		</tr>
		<tr>
			<td colspan="10" <%=chr_EstiloTD%>>
				Teste:&nbsp;
				<%call comboBDSQL ("teste", Env.oConn, "Select T_ID as valor, CASE WHEN LEN(T_TITULO) > 100 THEN LEFT(T_TITULO, 100) + '...' ELSE T_TITULO END as descricao from Testes order by T_TITULO asc", "", true)%>
			</td>
		</tr>
		<tr>
			<td colspan="4" <%=chr_EstiloTD%>>
				Serviço:&nbsp;
				<%call comboBDSQL ("servico", Env.oConn, "Select S_ID as valor, S_DESCRICAO as descricao from Servicos_Plataformas WHERE S_SERVICO = 1 order by S_DESCRICAO asc", "", true)%>
			</td>
			<td colspan="6" <%=chr_EstiloTD%>>
				Plataforma:&nbsp;
				<%call comboBDSQL ("plataforma", Env.oConn, "Select S_ID as valor, S_DESCRICAO as descricao from Servicos_Plataformas WHERE S_SERVICO = 0 order by S_DESCRICAO asc", "", true)%>
			</td>
		</tr>
		<tr>
			<td colspan="2" <%=chr_EstiloTD%>>
				Teste com Repetição:&nbsp;<input class="texto1" type="Checkbox" name="chkRepeticao">
			</td>
			<td colspan="3" <%=chr_EstiloTD%>>
				Executante do CRT:&nbsp;<input class="texto1" type="Checkbox" name="chkExecutanteCRT">
			</td>
			<td colspan="2" <%=chr_EstiloTD%>>
				Tem OS:&nbsp;<input class="texto1" type="Checkbox" name="chkTemOS">
			</td>
			<td colspan="3" <%=chr_EstiloTD%>>
				Tem Comentário:&nbsp;<input class="texto1" type="Checkbox" name="chkTemComentario">
			</td>
		</tr>
		<tr>
			<td colspan="3" <%=chr_EstiloTD%>>
				SGP do Equipamento:&nbsp;
				<input type="text" size="23" maxlength="16" name="codigobarras" class="texto1">
			</td>
			<td colspan="7" <%=chr_EstiloTD%>>
				Ambiente utilizado no teste:&nbsp;
				<%call comboBDSQL ("ambiente", Env.oConn, "Select AMB_ID as valor, AMB_NOME as descricao from Ambientes order by AMB_NOME asc", "", true)%>
			</td>
		</tr>
		</table>
	</td>
</tr>
<tr><td></td></tr>
<tr>
	<td align="right">
		<input type="submit" name="Filtro" Value="Consultar" class="texto1">
	</td>
</tr>
</table>
</form>
<%
Call imprimeRodape(RODAPE_OFF)
%>
