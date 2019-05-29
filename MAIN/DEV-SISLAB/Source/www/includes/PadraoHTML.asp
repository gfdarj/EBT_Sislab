<%
'Dim w_princ : w_princ= "770px" '-- tamanho da coluna
Dim w_princ : w_princ= "100%" '-- tamanho da coluna

sub ImprimeCabecalho(titulo, imprimeMenu)
	Response.Addheader "Expires","Mon, 26 Jul 1997 05:00:00 GMT"
	Response.Addheader "Cache-Control","no-cache, must-revalidate"
	Response.Addheader "Pragma","no-cache"
	Response.Buffer = True
	Response.Expires=0

	dim w
	w = "785px" '-- tamanho da coluna
	if IsEmpty(imprimeMenu) or (imprimeMenu="") then imprimeMenu = false
%>
<!DOCTYPE html>

<HTML>

<head>
	<title>
<%	if titulo = "" or IsEmpty(titulo) then%>
		SISLAB<%If Application("SISLAB_AMBIENTE") <> "PRO" Then Response.write "[" & Application("SISLAB_AMBIENTE") & "]"%> - Site do Centro de Refer&ecirc;ncia Tecnol&oacute;gica
<%	else%>
		<%=titulo%>
<%	end if%>
	</title>

	<meta http-equiv="Content-Type" content="text/html;" charset="<%=Application("SISLAB_CHARSET")%>">
	<link rel="stylesheet" href="estilos/principal.css" type="text/css">
</head>

<map name="Map"> 
  <area shape="rect" coords="671,18,741,46" href="http://pegasus" target="_top" alt="Site da <%=Application("SISLAB_NOME_EMPRESA")%>" title="Site da <%=Application("SISLAB_NOME_EMPRESA")%>">
  <area shape="poly" coords="11,1" href="#">
  <area shape="poly" coords="135,34" href="#">
  <area shape="poly" coords="10,4,175,4,175,43,221,43,235,43,235,62,10,62,10,4" href="<%=retornaInicio()%>" alt="P&aacute;gina Inicial" title="P&aacute;gina Inicial">
</map>

<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" border="0">
<!--<table width="<%=w_princ%>" border="0" cellspacing="1" cellpadding="0" bgcolor="#FFFFFF" id="tbl_principal" style="border: none; display: block;">-->
<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#FFFFFF" id="Table1" style="border: none; display: block;">
<tr valign="top" id="tr_princ_cabecalho" style="display: block;">
	<td>
		<!--<table width="<%=w_princ%>" border="0" cellspacing="0" cellpadding="0">-->
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td bgcolor="#FFFFFF" background="img/barra_titulo6.gif" height="40" width="100%" align="left">
				<table border="0"  width="100%" cellpadding="0" cellspacing="0" height="100%">
				<tr valign="bottom">
					<td width="120px" align="right">&nbsp;</td>
					<td width="120px" >
						<b><a href="index.asp" ><span >SISLAB</span></a></b><br>
						Usu&aacute;rio: <%=Env.Usuario%>
					</td>
					<td width="245px" align="right">
						&nbsp;&nbsp;&nbsp;
<%
	'-- exibe a data por extenso em portugues
	Session.LCID = 1046
	Response.write FormatDateTime(Date(),vbLongDate)
%>
					</td>
					<td>&nbsp;</td>
				</tr>
				</table>
			</td>
		</tr>
		<!--<img src="img/barra_titulo.gif" width="<%=w_princ%>" height="40" usemap="#Map" border="0">-->

        <tr><td bgcolor="#003366" height="1"></td></tr>
<%	if imprimeMenu then
		Dim base_dir : base_dir = "includes/menu"
		Dim frameTop : frameTop = 72  '102
		Dim hgtCRT : hgtCRT = 160
		Dim wdtCRT : wdtCRT = 180
		Dim hgtRecursos : hgtRecursos = 87
		Dim wdtRecursos : wdtRecursos = 200
		Dim hgtServicos : hgtServicos = 210
		Dim wdtServicos : wdtServicos = 260
		Dim leftCRT : leftCRT = 11
		Dim leftRecursos : leftRecursos = 147
		Dim leftServicos : leftServicos = 294

		If Not Env.UsuarioCRT Then
			hgtCRT = 132
			hgtServicos = 170
			if not Env.UsuarioCRT_Cadastrado then hgtRecursos = 60

			leftCRT = 25
			leftRecursos = 196
			leftServicos = 383
		end if
