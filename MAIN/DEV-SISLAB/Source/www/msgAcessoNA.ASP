<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="Global.asa"-->
<!--#include file="includes/EmailHTML.asp" -->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/Sislab_Lib.asp"-->

<%
'session.abandon
Dim bln_EmJanela : bln_EmJanela = (Request("janela") = "1")
%>

<!DOCTYPE html>

<html>
    <head>
        <title>SISLAB - Acesso Negado</title>
	    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
        <meta http-equiv='pragma' content='no-cache'>
        <!--<meta http-equiv='refresh' content='2; url=login.asp'>-->
    </head>

    <body marginwidth="2" marginheight="10" bgcolor="#FFFFFF">
	    <center>
	        <br /><br />

	        <font face="verdana" color=#777777 size=5 style="font-size:20pt;">
	            ACESSO NEGADO
	        </font>

            <br /><br />

	        <center>
	            <table width="70%" align='center'>
	            <tr>
                    <td>
	                    <center>
	                    <br /><br /><br />

	                    <font face="verdana" color=#CC7777 size=5 style="font-size:18pt;">
	                        USUÁRIO <u><%=UCase(Env.Nome_Reduzido())%></u> NÃO  ESTÁ AUTORIZADO A ACESSAR ESTA ÁREA OU A SUA SESSÃO ESTÁ EXPIRADA.<BR><BR>
<%
If bln_EmJanela Then
	Response.Write "CLIQUE <a href='javascript:window.close();'>AQUI</a> PARA FECHAR ESTA JANELA"
Else
	Response.Write "REINICIE O BROWSER OU CLIQUE <a href='index.asp'>AQUI</a>, E CASO O ERRO PERSISTA CONTATE O ADMINISTRADOR DO SITE</font>"
End If
%>
                        <br /><br />
	                    <font face="verdana" color=#AAAAAA size=4 style="font-size:14pt;">
                        <br /><br />
	                    </font>
                        <br /><br />
                        <br />
	                    </center>
            	    </td>
	            </tr>
	    </table>
    </BODY>
</html>
