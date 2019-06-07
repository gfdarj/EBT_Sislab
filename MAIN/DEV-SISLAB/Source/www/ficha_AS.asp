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
Dim Ebt, Ebt1

Set Ebt = New TEbt
Set Ebt1 = New TEbt

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
AuxResponsavel = objSiteRS("AG_USERNAME_NOME")
AuxRamal = objSiteRS("AG_USERNAME_TELEFONE")
AuxMatricula = objSiteRS("AG_USERNAME_MATRICULA")

'Response.Write "AQUI"
'response.End

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


<div class="container">
    <div class="row">
        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">


<br>

<h4>Histórico de Eventos</h4>

<table border="1" width="100%" cellpadding="2" cellspacing="1" class="table-condensed">
<tr>
	<td style="text-align: center;">SITUAÇÃO</td>
	<td style="text-align: center;">DATA DE INÍCIO</td>
	<td style="text-align: center;">DATA DE TÉRMINO</td>
	<td style="text-align: center;">OBSERVAÇÂO</td>
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
	<td style="text-align: center;">&nbsp;&nbsp;<b><%=objSiteRS("S_Descricao")%></b>&nbsp;</td>
	<td style="text-align: center;"><%=(objSiteRS("HE_DataInicio"))%>&nbsp;</td>
	<td style="text-align: center;"><%=(objSiteRS("HE_DataTermino"))%>&nbsp;</td>
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

<h4>Histórico de Eventos - Ordem de Serviço</h4>

<table border="1" width="100%" cellpadding="2" cellspacing="1" class="table-condensed">
<tr>
	<th style="text-align: center;">Nº OS</th>
	<th style="text-align: center;">SITUAÇÃO</th>
	<th style="text-align: center;">DATA DE INÍCIO</th>
	<th style="text-align: center;">DATA DE TÉRMINO</th>
	<th style="text-align: center;">OBSERVAÇÃO</th>
</tr>
<%	Dim auxOS
	Do while Not objSiteRS.eof
		auxOS = objSiteRS("OS_ID")

		Do while len(auxOS) < 3
			auxOS="0"&auxOS
		loop%>
<tr >
	<td>&nbsp;&nbsp;<%=auxselecao%>/<%=auxOS%>&nbsp;-&nbsp;<%=objSiteRS("T_Titulo")%></td>
	<td style="text-align: center;"><%=objSiteRS("S_Descricao")%>&nbsp;</td>
	<td style="text-align: center;"><%=(objSiteRS("HEOS_DataInicio"))%>&nbsp;</td>
	<td style="text-align: center;"><%=(objSiteRS("HEOS_DataTermino"))%>&nbsp;</td>
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

<h4>Histórico de Alterações de Datas</h4>

<table border="1" width="100%" class="table-condensed">
<tr>
	<th style="text-align: center;">DATA DE INÍCIO</th>
	<th style="text-align: center;">DATA DE TÉRNINO</th>
	<th style="text-align: center;">OBSERVAÇÂO</th>
</tr>
<%
objSiteRS.MoveFirst
Do while Not objSiteRS.eof%>
<tr >
	<td style="text-align: center;"><%=Left(objSiteRS("HD_DataInicio"), 10)%>&nbsp;</td>
	<td style="text-align: center;"><%=Left(objSiteRS("HD_DataTermino"), 10)%>&nbsp;</td>
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

<h4>Arquivos Associados</h4>
<%
	If MostraDadoSigiloso(AuxIdSigilo, AuxUsername) Then
%>
<table border="1" width="100%" class="table-condensed">
<tr>
	<td style="text-align: center;">TIPO DE ARQUIVO</td>
	<td style="text-align: center;">ARQUIVO</td>
</tr>
<%		objSiteRS.MoveFirst
		Do while Not objSiteRS.eof%>
<tr>
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


<h4>Dados do Agendamento</h4>

<table width="100%" border="1" class="table-condensed">
<tr>
	<th colspan="10">TÍTULO DO AGENDAMENTO</th>
