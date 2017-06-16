<script language="JavaScript">
function verificaNavegador() {
	var ehIE;
	var versao;
	
	// Não é um browser IE, pode ser qualquer outro
	ehIE = navigator.userAgent.indexOf("MSIE");

	if(ehIE == -1)
	{
		//location.href = 'indexNS.asp';
		alert('Atenção !\n\nSeu navegador não é o Internet Explorer. \n\nTalvez alguns recursos do sistema possam estar indispoíveis no seu browser.');
    }
	else
	{
		versao = navigator.userAgent.substring(ehIE);
		ehIE = versao.indexOf(";");
		if(parseFloat(versao.substring(0, ehIE).replace("MSIE", "")) < 5.5)
			alert('Atenção !\n\nVocê está usando uma versão do Internet Explorer inferior à 5.5. Alguns recursos do sistema SISLAB podem não funcionar corretamente nesta versão.\n\nPor favor, atualize o seu browser antes de continuar.');
	}
}
verificaNavegador();
</script>

<!--#include file="Global.asa"-->

<%
'-- Inicializa as constantes do tipo Application no caso de não serem lidas pelo Global.Asa
'If Application("SISLAB_AMBIENTE") = "" Then
	Call Application_OnStart()
'End If
%>
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/EmailHTML.asp" -->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/Funcoes.asp"-->
<%
dim usuarioCRT
usuarioCRT = Env.UsuarioCRT

'O SISTEMA VERIFICA SE EXISTEM DOCUMENTOS FORA DA VIGENCIA E ENVIA E-MAIL PARA RAT'S GQ'S PARA QUE POSSAM VALIDAR
'call VerificaVigenciaArquivos()

call ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "", "", "")


indicador = "&nbsp;&nbsp;<img align='middle' src='img/bullet.gif' border='0'>&nbsp;"
%>
<table border="0" cellspacing="0" cellpadding="0">
<tr>
	<td valign="top" rowspan="2">

<%if usuarioCRT then%>

		<table border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td><img src="img/borda/c1tl.gif" border="0"></td>
			<td class="menu1th" width="170px">Informações de Log Book</td>
			<td><a href="#" onclick="javascript:esconde(document.all.tr_LogBook, document.all.img_LogBook, 'img/borda/m1te.gif', 'img/borda/m1tc.gif');"><img id="img_LogBook" src="img/borda/m1te.gif" border="0"></a></td>
		</tr>
		<tr id="tr_LogBook">
			<td colspan="3" class="menu1" height="90px">
				<iframe src="info_logbook.asp" frameborder="0" width="185px" height="90px" scrolling="auto" name="teste_iframe">Desculpe, mas seu browser não consegue visualizar este iframe</iframe>
			</td>
		</tr>
		<tr valign="bottom">
			<td><img src="img/borda/mn_bottoml.gif" border="0"></td>
			<td class="menu1dw" height="1">&nbsp;</td>
			<td><img src="img/borda/mn_bottomr.gif" border="0"></td>
		</tr>
		<tr><td height="5px"></td></tr>
		</table>

