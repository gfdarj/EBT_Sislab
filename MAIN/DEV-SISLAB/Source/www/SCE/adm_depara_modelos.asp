<!-- #include file="includes/controlesHTML_SCE.asp" -->
<!-- #include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="includes/padraoHTML.asp"-->
<%
Dim ObjConn

Call Connection(true, ObjConn)
call ImprimeCabecalho ("", MENU_ON, true, "Administração de Dados - De/Para de Modelos", "", "history.go(-1);")
%>
<form method="post" action="adm_depara_modelos2.asp" name="formulario" onsubmit="javascript:return executaDePara(this);">
<table width="100%" class="texto">
<%
if request("msg")<>"" then%>
<tr>
	<td colspan="2"><b>
<%	if request("msg") = "1" then
		response.write "Modelos atualizados com sucesso !"
	end if
%>		</b>
	</td>
</tr>
<tr><td colspan="2">&nbsp;</td></tr><%
end if
%>
<tr>
	<td>
		Modelo antigo: (De)<br>
		<%call comboBDSQL( "mod_id_old", objConn, "select mod_id as VALOR, mod_codnome + ' - ' + f.fab_nome as DESCRICAO from sce_modelos m inner join sce_fabricantes f on m.fab_id = f.fab_id order by mod_codnome", valor, "N")%>
	</td>
	<td valign="middle" rowspan="3">
		<input class="form" type="submit" value="Executar !">
	</td>
</tr>
<tr><td>&nbsp;</td></tr>
<tr>
	<td>
		Modelo novo: (Para)<br>
		<%call comboBDSQL( "mod_id_new", objConn, "select mod_id as VALOR, mod_codnome + ' - ' + f.fab_nome as DESCRICAO from sce_modelos m inner join sce_fabricantes f on m.fab_id = f.fab_id order by mod_codnome", valor, "N")%>
	</td>
</tr>

</table>
</form>
<script language="JavaScript">
	d = document.forms[0];
	d.mod_id_old.size = 10;
	d.mod_id_new.size = 10;

	function executaDePara(d) {
		var ret = false;
		if( (d.mod_id_old.value == "") || (d.mod_id_new.value == "") )
			alert("Selecione os modelos !");
		else if(d.mod_id_old.value == d.mod_id_new.value )
			alert("Selecione modelos diferentes !");
		else {
			ret = true;
		}
		return ret;
	}
</script>
<%
Call Connection(false, ObjConn)
call ImprimeRodape (RODAPE_OFF)
%>
