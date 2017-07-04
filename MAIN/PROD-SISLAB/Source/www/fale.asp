<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/controleshtml.asp" -->
<!--#include file="includes/funcoes.asp" -->
<%
call ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Sugestões - Fale Conosco", "", "")

Dim objSiteRS, sSQL,auxusername

auxusername = Env.Usuario
%>
<script language="javascript" src="includes/anexo.js"></script>
<script language="javascript">
function ValidaCampos()
{
//if (document.formulario.titulo.value=="")
//	{
//	alert("Título não informado.\nInforme o Título da mensagem.");
//		return false;
//		formulario.titulo.focus();	
//	}
//if (AchaAspas(document.formulario.titulo.value))
//	{
//	alert("O título não pode conter Aspas ou apóstrofes.\nCorrija o título da mensagem.");
//	        formulario.titulo.focus();
//		return false;
//	}
if (document.formulario.assunto.value=="")
	{
	alert("Assunto não informado.\nInforme o Assunto da mensagem para encaminharmos devidamente sua mensagem.");
		return false;
		formulario.assunto.focus();	
	}
if (document.formulario.texto.value=="")
	{
	alert("Texto não informado.\nInforme o Texto da mensagem.");
		return false;
		formulario.texto.focus();	
	}
if (AchaAspas(document.formulario.texto.value))
	{
	alert("O texto não pode conter Aspas ou apóstrofes.\nCorrija o texto da mensagem.");
	        formulario.titulo.focus();
		return false;
	}
	return true;
}
</script>
<form method=post action="fale_envia.asp" name="formulario"  onsubmit="return ValidaCampos();">
<input type="hidden" name="username" value="<%=auxusername%>">
<table width="100%" class="texto1">
<tr>
	<td width="10%" height="0"></td>
	<td width="10%" height="0"></td>
	<td width="10%" height="0"></td>
	<td width="10%" height="0"></td>
	<td width="10%" height="0"></td>
	<td width="10%" height="0"></td>
	<td width="10%" height="0"></td>
	<td width="10%" height="0"></td>
	<td width="10%" height="0"></td>
	<td width="10%" height="0"></td>
</tr>
<tr valign="middle">
	<td colspan="3"><b>&nbsp;&nbsp;&nbsp;De: <%=lcase(auxusername)%>@embratel.com.br</b></font></td>
	<td colspan="7"><b>&nbsp;&nbsp;&nbsp;Para: Equipe do CRT</b></font></td>
</tr>
<tr><td height="5px"></td></tr>
</tr>
    <tr valign="middle"> 
	<!--
      <td colspan="4">
			<b>&nbsp;&nbsp;&nbsp;Título:<br>
			&nbsp;&nbsp;&nbsp;<input type="text" class="texto1" name="titulo" size=50 maxlength="180">
			</b>
      </td>-->
      <td colspan="10">
        <div align=left">
			<b>&nbsp;&nbsp;&nbsp;Assunto:<br>
			&nbsp;&nbsp;&nbsp;<select class="texto1" name="assunto">
			<option value="">Selecione o assunto ...</option>
			<option value="Automação de Testes">Automação de Testes</option>
			<option value="Avaliação de Serviços do CRT">Avaliação de Serviços do CRT</option>
			<option value="CRT e Área de Operações e Rede">CRT e Área de Operações e Rede</option>
			<option value="CRT e Área de Serviços">CRT e Área de Serviços</option>
			<option value="CRT e Clientes da EMBRATEL">CRT e Clientes da EMBRATEL</option>
			<option value="CRT e Gerência de Programas">CRT e Gerência de Programas</option>
			<option value="Infra-estrutura do CRT">Infra-estrutura do CRT</option>
			<option value="Integração de Sistemas">Integração de Sistemas</option>
			<option value="Parceiros Tecnológicos">Parceiros Tecnológicos</option>
			<option value="Projetos Especiais">Projetos Especiais</option>
			<option value="Visita ao CRT">Visita ao CRT</option>
			<option value="WebSite do CRT">WebSite do CRT</option>
			<option value="Workshops e Eventos">Workshops e Eventos</option>
			<option value="Outros assuntos">Outros assuntos</option>
			</select>
			</b>
	        </div>
		</td>
    </tr>
    <tr valign="middle">
      <td colspan="10">
        <div align=left">
		<b>&nbsp;&nbsp;&nbsp;Texto:<br>
		&nbsp;&nbsp;&nbsp;<textarea class="texto1" name="texto" cols=100 rows=10></textarea>
		</b>
        </div>
      </td>
    </tr>
    <tr valign="middle">
      <td colspan="10" height=40>
          &nbsp;&nbsp;&nbsp;<input type="submit" class="texto1" name="Submit" value=" Enviar ">
      </td>
    </tr>
  </table>
</form>
<%
Call ImprimeRodape(RODAPE_OFF)
%>