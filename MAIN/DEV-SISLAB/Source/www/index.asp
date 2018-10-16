<%
'dim strNTUser , email 
'strNTUser = Request.ServerVariables("AUTH_USER")
'email = Split(strNTUser, "\")  'Mid(strNTUser,(instr(1,strNTUser,"\")+1),len(strNTUser))

'response.Write "AQUI 1<BR>"
'response.write email(0)
'response.Write "<BR>AQUI 2<BR>"
'response.write email(1)
'response.End
%>
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/EmailHTML.asp" -->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/Sislab_Lib.asp"-->
<%
'Set ebt1 = new TEbt
'response.Write "AQUI1 : " & now
'response.Write "<BR>AQUI2 : " & now
'response.End
'response.Write ebt1.MensagemErro
'Call Ebt1.LoginUsuario("")
''Call Ebt1.LoginUsuario("aalmeida@alerj.rj.gov.br")
'Call Ebt1.BuscaDadosEmbratel("")
'WS_ObtemUsuarioAD
'Call ebt1.BuscaDadosEmbratelAD("galmeida")

'Response.Write "<BR>Usuario: " & Ebt1.Usuario() & "<BR><BR>"
'Response.Write "Nome: " & Ebt1.NomeReduzido & "<BR>"
''Response.Write "Descricao: " & Ebt1.Descricao & "<BR>"
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

Dim usuarioCRT, chr_SQL, RS,conta

usuarioCRT = Env.UsuarioCRT

'O SISTEMA VERIFICA SE EXISTEM DOCUMENTOS FORA DA VIGENCIA E ENVIA E-MAIL PARA RAT'S GQ'S PARA QUE POSSAM VALIDAR
'call VerificaVigenciaArquivos()
Call Tela.MostraCabecalho()
%>
<!-- CSS do fancybox -->
<link rel="stylesheet" href="includes/fancybox-3.5.2-dist/jquery.fancybox.min.css" />

<!-- javascript do fancybox -->
<script type="text/javascript" src="includes/jquery/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="includes/fancybox-3.5.2-dist/jquery.fancybox.min.js"></script>

<!-- Scroller do notícias -->
<script type="text/javascript" src="includes/pauseScroller.js"></script>

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
						<iframe src="servicos_agendamento.htm" frameborder="0" width="288" height="100" scrolling="auto" name="teste_iframe"><font face="Arial, Helvetica, sans-serif" size="1">Seu browser n�o suporta IFRAMES.</font></iframe>
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
							<td align="center">

                                <style type="text/css">
                                    /* Example CSS for the two demo scrollers */
                                    #pscroller1{
	                                    width: 135px;
	                                    height: 70px;
	                                    border: none;
	                                    padding: 0px;
	                                    background-color: none;
                                    }

                                    .someclass{ //class to apply to your scroller(s) if desired }
                                </style>

                                <br />
                                <div class="" id="datamain" style="max-width:140px; max-height: 70px; text-align: left; word-wrap: break-word;">
                                    <script type="text/javascript">
                                        var pausecontent = new Array();
<%
        chr_SQL = "select * From Plantao Where PLA_DATATERMINO >= GETDATE() order by PLA_CODNOTICIA desc"
        Call Env.RecordSet(True, RS, chr_SQL)
        conta = 0

        If not (RS.EOF and RS.BOF) Then
            While Not RS.Eof
		        conta = conta + 1
                If Not(IsNull(RS("PLA_LINK")) or RS("PLA_LINK")="") Then %>
                                        pausecontent[<%=conta-1%>]= '<a href="#" onclick="javascript:novaJanela(<%=RS("pla_codnoticia")%>);" class="texto" target="_self"><%=Reticencias(trim(RS("PLA_TITNOTICIA")),80)%></a>';
<%		        Else%>
                                        pausecontent[<%=conta-1%>]= '<font class="texto"><%=Reticencias(RS("PLA_TitNoticia"),80)%></font>';
<%		        End If
		        RS.MoveNext
	        WEnd 
%>
                                        pausecontent[<%=conta%>]=  '';

                                        new pausescroller(pausecontent, "pscroller1", "someclass", 3000)

<%      Else %>
                                        pausecontent[0]=  '<center><i>Nenhuma notícia cadastrada</i></center>';
                                        document.write(pausecontent[0]);
<%      End If 
        Call Env.RecordSet(False, RS, "")
%>
                                        function novaJanela(id_noticia)
                                        {
                                            var jan = window.open('noticias_exibe.asp?id_noticia=' + id_noticia, 'Noticias_CRT', 'toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,copyhistory=no,width=690,height=400,top=5,left=5');
                                            jan.focus();
                                        }
                                    </script>
                                </div>

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
								<!--
                                <iframe src="fotos_crt.asp" frameborder="0" width="140" height="125" scrolling="no" name="teste_iframe">
                                    <font face="Arial, Helvetica, sans-serif" size="1">Sorry your browser does not support IFRAMES.</font>
								</iframe>
                                -->

                                <div class="" style="max-width:140px; max-height: 125px;">
<%
     	chr_SQL = "SELECT TOP 2 ARQ_NOMEARQ, ARQ_LINK, ARQ_CODARQ " & _
		          "FROM Arquivos " & _
		          "WHERE ARQ_CODARQTIPO = " & Application("SISLAB_id_TipoArquivo_Imagem")
	    Call Env.RecordSet(True, RS, chr_SQL)
        While Not RS.Eof %>
                                    <a href="arquivos/<%=RS("ARQ_NOMEARQ")%>" data-fancybox="gallery" data-caption="<%=RS("ARQ_LINK")%>" class="fancybox">
                                        <img class="mySlides" title="<%=RS("ARQ_LINK")%>" src="arquivos/<%=RS("ARQ_NOMEARQ")%>" style="width:140px; height: 125px;" >
                                    </a>
<%          RS.MoveNext
        WEnd
        Call Env.RecordSet(False, RS, "")
%>
                                </div>

                                <script type="text/javascript">
                                    //Faz a troca das imagens em um intervalo pré-definido
                                    var myIndex = 0;
                                    carousel();

                                    function carousel() {
                                        var i;
                                        var x = document.getElementsByClassName("mySlides");
                                        for (i = 0; i < x.length; i++) {
                                            x[i].style.display = "none";
                                        }
                                        myIndex++;
                                        if (myIndex > x.length) { myIndex = 1 }
                                        x[myIndex - 1].style.display = "block";
                                        setTimeout(carousel, 5000); // Change image every 5 seconds
                                    }

                                    //fancybox
                                    $('[data-fancybox="gallery"]').fancybox({
                                        // Options will go here
                                        slideShow : {
                                            autoStart : true,
                                            playSpeed: 3000
                                        }
                                    });

                                </script>

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
	
	    // Não é um broagora er IE, pode ser qualquer outro
	    ehIE = navigator.userAgent.indexOf("MSIE");

	    if(ehIE == -1)
	    {
	        //location.href = 'indexNS.asp';
	        alert('Atenção !\n\nSeu navegador não é o Internet Explorer. \n\nTalvez alguns recursos do sistema possam estar indisponíveis no seu browser.');
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
