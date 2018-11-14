<!--#include file="../includes/Sislab_Lib.asp"-->
<!--#include file="../includes/PadraoHTML.asp" -->
<!--#include file="../includes/global.asp" -->
<!--#include file="../includes/controlesHTML.asp" -->

<%
Response.Addheader "Expires","Mon, 26 Jul 1997 05:00:00 GMT"
Response.Addheader "Cache-Control","no-cache, must-revalidate"
Response.Addheader "Pragma","no-cache"

dim objSP, objConn, s, ret, lista_car, lista_qtd, tipo
tipo = request.form("tipocomponente")
lista_car = request.form("lista_car")
lista_qtd = request.form("lista_qtd")

call Env.StoredProcedure( true, objSP, "SP_FAC_ATUALIZA_REL_CARACTERISTICAS_TIPO")
with( objSP )
	.Parameters.Append( .CreateParameter( "RETORNO", adInteger, adParamReturnValue ) )
	.Parameters.Append( .CreateParameter( "@carIDs", adVarchar, adParamInput, 8000, lista_car ) )
	.Parameters.Append( .CreateParameter( "@rctQuants", adVarchar, adParamInput, 8000, lista_qtd ) )
	.Parameters.Append( .CreateParameter( "@tpcID", adInteger, adParamInput, , tipo ) )
	.execute()
	ret = .Parameters( "RETORNO" )
end with
call Env.StoredProcedure( false, objSP, "SP_FAC_ATUALIZA_REL_CARACTERISTICAS_TIPO")
%>
<html><script type="text/javascript"><%
if ret > 0 then%>
	alert( "Componente atualizado com sucesso." );
	window.parent.location = "sel_tipocomponentes.asp";<%
else%>
	alert("Ocorreu um erro ao gravar este tipo de componente. (<%=ret%>)");	
	window.close();	<%
end if
%>
</script></html>

