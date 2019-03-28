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
<!--#include file="includes/Geral_Lib.asp" -->
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

Dim usuarioCRT, chr_SQL, RS,conta, navegador

navegador = MeuNavegador()
usuarioCRT = Env.UsuarioCRT

'usuarioCRT = false
'Response.write Env.EhRat & "<BR>" & Now
'Response.End

'O SISTEMA VERIFICA SE EXISTEM DOCUMENTOS FORA DA VIGENCIA E ENVIA E-MAIL PARA RAT'S GQ'S PARA QUE POSSAM VALIDAR
'call VerificaVigenciaArquivos()
Call Tela.MostraCabecalho()
%>
<!-- CSS do fancybox -->
<link rel="stylesheet" href="includes/fancybox-3.5.2-dist/jquery.fancybox.min.css" />

<!-- Scroller do notícias -->
<script type="text/javascript" src="includes/pauseScroller.js"></script>

        <br />

        <div class="container">

            <div class="row">

                <div class="col-xs-12 col-sm-12 col-md-4 col-lg-4">

                    <h4 class="linha-destaque">Acha Fácil CRT</h4>

                        <h5><a href="CadAgendamentoCliente.asp">Agende um servi&ccedil;o no CRT</a><br />
						&nbsp;&nbsp;&nbsp;<small>Cadastre o seu servi&ccedil;o, uma visita ou uma palestra no CRT</small></h5>

						<h5><a href="rel_ativ.asp" class="menu">Acompanhamento e Resultados</a><br />
						&nbsp;&nbsp;&nbsp;<small>Informações dos agendamentos no CRT</small></h5>

                <% If usuarioCRT Then %>
						<h5><a href="sit_crt.asp?hoje=1" onClick="javascript: showAguarde();" class="menu"><%=indicador%>Em execução no CRT</a><br />
						&nbsp;&nbsp;&nbsp;<small>Veja os agendamentos do dia</small></h5>
                <% End If %>

						<h5><a href="sit_crt.asp" class="menu"><%=indicador%>Lista de Atividades no CRT</a><br />
						&nbsp;&nbsp;&nbsp;<small>Servi&ccedil;os em andamento no CRT</small></h5>

						<h5><a href="pesqscr.asp?emjanela=1" class="menu" target="_blank"><%=indicador%>Pesquisa de Satisfa&ccedil;&atilde;o</a><br />
				    		&nbsp;&nbsp;&nbsp;<small>D&egrave; a sua opini&atilde;o sobre nossos servi&ccedil;os</small></h5>

						<h5><a href="form_remarca_teste_sel.asp" class="menu"><%=indicador%>Remarcar Agendamento</a><br />
			    			&nbsp;&nbsp;&nbsp;<small>Altere a data do seu agendamento no CRT</small></h5>

                <% If usuarioCRT Then %>
						<h5><a href="rel_tecnologia_fabricante.asp?index=1" class="menu" target="_blank"><%=indicador%>Tecnologias empregadas</a><br />
		    				&nbsp;&nbsp;&nbsp;<small>Tecnologias utilizadas nos agendamentos e seus fabricantes</small></h5>

						<h5><a href="rel_orgao_atividade.asp?index=1" class="menu" target="_blank"><%=indicador%>&Oacute;rg&atilde;os Clientes</a><br />
	    					&nbsp;&nbsp;&nbsp;<small>Veja as atividades executadas no CRT pelos &oacute;g&atilde;os Embratel</small></h5>

						<h5><a href="rel_clienteexterno_atividade.asp?index=1" class="menu" target="_blank"><%=indicador%>Servi&ccedil;os para Clientes</a><br />
    						&nbsp;&nbsp;&nbsp;<small>Trabalhos voltados para clientes Embratel</small></h5>
                <% End If %>
                </div>