%>
		<script language="JavaScript" src="includes/menu/menu.js"></script>
		<script language="JavaScript" src="includes/currency.js"></script>

		<!--Menu CRT-->
		<iframe id="menuCRT" frameBorder="0" style="position:absolute; left:<%=leftCRT%>px; width:<%=wdtCRT%>px; top:<%=frameTop%>px; height:<%=hgtCRT%>px; z-index:900; display: none;" onmouseout="javascript:testaMousePointer('crt');" src="<%=base_dir%>/menu_crt.asp" marginheight="0" marginwidth="0"></iframe>
		<!--Menu de Recursos-->
		<iframe id="menuRecursos" frameBorder="0" style="position:absolute; left:<%=leftRecursos%>px; width:<%=wdtRecursos%>px; top:<%=frameTop%>px;  height:<%=hgtRecursos%>px; z-index:9; display: none;" onmouseout="javascript:testaMousePointer('recursos');" src="<%=base_dir%>/menu_recursos.asp" marginheight="0" marginwidth="0"></iframe>
		<!--Menu Servicos-->
		<iframe id="menuServicos" frameBorder="0" style="position:absolute; left:<%=leftServicos%>px; width:<%=wdtServicos%>px; top:<%=frameTop%>px;  height:<%=hgtServicos%>px; z-index:900; display: none;" onmouseout="javascript:testaMousePointer('servicos');" src="<%=base_dir%>/menu_servicos.asp" marginheight="0" marginwidth="0"></iframe>
		<tr> 
			<td bgcolor="#FFFFFF" height="30"> 
				<table width="<%=w_princ%>" border="0" cellspacing="0" cellpadding="0" height="30">
				<tr> 
					<td align="center" id="mnuCRT"><a href="#" onClick="javascript:mostraMenuCRT(true);"><font class="links">Conhecendo o CRT</a></td>
					<td><font class="links">I</font></td>
					<td align="center" id="mnuRecursos"><a href="#" onClick="javascript:mostraMenuRecursos(true);"><font class="links">Recursos Dispon&iacute;veis</a></td>
					<td><font class="links">I</font></td>
					<td align="center" id="mnuServicos"><a href="#" onClick="javascript:mostraMenuServicos(true);"><font class="links">Servi&ccedil;os e Agendamentos</a></td>
					<td><font class="links">I</font></td>
					<td align="center"><a href="arq_disp.asp"><font class="links">Sistemas de Gestão</a></td>
					<%if Env.UsuarioCRT then%>
					<td><font class="links">I</font></td>
    	            <td align="center"><a href="sislab.asp" class="links"><font color="#990000">Administra&ccedil;&atilde;o do Site</a></td>
					<%END IF%>
				</tr>
				</table>
			</td>
		</tr>
        <tr><td bgcolor="#003366" height="1"></td></tr>
<%	end if%>
		</table>
	</td>
</tr>
<tr valign="top" id="tr_princ_conteudo" style="display: block;">
	<td bgcolor="#ffffff" valign="top">
		<div id="div_telaprincipal" style="width: <%=w_princ%>; border: thin navy; overflow: hidden;">
<%
' desabilitei o HEIGHT do DIV principal enquanto nao tivermos
' uma funcao para imprimir o conteudo deste DIV, pois indo para
' producao será necessario esta funcionalidade visto que os funcs
' utilizam muito a impressao das telas
' ==> para voltar a colocar o HEIGHT basta tirar o If abaixo e colocar
'     o valor "height: 310px" no style do div principal (acima)
	if false then%>
<script type="text/javascript">
	//testo a resolucao do video e altero o DIV de informações
	var resolucao = screen.width + "x" + screen.height;
	if (resolucao == "800x600") {
		document.all.div_telaprincipal.style.height = "310px";
	}
	if (resolucao == "1024x768") {
		document.all.div_telaprincipal.style.height = "480px";
	}