<%end if%>

		<table border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td><img src="img/borda/c1tl.gif" border="0"></td>
			<td class="menu1th" width="170px">Notícias</td>
			<td><a href="#" onclick="javascript:esconde(document.all.tr_Noticias, document.all.img_Noticias, 'img/borda/m1te.gif', 'img/borda/m1tc.gif');"><img id="img_Noticias" src="img/borda/m1te.gif" border="0"></a></td>
		</tr>
		<tr id="tr_Noticias">
			<td colspan="3" class="menu1">
				<iframe src="noticias.asp" frameborder="0" width="185px" height="130px" scrolling="auto" id="if_Noticias" name="iframe_noticias" style="display: block;">Desculpe, mas seu browser não consegue visualizar este iframe</iframe>
			</td>
		</tr>
		<tr valign="bottom">
			<td><img src="img/borda/mn_bottoml.gif" border="0"></td>
			<td class="menu1dw" height="1">&nbsp;</td>
			<td><img src="img/borda/mn_bottomr.gif" border="0"></td>
		</tr>

		<tr><td height="5px"></td></tr>
		</table>

		<table border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td><img src="img/borda/c1tl.gif" border="0"></td>
			<td class="menu1th" width="170px">Conheça o CRT</td>
			<td><a href="#" onclick="javascript:esconde(document.all.tr_ConhecaCRT, document.all.img_ConhecaCRT, 'img/borda/m1te.gif', 'img/borda/m1tc.gif');"><img id="img_ConhecaCRT" src="img/borda/m1te.gif" border="0"></a></td>
		</tr>
		<tr id="tr_ConhecaCRT">
			<td colspan="3" class="menu1">
				<iframe src="fotos_crt.asp" frameborder="0" width="185px" height="140px" scrolling="auto" name="teste_iframe">Desculpe, mas seu browser não consegue visualizar este iframe</iframe>
			</td>
		</tr>
		<tr valign="bottom">
			<td><img src="img/borda/mn_bottoml.gif" border="0"></td>
			<td class="menu1dw" height="0">&nbsp;</td>
			<td><img src="img/borda/mn_bottomr.gif" border="0"></td>
		</tr>
		</table>

	</td>

	<td height="5px" rowspan="2">&nbsp;</td>

	<!--coluna do meio-->
	<%
	Dim W1
	W1 = "345px"
	%>
	<!-- ACHA FACIL -->
	<td valign="top">

		<table border="0" cellpadding="0" cellspacing="0" height="120px">
		<tr><td height="10px"></td><td></td><td></td></tr>
		<tr>
			<td width="5px">&nbsp;<!--<img src="img/borda/c1tl.gif" border="0">--></td>
			<td class="destaque" width="<%=W1%>">Acha Fácil</td>
			<td width="5px">&nbsp;<!--<img src="img/borda/m1te.gif" border="0">--></td>
		</tr>
		<tr>
			<td valign="top" colspan="3" class="" width="<%=W1%>" height="140px">

				<!--CONTEUDO ACHA FACIL-->
								<table width="100%" border="0" cellpadding="0" cellspacing="0" class="texto1">
								<tr>
									<td width="50%" valign="top">
										<table width="100%" height="100%">
										<tr valign="middle">
											<td colspan="2" valign="middle">
												<a href="CadAgendamentoCliente.asp" class="menu" title="Cadastre a sua atividade, visita ou uma palestra no CRT"><%=indicador%>Agende uma atividade no CRT</a>
											</td>
										</tr>
										</table>
									</td>
								</tr>
								<tr>
									<td>
										<table width="100%" height="100%">
										<tr valign="top">
											<td colspan="2">
												<a href="rel_ativ.asp" class="menu" title="Relação das suas atividades"><%=indicador%>Acompanhe seus agendamentos</a>
											</td>
										</tr>
										</table>
									</td>
								</tr>
								<tr>
									<td>
										<table width="100%" height="100%">
										<tr valign="top">
											<td colspan="2" valign="top">
												<a href="form_remarca_teste_sel.asp" class="menu" title="Altere a data ou cancele os seus agendamentos no CRT"><%=indicador%>Remarque ou Cancele seus Agendamentos</a>
											</td>
										</tr>
										</table>
									</td>
								</tr>
								<tr>
									<td width="50%">
										<table width="100%" height="100%">
										<tr valign="top">
											<td colspan="2" valign="top">
												<a href="pesqscr.asp?emjanela=1" class="menu" target="_blank" title="De a sua opinião sobre nosso atendimento"><%=indicador%>Pesquisa de Satisfação</a>
											</td>
										</tr>
										</table>
									</td>
								</tr>

								<tr>
									<td width="50%">
										<table width="100%" height="100%">
										<tr valign="top">
											<td colspan="2" valign="top">
												<table cellpadding="0" cellspacing="0" border="0">
												<tr>
													<td width="105px" valign="middle"><a href="#" class="menu" target="_blank" title="Informações consolidadas das atividades no CRT"><%=indicador%>Relatórios</a></td>
													<td valign="middle"><a href="#" class="menu" title="Informações consolidadas das atividades no CRT" onclick="javascript:esconde(document.all.id_relatorios, document.all.img_relatorios, 'img/bullets/mte.gif', 'img/bullets/mtc.gif');"><img src="img/bullets/mtc.gif" id="img_relatorios" border="0" align='middle'></a></td>
												</tr>
												</table>
											</td>
										</tr>
										</table>

										<div style="display: none;" id="id_relatorios">
										<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
												<tr>
													<td>
														<%indicador = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"%>
														<table width="100%" cellpadding="0" cellspacing="0">
														<tr valign="top">
															<td colspan="2" valign="top">
																<a href="rel_tecnologia_fabricante.asp?index=1" class="menu" target="_blank" title="Tecnologias utilizadas nos agendamentos e seus fabricantes"><%=indicador%>Tecnologias empregadas</a>
															</td>
														</tr>
														</table>
														<table width="100%" cellpadding="0" cellspacing="0">
														<tr valign="top">
															<td colspan="2" valign="top">
																<a href="rel_orgao_atividade.asp?index=1" class="menu" target="_blank" title="Veja as atividades executadas no CRT pelos órgãos Embratel"><%=indicador%>Órgãos Clientes</a>
															</td>
														</tr>
														</table>

														<table width="100%" cellpadding="0" cellspacing="0">
														<tr valign="top">
															<td colspan="2" valign="top">
																<a href="rel_clienteexterno_atividade.asp?index=1" class="menu" target="_blank" title="Trabalhos voltados para clientes Embratel"><%=indicador%>Serviços para Clientes</a>
															</td>
														</tr>
														</table>
													</td>
												</tr>
										</table>
										</div>

									</td>
								</tr>
								</table>
				<!--CONTEUDO ACHA FACIL-->

			</td>
		</tr>
		<tr valign="bottom">
			<td width="5px">&nbsp;<!--<img src="img/borda/mn_bottoml.gif" border="0">--></td>
			<td width="*" class="" height="1">&nbsp;</td>
			<td width="5px">&nbsp;<!--<img src="img/borda/mn_bottomr.gif" border="0">--></td>
		</tr>
		</table>

	</td>

	<td height="5px">&nbsp;</td>

	<!--coluna da direita - Usada para os FLASH's-->
	<td valign="top">

		<!--Os arquivos flash devem ter largura de 200px-->
		<table cellpadding="0" cellspacing="0" border="0">
		<tr>
			<td align="center" valign="middle">
				<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0" height="60" width="200"><param name="wmode" value="transparent"><param name="movie" value="img/flash/UCEAutodesenvolvimento2B.swf?url=http://webebt10.embratel.com.br/uce_extranet/index.asp"><param name="quality" value="high"> <embed style="display: none;" src="img/flash/UCEAutodesenvolvimento2B.swf" quality="high" type="application/x-shockwave-flash" pluginspace="http://www.macromedia.com/go/getflashplayer" height="60" width="200"></object>
				<!--<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0" width="145" height="70">
		 		<param name="movie" value="img/flash/portal_logo.swf?url=index.asp">
		 		<param name="quality" value="high">
			 	<param name="wmode" value="transparent">
			 	<embed src="img/flash/portal_logo.swf?url=index.asp" width="140" height="70" quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" wmode="transparent"></embed>
				</object>-->
			</td>
		</tr>
		<tr><td height="20px"></td></tr>
		<tr>
			<td align="center" valign="middle">
				<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0" viewastext="" height="160" width="200">
				<param name="wmode" value="transparent">
				<param name="movie" value="img/flash/tvflash.swf">
				<param name="quality" value="high">
				<div id="adblock-frame-n23" adblockframe="true" style="margin: 0px; padding: 0px; overflow: visible; width: 200px; display: block;"><div style="height: 0px; width: 100%; overflow: visible;" align="right"><div style="border-style: ridge ridge none; border-width: 2px 2px 0px; padding: 1px; vertical-align: bottom; -moz-border-radius-topleft: 10px; -moz-border-radius-topright: 10px; opacity: 0.5; background-color: white; position: relative; top: -19px; left: -5px; z-index: 900; width: 48px; height: 15px; cursor: pointer; overflow: visible;" align="center"><span style="font-family: Arial,Helvetica,Sans-serif; font-size: 12px; font-style: normal; font-variant: normal; font-weight: normal; line-height: 140%; text-align: right; text-decoration: none; opacity: 1.5; color: black;">Adblock</span></div></div></div>
				<embed style="" adblockframename="adblock-frame-n23" adblockframedobject2="true" src="img/flash/tvflash.swf" quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" height="160" width="200">
				</object>
			</td>
		</tr>
		<tr><td height="10px"></td></tr>
		</table>

	</td>
