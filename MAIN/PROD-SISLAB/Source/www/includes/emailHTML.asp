<%
'----------------------------------------------------------------------------------------------
'-- Transforma o link de uma mensagem texto simples em um código com o link para ser
'-- inserido em uma página HTML. Procuro pelos caracteres ao final do link como ".", ",",
'-- "!", "?", ":", ";"
'--
'-- Exemplo:
'--   ENTRADA:
'--   Sua solicitação foi cadastrada com sucesso, e será analisada em até dois dias úteis.
'--   Acompanhe o andamento da sua solicitação no site do CRT :
'--   http://ntspo901/PORTALVPR/ProjetosEAdmRede/EstrategiaPortifTec/SISLAB1/index.asp.
'--
'--   SAÍDA
'--   Sua solicitação foi cadastrada com sucesso, e será analisada em até dois dias úteis.
'--   Acompanhe o andamento da sua solicitação no site do CRT : Clique aqui para acessar.
'--
'--   Onde "Clique aqui para acessar" é o link substituído.
'--
'--   Código HTML: 
'--   Sua solicitação foi cadastrada com sucesso, e será analisada em até dois dias úteis.
'--   Acompanhe o andamento da sua solicitação no site do CRT : 
'--   <A HREF='http://ntspo901/PORTALVPR/ProjetosEAdmRede/EstrategiaPortifTec/SISLAB1/index.asp'>Clique aqui para acessar</A>.
'----------------------------------------------------------------------------------------------
Function Link2Html( MyString )
	Dim MyArray, Msg, StrAux, Ok, i

	MyArray = Split(Replace(MyString, VbCrLf, " <BR>"), "http://", -1, 1)

	Msg = MyArray(0)

	'-- Posso supor que existe um link, agora preciso pegar o final do link e comparar.
	if ubound(myarray) > 0 then

		MyString = MyArray(1)
		MyArray = Split(MyString, " ", -1, 1)  '-- MyArray(0) tem o link

'response.write "0--> " & myarray(0) & "<BR><BR>"
'response.write "1--> " & myarray(1) & "<BR><BR>"
'response.write "2--> " & myarray(2) & "<BR><BR>"


		Ok = False
		i = 1
		While not Ok
'		response.write " ENTREI AQUI OKAY !!! " & myarray(0) & " QUE DROA !!!"
			if (Right(MyArray(0),i) = ".") or (Right(MyArray(0),i) = ",") or _
				(Right(MyArray(0),i) = ":") or (Right(MyArray(0),i) = ";") or _
				(Right(MyArray(0),i) = "<") or (Right(MyArray(0),i) = ">") or _
				(Right(MyArray(0),i) = "!") or (Right(MyArray(0),i) = "?") then
				i = i + 1
			else
				Ok = True
			end if
		WEnd

		Msg = Msg & "<A HREF='http://" & Left(MyArray(0), Len(MyArray(0))-i+1) & "'>Clique aqui para acessar o site</A>" & Right(MyArray(0),i-1)

		if UBound(MyArray) > 0 then
			for i = 1 to UBound(MyArray)
				Msg = Msg & " " & MyArray(i)
			next
		end if
	end if

	Link2Html = Msg
End Function


'----------------------------------------------------------------------------------------------
'-- Envia um email com os parametros selecionados
'----------------------------------------------------------------------------------------------
Sub Enviar_EmailGenerico(de_email, de_nome, para_email, para_nome, assunto, texto)

'rw "de: " & de_nome & "<" & de_email & ">"
'rw "<br>para:" & para_nome & "<" & para_email & ">"
'rw "<BR><BR>assunto: " & assunto
'rw "<BR><BR>texto: " & texto
're

	If Application("SISLAB_AMBIENTE") = "LOC" Then
		Exit Sub
	End If

'response.write "<BR><BR><BR>de_email 1: " & de_email
    If InStr(UCase(de_email), UCase("T3LAIL")) > 0 Then
        de_email = "laila.sousa@claro.com.br"
    End If
    If InStr(UCase(de_email), UCase("T3MZEN")) > 0 Then
        de_email = "maria.neta@claro.com.br"
    End If
    'If Left(UCase(de_email), 6) = "T3LAIL" Then
    '    de_email = "laila.sousa@claro.com.br"
    'End If
    'If Left(UCase(de_email), 6) = "T3MZEN" Then
    '    de_email = "maria.neta@claro.com.br"
    'End If
'response.write "<BR>de_email 2: " & de_email