</script><%
	end if
end sub

function retornaInicio()
if Env.PaginaInicial <> "" then
	retornaInicio = Env.PaginaInicial
else
	retornaInicio = "msgAcessoNA.ASP"
end if
end function

Sub ImprimeRodape(imprimeImagem)
	Dim chr_Buffer

	chr_Buffer = _
		"				</td>" & VbCrLf & _
		"			</tr>" & VbCrLf & _
		"			</table>" & VbCrLf & _
		"		</div>" & VbCrLf & _
		"	</td>" & VbCrLf & _
		"</tr>" & VbCrLf

	chr_Buffer = chr_Buffer & VbCrLf & _
		"</table>" & VbCrLf & _
		"</body>" & VbCrLf & _
		"</html>"

	Response.Write chr_Buffer
End Sub


Sub ImprimeRodape1(imprimeImagem)
	if IsEmpty(imprimeImagem) or (imprimeImagem="") then imprimeImagem = false%>
				</td>
			</tr>
			</table>
		</div>
	</td>
</tr>
<%	if imprimeImagem then%>
<map name="Map2">
	<area shape="rect" coords="682,2,766,15" href="http://www.coppetec.coppe.ufrj.br" alt="Funda&ccedil;&atilde;o COPPETEC" title="Funda&ccedil;&atilde;o COPPETEC" target="_blank">
</map>
<tr valign="top" id="tr_princ_rodape" style="display: block;">
	<td><img src="img/barra_inferior.jpg" width="<%=w_princ%>" height="18" usemap="#Map2" border="0"></td>
</tr>
<%	end if%>
</table>
</body>
</html><%
End Sub

'---------------------------------------------

Sub ImprimeCabecalho2(titulo, imprimeMenu, imprimeImagem, tamanhoTela, nomeTela, linkVoltar, PathRelativo)
    	Dim chr_Buffer

	'-- verifica se a sessao esta expirada
