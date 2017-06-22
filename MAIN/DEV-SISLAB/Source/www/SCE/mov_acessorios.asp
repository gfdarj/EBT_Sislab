<!--#include file="../includes/conexao.inc"-->
<!--#include file="includes/abre.asp"-->
<!--#include file="includes/bib_str.asp"-->
<!--#include file="includes/bib_bd.asp"-->
<%
Dim data, rec, msg, eq_id
Dim no_id : no_id = ""
Dim nf_id : nf_id = ""
Dim doc_id : doc_id = ""
Dim solicitante : solicitante = ""
Dim cde : cde = ""
Dim ag_numero : ag_numero = ""
Dim reserva : reserva = ""
Dim no_tipo : no_tipo = ""
Dim mov_id : mov_id = ""
Dim localizacao : localizacao = ""

if request("diamov") <> "" and request("mesmov") <> "" and request("anomov") <> "" then
	if request("horaMov") <> "" and request("minutoMov") <> "" then
		data = request("diaMov") & "/" & request("mesMov") & "/" & request("anoMov") & " " & request("horaMov") & ":" & request("minutoMov") & ":00"
	else
		data = request("diaMov") & "/" & request("mesMov") & "/" & request("anoMov") & " " & CStr(Hour(Now)) & ":" & CStr(Minute(Now)) & ":00"
	end if
	data = CDate(data)
else
	data = Now()
end if

eq_id = request("eq_id")
ag_numero = request("ag_numero")
mov_id = request("mov_id")
localizacao = UCase(request("localizacao"))
fl_calibracao = Request("fl_calibracao")

if UCase(request("ehReserva")) = "SIM" then
	'-- vem do formulario SEL_CAD_RESERVA2_MOV.ASP onde estao selecionados os itens da reserva
	'-- para movimentacao

	no_tipo = MOV_LOGISTICA_SAIDA
	no_id = 524 ' LAB - Saída para teste c/ AS no laboratório
	ag_numero = request("ag_numero")
	solicitante = ResponsavelAS(Conn, ag_numero)
	reserva = 1
