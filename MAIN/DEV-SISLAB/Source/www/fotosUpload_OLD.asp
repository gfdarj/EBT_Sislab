<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#inc lude file="includes/bib_str.asp" -->
<%
Server.ScriptTimeout = 100000

Dim Upload
Dim Count
Dim chr_Acao
Dim chr_Descricao
Dim chr_Titulo
Dim chr_Data
Dim int_Erro
Dim chr_Usuario

On Error Resume Next
Set Upload = Server.CreateObject( "Persits.Upload.1" )

Count = Upload.Save( Server.MapPath(".") & "\arquivos" )
On Error Goto 0

int_Erro = Err.Number

chr_Acao = Upload.Form("acao").Value
id_Arq = Upload.Form("id_arquivo").Value
chr_Titulo = Upload.Form("titulo").Value
chr_Descricao = Upload.Form("descricao").Value
chr_Usuario = Upload.Form("usuario").Value
chr_URL = Upload.Files(1).ExtractFileName
chr_Data = Day(date()) & "/" & Month(date()) & "/" & Year(date())

If int_Erro = 0 Then

'response.write Application("SISLAB_id_TipoArquivo_Imagem") & ":1<BR>"
'response.write chr_Titulo & ":2<BR>"
'response.write chr_URL & ":3<BR>"
'response.write chr_Usuario & ":4<BR>"
'response.write chr_Data & ":5<BR>"
'response.write UCase(request.ServerVariables("REMOTE_ADDR")) & ":6<BR>"
'response.write chr_Descricao & ":7<BR>"


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
	Upload.DeleteFile( Server.MapPath(".") & "\arquivos\" & chr_URL)

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