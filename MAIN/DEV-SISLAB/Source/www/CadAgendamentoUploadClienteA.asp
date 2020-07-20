<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/bib_str.asp" -->
<!--#include file="Classes/Classe_Upload.asp" -->
<%
Dim objSiteRS
Dim cont, sSQL, Upload
Dim count, file, auxusername, auxip, auxnumAS, auxcodarq, auxtit, s
Dim str_ListaArquivos : str_ListaArquivos = ""
Dim subPasta : subPasta = ""
Dim str_Arquivo : str_Arquivo = ""

Response.Charset = Application("SISLAB_CHARSET")

Dim Form : Set Form = New ASPForm

Server.ScriptTimeout = 1440 ' Limite de 24 minutos de execução de código, o upload deve acontecer dentro deste tempo ou então ocorre erro de limite de tempo.

Const MaxFileSize = 25200000 ' Limite de 25,2 Mb de arquivo

If Form.State = 0 Then

    auxnumAS = Form.Item("cod_AS")
    auxusername = Form.Item("username")
    auxip = Form.Item("ip")
    cont = 1
    subPasta = Form.SubPastaAS(auxnumAS)
    If subPasta <> "" Then subPasta = subPasta & "\" 

    'Faz o upload dos arquivos
    For each Field in Form.Files.Items
        ' # Field.Filename : Nome do Arquivo que chegou.
        ' # Field.ByteArray : Dados binários do arquivo, útil para subir em blobstore (MySQL).
        Field.SaveAs Server.MapPath(".") & "\" & Application("SISLAB_FolderArquivos") & "\" &  subPasta & Field.FileName

        str_ListaArquivos = str_ListaArquivos & cont & " - " & Field.FileName & "<br />"
        str_Arquivo = subPasta & Field.FileName

	    Auxtit = "DIAGRAMA-" & Zeros(auxnumAS,4) & "-" & _
		         year(date) & Zeros(month(date),2) & Zeros(Day(date),2) & "-" & _
		         Hour(now) & minute(now) & second(now) & "-" & CONT

	    sSQL = ""
	    sSQL = sSQL & "SET NOCOUNT ON;"
	    sSQL = sSQL & "Insert Into ARQUIVOS "
	    sSQL = sSQL & "(ARQ_LINK, ARQ_NOMEARQ, ARQ_CODARQTIPO, "
	    sSQL = sSQL & "ARQ_Responsavel, ARQ_IDORGAO, ARQ_DataAtualizacao, IPcadastro, "
	    sSQL = sSQL & "arq_dataaprovacao, UserIDCadastro, ARQ_IDSituacao, ARQ_Ocultar) "	
	    sSQL = sSQL & " values ('" & auxtit &"','" & str_Arquivo & "', 8,"
	    sSQL = sSQL & "'" & auxusername &"', 2, getDate(),'"&auxip&"', "
	    sSQL = sSQL & " getDate(),'" & auxusername &"', 2, 0);"
	    sSQL = sSQL & "SELECT @@IDENTITY; "
	    Call Env.RecordSet(True, objSiteRS, sSQL)

        's = s & sSQL & "<BR><BR>" & VbCrLf

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
        sSQL = sSQL & "WHERE ARQ_LINK = '" & auxtit & "' AND ARQ_NOMEARQ = '" & str_Arquivo & "' AND "
        sSQL = sSQL & "ARQ_Responsavel = '" & auxusername & "' AND ARQ_CODARQ NOT IN (SELECT ARQ_CODARQ FROM DIAGRAMAS)"
        Call Env.oConn.Execute(sSQL)

        cont = cont + 1
    Next

    Response.Clear

    Call Tela.ImprimeCabecalho2("Cadastro de Agendamento - Upload de Arquivos", MENU_OFF, false, "100%", "Agendamento " & auxnumAS & " - Upload de Arquivos e Diagramas", "NENHUM", "")
