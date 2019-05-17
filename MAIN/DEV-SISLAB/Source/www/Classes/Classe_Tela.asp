<%
'+-----------------------------------------------------------------------------------------------------
'+ Classe criada para armazenar as rotinas de tela do sistema
'+
'+ dependencia: Classe_Environment.asp
'+              Classe_Mensagem.asp
'+              Global.asp
'+ 20/03/2012 
'+-----------------------------------------------------------------------------------------------------
Class TTela

Private bln_TemErro
Private chr_MsgErro

Private p_estilo
Private p_CharSet
Private p_titulo
Private p_imprimeMenu
Private p_imprimeImagem
Private p_tamanhoTela
Private p_nomeTela
Private p_linkVoltar
Private p_PathRelativo
Public Mensagem

'-------------------------------------------------------------------------
Private Sub Class_Initialize()
    bln_TemErro = False
    chr_MsgErro = ""

    p_titulo = TITULO_SITE
    p_imprimeMenu = True
    p_imprimeImagem = True
    p_tamanhoTela = "100%"
    p_nomeTela = ""
    p_linkVoltar = "history.go(-1)"
    p_PathRelativo = ""
    p_estilo = "principal.css"

    If Application("SISLAB_CHARSET") = "" Then
        p_CharSet = "iso-8859-1"
    Else
        p_CharSet = Application("SISLAB_CHARSET")
    End If

    Set Mensagem = New TMensagem
End Sub

Private Sub Class_Terminate()
End Sub

'-------------------------------------------------------------------------

Public Property Let SetTitulo(titulo)
	p_titulo = titulo
End Property

Public Property Let SetMostraMenu(imprimeMenu)
	p_imprimeMenu = imprimeMenu
End Property

Public Property Let SetMostraImagem(imprimeImagem)
	p_imprimeImagem = imprimeImagem
End Property

Public Property Let SetTamanhoTela(tamanhoTela)
	p_tamanhoTela = tamanhoTela
End Property

Public Property Let SetNomeTela(nomeTela)
	p_nomeTela = nomeTela
End Property

Public Property Let SetLinkVoltar(linkVoltar)
	p_linkVoltar = linkVoltar
End Property

Public Property Let SetCaminhoRelativo(pathRelativo)
	p_PathRelativo = pathRelativo
End Property

'-------------------------------------------------------------------------
Public Sub MostraCabecalho
    Call Me.ImprimeCabecalho2(p_titulo, p_imprimeMenu, p_imprimeImagem, p_tamanhoTela, p_nomeTela, p_linkVoltar, p_PathRelativo)
End Sub

'mantida para ter um pouco de compatibilidade com as chamadas jÃ¡ existentes
Public Sub ImprimeCabecalho2(titulo, imprimeMenu, imprimeImagem, tamanhoTela, nomeTela, linkVoltar, PathRelativo)
	Dim chr_Buffer
	Dim usuario

    usuario = Env.Usuario

    p_titulo = titulo
    p_imprimeMenu = imprimeMenu
    p_imprimeImagem = imprimeImagem
    p_tamanhoTela = IIf(tamanhoTela = "", p_tamanhoTela, tamanhoTela)
    p_nomeTela = nomeTela
    p_linkVoltar = linkVoltar
    p_PathRelativo = PathRelativo

    Response.CharSet = Application("SISLAB_CHARSET")
    Response.Clear
	Response.Addheader "Expires","Mon, 26 Jul 1997 05:00:00 GMT"
	Response.Addheader "Cache-Control","no-cache, must-revalidate"
	Response.Addheader "Pragma","no-cache"
	Response.Buffer = True
	Response.Expires=0

	'-- verifica se a sessao esta expirada
	dim w
	w = "770px" '-- tamanho da coluna


	chr_Buffer = VbCrLf & _ 
	    	"<!DOCTYPE html>" & VbCrLf & _
	  		"" & VbCrLf & _
			"<html>" & VbCrLf & _
			"	<head>" & VbCrLf & _
			"	    <title>" & VbCrLf

	'-- Indica em que modo o sistema estÃ¡ sendo executado
	If Application("SISLAB_AMBIENTE") <> "PRO" Then _
			chr_Buffer = chr_Buffer & "[" & Application("SISLAB_AMBIENTE") & "] "

	if titulo = "" or IsEmpty(titulo) then
		chr_Buffer = chr_Buffer & "SISLAB - Site do Centro de ReferÃªncia TecnolÃ³gica"
	else
		chr_Buffer = chr_Buffer & titulo
	end if

