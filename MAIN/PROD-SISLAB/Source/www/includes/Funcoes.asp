<%
'-- retorna a data por extenso em portugues
Function DataExtenso(data)
	Session.LCID = 1046
	DataExtenso = FormatDateTime(data,vbLongDate)
End Function

function ehDocumentoComExpiracao(objConn,tipoDocumento)
	sSQL = "SELECT CASE WHEN " & tipoDocumento & " IN (SELECT tar_codtipoarquivo  FROM tipoarquivo WHERE tar_docqual = 1 and tar_codtipoarquivo not in (7,20,18))  THEN 'SIM' ELSE 'NAO' END AS RESPOSTA"

	call Env.RecordSet(true, objRS, sSQL)
	if objRS("RESPOSTA") = "SIM" THEN
		ehDocumentoComExpiracao = TRUE
	ELSE
		ehDocumentoComExpiracao = FALSE
	END IF
end function 

'tira vbcrlf e outros caracteres para guardar no banco
function limpaTexto(str)
	str = replace(str,"\n",vbcrlf)
	str = replace(str,"'","")
	str = replace(str,chr(34),"")

	if str = "" then 
		str = "null"
	end if

	limpaTexto = str
end function

'Limpa caracteres vb em texto
function strToTexto(str)
	str = str & ""
	str = replace(str,vbnewline,"\n")
	str = replace(str,vbcrlf,"\n")
	str = replace(str,vbtab,"\n")
	str = replace(str,vbLf,"\n")
	str = replace(str,vbCr,"\n")
	strToTexto = str
end function

function PreparaStrSQL(str)
	PreparaStrSQL = replace(ssql, " ,", " null,")
	PreparaStrSQL = replace(PreparaStrSQL, ",,", ",null,")
	PreparaStrSQL = replace(PreparaStrSQL, "''", "null")
	PreparaStrSQL = replace(PreparaStrSQL, "'//'", "null")
	PreparaStrSQL = replace(PreparaStrSQL, ",,", ",null,")
	PreparaStrSQL = replace(PreparaStrSQL, ",0.00,", ",null,")
	PreparaStrSQL = replace(PreparaStrSQL, "'null'", "null")
	if right(PreparaStrSQL, 1) = "," then PreparaStrSQL = PreparaStrSQL & "null"
end function

function guardaHistoricoArquivo(objConn,CodigoArquivo,DataAlteracao,AcaoTomada,usuario)
	sSQL= "insert into HISTORICO_ARQUIVOS (HA_CODARQ,HA_USUARIO,HA_DATAATUALIZACAO,HA_ACAO) VALUES " & _
		  "(" & CodigoArquivo & ",'" & usuario & "',CONVERT(SMALLDATETIME,'" & DataAlteracao & "',103),'" & AcaoTomada & "')"
	call Env.RecordSet( true, objRS, sSQL)
end function

function apagaHistoricoArquivo(objConn, auxcodarquivo)
	sSQL= "delete from HISTORICO_ARQUIVOS where HA_CODARQ = " & auxcodarquivo 
	call Env.RecordSet( true, objRS, sSQL)
end function

function tiraPlicAspas(str)
	str = replace(str,"'","")
	str = replace(str,chr(34),"")	
	tiraPlicAspas = str
end function

