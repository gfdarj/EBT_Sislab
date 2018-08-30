<!--#include file="includes/Sislab_Lib.asp"-->
<!-- #include file="includes/bib_str.asp" -->
<!-- #include file="includes/PadraoHTML.asp" -->
<!-- #include file="includes/global.asp" -->
<!-- #include file="includes/controleshtml.asp" -->
<%
If IsEmpty(Env.Usuario) Then response.redirect "msgAcessoNA.asp"

call ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Cadastrar Plantão de Notícias do CRT", "location.href='sel_Cad_plantao.asp';", "")

Dim objSiteRS, sSQL,i,auxi
Dim auxcodnoticia,auxtitnoticia,auxnoticia,auxlink
Dim auxdatainicio,auxdatatermino,auxidorgao
Dim auxaltera,cbano, auxselecao	
Dim auxdiainiexibicao,auxmesiniexibicao,auxanoiniexibicao
Dim auxdiafimexibicao,auxmesfimexibicao,auxanofimexibicao

if (IsEmpty(request.form("Noticias"))) Then
	auxselecao=0
else
	auxselecao=CInt(trim(request.form("Noticias")))
End if

sSQL="Select * from plantao Where PLA_CodNoticia=" & CInt(trim(auxselecao))
Call Env.RecordSet(true, objSiteRS, sSQL)

If Not objSiteRS.EOF Then
    objSiteRS.Movefirst

	auxcodnoticia = objSiteRS("pla_codnoticia")
	auxtitnoticia=objSiteRS("pla_titnoticia")
	auxlink=objSiteRS("pla_link")
	auxdatainicio=objSiteRS("pla_datainicio")
	auxdatatermino=objSiteRS("pla_datatermino")
	auxaltera="Alterar \ Excluir"
else
	auxdatainicio=Date()
	auxdatatermino=Date()+29
	auxaltera="Cadastrar"
End if

Call Env.RecordSet(false, objSiteRS, null)
%>
<script language="javascript" src="includes/anexo.js"></script>

<script language="javascript">
function selexcluir()
{
  document.formulario.tipocomando.value="Excluir"	
  document.formulario.submit()
}

function ValidaCampos()
{
if (document.formulario.titulo.value=="")
	{
	alert("Título da notícia não informada.\nInforme o título da notícia.");
	        formulario.titulo.focus();
		return false;
	}
if (AchaAspas(document.formulario.titulo.value))
	{
	alert("Título não pode conter Aspas ou apóstrofes.\nCorrija o texto do Título.");
	        formulario.titulo.focus();
		return false;
	}
if (AchaAspas(document.formulario.link.value))
	{
	alert("Link não pode conter Aspas ou apóstrofes.\nCorrija o texto do Link.");
	        formulario.link.focus();
		return false;
	}
if(!(ValidaDataMesAno(document.formulario.diainiexibicao.value+"/"+document.formulario.mesiniexibicao.value+"/"+document.formulario.anoiniexibicao.value,"Data Início")))
	{
		return false;
	}
if(!(ValidaDataMesAno(document.formulario.diafimexibicao.value+"/"+document.formulario.mesfimexibicao.value+"/"+document.formulario.anofimexibicao.value,"Data Expiração")))
	{
		return false;
	}
if(!(DataMaiorIgual(document.formulario.diafimexibicao.value+"/"+document.formulario.mesfimexibicao.value+"/"+document.formulario.anofimexibicao.value,document.formulario.diainiexibicao.value+"/"+document.formulario.mesiniexibicao.value+"/"+document.formulario.anoiniexibicao.value)))
	{
	alert("Data de Expiração não pode ser menor que Data de Início.\nCorrija as Datas.");
		return false;
	}
	return true;
}
</script>
<form method=post action="insCad_plantao.asp" name="formulario"  onsubmit="return ValidaCampos();">
<input type="hidden" name="tipocomando" value="<%=auxaltera%>">
<input type="hidden" name="codNoticia" value="<%=CInt(trim(auxselecao))%>">
<div align="center">
<table width="100%" cellpadding="3" cellspacing="3" class="tabela1">
<tr> 
	<td>
		<b>Título da Notícia:</b><br>
		<input type="text" name="titulo" size="100" maxlength="255" value="<%=auxtitnoticia%>" class="texto1">
    </td>
