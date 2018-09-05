<%
Option Explicit
response.buffer = true

'== Monta a tela do sistema =====================================================
Sub MostraHeader()

%>
<script language=javascript>
function Atualiza()
{
//    document.cabecalho.action=document.cabecalho.menu[document.cabecalho.menu.selectedIndex].value
    document.cabecalho.action="index.asp"
    document.cabecalho.submit();
}
</script>
<!--
<left>
<form name="cabecalho" method="post">
<table cellpadding=0 cellspacing=0 border=0 height="69">
<tr>
<td background="img/barcantoesq.gif" width=23 height="69">
&nbsp;
</td>
<td background="img/barmeio.gif" width=195  height="69" valign=top align=left>
<a href="../index.asp"><img src="img/logobarra3.gif"  valign=top border=0></a>
<td background="img/barmeio.gif" width=330  height="69" valign=top align=center>
<a href="../index.asp"><img src="img/barratitulo1.gif"  valign=top border=0></a>
</td>
<td background="img/barmeio.gif" width=150  height="69" valign=top align=right>
<a href="http://pegasus/"><img src="img/ebtbar.gif"  valign=top border=0></a>
</td>
</form>
<td background="img/barcantodir.gif" width=70  height="69">
&nbsp;
</td>
</tr>
</table>
</left> -->
<map name="teste">
<area alt="" coords="3,3,250,68" href="http://ntspo905/sislab1/index.asp">
<area alt="" coords="637,4,756,65" href="http://pegasus/">
</map>
<img src="../img/barra_crt2.jpg" border=0 usemap="#teste">


	<%
End Sub

Sub MostraHeader1_1()
	%>
<HTML>
<HEAD>
<meta http-equiv="pragma" content="no-cache">
	<STYLE TYPE="text/css">
	<!--
	A:link {color:#000060;}
	A:visited {color:#333360;}
	A:hover {color:#0000FF;}
	A:active {color:black;}
	A {text-decoration:none}
	-->
	</STYLE>



<TITLE>Site do CRT</TITLE>

<%
End Sub

Sub MostraFooter()
	%>
	<br>
	</BODY>
	</HTML>
	<%
End Sub

	sub ErroBD( str )
		response.clear %>
<html>
<head>
	<title>Erro</title>
	<link rel="stylesheet" href="includes/style.css" />
</head>
<body bgcolor="#FFFFFF" topmargin=0 leftmargin=0><%
call MostraHeader %><br>
<p align="center" class="erro">
<table align="center" class="tipo1" width="480px">
<tr><th class="titulo">Erro</th></tr>
<tr><td align="center">Houve um erro na obten&ccedil;&atilde;o de dados (<%= str %>). Se este erro persistir, por favor contate o administrador.</td></tr>
</table><br>
<button onclick="javascript:location.reload();">Tentar Novamente</button>&nbsp;&nbsp;&nbsp;&nbsp;<button onclick="javascript:history.back();">Voltar</button>
</p>
</body>
</html><%
		response.end
	end sub
%>