'	if Request.cookies("SISLAB")("usuario") = "" or IsEmpty(Request.cookies("SISLAB")("usuario")) then
'	If Not LogaUsuario(replace(ucase(Request.ServerVariables("REMOTE_USER")),"EMBRATEL\","")) Then
	If Env.Usuario = "" Then
		response.redirect "msgAcessoNA.ASP"
	Else
		Dim w

		w = "770px" '-- tamanho da coluna
		if IsEmpty(tamanhoTela) or (tamanhoTela = "") then tamanhoTela = w_princ
		if IsEmpty(imprimeMenu) or (imprimeMenu="") then imprimeMenu = false

        'Response.Write "<%@LANGUAGE='VBSCRIPT' CODEPAGE='1252'%" & ">" & VbCrLf
        Response.CharSet = Application("SISLAB_CHARSET")
        Response.Clear
	    Response.Addheader "Expires","Mon, 26 Jul 1997 05:00:00 GMT"
	    Response.Addheader "Cache-Control","no-cache, must-revalidate"
	    Response.Addheader "Pragma","no-cache"
	    Response.Buffer = True
	    Response.Expires=0

		chr_Buffer = _
            "<!DOCTYPE html>" & VbCrLf & _
			"" & VbCrLf & _
			"<html>" & VbCrLf & _
			"" & VbCrLf & _
			"	<head>" & VbCrLf & _
			"	    <title>" & VbCrLf

		'-- Indica em que modo o sistema está sendo executado
		If Application("SISLAB_AMBIENTE") <> "PRO" Then _
				chr_Buffer = chr_Buffer & "[" & Application("SISLAB_AMBIENTE") & "] "

		if titulo = "" or IsEmpty(titulo) then
			chr_Buffer = chr_Buffer & "SISLAB - Site do Centro de Referência Tecnológica"
		else
			chr_Buffer = chr_Buffer & titulo
		end if

		chr_Buffer = chr_Buffer & _
			"	    </title>" & VbCrLf & _
			"" & VbCrLf & _
            "       <meta charset='" & p_CharSet & "'>" & VbCrLf & _
			"	    <!--<meta http-equiv='Content-Type' content='text/html; charset='" & Application("SISLAB_CHARSET") & "'>-->" & VbCrLf & _
			"	    <link rel='stylesheet' href='" & PathRelativo & "estilos/principal.css' type='text/css'>" & VbCrLf & _
			"	</head>"

		chr_Buffer = chr_Buffer & _
			"<script language='JavaScript' src='" & PathRelativo & "includes/currency.js'></script>" & VbCrLf & _
			"<script language='JavaScript' src='" & PathRelativo & "includes/relogio.js'></script>" & VbCrLf

		chr_Buffer = chr_Buffer & _
			"<body bgcolor='#FFFFFF' text='#000000' leftmargin='0' topmargin='0' border='0' id='body_principal' onunload='javascript: hideAguarde();'>"

		chr_Buffer = chr_Buffer & _
			"<div id='divAguarde' class='tempo' style='display: none;'><table><tr><td><img src='" & PathRelativo & "img/tempo.gif' alt='Aguarde'></td><td>&nbsp;&nbsp;Aguarde...</td></tr></table></div>" & VbCrLf

		Response.Write chr_Buffer ' & "<BR><BR><BR><BR>AQUIIIII"

		if imprimeImagem then%>

		<table width="<%=w_princ%>" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td background="<%=PathRelativo%>img/titulo_bg.jpg" bgcolor="#FFFFFF" height="70" width="<%=w_princ%>" align="left">
				<table width="<%=w_princ%>" border="0" cellspacing="0" cellpadding="0">
				<tr>
				    <td align="left" width="100px">
                        <img src="<%=PathRelativo%>img/titulo_esquerda.jpg" height="70" border="0" id="imgTituloEsquerda" style="display: inline;">
				    </td>
				    <td>
                        <img src="<%=PathRelativo%>img/titulo_centro.jpg" height="70" border="0" id="imgTituloCentro" style="display: inline;">
				    </td>
				    <td valign="middle"  align="right">
				            <br /><br />
					        <b><%=Application("SISLAB_APLICACAO_NOME")%></b><br />
					        <b><%=Env.Ebt.NomeReduzido%></b><br>
					        <b><%=Env.Usuario%></b><br>
				    </td>
				    <td align="right">
                        <img src="<%=PathRelativo%>img/titulo_direita.jpg" height="70" border="0" id="imgTituloDireita" style="display: inline;">
				    </td>
				</tr>
				</table>

<%			if imprimeMenu then%>
<script type="text/javascript" language="JavaScript1.2">
	<!--
	var st_path="<%=PathRelativo%>includes/";
	var st_lib="stm31.js";
	document.open();
	document.write("<"+"script type='text/javascript' language='JavaScript1.2' src='"+st_path+st_lib+"'><"+"/script>");
	document.close();
	//-->
</script>
<script type="text/javascript" language="JavaScript1.2">
<!--
stm_bm(["tubtehr",400,"","<%=PathRelativo%>img/blank.gif",1,"0","stgct()",0,0,250,0,1000,1,0,0,"","",0],this);
stm_bp("p0",[0,4,0,0,0,2,0,7,100,"",-2,"",-2,90,0,0,"#000000","transparent","",3,3,2,"#ffffff #ffffff #006699 #ffffff"]);
stm_ai("p0i0",[0,"Principal","","",-1,-1,0,"<%=PathRelativo%>index.asp","_self","","Retorna à página principal","","",0,0,0,"","",0,0,0,0,1,"#cccccc",0,"#006699",0,"","",3,3,0,0,"#ffffff","#ffffff","#006699","#ffffff","bold 7pt 'Arial','Verdana'","bold 7pt Arial",0,0]);
stm_ai("p0i1",[6,15,"#ffffff","",-1,-1,0]); /*separador*/
stm_aix("p0i1","p0i0",[0,"Serviços","","",-1,-1,0,"","_self","","Serviços e Agendamentos","","",0,0,0,"<%=PathRelativo%>img/arrow_r.gif","<%=PathRelativo%>img/arrow_r.gif",7,7,0,0,1,"#ffffff",0,"#ffffff",0,"","",3,3,0,0,"#ffffff","#ffffff","#006699","#000000","7pt Arial","7pt Arial"]);
stm_bp("p1",[1,4,0,0,0,3,0,7,100,"",-2,"",-2,90,0,0,"#000000","transparent","",3,1,1,"#006699"]);
stm_aix("p1i0","p0i1",[0,"Agendamentos","","",-1,-1,0,"","_self","","Agendamentos - Opções"]);
stm_bp("p2",[1,2,0,0,0,3,0,0,100,"",-2,"",-2,90,0,0,"#7f7f7f","#ffffff","",3,1,1,"#000000"]);
stm_aix("p2i0","p0i1",[0,"Novo","","",-1,-1,0,"<%=PathRelativo%>CadAgendamentoCliente.asp","_self","","Cria um agendamento","","",0,0,0,"","",0,0]);
stm_aix("p2i1","p2i0",[0,"Acompanhamento e Resultados","","",-1,-1,0,"<%=PathRelativo%>rel_ativ.asp","_self","","Acompanha a execução de um agendamento e seu resultado"]);
stm_aix("p2i2","p2i0",[0,"Remarcar","","",-1,-1,0,"<%=PathRelativo%>form_remarca_teste_sel.asp","_self","","Remarca a execução de um agendamento"]);
<%
				If Env.UsuarioCRT then%>
