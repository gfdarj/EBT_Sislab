<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/controleshtml.asp" -->
<%
Dim indicador : indicador = "&nbsp;&nbsp;&nbsp;<span class='cinza1'>&raquo;</span>&nbsp;"
Dim objSiteRS, cont, sSQL, tot
Dim ehRat

Call imprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Administração do SISLAB", "location.href='index.asp'", "")

ehRat = Env.EhRat
'ehrat = false
%>
<script>
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
<table border="0" width="100%" class="tabela1">
<tr valign=top>
	<!-- Lado Esquerdo -->
	<td  valign=top width="49%">
		<table width="100%" cellpadding="2" cellpadding="0" class="tabela1">
		<tr><th align="left">Alocação de RH</th></tr>
		<tr>
			<td><A href="agendamento/default.htm" class="menu">
			<%=indicador%>Alocar Pessoal a Tarefas (treinamento, férias, ...)</a>
			</td>
		</tr>
		<tr>
			<td><A href="consulta_pessoal.asp" class="menu">	
			<%=indicador%>Consultar Alocação de Pessoal</a>
			</td>
		</tr>
		</table>
		<br>
		<table width="100%" cellpadding="2" cellpadding="0" class="tabela1">
		<tr>
			<th align="left">Controle de Ambientes</th>
		</tr>
<%If ehRAT or Env.ehGQ then%>
		<tr>
			<td><A href="CadAmbientes.asp" class="menu">
			<%=indicador%>Cadastro de Ambientes e Salas</a>
			</td>
		</tr>
		<tr>
			<td><A href="ambientes/sel_cad_agenda.asp" class="menu">
			<%=indicador%>Reservar Ambiente</a>	
			</td>
		</tr>
<%end if%>
		<tr>
			<td><A href="ambientes/cons_agenda.asp" class="menu">
			<%=indicador%>Consultar Ambientes Reservados</a>
			</td>
		</tr>
		</table>
		<br>
		<table width="100%" cellpadding="2" cellpadding="0" class="tabela1">
		<tr>
			<th align="left">Indicadores</th>
		</tr>
		<tr>
			<td><A href="Cons_Ind_pesqsCRSem.asp" class="menu">
			<%=indicador%>Pesquisa de Satisfação - Consolidado</a>
			</td>
		</tr>
		<tr>
			<td><A href="cons_indicadores.asp" class="menu">
			<%=indicador%>Indicadores de Demanda e Eficiência</a>
			</td>
		</tr>
		<tr>
			<td><A href="cons_indicadoresNC.asp" class="menu">
			<%=indicador%>Indicadores de Não Conformidades</a>
			</td>
		</tr>
		</table>
		<br>
		<table width="100%" cellpadding="2" cellpadding="0" class="tabela1">
		<tr>
			<th align="left">Remarcando um Agendamento</th>
		</tr>
		<tr>
			<td><A href="form_remarca_teste_sel.asp?tipo_remarca=S" class="menu">
			<%=indicador%>Solicitar Remarcação de um Serviço</a>
			</td>
		</tr>
		<tr>
			<td><A href="form_valida_remarca_sel.asp" class="menu">
			<%=indicador%>Validar Remarcação do Serviço</a>
			</td>
		</tr>
		</table>

		<br>
		<table width="100%" cellpadding="2" cellpadding="0" class="tabela1">
<%
If ehRAT then
%>
		<tr>
			<th align="left">Administra&ccedil;&atilde;o do SISLAB</th>
		</tr>
		<tr>
			<td><A href="mensagems_mudanca.asp" class="menu" title="Altera as mensagems automáticas quando houver mudança na situação de uma AS">
			<%=indicador%>Altera mensagems de mudança de situação da AS</a>
			</td>
		</tr>
<%
End If%>
		<tr>
			<td><A href="CadMensagem.asp" class="menu" title="Altera outras mensagems enviadas automáticamnte pelo SISLAB">
			<%=indicador%>Altera outras mensagems de e-mails autom&aacute;ticas</a>
			</td>
		</tr>
<%
If ehRAT then
%>
<!--		<tr>
			<td><A href="CadConfiguracao.asp" class="menu">
			<%=indicador%>Configuração dos Parâmetros do sistema</a>
			</td>
		</tr>-->
		<tr>
			<td><A href="altera_datas.asp" class="menu">
			<%=indicador%>Corrige datas de AS´s e OS´s</a>
			</td>
		</tr>
		<tr>
			<td><A href="includes/adm/bd.asp" class="menu">
			<%=indicador%>Comandos SQL</a>
			</td>
		</tr>
		<tr>
			<td><A href="includes/adm/bdxls.asp" class="menu">
			<%=indicador%>Comandos SQL - Exportação para Excel</a>
			</td>
		</tr>
		<tr>
			<td><A href="GerenciadorDeDados.asp" class="menu">
			<%=indicador%>Exportar Tabelas do Sistema</a>
			</td>
		</tr>
		<tr>
			<td><A href="form_agenda_exclui.asp" class="menu">
			<%=indicador%>Excluir um Agendamento</a>
			</td>
		</tr>
		<tr>
			<td><A href="CadDePara.asp" class="menu">
			<%=indicador%>Ferramenta DE -> PARA</a>
			</td>
		</tr>
		<tr>
			<td><A href="rel_historicoAS_datas.asp" class="menu">
			<%=indicador%>Histórico dos Agendamentos por ordem de data</a>
			</td>
		</tr>
		<tr>
			<td><A href="rel_historicoAS_id.asp" class="menu">
			<%=indicador%>Histórico dos Agendamentos por ordem de cadastro</a>
			</td>
		</tr>
		<tr>
			<td><A href="rel_numeracao_as.asp" class="menu">
			<%=indicador%>Verifica Numeração dos Agendamentos</a>
			</td>
		</tr>
