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
        "       <link rel='stylesheet' href='includes/bootstrap-3.3.7-dist/css/bootstrap.min.css' media='screen'>" & VbCrLf & _
		"       <link rel='stylesheet' type='text/css' href='" & PathRelativo & "estilos/" & p_estilo & "' />" & VbCrLf & _
		"   </head>" & VbCrLf

	chr_Buffer = chr_Buffer & _
		"<script language='JavaScript' src='" & PathRelativo & "includes/currency.js'></script>" & VbCrLf & _
		"<script language='JavaScript' src='" & PathRelativo & "includes/relogio.js'></script>" & VbCrLf

	chr_Buffer = chr_Buffer & _
		"<body onunload='javascript: hideAguarde();'>"

	chr_Buffer = chr_Buffer & _
		"<div id='divAguarde' class='tempo' style='display: none;'><table><tr><td><img src='" & PathRelativo & "img/tempo.gif' alt='Aguarde'></td><td>&nbsp;&nbsp;Aguarde...</td></tr></table></div>" & VbCrLf

	Response.Write chr_Buffer

	If p_imprimeImagem Then
	    Call ImprimeImagemSite()
	end if	'Imprime Tela   
%>

<!--------------------- Imprime o nome do formulÃ¡rio na tela --------------------->
<%		if p_nomeTela <> "" And usuario <> "" then
            Call ImprimeNomeTela
		end if
%>
<!--------------------- Imprime a tela Principal --------------------->

		<table id="tr_princ_conteudo" cellpadding="2" cellspacing="2" border="0" width="<%=p_tamanhoTela%>">
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
		<table width="<%=w_princ%>" class="" border="0" cellspacing="0" cellpadding="0" >
        <tr>
            <td background="<%=PathRelativo%>img/titulo_bg.jpg" height="70" style="vertical-align: bottom;">
                <div>
                    <div style="float:left;">
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
                    <div style="float: right; text-align:right;">
                            <p style="line-height: 14px;">&nbsp;</p>
				            <h6><%=Env.nomeAppHtml%><br />
					        <%=Env.Ebt.NomeReduzido%><br />
					        <%=Env.Usuario%></h6>
                    </div>
<%  End If %>
                </div>
            </td>
        </tr>
        </table>

<%			If p_imprimeMenu And Env.Usuario <> "" Then
                Call ImprimeMenu()
			end if%>

<%
End Sub

Private Sub ImprimeMenu() %>
<script type="text/javascript" language="JavaScript1.2">
	<!--
    var st_path = "<%=p_PathRelativo%>includes/";
    var st_lib = "stm31.js";
    document.open();
    document.write("<" + "script type='text/javascript' language='JavaScript1.2' src='" + st_path + st_lib + "'><" + "/script>");
    document.close();
	//-->
</script>