'tag do html 4
'		"	<meta http-equiv='Content-Type' content='text/html;' charset='iso-8859-1'>" & VbCrLf

	chr_Buffer = chr_Buffer & _
		"       </title>" & VbCrLf & _
        "       <meta charset='" & p_CharSet & "'>" & VbCrLf & _
        "       <meta http-equiv='x-ua-compatible' content='ie=edge'>" & VbCrLf & _
        "       <meta name='viewport' content='width=device-width, initial-scale==1.0'>" & VbCrLf & _
        "       <link rel='stylesheet' href='" & PathRelativo & "includes/bootstrap-3.3.7-dist/css/bootstrap.min.css' media='screen'>" & VbCrLf & _
		"       <link rel='stylesheet' type='text/css' href='" & PathRelativo & "estilos/" & p_estilo & "' />" & VbCrLf & _
		"       <link rel='stylesheet' href='https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css'>" & VbCrLf & _
		"       <script src='https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js'></script>" & VbCrLf & _
		"       <script src='https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js'></script>" & VbCrLf & _
		"   </head>" & VbCrLf

	chr_Buffer = chr_Buffer & _
		"<script language='JavaScript' src='" & PathRelativo & "includes/currency.js'></script>" & VbCrLf & _
		"<script language='JavaScript' src='" & PathRelativo & "includes/relogio.js'></script>" & VbCrLf

	chr_Buffer = chr_Buffer & _
		"<body onunload='javascript: hideAguarde();' style='margin-right: 18px;'>"

	chr_Buffer = chr_Buffer & _
        "<div class='XXXcontainer' style='XXXbackground-color: silver;'>"

	chr_Buffer = chr_Buffer & _
		"<div id='divAguarde' class='tempo' style='display: none;'><table><tr><td><img src='" & PathRelativo & "img/tempo.gif' alt='Aguarde'></td><td>&nbsp;&nbsp;Aguarde...</td></tr></table></div>" & VbCrLf

	Response.Write chr_Buffer

	If p_imprimeImagem Then
	    Call ImprimeImagemSite()
	End If	'Imprime Tela   
%>

<!--------------------- Imprime o nome do formulÃ¡rio na tela --------------------->
<%  If p_nomeTela <> "" And usuario <> "" then
        Call ImprimeNomeTela
	End If
%>
<!--------------------- Imprime a tela Principal --------------------->

		<table id="tr_princ_conteudo" cellpadding="2" cellspacing="2" border="0" style="width: <%=p_tamanhoTela%>;">
		<tr>
			<td>
<%
    'mostra mensagem de acesso nÃ£o autorizado ao sistema
    If usuario = "" Then
        Response.Write Mensagem.AcessoNegadoSistema
        Call MostraRodape()
        Response.End
	End If

End Sub

Private Sub ImprimeImagemSite()
    Dim w_princ
    Dim PathRelativo

    w_princ = p_tamanhoTela
    PathRelativo = p_PathRelativo
%>
<%
    If p_imprimeMenu And Env.Usuario <> "" Then
        Call ImprimeMenu()
    end if
%>
<!--
		<table style="width: <%=w_princ%>;" >
        <tr>
            <td background="<%=PathRelativo%>img/titulo_bg.jpg" height="70" style="vertical-align: bottom;">
                <div style="width: 100%;">
                    <div style="float:left; ">
                            <img src="<%=PathRelativo%>img/titulo_esquerda.jpg" border="0" 
                                id="imgTituloEsquerda"  vertical-align: top;">
                            <img src="<%=PathRelativo%>img/titulo_centro.jpg" height="70"
                                border="0" id="imgTituloCentro" style="display: inline; vertical-align: bottom;">

                    </div>

                    <div style="float: right;">
                            <img src="<%=PathRelativo%>img/titulo_direita.jpg" height="70" border="0" id="imgTituloDireita" 
                                style="display: inline; vertical-align: bottom;">
                    </div>

<%  If Env.Usuario <> "" Then %>
                    <div style="float: right; text-align:right; top: 0px; vertical-align: top;">
                        <p style="line-height: 14px;">&nbsp;</p>
				        <h6>
                            <%=Env.nomeAppHtml%><br />
					        <%=Env.Ebt.NomeReduzido%><br />
					        <%=Env.Usuario%>
				        </h6>
                    </div>
<%  End If %>
                </div>
            </td>
        </tr>
        </table>
-->
<%
End Sub

Private Sub ImprimeMenu()
    Dim userCRT, userRatRt

    userCRT = Env.usuarioCRT
    userRatRt = (Env.ehRAT or Env.ehRT)
