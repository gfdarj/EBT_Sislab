<!--#include file="includes/montatela.inc"-->
<!--#include file="includes/funcoesAux.inc"-->

<!--#include file="../includes/Sislab_Lib.asp"-->
<!--#include file="../includes/PadraoHTML.asp" -->
<!--#include file="../includes/global.asp" -->
<!--#include file="../includes/controlesHTML.asp" -->
<%
if( not( isNumeric( cstr( request.form( "cto_id" ) ) ) ) or request.form( "cto_nome" ) = "" ) then
	call ErroBD( "Foram fornecidos dados invalidos sobre o circuito" )
end if

dim objConn, objSP, ret

call Env.StoredProcedure( true, objSP, "SP_FAC_ATUALIZA_CIRCUITO")
with( objSP )
	.Parameters.Append( .CreateParameter( "RETORNO", adInteger, adParamReturnValue ) )
	.Parameters.Append( .CreateParameter( "@ctoID", adInteger, adParamInput, , request.form( "cto_id" ) ) )
	.Parameters.Append( .CreateParameter( "@ctoNome", adVarChar, adParamInput, 200, server.htmlencode( request.form( "cto_nome" ) ) ) )
	.Parameters.Append( .CreateParameter( "@tpcID", adInteger, adParamInput, , request.form( "tpc_id" ) ) )
	if( request.form( "cto_permanente" ) <> "" ) then
		.Parameters.Append( .CreateParameter( "@ctoPermanente", adInteger, adParamInput, , request.form( "cto_permanente" ) ) )
	else
		.Parameters.Append( .CreateParameter( "@ctoPermanente", adInteger, adParamInput, , null ) )
	end if
	.Parameters.Append( .CreateParameter( "@ctoAtivado", adInteger, adParamInput, , request.form( "cto_ativado" ) ) )

	.execute()
	ret = .Parameters( "RETORNO" )
end with
call Env.StoredProcedure( false, objSP, "SP_FAC_ATUALIZA_CIRCUITO")

if( ret < 0 ) then
	call ErroBD( "Nao foi possivel atualizar o circuito (" & ret & ")" )
else
	response.redirect( "ed_circuito.asp?cto_id=" & request.form( "cto_id" ) )
end if
%>