else
	'-- Se nao veio com o parametro da reserva, entao devo fazer as
	'-- verificacoes normais para este caso

	nf_id = request("nf_id")
	doc_id = request("doc_id")
	no_id = request("noid")
	no_tipo = request("notipo")
	solicitante = request("solicitante")
	cde = request("cde")
	reserva = 0

	'-- se for mov. do tipo expedicao entao verifica se existem acessorios do item
	'-- marcados como "em uso", caso tenha a movimentação nao pode ser feita
	if (no_tipo = MOV_EXPEDICAO) Or (no_tipo = MOV_EXPEDICAO_SUBST) then
		ssql = "select e.EQ_ID, e.EQ_CODIGOBARRAS, a.SEQUENCIAL, a.DESCRICAO, a.STATUS "
		ssql = ssql & "from SCE_Acessorios a inner join SCE_Equipamentos e on a.EQ_ID = e.EQ_ID "
		ssql = ssql & "where A.status <> " & STATUS_EXPEDIDO & " and e.eq_id in (" & request("eq_id") & ") "
		ssql = ssql & " AND A.status <> " & STATUS_EXPEDIDO_SUBST & " "
		ssql = ssql & "order by e.EQ_CODIGOBARRAS, a.SEQUENCIAL"
		set rec = conn.execute(ssql)
		'-- monto um quadro de aviso, contendo os equips e os acessorios
		if not (rec.eof and rec.bof) then
			msg =	"<table width='600px' align='center' class='texto' style='border: thin red solid;'>" + _
					"<tr><th style='border-bottom: thin red solid;'>Existem acessórios do item em uso ou no estoque !</th></tr>" + _
					"<tr><td>&nbsp;</td></tr>" + _
					"<tr><td>Para realizar a esta movimentação, é necessário fazer devolução do acessório no cadastro do item. Clique nos itens abaixo para alterá-los</td></tr>" + _
					"<tr><td>" + _
						"<table width='100%' class='texto'>" + _
						"<tr align='left'><th width='130px'>Cód. Barras</th><th>Acess&oacute;rio</th><th width='80px'>Status Acess.</th></tr>"
			eq_id = ""
			while not rec.eof
				if rec("STATUS") = STATUS_EM_USO then
					status = "Em Uso"
				elseif rec("STATUS") = STATUS_EM_ESTOQUE then
					status = "Em estoque"
				else
					status = "Expedido"
				end if

				if eq_id <> rec("EQ_ID") and eq_id <> "" then msg = msg + "<tr><td>&nbsp;</td></tr>"

				msg = msg + "<tr><td>"

				if eq_id <> rec("EQ_ID") then
					'msg = msg + "<a href='cad_acess_item.asp?eq_id=" & rec("EQ_ID") & "&categoria=E'>" & rec("EQ_CODIGOBARRAS") & "</a>"
					msg = msg + "<a href='#' onclick='javascript:window.open(""cad_acess_item.asp?eq_id=" & rec("EQ_ID") & "&categoria=E"", """", ""scrollbars=1, toolbar=0"");'>" & rec("EQ_CODIGOBARRAS") & "</a>"
				else
					msg = msg + "&nbsp;"
				end if
				msg = msg + "</td><td>" & rec("SEQUENCIAL") & " - " & rec("DESCRICAO") & "</td><td>" & status & "</td></tr>"

				eq_id = rec("EQ_ID")
				rec.MoveNext
			wend
			msg = msg + _
						"</table>"
			msg = msg + _
					"</td></tr>" + _
					"<tr><td>&nbsp;</td></tr>" + _
					"<tr><td align='center'><input type='Button' class='form' value='Voltar' onclick='javascript:history.go(-1);'>&nbsp;&nbsp;&nbsp;&nbsp;<input type='Button' class='form' value='Continuar' onclick='javascript:location.reload();'></td></tr>" + _
					"</table>"
			erroHtml(msg)
			Response.end
		end if
		rec.Close
	end if
	Set rec = nothing
end if

if no_tipo = "" then no_tipo = null
if no_id = "" then no_id = null
if nf_id = "" then nf_id = null
if doc_id = "" or doc_id = "0" then doc_id = null
if solicitante = "" then solicitante = null
if tipo = "" then tipo = null
if cde = "" then cde = null
if ag_numero = "" then ag_numero = null
if reserva = "" then reserva = null
if mov_id = "" then mov_id = null
If CStr(fl_calibracao) <> "1" Then fl_calibracao = Null


'response.write "mov_id: " & mov_id & "<BR><BR>"
'response.write "eq_id: " & request("eq_id") & "<BR><BR>"
'response.write "data: " & data & "<BR><BR>"
'response.write "no id: " & no_id & "<BR><BR>"
'response.write "user: " & session("user_id") & "<BR><BR>"
'response.write "solicita: " & solicitante & "<BR><BR>"
'response.write "no tipo: " & no_tipo  & "<BR><BR>"
'response.write "cde: " & cde & "<BR><BR>"
'response.write "AS: " & ag_numero & "<BR><BR>"
'response.write "resreva: " & reserva & "<BR><BR>"
'response.write "nf: " & nf_id & "<BR><BR>"
'response.write "doc: " & doc_id & "<BR><BR>"
'response.end

Call StoredProcedure(True, objSP, "sp_SCE_CADASTRA_MOVIMENTACAO", Conn)
With objSP
	.Parameters.item("@mov_id").Value = mov_id
	.Parameters.item("@lista_itens").Value = request("eq_id")
	.Parameters.item("@mov_data").Value = data
	.Parameters.item("@no_id").Value = no_id
	.Parameters.item("@mov_despachante").Value = session("user_id")
	.Parameters.item("@mov_solicitante").Value = solicitante
	.Parameters.item("@tipo").Value = no_tipo '-- OBS 1
	.Parameters.item("@cde").Value = cde
	.Parameters.item("@ag_numero").Value = ag_numero
	.Parameters.item("@reserva").Value = reserva
	.Parameters.item("@nf_id").Value = nf_id
	.Parameters.item("@doc_id").Value = doc_id
	.Parameters.item("@mov_passagem").Value = 0
	.Parameters.item("@eq_localizacao").Value = localizacao
	.Parameters.item("@fl_calibracao").Value = fl_calibracao
	on error resume next
	.Execute
	on error goto 0
End With
Call StoredProcedure(False, objSP, "sp_SCE_CADASTRA_MOVIMENTACAO", Null)

'-- OBS 1: Guardo o campo Tipo de NO para manter a compatibilidade com alguma
'--        tela do sistema que possa utilizar esta informacao vinda da tabela
'--        de movimentacao. O correto é pegar o valor da tabela SCE_Natureza_Operacao
'--        já que a tabela de movimento já possui uma FK para a tabela mencionada.




'================================================================
'	COMO NAO POSSO ALTERAR O BANCO, TENHO QUE ATUALIZAR PARA
'	O NOVO STATUS POR AQUI !!!
'
'		Gilberto - 12/03/2009
'================================================================
If CStr(no_tipo) = CStr(MOV_EXPEDICAO_SUBST) Then

	Dim a
	a = Split(request("eq_id"), ",")
	entra = False
	If UBound(a) > 0 Then
		For i = 0 To (UBound(a) -1)
			'-- pego a data da ultima movimentacao do item
			Set RS = Conn.Execute("SELECT MAX( m.MOV_DATA ) " & _
								"FROM SCE_Movimentacao m " & _
								"WHERE m.EQ_ID = " & a(i) )
			If RS.Eof and RS.Bof Then
				entra = True
			Else
				If data > RS(0) Then entra = True
			End If

			'-- se for a ultima movimentacao e for de expedicao, entao atualizo os acessorios do item
			If entra Then
				Conn.Execute("UPDATE SCE_Acessorios SET STATUS = 3 WHERE EQ_ID = " & a(i) )
			End If
		Next
	End If

	'Atualiza o status do item para o novo tipo
	Conn.Execute("UPDATE SCE_Equipamentos " & _
				"SET STATUS = " & STATUS_EXPEDIDO_SUBST & " " & _
				"WHERE EQ_ID IN (" & request("eq_id") & ") " )
End If
'================================================================




If conn.Errors.Count > 0 Then
	Call erroDB (conn.Errors, "")
else
	If request("retornar_para") <> "" Then
		response.redirect request("retornar_para")
	Else
		if request("mov_id") = "" then  '-- nova movimentacao
			response.redirect "mov_acessorio.asp?msg=1"
		else	'-- alteracao de uma movimentacao
			response.redirect "sel_mov_acessorio.asp?alterouOK=1&mov_id=" & request("mov_id")
		end if
	End If
End If
%>
