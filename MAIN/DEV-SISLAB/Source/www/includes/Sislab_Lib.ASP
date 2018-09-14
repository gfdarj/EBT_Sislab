<!--#include file="../includes/AdoVbs.inc"-->
<!--#include file="../includes/Geral_Lib.asp"-->
<!--#include file="../lib/Classe_SQL.asp"-->
<!--#include file="../lib/Classe_Ebt.asp"-->
<!--#include file="../lib/Classe_Mensagem.asp"-->
<!--#include file="../lib/Classe_Tela.asp"-->
<!--#include file="../lib/Classe_Environment.asp"-->
<%
'-- Inicializacao padrao do sistema
Dim Env
Dim Mensagem
Dim Tela

Set Env = New TEnvironment
Set Tela = New TTela
'Set Mensagem = New TMensagem

Env.SetModulo = "SISLAB"


'---------------------------------------------------------------------------------------------------------
' Define os parâmetros necessários ao sistema
'---------------------------------------------------------------------------------------------------------

'Application("SISLAB_CHARSET") = "iso-8859-1"
Application("SISLAB_CHARSET") = "utf-8"
'Application("SISLAB_CHARSET") = "WINDOWS-1252"
%>
