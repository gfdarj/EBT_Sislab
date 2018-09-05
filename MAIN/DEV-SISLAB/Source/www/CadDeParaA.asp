<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/funcoes.asp" -->
<%
'Dados Básico - Cliente -----------------------------------------------------------
TABELA = REQUEST("depara")
DE  = REQUEST("strDE")
PARA = REQUEST("PARA")
DE = replace(DE," | ",SEPARADOR_CAMPO)

ssql = "exec sp_CadDePara '" & SEPARADOR_CAMPO & "','" & SEPARADOR_REGISTRO & "','" & TABELA & "','" & DE & "','" & PARA & "'"
ssql = replace(ssql,",,",",null,")
ssql = replace(ssql,"''","null")
ssql = replace(ssql,"'//'","null")
ssql = replace(ssql,",,",",null,")

response.write ssql
response.end

Call Env.oConn.execute(ssql)

response.redirect "CadDePara.asp?depara=" & TABELA
%>