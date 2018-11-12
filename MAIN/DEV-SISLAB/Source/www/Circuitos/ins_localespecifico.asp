<%Option explicit%>
<!--#include file="../includes/Sislab_Lib.asp"-->
<!--#include file="../includes/PadraoHTML.asp" -->
<!--#include file="../includes/global.asp" -->
<!--#include file="../includes/controlesHTML.asp" -->
<%
Response.Addheader "Expires","Mon, 26 Jul 1997 05:00:00 GMT"
Response.Addheader "Cache-Control","no-cache, must-revalidate"
Response.Addheader "Pragma","no-cache"

dim objSP, objConn, ret
dim s, objRS

call Env.StoredProcedure( true, objSP, "SP_FAC_CADASTRA_LOCAL_ESPECIFICO")
with( objSP )
	.Parameters.Append( .CreateParameter( "RETORNO", adInteger, adParamReturnValue ) )
	.Parameters.Append( .CreateParameter( "@lgeID", adInteger, adParamInput, , request.form("localgenerico") ) )
	.Parameters.Append( .CreateParameter( "@leeNome", adVarchar, adParamInput, 50, request.form("local") ) )
	.execute()
	ret = .Parameters( "RETORNO" )
end with
call Env.StoredProcedure( false, objSP, "SP_FAC_CADASTRA_LOCAL_ESPECIFICO")

%><script language="JavaScript">
	var str='';
	str += '<font class="Fonttit3Cad"><b>Locais Espec&iacute;ficos:</b></font><br>';
	str += '<select multiple name="locais" style="width: 200px;" size="6" >';
<%
if ret > 0 then
	s = "select e.LEE_ID, e.LEE_NOME from FAC_Locais_Especificos_Equip e "
	s = s & "where e.LGE_ID = " & request.form("localgenerico") & " order by e.LEE_NOME"
	call Env.RecordSet(true, objRS, s)
	while not objRS.EOF	%>
	str += '<option value="<%=objRS("LEE_ID")%>"><%=objRS("LEE_NOME")%></option>';<%
		objRS.MoveNext
	wend
	call Env.RecordSet(false, objRS, s)%>
	window.parent.AtualizaLocais(str);<%
else%>
		alert("Ocorreu um erro ao inserir este local. (<%=ret%>)");<%
end if
%>
</script>