</tr>
<tr>
	<td colspan="10">
	<%=auxtitulo%>
	</td>
</tr>
<tr>
	<th colspan="6">TIPO DE TESTE</th>
	<th colspan="2" style="text-align: center;">DATA DE INÍCIO</th><th colspan="2" style="text-align: center;">DATA DE TÉRMINO</th>
</tr>
<tr>
	<td colspan="6"><%=auxtipoteste%>&nbsp;&nbsp;<%=auxdadosteste%></td>
	<td colspan="2" style="text-align: center;">&nbsp;<%=AuxDataInicio%></td>
	<td colspan="2" style="text-align: center;">&nbsp;<%=AuxDataTermino%></td>
</tr>
<tr>
	<th colspan="6">TECNOLOGIA UTILIZADA (PRINCIPAL)</th>
	<th colspan="2" style="text-align: center;">DATA DA SOLICITAÇÃO</th>
	<th colspan="2" style="text-align: center;">CONFIDENCIALIDADE</th>
</tr>
<tr >
	<td colspan="6"><%=auxTec%></td>
	<td style="text-align: center;" colspan="2">&nbsp;<%=AuxDataSolicita%></td>
	<td style="text-align: center;" colspan="2">&nbsp;<%=AuxSigilo%></td>
</tr>

<tr>
	<th colspan="10">OBJETIVO DO TESTE</th>
</tr>
<tr >
	<td colspan="10"><%=auxobjteste%></td>
</tr>

<tr>
	<th colspan="10">AMBIENTE NECESSÁRIO</th>
</tr>
<tr >
	<td colspan="10"><%=auxambiente%></td>
</tr>

<tr>
	<th colspan="10">RECURSOS NECESSÁRIOS</th>
</tr>
<tr >
	<td colspan="10"><%=auxrecursos%></td>
</tr>

<tr>
	<th colspan="10">OBSERVAÇÕES</th>
</tr>
<tr >
	<td colspan="10"><%=auxObs%></td>
</tr>

<tr>
	<th colspan="6">SOLICITANTE (USERNAME - MATRÍCULA)</th>
	<th colspan="2" style="text-align: center;">RAMAL</th>
	<th colspan="2" style="text-align: center;">ÓRGÃO</th>
</tr>
<tr >
	<td colspan="6"><%=AuxResponsavel%>&nbsp;(<%=AuxUsername%>&nbsp;-&nbsp;<%=AuxMatricula%>)</td>
	<td colspan="2" style="text-align: center;"><%=AUXRAMAL%></td>
	<td colspan="2" style="text-align: center;"><%=AUXORGAO%></td>
</tr>

<tr>
	<th colspan="3">CLIENTES EXTERNOS</th>
	<th colspan="4">RETIFICAÇÃO</th>
	<th colspan="3">RETORNO DO CLIENTE (R$)</th>
</tr>
<tr >
	<td colspan="3"><%=auxamostra%></td>
	<td colspan="4"><%=auxretificacao%></td>
	<td colspan="3" style="text-align: right;"><%=FormatCurrency(AuxRetornoCliente)%>&nbsp;&nbsp;</td>
</tr>

<%
if not IsNull(AuxMetas) then%>
<tr>
	<th colspan="10" style="text-align: center;">PLANO DE METAS DA <%=UCase(Application("SISLAB_NOME_EMPRESA"))%></th>
</tr>
<tr >
	<td colspan="4"><%=AuxMetas%></td>
</tr>
<%
end if
%>

<%'=============================================================================
Dim Matricula, vIndicEmpregado
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

'response.write "AQUI 1: " & AuxUsername
Call Ebt1.LoginUsuario(AuxUsername)

Matricula = Ebt1.Matricula()
vNome = Ebt1.NomeReduzido()
vSiglaOrgao = Ebt1.SiglaOrgao
vRIT =  Ebt1.Ramal
Matricula = ebt1.Matricula()