%>
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

    <nav class="navbar navbar-default navbar-static-top">
      <div class="container-fluid">
        <div class="navbar-header">
            <button type="button"class="navbar-toggle"data-toggle="collapse" data-target="#example-navbar-collapse">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="<%=p_PathRelativo%>index.asp" style="background-color: darkblue; color: white;">
                <span class="glyphicon glyphicon-menu-hamburger"></span> Centro de Referência Tecnológica
            </a>
        </div>

        <div class="collapse navbar-collapse" id="example-navbar-collapse">
          <ul class="nav navbar-nav navbar-left">
               <ul class="nav navbar-nav">
                    <!-- <li class="active"><a href="#">PRINCIPAL</a></li> -->

                    <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">SERVIÇOS<span class="caret"></span></a>
                      <ul class="dropdown-menu">
                        <li class="dropdown dropdown-submenu"><a href="#" class="dropdown-toggle" data-toggle="dropdown">Agendamentos</a>
                            <ul class="dropdown-menu">
                                <li><a href="<%=p_PathRelativo%>CadAgendamentoCliente.asp" title="Cria um agendamento">Novo</a></li>
                                <li><a href="<%=p_PathRelativo%>rel_ativ.asp" title="Acompanha a execução de um agendamento e seu resultado">Acompanhamento de Resultados</a></li>
                                <li><a href="<%=p_PathRelativo%>form_remarca_teste_sel.asp" title="Remarca a execução de um agendamento">Remarcar</a></li>
    <%				If userCRT Then %>
                                <li><a href="<%=p_PathRelativo%>rel_gq_filtro.asp" title="Relatório de acompanhamento de um agendamento">Relatório de Acompanhamento</a></li>
    <%				End If %>
                            </ul>
                        </li>
                        <li class="dropdown dropdown-submenu"><a href="#" class="dropdown-toggle" data-toggle="dropdown">Conhecendo o CRT</a>
                            <ul class="dropdown-menu">
    <%				If userCRT Then%>
                              <li><a href="<%=Application("SISLAB_ServidorLocalCRT")%>plantacrt/labcrt1.htm" title="Ambientes de acomodação e salas disponí­veis">Ambientes</a></li>
    <%				End If %>
                              <li><a href="<%=Env.ObtemLinkCodigoEtica()%>" title="Código de Ética">Código de Ética</a></li>
                              <li><a href="<%=p_PathRelativo%>equ_EstIn.asp" title="Equipe / Infra-estrutura Interna">Equipe / Infra-estrutura interna</a></li>
	<%			    If userCRT Then %>
                              <li><a href="http://XPRJO030309/index.htm" title="Espaço reservado aos trabalhos internos do CRT">Espaço CRT</a></li>
                              <li><a href="<%=Application("SISLAB_ServidorLocalCRT")%>Historico.pdf" title="Histórico do Centro de Referência Tecnológica">Histórico</a></li>
                              <li><a href="<%=p_PathRelativo%>loc_area.asp" title="Localização e Área construí­da">Localização / Área</a></li>
    <%				End If %>
                              <li><a href="<%=Env.ObtemLinkManualSistemaGestao()%>">Manual do Sistema de Gestão</a></li>
	<%			    If userCRT Then %>
                              <li><a href="<%=p_PathRelativo%>videos.asp">Vídeos do CRT</a></li>
    <%				End If %>
                            </ul>
                        </li>
                        <li class="divider"></li>
	<%			    If userCRT Then %>
                        <li><a href="<%=p_PathRelativo%>sce2/index.asp">Controle de Equipamentos (SCE)</a></li>
                        <li class="divider"></li>
                        <li><a href="<%=p_PathRelativo%>arq_disp.asp" title="Arquivos do sistema de gestão disponí­veis para visualização">Sistemas de Gestão</a></li>
    <%				End If %>
                        <li><a href="<%=p_PathRelativo%>sit_crt.asp" title="Exibe as atividades do CRT">Lista de Atividades do CRT</a></li>
	<%			    If userCRT Then %>
                        <li><a href="<%=p_PathRelativo%>sel_cad_logbook.asp" title="Cadastro de Ocorrências">Log Book</a></li>
                        <li><a href="<%=p_PathRelativo%>ambientes/cons_agenda.asp" title="Cadastro e reserva de salas">Ocupação dos Ambientes</a></li>
    <%				End If %>
                        <li class="dropdown dropdown-submenu"><a href="#" class="dropdown-toggle" data-toggle="dropdown">Pesquisa de Satisfação</a>
                            <ul class="dropdown-menu">
                              <li><a href="<%=p_PathRelativo%>pesqscr.asp" title="Cadastra uma nova pesquisa de satisfação">Cadastrar</a></li>
	<%			    If userCRT Then %>
                              <li><a href="<%=p_PathRelativo%>cons_ind_pesqscr_filtro.asp" title="Consulta uma pesquisa por número do agendamento">Consultar por AS</a></li>
    <%				End If %>
                            </ul>
                        </li>
                        <li class="dropdown dropdown-submenu"><a href="#" class="dropdown-toggle" data-toggle="dropdown">Recursos Disponíveis</a>
                            <ul class="dropdown-menu">
	<%			    If userCRT Then %>
                              <li><a href="<%=Application("SISLAB_ServidorLocalCRT")%>Logistica.pdf">Logística</a></li>
                              <li><a href="<%=Application("SISLAB_ServidorLocalCRT")%>SalaApoio.pdf">Sala de Apoio</a></li>
    <%				End If %>
                              <li><a href="<%=p_PathRelativo%>CadTransporte.asp" title="Horários do transporte para o CRT">Transporte para o CRT</a></li>
                            </ul>
                        </li>
                      </ul>
                    </li>

	<%			    If userRatRt Then %>
                    <li class="#"><a href="<%=p_PathRelativo%>sislab.asp">ADMINISTRAÇÃO DO SITE</a></li>
    <%				End If %>

                    <li class="#"><a href="<%=p_PathRelativo%>fale.asp">FALE CONOSCO</a></li>

                    <!--<li><a href="#"><span class="glyphicon glyphicon-search"></span></a></li>-->
               </ul>
          </ul>

            <div>
                <ul class="nav navbar-nav navbar-right">
                    <ul class="nav navbar-nav">
                        <li class="#">
                            <small>
                                <span style="color: darkblue; font-weight:bold;">
                                    <%=Env.nomeAppHtml%>&nbsp;&nbsp;&nbsp;<br />
					                <%=Env.Ebt.NomeReduzido%> (<%=Env.Usuario%>)&nbsp;
                                </span>
                            </small>
                        </li>
                        
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

