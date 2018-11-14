<!--#include file="includes/Sislab_Lib.asp"-->
<!--#include file="includes/PadraoHTML.asp" -->
<!--#include file="includes/global.asp" -->
<!--#include file="includes/bib_str.asp" -->
<!--#include file="Classes/Classe_Arquivo.asp" -->
<%
	Dim objRS
	Dim Arquivo

	Set Arquivo = New TArquivo

	Arquivo.SetOverwrite = False

	Call Arquivo.Init_UP()
	Call Arquivo.Upload()

	'-- processar o formulario
	if (Arquivo.ArquivosCarregados > 0) Then
		Arquivo.Exclui(Arquivo.Campo("arq_ant"))

		If Not Arquivo.TemErro Then
			Arquivo.Salva(Arquivo.Campo("ag_numero"))

			'-- atualizo na base o nome do novo arquivo (obs:nao estou testando se deu erro!)
			Env.oConn.Execute("UPDATE Arquivos SET ARQ_NOMEARQ = '" & Arquivo.ArquivoSubPasta(1) & "' WHERE ARQ_CODARQ = " & Arquivo.Campo("codarq") )

			'Terminar(Arquivo.Arquivo(1))
			Terminar(Arquivo.ArquivoSubPasta(1))
		End If
	else
		Erro( "Houve um problema na recep&ccedil;&atilde;o do arquivo" )
	end if

	Set Arquivo = Nothing

if Err.number <> 0 then
	Response.Redirect "erro.asp?perro=" & Server.URLEncode(Err.number) & "&pdescricao=" & Server.URLEncode(Err.description) 
end if

'-----------------------------------------

function Erro( msg )
	Call Tela.ImprimeCabecalho2("Alteração de Arquivo", MENU_OFF, false, "100%", "Erro na alteração de arquivo !", "NENHUM", "")
%>
<p class="erro" class="texto1b"><%= msg %></p>
<p align="center">
	<button  onclick="javascript:reload();">Tentar&nbsp;Novamente</button>&nbsp;&nbsp;&nbsp;&nbsp;
	<button  onclick="javascript:window.close();">&nbsp;&nbsp;Fechar&nbsp;&nbsp;</button>
</p>
<%	Call Tela.MostraRodape()
end function

function Terminar( nome_arq )
	Call Tela.ImprimeCabecalho2("Alteração de Arquivo", MENU_OFF, false, "100%", "Alteração de Arquivo", "NENHUM", "")
%>
	<script language="JavaScript1.2">
		window.opener.muda_arq("<%=Replace(nome_arq, "\", "\\")%>");
		window.setTimeout( "window.close()", 3000 );
	</script>
	<p align="center">
		<span class="texto1B" style="font-size: 12px;">Arquivo alterado com sucesso!</span><br><br>
		<button onclick="javascript:window.close()" >&nbsp;Fechar&nbsp;</button>
	</p>
<%	Call Tela.MostraRodape()
end function
%>