'response.write "<BR><BR>para_email 1: " & para_email
    If InStr(UCase(para_email), UCase("T3LAIL")) > 0 Then
        para_email = "laila.sousa@claro.com.br"
    End If
    If InStr(UCase(para_email), UCase("T3MZEN")) > 0 Then
        para_email = "maria.neta@claro.com.br"
    End If
    'If Left(UCase(para_email), 6) = "T3LAIL" Then
    '    para_email = "laila.sousa@claro.com.br"
    'End If
    'If Left(UCase(para_email), 6) = "T3MZEN" Then
    '    para_email = "maria.neta@claro.com.br"
    'End If
'response.write "<BR>para_email 2: " & para_email
'exit sub

	Dim objMail
	Set objMail = Server.CreateObject("CDONTS.NewMail") 
	objMail.from = de_nome & "<" & de_email & ">"
	objMail.to = para_nome & "<" & para_email & ">"
	objMail.MailFormat = 0  ' formato MIME
	objMail.BodyFormat = 0  ' html
	objMail.subject = assunto 
	objMail.body = _
			"<html>" & _
			"<head><title>" & assunto & "</title></head>" & _
			"<body>" & Replace(texto, VbCrLf, "<BR>") & "</body>" & _
			"</html>"
	objMail.send

	set objmail = nothing
End Sub


'----------------------------------------------------------------------------------------------
'-- Envia um email com os parametros selecionados
'----------------------------------------------------------------------------------------------
Sub Enviar_Email(para_email, para_nome, assunto, texto)
	Dim objMail

'response.write "<BR>para_email 1: " & para_email
    If InStr(UCase(para_email), UCase("T3LAIL")) > 0 Then
        para_email = "laila.sousa@claro.com.br"
    End If
    If InStr(UCase(para_email), UCase("T3MZEN")) > 0 Then
        para_email = "maria.neta@claro.com.br"
    End If
    'If Left(UCase(para_email), 6) = "T3LAIL" Then
    '    para_email = "laila.sousa@claro.com.br"
    'End If
    'If Left(UCase(para_email), 6) = "T3MZEN" Then
    '    para_email = "maria.neta@claro.com.br"
    'End If
'response.write "<BR>para_email 2: " & para_email
'exit sub

	If Application("SISLAB_AMBIENTE") <> "LOC" Then
		Set objMail = Server.CreateObject("CDONTS.NewMail") 
		objMail.from = EMAILDEENVIODOSISLAB & "<" & EMAILDEENVIODOSISLAB & ">"
		objMail.to = para_nome & "<" & para_email & ">"
		objMail.MailFormat = 0  ' formato MIME
		objMail.BodyFormat = 0  ' html
		objMail.subject = assunto 
		objMail.body = _
			"<html>" & _
			"<head><title>" & assunto & "</title></head>" & _
			"<body>" & Replace(texto, VbCrLf, "<BR>") & "</body>" & _
			"</html>"
		objMail.send
		set objmail = nothing
	End If
End Sub


'FUNÇÃO QUE DADO UM NOVO DOCUMENTO VERIFICA SE É UM DOCUMENTO DA QUALIDADE E ENVIA
'UM EMAIL DE NOTIFICAÇÃO A TODOS OS FUNCONÁRIOS DO CRT
Function enviaEmailUpload(objConn,tipoDocumento,Descricao,Responsavel)
	if ehDocumentoComExpiracao(objConn,tipoDocumento) then
		ssql = "select tar_tipoarquivo from tipoarquivo where tar_codtipoarquivo = " & tipoDocumento

		call Env.RecordSet(true, rsSite, sSQL)

		ssql = "select nome from usercrt where userid = '" & Responsavel & "'"
		call Env.RecordSet( true, rsSite2, sSQL)

		msg = "Um(a) novo(a) '" & rsSite("tar_tipoarquivo") & "' está disponível no site, " & _
			  "sob a responsabilidade de " & rsSite2("nome") & ".<br>" & _
			  "Consulte o site do sislab, na área de documentos disponíveis para maiores informações. "

		call enviaEmailUserCRT(objConn,"Atualização de documentos no site.", msg)
	end if
End Function

