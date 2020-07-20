<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/bib_str.asp" -->
<!--#include file="Classes/Classe_Upload.asp" -->
<%
Response.Charset = Application("SISLAB_CHARSET")

Dim objRS
Dim subPasta, pastaArquivos

Dim Form : Set Form = New ASPForm

Server.ScriptTimeout = 1440 ' Limite de 24 minutos de execução de código, o upload deve acontecer dentro deste tempo ou então ocorre erro de limite de tempo.

pastaArquivos = Server.MapPath(".") & "\" & Application("SISLAB_FolderArquivos") & "\"

Const MaxFileSize = 25200000 ' Limite de 25,2 Mb de arquivo

If Form.State = 0 Then
    subPasta = Form.SubPastaAS(Form.Item("ag_numero"))
    If subPasta <> "" Then subPasta = subPasta & "\" 

    'Faz o upload dos arquivos
    For each Field in Form.Files.Items

        On Error Resume Next
	    Call Form.DeleteFile(pastaArquivos & Form.Item("arq_ant"))
        On Error Goto 0

        ' # Field.Filename : Nome do Arquivo que chegou.
        ' # Field.ByteArray : Dados binários do arquivo, útil para subir em blobstore (MySQL).
        Field.SaveAs pastaArquivos & subPasta & Field.FileName


		'-- atualizo na base o nome do novo arquivo (obs:nao estou testando se deu erro!)
		Env.oConn.Execute("UPDATE Arquivos SET ARQ_NOMEARQ = '" & subPasta & Field.FileName & "' WHERE ARQ_CODARQ = " & Form.Item("codarq"))

		Terminar(subPasta & Field.FileName)
	Next
Else
	Erro( "Houve um problema na recep&ccedil;&atilde;o do arquivo" )
End If

Set Form = Nothing

Response.End

'-----------------------------------------

Function Erro( msg )
	Call Tela.ImprimeCabecalho2("Alteração de Arquivo", MENU_OFF, false, "100%", "Erro na alteração de arquivo !", "NENHUM", "")
%>
<div class="margem-10">
    <p style="font-weight: bold;"><%= msg %></p>
    <p style="text-align:center;">
	    <input type="button" class="btn btn-primary" onclick="javascript:reload();" value="Tentar&nbsp;Novamente" />&nbsp;&nbsp;&nbsp;&nbsp;
	    <input type="button" class="btn btn-primary" onclick="javascript:window.close();" value="&nbsp;&nbsp;Fechar&nbsp;&nbsp;" />
    </p>
</div>
<%	Call Tela.MostraRodape()
End Function

function Terminar( nome_arq )
	Call Tela.ImprimeCabecalho2("Alteração de Arquivo", MENU_OFF, false, "100%", "Alteração de Arquivo", "NENHUM", "")
%>
<div class="margem-10">
	<script type="text/javascript">
		window.opener.muda_arq("<%=Replace(nome_arq, "\", "\\")%>");
		window.setTimeout( "window.close()", 3000 );
	</script>
	<p>
		<span style="font-size: 12px;">Arquivo alterado com sucesso!</span><br><br>
		<input type="button" class="btn btn-primary" onclick="javascript:window.close()" value="&nbsp;Fechar&nbsp;" />
	</p>
</div>
<%	Call Tela.MostraRodape()
end function
%>