<script type="text/javascript">
    <!--
    stm_bm(["tubtehr",400,"","<%=p_PathRelativo%>img/blank.gif",1,"0","stgct()",0,0,250,0,1000,1,0,0,"","",0],this);
    stm_bp("p0",[0,4,0,0,0,2,0,7,100,"",-2,"",-2,90,0,0,"#000000","transparent","",3,3,2,"#ffffff #ffffff #006699 #ffffff"]);
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
    stm_aix("p3i0","p2i0",[0,"Ambientes","","",-1,-1,0,"<%=Application("SISLAB_ServidorLocalCRT")%>plantacrt/labcrt1.htm","_blank","","Ambientes de acomodação e salas disponí­veis"]);
    stm_aix("p3i1","p2i0",[0,"Código de Ética","","",-1,-1,0,"http://ntspo907/hpembratel/pdf/codigo_de_etica_embrapar.pdf","_self","","Código de Ética"]);
    stm_aix("p3i2","p2i0",[0,"Equipe / Infra-estrutura Interna","","",-1,-1,0,"<%=p_PathRelativo%>equ_EstIn.asp","_self","","Equipe / Infra-estrutura Interna"]);

    <%				'-- se for do CRT exibe o link para o servidor local
				    If Env.usuarioCRT Then %>
    stm_aix("p3i3","p2i3",[0,"Espaço CRT","","",-1,-1,0,"http://XPRJO030309/index.htm","_self","","Espaço reservado aos trabalhos internos do CRT"]);
    <%				End If %>

    stm_aix("p3i4","p2i0",[0,"Histórico","","",-1,-1,0,"<%=Application("SISLAB_ServidorLocalCRT")%>Historico.pdf","_blank","","Histórico do Centro de Referência Tecnológica"]);
    stm_aix("p3i5","p2i0",[0,"Localização / Área","","",-1,-1,0,"<%=p_PathRelativo%>loc_area.asp","_self","","Localização e Área construí­da"]);
    stm_aix("p3i6","p2i0",[0,"Manual do Sistema de Gestão","","",-1,-1,0,"arquivos/MSG Rev 08 de 20-02-06 .pdf","_self","","Manual do Sistema de Gestão"]);
    stm_aix("p3i7","p2i0",[0,"Vídeos do CRT","","",-1,-1,0,"videos.asp","_self","","Ví­deos do CRT"]);
    stm_ep();

    <%				If Env.usuarioCRT_Cadastrado Then%>
    //stm_aix("p1i2","p3i7",[0,"Controle de Consumí­veis (SCC)","","",-1,-1,0,"<%=p_PathRelativo%>scc/index.asp","_self","","Sistema de Controle de Consumí­veis","","",0,0,0,"","",0,0,0,0,1,"#ffffff",0,"#ffffff",0,"","",3,3,0,0,"#ffffff","#ffffff","#cc0000"]);
    stm_aix("p1i2","p3i7",[0,"Controle de Equipamentos (SCE)","","",-1,-1,0,"<%=p_PathRelativo%>sce2/index.asp","_self","","Sistema de Controle de Equipamentos","","",0,0,0,"","",0,0,0,0,1,"#ffffff",0,"#ffffff",0,"","",3,3,0,0,"#ffffff","#ffffff","#cc0000"]);
    <%				End If%>

    stm_aix("p1i3","p2i0",[0,"Sistemas de Gestão","","",-1,-1,0,"<%=p_PathRelativo%>arq_disp.asp","_self","","Arquivos do sistema de gestão disponí­veis para visualização"]);
    stm_aix("p1i4","p2i0",[0,"Lista de Atividades do CRT","","",-1,-1,0,"<%=p_PathRelativo%>sit_crt.asp","_self","","Exibe as atividades do CRT"]);
    stm_aix("p1i5","p2i0",[0,"Log Book","","",-1,-1,0,"<%=p_PathRelativo%>sel_cad_logbook.asp","_self","","Log Book - cadastro de ocorrências"]);
    stm_aix("p1i6","p2i0",[0,"Ocupação dos Ambientes","","",-1,-1,0,"<%=p_PathRelativo%>ambientes/cons_agenda.asp","_self","","Cadastro e reserva de salas"]);
    stm_aix("p1i7","p0i1",[0,"Pesquisa de Satisfação","","",-1,-1,0,"","_self","","Pesquisa de Satisfação"]);
    stm_bpx("p4","p2",[]);
    stm_aix("p4i0","p2i0",[0,"Cadastrar","","",-1,-1,0,"<%=p_PathRelativo%>pesqscr.asp","_self","","Cadastra uma nova pesquisa de satisfação"]);
    stm_aix("p4i1","p2i0",[0,"Consultar por AS","","",-1,-1,0,"<%=p_PathRelativo%>cons_ind_pesqscr_filtro.asp","_self","","Consulta uma pesquisa por número do agendamento"]);
    stm_ep();
    stm_aix("p1i8","p0i1",[0,"Recursos Disponí­veis","","",-1,-1,0,"","_self","","Recursos Disponí­veis"]);
    stm_bpx("p5","p2",[]);
    stm_aix("p5i0","p2i0",[0,"Logística","","",-1,-1,0,"<%=Application("SISLAB_ServidorLocalCRT")%>Logistica.pdf","_blank","","Logí­stica"]);
    stm_aix("p5i1","p2i0",[0,"Salas de Apoio","","",-1,-1,0,"<%=Application("SISLAB_ServidorLocalCRT")%>SalaApoio.pdf","_blank","","Salas de Apoio"]);
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

	if p_linkVoltar = "" then p_linkVoltar = "history.go(-1)"%>
		<table width="<%=p_tamanhoTela%>" cellpadding="0" cellspacing="0"  style="border-top: thin dotted Gray; border-bottom: thin dotted Gray;">
        <tr>
			<td class="realce1"> <!-- #d9d9d9 -->

				<table width="<%=w_princ%>" cellpadding="2" cellspacing="0" class="menu" id="tbl_principal_nomeform" >
				<tr valign="middle">
					<td valign="middle">
						<span style="font-family: Verdana, Arial, Helvetica, sans-serif; color: Navy; font-weight: bolder; font-size: 10pt;">&nbsp;<span style="color: red;">&raquo;</span>&nbsp;
							<i><%=p_nomeTela%></i>
						</span>
					</td>

					<td align="right" id="td2_tbl_principal_nomeform" >
