<!-- #include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="includes/padraoHTML.asp"-->
<!-- #INCLUDE FILE="includes/abre.asp" -->
<%
call ImprimeCabecalho ("", MENU_ON, true, "Consulta Notas Fiscais", "", "history.go(-1);")
%>
<script>
<!--#include file="includes/vform.js"-->
</script>
<table width="780">	
	<%ssql = "select * from sce_nota_fiscal where nf_numeronota = "& request("numeronota") 
	set rec = conn.execute(ssql)%>
	<tr>
		<td valign="top"  valign="middle" class=titulo><%=rec.recordcount%> nota(s) fiscal(is) encontrada(s)<br><br></td>
	</tr>
	<%if not rec.eof then
		while not rec.eof
			ssql = "select * from sce_empresa_nota_fiscal where enf_id = "& rec("enf_id")
			set rec2 = conn.execute(Ssql)
			if not rec2.eof then%>
				<tr>
					<td valign="top" valign="middle" class=texto>
						<a href=cad_nf.asp?nf_id=<%=rec("nf_id")%>><%=rec("nf_numeronota")%>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;<%=rec2("enf_cnpj")%>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;<%=rec2("enf_nome")%>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
<%				If rec("nf_tipo") = 1 Then
					Response.Write "Entrada"
				ElseIf rec("nf_tipo") = 2 Then
					Response.Write "Saída"
				Else
					Response.Write "&nbsp;"
				End If
%>						</a>
					</td>
				</tr>
			<%end if
			rec.movenext
		wend
	end if%>
</table>
<%
conn.close
set conn=nothing
call ImprimeRodape (RODAPE_OFF)
%>
