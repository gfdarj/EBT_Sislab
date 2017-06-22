<!--#include file="../includes/Sislab_Lib.asp"-->
<!--#include file="../includes/PadraoHTML.asp" -->
<!--#include file="../includes/global.asp" -->
<!--#include file="../includes/controlesHTML.asp" -->
<%
Response.Addheader "Expires","Mon, 26 Jul 1997 05:00:00 GMT"
Response.Addheader "Cache-Control","no-cache, must-revalidate"
Response.Addheader "Pragma","no-cache"

dim objSP, objConn, ret, familia, fabricante
familia = request.form("novafamilia")
fabricante = request.form( "fabricante" )
if familia <> "" then

	call Env.StoredProcedure( true, objSP, "SP_FAC_CADASTRA_FAMILIA_TIPO_COMPONENTE")
	with( objSP )
		.Parameters.Append( .CreateParameter( "RETORNO", adInteger, adParamReturnValue ) )
		.Parameters.Append( .CreateParameter( "@ftcNome", adVarchar, adParamInput, 200, familia ) )
		.execute()
		ret = .Parameters( "RETORNO" )
	end with
	call Env.StoredProcedure( false, objSP, "SP_FAC_CADASTRA_FAMILIA_TIPO_COMPONENTE")
%>
	<html><script language="JavaScript"><%
	if ret > 0 then%>
		window.parent.opener.location = "novotipo.asp?familia=<%=ret%>&fabricante=<%=fabricante%>";
		window.parent.close();
<%else%>
		alert("Ocorreu um erro ao gravar esta família. (<%=ret%>)");	
		window.close();	<%
	end if
%></script></html><%
end if
%>
