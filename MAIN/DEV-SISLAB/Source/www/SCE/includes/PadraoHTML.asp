<%
Dim width_princ : width_princ = 770
Dim w_princ : w_princ = width_princ & "px" '-- tamanho da coluna

sub ImprimeCabecalho(titulo, imprimeMenu, imprimeHeader, nomeTela, linkTela, onClickTela)

	'-- verifico se a sessao terminou
	If Session("user_id") = "" Then Response.Redirect "index.asp"

	Response.Addheader "Expires","Mon, 26 Jul 1997 05:00:00 GMT"
	Response.Addheader "Cache-Control","no-cache, must-revalidate"
	Response.Addheader "Pragma","no-cache"
	Response.Buffer = True
	Response.Expires = 0

	if IsEmpty(imprimeMenu) Or (imprimeMenu="") Then imprimeMenu = False
%>
<!--#include file="../includes/global_SCE.asp" -->
<html>
<head>
	<title>
<%	If titulo = "" Or IsEmpty(titulo) Then %>
		SCE - Sistema de Controle de Estoque [CRT]
<%	Else %>
		<%=titulo%>
<%	End If %>
	</title>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<link rel="stylesheet" href="css/estilo.css" type="text/css">
</head>

<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" border="0">

<!--
<table width="100%" cellspacing="1" cellpadding="0" border="1" id="tb_reserva" style="border: thin solid silver; overflow:auto;">
<tr>
	<td>
		<table width="2000px" cellpadding="0" cellspacing="0" class="texto" border="1" id="tb_reserva" style="border: thin solid silver; overflow:auto;">
		<tr>
			<td align="left" width="150px">Item</td>
			<td width="*" align="left">Descrição</td>
			<td width="85px">Data ini</td>
			<td width="85px">Data fim</td>
			<td width="110px">Eq. Setup</td>
			<td width="110px">Ambiente</td>
			<td width="55px" align="center">Aceito</td>
			<td width="20px"><img src="img/btn_branco.gif"></td>
		</tr>
		</table>
	</td>
</tr>
</table>
-->
<%	'response.end	%>

<!--<table width="<%'=w_princ%>" cellspacing="1" cellpadding="0" bgcolor="#FFFFFF" id="tbl_principal" style="border: none; display: block;">-->
<table width="100%" cellspacing="1" cellpadding="0" bgcolor="#FFFFFF" id="tbl_principal" style="border: none; display: block; overflow:auto;">
<tr>
	<td>
		<!--<table width="100%<%'=w_princ%>" cellspacing="0" cellpadding="0">-->
		<table width="100%" cellspacing="0" border="0" cellpadding="0">
		<tr><td></td><td></td></tr>

<%	if imprimeHeader then%>
		<map name="Map"> 
		  <area shape="rect" coords="671,18,741,46" href="http://pegasus" target="_top" alt="Site da Embratel" title="Site da Embratel">
		  <area shape="poly" coords="11,1" href="#">
		  <area shape="poly" coords="135,34" href="#">
		  <area shape="poly" coords="10,4,175,4,175,43,221,43,235,43,235,62,10,62,10,4" href="index2.asp" alt="P&aacute;gina Inicial" title="P&aacute;gina Inicial">
		</map>

		<!--<tr><td bgcolor="#FFFFFF" ><img src="../img/barra_superior_03.jpg" width="<%=w_princ%>" height="70" usemap="#Map" border="0"></td></tr>-->
		<tr>
			<td bgcolor="#FFFFFF" align="left"><img src="../sce/img/barra_titulo_1.jpg" height="70" border="0"></td>
			<td bgcolor="#FFFFFF" align="right"><img src="../sce/img/barra_titulo_2.jpg" height="70" border="0"></td>
		</tr>

<%	end if%>

        <tr id="tr_princ_cabecalho_separador1"><td colspan="2" bgcolor="#003366" height="1"></td></tr>

<%	if imprimeMenu then
		Dim base_dir : base_dir = "includes/menu"
		Dim frameTop : frameTop = 102
		Dim wdtCadastros : wdtCadastros = 150
		Dim wdtConsultas : wdtConsultas = 150
		Dim wdtRelatorios : wdtRelatorios = 260
		Dim wdtMovimentacao : wdtMovimentacao = 200

		Dim hgtCadastros : hgtCadastros = 185
		Dim hgtConsultas : hgtConsultas = 210
		Dim hgtRelatorios : hgtRelatorios = 250
		Dim hgtMovimentacao : hgtMovimentacao = 120

		if session("status") = PERFIL_LOG then
			hgtCadastros = 180
			hgtConsultas = 190
			hgtRelatorios = 180
		elseif session("status") = PERFIL_RAT then
			wdtCadastros = 100
			wdtConsultas = 100

			hgtCadastros = 25
			hgtConsultas = 40
			hgtMovimentacao = 40
			hgtRelatorios = 160
		end if
