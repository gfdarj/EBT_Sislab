<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/controleshtml.asp" -->
<!--#include file="includes/funcoes.asp" -->
<!--#include file="includes/bib_str.asp" -->
<%
Dim objSiteRS, objRES, cont, sSQL, tot, auxtipoteste, auxtitulo
Dim AuxRamal,AuxUsername,AuxOrgao,AuxDataInicio,AuxDataTermino
Dim AuxMatricula, AUxResponsavel
Dim AuxobjTeste, AuxTec, Auxsigilo, AuxDataSolicita, AuxAGRAT
Dim Auxselecao
Dim Auxdadosteste,AuxtipoTesteint,auxAGRT, AuxRetificacao, AuxAmostra
Dim Auxambiente, AuxObs, AuxRecursos
Dim AuxRetornoCliente, AuxMetas
Dim Ebt

Set Ebt = New TEbt

tot = 0
Auxselecao = Request("selecao")

If Request("emjanela") = "1" Then
	Call Tela.ImprimeCabecalho2("SISLAB - Ficha do agendamento", MENU_OFF, false, "", "Acompanhamento de Agendamento - N<sup>o</sup> AS: " & auxselecao, "SO_IMPRESSORA", "")
Else
	Call Tela.ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Acompanhamento de Agendamento - N<sup>o</sup> AS: " & auxselecao, "", "")
End if

'Crio um RecordSet para Montar Consulta
'Consulta agenda segundo filtros

sSQL = _
	"SELECT a.* " & _
	"FROM vw_Agendamento a " & _
	"WHERE a.AG_NUMERO = " & AuxSelecao

call Env.RecordSet( true, objSiteRS, sSQL)
objSiteRS.MoveFirst

auxtitulo = objSiteRS("AG_TITULO")

AuxTipoTeste = objSiteRS("TA_DESCRICAO")
AuxUsername = objSiteRS("AG_USERNAME")

'Response.Write "AQUI"
'response.End

'Call Ebt.BuscaDadosEmbratel("wsaddi@alerj.gov.br")
Call Ebt.BuscaDadosEmbratel(objSiteRS("AG_USERNAME"))

'response.Write Now & "<BR>"
'response.Write ebt.EhFuncionario & "<BR>"
'response.Write ebt.NomeReduzido  & "<BR>"
'response.Write ebt.Usuario & "<BR>"
'response.end 


If Ebt.EhFuncionario Then
	AuxResponsavel = Ebt.NomeReduzido
	AuxMatricula = Ebt.MATRICULA
	AuxRamal = Ebt.Ramal
Else
	AuxResponsavel = "xxxx"
	AuxMatricula = "xxxx"
	AuxRamal = "xxxx"
End If

Set Ebt = nothing


AuxOrgao = objSiteRS("AG_ORGAO")
AuxDataInicio = objSiteRS("AG_DATAINICIO")
AuxDataTermino = objSiteRS("AG_DATATERMINO")
AuxobjTeste = replace(ucase(objSiteRS("AG_OBJETIVO"))&"&nbsp;", vbCrLf, "<br>&nbsp;&nbsp;")
AuxDataSolicita = objSiteRS("AG_DATASOLICITACAO")
AuxTec = objSiteRS("TEC_NOME")
AuxAGRT = objSiteRS("AG_RESPONSAVEL")
AuxAGRAT = objSiteRS("AG_RAT")
AuxRetificacao = objSiteRS("AG_RETIFICACAO")
AuxAmostra = ucase(objSiteRS("AG_CLIENTEEXTERNO"))
Auxambiente = replace(ucase(objSiteRS("AG_AMBIENTE"))&"&nbsp;", vbCrLf, "<br>&nbsp;&nbsp;")
AuxObs = replace(ucase(objSiteRS("AG_OBSERVACAO"))&"&nbsp;", vbCrLf, "<br>&nbsp;&nbsp;")
AuxRecursos = replace(ucase(objSiteRS("AG_RECURSOS"))&"&nbsp;", vbCrLf, "<br>&nbsp;&nbsp;")
AuxRetornoCliente = objSiteRS("AG_RETORNOCLIENTE")
if IsNull(AuxRetornoCliente) then AuxRetornoCliente = "0"
AuxMetas = objSiteRS("AG_PLANODEMETAS")