'FUNÇÃO QUE DADA UMA AS E UM TEXTO ENVIA UM EMAIL PARA AS PESSOAS RELACIONADAS A ESTA AS
Function enviaEmailsAS(objConn, numAS, Titulo, Texto)
	dim Rat, Rt, rsAgendamento,sSQL,rsRATs,Solicitante:Solicitante=""

	If Application("SISLAB_AMBIENTE") = "LOC" Then
		Exit Function
	End If

	if not isnull(numAS) then
		sSQL = "select * from agendamento where ag_numero=" & numAS
		call Env.RecordSet( true, rsAgendamento, sSQL)
		if not (rsAgendamento.eof and rsAgendamento.bof) then
			Rat = rsAgendamento("AG_RAT") & ""
			Rt = rsAgendamento("AG_RESPONSAVEL") & ""
			if rsAgendamento("AG_RECEBEMAIL") then
				Solicitante = rsAgendamento("AG_USERNAME")
			end if

			'Modificação para enviar e-mail a todos os rats do sistema
			'if Rat <> "" then
			'	enviar_email NOMEDEENVIODOSISLAB, EMAILDEENVIODOSISLAB, Rat & SUFIXOEMAIL,Rat, Titulo, Texto
			'end if

			if Rt <> "" And Env.Ebt.ExisteUsuario(Rt) then
				Call enviar_email(Rt & SUFIXOEMAIL,Rt, Titulo, Texto)
			end if

			if Solicitante <> "" And Env.Ebt.ExisteUsuario(Solicitante) then
				Call enviar_email(Solicitante & SUFIXOEMAIL,Solicitante, Titulo, Texto)
			end if

			'Modificação para enviar e-mail a todos os rats do sistema
			'if Rat = "" then
			call enviaEmailRATsGQs(objConn,Titulo,texto)
			'end if
		end if
	end if
	'RESPONSE.END
End Function


'### FUNÇÃO QUE DADA UMA AS E UM TEXTO ENVIA UM EMAIL PARA AS PESSOAS RELACIONADAS A ESTA AS
'### Obs: Semelhante a funcao enviaEmailsAS, porém envia o email ao solicitante sem ser pelo ilab, usando
'###     o email do RT
Function enviaEmailsASFinalizada(objConn, numAS, Titulo, Texto)
	dim Rat, Rt, rsAgendamento,sSQL,rsRATs,Solicitante:Solicitante=""

	if not isnull(numAS) then
		sSQL = "select * from agendamento where ag_numero=" & numAS
		call Env.RecordSet( true, rsAgendamento, sSQL)
		if not (rsAgendamento.eof and rsAgendamento.bof) then
			Rat = rsAgendamento("AG_RAT") & ""
			Rt = rsAgendamento("AG_RESPONSAVEL") & ""
			if rsAgendamento("AG_RECEBEMAIL") then
				Solicitante = rsAgendamento("AG_USERNAME")
			end if

			'Modificação para enviar e-mail a todos os rats do sistema
			'if Rat <> "" then
			'	enviar_email NOMEDEENVIODOSISLAB, EMAILDEENVIODOSISLAB, Rat & SUFIXOEMAIL,Rat, Titulo, Texto
			'end if

			if Rt <> "" And Env.Ebt.ExisteUsuario(Rt) then
				Call enviar_email(Rt & SUFIXOEMAIL, Rt, Titulo, Texto)
			end if

			if Solicitante <> "" And Env.Ebt.ExisteUsuario(Solicitante) then
				'Envia o email ao solicitante como se fosse o RT
				Call Enviar_EmailGenerico( _
						Rt & SUFIXOEMAIL, _
						Env.Ebt.AchaNomeEmbratel(Rt), _
						Solicitante & SUFIXOEMAIL, _
						Env.Ebt.AchaNomeEmbratel(Solicitante), _
						Titulo, _
						Texto _
				)
				'Call Enviar_EmailGenerico(Rt & SUFIXOEMAIL, Env.Ebt.AchaNomeEmbratel(Rt), "gilberto.rj@ig.com.br", "Gilberto Almeida", Titulo, Texto)
			end if

			'Modificação para enviar e-mail a todos os rats do sistema
			'if Rat = "" then
			call enviaEmailRATsGQs(objConn,Titulo,texto)
			'end if
		end if
	end if
	'RESPONSE.END
End Function
'###

Function VerificaVigenciaArquivos()
	Dim chr_Msg
	Dim chr_MsgValidar
	Dim chr_MsgExpirado
	Dim sSQL
	Dim RS
	Dim int_Periodo
	Dim chr_IP

	If Trim(Env.IP) = "" Then chr_IP = "Null" Else chr_IP = "'" & Env.IP & "'"

	int_Periodo = 7

	Set RS = Env.oConn.Execute("sp_VerificaVigenciaArquivos " & int_Periodo & ", '" & Env.Usuario & "', " & chr_IP)