stm_aix("p2i3","p0i1",[0,"Relatório de Acompanhamento","","",-1,-1,0,"<%=PathRelativo%>REL_GQ_filtro.asp","_self","","Relatório de acompanhamento de um agendamento","","",0,0,0,"","",0,0,0,0,1,"#ffffff",0,"#ffffff",0,"","",3,3,0,0,"#ffffff","#ffffff","#cc0000"]);
<%				End If%>
stm_ep();
stm_aix("p1i1","p0i1",[0,"Conhecendo o CRT","","",-1,-1,0,"","_self","","Conhecendo o CRT"]);
stm_bpx("p3","p2",[]);
stm_aix("p3i0","p2i0",[0,"Ambientes","","",-1,-1,0,"<%=Application("SISLAB_ServidorLocalCRT")%>plantacrt/labcrt1.htm","_blank","","Ambientes de acomodação e salas disponíveis"]);
stm_aix("p3i1","p2i0",[0,"Código de Ética","","",-1,-1,0,"http://ntspo907/hpembratel/pdf/codigo_de_etica_embrapar.pdf","_self","","Código de Ética"]);
stm_aix("p3i2","p2i0",[0,"Equipe / Infra-estrutura Interna","","",-1,-1,0,"<%=PathRelativo%>equ_EstIn.asp","_self","","Equipe / Infra-estrutura Interna"]);

<%				'-- se for do CRT exibe o link para o servidor local
				if Env.usuarioCRT then%>
stm_aix("p3i3","p2i3",[0,"Espaço CRT","","",-1,-1,0,"http://XPRJO030309/index.htm","_self","","Espaço reservado aos trabalhos internos do CRT"]);
<%				end if%>

stm_aix("p3i4","p2i0",[0,"Histórico","","",-1,-1,0,"<%=Application("SISLAB_ServidorLocalCRT")%>Historico.pdf","_blank","","Histórico do Centro de Referência Tecnológica"]);
stm_aix("p3i5","p2i0",[0,"Localização / Área","","",-1,-1,0,"<%=PathRelativo%>loc_area.asp","_self","","Localização e área construída"]);
stm_aix("p3i6","p2i0",[0,"Manual do Sistema de Gestão","","",-1,-1,0,"arquivos/MSG Rev 08 de 20-02-06 .pdf","_self","","Manual do Sistema de Gestão"]);
stm_aix("p3i7","p2i0",[0,"Videos do CRT","","",-1,-1,0,"videos.asp","_self","","Vídeos do CRT"]);
stm_ep();

