<%
Response.Clear
%>
<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/funcoes.asp" -->
<!--#include file="includes/bib_str.asp" -->
<!--#include file="includes/ControlesXLS.asp"-->
<%
Dim chr_SQL
Dim RS
Dim Titulo
Dim ordenacao

'Precisei usar session por causa do tamanho e dos ' ' e " "
chr_SQL = IIf(VVVNZ(request("SQL")), Session("XLS_EXPORTA_SQL"), request("SQL"))

Titulo = Request("Titulo")
ordenacao = Request("ordenacao")

'rw Titulo & "<BR><BR>"
'rw chr_sql
're
Set RS = Env.oConn.Execute(chr_SQL)

Call criaExcel(Titulo, RS, ordenacao)
%>