<%
End Sub

Private Sub ImprimeMenu1() %>
<script type="text/javascript" language="JavaScript1.2">
	<!--
    var st_path = "<%=p_PathRelativo%>includes/";
    var st_lib = "stm31.js";
    document.open();
    document.write("<" + "script type='text/javascript' src='" + st_path + st_lib + "'><" + "/script>");
    document.close();
	//-->
</script>

<script type="text/javascript">
    <!--
    stm_bm(["tubtehr",400,"","<%=p_PathRelativo%>img/blank.gif",1,"0","stgct()",0,0,250,0,1000,1,0,0,"","",0],this);
    stm_bp("p0",[0,4,0,0,0,2/*Height*/,0,7,100,"",-2,"",-2,90,0,0,"#000000","transparent","",3,3,2,"#ffffff #ffffff #006699 #ffffff"]);
    stm_ai("p0i0",[0,"Principal","","",-1,-1,0,"<%=p_PathRelativo%>index.asp","_self","","Retorna à página principal","","",0,0,0,"","",0,0,0,0,1,"#cccccc",0,"#006699",0,"","",3,3,0,0,"#ffffff","#ffffff","#006699","#ffffff","bold 7pt 'Arial','Verdana'","bold 7pt Arial",0,0]);
    stm_ai("p0i1",[6,15,"#ffffff","",-1,-1,0]); /*separador*/
    stm_aix("p0i1","p0i0",[0,"Serviços","","",-1,-1,0,"","_self","","Serviços e Agendamentos","","",0,0,0,"<%=p_PathRelativo%>img/arrow_r.gif","<%=p_PathRelativo%>img/arrow_r.gif",7,7,0,0,1,"#ffffff",0,"#ffffff",0,"","",3,3,0,0,"#ffffff","#ffffff","#006699","#000000","7pt Arial","7pt Arial"]);
    stm_bp("p1",[1,4,0,0,0,3,0,7,100,"",-2,"",-2,90,0,0,"#000000","transparent","",3,1,1,"#006699"]);
    stm_aix("p1i0","p0i1",[0,"Agendamentos","","",-1,-1,0,"","_self","","Agendamentos - Opções"]);
    stm_bp("p2",[1,2,0,0,0,3,0,0,100,"",-2,"",-2,90,0,0,"#7f7f7f","#ffffff","",3,1,1,"#000000"]);
    stm_aix("p2i0","p0i1",[0,"Novo","","",-1,-1,0,"<%=p_PathRelativo%>CadAgendamentoCliente.asp","_self","","Cria um agendamento","","",0,0,0,"","",0,0]);
    stm_aix("p2i1","p2i0",[0,"Acompanhamento e Resultados","","",-1,-1,0,"<%=p_PathRelativo%>rel_ativ.asp","_self","","Acompanha a execução de um agendamento e seu resultado"]);
    stm_aix("p2i2","p2i0",[0,"Remarcar","","",-1,-1,0,"<%=p_PathRelativo%>form_remarca_teste_sel.asp","_self","","Remarca a execução de um agendamento"]);
    <%				If Env.UsuarioCRT Then %>
    stm_aix("p2i3","p0i1",[0,"Relatório de Acompanhamento","","",-1,-1,0,"<%=p_PathRelativo%>REL_GQ_filtro.asp","_self","","Relatório de acompanhamento de um agendamento","","",0,0,0,"","",0,0,0,0,1,"#ffffff",0,"#ffffff",0,"","",3,3,0,0,"#ffffff","#ffffff","#cc0000"]);
    <%				End If %>
    stm_ep();
    stm_aix("p1i1","p0i1",[0,"Conhecendo o CRT","","",-1,-1,0,"","_self","","Conhecendo o CRT"]);
    stm_bpx("p3","p2",[]);
    <%				If Env.UsuarioCRT Then%>
    stm_aix("p3i0","p2i0",[0,"Ambientes","","",-1,-1,0,"<%=Application("SISLAB_ServidorLocalCRT")%>plantacrt/labcrt1.htm","_blank","","Ambientes de acomodação e salas disponí­veis"]);
    <%				End If %>

    stm_aix("p3i1", "p2i0", [0, "Código de Ética", "", "", -1, -1, 0, "<%=Env.ObtemLinkCodigoEtica()%>", "_blank", "", "Código de Ética"]);
    stm_aix("p3i2","p2i0",[0,"Equipe / Infra-estrutura Interna","","",-1,-1,0,"<%=p_PathRelativo%>equ_EstIn.asp","_self","","Equipe / Infra-estrutura Interna"]);

    <%				'-- se for do CRT exibe o link para o servidor local
				    If Env.usuarioCRT Then %>
    stm_aix("p3i3","p2i3",[0,"Espaço CRT","","",-1,-1,0,"http://XPRJO030309/index.htm","_self","","Espaço reservado aos trabalhos internos do CRT"]);
    <%				End If %>

    <%				If Env.UsuarioCRT Then%>
    stm_aix("p3i4","p2i0",[0,"Histórico","","",-1,-1,0,"<%=Application("SISLAB_ServidorLocalCRT")%>Historico.pdf","_blank","","Histórico do Centro de Referência Tecnológica"]);
    <%				End If %>

    <%				If Env.UsuarioCRT Then%>
    stm_aix("p3i5", "p2i0", [0, "Localização / Área", "", "", -1, -1, 0, "<%=p_PathRelativo%>loc_area.asp", "_self", "", "Localização e Área construí­da"]);
    <%				End If %>

    stm_aix("p3i6", "p2i0", [0, "Manual do Sistema de Gestão", "", "", -1, -1, 0, "<%=Env.ObtemLinkManualSistemaGestao()%>", "_blank", "", "Manual do Sistema de Gestão"]);

    <% If Env.UsuarioCRT Then %>
    stm_aix("p3i7","p2i0",[0,"Vídeos do CRT","","",-1,-1,0,"videos.asp","_self","","Ví­deos do CRT"]);
    <%				End If %>

    stm_ep();

    <%				If Env.UsuarioCRT Then%>
    //stm_aix("p1i2","p3i7",[0,"Controle de Consumí­veis (SCC)","","",-1,-1,0,"<%=p_PathRelativo%>scc/index.asp","_self","","Sistema de Controle de Consumí­veis","","",0,0,0,"","",0,0,0,0,1,"#ffffff",0,"#ffffff",0,"","",3,3,0,0,"#ffffff","#ffffff","#cc0000"]);
    stm_aix("p1i2","p3i7",[0,"Controle de Equipamentos (SCE)","","",-1,-1,0,"<%=p_PathRelativo%>sce2/index.asp","_self","","Sistema de Controle de Equipamentos","","",0,0,0,"","",0,0,0,0,1,"#ffffff",0,"#ffffff",0,"","",3,3,0,0,"#ffffff","#ffffff","#cc0000"]);
    stm_aix("p1i3","p2i0",[0,"Sistemas de Gestão","","",-1,-1,0,"<%=p_PathRelativo%>arq_disp.asp","_self","","Arquivos do sistema de gestão disponí­veis para visualização"]);
    <%				End If%>

    stm_aix("p1i4","p2i0",[0,"Lista de Atividades do CRT","","",-1,-1,0,"<%=p_PathRelativo%>sit_crt.asp","_self","","Exibe as atividades do CRT"]);

    <% If Env.UsuarioCRT Then %>
    stm_aix("p1i5","p2i0",[0,"Log Book","","",-1,-1,0,"<%=p_PathRelativo%>sel_cad_logbook.asp","_self","","Log Book - cadastro de ocorrências"]);
    stm_aix("p1i6", "p2i0", [0, "Ocupação dos Ambientes", "", "", -1, -1, 0, "<%=p_PathRelativo%>ambientes/cons_agenda.asp", "_self", "", "Cadastro e reserva de salas"]);
    <%				End If%>

    stm_aix("p1i7","p0i1",[0,"Pesquisa de Satisfação","","",-1,-1,0,"","_self","","Pesquisa de Satisfação"]);
    stm_bpx("p4","p2",[]);
    stm_aix("p4i0","p2i0",[0,"Cadastrar","","",-1,-1,0,"<%=p_PathRelativo%>pesqscr.asp","_self","","Cadastra uma nova pesquisa de satisfação"]);

    <%				If Env.UsuarioCRT Then%>
    stm_aix("p4i1", "p2i0", [0, "Consultar por AS", "", "", -1, -1, 0, "<%=p_PathRelativo%>cons_ind_pesqscr_filtro.asp", "_self", "", "Consulta uma pesquisa por número do agendamento"]);
    <%				End If%>

    stm_ep();
    stm_aix("p1i8","p0i1",[0,"Recursos Disponí­veis","","",-1,-1,0,"","_self","","Recursos Disponí­veis"]);
    stm_bpx("p5","p2",[]);
    <%				If Env.UsuarioCRT Then%>
    stm_aix("p5i0","p2i0",[0,"Logística","","",-1,-1,0,"<%=Application("SISLAB_ServidorLocalCRT")%>Logistica.pdf","_blank","","Logí­stica"]);
    stm_aix("p5i1","p2i0",[0,"Salas de Apoio","","",-1,-1,0,"<%=Application("SISLAB_ServidorLocalCRT")%>SalaApoio.pdf","_blank","","Salas de Apoio"]);
    <%				End If%>
    stm_aix("p5i2","p2i0",[0,"Transporte para o CRT","","",-1,-1,0,"<%=p_PathRelativo%>CadTransporte.asp","_self","","Horários do transporte para o CRT"]);
    stm_ep();
    //stm_aix("p1i9","p2i0",[0,"SugestÃµes (Fale Conosco)","","",-1,-1,0,"<%'=PathRelativo%>fale.asp","_self","","Fale Conosco"]);
    stm_ep();
    <%				if Env.ehRAT or Env.ehRT then %>
    stm_ai("p0i1",[6,15,"#ffffff","",-1,-1,0]); /*separador*/
    stm_aix("p0i2","p2i0",[0,"Administração do Site","","",-1,-1,0,"<%=p_PathRelativo%>sislab.asp","_self","","Administração do SISLAB"]);
    stm_ep();
    <%				end if %>
    stm_ai("p0i1",[6,15,"#ffffff","",-1,-1,0]); /*separador*/
    stm_aix("p0i2","p2i0",[0,"Fale Conosco","","",-1,-1,0,"<%=p_PathRelativo%>fale.asp","_self","","Administração do SISLAB"]);
    stm_em();
    //-->
