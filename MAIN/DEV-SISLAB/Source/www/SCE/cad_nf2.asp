<!--#INCLUDE FILE="../includes/conexao.inc" -->
<!--#include file="includes/abre.asp"-->
<!--#include file="includes/bib_bd.asp"-->
<%
Dim objSP

nf_id = request("nf_id")
if nf_id = "" then nf_id = null
num = request("nf_numeronota")
if num = "" then num = null
qtde = request("nf_qtdevolumes")
if qtde = "" then qtde = null
valor = request("nf_valortotal")
If valor = "" Then
    valor = null 
Else
    valor = Replace(Replace(valor, ".", ""), ",", ".")
    valor = Replace(valor, ".", ",")
End If
'response.Write valor
'response.End
data_emissao = request("diaemissao") & "/" & request("mesemissao") & "/" & request("anoemissao")
nconhecimento = request("nf_nconhecimento")
if nconhecimento = "" then nconhecimento = null
tiponota = request("nf_tipo")
trans_id = request("trans_id")
if trans_id = "" then trans_id = null
enf_id = request("enf_id")
if enf_id = "" then enf_id = null
no_id = request("no_id")
if no_id="" then no_id = null
cfop = request("nf_cfop")
if cfop = "" then cfop = null
nf_id_pai = request("nf_id_pai")
if nf_id_pai = "" then nf_id_pai = null else nf_id_pai = cint(nf_id_pai)
validade = request("nf_validade")
if validade = "" then validade = null
data_recebimento = request("diarecebimento") & "/" & request("mesrecebimento") & "/" & request("anorecebimento")
data_real = request("diareal") & "/" & request("mesreal") & "/" & request("anoreal")
aceite = request("aceite")
if aceite="" then aceite = null
integridade = request("integridade")
if integridade="" then integridade = null
carta = request("carta")
if carta = "" then carta = null
volume = request("volume")
if volume = "" then volume = null
devolucao = request("devolucao")
if devolucao = "" then devolucao = "0"
descriminacao = trim(replace(ucase(request("descriminacao")),"'",""""))
if descriminacao = "" then descriminacao = null

Call StoredProcedure(True, objSP, "sp_SCE_CADASTRA_NOTAFISCAL", Conn)
With objSP
	.Parameters.item("@nf_id").Value = nf_id
	.Parameters.item("@nf_numeronota").Value = num
	.Parameters.item("@nf_qtdevolumes").Value = qtde
	.Parameters.item("@nf_valortotal").Value = valor
	.Parameters.item("@nf_dataemissao").Value = data_emissao
	.Parameters.item("@nf_nconhecimento").Value = nconhecimento
	.Parameters.item("@nf_tipo").Value = tiponota
	.Parameters.item("@trans_id").Value = trans_id
	.Parameters.item("@enf_id").Value = enf_id
	.Parameters.item("@nf_descriminacao").Value = descriminacao
	.Parameters.item("@nf_aceite").Value = aceite
	.Parameters.item("@nf_integridade").Value = integridade
	.Parameters.item("@nf_carta").Value = carta
	.Parameters.item("@nf_volume").Value = volume
	.Parameters.item("@nf_devolucaocompleta").Value = devolucao
	.Parameters.item("@nf_cfop").Value = cfop
	.Parameters.item("@no_id").Value = no_id
	.Parameters.item("@nf_id_pai").Value = nf_id_pai
	.Parameters.item("@nf_validade").Value = validade
	.Parameters.item("@nf_data").Value = data_real
	.Parameters.item("@nf_recebimento").Value = data_recebimento
	.Parameters.item("@user_id").Value = session("user_id")
	on error resume next
	.Execute
	on error goto 0
	If IsNull(.Parameters.item("@nf_id").Value) Then
		nf_id = ""
	Else
		nf_id = Cstr(.Parameters.item("@nf_id").Value)
	End If
End With
Call StoredProcedure(False, objSP, "sp_SCE_CADASTRA_NOTAFISCAL", Conn)

If conn.Errors.Count > 0 Or nf_id = "" Or IsNull(nf_id) Then
	Call erroDB (conn.Errors, "")
else
	response.redirect "cad_nf.asp?msg=1&nf_id=" & nf_id
End If
conn.close
set conn = nothing
%>