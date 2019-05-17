<html>
<head>
    <title>TESTE NAVBAR</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>


    <style type="text/css">
        .dropdown-submenu{ position: relative; }
        .dropdown-submenu>.dropdown-menu{
          top:0;
          left:100%;
          margin-top:-6px;
          margin-left:-1px;
          -webkit-border-radius:0 6px 6px 6px;
          -moz-border-radius:0 6px 6px 6px;
          border-radius:0 6px 6px 6px;
        }
        .dropdown-submenu>a:after{
          display:block;
          content:" ";
          float:right;
          width:0;
          height:0;
          border-color:transparent;
          border-style:solid;
          border-width:5px 0 5px 5px;
          border-left-color:#cccccc;
          margin-top:5px;margin-right:-10px;
        }
        .dropdown-submenu:hover>a:after{
          border-left-color:#555;
        }
        .dropdown-submenu.pull-left{ float: none; }
        .dropdown-submenu.pull-left>.dropdown-menu{
          left: -100%;
          margin-left: 10px;
          -webkit-border-radius: 6px 0 6px 6px;
          -moz-border-radius: 6px 0 6px 6px;
          border-radius: 6px 0 6px 6px;
        }

        /*
        @media (min-width: 768px) { 
        }
        @media (min-width: 992px) { 
        }
        @media (min-width: 1200px) { 
        }
        */
    </style>
</head>

<body>
    <nav class="navbar navbar-collapse navbar-fixed-top">
      <div class="container-fluid">
        <div class="navbar-header">
            <button type="button"class="navbar-toggle"data-toggle="collapse" data-target="#example-navbar-collapse">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
          <a class="navbar-brand" href="#">SCE</a>
        </div>

        <div class="collapse navbar-collapse" id="example-navbar-collapse">
          <ul class="nav navbar-nav navbar-left">
               <ul class="nav navbar-nav">
                    <li class="active"><a href="#">PRINCIPAL</a></li>

                    <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">SERVIÇOS<span class="caret"></span></a>
                      <ul class="dropdown-menu">
                        <li class="dropdown dropdown-submenu"><a href="#" class="dropdown-toggle" data-toggle="dropdown">Agendamentos</a>
                            <ul class="dropdown-menu">
                                <li><a href="#">Novo</a></li>
                                <li><a href="#">Acompanhamento de Resultados</a></li>
                                <li><a href="#">Remarcar</a></li>
                                <li><a href="#">Relatório de Acompanhamento</a></li>
                            </ul>
                        </li>
                        <li class="dropdown dropdown-submenu"><a href="#" class="dropdown-toggle" data-toggle="dropdown">Conhecendo o CRT</a>
                            <ul class="dropdown-menu">
                              <li><a href="#">Ambientes</a></li>
                              <li><a href="#">Código de Ética</a></li>
                              <li><a href="#">Equipe / Infra-estrutura interna</a></li>
                              <li><a href="#">Espaço CRT</a></li>
                              <li><a href="#">Histórico</a></li>
                              <li><a href="#">Localização / Área</a></li>
                              <li><a href="#">Manual do Sistema de Gestão</a></li>
                              <li><a href="#">Vídeos do CRT</a></li>
                            </ul>
                        </li>
                        <li class="divider"></li>
                        <li><a href="#">Controle de Equipamentos (SCE)</a></li>
                        <li class="divider"></li>
                        <li><a href="#">Sistemas de Gestão</a></li>
                        <li><a href="#">Lista de Atividades do CRT</a></li>
                        <li><a href="#">Log Book</a></li>
                        <li><a href="#">Ocupação dos Ambientes</a></li>
                        <li class="dropdown dropdown-submenu"><a href="#" class="dropdown-toggle" data-toggle="dropdown">Pesquisa de Satisfação</a>
                            <ul class="dropdown-menu">
                              <li><a href="#">Cadastrar</a></li>
                              <li><a href="#">Consultar por AS</a></li>
                            </ul>
                        </li>
                        <li class="dropdown dropdown-submenu"><a href="#" class="dropdown-toggle" data-toggle="dropdown">Recursos Disponíveis</a>
                            <ul class="dropdown-menu">
                              <li><a href="#">Logística</a></li>
                              <li><a href="#">Sala de Apoio</a></li>
                              <li><a href="#">Transporte para o CRT</a></li>
                            </ul>
                        </li>
                      </ul>
                    </li>

                    <li class="#"><a href="#">ADMINISTRAÇÃO DO SITE</a></li>

                    <li class="#"><a href="#">FALE CONOSCO</a></li>

                <li><a href="#"><span class="glyphicon glyphicon-search"></span></a></li>
              </ul>  
          </ul>

            <div>
                <ul class="nav navbar-nav navbar-right">
                    <ul class="nav navbar-nav">
                        <li><a href="#">AQUI !!!</a></li>
                    </ul>
                </ul>
            </div>

        </div>


      </div>
    </nav>

    <script type="text/javascript">
        /* PRECISA DISSO PARA FUNCIONAR O SUBMENU */
        (function ($) {
            $(document).ready(function () {
                $('ul.dropdown-menu [data-toggle=dropdown]').on('click', function (event) {
                    event.preventDefault();
                    event.stopPropagation();
                    $(this).parent().siblings().removeClass('open');
                    $(this).parent().toggleClass('open');
                });
            });
        })(jQuery);
    </script>







    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    AQUI
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />





</body>
</html>