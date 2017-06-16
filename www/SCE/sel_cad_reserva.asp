<!-- #include file="../includes/funcoes.asp" -->
<!-- #include file="includes/controlesHTML_SCE.asp" -->
<!-- #include file="../includes/global.asp" -->   <!-- constantes usada pelo menu -->
<!--#include file="includes/padraoHTML.asp"-->
<!--#include file="includes/abre.asp"-->
<!--#include file="includes/global_SCE.asp"-->
<%
'-- CAMPOS DE FILTRO PARA A SELECAO DE UMA RESERVA --
Dim nomeTela
if UCase(request("abrir_como")) = "REL" then _
	nomeTela = "Relatório de Reservas de Equipamentos" _
else _
	nomeTela = "Consulta Reservas de Equipamentos"

call ImprimeCabecalho ("", MENU_ON, true, nomeTela, "", "history.go(-1);")
%>
<script language=javascript>
	<!--#include file="includes/vform.js"-->
	<!--#include file="includes/montacnpj.inc"-->
	<!--#include file="includes/estado.asp"-->
</script>
<form name="formulario" method="post" action="sel_cad_reserva2.asp">
<input type="Hidden" name="abrir_como" value="<%=ucase(request("abrir_como"))%>">
<table width="750px" class="texto">
<tr>
	<td colspan="2">
<%		if request("msg") <> "" then
			if request("msg") = 1 then response.write " Reserva incluída com sucesso!"
			if request("msg") = 2 then response.write " Ítem alterada com sucesso!"
			if request("msg") = 3 then response.write " Reserva excluída com sucesso!"
			if request("msg") = 4 then response.write " É necessário selecionar algum campo de busca!"
			response.write "<BR><BR>"
		end if%>
	</td>
</tr>
<tr><td colspan="2" valign="middle" class="titulo">Selecione o Item:</td></tr>

<tr><td>&nbsp;</td></tr>

<tr>
	<td colspan="2">Agendamento:&nbsp;<%call comboAgendamento("txtAS", "ag_numero", conn, cstr(ag_numero), "N")%></td>
</tr>

<tr><td>&nbsp;</td></tr>

<tr>
	<td colspan="2">Respons&aacute;vel T&eacute;cnico:&nbsp;
		<%call comboBDSQL("ag_responsavel", conn, "select upper(USERID) as VALOR, CAST(NOME as VARCHAR(40)) as DESCRICAO from USERCRT where EXIBIR = 1 order by Nome", responsavel, "N")%>
	</td>
</tr>

<tr><td>&nbsp;</td></tr>

<tr>
	<td colspan="2">
		Per&iacute;odo:&nbsp;
		<%Call comboData("inicio")%>
		&nbsp;at&eacute;&nbsp;
		<%Call comboData("termino")%>
	</td>
</tr>

<tr><td>&nbsp;</td></tr>

<tr>
	<td>Código Barras:&nbsp;<input type="text" class="form" name="codbarras" size="25" maxlength="20"></td>
	<td class="texto">Fabricantes:&nbsp;
	<%call comboBDSQL( "fabricante", conn, "select fab_id as VALOR, fab_nome as DESCRICAO from sce_fabricantes order by fab_nome", "", "N")%>
	</td>
</tr>

<tr><td>&nbsp;</td></tr>

<tr>
	<td>Modelo:&nbsp;<input type="text" name="modelo" class="form"></td>
	<td>Descri&ccedil;&atilde;o:&nbsp;<input type="text" name="desc_modelo" class="form" size="50"></td>
</tr>

<tr><td>&nbsp;</td></tr>

<tr>
	<td colspan="2">
		<%Call ComboConforme("conforme", true)%>
		&nbsp;&nbsp;&nbsp;
		<%Call ComboSituacaoEq("status", true, true, true, "")%>
		&nbsp;&nbsp;&nbsp;
		<%Call ComboInstrumental("instrumental", true)%>
		&nbsp;&nbsp;&nbsp;
		<%Call ComboAmostraEq("amostra", true)%>
	</td>
</tr>

<tr><td>&nbsp;</td></tr>

<tr>
	<td>
		Número de Série:&nbsp;
		<input type="text" class="form" name="numeroserie" maxlength="50">
	</td>
	<td align="center">
		<%Call ComboPropriedadeEq("propriedade", True)%>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="submit" name="buscar" value="próximo &gt;&gt;" class="form">
	</td>
</tr>
</table>
</form>
<script language="JavaScript">document.formulario.txtAS.focus();</script>
<%
conn.close
set conn=nothing
call ImprimeRodape (RODAPE_OFF)
%>