<%			If ucase(linkVoltar) <> "NENHUM" then
				If ucase(linkVoltar) <> "SO_IMPRESSORA" then%>
						</b><a href="javascript:<%=p_linkVoltar%>;">Voltar</a>
						&nbsp;
<%				End If
				if ucase(p_linkVoltar) <> "SO_LINK" Then %>
						<button id="btn_imprimeTelaPrincipalSistema" style="border: none; height: 17px; width: 25px; background-color: none;" onclick="javascript:imprimeTelaPrincipalSistema();"><a href="#"><img src="<%=p_PathRelativo%>img/impressora.gif" border="0" align="absmiddle" alt="Imprimir conteÃºdo da tela"></a></button>
<%			    End If
			End If%>
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
		"</body>" & VbCrLf & _
		"</html>"

	Response.Write chr_Buffer
End Sub

Public Sub ImprimeMenuSce()
	Dim base_dir : base_dir = "includes/menu"
	Dim frameTop : frameTop = 120
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
	<script language="JavaScript" src="includes/menu/menu.js"></script>

	<!-- Cadastros-->
	<iframe id="menuCadastros" frameBorder="0" style="position:absolute; left:130px; width:<%=wdtCadastros%>px; top:<%=frameTop%>px; height:<%=hgtCadastros%>px; z-index:900; display: none;" onmouseout="javascript:testaMousePointer('cadastros');" src="<%=base_dir%>/menu_cadastros.asp?perfil=<%=perfil%>" marginheight="0" marginwidth="0"></iframe>
	<!-- Consultas -->
	<iframe id="menuConsultas" frameBorder="0" style="position:absolute; left:254px; width:<%=wdtConsultas%>px; top:<%=frameTop%>px;  height:<%=hgtConsultas%>px; z-index:900; display: none;" onmouseout="javascript:testaMousePointer('consultas');" src="<%=base_dir%>/menu_consultas.asp?perfil=<%=perfil%>" marginheight="0" marginwidth="0"></iframe>
	<!-- Relatorios -->
	<iframe id="menuRelatorios" frameBorder="0" style="position:absolute; left:378px; width:<%=wdtRelatorios%>px; top:<%=frameTop%>px;  height:<%=hgtRelatorios%>px; z-index:900; display: none;" onmouseout="javascript:testaMousePointer('relatorios');" src="<%=base_dir%>/menu_relatorios.asp?perfil=<%=perfil%>" marginheight="0" marginwidth="0"></iframe>
	<!-- Movimentacao -->
	<iframe id="menuMovimentacao" frameBorder="0" style="position:absolute; left:495px; width:<%=wdtMovimentacao%>px; top:<%=frameTop%>px;  height:<%=hgtMovimentacao%>px; z-index:900; display: none;" onmouseout="javascript:testaMousePointer('movimentacao');" src="<%=base_dir%>/menu_movimentacao.asp?perfil=<%=perfil%>" marginheight="0" marginwidth="0"></iframe>

    <p class='texto1'>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" height="20">
		<tr>
	        <td align="left" width="120px"><a href="index.asp" class="links"><font class="links"><b>> Início</b></a></td>
			<td align="left" id="mnuCadastros" width="120px"><a href="#" onMouseOver="javascript:mostraMenuCadastros(true);"><font class="links"><b>> Cadastros</b></a></td>
			<td align="left" id="mnuConsultas" width="120px"><a href="#" onMouseOver="javascript:mostraMenuConsultas(true);"><font class="links"><b>> Consultas</b></a></td>
			<td align="left" id="mnuRelatorios" width="120px"><a href="#" onMouseOver="javascript:mostraMenuRelatorios(true);"><font class="links"><b>> Relatórios</b></a></td>
			<td align="left" id="mnuMovimentacao" width="*"><a href="#" onMouseOver="javascript:mostraMenuMovimentacao(true);"><font class="links"><b>> Movimentação</b></a></td>
		</tr>
        <tr id="tr_princ_cabecalho_separador2"><td colspan="5" bgcolor="#003366" height="1"></td></tr>
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