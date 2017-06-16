<!--#include file="includes/Abre.asp"-->
<%
Dim s, rec

if request("mod_id") <> "" then
	s = "select PN_PARTNUMBER from SCE_PartNumberModelo where MOD_ID = " & request("mod_id") & " "

	Set rec = Conn.execute(s)
	If Not (rec.Eof And rec.Bof) Then
%>
<script language="JavaScript">
	window.parent.document.all.txtPN.value = '<%=rec(0)%>';
</script>
<%
	Else
%>
<script language="JavaScript">
	window.parent.document.all.txtPN.value = '';
</script>
<%
	End If
End If
%>