%>
	<script language="JavaScript" src="includes/menu/menu.js"></script>

	<!-- Cadastros-->
	<!--SEM O ITEM RESERVA !!! <iframe id="menuCadastros" frameBorder="0" style="position:absolute; left:44px; width:150px; top:<%'=frameTop%>px; height:170px; z-index:900; display: none;" onmouseout="javascript:testaMousePointer('cadastros');" src="<%'=base_dir%>/menu_cadastros.asp" marginheight="0" marginwidth="0"></iframe>-->
	<iframe id="menuCadastros" frameBorder="0" style="position:absolute; left:14px; width:<%=wdtCadastros%>px; top:<%=frameTop%>px; height:<%=hgtCadastros%>px; z-index:900; display: none;" onmouseout="javascript:testaMousePointer('cadastros');" src="<%=base_dir%>/menu_cadastros.asp" marginheight="0" marginwidth="0"></iframe>
	<!-- Consultas -->
	<iframe id="menuConsultas" frameBorder="0" style="position:absolute; left:140px; width:<%=wdtConsultas%>px; top:<%=frameTop%>px;  height:<%=hgtConsultas%>px; z-index:9; display: none;" onmouseout="javascript:testaMousePointer('consultas');" src="<%=base_dir%>/menu_consultas.asp" marginheight="0" marginwidth="0"></iframe>
	<!-- Relatorios -->
	<iframe id="menuRelatorios" frameBorder="0" style="position:absolute; left:262px; width:<%=wdtRelatorios%>px; top:<%=frameTop%>px;  height:<%=hgtRelatorios%>px; z-index:900; display: none;" onmouseout="javascript:testaMousePointer('relatorios');" src="<%=base_dir%>/menu_relatorios.asp" marginheight="0" marginwidth="0"></iframe>
	<!-- Movimentacao -->
	<iframe id="menuMovimentacao" frameBorder="0" style="position:absolute; left:387px; width:<%=wdtMovimentacao%>px; top:<%=frameTop%>px;  height:<%=hgtMovimentacao%>px; z-index:900; display: none;" onmouseout="javascript:testaMousePointer('movimentacao');" src="<%=base_dir%>/menu_movimentacao.asp" marginheight="0" marginwidth="0"></iframe>

	<tr id="tr_princ_cabecalho_menu">
		<td colspan="2" bgcolor="#FFFFFF" height="30"> 
			<table width="100%" border="0" cellspacing="0" cellpadding="2" height="30">
			<tr> 
				<td align="left" id="mnuCadastros" width="120px"><a href="#" onMouseOver="javascript:mostraMenuCadastros(true);"><font class="links">> Cadastros</a></td>
				<td align="left" id="mnuConsultas" width="120px"><a href="#" onMouseOver="javascript:mostraMenuConsultas(true);"><font class="links">> Consultas</a></td>
				<td align="left" id="mnuRelatorios" width="120px"><a href="#" onMouseOver="javascript:mostraMenuRelatorios(true);"><font class="links">> Relat&oacute;rios</a></td>
				<td align="left" id="mnuMovimentacao" width="120px"><a href="#" onMouseOver="javascript:mostraMenuMovimentacao(true);"><font class="links">> Movimenta&ccedil;&atilde;o</a></td>
    	        <td align="left" width="120px"><a href="../index.asp" class="links"><font class="links">> Sislab</a></td>
    	        <td align="left" width="*"><a href="index2.asp" class="links"><font class="links">> Início</a></td>
			</tr>
			</table>
		</td>
	</tr>
    <tr id="tr_princ_cabecalho_separador2"><td colspan="2" bgcolor="#003366" height="1"></td></tr>
<%	end if %>

<%	if nomeTela <> "" then%>
        <tr id="tr_princ_cabecalho_nometela">
			<td colspan="2" bgcolor="#F9F9F9">
			<%call ImprimeNomeTela(nomeTela, linkTela, onClickTela)%>
			</td>
	</tr>
        <tr id="tr_princ_cabecalho_separador3"><td colspan="2" bgcolor="#003366" height="1"></td></tr>
<%	end if%>
	</table>

	</td>
</tr>

<tr><td class="texto">&nbsp;</td></tr>
<tr valign="top" id="tr_princ_conteudo" style="display: block;">
	<td bgcolor="#ffffff" valign="top">
