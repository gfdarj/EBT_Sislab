<!--#include file="includes/controlesHTML_SCE.asp" -->
<!--#include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="includes/padraoHTML.asp"-->
<!--#include file="includes/abre.asp"-->
<!--#include file="includes/global_SCE.asp"-->
<%
call ImprimeCabecalho ("", MENU_ON, true, "Administração de Itens", "", "history.go(-1);")
%>
<script language=javascript>
	<!--#include file="includes/vform.js"-->
	<!--#include file="includes/montacnpj.inc"-->
	<!--#include file="includes/estado.asp"-->
</script>
<form name="formulario" method="post" action="cad_acess_mod.asp" onSubmit="vdform('formulario','notafiscal','Nota Fiscal','Number', 'documento','Documento','Number'); return document.ValorPassou;">
<input type=hidden name=busca value=1>
<table width="780px" class="texto">
	<tr>
		<td>
<%		if request("msg") <> "" then
			if request("msg") = 1 then response.write " Ítem incluído com sucesso!"
			if request("msg") = 2 then response.write " Ítem alterado com sucesso!"
			if request("msg") = 3 then response.write " Ítem excluído com sucesso!"
			if request("msg") = 4 then response.write " É necessário selecionar algum campo de busca!"
			if request("msg") = 5 then response.write " Já existe equipamento cadastrado com este código de barras!"
			response.write "<BR><BR>"
		end if%>
		</td>
	</tr>
	<tr><td  valign="middle" class="titulo">Selecione o Item:</td></tr>
	<tr><td>&nbsp;</td></tr>
	<tr>
		<td>
			Código Barras:&nbsp;<input type="text" class="form" name="codbarras" size="25">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			Localiza&ccedil;&atilde;o:&nbsp;<input type="text" class="form" name="localizacao" size="25">
		</td>
	</tr>
	<tr><td>&nbsp;</td></tr>
	<tr>
		<td class="texto">
		Plataforma: <%call comboServicosPlataformas("plataforma", conn, "N", "P")%>
		</td>
	</tr>
	<tr><td>&nbsp;</td></tr>
	<tr>
		<td class="texto">
		Fabricantes:&nbsp;
		<%call comboBDSQL( "fabricante", conn, "select fab_id as VALOR, fab_nome as DESCRICAO from sce_fabricantes order by fab_nome", "", "N")%>
		</td>
	</tr>
	<tr><td>&nbsp;</td></tr>
	<tr>
		<td>
			<table cellpadding="0" cellspacing="0" class="texto">
			<tr>
				<td>Modelo:&nbsp;<input type=text name=modelo class=form></td>
				<td width="40px">&nbsp;</td>
				<td>Descri&ccedil;&atilde;o:&nbsp;<input type="text" name="desc_modelo" class="form" size="30"></td>
			</tr>
			</table>
		</td>
	</tr>
	<tr class="texto"><td>&nbsp;</td></tr>

	<tr class="texto">
		<td>Família Tipo:&nbsp;<%call comboBDSQL( "idtipo", conn, "select TIPO_ID as VALOR, tipo_descricao as DESCRICAO from sce_tipos order by tipo_descricao", "", "N")%>
	</td>

	<tr class="texto"><td>&nbsp;</td></tr>
	<tr>
		<td class="texto">
			Fornecedor:&nbsp;
			<%call comboFornecedor("enf_id", conn, "", "N", "FORNECEDOR", false)%>
		</td>
	</tr>
	<tr class="texto"><td>&nbsp;</td></tr>
	<TR class="texto">
		<td>
			<table cellpadding="0" cellspacing="0" class="texto" width="100%">
			<tr>
				<td>Nota Fiscal:&nbsp;<input type="text" class="form" name="notafiscal" size="10"></td>
				<td width="10px">&nbsp;</td>
				<td>Documento:&nbsp;<input type="text" class="form" name="documento" size="7" maxlength="10"></td>
				<td width="10px">&nbsp;</td>
				<td>Registro/Certificado/CDE/RMA:&nbsp;<input type="text" class="form" name="cde_equip" size="7"></td>
				<td width="10px">&nbsp;</td>
				<td>Número de Série:&nbsp;<input type="text" class="form" name="numeroserie" maxlength="100"></td>
			</tr>
			</table>
		</td>
	</TR>
	<tr class="texto"><td>&nbsp;</td></tr>

<!--
	<TR class="texto">
		<td>
			<table cellpadding="0" cellspacing="0" class="texto">
			<tr>
				<td>Nota Fiscal:&nbsp;<input type="text" class="form" name="notafiscal" size="10"></td>
				<td width="30px">&nbsp;</td>
				<td>CDE (Movimentação):&nbsp;<input type="text" class="form" name="cde" size="7"></td>
			</tr>
			</table>
		</td>
	</TR>
-->
	<tr class="texto"><td>&nbsp;</td></tr>

	<TR class="texto">
		<td>
			<table cellpadding="0" cellspacing="0" class="texto">
			<tr>
				<td><%Call ComboInstrumental("instrumental", true)%></td>
				<td width="40px">&nbsp;</td>
				<td><%Call ComboConforme("conforme", true)%></td>
				<td width="40px">&nbsp;</td>
				<td><%Call ComboSituacaoEq("status", true, true, true, STATUS_EM_ESTOQUE)%></td>
				<td width="40px">&nbsp;</td>
				<td><%Call ComboPropriedadeEq("propriedade", true)%></td>
			</tr>
			</table>
		</td>
	</tr>
	<tr class="texto"><td>&nbsp;</td></tr>
	<tr>
		<td class="texto" align="right">
			<input type="submit" name="buscar" value="próximo &gt;&gt;" class="form">
<%if session("status") <> PERFIL_RAT then%>
			&nbsp;&nbsp;
			<input type="submit" name="buscar" value="cadastrar consumivel" class="form" onClick="f();">
			<script>
				function f(){
					document.formulario.action="cad_acess_item.asp?categoria=C";
					document.formulario.submit();
				}
			</script>
<%end if%>
		</td>
	</tr>
  </table>
</form>
<%
conn.close
set conn=nothing
call ImprimeRodape (RODAPE_OFF)
%>