'response.write "sp_VerificaVigenciaArquivos " & int_Periodo & ", '" & Env.Usuario & "', " & chr_IP
'response.end

	chr_MsgExpirado = "O(s) seguinte(s) arquivo(s) estão expirado(s):<BR><BR>"
	chr_MsgValidar = "O(s) seguinte(s) arquivo(s) precisam ser validado(s):<BR><BR>"

	If Not (RS Is Nothing) Then
		If Not (RS.Eof And RS.Bof) Then
			If RS("ERRO") = 0 Then

				'-- indica que foi retornado algum valor e deve ser enviado email
				If Not IsNull(RS("Expirou")) Then
					'--
					While Not RS.Eof

						If RS("Expirou") = 1 Then
							chr_Msg = "O arquivo '" & RS("Arq_link") & "' expirou.<br>" & _
								  " Para valida-lo por mais 12 meses, consulte a area documentos disponiveis e execute o procedimento de validação."
						Else
							chr_Msg = "O arquivo '" & RS("Arq_link") & "' está prestes a expirar.<br>" & _
								  " Para validá-lo por mais 12 meses, consulte a area documentos disponíveis e execute o procedimento de validação."
						End If

						'Call enviaEmailRATsGQs(Env.oConn, "SISLAB - Validação do Documento " & RS("Arq_link"), chr_Msg)
						'response.write chr_msg & "<BR><BR><BR>"

						RS.MoveNext
					WEnd
				'Else
				'	Response.Write "Nenhum cara retornado !<BR><BR>"
				End If
			Else
				chr_Msg = _
						"O email de aviso de vencimento/expiração dos arquivos não pode ser enviado.<BR><BR>" & _
						"Data: " & Day(date) & "/" & Month(date) & "/" & Year(date) & "<BR>" & _
						"Hora: " & Time()
				'Call Enviar_Email("gilbertof@yahoo.com", "SISLAB - Erro no envio de aviso para validação de arquivos", chr_Msg)
				'Call EnviaEmailGQs("SISLAB - Erro no envio de aviso para validação de arquivos", Texto)
			End If
		End If
	End If

	Set RS = Nothing

	'response.write chr_msg & "<BR><BR><BR>"
	'response.end
End Function


'Envia e-mails para Rat's e GQ's
Function enviaEmailGQs( Titulo, Texto)
	Dim rsRATs

	sSQL = "select * from usercrt where exibir=1 or gq=1"
	call Env.RecordSet( true, rsRATs, sSQL)

	while not rsRATs.eof
		If Env.Ebt.ExisteUsuario(rsRATs("userid")) Then
			Call enviar_email(rsRATs("userid") & SUFIXOEMAIL,rsRATs("userid"), Titulo, Texto)
		End If
		rsRATs.movenext
	wend
End Function


'Envia e-mails para Rat's somente
Function EnviaEmailRATs(Titulo, Texto)
	Dim rsRATs

	sSQL = "select * from usercrt where rat=1 and exibir=1"
	call Env.RecordSet( true, rsRATs, sSQL)

	while not rsRATs.eof
		If Env.Ebt.ExisteUsuario(rsRATs("userid")) Then
			Call enviar_email(rsRATs("userid") & SUFIXOEMAIL, rsRATs("userid"), Titulo, Texto)
		End If
		rsRATs.movenext
	wend
End Function


'Envia e-mails para Rat's e GQ's
Function enviaEmailRATsGQs(objConn, Titulo, Texto)
	Dim rsRATs

	sSQL = "select * from usercrt where rat=1 or gq=1"
	call Env.RecordSet( true, rsRATs, sSQL)

	while not rsRATs.eof
		If Env.Ebt.ExisteUsuario(rsRATs("userid")) Then
			Call enviar_email(rsRATs("userid") & SUFIXOEMAIL, rsRATs("userid"), Titulo, Texto)
		End If
		rsRATs.movenext
	wend

    Set rsRATs = Nothing
End Function


'Envia e-mails para todos os usuarios do CRT
Function enviaEmailUserCRT(objConn,Titulo,Texto)
	sSQL = "select * from usercrt where exibir=1"
	call Env.RecordSet( true, rsRATs, sSQL)

	While not rsRATs.eof
		If Env.Ebt.ExisteUsuario(rsRATs("userid")) Then
			Call enviar_email(rsRATs("userid") & SUFIXOEMAIL, rsRATs("userid"), Titulo, Texto)
		End If
		rsRATs.movenext
	Wend