<!--		<div id="div_telaprincipal" style="width: <%'=width_princ-5%>; border: thin navy; overflow: hidden; display: block; margin-left: 5px;"> -->
		<div id="div_telaprincipal" style="overflow:auto;">
<%
' desabilitei o HEIGHT do DIV principal enquanto nao tivermos
' uma funcao para imprimir o conteudo deste DIV, pois indo para
' producao será necessario esta funcionalidade visto que os funcs
' utilizam muito a impressao das telas
' ==> para voltar a colocar o HEIGHT basta tirar o If abaixo e colocar
'     o valor "height: 310px" no style do div principal (acima)
	if false then %>
<script language="JavaScript">
	//testo a resolucao do video e altero o DIV de informações
	//var resolucao = screen.width + "x" + screen.height;
	//if (resolucao == "800x600") {
	//	document.all.div_telaprincipal.style.height = "310px";
	//}
	//if (resolucao == "1024x768") {
	//	document.all.div_telaprincipal.style.height = "480px";
	//}
</script><%
	end if
End Sub


'##################################################################################################
Sub ImprimeRodape(imprimeImagem)
	if IsEmpty(imprimeImagem) or (imprimeImagem="") then imprimeImagem = false%>
		</div>
	</td>
</tr>
<%	if imprimeImagem then%>
<map name="Map2"><area shape="rect" coords="682,2,766,15" href="http://www.coppetec.coppe.ufrj.br" alt="Funda&ccedil;&atilde;o COPPETEC" title="Funda&ccedil;&atilde;o COPPETEC" target="_blank"></map>
<tr valign="top" id="tr_princ_rodape" style="display: block;">
	<td><img src="../img/rodape/barra_inferior.jpg" width="<%=w_princ%>" height="18" usemap="#Map2" border="0"></td>
</tr>
<%	end if%>
</table>
</body>
</html><%
end sub


'##################################################################################################
Sub ImprimeNomeTela(nome, link, onClick)%>
<table width="100%" class="texto" bgcolor="#F9F9F9">
<tr>
	<td class="titulo"><span style="font-style: italic; font-weight: bold;"><%=nome%></span></td>
	<td align="right" class="titulo"><a href='<%if link = "" then response.write "#" else response.write link%>' <%if onClick <> "" then response.write "onClick='javascript:" & onClick & "'"%>><i>>> voltar</i></a>&nbsp;&nbsp;&nbsp;<a href="#"><img src="img/impressora.gif" border="0" onClick="imprimeConteudoSCE();" alt="Imprimir"></a></td>
</tr>
</table>
<script language="JavaScript">
	function imprimeConteudoSCE() {
		// Esconde o menu e o cabecalo do sistema deixando apenas a parte
		// do conteudo, chamando o metodo de impressao
		var undef;	var w;

//		document.all.tr_princ_cabecalho.style.display = "none";

		if(document.all.tr_princ_cabecalho_menu != undef)
			document.all.tr_princ_cabecalho_menu.style.display = "none";
		if(document.all.tr_princ_cabecalho_separador1 != undef)
			document.all.tr_princ_cabecalho_separador1.style.display = "none";
		if(document.all.tr_princ_cabecalho_separador2 != undef)
			document.all.tr_princ_cabecalho_separador2.style.display = "none";
		if(document.all.tr_princ_cabecalho_nometela != undef)
			document.all.tr_princ_cabecalho_nometela.style.display = "none";
		if(document.all.tr_princ_rodape != undef)
			document.all.tr_princ_rodape.style.display = "none";
	
		w = document.all.div_telaprincipal.style.width;
		document.all.div_telaprincipal.style.width = "640px";
	
		window.print();
	
		document.all.div_telaprincipal.style.width = w;
	
//		document.all.tr_princ_cabecalho.style.display = "block";

		if(document.all.tr_princ_cabecalho_menu != undef)
			document.all.tr_princ_cabecalho_menu.style.display = "block";
		if(document.all.tr_princ_cabecalho_separador1 != undef)
			document.all.tr_princ_cabecalho_separador1.style.display = "block";
		if(document.all.tr_princ_cabecalho_separador2 != undef)
			document.all.tr_princ_cabecalho_separador2.style.display = "block";
		if(document.all.tr_princ_cabecalho_nometela != undef)
			document.all.tr_princ_cabecalho_nometela.style.display = "block";
		if(document.all.tr_princ_rodape != undef)
			document.all.tr_princ_rodape.style.display = "block";
	}
</script>
<%
End Sub
%>
