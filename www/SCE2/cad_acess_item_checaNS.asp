<!------- SCE ------->
<!--#include file="includes/SCE_Lib.asp"-->
<%
Dim s, rec

if request("numeroserie") <> "" then
	s = "select COUNT(*) from SCE_Equipamentos where EQ_NUMEROSERIE = '" & request("numeroserie") & "' "

	If request("eq_id") <> "" Then
		s = s & " AND EQ_ID <> " & request("eq_id")
	End If

	Set rec = Env.oConn.execute(s)
	If rec(0) > 0 Then
%>
<script language="JavaScript">
	alert('Este número de série já está cadastrado.');
</script>
<%			'--Nao tem prazo
	else%>
<script language="JavaScript">
	alert('Número de série OK.');
</script>
<%
	end if
end if
%>