<%
end if
%>
		</table>
		<br>

	</td>

	<td align="center" height="100%">
		<table cellpadding="0" cellspacing="0" border="0" width="0px" height="100%" style="border: solid gray thin; border-style: dashed; border-width: 1px;">
		<tr><td width="0px"></td></tr>
		</table>
	</td>

	<!-- Lado Direito -->
    <td width="49%" valign="top">
		<br>
		<table width="100%" cellpadding="2" cellpadding="0" class="tabela1">
		<tr>
			<th align="left">Especificações de Teste</th>
		</tr>
		<tr>
			<td><A href="form_especifica_teste.asp" class="menu">
			<%=indicador%>Incluir Nova Especificação de Teste</a>
			</td>
		</tr>
		<tr>
			<td><A href="form_atualiza_teste_sel.asp" class="menu">
			<%=indicador%>Atualizar Especificação de Teste</a>
			</td>
		</tr>
		</table>

		<br>

		<table width="100%" cellpadding="2" cellpadding="0" class="tabela1">
		<tr>
			<th align="left">Gerência de Arquivos no Site</th>
		</tr>
		<tr>
			<td><a href="fotos.asp" class="menu">
			<%=indicador%>Cadastrar Fotos</a>
			</td>
		</tr>
		<tr>
			<td><a href="Sel_Cad_Plantao.asp" class="menu">
			<%=indicador%>Cadastrar Notícia</a>
			</td>
		</tr>
		<tr>
			<td><A href="sel_cad_arquivo.asp" class="menu">
			<%=indicador%>Upload de Arquivos</a>
			</td>
		</tr>
		<tr>
			<td><A href="cons_arquivos_link.asp" class="menu">
			<%=indicador%>Verifica Links para os Arquivos</a>
			</td>
		</tr>
		</table>

		<br>
<%
If ehRAT Then
%>
		<table width="100%" cellpadding="2" cellpadding="0" class="tabela1">
		<tr>
			<th align="left">Equipamentos - SCE</th>
		</tr>
		<tr>
			<td><A href="CadPlataformaEquipamento.asp" class="menu">
			<%=indicador%>Cadastro de Equipamentos em Plataformas</a>
			</td>
		</tr>
		<tr>
			<td>&nbsp;&nbsp;&nbsp;<A href="CadPlataformaEquipamentoHist.asp" class="menu">
			<%=indicador%>Histórico de mudanças em plataformas</a>
			</td>
		</tr>
		<tr>
			<td><A href="Rel_Inv_Equip.asp" class="menu">
			<%=indicador%>Relatório Geral de Equipamentos</a>
			</td>
		</tr>
		</table>
		</br>

		<table width="100%" cellpadding="2" cellpadding="0" class="tabela1">
		<tr>
			<th align="left">Cadastros Intermediários</th>
		</tr>
		<tr>
			<td><A href="CadAreaTecnologica.asp" class="menu">
			<%=indicador%>Cadastro de Área Tecnológica</a>
			</td>
		</tr>
		<tr>
			<td><A href="CadTransporte.asp?altera=S" class="menu">
			<%=indicador%>Cadastro de Horários do Transporte CRT / Sede</a>
			</td>
		</tr>
		<tr>
			<td><A href="CadOrgao.asp" class="menu">
			<%=indicador%>Cadastro de Órgãos (Diretores e Gerentes)</a>
			</td>
		</tr>
		<tr>
			<td><A href="CadServPlataforma.asp?Acao=P" class="menu">
			<%=indicador%>Cadastro de Plataformas</a>
			</td>
		</tr>
		<tr>
			<td><A href="CadServPlataforma.asp?Acao=S" class="menu">
			<%=indicador%>Cadastro de Serviços</a>
			</td>
		</tr>
		<tr>
			<td><A href="CadTecnologia.asp" class="menu">
			<%=indicador%>Cadastro de Tecnologias</a>
			</td>
		</tr>
		<tr>
			<td><A href="CadTipoArquivo.asp" class="menu">
			<%=indicador%>Cadastro de Tipos de Arquivo</a>
			</td>
		</tr>
		<tr>
			<td><A href="CadTipoAtividade.asp" class="menu">
			<%=indicador%>Cadastro de Tipos de Atividade</a>
			</td>
		</tr>
		<tr>
			<td><A href="CadTipoTeste.asp" class="menu">
			<%=indicador%>Cadastro de Tipos de Teste (Especificação)</a>
			</td>
		</tr>
		<tr>
			<td><A href="CadLbTipoOcorrencia.asp" class="menu">
			<%=indicador%>Cadastro de Tipos de Ocorrência LogBook</a>
			</td>
		</tr>
		<tr>
			<td><A href="Cadusercrt.asp" class="menu">
			<%=indicador%>Cadastro de Usuário CRT</a>
			</td>
		</tr>
		<tr>
			<td><A href="CadListaEquipesEmbratel.asp" class="menu">
			<%=indicador%><font color="#ff0000">Lista de equipes para acesso a dados sigilosos</font></a>
			</td>
		</tr>
		</table>
		<br>
<%
End If
%>

		<table width="100%" cellpadding="2" cellpadding="0" class="tabela1">
		<tr>
			<th align="left">Outros</th>
		</tr>
		<tr>
			<td><A href="circuitos/index.asp" class="menu">
			<%=indicador%>Sistema de Gestão de Facilidades</a>
			</td>
		</tr>
		<tr>
			<td><A href="javascript:MostraDFD()" class="menu">
			<%=indicador%>DTE - Solicitação de Serviço</a>
			</td>
		</tr>
		</table>
		<br>
	</td>
</tr>
</table>
</font>
<%
Call imprimeRodape(RODAPE_On)
%>