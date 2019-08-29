<!------- SCE ------->
<!--#include file="includes/SCE_Lib.asp"-->
<%
Dim s, rec

if request("mod_id") <> "" then
	s = "select MOD_PARTNUMBER from SCE_modelos where MOD_ID = " & request("mod_id") & " "

	Set rec = Env.oConn.execute(s)
	If Not (rec.Eof And rec.Bof) Then
%>
<script type="text/javascript">
	window.parent.document.all.txtPN.value = '<%=rec(0)%>';
</script>
<%
	Else
%>
<script type="text/javascript">
	window.parent.document.all.txtPN.value = '';
</script>
<%
	End If
End If
%>