AuxIdSigilo = objSiteRS("AG_SIGILO")
AuxSigilo = ucase(objSiteRS("TS_DESCRICAO"))

AuxTipoTesteint=objSiteRS("TA_ID")
%>

<br>

<table class="table-bordered" border="0" width="100%" cellpadding="3" cellspacing="0">
<tr>
	<th align="left">Histórico de Eventos</th>
</tr>
</table>

<table border="1" width="100%" cellpadding="2" cellspacing="1">
<tr>
	<td width="16%"></td>
	<td width="23%"></td>
	<td width="23%"></td>
	<td width="38%"></td>
</tr>
<tr class="realce1">
	<td align="center">SITUAÇÃO</td>
	<td align="center">DATA DE INÍCIO</td>
	<td align="center">DATA DE TÉRNINO</td>
	<td align="center">OBSERVAÇÂO</td>
</tr>
<%
sSQL = _
	"SELECT he.AG_NUMERO, s.ID_SITUACAO, s.S_DESCRICAO, he.HE_DATAINICIO, " & _
    	"he.HE_DATATERMINO, he.HE_MOTIVO " & _
	"FROM Situacoes s INNER JOIN Historico_Eventos he ON s.ID_SITUACAO = he.ID_SITUACAO " & _
	"WHERE AG_NUMERO = " & AuxSelecao & " order by HE_DataInicio asc, HE_DataTermino desc;"
call Env.RecordSet( true, objSiteRS, sSQL)
objSiteRS.MoveFirst
Do while Not objSiteRS.eof%>
<tr >
	<td>&nbsp;&nbsp;<b><%=objSiteRS("S_Descricao")%></b>&nbsp;</td>
	<td align="center"><%=(objSiteRS("HE_DataInicio"))%>&nbsp;</td>
	<td align="center"><%=(objSiteRS("HE_DataTermino"))%>&nbsp;</td>
	<td><%=objSiteRS("HE_MOTIVO")%>&nbsp;</td>
</tr>
<%	objSiteRS.MoveNext
Loop
%>
</table>

<%
sSQL = _
	"SELECT heos.AG_NUMERO, t.T_Titulo, heos.OS_ID, sit.ID_SITUACAO, sit.S_DESCRICAO, " & _
		"heos.HEOS_DATAINICIO, heos.HEOS_DATATERMINO, heos.HEOS_MOTIVO, TIT_DESCRICAO " & _
	"FROM Situacoes sit " & _
		"INNER JOIN Historico_EventosOS heos ON sit.ID_SITUACAO = heos.ID_SITUACAO " & _
		"INNER JOIN Ordem_de_Servico os ON heos.OS_ID = os.OS_ID AND heos.AG_Numero = os.AG_Numero " & _
		"INNER JOIN Testes t ON t.T_ID = os.T_ID " & _
		"INNER JOIN Tipo_Teste tt ON t.TIT_ID = tt.TIT_ID " & _
		"INNER JOIN Agendamento a ON a.AG_NUMERO = heos.AG_Numero " & _
	"WHERE a.AG_NUMERO = " & AuxSelecao & " " & _
	"order by heos.OS_ID, heos.HEOS_DataInicio asc /*, heos.HEOS_DataTermino desc*/;"
call Env.RecordSet( true, objSiteRS, sSQL)
if Not objSiteRS.eof then 
	objSiteRS.MoveFirst%>
<br>

<table class="table-bordered" border="0" width="100%" cellpadding="3" cellspacing="0">
<tr>
	<th align="left">Histórico de Eventos - Ordem de Serviço</th>
</tr>
</table>

<table border="1" width="100%" cellpadding="2" cellspacing="1">
<tr>
	<td width="30%"></td>
	<td width="14%"></td>
	<td width="15%"></td>
	<td width="15%"></td>
	<td width="26%"></td>
