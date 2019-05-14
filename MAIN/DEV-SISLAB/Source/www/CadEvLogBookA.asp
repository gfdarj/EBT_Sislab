<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/emailHTML.asp" -->
<!--#include file="includes/controleshtml.asp" -->
<!--#include file="includes/funcoes.asp" -->
<%
Dim objSiteRS, sSQL, auxcodLB, i
Dim auxdatahoraocorrencia
Dim auxdescricao,auxobservacoes,auxusername, auxcadastrado
Dim auxprovidencias,auxip,auxconcluido, auxconcluidoGQ, auxtipocomando, auxobservacoesRes
Dim auxexecutor,auxrespexecucao,auxprazo, auxobservacoesGQ, auxanaliseGQ, auxpendencias, auxrequisitoNorma
Dim auxlstdisposicao, auxdocassociado, auxlstregistros, auxdisposicao, auxexecutante, auxprazore, auxdata, auxeficacia, auxnome, auxnumero
dim lb_crit : lb_crit = null
Dim estado

auxusername = request("hdusername")
auxdatahoraocorrencia = request.form("diaocorrencia") & "/" & request.form("mesocorrencia") & "/" & request.form("anoocorrencia") & " " & request.form("horaocorrencia") & ":" & request.form("minutoocorrencia") & ":00"
auxdtFim = "'" & request.form("diadtFim") & "/" & request.form("mesdtFim") & "/" & request.form("anodtFim") & " " & request.form("horadtFim") & ":" & request.form("minutodtFim") & ":00" & "'"
if request.form("diadtFim") = "" then
	auxdtFim = "null"
end if

auxobservacoes = tiraPlicAspas(request.form("observacoes"))
auxdescricao = tiraPlicAspas(request.form("descricao"))
auxprovidencias = tiraPlicAspas(request.form("providencias"))
auxcodLB = tiraPlicAspas(request.form("codLogBook"))
auxexecutor = tiraPlicAspas(request.form("executor"))
auxrespexecucao = tiraPlicAspas(request.form("responsavel"))
auxcadastrado = tiraPlicAspas(request.form("cadastrado"))
auxprazo = request.form("prazo") 
auxobservacoesGQ = tiraPlicAspas(request.form("observacoesGQ"))
auxanaliseGQ = tiraPlicAspas(request.form("analiseGQ"))
auxrequisitoNorma = tiraPlicAspas(request.form("requisitoNorma"))
auxpendencias = tiraPlicAspas(request.form("pendencias"))
auxobservacoesRes = tiraPlicAspas(request.form("observacoesRes"))
auxdocassociado = tiraPlicAspas(request.form("docassociado"))
auxlstdisposicao = request.form("lstdisposicao").Count
auxlstregistros = request.form("lstregistros").Count
tipoOcorrencia = request.form("tipoOcorrencia")
lb_crit = cstr(request( "lb_criticidade" ))
if lb_crit = "" or lb_crit = "0" then lb_crit = "null"
norma = tiraPlicAspas(request.form( "norma" ))
observacoesgq = tiraPlicAspas(request.form( "observacoesgq" ))
analisegq = tiraPlicAspas(request.form( "analisegq" ))
ratresp = "'" & request.form( "ratResponsavel" ) & "'"
if ratresp = "''" then ratresp = "null"

IF tipoOcorrencia = "" THEN tipoOcorrencia = "null"
IF auxrespexecucao = "" THEN auxrespexecucao = null
IF auxprazo = "" THEN auxprazo = "null"

if request.form("concluida")="1" then
	auxconcluido=1 
else
	auxconcluido=0 
end if

if request.form("concluidaGQ")="on" then
	auxconcluidoGQ=1 
else
	auxconcluidoGQ=0 
end if

if request.form("chkOPM")="on" then
	AUXOPM=1 
else
	AUXOPM=0 
end if

if request.form("chkConcGQ")="on" then
	AUXConqGQ = 1 
else
	AUXConqGQ = 0 
end if


auxip=UCase(request.ServerVariables("REMOTE_ADDR"))

modo = REquest("modo")
ocorrencia = request("ocorrencia")
dim j :j = 0

if modo = "CADASTRAR" then
	SQLACOES = replace(SQLACOES,SEPARADOR,"@identificar")
	sSQL = "DECLARE @identificar as int "
	sSQL = sSQL & "Insert Into LB_LogBook "
	sSQL = sSQL & "(LB_DATAHORACONCLUSAO,lb_prazo,LB_UsernameCad,LB_DataHoraCad,LB_IPCad, "
	sSQL = sSQL & "LB_Descricao,LB_Observacao,LB_providencias, "
	sSQL = sSQL & "LB_DataHoraOco,LB_Concluido,LB_executor, "
	sSQL = sSQL & "LB_DOCASSOCIADO,LB_ConcluidoGQ,LB_RESPEXEC,LBTO_ID,LB_REQUISITONORMA,LB_OBSERVACOESGQ,LB_ANALISEGQ,LB_OPM,LB_RATRESPONSAVEL,LB_CRITICIDADE) "
	sSQL = sSQL & " values (Convert(smalldatetime," & auxdtFim & ",103)" & "," & auxprazo & ",'" & auxusername & "', getDate(),'" & auxip & "', "
	sSQL = sSQL & "'" & auxdescricao & "','" & auxobservacoes & "','" & auxprovidencias & "',"
	sSQL = sSQL & "Convert(smalldatetime,'" & auxdatahoraocorrencia & "',103)," & auxconcluido & ",'" & auxexecutor & "',"
	sSQL = sSQL & "'" & auxdocassociado & "'," & AUXConqGQ & ",'" & auxrespexecucao & "'," & tipoOcorrencia & ",'" & norma & "','" & observacoesgq & "','" & analisegq & "'," & AUXOPM & "," & ratresp & "," & lb_crit & ");"
	sSQL = sSQL & "Set @identificar = @@identity;"

