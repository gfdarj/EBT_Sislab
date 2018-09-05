<!--#include file="includes/Sislab_Lib.asp"-->
<script language="JavaScript">
function verificaNavegador() {
	var ehIE;
	var versao;
	
	// Não é um browser IE, pode ser qualquer outro
	ehIE = navigator.userAgent.indexOf("MSIE");

	if(ehIE == -1)
	{
		location.href = 'indexNS.asp';
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
<!--#include file="includes/global.asp" -->
<!--#include file="includes/emailHTML.asp" -->
<%
dim usuarioCRT

usuarioCRT = False

'O SISTEMA VERIFICA SE EXISTEM DOCUMENTOS FORA DA VIGENCIA E ENVIA E-MAIL PARA RAT'S GQ'S PARA QUE POSSAM VALIDAR
'call VerificaVigenciaArquivos(objConn)

call ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "", "", "")
%>
<table height="100%" width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
	<td valign="top" width="100%">
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
<%
if usuarioCRT then%>
		<tr> 
			<td bgcolor="#FFFFFF" width="288" valign="top">
				<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#003366">
				<tr> 
					<td>
						<iframe src="servicos_agendamento.htm" frameborder="0" width="288" height="100" scrolling="auto" name="teste_iframe"><font face="Arial, Helvetica, sans-serif" size="1">Immerse your soul in love.</font></iframe>
		<!--				<iframe src="o_que_e_crt.htm" frameborder="0" width="284" height="100" scrolling="auto" name="teste_iframe"><font face="Arial, Helvetica, sans-serif" size="1">Immerse your soul in love.</font></iframe>-->
					</td>
				</tr>
				</table>
			</td>
			<td width="10px"></td>
			<td bgcolor="#FFFFFF" width="288" valign="top"> 
				<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#003366">
				<tr> 
					<td>
						<iframe src="info_logbook.asp" frameborder="0" width="288" height="100" scrolling="auto" name="teste_iframe"><font face="Arial, Helvetica, sans-serif" size="1">Immerse your soul in love.</font></iframe>
		<!--				<iframe src="servicos_agendamento.htm" frameborder="0" width="284" height="100" scrolling="auto" name="teste_iframe"><font face="Arial, Helvetica, sans-serif" size="1">Immerse your soul in love.</font></iframe>-->
					</td>
				</tr>
				</table>
			</td>
		</tr>
		<tr><td height="10px"></td></tr>
<%
end if%>
		<tr>
			<td width="100%" height="100%" bgcolor="#FFFFFF" colspan="3" valign="top">
				<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#003366">
				<tr> 
					<td bgcolor="#FFFFFF">
						<div style="height=<%if usuarioCRT then response.write "225" else response.write "336"%>px; overflow: auto;">
						
						
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr> 
							<td width="5px">&nbsp;</td>
							<td width="*" height="25" class="fonteTitulo1"><span class="Vermelho2">&raquo;</span>&nbsp; Acha F&aacute;cil CRT</td>
						</tr>
						<tr>
							<td height="1"></td>
							<td height="1" bgcolor="#003366"></td>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td class="texto" valign="top">
								<br>
								<table width="100%" cellpadding="0" cellspacing="0" border="0" class="texto1">
								<tr>
									<td width="50%" valign="top">
										<table width="100%" height="100%">
										<tr valign="top">
											<td colspan="2" valign="top">
												<a href="CadAgendamentoCliente.asp" class="menu"><%=indicador%>Agende um servi&ccedil;o no CRT</a>
											</td>
										</tr>
										<tr valign="top">
											<td width="15px"></td>
											<td valign="top">
												<span class="texto">Cadastre o seu servi&ccedil;o, uma visita ou uma palestra no CRT</span>
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
												<span class="texto">Veja o andamento do seu servi&ccedil;o no CRT</span>
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
												<a href="sit_crt.asp?hoje=1" class="menu"><%=indicador%>Em execução no CRT</a>
											</td>
										</tr>
										<tr>
											<td width="15px"></td>
											<td valign="top">
												<span class="texto">Veja os agendamentos do dia</span>
											</td>
										</tr>
										</table>
									</td>
									<td width="10px"></td>
									<td width="*">
										<table width="100%" height="100%">
										<tr valign="top">
											<td colspan="2" valign="top">
												<a href="sit_crt.asp" class="menu"><%=indicador%>Lista de Atividades no CRT</a>
											</td>
										</tr>
										<tr>
											<td width="15px"></td>
											<td valign="top">
												<span class="texto">Servi&ccedil;os em andamento no CRT</span>
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
												<a href="pesqscr.asp?emjanela=1" class="menu" target="_blank"><%=indicador%>Pesquisa de Satisfa&ccedil;&atilde;o</a>
											</td>
										</tr>
										<tr>
											<td width="15px"></td>
											<td valign="top">
												<span class="texto">D&egrave; a sua opini&atilde;o sobre nossos servi&ccedil;os</span>
											</td>
										</tr>
										</table>
									</td>
									<td width="10px"></td>
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
												<span class="texto">Altere a data ou cancele o seu agendamento no CRT</span>
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
												<span class="texto">Tecnologias utilizadas nos agendamentos e seus fabricantes</span>
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
												<span class="texto">Veja as atividades executadas no CRT pelos &oacute;g&atilde;os Embratel</span>
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
												<a href="rel_clienteexterno_atividade.asp?index=1" class="menu" target="_blank"><%=indicador%>Servi&ccedil;os para Clientes</a>
											</td>
										</tr>
										<tr>
											<td width="15px"></td>
											<td valign="top">
												<span class="texto">Trabalhos voltados para clientes Embratel</span>
											</td>
										</tr>
										</table>
									</td>
								</tr>
								</table>
							</td>
						</tr>
						</table>
						</div>
<!--
						<iframe src="index_principal.asp" frameborder="0" width="588" <%if usuarioCRT then response.write "height='225px'" else response.write "height='336'"%> scrolling="auto" name="teste_iframe">
							<font face="Arial, Helvetica, sans-serif" size="1">Sorry your browser does not support IFRAMES.</font>
						</iframe>
-->
					</td>
				</tr>
				</table>
			</td>
			<td bgcolor="#FFFFFF" width="10">&nbsp;</td>
		</tr>
		</table>
	</td>

	<td width="100%" valign="top">
		<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#C0E0EF" height="309">
		<tr> 
			<td valign="top" bgcolor="#FFFFFF" height="155"><iframe src="noticias.asp" frameborder="0" width="170" height="155" scrolling="auto" name="teste_iframe"><font face="Arial, Helvetica, sans-serif" size="1">Sorry 
                  your browser does not support IFRAMES.</font></iframe>
			</td>
		</tr>
		<tr> 
			<td bgcolor="#FFFFFF" height="154" valign="top"><iframe src="fotos_crt.asp" frameborder="0" width="170" height="154" scrolling="auto" name="teste_iframe"><font face="Arial, Helvetica, sans-serif" size="1">Sorry 
                  your browser does not support IFRAMES.</font></iframe>
			</td>
		</tr>
		</table>
	</td>

</tr>
</table>
<%
call ImprimeRodape(RODAPE_ON)
%>