</tr>
<tr class="realce1">
	<td align="center">Nº OS</td>
	<td align="center">SITUAÇÃO</td>
	<td align="center">DATA DE INÍCIO</td>
	<td align="center">DATA DE TÉRMINO</td>
	<td align="center"><b>OBSERVAÇÃO</td>
</tr>
<%	Dim auxOS
	Do while Not objSiteRS.eof
		auxOS = objSiteRS("OS_ID")

		Do while len(auxOS) < 3
			auxOS="0"&auxOS
		loop%>
<tr >
	<td>&nbsp;&nbsp;<b><%=auxselecao%>/<%=auxOS%>&nbsp;-&nbsp;<%=objSiteRS("T_Titulo")%></b></td>
	<td align="center"><b><%=objSiteRS("S_Descricao")%>&nbsp;</b></td>
	<td align="center"><%=(objSiteRS("HEOS_DataInicio"))%>&nbsp;</td>
	<td align="center"><%=(objSiteRS("HEOS_DataTermino"))%>&nbsp;</td>
	<td><%=objSiteRS("HEOS_MOTIVO")%>&nbsp;</td>
</tr>
<%		objSiteRS.MoveNext
	Loop%>
</table><%
end if%>


<%
sSQL = "SELECT CONVERT(VARCHAR, HD_DataInicio, 103) + ' ' + LEFT(CONVERT(VARCHAR, HD_DataInicio, 114), 5) AS HD_DataInicio, " & _
	"CONVERT(VARCHAR, HD_DataTermino, 103) + ' ' + LEFT(CONVERT(VARCHAR, HD_DataTermino, 114), 5) AS HD_DataTermino, HD_MOTIVO " & _
	"FROM Historico_Datas WHERE AG_NUMERO = " & AuxSelecao & " order by AG_NUMERO, HD_MARCACAO"
call Env.RecordSet( true, objSiteRS, sSQL)
if not (objSiteRS.Eof and objSiteRS.Bof) then
%>
<br>
<table class="table-bordered" border="0" width="100%" cellpadding="3" cellspacing="0">
<tr>
	<th align="left">Histórico de Alterações de Datas</th>
</tr>
</table>
<table border="1" width="100%" cellpadding="2" cellspacing="1">
<tr>
	<td width="23%"></td>
	<td width="23%"></td>
	<td width="*"></td>
</tr>
<tr class="realce1">
	<td align="center">DATA DE INÍCIO</td>
	<td align="center">DATA DE TÉRNINO</td>
	<td align="center">OBSERVAÇÂO</td>
</tr>
<%
objSiteRS.MoveFirst
Do while Not objSiteRS.eof%>
<tr >
	<td align="center"><%=(objSiteRS("HD_DataInicio"))%>&nbsp;</td>
	<td align="center"><%=(objSiteRS("HD_DataTermino"))%>&nbsp;</td>
	<td><%=objSiteRS("HD_MOTIVO")%>&nbsp;</td>
</tr>
<%	objSiteRS.MoveNext
Loop
%>
</table>
<%
end if
%>

<%
sSQL = "Select VW.* From vw_ArquivosTeste VW  "
sSQL = sSQL & " WHERE VW.AG_NUMERO="&AuxSelecao&"; "
call Env.RecordSet( true, objSiteRS, sSQL)
if Not objSiteRS.eof then%>
<br>
<table class="table-bordered" border="0" width="100%" cellpadding="3" cellspacing="0">
<tr>
	<th align="left">Arquivos Associados</th>
</tr>
</table>
<%
	If MostraDadoSigiloso(AuxIdSigilo, AuxUsername) Then
%>
<table border="1" width="100%" cellpadding="2" cellspacing="1">
<tr>
	<td width="30%"></td>
	<td width="70%"></td>
</tr>
<tr class="realce1">
	<td align="center">TIPO DE ARQUIVO</td>
	<td align="center">ARQUIVO</td>
</tr>
<%		objSiteRS.MoveFirst
		Do while Not objSiteRS.eof%>
