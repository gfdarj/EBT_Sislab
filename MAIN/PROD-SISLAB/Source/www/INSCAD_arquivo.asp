<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/funcoes.asp" -->
<!--#include file="includes/EmailHTML.asp" -->
<!--#include file="includes/bib_str.asp" -->
<!--#include file="Lib/Classe_Arquivo.asp" -->
<%
' On Error Resume Next

' Se Sessão expirou enviar para novo logon

If not Env.usuarioCRT Then
	response.redirect "msgAcessoNA.asp"
End if

Server.ScriptTimeout = 100000

Dim objSiteRS, sSQL
Dim auxnomearq,auxcodarquivo,auxorgao, auxagendamento
Dim auxtipocomando, auxusername, auxresponsavel
'Dim Upload
Dim Count,auxip,auxtitulo,auxdatahoraatualiza
Dim auxSitArquivo,auxversao,i
Dim auxtipoarquivo,auxobservacao,auxdescricao
Dim auxconfidencial, File, auxlistaAgendamento, eh_validacao
Dim o1, o2, o3
Dim Arquivo

Set Arquivo = New TArquivo

Arquivo.SetOverwrite = False

Call Arquivo.Init_UP()
If Arquivo.TemErro Then
    Call ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Cadastro de Arquivos - Erro de Upload", "", "")
    RW "<BR>"
    RW "<p class='texto'><font color='red'><B>Ocorreu um erro ao criar o objeto de Upload.</B></font></p>"
    RW "<p class='texto'><font color='red'><B>Mensagem: " & Arquivo.MensagemErro() & "</B></font></p>"
    RE
End If
Call Arquivo.Upload()
If Arquivo.TemErro Then
    Call ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Cadastro de Arquivos - Erro de Upload", "", "")
    RW "<BR>"
    RW "<p class='texto'><font color='red'><B>Ocorreu um erro ao tentar salvar o arquivo.</B></font></p>"
    RW "<p class='texto'><font color='red'><B>Mensagem: " & Arquivo.MensagemErro() & "</B></font></p>"
    RE
End If

'rw "<BR>lstagendamento: " & Arquivo.Campo("lstagendamento")
'rw "<BR>cmbAgendamento: " & Arquivo.Campo("cmbAgendamento")
'rw "<BR>ArquivosCarregados: " & Arquivo.ArquivosCarregados
'rw "<BR>" & Arquivo.Campo("codarquivo")
'rw "<BR>" & Arquivo.Campo("titulo")
'rw "<BR>" & Arquivo.Campo("REMOTE_ADDR")
'rw "<BR>" & Arquivo.Campo("situacao")
'rw "<BR>" & Arquivo.Campo("tipoarquivo")
'rw "<BR>" & Arquivo.Campo("versao")
'rw "<BR>" & Arquivo.Campo("observacao")
'rw "<BR>" & Arquivo.Campo("descricao")
'rw "<BR>" & Arquivo.Campo("txtatualiza")
'rw "<BR>" & Arquivo.Campo("agendamento")
'rw "<BR>" & Arquivo.Campo("cmbOs")
'rw "<BR>" & Arquivo.Campo("cmbAgendamento")
'rw "<BR>" & Arquivo.Campo("responsavel")
'rw "<BR>" & Arquivo.Campo("eh_validacao")
're

'-- Endereço nos servidor  onde ira cair o arquivo
''Count = Upload.Save("d:\inetpub\wwwroot\Sislab1\arquivos")
'Count = Upload.Save( Server.MapPath(".") & "\Arquivos" )

auxtipocomando = Arquivo.Campo("tipocomando")
if Arquivo.Campo("cmbAgendamento") = "1" then
	auxagendamento = Arquivo.Campo("lstagendamento")
else
	auxagendamento = "0"
end if

