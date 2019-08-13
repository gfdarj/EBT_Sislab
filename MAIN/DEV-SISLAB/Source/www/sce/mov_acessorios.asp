<!------- SISLAB ---->
<!--#include file="../includes/bib_str.asp"-->
<!--#inc lude file="../includes/padraoHTML.asp"-->
<!------- LIB ------->
<!--#include file="../Classes/Classe_Sce.asp"-->
<!------- SCE ------->
<!--#include file="includes/SCE_Lib.asp"-->
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
Dim arrEq
Dim eq : eq = ""
Dim eqAnt : eqAnt = ""
Dim Sce

Set Sce = New TSce

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
arrEq = Split(request("eq_id"), ",")
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
	solicitante = Sce.ResponsavelAS(ag_numero)
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
		set rec = Env.oconn.execute(ssql)
		'-- monto um quadro de aviso, contendo os equips e os acessorios
		if not (rec.eof and rec.bof) then
			msg =	"<table width='600px' align='center' style='border: thin red solid;'>" + _
					"<tr><th style='border-bottom: thin red solid;'>Existem acessórios do item em uso ou no estoque !</th></tr>" + _
					"<tr><td>&nbsp;</td></tr>" + _
					"<tr><td>Para realizar a esta movimentação, é necessário fazer devolução do acessório no cadastro do item. Clique nos itens abaixo para alterá-los</td></tr>" + _
					"<tr><td>" + _
						"<table width='100%'>" + _
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
'response.write "solicita: " & solicitante & "<BR><BR>"
'response.write "no tipo: " & no_tipo  & "<BR><BR>"
'response.write "cde: " & cde & "<BR><BR>"
'response.write "AS: " & ag_numero & "<BR><BR>"
'response.write "resreva: " & reserva & "<BR><BR>"
'response.write "nf: " & nf_id & "<BR><BR>"
'response.write "doc: " & doc_id & "<BR><BR>"
'response.end

Tela.SetNomeTela = "SCE > Movimentação > Item" : Tela.SetCaminhoRelativo = "../"

On Error Resume Next

Env.oConn.BeginTrans
If Err.number <> 0 Then Call Tela.MostraErroSqlRB()

'Grava os movimentos para os Equipamentos da Lista
For Each eq In arrEq

'RW eq & "<BR>"

    eqAnt = Request("eq_id" & eq) : eqAnt = IIf(VVVNZ(eqAnt), Null, eqAnt)

    Call Env.StoredProcedure(True, objSP, "sp_SCE_CADASTRA_MOVIMENTACAO")
    With objSP
	    .Parameters.item("@mov_id").Value = mov_id
	    .Parameters.item("@eq_id").Value = eq
	    .Parameters.item("@mov_data").Value = data
	    .Parameters.item("@no_id").Value = no_id
	    .Parameters.item("@mov_despachante").Value = Env.Usuario
	    .Parameters.item("@mov_solicitante").Value = solicitante
	    .Parameters.item("@tipo").Value = no_tipo '-- OBS 1
	    .Parameters.item("@cde").Value = cde
	    .Parameters.item("@ag_numero").Value = ag_numero
	    .Parameters.item("@reserva").Value = reserva
	    .Parameters.item("@nf_id").Value = nf_id
	    .Parameters.item("@doc_id").Value = doc_id
	    .Parameters.item("@mov_passagem").Value = 0
	    .Parameters.item("@amb_id").Value = localizacao
	    .Parameters.item("@fl_calibracao").Value = fl_calibracao
	    .Parameters.item("@eq_codigobarrasanterior").Value = eqAnt
	    .Parameters.item("@usuario_log").Value = Env.Usuario
	    .Execute

        If Err.number <> 0 Then Call Tela.MostraErroSqlRB()

    End With
    Call Env.StoredProcedure(False, objSP, "sp_SCE_CADASTRA_MOVIMENTACAO")
    If Err.number <> 0 Then Call Tela.MostraErroSqlRB()
Next

Env.oConn.CommitTrans
If Err.number <> 0 Then Call Tela.MostraErroSqlRB()

If request("retornar_para") <> "" Then
	response.redirect request("retornar_para")
Else
	if request("mov_id") = "" then  '-- nova movimentacao
		response.redirect "mov_acessorio.asp?msg=1"
	else	'-- alteracao de uma movimentacao
		response.redirect "sel_mov_acessorio.asp?alterouOK=1&mov_id=" & request("mov_id")
	end if
End If
%>