End Function


'Envia e-mails para os RT's e GQ's quando o usuário responde à pesquisa
Sub EnviaEmailRespostaPesquisa(objConn, int_AS)
	Dim chr_SQL
	Dim chr_Texto
	Dim chr_Titulo
	Dim RS

	chr_Titulo = "SISLAB - Resposta à Pesquisa de Satisfação " & int_AS
	chr_Texto = "A pesquisa de satisfação foi respondida pelo usuário do agendamento " & int_AS & "</b>.<br><br>"

	chr_SQL = _
		"SELECT AG_RESPONSAVEL FROM vw_Agendamento WHERE AG_NUMERO = " & int_AS & " " & _
		"UNION " & _
		"SELECT USERID from UserCRT where GQ = 1"

	call Env.RecordSet(True, RS, chr_SQL)
	While Not RS.Eof
		If Env.Ebt.ExisteUsuario(RS(0)) Then
			Call Enviar_email(RS(0) & SUFIXOEMAIL, RS(0), chr_Titulo, chr_Texto)
			'enviar_email "gilbertof@yahoo.com", RS(0), RS(0) & "-" & chr_Titulo, chr_Texto
		End If
		RS.MoveNext
	WEnd
	call Env.RecordSet(False, RS, chr_SQL)
End Sub


'### FUNÇÃO QUE DADA UMA AS, envia ao solicitante uma menssagem personalisada pedindo a resposta
'### à pesquisa de satisfação e usando o email remetente como o do RT
Function EnviaEmailRespondaPesquisa(numAS)
	Dim Rat, Rt, NomeRT, rsAgendamento, sSQL, rsRATs, Solicitante : Solicitante = ""
	Dim RS, Titulo, Texto

	If Application("SISLAB_AMBIENTE") = "LOC" Then
		Exit Function
	End If

	If Not IsNull(numAS) Then

		sSQL = "select a.AG_USERNAME, a.AG_RESPONSAVEL, u.NOME "
		sSQL = sSQL & "from agendamento a INNER JOIN Usercrt u ON a.AG_RESPONSAVEL = u.USERID "
		sSQL = sSQL & "where ag_numero=" & numAS
		call Env.RecordSet(True, rsAgendamento, sSQL)
		If not (rsAgendamento.eof and rsAgendamento.bof) Then
			Rt = rsAgendamento("AG_RESPONSAVEL") & ""
			Solicitante = rsAgendamento("AG_USERNAME") & ""
			NomeRT = rsAgendamento("NOME") & ""

			'### Busca a menssagem personalizada para a pesquisa de satisfação
			Set RS = Env.oConn.Execute("SELECT DeMensagem, TextoMensagem FROM Mensagem WHERE CodMensagem = 1")

			If Not RS.Eof Then
				Titulo = "Responda à Pesquisa de Satisfação do AS " & numAS
				Texto = Replace(RS("TextoMensagem"), "%PARAMETRO_1%", numAS)

				'Envia o email ao solicitante como se fosse o RT
				Call Enviar_EmailGenerico( _
					Rt & SUFIXOEMAIL, _
					NomeRT, _
					Solicitante & SUFIXOEMAIL, _
					Env.Ebt.AchaNomeEmbratel(Solicitante), _
					Titulo, _
					Texto _
				)
				'### Envia email para mim como teste
				'Call Enviar_EmailGenerico(Rt & SUFIXOEMAIL, Env.Ebt.AchaNomeEmbratel(Rt), "gilberto.rj@ig.com.br", "Gilberto Almeida", Titulo, Texto)
			End If
			Set RS = Nothing
		End If
		call Env.RecordSet(False, rsAgendamento, sSQL)
	End If
	'RESPONSE.END
End Function


