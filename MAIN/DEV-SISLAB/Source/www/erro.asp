<html>

<head>
<link rel="stylesheet" href="estilos/style.css">
</head>

<body>

<table border="0" width="100%">
  <tr>
    <td width="100%" bgcolor="#000000"><font class="submenu"><b>&nbsp;&nbsp;Erro
      no processamento</b></font></td>
  </tr>
  <tr>
    <td width="100%"><font class="item"><br>
      Ocorreu um erro no processamento da página que você está
      tentando acessar. <br>
      Entre em contato com o webmaster do site reportando os seguintes erros:</font>
 </td>
  </tr>
  <tr>
    <td width="100%">
	<font class="item">Número: <%= Request("perro")%><BR>
	Descrição: <%= Request("pdescricao")%>
	</font>
	</td>
  </tr>
</table>

</body>

</html>
