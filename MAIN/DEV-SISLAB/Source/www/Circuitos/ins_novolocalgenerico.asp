<!--#include file="../includes/Sislab_Lib.asp"-->
<!--#include file="../includes/PadraoHTML.asp" -->
<!--#include file="../includes/global.asp" -->
<!--#include file="../includes/controlesHTML.asp" -->
<%
Response.Addheader "Expires","Mon, 26 Jul 1997 05:00:00 GMT"
Response.Addheader "Cache-Control","no-cache, must-revalidate"
Response.Addheader "Pragma","no-cache"

dim objSP, objConn, s, ret, tipo, local
local = request.form("novolocal")
tipo = request.form("tipo")

call Env.StoredProcedure( true, objSP, "SP_FAC_CADASTRA_LOCAL_GENERICO")
with( objSP )
	.Parameters.Append( .CreateParameter( "RETORNO", adInteger, adParamReturnValue ) )
	.Parameters.Append( .CreateParameter( "@lgeNome", adVarchar, adParamInput, 50, local ) )
	.Parameters.Append( .CreateParameter( "@lgeTipo", adVarchar, adParamInput, 1, tipo ) )
	.execute()
	ret = .Parameters( "RETORNO" )
end with
call Env.StoredProcedure( false, objSP, "SP_FAC_CADASTRA_LOCAL_GENERICO")
%>
<html><script type="text/javascript"><%
if ret > 0 then%>
	window.parent.opener.location = "sel_localgenerico.asp?local=<%=ret%>";
	window.parent.close();<%
else%>
	alert("Ocorreu um erro ao gravar este local. (<%=ret%>)");	
	window.close();	<%
end if
%>
</script></html>