<%				if Env.usuarioCRT_Cadastrado then%>
//stm_aix("p1i2","p3i7",[0,"Controle de Consumíveis (SCC)","","",-1,-1,0,"<%=PathRelativo%>scc/index.asp","_self","","Sistema de Controle de Consumíveis","","",0,0,0,"","",0,0,0,0,1,"#ffffff",0,"#ffffff",0,"","",3,3,0,0,"#ffffff","#ffffff","#cc0000"]);
stm_aix("p1i2","p3i7",[0,"Controle de Equipamentos (SCE)","","",-1,-1,0,"<%=PathRelativo%>sce/index.asp","_self","","Sistema de Controle de Equipamentos","","",0,0,0,"","",0,0,0,0,1,"#ffffff",0,"#ffffff",0,"","",3,3,0,0,"#ffffff","#ffffff","#cc0000"]);
//stm_aix("p1i2","p2i3",[0,"Controle de Equipamentos (SCE)","","",-1,-1,0,"sce/index.asp","_self","","Sistema de Controle de Equipamentos"]);
<%				end if%>

stm_aix("p1i3","p2i0",[0,"Sistemas de Gestão","","",-1,-1,0,"<%=PathRelativo%>arq_disp.asp","_self","","Arquivos do sistema de gestão disponíveis para visualização"]);
stm_aix("p1i4","p2i0",[0,"Lista de Atividades do CRT","","",-1,-1,0,"<%=PathRelativo%>sit_crt.asp","_self","","Exibe as atividades do CRT"]);
stm_aix("p1i5","p2i0",[0,"Log Book","","",-1,-1,0,"<%=PathRelativo%>sel_cad_logbook.asp","_self","","Log Book - cadastro de ocorrências"]);
stm_aix("p1i6","p2i0",[0,"Ocupação dos Ambientes","","",-1,-1,0,"<%=PathRelativo%>ambientes/cons_agenda.asp","_self","","Cadastro e reserva de salas"]);
stm_aix("p1i7","p0i1",[0,"Pesquisa de Satisfação","","",-1,-1,0,"","_self","","Pesquisa de Satisfação"]);
stm_bpx("p4","p2",[]);
stm_aix("p4i0","p2i0",[0,"Cadastrar","","",-1,-1,0,"<%=PathRelativo%>pesqscr.asp","_self","","Cadastra uma nova pesquisa de satisfação"]);
stm_aix("p4i1","p2i0",[0,"Consultar por AS","","",-1,-1,0,"<%=PathRelativo%>cons_ind_pesqscr_filtro.asp","_self","","Consulta uma pesquisa por número do agendamento"]);
stm_ep();
stm_aix("p1i8","p0i1",[0,"Recursos Disponíveis","","",-1,-1,0,"","_self","","Recursos Disponíveis"]);
stm_bpx("p5","p2",[]);
stm_aix("p5i0","p2i0",[0,"Logística","","",-1,-1,0,"<%=Application("SISLAB_ServidorLocalCRT")%>Logistica.pdf","_blank","","Logística"]);
stm_aix("p5i1","p2i0",[0,"Salas de Apoio","","",-1,-1,0,"<%=Application("SISLAB_ServidorLocalCRT")%>SalaApoio.pdf","_blank","","Salas de Apoio"]);
stm_aix("p5i2","p2i0",[0,"Transporte para o CRT","","",-1,-1,0,"<%=PathRelativo%>CadTransporte.asp","_self","","Horários do transporte para o CRT"]);
//////stm_aix("p5i2","p2i0",[0,"Transporte para o CRT","","",-1,-1,0,"<%=Application("SISLAB_ServidorLocalCRT")%>transporte.pdf","_blank","","Horários do transporte para o CRT"]);
stm_ep();
//stm_aix("p1i9","p2i0",[0,"Sugestões (Fale Conosco)","","",-1,-1,0,"<%=PathRelativo%>fale.asp","_self","","Fale Conosco"]);
stm_ep();
<%				if Env.ehRAT or Env.ehRT then%>
stm_ai("p0i1",[6,15,"#ffffff","",-1,-1,0]); /*separador*/
stm_aix("p0i2","p2i0",[0,"Administração do Site","","",-1,-1,0,"<%=PathRelativo%>sislab.asp","_self","","Administração do SISLAB"]);
stm_ep();
<%				end if%>
stm_ai("p0i1",[6,15,"#ffffff","",-1,-1,0]); /*separador*/
stm_aix("p0i2","p2i0",[0,"Fale Conosco","","",-1,-1,0,"<%=PathRelativo%>fale.asp","_self","","Administração do SISLAB"]);
stm_em();
//-->
</script>
<%			end if%>
			</td>
		</tr>
		</table>
