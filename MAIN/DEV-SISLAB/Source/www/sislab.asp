<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<%
Dim indicador : indicador = "&nbsp;&nbsp;&nbsp;<span class='cinza1'>&raquo;</span>&nbsp;"
Dim objSiteRS, cont, sSQL, tot
Dim ehRat

Call Tela.ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Administração do SISLAB", "location.href='index.asp'", "")

ehRat = Env.EhRat
'ehrat = false
%>
<script type="text/javascript">
    function MostraDFD(){
	    var janela;
	    janela = window.open("eventosinternos.asp?hdnEvento=13", 'DTE', "toolbar=1,location=0,directories=0,status=1,menubar=0,scrollbars=1,resizable=1,width=640,height=480");
	    janela.focus();
    }
</script>

<style>
    br {
	    font-size: 3pt;
    }
</style>

<% If Env.UsuarioCRT Then %>
<div class="container">
    <div class="row">
        <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">
            <h4 class="linha-destaque">Alocação de RH</h4>
	        <h5><a href="agendamento/default.htm" target="_parent">Alocar Pessoal a Tarefas (treinamento, férias, ...)</a></h5>
            <h5><a href="consulta_pessoal.asp" target="_parent">Consultar Alocação de Pessoal</a></h5>
        </div>

        <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">
            <h4 class="linha-destaque">Controle de Ambientes</h4>

<%If ehRAT or Env.ehGQ or Env.PerfilSce = PERFIL_LOG Then%>
	        <h5><a href="CadAmbientes.asp" target="_parent">Cadastro de Ambientes e Salas</a></h5>
<%end if%>
<%If ehRAT or Env.ehGQ then%>
            <h5><a href="ambientes/sel_cad_agenda.asp" target="_parent">Reservar Ambiente</a></h5>
<%end if%>
            <h5><a href="ambientes/cons_agenda.asp" target="_parent">Consultar Ambientes Reservados</a></h5>
        </div>

        <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">
            <h4 class="linha-destaque">Indicadores</h4>
	        <h5><a href="Cons_Ind_pesqsCRSem.asp" target="_parent">Pesquisa de Satisfação - Consolidado</a></h5>
            <h5><a href="cons_indicadores.asp" target="_parent">Indicadores de Demanda e Eficiência</a></h5>
            <h5><a href="cons_indicadoresNC.asp" target="_parent">Indicadores de Não Conformidades</a></h5>
        </div>

        <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">
            <h4 class="linha-destaque">Remarcando um Agendamento</h4>
<% If ehRAT Then%>
	        <h5><a href="form_remarca_teste_sel.asp?tipo_remarca=S" target="_parent">Solicitar Remarcação de um Serviço</a></h5>
            <h5><a href="form_valida_remarca_sel.asp" target="_parent">Validar Remarcação do Serviço</a></h5>
<% End If %>
            <h5><a href="cons_indicadoresNC.asp" target="_parent">Indicadores de Não Conformidades</a></h5>
        </div>

        <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">
            <h4 class="linha-destaque">Especificações de Teste</h4>
	        <h5><a href="form_especifica_teste.asp" target="_parent">Incluir Nova Especificação de Teste</a></h5>
            <h5><a href="form_atualiza_teste_sel.asp" target="_parent">Atualizar Especificação de Teste</a></h5>
        </div>

        <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">
            <h4 class="linha-destaque">Gerência de Arquivos no Site</h4>
	        <h5><a href="fotos.asp" target="_parent">Cadastrar Fotos</a></h5>
            <h5><a href="Sel_Cad_Plantao.asp" target="_parent">Cadastrar Notícia</a></h5>
            <h5><a href="sel_cad_arquivo.asp" target="_parent">Upload de Arquivos</a></h5>
            <h5><a href="cons_arquivos_link.asp" target="_parent">Verifica Links para os Arquivos</a></h5>
        </div>

        <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">
            <h4 class="linha-destaque">Administração do SISLAB</h4>
<%If ehRAT Then%>
	        <h5><a href="mensagems_mudanca.asp" target="_parent">Altera mensagems de mudança de situação da AS</a></h5>
