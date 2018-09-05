<!--#include file="includes/Abre.asp"-->
<%
Dim s, rec

if request("no_id") <> "" then
	s = "select PRAZO from SCE_Natureza_Operacao where no_id = " & request("no_id")
	Set rec = Conn.execute(s)
	if not (rec.eof and rec.bof) then
		if not IsNull(rec(0)) then
			'--Tem prazo
			if CBool(rec(0)) then%>
<script language="JavaScript">
	window.parent.document.all.tr_validade_separador.style.display = "block";
	window.parent.document.all.tr_validade.style.display = "block";
</script>
<%			'--Nao tem prazo
			else%>
<script language="JavaScript">
	window.parent.document.all.tr_validade_separador.style.display = "none";
	window.parent.document.all.tr_validade.style.display = "none";
	//window.parent.document.all.nf_validade.value = "";
</script>
<%			end if
		end if
	end if
end if
%>