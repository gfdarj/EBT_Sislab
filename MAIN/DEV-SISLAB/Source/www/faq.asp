<!-- #INCLUDE FILE="includes/inicializacao.inc" -->
<%
'	On Error Resume Next
'Chama função em config.inc que faz a conexão com o Banco de dados

'	Conecta True

' Inicializo variavel de conexão 

Dim objSiteRS, cont, sSQL, tot
%>
<html>

<head>
    <title>Site do Centro de Referência Tecnológica</title>
    <meta http-equiv="Pragma" content="no-cache">
    <meta charset="<%=Application("SISLAB_CHARSET")%>" />
    <link rel="stylesheet" href="estilos/style.css">
</head>

<script type="text/javascript">
function chama_as(cod_as)
{
    	sel.selecao.value=cod_as;
	sel.submit();
}
</script>

<link rel="stylesheet" href="estilos/style.css">
<body bgcolor="#FFFFFF" topmargin=0 leftmargin=0>

<% 

'Chamo a Barra comum a todas as paginas

	Call MostraHeader 

%>


<table width="700" border="0" cellspacing="0" cellpadding="0">
<tr>
<td colspan=4 bgcolor="#FFFFFF">
<table width="700" border="0" cellspacing="0" cellpadding="0">
<tr>
<td bgcolor="#000030" width="300">
<font face="tahoma" style="font-size=10pt" color="#FFFF00">
<img src="img/icutiliz.gif" border=0 align="absmiddle">&nbsp;<B>&nbsp;Utilizando o CRT</B><br>
</font>
</td>
<td bgcolor="#000030" align="center">
<font face="tahoma" style="font-size=9pt" color="#B1D2FF">
<B>FAQ - Perguntas e Respostas</B><br>
</font>
</td>
<td bgcolor="#000030" align="right">
<font face="tahoma" style="font-size=10pt" color="#FFFFFF">
&nbsp;<B><a href="javascript: history.go(-1);" class="Menu">Voltar</a></B>&nbsp;&nbsp;&nbsp;<br>
</font>
</td>
</tr>
</table>

</td>
</tr>
<tr>

<td valign="top">
&nbsp;
</td>
</tr>

</table>

<center>
<table width=550>

<tr>
<td>
<font class="faqask">
&nbsp;1) Porque a <%=Application("SISLAB_NOME_EMPRESA")%> pensou em ter um laboratório?
 <br>
</font>
<div align=justify>
<font class="faqans">
&nbsp;&nbsp;&nbsp;- 
No conceito original o LAB destinava-se à qualificação e Certificação de Produtos dentro das Normas Telebrás. <br>
Na visão atual o CRT tem como função prover ambientes para testes de Produtos e Integração de Sistemas da Planta Ativa.
 <br><br>
</div>
</font>
</td>
</tr>

<tr>
<td>
<font class="faqask">
&nbsp;2) Quem são os clientes do laboratório?
 <br>
</font>
<div align=justify>
<font class="faqans">
&nbsp;&nbsp;&nbsp;- Os Clientes Internos do CRT são:<br>
Área de Engenharia de Projetos de Redes ( Acesso , Dados, Internet, Satélite, Telefonia e Transporte), Diretorias Regionais, Diretoria de Serviços, Operações Centralizadas e Planejamento.
 <br><br>
</div>
</font>
</td>
</tr>

<tr>
<td>
<font class="faqask">
&nbsp;3) O que é feito neste laboratório?
 <br>
</font>
<div align=justify>
<font class="faqans">
&nbsp;&nbsp;&nbsp;- O CRT está estruturado em 3 Gerências cujas atividades são:<br>
<u>Projetos Especiais</u><br>	
Assegurar o cumprimento das metas e cronogramas relativos à Consultorias Técnicas para o Cliente, através do planejamento e gestão dos recursos necessários à elaboração dos respectivos Projetos Especiais, bem como da disponibilização de estrutura para demonstrações de produtos e soluções customizadas.<br>
<u>Automação de Ensaios</u><br>
Implantar e desenvolver de forma contínua, estrutura para automação de ensaios e testes,  capacitada a ofertar soluções tecnológicas para a planta <%=Application("SISLAB_NOME_EMPRESA")%> e de seus Clientes dentro dos padrões de qualidade, aos menores custos possíveis e nos prazos exigidos.<br>
<u>Integração de Sistemas</u><br>
Suportar as áreas de Engenharia, Operações e Vendas no propósito de assegurar junto aos seus Clientes a confiabilidade da qualidade dos serviços prestados, provendo e mantendo estrutura voltada a testes e simulações de desempenho, integração de  produtos e sistemas de telecomunicações.
 <br><br>
</div>
</font>
</td>
</tr>

<tr>
<td>
<font class="faqask">
&nbsp;4) Como ele vai ajudar a EBT e a seus clientes?
 <br>
</font>
<div align=justify>
<font class="faqans">
&nbsp;&nbsp;&nbsp;- 
Provendo meios para o desenvolvimento de novos produtos e ou Serviços de Telecomunicações para Embratel e comprometendo-se na garantia da qualidade de serviços oferecidos pela <%=Application("SISLAB_NOME_EMPRESA")%>.
 <br><br>
</div>
</font>
</td>
</tr>

<tr>
<td>
<font class="faqask">
&nbsp;5)  Quais os equipamentos que existem neste laboratório?
 <br>
</font>
<div align=justify>
<font class="faqans">
&nbsp;&nbsp;&nbsp;- 
<a href="equipame.asp">Clique aqui</a> e veja a lista completa de Equipamentos do CRT.<br><br>
</div>
</font>
</td>
</tr>

<tr>
<td>
<font class="faqask">
&nbsp;6)  Como chegar a este laboratório?
 <br>
</font>
<div align=justify>
<font class="faqans">
&nbsp;&nbsp;&nbsp;- 
Veja neste Site o <a href="loc_area.asp">mapa de acesso</a> ao CRT ou ainda os <a href="transpor.asp">horários do transporte</a> que sai do prédio sede (RJ) para o CRT.<br><br>
</div>
</font>
</td>
</tr>

<tr>
<td>
<font class="faqask">
&nbsp;7)  Como utilizar o laboratório?
 <br>
</font>
<div align=justify>
<font class="faqans">
&nbsp;&nbsp;&nbsp;- 
Você deve solicitar um agendamento de testes / serviços do laboratório através de um dos <a href="forms.asp">formulários disponível neste site</a> ou caso seja uma solicitação específica que tenha a necessidade da utilização dos recursos do CRT entre em contato conosco pelo endereço <a href="mailto: <%=Application("SISLAB_EMAIL_AUTOMATICO")%>"><%=Application("SISLAB_EMAIL_AUTOMATICO")%></a>.<br><br>
</div>
</font>
</td>
</tr>

</table>
</center>

<%
	'Fechar Objetos abertos
' 	Conecta False

%>
<%
	Call MostraFooter
%>