</tr>

<tr>
	<td colspan="3">
		<%
		W = "100%"
		%>

		<!-- Agendamentos no CRT -->
		<table width="<%=W%>" border="0" cellpadding="0" cellspacing="0" height="120px">
		<tr>
			<td width="5px">&nbsp;<!--<img src="img/borda/c1tl.gif" border="0">--></td>
			<td width="*" class="destaque" width="<%=W1%>">Agendamentos de hoje no CRT</td>
			<td width="5px">&nbsp;<!--<img src="img/borda/m1te.gif" border="0">--></td>
		</tr>
		<tr>
			<td></td>
			<td valign="top" class="" width="100%" height="240px">
				<%RW MontaAgendamentosDoDia("")%>
			</td>
			<td></td>
		</tr>
		<tr valign="bottom">
			<td width="5px">&nbsp;<!--<img src="img/borda/mn_bottoml.gif" border="0">--></td>
			<td class="" height="1">&nbsp;</td>
			<td width="5px">&nbsp;<!--<img src="img/borda/mn_bottomr.gif" border="0">--></td>
		</tr>
		</table>
	</td>
</tr>

</table>
<script language="JavaScript">
function esconde(eu, img, img1, img2)
{
	if(eu.style.display == 'none')
	{
		eu.style.display = 'block';
		img.src = img1;
	}
	else
	{
		eu.style.display = 'none';
		img.src = img2;
	}
}
</script>
<%
call ImprimeRodape(RODAPE_ON)
%>