'-- troco ' por "
function trocaPlic2Aspas(str)
	str = replace(str,"\n",vbcrlf)
	str = replace(str,"'","""")
	trocaPlic2Aspas = str
end function

Function TextoSituacao(pSituacao,objConn)
	sSQL = "Select s_descricao, s_mensagem from situacoes where id_situacao = " & pSituacao
	call Env.RecordSet( true, rs_situacao, sSQL)

	if rs_situacao.EOF then
		TextoSituacao = ""
	else
		TextoSituacao = rs_situacao("s_descricao")
	end if
End Function

'Funções herdadas do LogBook
'Não as alterarei, nem verificarei sua necessidade no momento em virtude do prazo para tornar-lo 
'ativo
Public Function PegaPalavra( Frase, QualCampo, Separador) 
	Dim i, j 
	Dim sFraseAux, sPalavra, sCampo 

	' Realiza as verificacoes e atribuicoes
	If QualCampo < 1 Then QualCampo = 1
		sFraseAux = Frase

	' Efetua captura
	For i = 1 To QualCampo
		j = InStr(1, sFraseAux, Separador, 1)
		If j > 0 Then
			sPalavra = Left(sFraseAux, j - 1)
			sFraseAux = Trim( Mid( sFraseAux, j + Len( Separador ) ) )
		Else
			sPalavra = sFraseAux
			sFraseAux = ""
		End If
	Next
	PegaPalavra = Trim( sPalavra )
End Function

'FUNÇÕES ENCONTRADAS NO ARQUIVO CONS_IND_PESQCR.ASP
'RELATIVAS A PESQUISA DE SATISFAÇÃO
function retornaaprox(opcao)
	dim auxint,auxdec,auxnum
	opcao = "0" & opcao
	auxnum=cdbl(opcao)
	auxint=int(opcao)
	auxdec=cint((auxnum-auxint)*100)

	if len(auxdec)=1 then
		auxdec=left(auxdec,1)&"0"
	end if
	if len(auxdec)=0 then
		auxdec=auxdec&"00"
	end if

	retornaaprox=auxint&","&auxdec
end function

function retornaopcao(opcao)
	if opcao=1 then retornaopcao="Muito Insatisfeito" end if
	if opcao=2 then retornaopcao="Insatisfeito" end if 
	if opcao=3 then retornaopcao="Nem Satisfeito, Nem Insatisfeito" end if
	if opcao=4 then retornaopcao="Satisfeito" end if
	if opcao=5 then retornaopcao="Muito Satisfeito" end if
	if Isnull(opcao) then retornaopcao="Não Respondido" end if
end function

function retornaopcao1(opcao)
	if opcao<3 then retornaopcao1="<img width=15 height=15 src='img/smile3.gif'>" end if
	if (opcao>=3 and opcao<4) then retornaopcao1="<img width=15 height=15 src='img/smile2.gif'>" end if
	if opcao>=4 then retornaopcao1="<img width=15 height=15 src='img/smile1.gif'>" end if
end function


function retornacomentario(comenta)
	if Isnull(comenta) or comenta="" then retornacomentario="Sem Coment." else retornacomentario="Comentário: "&comenta end if
end function

Function DescOs(objConn, agnumero)
	Dim objRS, sSQL

	sSQL = "select t_titulo from testes t inner join Ordem_de_Servico e on e.t_id = t.t_id where ag_numero =  " & agnumero
	call Env.RecordSet( true, objRS, sSQL)
		str = "-"
		while objRS.eof = false
			str = str & "-" & objRS("t_titulo")
			objRS.movenext
		wend
		str = str & "-"
	call Env.RecordSet( false, objRS, null)
End Function

FUNCTION toFloat(str1)
dim buf
	if instr(str1,",") > 0 then
		buf = replace(str1,",","%")
		buf = replace(buf,".","")
		buf = replace(buf,"%",".")
	end if
toFloat = buf
end function


'-- Verifica a existencia de arquivos no agendamento
Function TemArquivo(objConn, agnumero)
	Dim objRS, sSQL

	sSQL = "SELECT COUNT(AG_NUMERO) as cont FROM Diagramas WHERE AG_NUMERO = " & agnumero
	call Env.RecordSet( true, objRS, sSQL)
	if objRS(0) > 0 then TemArquivo = True else TemArquivo = False
	call Env.RecordSet( false, objRS, null)
End Function

'-- Gera uma lista dos ambientes do agendamento
Function AmbienteAS(objConn, ag_numero, separador)
	dim objRS, s
	s = "SELECT a.AMB_NOME FROM Reserva_Ambientes ra INNER JOIN Ambientes a " & _
		"ON ra.AMB_ID = a.AMB_ID WHERE ra.RAM_AS = " & ag_numero & " ORDER BY a.AMB_NOME"
	call Env.RecordSet(true, objRS, s)
	AmbienteAS = ""
	if not (objRS.Eof and objRS.Bof) then
		while not objRS.Eof
			AmbienteAS = AmbienteAS & objRS(0)
'response.write AmbienteAS & "<BR>"
			objRS.MoveNext
			if not objRS.Eof then AmbienteAS = AmbienteAS & " " & separador
		wend
		AmbienteAS = Trim(AmbienteAS)
	end if
	call Env.RecordSet(false, objRS, null)
'response.end
End Function


Function MontaAgendamentosDoDia(W)
	Dim SQL
	Dim chr_Buf
	Dim RS
	Dim chr_Class
	Dim i

	SQL = _
		"SELECT A.AG_NUMERO, A.AG_SIGILO, A.AG_USERNAME, A.AG_TITULO, A.AG_RAT, A.AG_RESPONSAVEL, (SELECT COUNT(D.AG_NUMERO) as cont FROM Diagramas D WHERE D.AG_NUMERO = A.AG_NUMERO) AS TEM_ARQUIVO, TA_DESCRICAO, TS_DESCRICAO " & _
		"FROM vw_Agendamento A WHERE ID_SITUACAO = " & AS_Em_Execucao & " " & _
		"ORDER BY AG_NUMERO DESC"

	Call Env.RecordSet(True, RS, SQL)

	If W = "" Then W = "100%"

	chr_Buf = _
			"<table width='" & W & "' class='texto' cellpadding='2' cellspacing='0' border='0'>" & VbCrLf & _
			"<tr><td height='7px'></td></tr>" & VbCrLf

	If (RS.Eof And RS.Bof) Then
		chr_Buf = chr_Buf & "<tr><td class='texto' align='center'>Nenhum agendamento em Execução hoje</td></tr>"
	Else
		i = 1
		While Not RS.Eof
			If i mod 2 = 0 Then chr_Class = "texto" Else chr_Class = "Azul1Bg"

			'<td>RAT:&nbsp;" & RS("AG_RAT") & "&nbsp;/&nbsp;RT:&nbsp;" & RS("AG_RESPONSAVEL") & "&nbsp;</td></tr>"
			chr_Buf = chr_Buf & _
				"<tr valign='top' class='" & chr_Class & "'>" & VbCrLf & _
				"	<td valign='top' align='center' width='30px'><b><a class='texto' style='color: #999999;' href='#' title='Veja este agendamento'>" & RS("AG_NUMERO") & "</a></b></td>" & VbCrLf & _
				"	<td width='*'>" & VbCrLf

			If RS("AG_SIGILO") = 1 Then
				chr_Buf = chr_Buf & _
					"		<img align='absmiddle' src='img/Iccadeado.gif' title='Este agendamento possui sigilo de resultado' border=0>&nbsp;" & VbCrLf
			End If
			If RS("TEM_ARQUIVO") > 0 Then
			'If TemArquivo(Env.oConn, RS("AG_NUMERO")) > 0 Then
				chr_Buf = chr_Buf & _
					"		<img src='img/icnote.gif' title='Este agendamento possui arquivo(s) anexo(s)'>&nbsp;" & VbCrLf
			End If

			chr_Buf = chr_Buf & "		<b>" & RS("AG_TITULO") & "</b>" & VbCrLf

			If Not VVVN(RS("TA_DESCRICAO")) Then
				chr_Buf = chr_Buf & " - " & RS("TA_DESCRICAO") & "" & VbCrLf
			End If

			If Not VVVN(RS("TS_DESCRICAO")) Then
				chr_Buf = chr_Buf & " - " & RS("TS_DESCRICAO") & "" & VbCrLf
			End If

			chr_Buf = chr_Buf & _
				"		<br> Solicitante: " & Ucase(RS("AG_USERNAME")) & " - RT: " & Ucase(RS("AG_RESPONSAVEL")) & "" & VbCrLf & _
				"	</td>" & VbCrLf & _
				"	<td width='180px'>" & AmbienteAS(Env.oConn, RS("AG_NUMERO"), ", ") & "&nbsp;</td>" & VbCrLf & _
				"</tr>" & VbCrLf & _
				"<tr><td height='5px'></td></tr>" & VbCrLf
			RS.MoveNext
			i = i + 1
		WEnd
	End If

	Call Env.RecordSet(False, RS, SQL)

	chr_Buf = chr_Buf & "</table>"

	MontaAgendamentosDoDia = chr_Buf
End Function


Function MostraDadoSigiloso(int_Sigilo, chr_Username)
	Dim chr_UserLogado
	Dim bln_EhCRT

	MostraDadoSigiloso = False

	bln_EhCRT = Env.UsuarioCRTVisivel
	chr_UserLogado = UCase(Env.Usuario)
	chr_Username = UCase(Trim(chr_Username))

	'### DEBUG ###
'	int_sigilo = 1 : 	bln_EhCRT = False : 	chr_UserLogado = "ADAO" : 	chr_Username = "CORDOVA"

	'é sigiloso mas o solicitante é o usuario logado
	If (int_Sigilo > 0 And chr_UserLogado = chr_Username) Or _
			bln_EhCRT Or _
			(int_Sigilo = 0) Or _
			EhGerenteDeEquipeEBT(chr_Username) _
	Then
		MostraDadoSigiloso = True
	End If
			'(chr_UserLogado = "ADAO" And (chr_Username = "ADAO" Or chr_Username = "CORDOVA" Or chr_Username = "CESAREI" Or chr_Username = "JOAOJ" Or chr_Username = "NALDOP" Or chr_Username = "GASAFER" Or chr_Username = "BORDALO" Or chr_Username = "RMMELLO"))
End Function


'###
'	Verifica se um usuario nao CRT é um gerente de uma equipe. Caso seja, permite o acesso do mesmo aos dados
'	dos agendamentos de sua equipe
'###
Function EhGerenteDeEquipeEBT(chr_UserResponsavelAS)
	Dim RS
	Dim bln_EhCRT, chr_UserLogado

	bln_EhCRT = Env.UsuarioCRT
	chr_UserLogado = UCase(Env.Usuario)

	EhGerenteDeEquipeEBT = False

	If (Not bln_EhCRT) And (chr_UserLogado <> "") And (chr_UserResponsavelAS <>  "") Then
		Set RS = Env.oConn.Execute("SELECT COUNT(*) FROM EquipeEmbratel WHERE UserId_Gerente = '" & chr_UserLogado & "' AND UserId_Membro = '" & chr_UserResponsavelAS & "'")
		If Not RS.Eof Then
			If RS(0) > 0 Then
				EhGerenteDeEquipeEBT = True
			End If
		End If
		Set RS = Nothing
	End If
End Function


Function ExibeMensagemSigiloAS(int_Border)
	Dim chr_Buf

	chr_Buf = VbCrLf & _
		"<table border='" & int_Border & "' width='100%' cellpadding='2' cellspacing='1' class='texto1'>" & VbCrLf & _
		"<tr>" & VbCrLf & _
		"	<td align='left'>" & VbCrLf & _
		"		&nbsp;<img align='absmiddle' src='img/Iccadeado.gif' border=0>&nbsp;" & VbCrLf & _
		"		<B>O Teste é Sigiloso. Se desejar uma consulta a este(s) documento(s) envie um e-mail para <a href='mailto:ilab@embratel.com.br'>ilab@embratel.com.br</b></a-->&nbsp;" & VbCrLf & _
		"	</td>" & VbCrLf & _
		"</tr>" & VbCrLf & _
		"</table>" & VbCrLf

	ExibeMensagemSigiloAS = chr_Buf
End Function

%>
