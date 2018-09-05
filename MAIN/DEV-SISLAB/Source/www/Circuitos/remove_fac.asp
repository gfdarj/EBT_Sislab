<!--#include file="includes/montatela.inc"-->
<!--#include file="includes/funcoesAux.inc"-->

<!--#include file="../includes/Sislab_Lib.asp"-->
<!--#include file="../includes/PadraoHTML.asp" -->
<!--#include file="../includes/global.asp" -->
<!--#include file="../includes/controlesHTML.asp" -->

<%
if( request.querystring( "fac_id" ) = "" ) then
	response.redirect( "circuitos.asp" )
end if

dim objConn, objSP, ret

call Env.StoredProcedure( true, objSP, "SP_FAC_EXCLUI_FACILIDADE")
with( objSP )
	.Parameters.Append( .CreateParameter( "RETORNO", adInteger, adParamReturnValue ) )
	.Parameters.Append( .CreateParameter( "@facID", adInteger, adParamInput, , request.querystring( "fac_id" ) ) )

	.execute()
	ret = .Parameters( "RETORNO" )
end with
call Env.StoredProcedure( false, objSP, "SP_FAC_EXCLUI_FACILIDADE")

if( ret < 0 ) then
	call ErroBD( "Nao foi possivel remover uma facilidade (" & ret & ")" )
end if
response.redirect( "ed_circuito.asp?cto_id=" & request.querystring( "cto_id" ) )
%>