<tr >
	<td>&nbsp;&nbsp;<b><%=objSiteRS("TAR_TipoArquivo")%>&nbsp;</b></td>
	<td>&nbsp;&nbsp;
		<a href="#" title="Clique aqui para visualizar o arquivo" onclick="abreArquivo('arquivos/<%=Replace(objSiteRS("Arq_nomeArq"), "\", "/")%>');"><%=objSiteRS("Arq_Link")%></a>
		&nbsp;
	</td>
</tr>
<%		objSiteRS.MoveNext
		Loop%>
</table><%
	Else
		Response.Write ExibeMensagemSigiloAS(1)
	End If
End If%>

<br>

<table class="table-bordered" border="0" width="100%" cellpadding="3" cellspacing="0">
<tr>
	<th align="left">Dados do Agendamento</th>
</tr>
</table>

<table width="100%" border="1" cellpadding="2" cellspacing="1">
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
<tr class="realce1">
	<td colspan="10">
	&nbsp;&nbsp;TÍTULO DO AGENDAMENTO
	</td>
</tr>
<tr >
	<td colspan="10">
	&nbsp;<%=auxtitulo%>
	</td>
</tr>
<tr class="realce1">
	<td colspan="6">
	&nbsp;&nbsp;TIPO DE TESTE
	</td>
	<td align="center" colspan="2">
	<B>DATA DE INÍCIO</B>
	</td>
	<td align="center" colspan="2">
	<B>DATA DE TÉRMINO</B>
	</td>
</tr>
<tr >
	<td colspan="6">
	&nbsp;<%=auxtipoteste%>&nbsp;&nbsp;<%=auxdadosteste%>
	</td>
	<td align="center" colspan="2">
	&nbsp;<%=AuxDataInicio%>
	</td>
	<td align="center" colspan="2">
	&nbsp;<%=AuxDataTermino%>
	</td>
</tr>
<tr class="realce1">
	<td colspan="6">
	&nbsp;&nbsp;TECNOLOGIA UTILIZADA (PRINCIPAL)
	</td>
	<td colspan="2" align="center">
	DATA DA SOLICITAÇÃO
	</td>
	<td align="center" colspan="2">
	CONFIDENCIALIDADE
	</td>
</tr>
<tr >
	<td colspan="6">
	&nbsp;&nbsp;<%=auxTec%>
	</td>
	<td align="center" colspan="2">
	&nbsp;<%=AuxDataSolicita%>
	</td>
	<td align="center" colspan="2">
	&nbsp;<%=AuxSigilo%>
	</td>
</tr>

<tr class="realce1">
	<td colspan="10">
	&nbsp;&nbsp;OBJETIVO DO TESTE
	</td>
</tr>
<tr >
	<td colspan="10">
	&nbsp;&nbsp;<%=auxobjteste%>
	</td>
</tr>

<tr class="realce1">
	<td colspan="10">
	&nbsp;&nbsp;AMBIENTE NECESSÁRIO
	</td>
</tr>
<tr >
	<td colspan="10">
	&nbsp;&nbsp;<%=auxambiente%>
	</td>
</tr>

<tr class="realce1">
	<td colspan="10">
	&nbsp;&nbsp;RECURSOS NECESSÁRIOS
	</td>
</tr>
<tr >
	<td colspan="10">
	&nbsp;&nbsp;<%=auxrecursos%>
	</td>
</tr>

<tr class="realce1">
	<td colspan="10">
	&nbsp;&nbsp;OBSERVAÇÕES
	</td>
</tr>
<tr >
	<td colspan="10">
	&nbsp;&nbsp;<%=auxObs%>
	</td>
</tr>

<tr class="realce1">
	<td colspan="6">
	&nbsp;&nbsp;SOLICITANTE (USERNAME - MATRÍCULA)
	</td>
	<td align="center" colspan="2">
	RAMAL
	</td>
	<td align="center" colspan="2">
	ÓRGÃO
	</td>
