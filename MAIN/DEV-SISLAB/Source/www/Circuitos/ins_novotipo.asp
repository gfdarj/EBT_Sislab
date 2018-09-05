<!--#include file="../includes/Sislab_Lib.asp"-->
<!--#include file="../includes/PadraoHTML.asp" -->
<!--#include file="../includes/global.asp" -->
<!--#include file="../includes/controlesHTML.asp" -->
<%
Response.Addheader "Expires","Mon, 26 Jul 1997 05:00:00 GMT"
Response.Addheader "Cache-Control","no-cache, must-revalidate"
Response.Addheader "Pragma","no-cache"

dim objSP, objConn, s, ret, tipo
tipo = request.form("novotipo")
if tipo <> "" then

	call Env.StoredProcedure( true, objSP, "SP_FAC_CADASTRA_TIPO_COMPONENTE")
	with( objSP )
		.Parameters.Append( .CreateParameter( "RETORNO", adInteger, adParamReturnValue ) )
		.Parameters.Append( .CreateParameter( "@tpcNome", adVarchar, adParamInput, 50, tipo ) )
		.Parameters.Append( .CreateParameter( "@ftcID", adInteger, adParamInput, , request.form("familia") ) )
		.Parameters.Append( .CreateParameter( "@fabID", adInteger, adParamInput, , request.form("fabricante") ) )
		.execute()
		ret = .Parameters( "RETORNO" )
	end with
	call Env.StoredProcedure(false, objSP, "SP_FAC_CADASTRA_TIPO_COMPONENTE")
%>
	<html><script language="JavaScript"><%
	if ret > 0 then%>
		window.parent.opener.location = "sel_tipocomponentes.asp?tipo=<%=ret%>";
		window.parent.close();
<%else%>
		alert("Ocorreu um erro ao gravar este tipo de componente. (<%=ret%>)");	
		window.close();	<%
	end if
%></script></html><%
end if
%>