<% If usuarioCRT Then %>
                <div class="col-xs-12 col-sm-12 col-md-4 col-lg-4">

                    <div class="row">

                        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                            <h4 class="linha-destaque">Serviços e Agendamentos</h4>
	                        <h5><a href="cadAgendamentoCliente.asp" target="_parent">Agendamento de serviço</a></h5>
                            <h5><a href="rel_ativ.asp" target="_parent">Acompanhamento de agendamento</a></h5>
                            <h5><a href="form_remarca_teste_sel.asp" target="_parent">Remarcar/Cancelar agendamento</a></h5>
                            <h5><a href="sel_cad_logbook.asp" target="_parent">Log Book</a></h5>
                            <h5><a href="fale.asp" target="_parent">Sugestões (Fale Conosco)</a></h5>
                        </div>
                    </div>
                
                    <div class="row">

                        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                            <h4 class="linha-destaque">Informações de LogBook</h4>

							<script type="text/javascript">
							function chama_oc(cod_oc)
							{
								var selOC = document.getElementById("id_selOC");
								selOC.ocorrencia.value = cod_oc;
								selOC.submit();
							}
							</script>
							<form name="seloc" id="id_selOC" target="_parent" action="cad_evLogBook.asp" method="post">
								<input type="hidden" name="ocorrencia" value="">
							</form>
	
<%							IF Env.EhRat() Then %>

<%								chr_SQL = "select distinct LB_ID "
								chr_SQL = chr_SQL & "from LB_LOGBOOK "
								chr_SQL = chr_SQL & "where "
								chr_SQL = chr_SQL & "(LB_CONCLUIDOGQ = 0) AND LB_RATRESPONSAVEL IS NULL"
								Call Env.RecordSet(true, RS, chr_SQL) %>
								<p>
									<small>
										<span class="text-warning">Novas Ocorrências:</span>&nbsp;
<%								If Not (RS.EOF And RS.BOF) Then
									RS.Movefirst
									While Not RS.EOF %>
									<a href="javascript:chama_oc(<%=RS("LB_ID")%>);" class="link_ocs"><%=RS("LB_ID")%></a>
<%										RS.MoveNext
										if Not RS.EOF Then Response.Write ",&nbsp;"
									WEnd
								Else %>
									Nenhuma Ocorrência
<%								End If %>
									</small>
								</p>
	
<%								chr_SQL = "select distinct LB_ID "
								chr_SQL = chr_SQL & "from LB_LOGBOOK "
								chr_SQL = chr_SQL & "where "
								chr_SQL = chr_SQL & "(LB_CONCLUIDOGQ = 0) AND LB_RATRESPONSAVEL = '" & Env.Usuario() & "'"
								Call Env.RecordSet(true, RS, chr_SQL) %>
								<p>
									<small>
										<span class="text-warning">Em Análise:</span>&nbsp;
<%								If Not (RS.EOF And RS.BOF) Then
									RS.Movefirst
									While Not RS.EOF %>
									<a href="javascript:chama_oc(<%=RS("LB_ID")%>);" class="link_ocs"><%=RS("LB_ID")%></a>
<%										RS.MoveNext
										if Not RS.EOF Then Response.Write ",&nbsp;"
									WEnd
								Else %>
									Nenhuma Ocorrência
<%								End If %>
									</small>
								</p>
								
<%								chr_SQL = "Select Distinct LB_ID "
								chr_SQL = chr_SQL & "from LB_LOGBOOK "
								chr_SQL = chr_SQL & "Where "
								chr_SQL = chr_SQL & "(LB_ConcluidoGQ = 0) AND "
								chr_SQL = chr_SQL & "(LB_RespExec = '" & Env.Usuario & "') "
								Call Env.RecordSet(true, RS, chr_SQL) %>
								<p>
									<small>
										<span class="text-warning">Sob sua responsabilidade:</span>&nbsp;
<%								If Not (RS.EOF And RS.BOF) Then
									RS.Movefirst
									While Not RS.EOF %>
									<a href="javascript:chama_oc(<%=RS("LB_ID")%>);" class="link_ocs"><%=RS("LB_ID")%></a>
<%										RS.MoveNext
										if Not RS.EOF Then Response.Write ",&nbsp;"
									WEnd
								Else %>
									Nenhuma Ocorrência
<%								End If %>
									</small>
								</p>

<%								chr_SQL = "Select Distinct LB_ID "
								chr_SQL = chr_SQL & "from LB_LOGBOOK "
								chr_SQL = chr_SQL & "Where "
								chr_SQL = chr_SQL & "(LB_ConcluidoGQ = 0) AND "
								chr_SQL = chr_SQL & "(LB_UsernameCad = '" & Env.Usuario() & "') "
								Call Env.RecordSet(true, RS, chr_SQL) %>
								<p>
									<small>
										<span class="text-warning">Suas Ocorrências Cadastradas:</span>&nbsp;
<%								If Not (RS.EOF And RS.BOF) Then
									RS.Movefirst
									While Not RS.EOF %>
									<a href="javascript:chama_oc(<%=RS("LB_ID")%>);" class="link_ocs"><%=RS("LB_ID")%></a>
