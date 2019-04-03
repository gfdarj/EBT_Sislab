<!--Crie uma página que contém o formulário onde existem os elementos do tio "File" como abaixo: -->
 
<!DOCTYPE html>
<head>
	<title>Upload sem componente</title>
 <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
 
<body>

<!--
<form action="TesteUploadA.asp" method="post" enctype="multipart/form-data">
	E-mail: <input type="text" name="txtEmail"><br>
	Arquivo 1: <input type="file" name="txtArquivo1"><br>
	Arquivo 2: <input type="file" name="txtArquivo2"><br>
	<input type="submit" name="cmdEnviar" value="Enviar">
</form>
-->

	<form action="TesteUploadA.asp" method="post" enctype="multipart/form-data">
		<input type="file" name="arquivo" />
		<input type="submit" value="Upload" />
	</form>

</body>
</html>
 
