<!--#include file="../includes/Sislab_Lib.asp"-->
<!--#include file="../includes/PadraoHTML.asp" -->
<!--#include file="../includes/global.asp" -->
<!--#include file="../includes/controlesHTML.asp" -->
<%
Response.Addheader "Expires","Mon, 26 Jul 1997 05:00:00 GMT"
Response.Addheader "Cache-Control","no-cache, must-revalidate"
Response.Addheader "Pragma","no-cache"

dim novacarac, objSP, objConn, s, ret, tipo
novacarac = UCase(request.form("novacarac"))
definicao = Server.HtmlEncode( request.form("definicao") )

if definicao = "" then definicao = null
if novacarac <> "" then

	call Env.StoredProcedure( true, objSP, "SP_FAC_CADASTRA_CARACTERISTICA")
	with( objSP )
		.Parameters.Append( .CreateParameter( "RETORNO", adInteger, adParamReturnValue ) )
		.Parameters.Append( .CreateParameter( "@carNome", adVarchar, adParamInput, 50, novacarac ) )
		.Parameters.Append( .CreateParameter( "@carDefinicao", adVarchar, adParamInput, 5000, definicao ) )
		.execute()
		ret = .Parameters( "RETORNO" )
	end with
	call Env.StoredProcedure( false, objSP, "SP_FAC_CADASTRA_CARACTERISTICA")

%><script type="text/javascript"><%
	if ret > 0 then%>
		window.parent.opener.ad_novo("<%=novacarac%>", "<%=ret%>");
		window.parent.close();
<%else%>
		alert("Ocorreu um erro ao gravar esta caracteristica. (<%=ret%>)");	
		window.close();	<%
	end if
%></script><%
end if
%>
