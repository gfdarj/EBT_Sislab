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
<%
dim usuarioCRT
usuarioCRT = false

'O SISTEMA VERIFICA SE EXISTEM DOCUMENTOS FORA DA VIGENCIA E ENVIA E-MAIL PARA RAT'S GQ'S PARA QUE POSSAM VALIDAR
'call VerificaVigenciaArquivos()

Call ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "", "", "")


indicador = "<img align='middle' src='img/bullet.gif' border='0'>&nbsp;"
%>
<table border="0" cellspacing="0" cellpadding="0">
<tr>
	<td valign="top">

<%if usuarioCRT then%>

		<table border="0" cellpadding="0" cellspacing="0" height="120px">
		<tr>
			<td><img src="img/borda/c1tl.gif" border="0"></td>
			<td class="menu1th" width="170px">Informações de Log Book</td>
			<td><img src="img/borda/m1te.gif" border="0"></td>
		</tr>
		<tr>
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

		<table border="0" cellpadding="0" cellspacing="0" height="120px">
		<tr>
			<td><img src="img/borda/c1tl.gif" border="0"></td>
			<td class="menu1th" width="170px">Notícias</td>
			<td><img src="img/borda/m1te.gif" border="0"></td>
		</tr>
		<tr>
			<td colspan="3" class="menu1" height="120px">
				<iframe src="noticias.asp" frameborder="0" width="185px" height="130px" scrolling="auto" name="teste_iframe">Desculpe, mas seu browser não consegue visualizar este iframe</iframe>
			</td>
		</tr>
		<tr valign="bottom">
			<td><img src="img/borda/mn_bottoml.gif" border="0"></td>
			<td class="menu1dw" height="1">&nbsp;</td>
			<td><img src="img/borda/mn_bottomr.gif" border="0"></td>
		</tr>

		<tr><td height="5px"></td></tr>
		</table>

		<table border="0" cellpadding="0" cellspacing="0" height="120px">
		<tr>
			<td><img src="img/borda/c1tl.gif" border="0"></td>
			<td class="menu1th" width="170px">Conheça o CRT</td>
			<td><img src="img/borda/m1te.gif" border="0"></td>
		</tr>
		<tr>
			<td colspan="3" class="menu1" height="110px">
				<iframe src="fotos_crt.asp" frameborder="0" width="185px" height="155px" scrolling="auto" name="teste_iframe">Desculpe, mas seu browser não consegue visualizar este iframe</iframe>
			</td>
		</tr>
		<tr valign="bottom">
			<td><img src="img/borda/mn_bottoml.gif" border="0"></td>
			<td class="menu1dw" height="0">&nbsp;</td>
			<td><img src="img/borda/mn_bottomr.gif" border="0"></td>
		</tr>
		</table>

	</td>

	<td height="5px">&nbsp;</td>

	<td valign="top">

		<table border="0" cellpadding="0" cellspacing="0" height="120px">
		<tr>
			<td>&nbsp;<!--<img src="img/borda/c1tl.gif" border="0">--></td>
			<td class="destaque" width="540px">Acha Fácil</td>
			<td>&nbsp;<!--<img src="img/borda/m1te.gif" border="0">--></td>
		</tr>
		<tr>
			<td valign="top" colspan="3" class="" height="240px" width="540px">

				<!--CONTEUDO ACHA FACIL-->
								<table width="550px" border="0" cellpadding="0" cellspacing="0" class="texto1">
								<tr>
									<td width="50%" valign="top">
										<table width="100%" height="100%">
										<tr valign="middle">
											<td colspan="2" valign="middle">
												<a href="CadAgendamentoCliente.asp" class="menu"><%=indicador%>Agende um servi&ccedil;o no CRT</a>
											</td>
										</tr>
										<tr valign="top">
											<td width="15px"></td>
											<td valign="top">
												<span class="texto0">Cadastre o seu servi&ccedil;o, uma visita ou uma palestra no CRT</span>
											</td>
										</tr>
										</table>
									</td>
									<td width="10px"></td>
									<td>
										<table width="100%" height="100%">
										<tr valign="top">
											<td colspan="2">
												<a href="rel_ativ.asp" class="menu"><%=indicador%>Acompanhe seu agendamento</a>
											</td>
										</tr>
										<tr>
											<td width="15px"></td>
											<td valign="top">
												<span class="texto0">Veja o andamento do seu servi&ccedil;o no CRT</span>
											</td>
										</tr>
										</table>
									</td>
								</tr>
						
								<tr><td height="6px"></td></tr>
						
								<tr>
									<td width="50%">
										<table width="100%" height="100%">
										<tr valign="top">
											<td colspan="2" valign="top">
												<a href="sit_crt.asp?hoje=1" onclick="javascript: showAguarde();" class="menu"><%=indicador%>Em execução no CRT</a>
											</td>
										</tr>
										<tr>
											<td width="15px"></td>
											<td valign="top">
												<span class="texto0">Servi&ccedil;os em andamento no CRT</span>
											</td>
										</tr>
										</table>
									</td>
									<td width="10px"></td>
									<td width="50%">
										<table width="100%" height="100%">
										<tr valign="top">
											<td colspan="2" valign="top">
												<a href="pesqscr.asp?emjanela=1" class="menu" target="_blank"><%=indicador%>Pesquisa de Satisfa&ccedil;&atilde;o</a>
											</td>
										</tr>
										<tr>
											<td width="15px"></td>
											<td valign="top">
												<span class="texto0">De a sua opini&atilde;o sobre nossos servi&ccedil;os</span>
											</td>
										</tr>
										</table>
									</td>
								</tr>
						
								<tr><td height="6px"></td></tr>
						
								<tr>
									<td>
										<table width="100%" height="100%">
										<tr valign="top">
											<td colspan="2" valign="top">
												<a href="form_remarca_teste_sel.asp" class="menu"><%=indicador%>Remarcar ou Cancelar Agendamento</a>
											</td>
										</tr>
										<tr>
											<td width="15px"></td>
											<td valign="top">
												<span class="texto0">Altere a data ou cancele o seu agendamento no CRT</span>
											</td>
										</tr>
										</table>
									</td>
									<td width="10px"></td>
									<td>
										<table width="100%" height="100%">
										<tr valign="top">
											<td colspan="2" valign="top">
												<a href="rel_clienteexterno_atividade.asp?index=1" class="menu" target="_blank"><%=indicador%>Servi&ccedil;os para Clientes</a>
											</td>
										</tr>
										<tr>
											<td width="15px"></td>
											<td valign="top">
												<span class="texto0">Trabalhos voltados para clientes Embratel</span>
											</td>
										</tr>
										</table>
									</td>
								</tr>
						
								<tr><td height="6px"></td></tr>
						
								<tr>
									<td width="50%">
										<table width="100%" height="100%">
										<tr valign="top">
											<td colspan="2" valign="top">
												<a href="rel_tecnologia_fabricante.asp?index=1" class="menu" target="_blank"><%=indicador%>Tecnologias empregadas</a>
											</td>
										</tr>
										<tr>
											<td width="15px"></td>
											<td valign="top">
												<span class="texto0">Tecnologias utilizadas nos agendamentos e seus fabricantes</span>
											</td>
										</tr>
										</table>
									</td>
									<td width="10px"></td>
									<td>
										<table width="100%" height="100%">
										<tr valign="top">
											<td colspan="2" valign="top">
												<a href="rel_orgao_atividade.asp?index=1" class="menu" target="_blank"><%=indicador%>&Oacute;rg&atilde;os Clientes</a>
											</td>
										</tr>
										<tr>
											<td width="15px"></td>
											<td valign="baseline">
												<span class="texto0">Veja as atividades executadas no CRT pelos &oacute;g&atilde;os Embratel</span>
											</td>
										</tr>
										</table>
									</td>
								</tr>

								</table>
				<!--CONTEUDO ACHA FACIL-->

			</td>
		</tr>
		<tr valign="bottom">
			<td>&nbsp;<!--<img src="img/borda/mn_bottoml.gif" border="0">--></td>
			<td class="" height="1">&nbsp;</td>
			<td>&nbsp;<!--<img src="img/borda/mn_bottomr.gif" border="0">--></td>
		</tr>
		</table>

		<!-- Agendamentos no CRT -->
		<table border="0" cellpadding="0" cellspacing="0" height="120px">
		<tr>
			<td>&nbsp;<!--<img src="img/borda/c1tl.gif" border="0">--></td>
			<td class="destaque" width="540px">Agendamentos de hoje no CRT</td>
			<td>&nbsp;<!--<img src="img/borda/m1te.gif" border="0">--></td>
		</tr>
		<tr>
			<td valign="top" colspan="3" class="" height="240px" width="540px">
			</td>
		</tr>
		<tr valign="bottom">
			<td>&nbsp;<!--<img src="img/borda/mn_bottoml.gif" border="0">--></td>
			<td class="" height="1">&nbsp;</td>
			<td>&nbsp;<!--<img src="img/borda/mn_bottomr.gif" border="0">--></td>
		</tr>
		</table>


	</td>

</tr>

</table>
<%
call ImprimeRodape(RODAPE_ON)
%>
