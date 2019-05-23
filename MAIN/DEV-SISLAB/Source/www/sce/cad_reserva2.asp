<!------- SCE ------->
<!--#include file="includes/SCE_Lib.asp"-->
<!------- SISLAB ---->
<!--#include file="../includes/bib_str.asp"-->
<%
'-- GRAVA OS DADOS DA RESERVA --
'Dim separador_campo : separador_campo = "¿?¿"
'Dim separador_registro : separador_registro = "»?«"

Dim operacao, id, ag_numero, ag_responsavel, ambiente, lista_itens, item, obs, aceito
Dim oErro, RS, lista_eqid

If Request("ehnovo") then 
	operacao = "cadastrou"  '-- pego valor no cad_reserva.asp
Else
	operacao = "alterou"
End If

ag_numero = Request("ag_numero")

ag_responsavel = Request("ag_responsavel")
if ag_responsavel = "" then ag_responsavel = "null" Else ag_responsavel = " UPPER('" & ag_responsavel & "')"

obs = request("obs")
if obs = "" then obs = "null" Else obs = "'" & obs & "'"


Env.oConn.BeginTrans

'On Error Resume Next

'### Grava a reserva
If Request("ehnovo") then 
	Call Env.oConn.Execute( _
		"INSERT INTO SCE_Reserva (AG_NUMERO, RES_RESPONSAVEL, RES_OBSERVACAO) " & _
		"	VALUES (" & ag_numero & ", " & ag_responsavel & ", " & obs & ")" _
	)
Else
	Call Env.oConn.Execute( _
		"UPDATE SCE_Reserva SET RES_RESPONSAVEL = " & ag_responsavel & " " & _
		"	,RES_OBSERVACAO = " & obs & " " & _
		"	WHERE AG_NUMERO = " & ag_numero & "" _
	)
End If

'Set oErro = Conn.Errors
'If oErro.Count > 0 Then
'	Conn.RollbackTrans
'	Call ErroDB(oErro, "")
'End If

lista_eqid = ""

'### Grava os itens da reserva
For Each item In Request("lista_itens")
'response.write item & "<BR>"

	lista_itens = Split(item, ",")

	lista_eqid = lista_eqid & lista_itens(0) & ","

	Set RS = Env.oConn.Execute("SELECT COUNT(*) AS Total FROM SCE_Reserva_Equipamentos WHERE AG_NUMERO = " & ag_numero & " AND EQ_ID = " & lista_itens(0))
	If Not RS.Eof Then
		If lista_itens(5) = "9" Then aceito = "NULL" Else aceito = lista_itens(5)

		If RS(0) = 0 Then
			Call Env.oConn.Execute( _
				"INSERT INTO SCE_Reserva_Equipamentos (AG_NUMERO, EQ_ID, REQ_DATAINICIO, REQ_DATATERMINO, REQ_EQSETUP, AMB_ID, REQ_ACEITO) " & _
				"	VALUES (" & ag_numero & ", " & lista_itens(0) & ", CONVERT(DATETIME, '" & lista_itens(1) & "', 103), CONVERT(DATETIME, '" & lista_itens(2) & "', 103), '" & lista_itens(3) & "', " & lista_itens(4) & ", " & aceito & ")" _
			)
		Else
			Call Env.oConn.Execute( _
				"UPDATE SCE_Reserva_Equipamentos " & _
				"SET REQ_DATAINICIO = CONVERT(DATETIME, '" & lista_itens(1) & "', 103) " & _
				"	,REQ_DATATERMINO = CONVERT(DATETIME, '" & lista_itens(2) & "', 103) " & _
				"	,REQ_EQSETUP = '" & lista_itens(3) & "'" & _
				"	,AMB_ID = " & lista_itens(4) & " " & _
				"	,REQ_ACEITO = " & aceito & " " & _
				"WHERE AG_NUMERO = " & ag_numero & " AND EQ_ID = " & lista_itens(0) _
			)
		End If

'		Set oErro = Conn.Errors
'		If oErro.Count > 0 Then
'			Conn.RollbackTrans
'			Call ErroDB(oErro, "")
'		End If
	End If

'debug------
'	For i = 0 to UBound(lista_itens)
'		response.write lista_itens(i) & " <--> "
'	Next
'	response.write " <br> "
Next

'response.write lista_eqid
'response.end

'Apago os equipamentos que não estao na lista
If Len(lista_eqid) > 0 Then
	lista_eqid = Left(lista_eqid, Len(lista_eqid)-1)

	Call Env.oConn.Execute("DELETE FROM SCE_Reserva_Equipamentos WHERE AG_NUMERO = " & ag_numero & " AND EQ_ID NOT IN (" & lista_eqid & ")")
End If

Env.oConn.CommitTrans

On Error Goto 0

Response.Redirect "cad_reserva.asp?ag_numero=" & ag_numero & "&" & operacao & "=1"

'response.End




'#### CODIGO ANTIGO USANDO A PROCEDURE !!!

'response.write "lista_itens: " & lista_itens & "<BR><BR>Len:"
'response.write len(lista_itens) & "<BR>"
'response.write ag_numero & "<BR>"
'response.write ag_responsavel & "<BR>"
'response.write "" & ambiente & "<BR>"
'response.write lista_itens
'response.end


'########################################################################################
' Acrescentei o campo ambiente na tabela de reserva de equipomentos, logo tenho que
' mudar a procedure. Como isso não é possível por enquanto, tenho que mudar a gravação.
'
'											Gilberto (19/09/2010)
'########################################################################################
'ag_numero = request("ag_numero")
'if ag_numero = "" then ag_numero = null
'ag_responsavel = request("ag_responsavel")
'if ag_responsavel = "" then ag_responsavel = null
'ambiente = request("amb_id")
'if ambiente = "" then ambiente = null
'obs = request("obs")
'if obs = "" then obs = null

'-- pega a lista de itens (campos separados por "¿!¿" e separa cada registro concatenando
'-- em uma string passada ao banco de dados
'if request("lista_itens") = "" then
'	lista_itens = null
'else
'	lista_itens = ""
'	for each item in request("lista_itens")
'		lista_itens = lista_itens + item + separador_registro
'	next
'	lista_itens = UCase(Left(lista_itens, Len(lista_itens)-3))
'end if

'Call StoredProcedure(True, objSP, "sp_SCE_CADASTRA_RESERVA", Conn)
'With objSP
'	.Parameters.item("@AG_NUMERO") = ag_numero
'	.Parameters.item("@RES_RESPONSAVEL") = ag_responsavel
'	.Parameters.item("@AMB_ID") = ambiente
'	.Parameters.item("@LISTA_ITENS") = lista_itens
'	.Parameters.item("@OBSERVACAO") = obs
'	on error resume next
'	.Execute
'	on error goto 0
'End With
'Call StoredProcedure(False, objSP, Null, Null)

'If conn.Errors.Count > 0 Then
'	Call erroDB (conn.Errors, "")
'else
'	response.redirect "cad_reserva.asp?ag_numero=" & ag_numero & "&" & operacao & "=1"
'End If
%>