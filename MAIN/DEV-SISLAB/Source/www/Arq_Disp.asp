<!--#include file="includes/global.asp" -->
<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/controleshtml.asp" -->
<%
Dim objSiteRS, objSiteCRT, cont, sSQL, EhGQ, EH_CRT, auxUsername, i,objConn

auxusername = Env.Nome_Reduzido
EH_CRT = Env.usuarioCRT

call ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Sistemas de Gestão - Arquivos Disponíveis", "", "")
%>

<form method=post action="cons_arquivos.asp" name="formulario">
<table border="0" width="100%" class="tabela1" cellpadding="3" cellspacing="3">
<tr>
	<td class="texto1">
		<font color="#ff0000" ><b>AVISO :</b></font> <br>Os documentos do SG quando impressos só tem valor com a identificação de "Cópia Controlada" através de carimbo ou tarja. <br><br>
		<font color="#ff0000" ><b>IMPORTANTE :</b></font><br>Todo Empregado ao acessar ou manusear qualquer documento do SG possui a responsabilidade de evitar a reprodução indevida dos documentos e assegurar a utilização da versão mais atual.
	</td>
</tr>
<tr><td height="5px"></td></tr>
<tr>
	<td>
		&nbsp;<span class="texto1b" style="font-size: 12px;">Informe os Critérios da sua Pesquisa</span>
	</td>
</tr>
<tr>
	<td>
		<table border="0" width="100%" class="tabela1" cellpadding="3" cellspacing="3" style="background: <%=chr_BgColor%>;">
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
	    <tr> 
    		<td colspan="10">Assunto<br>
				<input type="text" name="assunto" size="60" maxlength="90" value="" class="texto1">
			</td>
		</tr>
		<tr>
			<td colspan="10">Responsável pelo Arquivo<br>
				<%CALL comboUSERCRT("responsavel",objConn,TRUE)%>
			</td>
		</tr>
		<tr>
			<td colspan="3">Tipo de Arquivo<br>
				<select name="tipoarquivo" style="font-size=8pt">
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
			<td colspan="7">Situação do Arquivo<br>
				<select name="sitarquivo" class="texto1">
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
		<tr><td height="10px"></td></tr>
		<tr valign="middle">
			<td colspan="10" align="left">
				<input type="submit" name="Submit" value="Pesquisar" class="texto1">&nbsp;&nbsp;&nbsp;
			</td>
		</tr>
		</table>
	</td>
</tr>
</table>
<%
Call imprimeRodape(RODAPE_OFF)
%>