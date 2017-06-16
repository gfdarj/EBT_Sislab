<!-- #INCLUDE FILE="global_SCE.asp" -->
<%
'--------------------------------------------------------------------------------------------
'-- ARQUIVO DE FUNCOES E VALIDACOES DE BANCO DE DADOS - SISTEMA SCE
'--------------------------------------------------------------------------------------------


'--------------------------------------------------------------------------------------------
'-- Defino as regras entre o Tipo de Movimentação e o STATUS dos equipamentos/acessórios
'--------------------------------------------------------------------------------------------
function Maquina_de_Estados(notipo)
	dim status_equipamento

	status_equipamento = cint(notipo)

	if (status_equipamento = cint(MOV_ENTRADA)) or (status_equipamento = cint(MOV_LOGISTICA_ENTRADA)) then
		status_equipamento = cint(STATUS_EM_ESTOQUE)  '-- estoque

	elseif status_equipamento = cint(MOV_EXPEDICAO) then '-- expedicao
		status_equipamento = cint(STATUS_EXPEDIDO)      '-- expedido

	elseif status_equipamento = cint(MOV_EXPEDICAO_SUBST) then '-- expedicao com substituicao
		status_equipamento = cint(STATUS_EXPEDIDO_SUBST)      '-- expedido com substituicao

	else '-- logistica saida
		status_equipamento = cint(STATUS_EM_USO) '-- em uso
	end if

	Maquina_de_Estados = status_equipamento
end function

'--------------------------------------------------------------------------------------------
'-- Imprime mensagem de erro em alguma transacao com o banco de dados
'-- Parametro: recebe o objeto Conection.Errors
'--------------------------------------------------------------------------------------------
function erroDB(Erro, link)
	Dim objErro%>
<html>
<head>
	<title>SCE - ERRO DE GRAVAÇÃO</title>
	<link rel="stylesheet" href="css/estilo.css">
</head>
<body>
	<table height="100%" width="100%" align="center">
	<tr valign="middle">
		<td>
			<table width="600px" align="center" class="texto" style="border: thin red solid;">
				<tr><th style="border-bottom: thin red solid;" colspan="2">Ocorreu um erro no banco de dados</th></tr>
				<tr><td colspan="2">&nbsp;</td></tr>
<%	For Each objErro In Erro%>
				<!--<tr><td>Erro:</td><td><%=objErro.Number%></td></tr>-->
				<tr><td>Descri&ccedil;&atilde;o:</td><td><%=objErro.Description%></td></tr>
				<!--<tr><td>Erro nativo:</td><td><%=objErro.NativeError%></td></tr>-->
				<!--<tr><td>Estado SQL:</td><td><%=objErro.SQLState%></td></tr>-->
				<!--<tr><td>Reportado por:</td><td><%=objErro.Source%></td></tr>-->
				<!--<tr><td>Arquivo de Help:</td><td><%=objErro.HelpFile%></td></tr>-->
				<!--<tr><td>ID de ajuda do contexto:</td><td><%=objErro.HelpContext%></td></tr>-->
				<tr><td colspan="2">&nbsp;</td></tr>
<%	Next%>
				<tr><td align="center" colspan="2"><input type="Button" value="Voltar" class="form" onclick="javascript:<%if trim(link) = "" then%>history.go(-1);<%else%><%=link%><%end if%>"></td></tr>
			</table>
		</td>
	</tr>
	</table>
</body>
</html><%
end function

Function VerificaReservaItem(apenasConta, Conn, agendamento, item, ehHTML)
	'-- Retorno a lista de agendamentos na qual um determinado item esta reservado.
	'-- OBS: a reserva é passada caso a mesma esteja sendo alterada,
	'-- caso seja vazio significa uma nova reserva

	Dim rec, s, retorno
	if apenasConta then
		s =	"SELECT DISTINCT count(*) "
	else
		s =	"SELECT re.AG_NUMERO, r.RES_RESPONSAVEL, " & _
			"CONVERT(VARCHAR, re.REQ_DATAINICIO, 103) AS AG_DATAINICIO, " & _
			"CONVERT(VARCHAR, re.REQ_DATATERMINO, 103) AS AG_DATATERMINO "
	end if

	s = s & _
		"FROM SCE_Reserva_Equipamentos re inner join SCE_Reserva_Equipamentos re1 " & _
			"on (re.EQ_ID = re1.EQ_ID and re1.AG_NUMERO <> re.AG_NUMERO) " & _
			"inner join SCE_Reserva r on r.AG_NUMERO = re.AG_NUMERO " & _
		"WHERE ((re.REQ_DATAINICIO BETWEEN re1.REQ_DATAINICIO AND re1.REQ_DATATERMINO) " & _
			"OR (re.REQ_DATATERMINO BETWEEN re1.REQ_DATAINICIO AND re1.REQ_DATATERMINO)) " & _
			"AND re.REQ_MOVIMENTOU = 0 AND re1.EQ_ID = " & item & " AND " & _
			"re1.AG_NUMERO = " & agendamento & " "

	if not apenasConta then _
		s = s & "ORDER BY re.AG_NUMERO, re.REQ_DATAINICIO, re.REQ_DATATERMINO"

