<!--#include file="../includes/AdoVbs.inc"-->
<!--#include file="../includes/Geral_Lib.asp"-->
<!--#include file="../Classes/Classe_SQL.asp"-->
<!--#include file="../Classes/Classe_Mensagem.asp"-->
<!--#include file="../Classes/Classe_Tela.asp"-->
<!--#include file="../Classes/Classe_Ebt.asp"-->
<!--#include file="../Classes/Classe_Environment.asp"-->
<%
'-- Inicializacao padrao do sistema
Dim Env
Dim Mensagem
Dim Tela

'response.write "IOOOO 123 543 aaaa"
'response.end


Set Env = New TEnvironment
Set Tela = New TTela
'Set Mensagem = New TMensagem

Env.SetModulo = "SISLAB"

%>
