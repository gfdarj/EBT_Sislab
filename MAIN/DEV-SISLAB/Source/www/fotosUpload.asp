<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/bib_str.asp" -->
<!--#include file="Lib/Classe_Arquivo.asp" -->
<%
Server.ScriptTimeout = 100000

Dim Upload
Dim Count
Dim chr_Acao
Dim chr_Descricao
Dim chr_Titulo
Dim chr_Data
Dim chr_Usuario

Set Upload = New TArquivo

Call Upload.Init_UP()

Upload.SetOverwrite = False

'Call Upload.Upload(2007)
Call Upload.Upload()
Call Upload.Salva("")

chr_Acao = Upload.Campo("acao")
id_Arq = Upload.Campo("id_arquivo")
chr_Titulo = Upload.Campo("titulo")
chr_Descricao = Upload.Campo("descricao")
chr_Usuario = Upload.Campo("usuario")
chr_URL = Upload.Arquivo(1)

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

chr_Data =  Year(date()) & Zeros(Month(date()),2) & Zeros(Day(date()),2)

If Not Upload.TemErro Then

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
	int_Retorno =  RS("saida")

	If int_Retorno <> -1 Then 'Ok
		Set UpLoad = Nothing
		Response.Redirect "fotos.asp"
	Else
		Call MensagemErro("Não foi possível carregar o arquivo selecionado.")
	End If
Else
	Upload.Excluir(chr_URL)

	Call MensagemErro("Ocorreu um erro ao tentar carregar o arquivo selecionado.")
End If

Set UpLoad = Nothing

'---------------------------------------

Sub MensagemErro(chr_Msg)
	Call ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Cadastrar Fotos", "", "")

	chr_Buf = _
			"<scr" & "ipt language='JavaScript'>" & VbCrLf & _
			"hideAguarde()" & VbCrLf & _
			"</scr" & "ipt>" & VbCrLf & _
			"<br><table align='center' class='tabela1' border='0' cellpadding='3' cellspacing='0'>" & VbCrLf & _
			"<tr>" & VbCrLf & _
			"	<td class='texto1' align='center'><b><i>" & chr_Msg & "</i></b></td>" & VbCrLf & _
			"</tr>" & VbCrLf & _
			"<tr><td>&nbsp;</td></tr>" & VbCrLf & _
			"<tr>" & VbCrLf & _
			"	<td align='center'><input type='Button' class='texto1' value=' Voltar ' onclick='javascript:location.href=""fotos.asp"";'></td>" & VbCrLf & _
			"</tr>" & VbCrLf & _
			"</table></form>" & VbCrLf & _
			"<br>" & VbCrLf

	RW chr_Buf

	Call ImprimeRodape(RODAPE_OFF)
End Sub

%>