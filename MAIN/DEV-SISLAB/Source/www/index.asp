

<%
'-- Inicializa as constantes do tipo Application no caso de não serem lidas pelo Global.Asa
'If Application("SISLAB_AMBIENTE") = "" Then
	Call Application_OnStart()
'End If
%>
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="Global.asa"-->
<!--#include file="includes/EmailHTML.asp" -->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/Sislab_Lib.asp"-->
<%

'Set ebt1 = new TEbt
'call Ebt1.LoginUsuario("")
'Response.Write "Usuario: " & Ebt1.Usuario() & "<BR>"
'Response.Write "Nome: " & Ebt1.NomeReduzido & "<BR>"
'Response.Write "ehFuncionario: " & Ebt1.ehFuncionario & "<BR>"
'Response.Write "ehRAT: " & Ebt1.ehRAT & "<BR>"
'Response.Write "ehRT: " & Ebt1.ehRT& "<BR>"
'Response.Write "Matricula: " & Ebt1.Matricula & "<BR>"
'Response.Write "UsuarioCRT: " & Ebt1.UsuarioCRT & "<BR>"
'Response.Write "UsuarioSCE: " & Ebt1.UsuarioSCE & "<BR>"
'Response.Write "PerfilSCE: " & Ebt1.PerfilSCE & "<BR>"
'Response.Write "UsuarioCRT_Cadastrado: " & Ebt1.UsuarioCRTCadastrado & "<BR>"
'Response.Write "Celular: " & Ebt1.Celular & "<BR>"
'Response.Write "Ramal: " & Ebt1.Ramal & "<BR>"
'Response.Write "NOW: " & now & "<BR>"
'Response.End


dim usuarioCRT
usuarioCRT = Env.UsuarioCRT

'O SISTEMA VERIFICA SE EXISTEM DOCUMENTOS FORA DA VIGENCIA E ENVIA E-MAIL PARA RAT'S GQ'S PARA QUE POSSAM VALIDAR
'call VerificaVigenciaArquivos()
Call Tela.MostraCabecalho()
%>
<table height="100%" width="765px" border="0" cellspacing="0" cellpadding="0">
<tr>
	<!-- Primeira parte da tela - coluna acha facil + logbook + servicos -->
	<td valign="top" width="*">

		<table width="100%" border="0" cellpadding="0" cellspacing="0">
<%
if usuarioCRT then%>
		<tr> 
			<td bgcolor="#FFFFFF" width="260px" valign="top">
				<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#003366">
				<tr> 
					<td>
						<iframe src="servicos_agendamento.htm" frameborder="0" width="288" height="100" scrolling="auto" name="teste_iframe"><font face="Arial, Helvetica, sans-serif" size="1">Seu browser não suporta IFRAMES.</font></iframe>
						<!--<iframe src="o_que_e_crt.htm" frameborder="0" width="284" height="100" scrolling="auto" name="teste_iframe"><font face="Arial, Helvetica, sans-serif" size="1">Immerse your soul in love.</font></iframe>-->
					</td>
				</tr>
				</table>
			</td>
			<td width="10px" bgcolor="#ffffff"></td>
			<td bgcolor="#FFFFFF" width="260px" valign="top"> 
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
		<tr><td height="10px" colspan="3" bgcolor="#ffffff"></td></tr>