'### Verifica se a AS possui Equipamentos de terceiros e com NF de entrada
Function EnviaEmailTemEquipamentoTerceiro(num_ag)
	Dim ssql, RS
	Dim Titulo, Texto
	Dim Rt, NomeRT, NomeRat, Rat

	'If Application("SISLAB_AMBIENTE") = "LOC" Then
	'	Exit Function
	'End If

	ssql = "SELECT A.AG_NUMERO, a.AG_RESPONSAVEL, UResp.NOME AS NOME_RESP, a.AG_RAT, URat.NOME AS NOME_RAT, "
	ssql = ssql & "	a.AG_USERNAME, ISNULL(Terc.Total, 0) AS Total "
	ssql = ssql & "FROM  Agendamento A INNER JOIN "
	ssql = ssql & "      Usercrt UResp ON a.AG_RESPONSAVEL = UResp.USERID INNER JOIN "
	ssql = ssql & "      Usercrt URat ON a.AG_RAT = URat.USERID LEFT JOIN "
	ssql = ssql & "      (SELECT R.AG_NUMERO, COUNT(*) AS Total "
	ssql = ssql & "		FROM  SCE_Movimentacao M INNER JOIN "
	ssql = ssql & "			SCE_Natureza_Operacao NO INNER JOIN "
	ssql = ssql & "			SCE_Nota_Fiscal NF ON NO.NO_ID = NF.no_id ON M.NF_ID = NF.NF_ID INNER JOIN "
	ssql = ssql & "			SCE_Reserva_Equipamentos R INNER JOIN "
	ssql = ssql & "			SCE_Equipamentos E ON R.EQ_ID = E.EQ_ID ON M.EQ_ID = R.EQ_ID "
	ssql = ssql & "		WHERE /*(M.RESERVA = 1) AND*/ (NO.NO_TIPO = 1) AND (NO.ASA = 1) AND (E.EQ_PROPRIEDADE = 'T') "
	ssql = ssql & "			/*AND R.AG_NUMERO = */ "
	ssql = ssql & "		GROUP BY R.AG_NUMERO "
	ssql = ssql & "	) AS Terc ON a.AG_NUMERO = Terc.AG_NUMERO "
	ssql = ssql & "WHERE "
	ssql = ssql & "	A.AG_NUMERO = " & num_ag & " "
'response.Write(ssql) & "<BR>"
'response.End()

	Call Env.RecordSet(True, RS, ssql)
	If Not RS.Eof Then
		Rat = RS("AG_RAT")
		NomeRat = RS("NOME_RAT") & ""
		Rt = RS("AG_RESPONSAVEL") & ""
		NomeRT = RS("NOME_RESP") & ""

		If RS("Total") > 0 Then

			Titulo = "SISLAB/SCE - Equipamento de terceiro na AS " & num_ag & " - AS Finalizada"
			Texto = "Este agendamento possuí " & RS("Total") & " equipamento(s) de terceiros que deram entrada no CRT.<BR><BR>Verifique se os mesmos já deram saída na logística.<BR><BR>Grato.<BR>Equipe CRT.<BR>"

			'Envia o email ao RT, ao LogFund e aos RATs
			Call Enviar_EmailGenerico("ilab@embratel.com.br", "SISLAB", Rt & SUFIXOEMAIL, NomeRT, Titulo, Texto)
			Call Enviar_EmailGenerico("ilab@embratel.com.br", "SISLAB", "logfund1" & SUFIXOEMAIL, "Logfund 1", Titulo, Texto)
			Call Enviar_EmailGenerico("ilab@embratel.com.br", "SISLAB", "logfund2" & SUFIXOEMAIL, "Logfund 2", Titulo, Texto)
			Call EnviaEmailRATs(Titulo, Texto)

			'### Envia email para mim como teste
			'Call Enviar_EmailGenerico("ilab@embratel.com.br", "SISLAB", "gilberto.rj@ig.com.br", "Gilberto", Titulo, Texto )
'rw titulo & "<BR><BR>" & texto
're
		Else
			Titulo = "SISLAB/SCE - AS " & num_ag & " foi Finalizada"
			Texto = "Este agendamento foi finalizado.<BR><BR>" & _
					"RAT: " & NomeRat & "<BR><BR>" & _
					"RT: " & NomeRT & "<BR><BR>" & _
					"Equipe CRT.<BR>"

			'Envia o email ao RT, ao LogFund e aos RATs
			Call Enviar_EmailGenerico("ilab@embratel.com.br", "SISLAB", "logfund1" & SUFIXOEMAIL, "Logfund 1", Titulo, Texto)
			Call Enviar_EmailGenerico("ilab@embratel.com.br", "SISLAB", "logfund2" & SUFIXOEMAIL, "Logfund 2", Titulo, Texto)

			'Call Enviar_EmailGenerico("ilab@embratel.com.br", "SISLAB", "gilberto.rjo@gmail.com", "Gilberto", Titulo, Texto )
		End If
	End If

'response.Write(titulo) & "<BR>---<BR>"
'response.Write(texto) & "<BR>---<BR>"

	Call Env.RecordSet(False, RS, Null)
End Function
%>