<%
End If%>
            <h5><a href="CadMensagem.asp" target="_parent">Altera outras mensagems de e-mails automáticas</a></h5>
<%If ehRAT Then%>
            <h5><a href="altera_datas.asp" target="_parent">Corrige datas de AS´s e OS´s</a></h5>
            <h5><a href="includes/adm/bd.asp" target="_parent">Comandos SQL</a></h5>
            <h5><a href="includes/adm/bdxls.asp" target="_parent">Comandos SQL - Exportação para Excel</a></h5>
            <h5><a href="GerenciadorDeDados.asp" target="_parent">Exportar Tabelas do Sistema</a></h5>
            <h5><a href="form_agenda_exclui.asp" target="_parent">Excluir um Agendamento</a></h5>
            <h5><a href="CadDePara.asp" target="_parent">Ferramenta DE -> PARA</a></h5>
            <h5><a href="rel_historicoAS_datas.asp" target="_parent">Histórico dos Agendamentos por ordem de data</a></h5>
            <h5><a href="rel_historicoAS_datas.asp?Ord=1" target="_parent">Histórico dos Agendamentos por ordem de cadastro</a></h5>
            <h5><a href="rel_numeracao_as.asp" target="_parent">Verifica Numeração dos Agendamentos</a></h5>
<%
End If%>
        </div>

<%If ehRAT Then%>
        <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">
            <h4 class="linha-destaque">Cadastros Intermediários</h4>
            <h5><a href="CadAreaTecnologica.asp" target="_parent">Cadastro de Área Tecnológica</a></h5>
            <h5><a href="CadTransporte.asp?altera=S" target="_parent">Cadastro de Horários do Transporte CRT / Sede</a></h5>
            <h5><a href="CadOrgao.asp" target="_parent">Cadastro de Órgãos (Diretores e Gerentes)</a></h5>
            <h5><a href="CadServPlataforma.asp?Acao=P" target="_parent">Cadastro de Plataformas</a></h5>
            <h5><a href="CadServPlataforma.asp?Acao=S" target="_parent">Cadastro de Serviços</a></h5>
            <h5><a href="CadTecnologia.asp" target="_parent">Cadastro de Tecnologias</a></h5>
            <h5><a href="CadTipoArquivo.asp" target="_parent">Cadastro de Tipos de Arquivo</a></h5>
            <h5><a href="CadTipoAtividade.asp" target="_parent">Cadastro de Tipos de Atividade</a></h5>
            <h5><a href="CadTipoTeste.asp" target="_parent">Cadastro de Tipos de Teste (Especificação)</a></h5>
            <h5><a href="CadLbTipoOcorrencia.asp" target="_parent">Cadastro de Tipos de Ocorrência LogBook</a></h5>
            <h5><a href="Cadusercrt.asp" target="_parent">Cadastro de Usuário CRT</a></h5>
            <h5><a href="CadListaEquipes.asp" target="_parent">Lista de equipes para acesso a dados sigilosos</a></h5>
        </div>

        <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">
            <h4 class="linha-destaque">Equipamentos - SCE</h4>
	        <h5><a href="CadPlataformaEquipamento.asp" target="_parent">Cadastro de Equipamentos em Plataformas</a></h5>
            <h5><a href="CadPlataformaEquipamentoHist.asp" target="_parent">Histórico de mudanças em plataformas</a></h5>
            <h5><a href="Rel_Inv_Equip.asp" target="_parent">Relatório Geral de Equipamentos</a></h5>
        </div>
<%End If %>

        <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">
            <h4 class="linha-destaque">Outros</h4>
	        <h5><a href="circuitos/index.asp" target="_parent">Sistema de Gestão de Facilidades</a></h5>
            <h5><a href="javascript:MostraDFD()" target="_parent">DTE - Solicitação de Serviço</a></h5>
        </div>


    </div>
</div>

<% Else %>
    <%="<br />" & Env.MensagemAcessoExclusivo() %>
<% End If %>

<%
Call Tela.MostraRodape()
%>