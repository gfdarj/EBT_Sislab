<!--#include file="includes/global.asp" -->
<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/controleshtml.asp" -->
<%
Dim objSiteRS, objSiteCRT, cont, sSQL, EhGQ, EH_CRT, auxUsername, i,objConn

auxusername = Env.NomeReduzido
EH_CRT = Env.usuarioCRT

Tela.SetMostraMenu = MENU_ON
Tela.SetMostraImagem = True
Tela.SetNomeTela = "Sistemas de Gestão - Arquivos Disponíveis"
Tela.SetLinkVoltar = ""
Call Tela.MostraCabecalho()
'''''Call Tela.ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Sistemas de Gestão - Arquivos Disponíveis", "", "")
%>

<div class="margem-10">

<form method=post action="cons_arquivos.asp" name="formulario">

<h4 class="texto-vermelho-bold">AVISO: <small>Os documentos do SG quando impressos só tem valor com a identificação de "Cópia Controlada" através de carimbo ou tarja.</small></h4>
<h4 class="texto-vermelho-bold">IMPORTANTE: <small>Todo Empregado ao acessar ou manusear qualquer documento do SG possui a responsabilidade de evitar a reprodução indevida dos documentos e assegurar a utilização da versão mais atual.</small></h4>

<table class="largura-total">
<tr>
	<th>
		Informe os Critérios da sua Pesquisa
	</th>
</tr>
<tr>
	<td>
		<table border="0">
		<tr>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
	    <tr style="height: 55px;">
    		<td colspan="10">Assunto<br>
				<input type="text" name="assunto" size="60" maxlength="90" value="" >
			</td>
		</tr>
		<tr style="height: 55px;">
			<td colspan="10">Responsável pelo Arquivo<br>
				<%CALL comboUSERCRT("responsavel",objConn,TRUE)%>
			</td>
		</tr>
		<tr style="height: 55px;">
			<td colspan="2">Tipo de Arquivo<br>
				<select name="tipoarquivo">
					<option value="">-- Todos --</option>
					<%	'-- Os roteiros e laudos devem ser exibidos como opcao de filtro para todos.
					'-- apenas se forem sigilosos nao devem ser exibidos na lista de resultados
					'if EH_CRT then
					call comboBD(objConn,"Select TAR_CodTipoArquivo as valor, TAR_TipoArquivo as descricao from TipoArquivo order by TAR_TipoArquivo asc")
					'else
					'	call comboBD(objConn,"Select TAR_CodTipoArquivo as valor, TAR_TipoArquivo as descricao from TipoArquivo where TAR_CodTipoArquivo <> 7 and  TAR_CodTipoArquivo <> 30 order by TAR_TipoArquivo asc")
					'end if%>
				</select>
			</td>
			<td colspan="8">Situação do Arquivo<br>
				<select name="sitarquivo">
					<option value="">-- Todas --</option>
<%					if Env.ehGQ then
						call comboBDpadrao(objConn,"Select SAR_CodSitArquivo as valor, SAR_SitArquivo as descricao from SituacaoArquivo order by SAR_SitArquivo asc",2)
					else
						call comboBDpadrao(objConn,"Select SAR_CodSitArquivo as valor, SAR_SitArquivo as descricao from SituacaoArquivo where SAR_CodSitArquivo <> 4 order by SAR_SitArquivo asc",2)
					end if
					'if objSiteRS("SAR_SitArquivo") = "Aprovado" then
					'option value='<%=objSiteRS("SAR_SitArquivo")' selected>	%>
				</select>
			</td>
		</tr>
		</table>
	</td>
</tr>
<tr style="height: 55px;">
    <td>
        <input type="submit" name="Submit" value="Pesquisar" >
    </td>
</tr>
</table>

</form>
</div>
<%
Call Tela.MostraRodape()
%>