</script>
<%
End Sub

Private Sub ImprimeNomeTela()
    Dim w_princ
    Dim PathRelativo
    Dim linkVoltar

    w_princ = p_tamanhoTela
    PathRelativo = p_PathRelativo
    linkVoltar = p_linkVoltar

	If p_linkVoltar = "" Then p_linkVoltar = "history.go(-1)" %>

        <div id="tbl_principal_nomeform" style="display: inline;">

            <div  style="display: inline; vertical-align: middle; float: left; padding-left: 10px; margin-bottom: 15px;" >
                <h4>
                    <span class="texto-vermelho-bold">&raquo;</span>&nbsp;
			        <span style="color: darkblue;"><strong><%=p_nomeTela%></strong></span>
                </h4>
            </div>

            <div style="text-align: right; vertical-align: middle; margin-top: 10px; margin-right: 10px; float: right; margin-bottom: 15px;">
                <p>
<%			If ucase(linkVoltar) <> "NENHUM" then
				If ucase(linkVoltar) <> "SO_IMPRESSORA" then%>
                    <a href="javascript:<%=p_linkVoltar%>;"><strong>Voltar</strong></a>
<%				End If
                if ucase(p_linkVoltar) <> "SO_LINK" Then %>
<%			    End If
			End If%>
                </p>
            </div>
        </div>

        <br />

        <!--
		<table width="<%=p_tamanhoTela%>" style="/*border-top: thin dotted Gray; border-bottom: thin dotted Gray;*/">
        <tr>
			<td class="destaque titulo">
				<table width="<%=w_princ%>" cellpadding="2" cellspacing="0" class="menu" id="tbl_principal_nomeform" >
				    <tr valign="middle">
					    <td valign="middle">
                            <p>
                                &nbsp;<span class="texto-vermelho-bold">&raquo;</span>&nbsp;
							    <span style="color: darkblue;"><strong><%=p_nomeTela%></strong></span>
                            </p>
					    </td>

    					<td align="right" id="td2_tbl_principal_nomeform" >
