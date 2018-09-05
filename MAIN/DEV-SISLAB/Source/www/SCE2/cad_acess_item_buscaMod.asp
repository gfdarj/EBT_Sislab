<!------- SCE ------->
<!--#include file="includes/SCE_Lib.asp"-->
<%
Dim s
Dim RS
Dim int_Conta
Dim chr_Descricao

if request("fab_id") <> "" then
	s = "select m.mod_id as VALOR, REPLACE(m.mod_codnome + ' - ' + CAST(RTRIM(LTRIM(REPLACE(REPLACE(REPLACE(m.mod_descricao, CHAR(9), ''), CHAR(13), '-'), CHAR(10), '-'))) as VARCHAR(60)), CHAR(13), '') as DESCRICAO from sce_modelos m where fab_id = " & Request("fab_id") & " ORDER BY m.mod_codnome, m.mod_descricao"

	Response.Write "<!--SQL: " & s & "-->"

	Set RS = Env.oConn.execute(s)
	If Not (RS.Eof And RS.Bof) Then
%>
<script language="JavaScript">
	var w = window.parent.document.all.mod_id;

	for (var i = w.options.length - 1; i >= 0; i--){
		w.options[i] = null;
	}

	w.options[0] = new Option('-- Escolha um Modelo --', '');
<%
		int_Conta = 1
		While Not RS.Eof
			If IsNull(RS(1)) Then chr_Descricao = "" Else chr_Descricao = RS(1)
			chr_Descricao = Trim(UCase(server.htmlencode(chr_Descricao)))
			chr_Descricao = Replace(chr_Descricao, "<BR>", "")
			chr_Descricao = Replace(chr_Descricao, VbCrLf, "")
%>
	w.options[<%=int_Conta%>] = new Option('<%=chr_Descricao%>', '<%=RS(0)%>');

<%			int_Conta = int_Conta + 1
			RS.MoveNext
		WEnd
%>
</script>
<%
	Else
%>
<script language="JavaScript">
	var w = window.parent.document.all.mod_id;

	for (var i = w.options.length - 1; i >= 0; i--){
		w.options[i] = null;
	}

	w.options[0] = new Option('-- Escolha um Modelo --', '');
</script>
<%
	End If
End If
%>