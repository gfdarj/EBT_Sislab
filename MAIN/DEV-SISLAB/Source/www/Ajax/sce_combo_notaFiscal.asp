<!--#include file="../includes/Sislab_Lib.asp"-->
<!--#include file="../sce/includes/Global_SCE.asp"-->
<%
'###
'###	AJAX DA COMBO DE NATUREZA DE OPERAÇÃO NA TELA DE MOVIMENTAÇÃO DO SCE
'###
Dim sBuf

Response.Clear()

'# Evitar problemas com acentuação no ajax
Response.Charset = Application("SISLAB_CHARSET")

'#####
'#	Fornecedor SCE
'###
sBuf = sBuf & "<option value=''>--</option>"

Dim RS
Dim sSQL
Dim tipo, id_fornecedor

tipo = CStr(UCase(Request("tipo")))
id_fornecedor = UCase(Request("fornecedor"))

sSQL = ""
where = "WHERE 1 = 1"

If tipo = CStr(NF_ENTRADA) Then
	where = where & " AND NF_TIPO = " & NF_ENTRADA
ElseIf tipo = CStr(NF_SAIDA) Then
	where = where & " AND NF_TIPO = " & NF_SAIDA
End If

if Not VVVNZ(id_fornecedor) then
	where = where & " AND e.ENF_ID = " & id_fornecedor & " "
end if

sSQL =	"select nf_id as VALOR, CAST(nf.nf_numeronota as VARCHAR) + " & _
		"' - ' + e.enf_nome as DESCRICAO from sce_nota_fiscal nf inner join " & _
		"sce_empresa_nota_fiscal e on e.enf_id = nf.enf_id " & where & " " & _
		"order by nf.nf_numeronota"

Set RS = Env.oConn.Execute(sSQL)

If Not (RS.Eof And RS.Bof) Then
	While Not RS.Eof
		sBuf = sBuf & "<option value='" & RS("VALOR") & "'>" & RS("DESCRICAO") & "</option>"
		RS.MoveNext
	WEnd
Else
End If

Set RS = Nothing

Response.Write(ssql)
Response.Write(sBuf)
%>
