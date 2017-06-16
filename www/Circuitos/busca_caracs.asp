<!--#include file="../includes/Sislab_Lib.asp"-->
<!--#include file="../includes/PadraoHTML.asp" -->
<!--#include file="../includes/global.asp" -->
<!--#include file="../includes/controlesHTML.asp" -->
<!--#include file="../includes/bib_str.asp" -->
<!--#include file="includes/funcoesAux.inc"-->
<html>
<body>
<script language="JavaScript1.2">
window.parent.limpa_caracs();
window.parent.document.all.d_carac.style.display = "block";
<%
dim objConn, objRS, strSQL
if( cstr( request.querystring( "cpt_id" ) ) <> "" ) then
	strSQL = "select fac_tipo_componente.tpc_id, fac_caracteristicas.car_id, fac_caracteristicas.car_nome from fac_rel_caracteristicas_tipo " _
			& "inner join fac_tipo_componente on fac_rel_caracteristicas_tipo.tpc_id = fac_tipo_componente.tpc_id " _
			& "inner join fac_componentes on fac_tipo_componente.tpc_id = fac_componentes.tpc_id " _
			& "inner join fac_caracteristicas on fac_rel_caracteristicas_tipo.car_id = fac_caracteristicas.car_id " _
			& "where fac_componentes.cpt_id = " & request.querystring( "cpt_id" ) 

	call Env.RecordSet(true, objRS, strSQL)
	if( not( objRS.BOF and objRS.EOF ) ) then %>
window.parent.muda_tipo( "<%= objRS( "tpc_id" ) %>" );<%
		while( not( objRS.EOF ) ) %>
window.parent.ad_carac( "<%= objRS( "car_nome" ) %>", "<%= objRS( "car_id" ) %>" );<%
			objRS.MoveNext
		wend
	end if
	call Env.RecordSet(false, objRS, strSQL)
end if
%>
</script>
</body>
</html>