<%		end if	'Imprime Tela   %>

<!--------------------- Imprime o nome do formulário na tela --------------------->

<%		if nomeTela <> "" then
			if linkVoltar = "" then linkVoltar = "history.go(-1)"%>
		<table width="<%=w_princ%>" cellpadding="0" cellspacing="0" border="0" style="border-top: thin dotted Gray; border-bottom: thin dotted Gray;">
        <tr>
			<td class="realce1"> <!-- #d9d9d9 -->
				<table width="<%=w_princ%>" cellpadding="2" cellspacing="0" class="Menu" id="tbl_principal_nomeform" style="display: 1block;">
				<tr valign="middle">
					<td valign="middle">
						<span style="font-family: Verdana, Arial, Helvetica, sans-serif; color: Navy; font-weight: bolder; font-size: 10pt;">&nbsp;<span style="color: red;">&raquo;</span>&nbsp;
							<i><%=nomeTela%></i>
						</span>
					</td>
					<td align="right" id="td2_tbl_principal_nomeform" style="display: 1inline;">
<%			if ucase(linkVoltar) <> "NENHUM" then
				if ucase(linkVoltar) <> "SO_IMPRESSORA" then%>
						</b><a href="javascript:<%=linkVoltar%>;">Voltar</a>
						&nbsp;&nbsp;
<%				end if
				if ucase(linkVoltar) <> "SO_LINK" then%>
						<button id="btn_imprimeTelaPrincipalSistema" style="border: none; height: 17px; width: 25px; background-color: none;" onclick="javascript:imprimeTelaPrincipalSistema();"><a href="#"><img src="<%=PathRelativo%>img/impressora.gif" border="0" align="absmiddle" alt="Imprimir conteúdo da tela"></a></button>
<%				end if
			end if%>
						&nbsp;&nbsp;
					</td>
				</tr>
				</table>
			</td>
		</tr>
		</table>
		<script type="text/javascript">
		function imprimeTelaPrincipalSistema() {
			var d = document.all;
			var undef;
	
			if(document.all.tr_princ_rodape != undef)
				document.all.tr_princ_rodape.style.display = "none";
			if(document.all.td2_tbl_principal_nomeform != undef)
				document.all.td2_tbl_principal_nomeform.style.display = "none";
			if(document.all.Stm0p0i != undef)
				document.all.Stm0p0i.style.display = "none";
	
			window.print();

			if(document.all.tr_princ_rodape != undef)
				document.all.tr_princ_rodape.style.display = "block";
			if(document.all.td2_tbl_principal_nomeform != undef)
				document.all.td2_tbl_principal_nomeform.style.display = "inline";
			if(document.all.Stm0p0i != undef)  // menu
				document.all.Stm0p0i.style.display = "inline";
		}
		</script>
<!--	</td>
</tr>-->
<%		end if %>


<!--------------------- Imprime a tela Principal --------------------->

		<table id="tr_princ_conteudo" cellpadding="2" cellspacing="2" border="0" width="<%=tamanhoTela%>">
		<tr>
			<td>
<!--				<div id="div_telaprincipal" style="width: <%=tamanhoTela%>; border: thin navy; overflow: hidden;">-->
<%
	End If	'-- Se nao for usuario CRT

End Sub

Sub ImprimeRodape2(imprimeImagem, PathRelativo)
	Dim chr_Buffer
	if IsEmpty(imprimeImagem) or (imprimeImagem="") then imprimeImagem = false

	chr_Buffer = _
		"		</div>" & VbCrLf & _
		"	</td>" & VbCrLf & _
		"</tr>" & VbCrLf & _
		"</table>" & VbCrLf

	chr_Buffer = chr_Buffer & VbCrLf & _
		"<!--</table>-->" & VbCrLf & _
		"</body>" & VbCrLf & _
		"</html>"

	Response.Write chr_Buffer
End Sub

%>
