<!-- #INCLUDE FILE="includes/conexao.inc" -->
<%
Response.Addheader "Expires","Mon, 26 Jul 1997 05:00:00 GMT"
Response.Addheader "Cache-Control","no-cache, must-revalidate"
Response.Addheader "Pragma","no-cache"

dim objSP, objConn, ret, fabricante, familia
fabricante = request.form("novofabricante")
familia = request.form("familia")
if fabricante <> "" then

	call Env.StoredProcedure( true, objSP, "SP_FAC_CADASTRA_FABRICANTE")
	with( objSP )
		.Parameters.Append( .CreateParameter( "RETORNO", adInteger, adParamReturnValue ) )
		.Parameters.Append( .CreateParameter( "@fabNome", adVarchar, adParamInput, 200, fabricante ) )
		.execute()
		ret = .Parameters( "RETORNO" )
	end with
	call StoredProcedure( false, objSP, "SP_FAC_CADASTRA_FABRICANTE")
%>
	<html><script language="JavaScript"><%
	if ret > 0 then%>
		window.parent.opener.location = "novotipo.asp?fabricante=<%=ret%>&familia=<%=familia%>";
		window.parent.close();
<%else%>
		alert("Ocorreu um erro ao gravar este fabricante. (<%=ret%>)");	
		window.close();	<%
	end if
%></script></html><%
end if
%>