<%										RS.MoveNext
										if Not RS.EOF Then Response.Write ",&nbsp;"
									WEnd
								Else %>
									Nenhuma Ocorrência
<%								End If %>
									</small>
								</p>

<%							End If %>

                        </div>

                    </div> <!-- row -->

                </div>

                <div class="col-xs-12 col-sm-12 col-md-4 col-lg-4">
                    <div class="row">
                        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                            <% Call MostraNoticias() %>
                        </div>
                    </div> <!-- row -->

                    <br />

                    <div class="row">

                        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                            <% Call MostraFotos() %>
                        </div>

                    </div>  <!-- row -->

                </div> <!-- 3a coluna -->

<% Else '--> If usuarioCRT %>

                <div class="col-xs-12 col-sm-12 col-md-4 col-lg-4">
                    <div class="row">
                        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                            <% Call MostraNoticias() %>
                        </div>
                    </div> <!-- row -->

                </div> <!-- 2a coluna -->

                <div class="col-xs-12 col-sm-12 col-md-4 col-lg-4">

                    <div class="row">

                        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                            <% Call MostraFotos() %>
                        </div>

                    </div>  <!-- row -->

                </div> <!-- 3a coluna -->

<% End If '--> If usuarioCRT %>

            </div>

        </div>  <!-- container -->


        <br />


<%
If navegador <> "MSIE" Then
%>
		<!-- javascript do fancybox -->
		<script type="text/javascript" src="includes/jquery/jquery-3.3.1.min.js"></script>
		<script type="text/javascript" src="includes/fancybox-3.5.2-dist/jquery.fancybox.min.js"></script>
<%
End If
%>

<%
Call Tela.MostraRodape()


'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Funções para ajudar a montar os "quadros" da tela
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

Private Sub MostraNoticias %>

                            <h4 class="linha-destaque">Notícias</h4>

                                <div class="" id="datamain" style="max-width:300px; height: 100px; max-height: 100px; text-align: justify; word-wrap: break-word;">
                                    <script type="text/javascript">
                                        var pausecontent = new Array();
<%
        chr_SQL = "select * From Plantao Where PLA_DATATERMINO >= GETDATE() order by PLA_CODNOTICIA desc"
        Call Env.RecordSet(True, RS, chr_SQL)
        conta = 0

        If not (RS.EOF and RS.BOF) Then
            While Not RS.Eof
		        conta = conta + 1
                If Not(VVVNZ(RS("PLA_LINK")) or RS("PLA_LINK")="") Then %>
                                        pausecontent[<%=conta-1%>]= '<a href="#" onclick="javascript:novaJanela(<%=RS("pla_codnoticia")%>);"  target="_self"><%=Reticencias(trim(RS("PLA_TITNOTICIA")),80)%></a>';
<%		        Else%>
                                        pausecontent[<%=conta-1%>]= '<font ><%=Reticencias(RS("PLA_TitNoticia"),80)%></font>';
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
<%
End Sub


Private Sub MostraFotos %>

                            <h4 class="linha-destaque">Fotos</h4>
<%
    If navegador = "MSIE" Then
%>
                            <iframe src="fotos_crt.asp" frameborder="0" width="300" style="border: solid;" height="190" scrolling="no" name="teste_iframe">
                                Sorry your browser does not support IFRAMES.
						    </iframe>
<%
    Else %>
<%
     	chr_SQL = "SELECT TOP 15 ARQ_NOMEARQ, ARQ_LINK, ARQ_CODARQ " & _
		          "FROM Arquivos " & _
		          "WHERE ARQ_CODARQTIPO = " & Application("SISLAB_id_TipoArquivo_Imagem") & " " & _
                  "ORDER BY NEWID()"
	    Call Env.RecordSet(True, RS, chr_SQL)
        While Not RS.Eof %>
                            <a href="arquivos/<%=RS("ARQ_NOMEARQ")%>" data-fancybox="gallery" data-caption="<%=RS("ARQ_LINK")%>" class="fancybox">
                                <img class="mySlides" title="<%=RS("ARQ_LINK")%>" src="arquivos/<%=RS("ARQ_NOMEARQ")%>" style="width:300px; height: 190px; border: solid;" >
                            </a>
<%          RS.MoveNext
        WEnd
        Call Env.RecordSet(False, RS, "")
%>
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
<%
    End If
%>
<%
End Sub

%>