'response.write s
'response.end

	Set rec = Conn.execute(s)

	retorno = ""

	if apenasConta then
		if rec(0) > 0 then retorno = cstr(rec(0))
	else
		while not rec.eof
			retorno = retorno & rec("AG_NUMERO") & " (" & rec("RES_RESPONSAVEL") & _
				" - " & rec("AG_DATAINICIO") & " até " & rec("AG_DATATERMINO") & ")"
			rec.MoveNext
			if not rec.eof then retorno = retorno & ", "
		wend
	end if

	rec.Close
	set rec = nothing

	retorno = Trim(retorno)
	if ehHTML then retorno = replace(retorno, " ", "&nbsp;")
	if ehHTML and retorno = "" then retorno = "&nbsp;"

	VerificaReservaItem = retorno
End Function

Function PegaStatusItem(Conn, item, ehHTML)
	'-- Retorno o RT´s que foi o responsavel pela saida do material da logistica

	Dim rec, s, status, local
	Dim retorno : retorno = ""

	if item <> "" then
		s = "SELECT STATUS, EQ_LOCALIZACAO FROM SCE_Equipamentos WHERE EQ_ID = " & item
		Set rec = Conn.execute(s)
		if not (rec.eof and rec.bof) then
			if isNull(rec("STATUS")) then status = -1 else status = rec("STATUS")
			if isNull(rec("EQ_LOCALIZACAO")) then local = "" else local = rec("EQ_LOCALIZACAO")
		end if
		rec.Close

		if status = STATUS_EM_USO then
			'-- PEGO A ULTIMA MOVIMENTACAO DO ITEM
			s =	"SELECT m.ASA AS AG_NUMERO, MOV_SOLICITANTE FROM vw_SCE_Movimentacao_Atual m " & _
				"INNER JOIN SCE_Natureza_Operacao n ON n.NO_ID = m.NO_ID " & _
				"WHERE n.NO_TIPO = " & MOV_LOGISTICA_SAIDA & " AND EQ_ID = " & item & " "
			Set rec = Conn.execute(s)

			if not (rec.eof and rec.bof) then
				if not isNull(rec("AG_NUMERO")) then retorno = rec("AG_NUMERO")
				if not isNull(rec("MOV_SOLICITANTE")) then
					if retorno <> "" then retorno = retorno & " - "
					retorno = retorno & Trim(rec("MOV_SOLICITANTE"))
				end if
			end if

			if retorno <> "" then
				if ehHTML then retorno = "Em Uso" & "<br>" & retorno else retorno = "Em Uso - " & retorno
			else
				retorno = "Em Uso"
			end if
			rec.Close

		elseif status = STATUS_EM_ESTOQUE then
			if ehHTML then retorno = "Em Estoque" & "<br>" & local else retorno = "Em Estoque - " & local

		elseif status = STATUS_EXPEDIDO then
			retorno = "Expedido"

		elseif status = STATUS_EXPEDIDO_SUBST then
			retorno = "Substituído"

		elseif status = STATUS_CADASTRADO then
			if ehHTML then retorno = "Cadastrado" & "<br>" & local else retorno = "Cadastrado - " & local

		end if
	end if

	retorno = Trim(retorno)
	if ehHTML then retorno = replace(retorno, " ", "&nbsp;")
	if ehHTML and retorno = "" then retorno = "&nbsp;"

	PegaStatusItem = retorno
End Function

Function ResponsavelAS(objConn, ag_numero)
	Dim s, objRS
	s = "SELECT AG_RESPONSAVEL FROM Agendamento where AG_NUMERO = " & ag_numero
	Set objRS = ObjConn.Execute(s)
	if not (objRS.Eof and objRS.Bof) then _
		if IsNull(objRS("AG_RESPONSAVEL")) then ResponsavelAS = "" else ResponsavelAS = objRS("AG_RESPONSAVEL")
	objRS.Close
	Set objRS = Nothing
End Function

Function ReservaFechada(objConn, ag_numero)
	Dim s, objRS, total, total_mov
	s = "SELECT count(*) FROM SCE_Reserva_Equipamentos where AG_NUMERO = " & ag_numero
	Set objRS = ObjConn.Execute(s)
	total = objRS(0)
	objRS.Close
	s = "SELECT count(*) FROM SCE_Reserva_Equipamentos where REQ_MOVIMENTOU = 1 AND AG_NUMERO = " & ag_numero
	Set objRS = ObjConn.Execute(s)
	total_mov = objRS(0)
	Set objRS = Nothing
'	if total = total_mov then ReservaFechada = True else ReservaFechada = False
	ReservaFechada = (total = total_mov)
End Function

Function PegaNotaFiscalItem(objConn, item)
	Dim objRS, s
	s =	"SELECT DISTINCT nf.NF_NUMERONOTA FROM SCE_Nota_Fiscal nf " & _
			"INNER JOIN SCE_Movimentacao m ON m.NF_ID = nf.NF_ID " & _
			"WHERE m.EQ_ID = " & item & " ORDER BY nf.NF_NUMERONOTA"
	Set objRS = objConn.Execute(s)
	PegaNotaFiscalItem = ""
	if not (objRS.Eof and objRS.Bof) then
		while not objRS.Eof
			PegaNotaFiscalItem = PegaNotaFiscalItem & objRS(0)
			objRS.MoveNext
			if not objRS.Eof then PegaNotaFiscalItem = PegaNotaFiscalItem & ", "
		wend
	end if
	objRS.Close
	Set objRS = Nothing
	PegaNotaFiscalItem = Trim(PegaNotaFiscalItem)
End Function
%>