</tr>
<tr >
	<td colspan="6">
	&nbsp;&nbsp;<%=AuxResponsavel%>&nbsp;(<%=AuxUsername%>&nbsp;-&nbsp;<%=AuxMatricula%>)
	</td>
	<td align="center" colspan="2">
	&nbsp;<%=AUXRAMAL%>
	</td>
	<td align="center" colspan="2">
	&nbsp;<%=AUXORGAO%>
	</td>
</tr>

<tr class="realce1">
	<td colspan="3">
	&nbsp;&nbsp;CLIENTES EXTERNOS
	</td>
	<td colspan="4">
	&nbsp;&nbsp;RETIFICAÇÃO
	</td>
	<td colspan="3">
	&nbsp;&nbsp;RETORNO DO CLIENTE (R$)
	</td>
</tr>
<tr >
	<td colspan="3">
	&nbsp;&nbsp;<%=auxamostra%>
	</td>
	<td colspan="4">
	&nbsp;&nbsp;<%=auxretificacao%>
	</td>
	<td colspan="3" align="right">
	<%=FormatCurrency(AuxRetornoCliente)%>&nbsp;&nbsp;
	</td>
</tr>

<%
if not IsNull(AuxMetas) then%>
<tr class="realce1">
	<td colspan="10" align="center">
	&nbsp;&nbsp;PLANO DE METAS DA EMBRATEL
	</td>
</tr>
<tr >
	<td colspan="4">
	&nbsp;&nbsp;<%=AuxMetas%>
	</td>
</tr>
<%
end if
%>

<%'=============================================================================
Dim Matricula, ebt1, vIndicEmpregado
Dim vNome, vSiglaOrgao
Dim vRIT

vIndicEmpregado = "N" ' nao exite funcionario com esta matricula
vNome = ""
vSiglaOrgao = ""
vRIT =  ""

if AuxAGRT <> "" then
	AuxUsername = AuxAGRT
else
	AuxUsername = ""
end if

Set ebt1 = New TEbt

Call ebt1.LoginUsuario(AuxUsername)

Matricula = Ebt1.Matricula()
vNome = Ebt1.NomeReduzido")
vSiglaOrgao = Ebt1.SiglaOrgao
vRIT =  ebt1.Ramal

Set ebt1  = nothing

'=============================================================================%>

<tr class="realce1">
	<td colspan="6">
	&nbsp;&nbsp;RESPONSÁVEL TÉCNICO (USERNAME - MATRÍCULA)
	</td>	
	<td align="center" colspan="2">
	RAMAL
	</td>		
	<td align="center" colspan="2">
	ÓRGÃO
	</td>
</tr>
<tr >
	<td colspan="6">
	&nbsp;&nbsp;<%=vNome%>&nbsp;(<%=AuxUsername%>&nbsp;-&nbsp;<%=Matricula%>)
	</td>
	<td align="center" colspan="2">
	&nbsp;<%=vRIT%>
	</td>
	<td align="center" colspan="2">
	&nbsp;<%=vSiglaORGAO%>
	</td>
</tr>

<%'=============================================================================
if AuxAGRAT<>"" then
	AuxUsername=AuxAGRAT
else
	AuxUsername=""
end if

vIndicEmpregado = "N" ' nao exite funcionario com esta matricula
vNome = ""
vSiglaOrgao = ""
vRIT =  ""

Set ebt1 = New TEbt

Call ebt1.LoginUsuario(AuxUsername)

vNome = ebt1.NomeReduzido()
vSiglaOrgao = ebt1.SiglaOrgao()
vRIT =  ebt1.Ramal()

Set ebt1 = Nothing

'=============================================================================%>

<tr class="realce1">
	<td colspan="6">
	&nbsp;&nbsp;RAT (USERNAME - MATRÍCULA)
	</td>
	<td align="center" colspan="2">
	RAMAL
	</td>	
	<td align="center" colspan="2">
	ÓRGÃO
	</td>
</tr>

<tr >
	<td colspan="6">
	&nbsp;&nbsp;<%=vNome%>&nbsp;(<%=AuxUsername%>&nbsp;-&nbsp;<%=Matricula%>)
	</td>
	<td align="center" colspan="2">
	&nbsp;<%=vRIT%>
	</td>
	<td align="center" colspan="2">
	&nbsp;<%=vSiglaORGAO%>
	</td>
