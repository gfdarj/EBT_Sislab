<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/funcoes.asp" -->
<!--#include file="includes/EmailHTML.asp" -->
<!--#include file="includes/bib_str.asp" -->
<!--#include file="Classes/Classe_Upload.asp" -->
<%
' On Error Resume Next

If not Env.usuarioCRT Then
	response.redirect "msgAcessoNA.asp"
End if

Response.Charset = Application("SISLAB_CHARSET")


Dim objSiteRS, sSQL
Dim auxnomearq,auxcodarquivo,auxorgao, auxagendamento
Dim auxtipocomando, auxusername, auxresponsavel
Dim Count,auxip,auxtitulo,auxdatahoraatualiza
Dim auxSitArquivo,auxversao,i
Dim auxtipoarquivo,auxobservacao,auxdescricao
Dim auxconfidencial, File, auxlistaAgendamento, eh_validacao
Dim o1, o2, o3

Dim Form : Set Form = New ASPForm

Server.ScriptTimeout = 1440 ' Limite de 24 minutos de execução de código, o upload deve acontecer dentro deste tempo ou então ocorre erro de limite de tempo.

Const MaxFileSize = 25200000 ' Limite de 25,2 Mb de arquivo

If Form.State = 0 Then

    auxtipocomando = Form.Item("tipocomando")
    if Form.Item("cmbAgendamento") = "1" then
	    auxagendamento = Form.Item("lstagendamento")
    else
	    auxagendamento = "0"
    end if

    auxcodarquivo = Form.Item("codarquivo")
    if IsNumeric(auxcodarquivo) then auxcodarquivo = CInt(auxcodarquivo) else auxcodarquivo = 0
    auxtitulo = Form.Item("titulo")
    auxip = UCase(request.ServerVariables("REMOTE_ADDR"))
    auxsitArquivo = Form.Item("situacao")
    auxtipoArquivo = Form.Item("tipoarquivo")
    auxversao = Form.Item("versao")
    auxobservacao = Form.Item("observacao")
    auxdescricao = Form.Item("descricao")
    auxdatahoraatualiza = Form.Item("txtatualiza")
    auxAS = Form.Item("agendamento")
    auxOS = Form.Item("cmbOs")
    vincula = Form.Item("cmbAgendamento")
    auxresponsavel = Form.Item("responsavel")

    eh_validacao = CBool(Form.Item("eh_validacao"))

    If eh_validacao Then
	    auxusername = Form.Item("validador")
    Else
	    auxusername = Form.Item("username")
    End If

    auxdatahoraatualiza = Form.Item("diaatualiz") & "/" & Form.Item("mesatualiz") & "/" & Form.Item("anoatualiz")
    DataValidacao =  Form.Item("diaValidacao") & "/" & Form.Item("mesValidacao") & "/" & Form.Item("AnoValidacao")

    'expira = ehDocumentoComExpiracao(auxtipoArquivo,objConn)


Else
    Call Tela.ImprimeCabecalho2(TITULO_SITE, MENU_ON, true, "", "Cadastro de Arquivos - Erro de Upload", "", "")
    RW "<br />"
    RW "<div class='margem-10'>"
    RW "    <p class='texto-vermelho-bold'>Ocorreu um erro ao criar o objeto de Upload.</p>"
    RW "</div>"
    Call Tela.MostraRodape()
End If



'rw "<BR>lstagendamento: " & Form.Item("lstagendamento")
'rw "<BR>cmbAgendamento: " & Form.Item("cmbAgendamento")
'rw "<BR>ArquivosCarregados: " & Arquivo.ArquivosCarregados
'rw "<BR>" & Form.Item("codarquivo")
'rw "<BR>" & Form.Item("titulo")
'rw "<BR>" & Form.Item("REMOTE_ADDR")
'rw "<BR>" & Form.Item("situacao")
'rw "<BR>" & Form.Item("tipoarquivo")
'rw "<BR>" & Form.Item("versao")
'rw "<BR>" & Form.Item("observacao")
'rw "<BR>" & Form.Item("descricao")
'rw "<BR>" & Form.Item("txtatualiza")
'rw "<BR>" & Form.Item("agendamento")
'rw "<BR>" & Form.Item("cmbOs")
'rw "<BR>" & Form.Item("cmbAgendamento")
'rw "<BR>" & Form.Item("responsavel")
'rw "<BR>" & Form.Item("eh_validacao")
're

'-- Endereço nos servidor  onde ira cair o arquivo
''Count = Upload.Save("d:\inetpub\wwwroot\Sislab1\arquivos")
'Count = Upload.Save( Server.MapPath(".") & "\Arquivos" )


if Form.Item("chkconfidencial") <> "1" then
  auxconfidencial = 0
else
  auxconfidencial = -1
end if
o1 = Form.Item("o1")
if o1 = "" then o1 = "null"
o2 = Form.Item("o2")
if o2 = "" then o2 = "null"
o3 = Form.Item("o3")
if o3 = "" then o3 = "null"

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
if auxcodarquivo > 0 then
	auxnomearq = Form.Item("nome")
else
	'auxnomearq = Upload.Files(1).ExtractFileName
	auxnomearq = Arquivo.ArquivoSubPasta(1)
end if

'RW "<BR><b>auxnomearq:</b> " & auxnomearq
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

	if Form.Item("resp") = "1" then
		msg = "Foi executada a seguinte ação ( " & auxtipocomando & " ) sobre o documento " & auxtitulo & "<br><BR>" & _
			  "<u>Dados do Documento</u>" & "<BR><br>" & _ 
			  "Revisão : " & auxversao & "<br>" & _
  			  "Responsável : " & auxresponsavel & "<br>" & _
  			  "Descrição : " & auxdescricao & "<br>" & _
			  "Arquivo: " & auxnomearq
		assunto = "Sislab - Upload de Arquivos"
		Call enviaEmailUserCRT(Env.oConn,assunto,msg)
		Call enviar_email("gilberto.rj@ig.com.br", "Gilberto", assunto, msg)
	end if
%>
	<html>
	<head>
	<title>CRT - Cadastro de Arquivos</title>
	<meta http-equiv="refresh" content="4; url=<%if eh_validacao then response.write "arq_disp.asp" else response.write "sel_cad_arquivo.asp"%>">
	</head>
	<body>

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
Call Tela.MostraRodape()
%>