auxcodarquivo = Arquivo.Campo("codarquivo")
if IsNumeric(auxcodarquivo) then auxcodarquivo = CInt(auxcodarquivo) else auxcodarquivo = 0
auxtitulo = Arquivo.Campo("titulo")
auxip = UCase(request.ServerVariables("REMOTE_ADDR"))
auxsitArquivo = Arquivo.Campo("situacao")
auxtipoArquivo = Arquivo.Campo("tipoarquivo")
auxversao = Arquivo.Campo("versao")
auxobservacao = Arquivo.Campo("observacao")
auxdescricao = Arquivo.Campo("descricao")
auxdatahoraatualiza = Arquivo.Campo("txtatualiza")
auxAS = Arquivo.Campo("agendamento")
auxOS = Arquivo.Campo("cmbOs")
vincula = Arquivo.Campo("cmbAgendamento")
auxresponsavel = Arquivo.Campo("responsavel")

eh_validacao = CBool(Arquivo.Campo("eh_validacao"))

If eh_validacao Then
	auxusername = Arquivo.Campo("validador")
Else
	auxusername = Arquivo.Campo("username")
End If

auxdatahoraatualiza = Arquivo.Campo("diaatualiz") & "/" & Arquivo.Campo("mesatualiz") & "/" & Arquivo.Campo("anoatualiz")
DataValidacao =  Arquivo.Campo("diaValidacao") & "/" & Arquivo.Campo("mesValidacao") & "/" & Arquivo.Campo("AnoValidacao")

'expira = ehDocumentoComExpiracao(auxtipoArquivo,objConn)

if Arquivo.Campo("chkconfidencial") <> "1" then
  auxconfidencial = 0
else
  auxconfidencial = -1
end if
o1 = Arquivo.Campo("o1")
if o1 = "" then o1 = "null"
o2 = Arquivo.Campo("o2")
if o2 = "" then o2 = "null"
o3 = Arquivo.Campo("o3")
if o3 = "" then o3 = "null"

' Se for arquivo de VÍDEO então gravo na pasta correspondente
If CStr(auxtipoArquivo) = CStr(Application("SISLAB_ID_CODARQTIPO_VIDEOS")) Then
    Arquivo.SetNomePasta = "Videos"
End If

'	SALVA O ARQUIVO NO DISCO
Call Arquivo.Salva(auxAS)

if auxAs = "" then auxAs = null

sSQL = "Select orga_ID from usercrt where UserId='" & auxusername & "'; "

call Env.RecordSet( true, objSiteRS1, sSQL)

auxorgao = objSiteRS1("Orga_ID")

'response.write auxcodarquivo & " .... " & isnull(auxcodarquivo) & " ... " & Upload.Form("nome") & "<BR>"
'response.write isnumeric(auxcodarquivo) & " .... " & auxcodarquivo <> "" 
'response.end

'-- se ja existir o arquivo apenas pego o nome do arquivo
if CStr(auxcodarquivo) > "0" then
	auxnomearq = Arquivo.Campo("nome")
else
	'auxnomearq = Upload.Files(1).ExtractFileName
	auxnomearq = Arquivo.ArquivoSubPasta(1)
end if

If VVVNZ(Arquivo.Arquivo(0)) And CStr(auxtipoarquivo) = CStr(Application("SISLAB_ID_CODARQTIPO_VIDEOS")) Then
    auxnomearq = "Videos\" & auxnomearq
End If

'RW "<BR><b>auxcodarquivo:</b> " & auxcodarquivo
'RW "<BR><b>auxnomearq:</b> " & auxnomearq
'RW "<BR><b>Arquivo.ArquivoSubPasta(0):</b> " & Arquivo.Arquivo(0)
'RW "<BR><b>Arquivo.ArquivoSubPasta(1):</b> " & Arquivo.Arquivo(1)
'RW "<BR><b>GetPastaRaiz:</b> " & Arquivo.GetPastaRaiz
'RE
'----------------------------------------------------------------------------------------

