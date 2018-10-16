<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/EmailHTML.asp" -->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/Sislab_Lib.asp"-->

<!DOCTYPE html>

<html>
    <head>
        <title>TESTE BOOTSTRAP</title>
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <meta name="viewport" content="width=device-width, initial-scale==1.0">
        <link rel="stylesheet" href="includes/bootstrap-3.3.7-dist/css/bootstrap.min.css" media="screen">
    </head>

    <body>
        <style>
            .linha_fundo {
                background: LightBlue;
            }
        </style>

        <div class="container">
            <h1>CENTRO DE REFERÊNCIA TECOLÓGICA</h1>

            <div class="row">
                <div class="col-xs-12 col-sm-12 col-md-4 col-lg-4 linha_fundo">

                    <h4>Serviços e Agendamentos</h4>
	                <h6><a href="cadAgendamentoCliente.asp" target="_parent">Agendamento de serviço</a></h6>
                    <h6><a href="rel_ativ.asp" target="_parent">Acompanhamento de agendamento</a></h6>
                    <h6><a href="form_remarca_teste_sel.asp" target="_parent">Remarcar/Cancelar agendamento</a></h6>
                    <h6><a href="sel_cad_logbook.asp" target="_parent">Log Book</a></h6>
                    <h6><a href="fale.asp" target="_parent">Sugestões (Fale Conosco)</a></h6>

                </div>

                <div class="col-xs-12 col-sm-12 col-md-4 col-lg-4">

                    <div class="row">
                        <div class="col-xs-12 col-sm-12 col-md-11 col-md-offset-1 col-lg-11 col-lg-offset-1 linha_fundo">
                            <h4>Informações de LogBook</h4>
                            <p>Aqui entram as informações 1</p>
                            <p>Aqui entram as informações 2</p>
                        </div>
                    </div>
    
                </div>

                <div class="col-xs-12 col-sm-12 col-md-4 col-lg-4">

                    <div class="row">
                        <div class="col-xs-12 col-sm-12 col-md-11 col-md-offset-1 col-lg-11 col-lg-offset-1 linha_fundo">
                            <h4>Notícias</h4>
					        <span class="texto1" style="font-size: 9px;"><i>Clique na notícia para abrir</i></span>

                        </div>
                    </div>
                </div>

            </div>

        </div>

        <br />

        <div class="container">
            <div class="row">
                <div class="col-xs-12 col-sm-7 col-md-9 col-lg-8 linha_fundo">
                    <h3>Acha Fácil CRT</h3>

                    <div class="row">
                        <div class="col-xs-12 col-sm-5 col-md-5 col-lg-5">
                            <h5><a href="CadAgendamentoCliente.asp">Agende um servi&ccedil;o no CRT</a><br />
							&nbsp;&nbsp;&nbsp;<small>Cadastre o seu servi&ccedil;o, uma visita ou uma palestra no CRT</small></h5>

                        </div>

                        <div class="col-xs-12 col-sm-5 col-sm-offset-2 col-md-5 col-md-offset-2 col-lg-5 col-lg-offset-2">
						    <h5><a href="rel_ativ.asp" class="menu">Acompanhamento e Resultados</a><br />
						    &nbsp;&nbsp;&nbsp;<small>Informações dos agendamentos no CRT</small></h5>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-xs-12 col-sm-5 col-md-5 col-lg-5">
							<h5><a href="sit_crt.asp?hoje=1" onClick="javascript: showAguarde();" class="menu"><%=indicador%>Em execução no CRT</a><br />
							&nbsp;&nbsp;&nbsp;<small>Veja os agendamentos do dia</small></h5>
                        </div>

                        <div class="col-xs-12 col-sm-5 col-sm-offset-2 col-md-5 col-md-offset-2 col-lg-5 col-lg-offset-2">
							<h5><a href="sit_crt.asp" class="menu"><%=indicador%>Lista de Atividades no CRT</a><br />
							&nbsp;&nbsp;&nbsp;<small>Servi&ccedil;os em andamento no CRT</small></h5>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-xs-12 col-sm-5 col-md-5 col-lg-5">
							<h5><a href="pesqscr.asp?emjanela=1" class="menu" target="_blank"><%=indicador%>Pesquisa de Satisfa&ccedil;&atilde;o</a><br />
				    			&nbsp;&nbsp;&nbsp;<small>D&egrave; a sua opini&atilde;o sobre nossos servi&ccedil;os</small></h5>
                        </div>

                        <div class="col-xs-12 col-sm-5 col-sm-offset-2 col-md-5 col-md-offset-2 col-lg-5 col-lg-offset-2">
							<h5><a href="form_remarca_teste_sel.asp" class="menu"><%=indicador%>Remarcar Agendamento</a><br />
			    				&nbsp;&nbsp;&nbsp;<small>Altere a data do seu agendamento no CRT</small></h5>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-xs-12 col-sm-5 col-md-5 col-lg-5">
							<h5><a href="rel_tecnologia_fabricante.asp?index=1" class="menu" target="_blank"><%=indicador%>Tecnologias empregadas</a><br />
		    					&nbsp;&nbsp;&nbsp;<small>Tecnologias utilizadas nos agendamentos e seus fabricantes</small></h5>
                        </div>

                        <div class="col-xs-12 col-sm-5 col-sm-offset-2 col-md-5 col-md-offset-2 col-lg-5 col-lg-offset-2">
							<h5><a href="rel_orgao_atividade.asp?index=1" class="menu" target="_blank"><%=indicador%>&Oacute;rg&atilde;os Clientes</a><br />
	    						&nbsp;&nbsp;&nbsp;<small>Veja as atividades executadas no CRT pelos &oacute;g&atilde;os Embratel</small></h5>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
							<h5><a href="rel_clienteexterno_atividade.asp?index=1" class="menu" target="_blank"><%=indicador%>Servi&ccedil;os para Clientes</a><br />
    							&nbsp;&nbsp;&nbsp;<small>Trabalhos voltados para clientes Embratel</small></h5>
                        </div>
                    </div>
                </div>

                <div class="col-xs-12 col-sm-12 col-md-4 col-lg-4">
                    <div class="row">
                        <div class="col-xs-12 col-sm-12 col-md-11 col-md-offset-1 col-lg-11 col-lg-offset-1 linha_fundo">

                            <h4>Fotos</h4>
							<span class="texto1" style="font-size: 9px;"><i>Clique na foto para ampliar</i></span>

                        </div>
                    </div>
                </div>
            </div>

        </div>


        <script src="includes/bootstrap-4.1.3-dist/js/jquery-3.3.1.min.js"></script>
        <script src="includes/bootstrap-4.1.3-dist/js/bootstrap.min.js"></script>
    </body>

</html>
