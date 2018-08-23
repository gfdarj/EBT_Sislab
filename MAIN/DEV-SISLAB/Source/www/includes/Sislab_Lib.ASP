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

Application("SISLAB_CHARSET") = "iso-8859-1"
'Application("SISLAB_CHARSET") = "utf-8"
'Application("SISLAB_CHARSET") = "WINDOWS-1252"

Application("SISLAB_ID_APLICACAO_SISLAB")	= 1
Application("SISLAB_ID_APLICACAO_SCE") 	= 2

Application("SISLAB_AMBIENTE") = "LOC"

If Application("SISLAB_AMBIENTE") = "DES" Then '-- Desenvolvimento

	Application("SISLAB_SERVER") = "W7RJO069255"
	Application("SISLAB_PROTOCS") = "http://"
	Application("SISLAB_SiteFolder") = "W7RJO069255/sislab"
	Application("SISLAB_InitialCatalog") = "sislab"
	Application("SISLAB_DataSource") = "NTSPO930"
	Application("SISLAB_DataUser") = "sislab_dsv"
	Application("SISLAB_DataUserPwd") = "Embratel@21"

	Application("SISLAB_id_TipoArquivo_Imagem") = 31

	'Application("SISLAB_ServidorLocalCRT") = "http://localhost/sislab1_arquivoslocais/"
	Application("SISLAB_ServidorLocalCRT") = "Arquivos/"

ElseIf Application("SISLAB_AMBIENTE") = "PRO" Then '-- Producao

	Application("SISLAB_SERVER") = "ntspo901"
	Application("SISLAB_PROTOCS") = "http://"
	Application("SISLAB_SiteFolder") = ""
	Application("SISLAB_InitialCatalog") = "SISLAB"
	Application("SISLAB_DataSource") = "ntspo006"
	Application("SISLAB_DataUser") = "sislab1"
	Application("SISLAB_DataUserPwd") = "sislab1001"

	Application("SISLAB_id_TipoArquivo_Imagem") = 31

	'Application("SISLAB_ServidorLocalCRT") = "http://localhost/sislab1_arquivoslocais/"
	Application("SISLAB_ServidorLocalCRT") = "Arquivos/"

ElseIf Application("SISLAB_AMBIENTE") = "LOC" Then	'--Local

	Application("SISLAB_SERVER") = "localhost"
	Application("SISLAB_PROTOCS") = "http://"
	Application("SISLAB_SiteFolder") = ""
	Application("SISLAB_InitialCatalog") = "sislab"
	Application("SISLAB_DataSource") = "051843W\SQLEXPRESS"
	Application("SISLAB_DataUser") = "sa"
	Application("SISLAB_DataUserPwd") = "adm123"

	Application("SISLAB_id_TipoArquivo_Imagem") = 31

	'Application("SISLAB_ServidorLocalCRT") = "http://localhost/sislab1_arquivoslocais/"
	Application("SISLAB_ServidorLocalCRT") = "Arquivos/"

End If

Application("SISLAB_Tempo_Troca_Imagens") = 10

Application("SISLAB_FolderArquivos") = "\Arquivos"
Application("SISLAB_FolderArquivosLB") = "\ArquivosLB"

'Application("SISLAB_DEBUG") = "SIM"		'-- SIM / NAO
Application("SISLAB_DEBUG") = "NAO"		'-- SIM / NAO

%>
