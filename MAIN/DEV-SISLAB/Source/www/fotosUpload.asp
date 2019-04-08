<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/bib_str.asp" -->
<!--#include file="classes/Classe_Upload.asp" -->
<%
Server.ScriptTimeout = 100000

Dim Upload
Dim Count
Dim chr_Acao
Dim chr_Descricao
Dim chr_Titulo
Dim chr_Data
Dim chr_Usuario

Dim Form : Set Form = New ASPForm

Server.ScriptTimeout = 1440 ' Limite de 24 minutos de execução de código, o upload deve acontecer dentro deste tempo ou então ocorre erro de limite de tempo.

Const MaxFileSize = 25200000 ' Limite de 25,2 Mb de arquivo

If Form.State = 0 Then

    int_Retorno = 0
    chr_Acao = Form.Item("acao")
    id_Arq = Form.Item("id_arquivo")
    chr_Titulo = Form.Item("titulo")
    chr_Descricao = Form.Item("descricao")
    chr_Usuario = Form.Item("usuario")
    chr_Data =  Year(date()) & Zeros(Month(date()),2) & Zeros(Day(date()),2)

    For each Field in Form.Files.Items
        ' # Field.Filename : Nome do Arquivo que chegou.
        ' # Field.ByteArray : Dados binários do arquivo, útil para subir em blobstore (MySQL).
        Field.SaveAs Server.MapPath(".") & "\" & Application("SISLAB_FolderArquivos") & "\" & Field.FileName

        chr_URL = Field.FileName

	    chr_SQL = "exec sp_Cadastra_Arquivos 'INSERIR', Null, '" & chr_Data & "', Null, " & _
				    Application("SISLAB_id_TipoArquivo_Imagem") & ", '" & _
				    chr_Titulo & "', '" & _
				    chr_URL & "', '" & _
				    chr_Usuario & "', " & _
				    "Null, Null, Null, 0, '" & chr_Data & "', '" & _
				    UCase(request.ServerVariables("REMOTE_ADDR")) & "', '" & _
				    chr_Usuario & "', '" & _
				    chr_Descricao & "', " & _
				    "Null, Null, Null, Null, Null"

	    Set RS = Env.oConn.Execute(chr_SQL)
        If RS("saida") = -1 Then
            int_Retorno = -1
        End If
    Next

	If int_Retorno <> -1 Then 'Ok
		Set Form = Nothing
		Response.Redirect "fotos.asp"
	Else
		Call MensagemErro("Não foi possível carregar o arquivo selecionado.")
	End If
Else
	Call MensagemErro("Ocorreu um erro ao tentar carregar o arquivo selecionado.")
End If


'response.write Application("SISLAB_id_TipoArquivo_Imagem") & ":1<BR>"
'response.write chr_Titulo & ":2<BR>"
'response.write chr_URL & ":3<BR>"
'response.write chr_Usuario & ":4<BR>"
'response.write chr_Data & ":5<BR>"
'response.write UCase(request.ServerVariables("REMOTE_ADDR")) & ":6<BR>"
'response.write chr_Descricao & ":7<BR>"
'response.write Upload.ArquivoSubPasta(1) & ":8<BR>"
'Response.end

'chr_Acao = Upload.Form("acao").Value
'id_Arq = Upload.Form("id_arquivo").Value
'chr_Titulo = Upload.Form("titulo").Value
'chr_Descricao = Upload.Form("descricao").Value
'chr_Usuario = Upload.Form("usuario").Value
'chr_URL = Upload.Files(1).ExtractFileName



'---------------------------------------

Sub MensagemErro(chr_Msg)
	Call Tela.ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Cadastrar Fotos", "", "")

	chr_Buf = _
			"<scr" & "ipt language='JavaScript'>" & VbCrLf & _
			"   hideAguarde()" & VbCrLf & _
			"</scr" & "ipt>" & VbCrLf & _
			"<div class='margem-10'>" & VbCrLf & _
			"   <br>" & VbCrLf & _
			"   <table align='center' class='table-condensed' border='0' cellpadding='3' cellspacing='0'>" & VbCrLf & _
			"   <tr>" & VbCrLf & _
			"	    <td class='texto1' align='center'><b><i>" & chr_Msg & "</i></b></td>" & VbCrLf & _
			"   </tr>" & VbCrLf & _
			"   <tr><td>&nbsp;</td></tr>" & VbCrLf & _
			"   <tr>" & VbCrLf & _
			"	    <td align='center'><input type='button' value=' Voltar ' onclick='javascript:location.href=""fotos.asp"";'></td>" & VbCrLf & _
			"   </tr>" & VbCrLf & _
			"   </table></form>" & VbCrLf & _
			"</div>" & VbCrLf & _
			"<br>" & VbCrLf
	RW chr_Buf

    Call Tela.MostraRodape()
End Sub

%>