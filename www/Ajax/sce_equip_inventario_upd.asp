<!--#include file="../includes/Sislab_Lib.asp"-->
<!--#include file="../includes/global.asp"-->
<!--#include file="../includes/funcoes.asp"-->
<%
'#####
'#	Atualiza o inventário do equipamento com a data de hoje
'###
If Not VVVNZ(Request("eq_id")) Then
	Dim RS

	Set RS = Env.oConn.Execute( _
		"SET NOCOUNT ON; " & VbCrLf & _
		"UPDATE SCE_Equipamentos SET EQ_DT_ULT_INVENTARIO = " & IIf(Request("limpar") <> "S", "GETDATE()", "NULL") & " " & VbCrLf & _
		"WHERE EQ_ID = " & Request("eq_id") & "; " & VbCrLf & _
		"SELECT convert(varchar, getdate(), 103) + ' ' + LEFT(convert(varchar, getdate(), 108),5) AS DiaHora;" & VbCrLf _
	)
	If Not (RS.Eof And RS.Bof) Then
		If Request("limpar") <> "S" Then Response.Write(RS(0)) Else Response.Write("")
	End If

	Set RS = Nothing
End If
%>