</tr>

<%
sSQL = _
	"SELECT * FROM Participantes_Externos WHERE AG_NUMERO = " & AuxSelecao & " " & _
	"ORDER BY PE_NOME"
call Env.RecordSet( true, objSiteRS, sSQL)
if Not(objSIteRS.EOF) then
	objSiteRS.MoveFirst
%>
<tr class="realce1">
	<td colspan="10">
	&nbsp;&nbsp;PARTICIPANTES EXTERNOS
	</td>
</tr>
<tr >
	<td colspan="10">
<%	Do While Not(objSiteRS.EOF)%>
	&nbsp;&nbsp;Nome: <%=objSiteRS("PE_NOME")%> - 
	&nbsp;&nbsp;Empresa: <%=objSiteRS("PE_EMPRESA")%> - 
	&nbsp;&nbsp;Motivo: <%=objSiteRS("PE_MOTIVO")%><br>
<%		objSiteRS.MoveNext
	loop%>
	</td>
</tr><%
end if%>


<%
sSQL = "SELECT COUNT(*) FROM Agenda_Servicos_Plataforma WHERE AG_NUMERO = " & AuxSelecao
call Env.RecordSet( true, objSiteRS, sSQL)
if objSiteRS(0) > 0 then
	call Env.RecordSet( false, objSiteRS, null)
%>
<tr class="realce1">
	<td align="center" colspan="5">
	SERVIÇOS EMBRATEL UTILIZADOS
	</td>
	<td align="center" colspan="5">
	SISTEMAS UTILIZADOS
	</td>
</tr>
<tr  valign="top">
	<td colspan="5">
<%	sSQL = _
		"SELECT UPPER(sp.S_DESCRICAO) FROM Agenda_Servicos_Plataforma asp INNER JOIN " & _
		"Servicos_Plataformas sp ON asp.S_ID = sp.S_ID WHERE asp.AG_NUMERO = " & AuxSelecao & " " & _
		"AND sp.S_SERVICO = 1 ORDER BY sp.S_DESCRICAO"
	call Env.RecordSet( true, objSiteRS, sSQL)
	Do While Not(objSiteRS.EOF)%>
	&nbsp;&nbsp;-&nbsp;<%=objSiteRS(0)%><br>
<%		objSiteRS.MoveNext
	loop
	call Env.RecordSet( false, objSiteRS, null)%>
	</td>
	<td colspan="5">
<%	sSQL = _
		"SELECT UPPER(sp.S_DESCRICAO) FROM Agenda_Servicos_Plataforma asp INNER JOIN " & _
		"Servicos_Plataformas sp ON asp.S_ID = sp.S_ID WHERE asp.AG_NUMERO = " & AuxSelecao & " " & _
		"AND sp.S_SERVICO = 0 ORDER BY sp.S_DESCRICAO"
	call Env.RecordSet( true, objSiteRS, sSQL)
	Do While Not(objSiteRS.EOF)%>
	&nbsp;&nbsp;-&nbsp;<%=objSiteRS(0)%><br>
<%		objSiteRS.MoveNext
	loop
	call Env.RecordSet( false, objSiteRS, null)%>
	</td>
</tr><%
end if%>
</table>

<%
sSQL = _
	"SELECT os.*, t.*, e.EQ_CODIGOBARRAS, e.MOD_DESCRICAO, e.MOD_CODNOME,  " & _
	"serv.S_DESCRICAO AS S_DESCRICAO_SERVICO, plat.S_DESCRICAO AS S_DESCRICAO_PLATAFORMA, tt.TIT_DESCRICAO " & _
	"FROM Ordem_de_Servico os LEFT JOIN Testes t ON os.T_ID = t.T_ID " & _
	"LEFT JOIN Tipo_Teste tt ON t.TIT_ID = tt.TIT_ID " & _
	"LEFT JOIN vw_SCE_Equipamentos_Fabricantes e ON e.EQ_ID = os.EQ_ID_AMOSTRA " & _
	"LEFT JOIN Servicos_Plataformas serv ON serv.S_ID = os.S_ID_SERVICO " & _
	"LEFT JOIN Servicos_Plataformas plat ON plat.S_ID = os.S_ID_PLATAFORMA " & _
	"WHERE os.AG_NUMERO = " & AuxSelecao & " " & _
	"ORDER BY os.OS_ID"

