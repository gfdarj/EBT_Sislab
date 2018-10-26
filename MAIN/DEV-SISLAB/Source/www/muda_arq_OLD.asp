<!--#include file="includes/Sislab_Lib.asp"-->
<!-- #include file="includes/PadraoHTML.asp" -->
<!-- #include file="includes/global.asp" -->
<%
dim objUL, num, path

set objUL = server.createobject( "Persits.Upload.1" )
objUL.IgnoreNoPost = true
objUL.OverwriteFiles = true
'num = objUL.Save( "d:\inetpub\wwwroot\Sislab1\arquivos" )
path = Server.MapPath(".") & "\arquivos"
num = objUL.Save(path)

'-- exibir o formulario
if( objUL.form( "proc" ) = "" ) then
%>
<%	call ImprimeCabecalho2("Alteração de Arquivo", MENU_OFF, false, "100%", "Alteração de Arquivo", "NENHUM", "")%>
	<form method="post" action="" name="formulario" enctype="multipart/form-data">
	<input type="hidden" name="proc" value="É hora de processar!">
	<input type="hidden" name="codarq" value="<%=request("codarq")%>">
	<input type="hidden" name="arq_ant" value="<%=request("ant")%>">
	<table class="table-bordered" align="center">
	<tr>
		<td><b>Arquivo Antigo:</b></td>
		<td><%=request( "ant" ) %></td>
	</tr>
	<tr>
		<td><b>Novo Arquivo:</b></td>
		<td>
			<input type="File" name="arq" size="30" class="texto1">
		</td>
	</tr>
	<tr>
		<td colspan="2" align="center"><button class="texto1" onclick="javascript:if( formulario.arq.value != '' ) formulario.submit(); else alert( 'Por favor, escolha um arquivo' );">&nbsp;OK&nbsp;</button>&nbsp;&nbsp;&nbsp;&nbsp;<button onclick="javascript:window.close();" class="texto1">Cancelar</button></td>
	</tr>
	</table>
	</form>
<%	call ImprimeRodape(RODAPE_OFF)
else
	Dim objRS

	'-- processar o formulario
	if( num = 1 ) then
		if( objUL.form( "arq_ant" ) <> objUL.Files( 1 ).ExtractFileName() and objUL.FileExists( path & "\" & objUL.form( "arq_ant" ) ) ) then
			'-- apago o arquivo antigo, caso seja diferente
			if( objUL.FileExists( path & "\" & objUL.form( "arq_ant" ) ) ) then
				objUL.DeleteFile( path & "\" & objUL.form( "arq_ant" ) )
			end if

			'-- atualizo na base o nome do novo arquivo (obs:nao estou testando se deu erro!)
			Env.oConn.Execute("UPDATE Arquivos SET ARQ_NOMEARQ = '" & objUL.Files( 1 ).ExtractFileName() & "' WHERE ARQ_CODARQ = " & objUL.form("codarq") )

			Terminar( objUL.Files( 1 ).ExtractFileName() )
		else
			Terminar( objUL.Files( 1 ).ExtractFileName() )
		end if
	else
		Erro( "Houve um problema na recep&ccedil;&atilde;o do arquivo" )
	end if
end if

set objUL = nothing

if Err.number <> 0 then
	Response.Redirect "erro.asp?perro=" & Server.URLEncode(Err.number) & "&pdescricao=" & Server.URLEncode(Err.description) 
end if

'-----------------------------------------

function Erro( msg )
	call ImprimeCabecalho2("Alteração de Arquivo", MENU_OFF, false, "100%", "Erro na alteração de arquivo !", "NENHUM", "")
%>
<p class="erro" class="texto1b"><%= msg %></p>
<p align="center">
	<button class="texto1" onclick="javascript:reload();">Tentar&nbsp;Novamente</button>&nbsp;&nbsp;&nbsp;&nbsp;
	<button class="texto1" onclick="javascript:window.close();">&nbsp;&nbsp;Fechar&nbsp;&nbsp;</button>
</p>
<%	call ImprimeRodape(RODAPE_OFF)
end function

function Terminar( nome_arq )
	call ImprimeCabecalho2("Alteração de Arquivo", MENU_OFF, false, "100%", "Alteração de Arquivo", "NENHUM", "")
%>
	<script language="JavaScript1.2">
		window.opener.muda_arq( "<%= nome_arq %>" );
		window.setTimeout( "window.close()", 3000 );
	</script>
	<p align="center">
		<span class="texto1B" style="font-size: 12px;">Arquivo alterado com sucesso!</span><br><br>
		<button onclick="javascript:window.close()" class="texto1">&nbsp;Fechar&nbsp;</button>
	</p>
<%	call ImprimeRodape(RODAPE_OFF)
end function
%>