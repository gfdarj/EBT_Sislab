<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/bib_str.asp" -->
<!--#include file="Classes/Classe_Arquivo.asp" -->
<%
Dim objSiteRS
Dim cont, sSQL, Upload
Dim count, file,auxusername,auxip,auxnumAS,auxcodarq,auxtit
Dim Arquivo

Set Arquivo = New TArquivo

Arquivo.SetOverwrite = False

Call Arquivo.Init_UP()
Call Arquivo.Upload()

auxnumAS = Arquivo.Campo("cod_AS")
auxusername = Arquivo.Campo("username")
auxip = Arquivo.Campo("ip")
cont = 1

dim s
s = ""

Call Arquivo.Salva(auxnumAS)

For cont = 1 To Arquivo.TotalArquivos

	Auxtit="DIAGRAMA-" & Zeros(auxnumAS,4) & "-" & _
		year(date) & Zeros(month(date),2) & Zeros(Day(date),2) & "-" & _
		Hour(now) & minute(now) & second(now) & "-" & CONT

	sSQL = ""
	sSQL = sSQL & "SET NOCOUNT ON;"
	sSQL = sSQL & "Insert Into ARQUIVOS "
	sSQL = sSQL & "(ARQ_LINK, ARQ_NOMEARQ, ARQ_CODARQTIPO, "
	sSQL = sSQL & "ARQ_Responsavel, ARQ_IDORGAO, ARQ_DataAtualizacao, IPcadastro, "
	sSQL = sSQL & "arq_dataaprovacao, UserIDCadastro, ARQ_IDSituacao, ARQ_Ocultar) "	
	sSQL = sSQL & " values ('" & auxtit &"','" & Arquivo.ArquivoSubPasta(cont) & "', 8,"
	sSQL = sSQL & "'" & auxusername &"', 2, getDate(),'"&auxip&"', "
	sSQL = sSQL & " getDate(),'" & auxusername &"', 2, 0);"
	sSQL = sSQL & "SELECT @@IDENTITY; "
	Call Env.RecordSet(True, objSiteRS, sSQL)

'    s = s & sSQL & "<BR><BR>" & VbCrLf

	auxcodarq = objSiteRS(0)
	Call Env.RecordSet(False, objSiteRS, Null)

    sSQL = "Insert Into DIAGRAMAS "
	sSQL = sSQL & "(AG_Numero, ARQ_codARQ) "
	sSQL = sSQL & "values(" & auxnumAS & "," & auxcodarq & "); "
	Call Env.oConn.Execute(sSQL)


    '***** ATENÇÃO !!!
    '   COLOQUEI ESSE CÓDIGO PORQUE ESTAVA MULTIPLICANDO POR 6 TODOS OS INSERT´S NA TABELA DE ARQUIVOS
    '   NÃO ENCONTREI TRIGGER, NEM CONSTRAINT, NEM OUTRO MOTIVO PARA OCORRER TAL PROBLEMA !!!
    '
    '   GILBERTO - 08/SET/2017
    '*
	sSQL = "DELETE FROM ARQUIVOS "
	sSQL = sSQL & "WHERE ARQ_LINK = '" & auxtit & "' AND ARQ_NOMEARQ = '" & Arquivo.ArquivoSubPasta(cont) & "' AND "
    sSQL = sSQL & "ARQ_Responsavel = '" & auxusername & "' AND ARQ_CODARQ NOT IN (SELECT ARQ_CODARQ FROM DIAGRAMAS)"
	Call Env.oConn.Execute(sSQL)

Next

Response.Clear

Call ImprimeCabecalho2("Cadastro de Agendamento - Upload de Arquivos", MENU_OFF, false, "100%", "Agendamento " & auxnumAS & " - Upload de Arquivos e Diagramas", "NENHUM", "")
%>
<table border="0" width="100%" class="tabela1" cellpadding="3" cellspacing="3">
<tr>
	<td>
		&nbsp;<span class="vermelho2">&raquo;</span>&nbsp;<span class="texto1b" style="font-size: 12px;">Arquivos Gravados (Total: <%=Arquivo.TotalArquivos%>)</span>
	</td>
</tr>
<tr><td>S: <%=s %></td></tr>
<tr>
	<td>
<%
For Each file In Arquivo.Arquivos
	Response.Write file.path & "<br>"
	Response.Write file.name & "<br>"
	Response.Write file.size & "<br>"
	Response.Write File.ExtractFileName & "<br><br>"
Next
%>
	</td>
</tr>
<tr>
	<td class="cinza1"><i>Gravado por: <%=auxusername%>&nbsp;&nbsp;&nbsp;IP: <%=auxip%></i></td>
</tr>
<tr>
	<td align="center"><input type="Button" class="texto1" value="Fechar" onclick="javascript:window.close();"></td>
</tr>
</table>
<%
Set Arquivo = Nothing

Call imprimeRodape(RODAPE_OFF)
%>