ElseIf modo = "ALTERAR" then
	SQLACOES = replace(SQLACOES,SEPARADOR,ocorrencia)
	SSQL = "UPDATE LB_LogBook SET " & _
			" lb_prazo = " & auxprazo & ", " & _
			" LB_DATAHORACONCLUSAO = Convert(smalldatetime," & auxdtFim & ",103)," & _
			" LB_DataHoraCad = getDate()," & _
			" LB_IPCad = '" & auxip & "'," & _
			" LB_Descricao = '" & auxdescricao & "'," & _
			" LB_Observacao = '" & auxobservacoes & "'," & _
			" LB_providencias = '" & auxprovidencias & "'," & _
			" LB_UsernameCad = '" & auxusername & "'," & _
			" LB_DataHoraOco = Convert(smalldatetime,'" & auxdatahoraocorrencia & "',103)," & _
			" LB_Concluido = '" & auxconcluido & "'," &  _
			" LB_executor = '" & auxexecutor & "'," & _
			" LB_DOCASSOCIADO = '" & auxdocassociado & "'," & _
			" LB_ConcluidoGQ = '" & AUXConqGQ & "'," & _
			" LB_RESPEXEC = '" & auxrespexecucao & "'," & _
			" LBTO_ID = '" & tipoOcorrencia & "'," & _
			" LB_REQUISITONORMA = '" & norma & "'," & _
			" LB_OBSERVACOESGQ = '" & observacoesgq & "'," & _
			" LB_ANALISEGQ = '" & analisegq & "'," & _
			" LB_RATRESPONSAVEL = " & ratresp & "," & _
			" LB_OPM = '" & AUXOPM & "', " & _
			" LB_CRITICIDADE = " & lb_crit

	SSQL = SSQL & " WHERE LB_ID = " & ocorrencia & ";"
end if

'isto era para estar funcionando, não sei por que não está
'por isso tive de fazer um bacalhau
'SSQL = SSQL & SQLACOES '& "Select  @identificar as Numero_da_Ocorrencia;"

'response.write "SQL: " & ssql & "<BR>--------------------<BR>"
'response.write "sqlacoes: " & sqlacoes & "<BR>"
'response.end

call Env.RecordSet( true, objSiteRS, sSQL & " " & SQLACOES )

if modo = "CADASTRAR" then
	sSQL2 = "select lb_id as Numero_da_Ocorrencia, LB_CONCLUIDOGQ, LB_RATRESPONSAVEL from lb_logbook WHERE LB_ID = (select max(lb_id) as Numero_da_Ocorrencia from lb_logbook)"
else
	sSQL2 = "select lb_id as Numero_da_Ocorrencia, LB_CONCLUIDOGQ, LB_RATRESPONSAVEL from lb_logbook where LB_ID = " & ocorrencia
end if
call Env.RecordSet( true, objSiteRS, sSQL2)

if request("resp") = "1" then
	If modo = "CADASTRAR" then
		str1 = "criada"
		estado = "Novo"
	Else
		str1 = "alterada"

		if objSiteRS("LB_CONCLUIDOGQ") = true then _
			estado = "Concluido"
		if objSiteRS("LB_CONCLUIDOGQ") = false and objSiteRS("LB_RATRESPONSAVEL") & "" <> "" then _
			estado = "Em Análise"
		if objSiteRS("LB_CONCLUIDOGQ") = false and objSiteRS("LB_RATRESPONSAVEL") & "" = "" then _
			estado = "Novo"

		Set RS = Nothing
	End If

	msg = "Ocorrência de logbook " & str1 & ": " & "<br>" & _
		  "Nº da Ocorrência : " & objSiteRS("Numero_da_Ocorrencia") &  "<br>" & _
		  "Situação: " & estado &  "<br>" & _
		  "RAT Responsável : " & ratresp &  "<br>" & _
		  "Responsável : " & auxrespexecucao &  "<br>" & _
		  "Solicitante : " & auxusername &  "<br>" & _
		  "Descrição da Ocorrência : " & auxdescricao &  "<br>"
	assunto = "Gerenciamento do LogBook - Elaboração de LogBook"

	'Call enviar_email("gilberto.rj@ig.com.br", "Gilberto", assunto, msg)
	Call enviaEmailRATsGQs(Env.oConn, assunto, msg)

	If Env.ExisteUsuario(auxusername) Then
		Call Enviar_Email(auxusername, auxusername, assunto, msg)
	End If

	If Env.ExisteUsuario(auxrespexecucao) Then
		call Enviar_Email(auxrespexecucao, auxrespexecucao, assunto, msg)
	End If

End If

If Err Then %>
<center>
<table border="0" bgcolor="#FFFFFF" width="80%">
<tr>
<td>
<div align="left">
  <font style="font-size=10pt;" color="#000000"> 
<b>&nbsp;&nbsp;Erro Nº:</b> <%=Err.Number%><br>
<b>&nbsp;&nbsp;Descrição:</b> <%=Err.Description%><br>
  </font>
<%
else
	if ocorrencia = "" then ocorrencia = objSiteRS("Numero_da_Ocorrencia")
	response.redirect "CadEvLogBook.asp?ocorrencia=" & ocorrencia
end if
%>
