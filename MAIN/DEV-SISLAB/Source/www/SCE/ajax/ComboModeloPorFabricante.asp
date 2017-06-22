<!--#include file="../../global.asa" -->
<!--#include file="../../includes/Sislab_Lib.asp"-->
<%
Dim RS
Dim int_IdFab

int_IdFab = RQ("id_fab")

If Not VVVNZ(int_IdFab) Then
	Set RS = Env.oConn.Execute("select m.mod_id as VALOR, m.mod_codnome + ' - ' + CAST(m.mod_descricao as VARCHAR(100)) as DESCRICAO from sce_modelos m where fab_id = " & int_IdFab & " ORDER BY m.mod_codnome, m.mod_descricao")
	If Not RS.Eof Then
		While Not RS.Eof
			RW "<option value='" & RS("VALOR") & "'>" & RS("DESCRICAO") & "</option>"
			RS.MoveNext
		WEnd
	Else
		RW "<option value=''>--</option>"
	End If
Else
	RW "<option value=''>--</option>"
End If
%>