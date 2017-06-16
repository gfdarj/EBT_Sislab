<!--#include file="includes/controlesHTML_SCE.asp" -->
<!--#include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="includes/padraoHTML.asp"-->
<!--#include file="includes/global_SCE.asp"-->
<!--#include file="includes/abre.asp"-->
<!--#include file="includes/bib_str.asp"-->

<script language=javascript>
	<!--#include file="includes/vform.js"-->
</script>
<%
Dim tipousuario : tipousuario = ""
if session("status") = PERFIL_ADM then tipousuario = " <span style='color:#800000;'>(Administrador)</span>"

call ImprimeCabecalho ("", MENU_ON, true, "Movimentação de Item" & tipousuario, "", "history.go(-1);")
%>
<script language="JavaScript">
function movimentaItens() {<%
'--
'-- Se for administrador pode fazer movimentos para qualquer tipo de situacao.
'-- Os não ADM´s só poderao fazer movimentacoes para itens com situacao atual selecionada
'-- por esta combo. Alem disso, as datas nesse caso serão as datas atuais
'--
if session("status") <> PERFIL_ADM then
%>	var d = document.forms[0];
	var ret = false;
	if (d.status.value == "") {
		alert("Selecione um tipo a ser movimentado.");
		d.status.focus();
	}
	else
		{ ret = true; }<%
else
%>	ret = true;<%
end if
%>	return ret;
}
</script>
<form name="formulario" method="post" action="mov_acessorio2.asp" onsubmit="javascript:return movimentaItens();">
<input type="hidden" name="busca" value="1">
 <table width="750px" class="texto">
	<tr><td><%if request("msg") <> "" then response.write " <strong><div align=center>Movimentação efetuada com sucesso.<br> Foi criado um histórico de movimentação com estes dados.</div></strong><br><br>"%></td></tr>
	<tr>
	    <td  valign="middle" class="titulo">Selecione o Ítem:</td>
	</tr>
	<tr><td>&nbsp;</td></tr>
	<tr><td><%if session("status") <> PERFIL_ADM then response.write "<b>"%>Movimentar os itens na<%Call ComboSituacaoEq("status", true, false, true, "")%><%if session("status") <> PERFIL_ADM then response.write "</b>"%></td></tr>
	<tr><td>&nbsp;</td></tr>
	<tr>
		<td> 
      		<table border="0" class="texto" cellpadding="0" cellspacing="0">
	  			<tr>
	    			<td class="texto" colspan="2">
						Código Barras:&nbsp;<input type="text" class="form" name="codbarras" style="width:120px" maxlength="50">
						<!--&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="Button" value=" Procurar " onclick="buscaCB()" class="form">-->
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						Plataforma: <%call comboServicosPlataformas("plataforma", conn, "N", "P")%>
					</td>
				</tr>

				<tr><td class="texto" colspan="2"><br></td></tr>

				<tr>
	    			<td class="texto">
						Fabricante:&nbsp;
						<%call comboBDSQL( "fabricante", conn, "select fab_id as VALOR, fab_nome as DESCRICAO from sce_fabricantes order by fab_nome", "", "N")%>
					</td>
					<td class="texto">
					Modelo:&nbsp;<input type="text" name="modelo" class="form" style="width:200px">
					</td>
				</tr>
				<tr>
					<td class="texto" colspan="2"><br></td>
				</tr>
				
				<tr>
					<td class=texto colspan=2>	
					Fornecedor				
<%call comboFornecedor("enf_id", conn, "", "N", "FORNECEDOR", false)%>
					</td>
				</tr>

				<tr><td class="texto">&nbsp;</td></tr>

				<tr>
					<td class="texto" width="50%" colspan="2">
					Nota Fiscal:&nbsp;<input type="text" class="form" name="notafiscal" size="20">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					Documento:&nbsp;<input type="text" class="form" name="documento" size="7" maxlength="10">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					CDE:&nbsp;<input type="text" class="form" name="cde" size="10">
					</td>
				</tr>

				<tr class="texto"><td>&nbsp;</td></tr>

				<tr>
	  				<td class="texto" colspan="3">
						N&deg; AS:&nbsp;<input type="text" class="form" name="as" size="10">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						Número de Série:&nbsp;<input type="text" class="form" name="numeroserie" maxlength="50">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						Localiza&ccedil;&atilde;o:&nbsp;<input type="text" class="form" name="localizacao" size="25" value="">
					</td>
				</tr>

				<tr>
					<td class="texto" colspan="3" align="right"><input type="submit" name="buscar" value="próximo &gt;&gt;" class="form"></td>
				</tr>
			</table>
      	</td>
    </tr>
  </table>
</form>

</center>
<%
conn.close
set conn=nothing
call ImprimeRodape (RODAPE_OFF)
%>
