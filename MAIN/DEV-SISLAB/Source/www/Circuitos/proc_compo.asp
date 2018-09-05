<!--#include file="../includes/Sislab_Lib.asp"-->
<!--#include file="../includes/PadraoHTML.asp" -->
<!--#include file="../includes/global.asp" -->
<!--#include file="../includes/controlesHTML.asp" -->

<!--#include file="includes/funcoesAux.inc"-->
<%
dim objConn, objSP, strSQL, ret, lista_int, lista_qtd

lista_int = request.form("lista_int")
lista_qtd = request.form("lista_qtd")

if( request.form( "cpt_id" ) = "" ) then

	call Env.StoredProcedure( true, objSP, "SP_FAC_CADASTRA_COMPONENTE")
	with( objSP )
		.Parameters.Append( .CreateParameter( "RETORNO", adInteger, adParamReturnValue ) )
		.Parameters.Append( .CreateParameter( "@cptNome", adVarchar, adParamInput, 200, server.htmlencode( request.form( "cpt_nome" ) ) ) )
		.Parameters.Append( .CreateParameter( "@vsw_atu", adVarchar, adParamInput, 100, server.htmlencode( request.form( "vsw_atu" ) ) ) )
		.Parameters.Append( .CreateParameter( "@vsw_std", adVarchar, adParamInput, 100, server.htmlencode( request.form( "vsw_std" ) ) ) )
		.Parameters.Append( .CreateParameter( "@obs", adVarchar, adParamInput, 255, server.htmlencode( request.form( "obs" ) ) ) )
		.Parameters.Append( .CreateParameter( "@tpcID", adInteger, adParamInput, , request.form( "tpc_id" ) ) )
		.Parameters.Append( .CreateParameter( "@intIDs", adVarchar, adParamInput, 8000, lista_int ) )
		.Parameters.Append( .CreateParameter( "@intQuants", adVarchar, adParamInput, 8000, lista_qtd ) )
		.Parameters.Append( .CreateParameter( "@leeID", adInteger, adParamInput, , request.form( "lee_id" ) ) )
		if( request.form( "cpt_cod_sgp_sce" ) <> "" ) then
			.Parameters.Append( .CreateParameter( "@cptCodSGPSCE", adVarchar, adParamInput, 50, request.form( "cpt_cod_sgp_sce" ) ) )
		else
			.Parameters.Append( .CreateParameter( "@cptCodSGPSCE", adVarchar, adParamInput, 50, null ) )
		end if

		.execute
		ret = .Parameters( "RETORNO" )
	end with
	call Env.StoredProcedure( false, objSP, "SP_FAC_CADASTRA_COMPONENTE")
Else
	call Env.StoredProcedure( true, objSP, "SP_FAC_ATUALIZA_COMPONENTE")
	with( objSP )
		.Parameters.Append( .CreateParameter( "RETORNO", adInteger, adParamReturnValue ) )
		.Parameters.Append( .CreateParameter( "@cptID", adInteger, adParamInput, , request.form( "cpt_id" ) ) )
		.Parameters.Append( .CreateParameter( "@cptNome", adVarchar, adParamInput, 200, request.form( "cpt_nome" ) ) )
		.Parameters.Append( .CreateParameter( "@vsw_atu", adVarchar, adParamInput, 100, server.htmlencode( request.form( "vsw_atu" ) ) ) )
		.Parameters.Append( .CreateParameter( "@vsw_std", adVarchar, adParamInput, 100, server.htmlencode( request.form( "vsw_std" ) ) ) )
		.Parameters.Append( .CreateParameter( "@obs", adVarchar, adParamInput, 255, server.htmlencode( request.form( "obs" ) ) ) )
		.Parameters.Append( .CreateParameter( "@tpcID", adInteger, adParamInput, , request.form( "tpc_id" ) ) )
		.Parameters.Append( .CreateParameter( "@intIDs", adVarchar, adParamInput, 8000, lista_int ) )
		.Parameters.Append( .CreateParameter( "@intQuants", adVarchar, adParamInput, 8000, lista_qtd ) )
		.Parameters.Append( .CreateParameter( "@leeID", adInteger, adParamInput, , request.form( "lee_id" ) ) )
		if( request.form( "cpt_cod_sgp_sce" ) <> "" ) then
			.Parameters.Append( .CreateParameter( "@cptCodSGPSCE", adVarchar, adParamInput, 50, request.form( "cpt_cod_sgp_sce" ) ) )
		else
			.Parameters.Append( .CreateParameter( "@cptCodSGPSCE", adVarchar, adParamInput, 50, null ) )
		end if

		.execute
		ret = .Parameters( "RETORNO" )
	end with
	call Env.StoredProcedure( false, objSP, "SP_FAC_ATUALIZA_COMPONENTE")

end if

if( ret < 0 ) then
	call ErroBD( "Nao foi possivel adicionar o componente (-1)" )
else
	response.redirect( "index.asp" )
end if
%>
<%= lista_qtd %><br>
<%= lista_int %><br>
<%=ret%>

