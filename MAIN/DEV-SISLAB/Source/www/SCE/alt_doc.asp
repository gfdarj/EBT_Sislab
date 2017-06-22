<!-- #include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="includes/padraoHTML.asp"-->
<!-- #INCLUDE FILE="includes/abre.asp" -->
<!--#include file="includes/bib_str.asp"-->
<%
call ImprimeCabecalho ("", MENU_ON, true, "Consulta de Documentos", "", "history.go(-1);")
%>
<script>
	<!--#include file="includes/vform.js"-->
</script>
<form method=post action="alt_doc2.asp" name="formulario">
<table width="100%">
	<tr>
		<td class="texto">
		<%if request("msg")<>"" then 
			if cint(request("msg")) = 1 then response.write "<br><strong>Documento alterado com sucesso!</strong><br><br>"
			if cint(request("msg")) = 2 then response.write "<br><strong>Documento excluído com sucesso!</strong><br><br>"
		end if%></td>
	</tr>
   <tr>
	    <td class="titulo">Edição de Documentos</td>
  	</tr>
	<tr><td class="texto">&nbsp;</td></tr>
	<tr>
		<td valign="top" valign="middle" class="texto">
		<%ssql = "select * from sce_documentacao order by doc_id"
		set rec = conn.execute(ssql)
		if not rec.eof then%>
			<select name="doc_id" size="15" class="form" style="width:600">
			<%while not rec.eof%>
				<option value="<%=rec("doc_id")%>"><%=Zeros(rec("doc_id"),4)%> / Resp: <%=rec("doc_responsavel")%> / Cliente: <%=rec("DOC_NOME")%></option>
				<%rec.movenext
			wend%>
			</select>
		<%else
			response.write "Não Existe Documentação Cadastradas No Momento."
		end if%>
		</td>
    </tr>
	<tr><td class="texto">&nbsp;</td></tr>
	<tr>
	    <td  valign="middle" class="titulo"><input type=submit value=" Editar " class=form></td>
	</tr>
 </table>
 </form>
<%
conn.close
set conn=nothing
call ImprimeRodape (RODAPE_OFF)
%>