<%			If ucase(linkVoltar) <> "NENHUM" then
				If ucase(linkVoltar) <> "SO_IMPRESSORA" then%>
						    <a href="javascript:<%=p_linkVoltar%>;"><strong>Voltar</strong></a>
						    &nbsp;
<%				End If
                if ucase(p_linkVoltar) <> "SO_LINK" Then %>
                        <!--
                        <button id="btn_imprimeTelaPrincipalSistema" style="border: none; background-color: transparent;"
                            onclick="javascript:imprimeTelaPrincipalSistema();">
                            <a href="#" style="background-color: transparent;">
                                <img width="20px" src="<%=p_PathRelativo%>img/impressora1.gif" border="0" align="absmiddle" alt="Imprimir conteúdo da tela">
                            </a>
						</button>
                        -->
<%			    End If
			End If%>
<!--        			    &nbsp;&nbsp;
					    </td>
				    </tr>
				</table>
			</td>
		</tr>
		</table>
        -->

		<script type="text/javascript">
		    function imprimeTelaPrincipalSistema()
		    {
		        var d = document.all;
		        var undef;

		        if (document.all.tr_princ_rodape != undef)
		            document.all.tr_princ_rodape.style.display = "none";
		        if (document.all.td2_tbl_principal_nomeform != undef)
		            document.all.td2_tbl_principal_nomeform.style.display = "none";
		        if (document.all.Stm0p0i != undef)
		            document.all.Stm0p0i.style.display = "none";

		        window.print();

		        if (document.all.tr_princ_rodape != undef)
		            document.all.tr_princ_rodape.style.display = "block";
		        if (document.all.td2_tbl_principal_nomeform != undef)
		            document.all.td2_tbl_principal_nomeform.style.display = "inline";
		        if (document.all.Stm0p0i != undef)  // menu
		            document.all.Stm0p0i.style.display = "inline";
		    }
		</script> <%
End Sub



Public Sub MostraRodape()
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
		"</div>" & VbCrLf & _
		"</div> <!-- class container -->" & VbCrLf & _
		"</body>" & VbCrLf & _
		"</html>"

	Response.Write chr_Buffer
End Sub

Public Sub ImprimeMenuSce() 
    Dim perfil

    perfil = Env.PerfilSCE