<%
end if%>
		<!-- Acha facil -->
		<tr>
			<td width="605px" height="100%" bgcolor="#FFFFFF" colspan="3" valign="top">
				<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#003366">
				<tr> 
					<td bgcolor="#FFFFFF">
						<!--<div style="height=<%if usuarioCRT then response.write "225" else response.write "336"%>px; overflow: auto;">-->
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr> 
							<td width="5px">&nbsp;</td>
							<td width="*" height="25" class="fonteTitulo1"><span class="Vermelho2">&raquo;</span>&nbsp; Acha Fácil CRT</td>
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
												<a href="rel_ativ.asp" class="menu"><%=indicador%>Acompanhamento e Resultados</a>
											</td>
										</tr>
										<tr>
											<td width="15px"></td>
											<td valign="top">
												<span class="texto">Informações dos agendamentos no CRT</span>
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
												<a href="sit_crt.asp?hoje=1" onClick="javascript: showAguarde();" class="menu"><%=indicador%>Em execução no CRT</a>
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
												<a href="form_remarca_teste_sel.asp" class="menu"><%=indicador%>Remarcar Agendamento</a>
											</td>
										</tr>
										<tr>
											<td width="15px"></td>
											<td valign="top">
												<span class="texto">Altere a data do seu agendamento no CRT</span>
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
						<!--</div>-->
<!--
						<iframe src="index_principal.asp" frameborder="0" width="588" <%if usuarioCRT then response.write "height='225px'" else response.write "height='336'"%> scrolling="auto" name="teste_iframe">
							<font face="Arial, Helvetica, sans-serif" size="1">Sorry your browser does not support IFRAMES.</font>
						</iframe>
-->
					</td>
				</tr>
				</table>
			</td>
		</tr>
		</table>
	</td>

	<td style="width:5px;" width="5px" bgcolor="#ffffff"></td>

	<!-- Segunda parte da tela - coluna noticias + fotos -->
	<%
	Dim W1 : W1 = "140px"
	%>
	<td width="<%=W1%>" valign="top">

		<table cellpadding="0" cellspacing="0" border="0">
		<tr>
			<td>
				<table align="left" width="<%=W1%>" border="0" cellspacing="1" cellpadding="0" bgcolor="#C0E0EF" height="110">
				<tr>
					<td valign="top" bgcolor="#FFFFFF" height="110">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr> 
							<td width="5px"></td>
							<td width="*" height="25" class="fonteTitulo1"><span class="Vermelho2">&raquo;</span>&nbsp; Notícias</td>
						</tr>
						<tr>
							<td height="1"></td>
							<td height="1" bgcolor="#003366"></td>
						</tr>
						<tr>
							<td width="5px">&nbsp;</td>
							<td align="center"><br>
								<iframe id="datamain" src="noticias.asp" frameborder="0" width="140" height="70" scrolling="no" name="datamain"><font face="Arial, Helvetica, sans-serif" size="1">Sorry your browser does not support IFRAMES.</font></iframe>
							</td>
						</tr>
						<tr>
							<td colspan="2" align="center" valign="middle">
								<span class="texto1" style="font-size: 9px;"><i>Clique na notícia para abrir</i></span>
							</td>
						</tr>
						</table>
					</td>
				</tr>
				</table>
			</td>
		</tr>
		<tr><td height="10px"></td></tr>
		<tr>
			<td>
				<table width="<%=W1%>" border="0" cellspacing="1" cellpadding="0" bgcolor="#C0E0EF" height="125">
				<tr>
					<td bgcolor="#FFFFFF" height="125" valign="top" align="center">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr> 
							<td width="5px"></td>
							<td width="*" height="25" class="fonteTitulo1"><span class="Vermelho2">&raquo;</span>&nbsp; Fotos</td>
						</tr>
						<tr>
							<td height="1"></td>
							<td height="1" bgcolor="#003366"></td>
						</tr>
						<tr>
							<td colspan="2" valign="middle" align="center"><br>
								<iframe src="fotos_crt.asp" frameborder="0" width="140" height="125" scrolling="no" name="teste_iframe"><font face="Arial, Helvetica, sans-serif" size="1">Sorry your browser does not support IFRAMES.</font></iframe>
								<span class="texto1" style="font-size: 9px;"><i>Clique na foto para ampliar</i></span>
							</td>
						</tr>
						</table>
					</td>
				</tr>
				</table>
			</td>
		</tr>
		</table>
	</td>

</tr>
</table>

<script type="text/javascript">
/*
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
*/
</script>


<%
Call Tela.MostraRodape()
%>