call Env.RecordSet( true, objRes, sSQL)
If not (objRes.EOF and objRes.BOF) then
	objRes.MoveFirst%>
<br>

<table class="table-bordered" border="0" width="100%" cellpadding="3" cellspacing="0">
<tr>
	<th align="left">Dados do Servi&ccedil;o</th>
</tr>
</table>

<table width="100%" border="1" cellpadding="2" cellspacing="2">
<tr>
<tr class="realce1">
	<td align="center">Nº OS</td>
	<td align="center">TESTE</td>
<!--	<td align="center">DADOS GERAIS DOS TESTES</td> -->
	<td align="center">SERVIÇO</td>
	<td align="center">PLATAFORMA</td>
	<td align="center">AMOSTRA</td>
</tr>
<%	While not objRes.EOF%>
<tr  valign="top">
	<td align="center"><%=Zeros(objRes("OS_ID"),3)%></td>
	<td>
		<%=objRes("T_TITULO")%>
<%
		if not IsNull(objRes("TIT_DESCRICAO")) then
			response.write " (" & objRes("TIT_DESCRICAO") & ")"
		end if
%>
	</td>
<!--
	<td>
<%		'if not IsNull(objRes("T_DESCRICAO")) then%>
	Descrição: <%'=objRes("T_DESCRICAO")%><br>
<%		'end if

		'if not IsNull(objRes("T_OBSERVACAO")) then%>
	Observações: <%'=objRes("T_OBSERVACAO")%><br>
<%		'end if%>
		&nbsp;
	</td>
-->
	<td><%=objRes("S_DESCRICAO_SERVICO")%>&nbsp;</td>
	<td><%=objRes("S_DESCRICAO_PLATAFORMA")%>&nbsp;</td>
	<td>
<%		if Not IsNull(objRes("EQ_CODIGOBARRAS")) then%>
			<%=objRes("EQ_CODIGOBARRAS")%>: <%=objRes("MOD_CODNOME")%> - <%=objRes("MOD_DESCRICAO")%>
<%		end if%>
		&nbsp;
	</td>
</tr>
<%		ObjRes.MoveNext
	WEnd%>
</table>
<%
end if
call Env.RecordSet( false, objRes, null)
%>

<%
if Env.usuarioCRT then
	SSQL = "Select count(ag_numero) as Valor from Agendamento where ag_numero = " & AuxSelecao & " and (not AG_RElat_RT is null or not AG_RElat_RAT is null)"
	call Env.RecordSet( true, objSiteRS, sSQL)
	if cint(objSiteRS("Valor")) > 0 then%>
<br>

<table class="table-bordered" border="0" width="100%" cellpadding="3" cellspacing="0">
<tr>
	<th align="left">Histórico de Comunicações deste Agendamento</th>
</tr>
</table>

<table class="table-bordered" width="100%" border="1" cellpadding="2" cellspacing="1">
<tr>
	<td align="center">
		<font face="arial" class="item"  color="#000000">
		<A href="javascript:visualizarMSG();">Clique aqui para visualizar</font></A>
	</td>
</tr>
</table>
<%	end if
end if
%>

<br>

<script>
function visualizarMSG(){
	var janela;
	janela = window.open("eventosinternos.asp?hdnevento=6&txAS=<%=AuxSelecao%>", "cad_contato", "width=480, height=450, toolbar=no, status=yes, menubar=no, scrollbars=yes");
}
function abreArquivo(nome){
	var janela;
	janela = window.open(nome, '', 'toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=yes,copyhistory=no');
	janela.focus();
}
</script>
<%
Call Tela.MostraRodape()
%>