%>
    <nav class="navbar navbar-collapse navbar-static-top">
      <div class="container-fluid">
        <div class="navbar-header">
            <button type="button"class="navbar-toggle"data-toggle="collapse" data-target="#example-navbar-collapse">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
          <a class="navbar-brand" href="index.asp" style="background-color: lightgray;">SCE</a>
        </div>

        <div class="collapse navbar-collapse" id="example-navbar-collapse">
          <ul class="nav navbar-nav navbar-left">
               <ul class="nav navbar-nav">
                    <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">Cadastro<span class="caret"></span></a>
                      <ul class="dropdown-menu">
                        <li><a href="cad_empresas.asp">Empresas</a></li>
                        <li><a href="cad_fab.asp">Fabricantes</a></li>
                        <li><a href="cad_no.asp">Natureza de Opera&ccedil;&atilde;o</a></li>
                        <li><a href="cad_nf.asp">Notas Fiscais</a></li>
                        <li><a href="cad_doc.asp">Documentos</a></li>
                        <li><a href="cad_tipos.asp">Fam&iacute;lia Tipo</a></li>
                        <li><a href="cad_areasutilizacao.asp">&Aacute;reas de Utiliza&ccedil;&atilde;o</a></li>
                        <li><a href="cad_modelos.asp">Modelos</a></li>
                        <li><a href="cad_acess_item.asp">Itens</a></li>
<% If perfil = PERFIL_ADM Or perfil = PERFIL_RAT Then %>
                        <li><a href="cad_reserva.asp">Reservas</a></li>
<% End If %>
                      </ul>
                    </li>

                    <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">Consultas<span class="caret"></span></a>
                      <ul class="dropdown-menu">
<% If perfil = PERFIL_ADM or perfil = PERFIL_LOG Then %>
                        <li><a href="sel_cad_empresa.asp">Empresas</a></li>
                        <li><a href="alt_fab.asp">Fabricantes</a></li>
                        <li><a href="sel_cad_no.asp">Natureza de Opera&ccedil;&atilde;o</a></li>
                        <li><a href="sel_cad_nf.asp">Notas Fiscais</a></li>
                        <li><a href="alt_doc.asp">Documentos</a></li>
                        <li><a href="sel_cad_tipo.asp">Fam&iacute;lia Tipo</a></li>
                        <li><a href="sel_cad_areautilizacao.asp">&Aacute;reas de Utiliza&ccedil;&atilde;o</a></li>
                        <li><a href="sel_cad_modelo.asp">Modelos</a></li>
<% End If %>
                        <li><a href="sel_cad_acessorio.asp">Itens</a></li>
                        <li><a href="sel_cad_reserva.asp?abrir_como=CON">Reservas</a></li>
                      </ul>
                    </li>

                    <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">Movimentação<span class="caret"></span></a>
                      <ul class="dropdown-menu">
<% If perfil = PERFIL_ADM or perfil = PERFIL_LOG Then %>
                        <li><a href="mov_acessorio.asp">Movimentação de Itens</a></li>
                        <li class="divider"></li>
<% End If %>
                        <li><a href="mov_passacarga.asp">Passagem de Carga</a></li>
                        <li><a href="mov_recebecarga.asp">Receber Carga</a></li>

<% if perfil = PERFIL_ADM then%>
                        <li class="divider"></li>
                        <li><a href="adm_depara_modelos.asp">De-Para de Modelos</a></li>
<% End If %>
                      </ul>
                    </li>

                    <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">Relatórios<span class="caret"></span></a>
                      <ul class="dropdown-menu">
                        <li><a href="rel_instrumental.asp">Controle de Instrumentais</a></li>
                        <li><a href="rel_instrumentalnovo.asp">Controle de Instrumentais (NOVO)</a></li>
<% If perfil = PERFIL_ADM Then %>
                        <li><a href="rel_consolidado_total_nf.asp">Consolidado - Total por Nota Fiscal</a></li>
                        <li><a href="rel_consolidado_mov.asp">Consolidado - Movimentações</a></li>
                        <li><a href="rel_consolidado.asp">Consolidado - Posi&ccedil;&atilde;o do Estoque</a></li>
<% End If %>
<% If perfil = PERFIL_ADM Or perfil = PERFIL_LOG Then %>
                        <li><a href="rel_consolidado_doc.asp">Consolidado - Documentos Gerados</a></li>
<% End If %>
                        <li><a href="imp_emp.asp">Empresas</a></li>
                        <li><a href="rel_equipamento.asp">Equipamentos</a></li>
                        <li><a href="rel_nf.asp">Notas Fiscais</a></li>
<% If perfil = PERFIL_ADM or perfil = PERFIL_RAT Or perfil = PERFIL_LOG Then %>
                        <li><a href="sel_cad_reserva.asp?abrir_como=REL">Reservas</a></li>
<% End If %>
                        <li><a href="rel_pas.asp">Passagem de Cargas</a></li>
                        <li><a href="rel_mov.asp">Movimenta&ccedil;&atilde;o de Itens</a></li>
<% If perfil = PERFIL_ADM or perfil = PERFIL_LOG Then %>
                        <li class="divider"></li>
                        <li><a href="rel_termoresp.asp">Termo de Responsabilidade</a></li>
