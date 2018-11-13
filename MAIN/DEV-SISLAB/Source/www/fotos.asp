<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/bib_str.asp" -->
<%
Server.ScriptTimeout = 100000

Dim chr_URL
Dim chr_Link
Dim id_Arq
Dim chr_Imagem
Dim chr_Path
Dim chr_Path1
Dim chr_Acao
Dim chr_Descricao

chr_Imagem = "arquivos/"
'chr_Imagem = "arquivos/ImgRotator/"
chr_Path = Server.MapPath(chr_Imagem)
chr_Path1 = Server.MapPath(".")

chr_Acao = RQ("acao")
id_Arq = RQ("id_arquivo")
chr_URL = RQ("arquivo")

Set objFSO = Server.CreateObject("Scripting.FileSystemObject")

Select Case chr_Acao

	Case "EXC"
		Call ApagaImagem(id_Arq)

	Case Else
		Call ListaImagens()

End Select

Set objFSO = Nothing

'---------------------------------------

Sub ApagaImagem(id_Arq)
	Dim chr_SQL
	Dim RS
	Dim chr_Arq
	Dim int_Retorno

	chr_SQL = _
		"SELECT ARQ_NOMEARQ " & _
		"FROM Arquivos " & _
		"WHERE ARQ_CODARQ = " & id_Arq
	Call Env.RecordSet(True, RS, chr_SQL)
	If Not (RS.Eof And RS.Bof) Then chr_Arq = RS(0) Else chr_Arq = "nao_encontrado"
	Set RS = Nothing

	'On Error Resume Next
	objFSO.DeleteFile(chr_Path & "\" & chr_Arq)
	'On Error Goto 0

	If Err.Number = 0 Then
		chr_SQL = "exec sp_Cadastra_Arquivos 'EXCLUIR', Null, Null, " & id_Arq & ", Null, Null, Null, Null, Null, Null, Null, Null, Null, Null, Null, Null, Null, Null, Null, Null, Null"

		Set RS = Env.oConn.Execute(chr_SQL)
		int_Retorno =  RS("saida")

		If int_Retorno <> -1 Then 'Ok
			RR "fotos.asp"
		Else
			Call MensagemErro("Não foi possível excluir o arquivo selecionado.")
		End If
	Else
		Call MensagemErro("Ocorreu um erro ao tentar excluir o arquivo selecionado.")
	End If

End Sub


Sub ListaImagens()
	Dim int_FileSize
	Dim chr_Buf
	Dim chr_Buf1
	Dim chr_Buf2

	Set objFolder = objFSO.GetFolder(chr_Path)

	Call Tela.imprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Cadastrar Fotos", "", "")

	chr_SQL = _
		"SELECT ARQ_NOMEARQ, ARQ_LINK, ARQ_CODARQ , ARQ_DESCRICAO " & _
		"FROM Arquivos " & _
		"WHERE ARQ_CODARQTIPO = " & Application("SISLAB_id_TipoArquivo_Imagem") & " " & _
		"ORDER BY ARQ_LINK ASC"

	Call Env.RecordSet(True, RS, chr_SQL)

	chr_Buf = _
			"<scr" & "ipt type='text/javascript'>" & VbCrLf & _
			"function abreJanela(id_arq)" & VbCrLf & _
			"{" & VbCrLf & _
			"	var w = window.open('fotos_exibe.asp?arq=' + id_arq, '', 'toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,copyhistory=no,width=780,height=500,top=5,left=5');" & VbCrLf & _
			"	w.focus();" & VbCrLf & _
			"}" & VbCrLf & _
			"function apagar(f, arq, obj)" & VbCrLf & _
			"{" & VbCrLf & _
			"	f.action = 'fotos.asp?Acao=EXC&id_arquivo=' + arq;" & VbCrLf & _
			"	f.submit();" & VbCrLf & _
			"}" & VbCrLf & _
			"</scr" & "ipt>" & VbCrLf & _
			"<scr" & "ipt type='text/jav" & "ascr" & "ipt' src='inclu" & "des/anexo.js'></scr" & "ipt>" & VbCrLf & _
			"" & VbCrLf & _
			"<div class='margem-10'>" & VbCrLf & _
			"<form name='frmUpload' method='post' action='fotosUpload.asp'  ENCTYPE='multipart/form-data'>" & VbCrLf & _
			"<input type='hidden' name='usuario' value='" & Env.Usuario() & "'>" & VbCrLf & _
			"<input type='hidden' name='acao' value=''>" & VbCrLf & _
			"<input type='hidden' name='id_arquivo' value=''>" & VbCrLf & _
			"<input type='hidden' name='arquivo' value=''>" & VbCrLf

	chr_Buf1 = _
			"<br><br>" & VbCrLf & _
			"<table class='table-condensed table-bordered table-striped table-hover'>" & VbCrLf & _
			"<tr>" & VbCrLf & _
			"	<th align='center'><b>Visualização</b></th><th><b>Arquivo</b></th><th><b>Descrição</b></th><th><b>Tamanho</b></th><th>&nbsp;&nbsp;&nbsp;</th>" & VbCrLf & _
			"</tr>" & VbCrLf

	If Not (RS.Eof And RS.Bof) Then

		While Not RS.Eof
			chr_URL = RS(0)
			chr_Link = RS(1)
			id_Arq = RS(2)
			chr_Descricao = RS(3)

			If objFSO.FileExists(chr_Path & "\" & chr_URL) Then
				Set objTxt = objFSO.GetFile(chr_Path & "\" & chr_URL)
				int_FileSize = int(objTxt.Size/1024)
				Set objTxt = Nothing
			Else
				int_FileSize = 0
			End If

			chr_Buf1 = chr_Buf1 & _
				"<tr id='tr_" & int_conta & "'>" & VbCrLF & _
				"	<td align='center'>" & VbCrLF & _
				"		<a href='#' onclick='abreJanela(" & id_Arq & ");'><img border='0' title='Clique aqui para ver a imagem em tamanho natural' width='130px' height='100px' src='arquivos/" & chr_URL & "'></a>" & VbCrLF & _
				"	</td>" & VbCrLF & _
				"	<td>" & VbCrLF & _
				"		" & chr_Link & "&nbsp;</a>" & VbCrLF & _
				"	</td>" & VbCrLF & _
				"	<td align='justify'>" & chr_Descricao &"&nbsp;</td>" & VbCrLF & _
				"	<td align='right'>" & FormataNumero(int_FileSize) &" Kb</td>" & VbCrLF & _
				"	<td>" & VbCrLF & _
				"		<a href='#' onclick='apagar(frmUpload, " & id_Arq & ", """ & chr_URL & """);'>" & VbCrLF & _
				"		<img border='0' src='img/btn_excluir.gif' title='Clique aqui para apagar este arquivo'></a>" & VbCrLF & _
				"	</td>" & VbCrLF & _
				"</tr>" & VbCrLf

			RS.MoveNext
		WEnd

	Else
		chr_Buf1 = chr_Buf1 & _
			"<tr>" & VbCrLf & _
			"	<td colspan='5' align='center'><b><i>Nenhuma Imagem encontrada</i></b></td>" & VbCrLf & _
			"</tr>" & VbCrLf
	End If

	chr_Buf1 = chr_Buf1 & "</table>" & VbCrLf

	'--Entra com os dados para cadastro da foto.
	chr_Buf2 = VbCrLf & _
			"<scr" & "ipt type='text/javascript'>" & VbCrLf & _
			"function ValidaUpload(f)" & VbCrLf & _
			"{" & VbCrLf & _
			"	if (document.all.id_arquivo.value == '') {" & VbCrLf & _
			"		alert('Nenhum arquivo selecionado.');" & VbCrLf & _
			"		document.all.id_arquivo.focus();" & VbCrLf & _
			"		return false;" & VbCrLf & _
			"	}" & VbCrLf & _
			"	if (!validaNomeArquivo(extractFileName(document.all.FILE1.value))) {" & VbCrLf & _
			"		alert('O nome do arquivo está inválido. Retire acentuação e espaços antes de prosseguir.');" & VbCrLf & _
			"		document.all.FILE1.focus();" & VbCrLf & _
			"		return false;" & VbCrLf & _
			"	}" & VbCrLf & _
			"	if (document.all.titulo.value == '') {" & VbCrLf & _
			"		alert('Informe o título da foto.');" & VbCrLf & _
			"		document.all.titulo.focus();" & VbCrLf & _
			"		return false;" & VbCrLf & _
			"	}" & VbCrLf & _
			"	if (document.all.descricao.value == '') {" & VbCrLf & _
			"		alert('Informe a descrição da foto.');" & VbCrLf & _
			"		document.all.descricao.focus();" & VbCrLf & _
			"		return false;" & VbCrLf & _
			"	}" & VbCrLf & _
			"	showAguarde(); " & VbCrLf & _
			"	return true" & VbCrLf & _
			"}" & VbCrLf & _
			"function Envia()" & VbCrLf & _
			"{" & VbCrLf & _
			"	if(ValidaUpload(document.forms[0]))" & VbCrLf & _
			"	{" & VbCrLf & _
			"		document.all.acao.value='INS';" & VbCrLf & _
			"		document.forms[0].action='fotosUpload.asp';" & VbCrLf & _
			"		document.forms[0].submit();" & VbCrLf & _
			"	}" & VbCrLf & _
			"}" & VbCrLf & _
			"</scr" & "ipt>" & VbCrLf & _
			"<scr" & "ipt language='JavaScript'>" & VbCrLf & _
			"hideAguarde();" & VbCrLf & _
			"</scr" & "ipt>" & VbCrLf & _
			"" & VbCrLf & _
			"<br>" & VbCrLf & _
			"<table align='center'>" & VbCrLf & _
			"	<tr><td>Selecione a Foto desejada:</td></tr>" & VbCrLf & _
			"	<tr>" & VbCrLf & _
			"		<td>" & VbCrLf & _
			"			<input id='id_arquivo' type='File' size='65' name='FILE1'>" & VbCrLf & _
			"		</td>" & VbCrLf & _
			"	</tr>" & VbCrLf & _
			"	<tr><td>Título da Imagem:</td></tr>" & VbCrLf & _
			"		<td>" & VbCrLf & _
			"			<input type='text' value='' name='titulo' size='80' maxlength='100'>" & VbCrLf & _
			"		</td>" & VbCrLf & _
			"	</tr>" & VbCrLf & _
			"	<tr><td>Descrição da Imagem:</td></tr>" & VbCrLf & _
			"		<td>" & VbCrLf & _
			"			<textarea name='descricao' cols='80' rows='3'></textarea>" & VbCrLf & _
			"		</td>" & VbCrLf & _
			"	</tr>" & VbCrLf & _
			"	<tr><td>&nbsp;</td></tr>" & VbCrLf & _
			"	<tr><td align='center'><input type='Button' value='Carregar' onclick='javascript:Envia();'></td></tr>" & VbCrLf & _
			"	</table>" & VbCrLf

	'chr_Buf = chr_Buf & chr_Buf2 & "<BR>" & chr_Buf1 & "</form><br>" & VbCrLf

	RW chr_Buf & chr_Buf2 & "<BR>" & chr_Buf1 & "</form></div><br>" & VbCrLf

    Call Tela.MostraRodape()

	Set objFolder = Nothing
End Sub


Sub MensagemErro(chr_Msg)
	Call Tela.ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Cadastrar Fotos", "", "")

	chr_Buf = _
			"<scr" & "ipt type='text/javascript'>" & VbCrLf & _
			"hideAguarde()" & VbCrLf & _
			"</scr" & "ipt>" & VbCrLf & _
			"<table align='center' class='tabela1' border='0' cellpadding='3' cellspacing='0'>" & VbCrLf & _
			"<tr>" & VbCrLf & _
			"	<td align='center' class='texto1'><b><i>" & chr_Msg & "</i></b></td>" & VbCrLf & _
			"</tr>" & VbCrLf & _
			"<tr><td>&nbsp;</td></tr>" & VbCrLf & _
			"<tr>" & VbCrLf & _
			"	<td align='center'><input type='Button' class='texto1' value=' Voltar ' onclick='javascript:history.go(-1);'></td>" & VbCrLf & _
			"</tr>" & VbCrLf & _
			"</table>" & VbCrLf & _
			"<br>" & VbCrLf

	RW chr_Buf

    Call Tela.MostraRodape()
End Sub

%>
