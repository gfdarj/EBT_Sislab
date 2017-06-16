<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/global.asp" -->
<%
Dim chr_Usuario

If Request("Login") <> "" Then
	chr_Usuario = 
	Env.LoginUsuario(Request("Login"))
End If

Response.write "<h3>Página de diagnóstico - SISLAB</h3>"
Response.write "Variáveis de ambiente<br>"
Response.write "<br>Usuario testado: " & Env.Usuario & " (armazenado no cookie: " & Env.usuario & ")"
Response.write "<br>Página Inicial: " & Env.PaginaInicial
Response.write "<br>É RT: " & Env.ehRT
Response.write "<br>É RAT: " & Env.ehRAT
Response.write "<br>É GQ: " & Env.ehGQ
Response.write "<br>Usuário do CRT: " & Env.usuarioCRT
Response.write "<br>É Funcionario EBT: " & Env.ehFuncionario
%>