</tr>
<tr> 
	<td>
		<table class="tabela1" cellpadding="3" cellspacing="0">
		<tr>
			<td>
				<b>Data de Início de Exibição:</b></font><br>
				<select name="diainiexibicao" class="combo">
				  <option value="">Dia</option>
				  <% for i=1 to 31 %>
				<% if i<10 then 
					auxi="0"&i
				     else
					auxi=i
				   end if
				%>	
				  <option value=<%=auxi%>><%=auxi%></option>
				  <%next%>
				</select>
				<select name="mesiniexibicao" class="combo">
				  <option value="">Mês</option>
				  <option value=01>Janeiro</option>
				  <option value=02>Fevereiro</option>
				  <option value=03>Março</option>
				  <option value=04>Abril</option>
				  <option value=05>Maio</option>
				  <option value=06>Junho</option>
				  <option value=07>Julho</option>
				  <option value=08>Agosto</option>
				  <option value=09>Setembro</option>
				  <option value=10>Outubro</option>
				  <option value=11>Novembro</option>
				  <option value=12>Dezembro</option>
				</select>
				<select name="anoiniexibicao" class="combo">
				  <option value="">Ano</option>
				  <% for i=-8 to 8 %>
				<%cbano=year(now)-i%>
				  <option value=<%=cbano%>><%=cbano%></option>
				  <%next%>
				</select>
			</td>
			<td width="50px">&nbsp;</td>
			<td>
				<b>Data Expiração da Exibição:</b><br>
				<select name="diafimexibicao" class="combo">
				  <option value="">Dia</option>
				  <% for i=1 to 31 %>
				<% if i<10 then 
					auxi="0"&i
				     else
					auxi=i
				   end if
				%>
				  <option value=<%=auxi%>><%=auxi%></option>
				  <%next%>
				</select>
				<select name="mesfimexibicao" class="combo">
				  <option value="">Mês</option>
				  <option value=01>Janeiro</option>
				  <option value=02>Fevereiro</option>
				  <option value=03>Março</option>
				  <option value=04>Abril</option>
				  <option value=05>Maio</option>
				  <option value=06>Junho</option>
				  <option value=07>Julho</option>
				  <option value=08>Agosto</option>
				  <option value=09>Setembro</option>
				  <option value=10>Outubro</option>
				  <option value=11>Novembro</option>
				  <option value=12>Dezembro</option>
				</select>
				<select name="anofimexibicao" class="combo">
				  <option value="">Ano</option>
				  <% for i=-8 to 8 %>
				<%cbano=year(now)-i%>
				  <option value=<%=cbano%>><%=cbano%></option>
				  <%next%>
				</select>
			</td>
		</tr>
		</table>
	</td>
</tr>
<tr> 
	<td>
		<b>Link (URL para página relacionada):</b><br>
		<input type="text" name="link" size="100" maxlength="255" value="" class="texto1">
    </td>
</tr>
<tr>
	<td>
		<input type="submit" name="Submit" value=" Atualizar " class="texto1">
        &nbsp;&nbsp;&nbsp; 
<%if auxaltera="Alterar \ Excluir" then %>
        <input type="button" name="Excluir" value="  Excluir  " onclick="javascript: selexcluir()" class="texto1">
<%end if%>
	</td>
</tr>
</table>
</form>
<script language="VBScript">
	document.formulario.titulo.value="<%=auxtitnoticia%>"
	document.formulario.link.value="<%=auxlink%>"
	document.formulario.diafimexibicao.value="<%=Zeros(day(auxdatatermino),2)%>"
	document.formulario.mesfimexibicao.value="<%=Zeros(month(auxdatatermino),2)%>"
	document.formulario.anofimexibicao.value="<%=year(auxdatatermino)%>"

	document.formulario.diainiexibicao.value="<%=Zeros(day(auxdatainicio),2)%>"
	document.formulario.mesiniexibicao.value="<%=Zeros(month(auxdatainicio),2)%>"
	document.formulario.anoiniexibicao.value="<%=year(auxdatainicio)%>"
<% if auxaltera<>"Alterar \ Excluir" then %>
	document.formulario.Submit.value="  Cadastrar  "          
<%end if%>
</script>
<%
Call imprimeRodape(RODAPE_OFF)
%>