<% End If %>
                      </ul>
                    </li>
                    <!--<li><a href="#"><span class="glyphicon glyphicon-search"></span></a></li>-->
              </ul>  
          </ul>
        </div>
      </div>
    </nav>
<%
End Sub

Public Sub ImprimeMenuSce_1()
	Dim base_dir : base_dir = "includes/menu"
	Dim frameTop : frameTop = 146
	Dim wdtCadastros : wdtCadastros = 150
	Dim wdtConsultas : wdtConsultas = 150
	Dim wdtRelatorios : wdtRelatorios = 260
	Dim wdtMovimentacao : wdtMovimentacao = 200

	Dim hgtCadastros : hgtCadastros = 185
	Dim hgtConsultas : hgtConsultas = 190
	Dim hgtRelatorios : hgtRelatorios = 250
	Dim hgtMovimentacao : hgtMovimentacao = 110

    Dim perfil: perfil = Env.PerfilSCE

	if perfil = PERFIL_LOG then
		hgtCadastros = 180
		hgtConsultas = 190
		hgtRelatorios = 180
	elseif perfil = PERFIL_RAT then
		wdtCadastros = 100
		wdtConsultas = 100

		hgtCadastros = 25
		hgtConsultas = 40
		hgtMovimentacao = 40
		hgtRelatorios = 160
	end if
%>
	<script type="text/javascript" src="includes/menu/menu.js"></script>

	<!-- Cadastros-->
	<iframe id="menuCadastros" frameBorder="0" style="position:absolute; left:150px; width:<%=wdtCadastros%>px; top:<%=frameTop%>px; height:<%=hgtCadastros%>px; z-index:900; display: none;" onmouseout="javascript:testaMousePointer('cadastros');" src="<%=base_dir%>/menu_cadastros.asp?perfil=<%=perfil%>" marginheight="0" marginwidth="0"></iframe>
	<!-- Consultas -->
	<iframe id="menuConsultas" frameBorder="0" style="position:absolute; left:300px; width:<%=wdtConsultas%>px; top:<%=frameTop%>px;  height:<%=hgtConsultas%>px; z-index:900; display: none;" onmouseout="javascript:testaMousePointer('consultas');" src="<%=base_dir%>/menu_consultas.asp?perfil=<%=perfil%>" marginheight="0" marginwidth="0"></iframe>
	<!-- Relatorios -->
	<iframe id="menuRelatorios" frameBorder="0" style="position:absolute; left:450px; width:<%=wdtRelatorios%>px; top:<%=frameTop%>px;  height:<%=hgtRelatorios%>px; z-index:900; display: none;" onmouseout="javascript:testaMousePointer('relatorios');" src="<%=base_dir%>/menu_relatorios.asp?perfil=<%=perfil%>" marginheight="0" marginwidth="0"></iframe>
	<!-- Movimentacao -->
	<iframe id="menuMovimentacao" frameBorder="0" style="position:absolute; left:600px; width:<%=wdtMovimentacao%>px; top:<%=frameTop%>px;  height:<%=hgtMovimentacao%>px; z-index:900; display: none;" onmouseout="javascript:testaMousePointer('movimentacao');" src="<%=base_dir%>/menu_movimentacao.asp?perfil=<%=perfil%>" marginheight="0" marginwidth="0"></iframe>

    <p>
		<table class="largura-total" border="0">
		<tr>
	        <td style="width: 150px;"><a href="index.asp" class="links"><font class="links"><b>> Início</b></a></td>
			<td id="mnuCadastros" style="width: 150px;"><a href="#" onMouseOver="javascript:mostraMenuCadastros(true);"><b>> Cadastros</b></a></td>
			<td id="mnuConsultas" style="width: 150px;"><a href="#" onMouseOver="javascript:mostraMenuConsultas(true);"><b>> Consultas</b></a></td>
			<td id="mnuRelatorios" style="width: 150px;"><a href="#" onMouseOver="javascript:mostraMenuRelatorios(true);"><b>> Relatórios</b></a></td>
			<td id="mnuMovimentacao"><a href="#" onMouseOver="javascript:mostraMenuMovimentacao(true);"><b>> Movimentação</b></a></td>
		</tr>
        <tr id="tr_princ_cabecalho_separador2"><td colspan="5" style="background-color: #003366; height: 1px;" ></td></tr>
	    </table>
    </p>
<%
End Sub


Public Sub MostraErroSql()
    Call Tela.MostraCabecalho()

    If Env.Modulo = "SCE" Then Call Tela.ImprimeMenuSce()

    Response.Flush
	Response.Write Tela.Mensagem.ErroSql()
    Call Tela.MostraRodape

    Set Env.oConn = Nothing
    Response.End
End Sub

Public Sub MostraObjetoErroSql(oErr)
    Call Tela.MostraCabecalho()

    If Env.Modulo = "SCE" Then Call Tela.ImprimeMenuSce()

    Response.Flush
	Response.Write Tela.Mensagem.ErroSql(oErr)
    Call Tela.MostraRodape

    Set Env.oConn = Nothing
    Response.End
End Sub

Public Sub MostraErroSqlRB()
    Env.oConn.RollbackTrans
    Call MostraErroSql()
End Sub

End Class
%>
