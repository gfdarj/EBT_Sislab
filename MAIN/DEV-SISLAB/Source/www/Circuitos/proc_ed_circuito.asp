<!--#include file="includes/montatela.inc"-->
<!--#include file="includes/funcoesAux.inc"-->

<!--#include file="../includes/Sislab_Lib.asp"-->
<!--#include file="../includes/PadraoHTML.asp" -->
<!--#include file="../includes/global.asp" -->
<!--#include file="../includes/controlesHTML.asp" -->

<%
if( request.form( "cto_id" ) = "" or request.form( "cpt_id" ) = "" or request.form( "pos_nova_fac" ) = "" ) then
	response.redirect( "circuitos.asp" )
end if

dim objConn, objSP, ret, ret2, tmp

call Env.StoredProcedure( true, objSP, "SP_FAC_CADASTRA_FACILIDADE")
with( objSP )
	.Parameters.Append( .CreateParameter( "RETORNO", adInteger, adParamReturnValue ) )
	.Parameters.Append( .CreateParameter( "@ctoID", adInteger, adParamInput, , request.form( "cto_id" ) ) )
	.Parameters.Append( .CreateParameter( "@cptID", adInteger, adParamInput, , request.form( "cpt_id" ) ) )
	.Parameters.Append( .CreateParameter( "@intID", adInteger, adParamInput, , request.form( "interface" ) ) )
	.Parameters.Append( .CreateParameter( "@facOrdem", adTinyInt, adParamInput, , request.form( "pos_nova_fac" ) ) )
	.execute()
	ret = .Parameters( "RETORNO" )
end with
call Env.StoredProcedure( false, objSP, "SP_FAC_CADASTRA_FACILIDADE")

if( ret < 0 ) then
	call ErroBD( "Nao foi possivel inserir a nova facilidade (" & ret & ")" )
end if

for each tmp in request.form
	if( isnumeric( cstr( tmp ) ) and request.form( tmp ) <> "" ) then
		call Env.StoredProcedure( true, objSP, "SP_FAC_CADASTRA_REL_CARACTERISTICAS_FACILIDADES")
		with( objSP )
			.Parameters.Append( .CreateParameter( "RETORNO", adInteger, adParamReturnValue ) )
			.Parameters.Append( .CreateParameter( "@carID", adInteger, adParamInput, , tmp ) )
			.Parameters.Append( .CreateParameter( "@tpcID", adInteger, adParamInput, , request.form( "tpc_id" ) ) )
			.Parameters.Append( .CreateParameter( "@facID", adInteger, adParamInput, , ret ) )
			.Parameters.Append( .CreateParameter( "@rcfIdentCaract", adVarChar, adParamInput, 255, request.form( tmp ) ) )

			.execute()
			ret2 = .Parameters( "RETORNO" )
		end with
		call Env.StoredProcedure( false, objSP, "SP_FAC_CADASTRA_REL_CARACTERISTICAS_FACILIDADES")

		if( ret2 < 0 ) then
			call ErroBD( "Nao foi possivel inserir a caracteristica para a facilidade " & ret & " (" & ret2 & ")" )
		end if
	end if
next
response.redirect( "ed_circuito.asp?cto_id=" & request.form( "cto_id" ) )
%>