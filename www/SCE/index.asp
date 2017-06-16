<!--#include file="includes/abre.asp"-->
<html>
<head>
<title>Site do Centro de Refer&ecirc;ncia Tecnol&oacute;gica</title>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<link rel="stylesheet" href="css/estilo.css">
</head>

<body bgcolor="#C0E0EF" text="#000000" leftmargin="0" topmargin="0" >
<table width="780" border="0" cellspacing="1" cellpadding="0" bgcolor="#003366">
  <tr> 
    <td>
      <table width="778" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td bgcolor="#FFFFFF" colspan="7"> <img src="img/barra_superior_03.jpg" width="778" height="70" usemap="#Map" border="0"></td>
        </tr>
        <tr> 
          <td bgcolor="#003366" colspan="7" height="1"></td>
        </tr>
        <tr> 
          <td bgcolor="#FFFFFF" colspan="7" valign="top" height="330"> 

<form action="login.asp" method="post">
<table height="330" class="texto">
<tr>
    <td class="titulo" style="color: Red">
        &nbsp;&nbsp;&nbsp;&nbsp;ATENÇÃO !!!<br /><br />
        &nbsp;&nbsp;&nbsp;&nbsp;Este SCE está desatualizado, clique no botão "NOVO" para acessar a nova versão.<br /><br />
        &nbsp;&nbsp;&nbsp;&nbsp;<input type='button' name='btnNovo' value=" NOVO " onclick="javascript:location.href='../sce2/index.asp'" />
    </td>
</tr>
<tr><td>&nbsp;</td></tr>
<tr>
	<td class="texto">
		<%if request("msg") <> "" then
			if cint(request("msg")) = 1 then response.write "Usuário inexistente.<br><br>"
			if cint(request("msg")) = 2 then response.write "Senha incorreta.<br><br>"
		end if%>
		Login&nbsp;&nbsp;<input type=text name=login class=form size=20 maxlength="30"><br><br>
		Senha&nbsp;&nbsp;<input type=password name=senha class=form size=20 maxlength="30"><br><br>
		<input type=submit value=" Entrar " class=form>
	</td>
</tr>
</table>
</form>

<script language="JavaScript">document.all.login.focus();</script>

          </td>
        </tr>
        <tr> 
          <td colspan="7" bgcolor="#ffffff" class="texto">
		  	<table bgcolor="#FFFFFF" width="100%" cellspacing="0" cellpadding="0" border="0">
				<tr>
				    <td><img src="img/barra_inferior_01.jpg"  width="610" height="18" border="0"></td>
				    <td class="texto" align="center">:: Desenvolvido por <a href="http://www.isquare.com.br" target="_blank">iSquare</a></td>
				</tr>
			</table>
		  </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<map name="Map"> 
  <area shape="rect" coords="671,18,741,46" href="http://www.embratel.com.br" target="_blank" alt="Site da Embratel" title="Site da Embratel">
</map>
</body>
</html>
<%
conn.close
set conn=nothing
if isobject(rec) then
	set rec = nothing
end if
%>