ssql = "exec SP_CADASTRA_ARQUIVOS " & _
		"'" & ucase(auxtipocomando) & "'," & auxAs & ",'" & DataValidacao & "'," & auxcodarquivo & "," & _
		auxtipoarquivo & ",'" & auxtitulo & "','" & auxnomearq & "','" & auxresponsavel & "','" & auxorgao & "','" & _
		auxobservacao & "','" & auxversao & "'," & auxconfidencial & ",'" & auxdatahoraatualiza & "','" & auxip & "','" & _
		auxusername & "','" & auxdescricao & "'," & auxsitarquivo & "," & IIf(VVVNZ(auxOS), "null", auxOS) & "," & o1 & "," & o2 & "," & o3
ssql = replace(ssql,",,",",null,")
ssql = replace(ssql,"''","null")
ssql = replace(ssql,"'//'","null")

'response.write ssql
'response.end

Dim RETORNO
Set rs = Env.oConn.execute(ssql)
RETORNO =  rs("saida")

If RETORNO <> "-1" then

	'-- tenho que apagar o arquivo caso o mesmo tenha sido excluído
	if ucase(auxtipocomando) = "EXCLUIR" then
		Arquivo.Exclui(auxnomearq)
	end if

	if Arquivo.Campo("resp") = "1" then
		msg = "Foi executada a seguinte ação ( " & auxtipocomando & " ) sobre o documento " & auxtitulo & "<br><BR>" & _
			  "<u>Dados do Documento</u>" & "<BR><br>" & _ 
			  "Revisão : " & auxversao & "<br>" & _
  			  "Responsável : " & auxresponsavel & "<br>" & _
  			  "Descrição : " & auxdescricao & "<br>" & _
			  "Arquivo: " & auxnomearq
		assunto = "Sislab - Upload de Arquivos"
		Call enviaEmailUserCRT(Env.oConn,assunto,msg)
	end if
%>
	<html>
	<head>
	<title>CRT - Cadastro de Arquivos</title>
	<meta http-equiv="refresh" content="4; url=<%if eh_validacao then response.write "arq_disp.asp" else response.write "sel_cad_arquivo.asp"%>">
	</head>
	<body bgcolor="#FFFFFF">

	<div align="center">
	  <table width="90%" bgcolor="#88BBBB">
    	<tr> 
	      <td width="10%" height="0"></td>
    	  <td width="10%" height="0"></td>
	      <td width="10%" height="0"></td>
    	  <td width="10%" height="0"></td>
	      <td width="10%" height="0"></td>
    	  <td width="10%" height="0"></td>
	      <td width="10%" height="0"></td>
    	  <td width="10%" height="0"></td>
	      <td width="10%" height="0"></td>
    	  <td width="10%" height="0"></td>
	    </tr>
    	<tr valign="middle" bgcolor="#88BBBB" border="1"> 
	      <td colspan="10" align="center">Operação Executada com Sucesso</td>
    	</tr>
	    <tr valign="middle" bgcolor="#AADDDD"> 
    	  <td colspan="10">&nbsp;&nbsp;&nbsp;Comando SQL Digitado</td>
	    </tr	>
	    <tr valign="middle"> 
    		  <td colspan="10" bgcolor="#FFFFFF"  height="180"> 
	        <div align="center">&nbsp; 
<%=sSQL%>
        </div>
      </td>
    </tr>
  </table>
<%else%>
<center>
<table border="0" bgcolor="#FFFFFF" width="80%">
<tr>
<td>
<div align="left">
  <font style="font-size=10pt;" color="#000000"> 
<b>&nbsp;&nbsp;Erro Nº:</b> <%=Err.Number%><br>
<b>&nbsp;&nbsp;Descrição:</b> <%=Err.Description%><br>
<% end if %>
</div>
</td>
</tr>
</table>
</center>
<%
Call imprimeRodape(RODAPE_OFF)
%>