%>
<div class="margem-10">
    <table border="0" width="100%" class="table-condensed">
    <tr>
	    <td>
		    <span class="texto-vermelho-bold">&raquo;</span>&nbsp;Arquivos Gravados (Total: <%=cont-1%>)</span>
	    </td>
    </tr>
    <tr>
	    <td>
            <%=str_ListaArquivos%>
	    </td>
    </tr>
    <tr>
	    <td class="cinza1"><i>Gravado por: <%=auxusername%>&nbsp;&nbsp;&nbsp;IP: <%=auxip%></i></td>
    </tr>
    <tr>
	    <td align="center"><input type="button" class="btn btn-primary" value="Fechar" onclick="javascript:window.close();"></td>
    </tr>
    </table>
</div>
<%
Else
    Call Tela.ImprimeCabecalho2("Cadastro de Agendamento - Upload de Arquivos", MENU_OFF, false, "100%", "Agendamento " & auxnumAS & " - Upload de Arquivos e Diagramas", "NENHUM", "") %>
<div class="margem-10">
    <table border="0" width="100%" class="table-condensed">
    <tr>
	    <td>
		    <span class="texto-vermelho-bold">&raquo;</span>&nbsp;Ocorreu um erro ao fazer o upload.
	    </td>
    </tr>
    <tr>
	    <td align="center"><input type="button" class="btn btn-primary" value="Fechar" onclick="javascript:window.close();"></td>
    </tr>
    </table>
</div>
<%
End If


'For cont = 1 To Arquivo.TotalArquivos
'
'	Auxtit="DIAGRAMA-" & Zeros(auxnumAS,4) & "-" & _
'		year(date) & Zeros(month(date),2) & Zeros(Day(date),2) & "-" & _
'		Hour(now) & minute(now) & second(now) & "-" & CONT
'
'	sSQL = ""
'	sSQL = sSQL & "SET NOCOUNT ON;"
'	sSQL = sSQL & "Insert Into ARQUIVOS "
'	sSQL = sSQL & "(ARQ_LINK, ARQ_NOMEARQ, ARQ_CODARQTIPO, "
'	sSQL = sSQL & "ARQ_Responsavel, ARQ_IDORGAO, ARQ_DataAtualizacao, IPcadastro, "
'	sSQL = sSQL & "arq_dataaprovacao, UserIDCadastro, ARQ_IDSituacao, ARQ_Ocultar) "	
'	sSQL = sSQL & " values ('" & auxtit &"','" & Arquivo.ArquivoSubPasta(cont) & "', 8,"
'	sSQL = sSQL & "'" & auxusername &"', 2, getDate(),'"&auxip&"', "
'	sSQL = sSQL & " getDate(),'" & auxusername &"', 2, 0);"
'	sSQL = sSQL & "SELECT @@IDENTITY; "
'	Call Env.RecordSet(True, objSiteRS, sSQL)
'
''    s = s & sSQL & "<BR><BR>" & VbCrLf
'
'	auxcodarq = objSiteRS(0)
'	Call Env.RecordSet(False, objSiteRS, Null)
'
'    sSQL = "Insert Into DIAGRAMAS "
'	sSQL = sSQL & "(AG_Numero, ARQ_codARQ) "
'	sSQL = sSQL & "values(" & auxnumAS & "," & auxcodarq & "); "
'	Call Env.oConn.Execute(sSQL)
'
'
'    '***** ATENÇÃO !!!
'    '   COLOQUEI ESSE CÓDIGO PORQUE ESTAVA MULTIPLICANDO POR 6 TODOS OS INSERT´S NA TABELA DE ARQUIVOS
'    '   NÃO ENCONTREI TRIGGER, NEM CONSTRAINT, NEM OUTRO MOTIVO PARA OCORRER TAL PROBLEMA !!!
'    '
'    '   GILBERTO - 08/SET/2017
'    '*
'	sSQL = "DELETE FROM ARQUIVOS "
'	sSQL = sSQL & "WHERE ARQ_LINK = '" & auxtit & "' AND ARQ_NOMEARQ = '" & Arquivo.ArquivoSubPasta(cont) & "' AND "
'    sSQL = sSQL & "ARQ_Responsavel = '" & auxusername & "' AND ARQ_CODARQ NOT IN (SELECT ARQ_CODARQ FROM DIAGRAMAS)"
'	Call Env.oConn.Execute(sSQL)
'Next

Set Form = Nothing

Call Tela.MostraRodape()
%>