'=============================================================================%>

<tr>
	<th colspan="6">RESPONSÁVEL TÉCNICO (USERNAME - MATRÍCULA)</th>	
	<th colspan="2" style="text-align: center;">RAMAL</th>
	<th colspan="2" style="text-align: center;">ÓRGÃO</th>
</tr>
<tr >
	<td colspan="6"><%=vNome%>&nbsp;(<%=AuxUsername%>&nbsp;-&nbsp;<%=Matricula%>)</td>
	<td colspan="2" style="text-align: center;"><%=vRIT%></td>
	<td colspan="2" style="text-align: center;"><%=vSiglaORGAO%></td>
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

'response.write "AQUI 2: " & AuxUsername
Call Ebt1.LoginUsuario(AuxUsername)

vNome = ebt1.NomeReduzido()
vSiglaOrgao = ebt1.SiglaOrgao()
vRIT =  ebt1.Ramal()
Matricula = ebt1.Matricula()

'=============================================================================%>

<tr>
	<th colspan="6">RAT (USERNAME - MATRÍCULA)</th>
	<th colspan="2" style="text-align: center;">RAMAL</th>	
	<th colspan="2" style="text-align: center;">ÓRGÃO</th>
</tr>
<tr >
	<td colspan="6"><%=vNome%>&nbsp;(<%=AuxUsername%>&nbsp;-&nbsp;<%=Matricula%>)</td>
	<td colspan="2" style="text-align: center;"><%=vRIT%></td>
	<td colspan="2" style="text-align: center;"><%=vSiglaORGAO%></td>
</tr>

<%
sSQL = _
	"SELECT * FROM Participantes_Externos WHERE AG_NUMERO = " & AuxSelecao & " " & _
	"ORDER BY PE_NOME"
call Env.RecordSet( true, objSiteRS, sSQL)
if Not(objSIteRS.EOF) then
	objSiteRS.MoveFirst
%>
<tr>
	<th colspan="10">PARTICIPANTES EXTERNOS</th>
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
<tr>
	<td style="text-align: center;" colspan="5">
	SERVIÇOS <%=UCase(Application("SISLAB_NOME_EMPRESA"))%> UTILIZADOS
	</td>
	<td style="text-align: center;" colspan="5">
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

<h4>Dados do Servi&ccedil;o</h4>

<table width="100%" border="1" class="table-condensed">
<tr>
<tr>
	<td style="text-align: center;">Nº OS</td>
	<td style="text-align: center;">TESTE</td>
	<td style="text-align: center;">SERVIÇO</td>
	<td style="text-align: center;">PLATAFORMA</td>
	<td style="text-align: center;">AMOSTRA</td>
</tr>
<%	While not objRes.EOF%>
<tr  valign="top">
	<td style="text-align: center;"><%=Zeros(objRes("OS_ID"),3)%></td>
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

<h4>Histórico de Comunicações deste Agendamento</h4>

<table class="table-bordered" width="100%" border="1" cellpadding="2" cellspacing="1">
<tr>
	<td style="text-align: center;">
		<font face="arial" class="item"  color="#000000">
		<A href="javascript:visualizarMSG();">Clique aqui para visualizar</font></A>
	</td>
</tr>
</table>
<%	end if
end if
%>
        </div>
    </div>
</div>

<br />
<br />

<script type="text/javascript">
    function visualizarMSG()
    {
	    var janela;
	    janela = window.open("eventosinternos.asp?hdnevento=6&txAS=<%=AuxSelecao%>", "cad_contato", "width=480, height=450, toolbar=no, status=yes, menubar=no, scrollbars=yes");
    }
    function abreArquivo(nome)
    {
	    var janela;
	    janela = window.open(nome, '', 'toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=yes,copyhistory=no');
	    janela.focus();
    }
</script>
<%
Set Ebt = nothing
Set Ebt1  = nothing

Call Tela.MostraRodape()
%>
