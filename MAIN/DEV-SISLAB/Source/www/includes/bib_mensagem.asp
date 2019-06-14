<%
'--------------------------------------------------------------------------------------------
'-- ARQUIVO DE ROTINAS DE MENSAGENS PADRAO - SISTEMA SISLAB
'-- coppetec
'-- 
'-- Obs: Para rodar é necessário estar incluido no ASP o arquivo contendo a rotina
'-- de cabeçalho/rodapé padrao
'--------------------------------------------------------------------------------------------


'--------------------------------------------------------------------------------------------
'-- exibe tela de erro com uma mensagem HTML passada por parametro
'--------------------------------------------------------------------------------------------
function ErroHtml(menu, rodape, chr_mensagem, linkVoltar, path)

	If linkVoltar = "" Then linkVoltar = "javascript:history.go(-1);"

	Call Tela.ImprimeCabecalho2(TITULO_SITE, menu, true, "", "Erro nao Gravação de Dados", "SO_IMPRESSORA", path)

	response.write "<br><p>"

	response.write "&nbsp;<span class='texto-vermelho-bold'>&raquo;</span>&nbsp;<span style='font-size: 12px;'>Descrição do(s) erro(s) encontrado(s)</span><br><br>"

	response.write "&nbsp;&nbsp;<b>Descrição:</b> " & chr_mensagem & "<br><br>"

	response.write "</p>"
	response.write "<p>&nbsp;&nbsp;<a href='" & linkVoltar & "'>Voltar</a></p>"

    Call Tela.MostraRodape()
End Function


Function MsgGravacaoDados(menu, rodape, msgHtml, linkvoltar, path)
	Call Tela.ImprimeCabecalho2(TITULO_SITE, menu, true, "", "Gravação de Dados", "SO_IMPRESSORA", path)
	response.write "<table border='0' width='100%' cellpadding='0' cellspacing='3'><tr><td>" & msgHtml & "</td></tr></table>"
	response.write "<br><p>&nbsp;&nbsp;<a href='" & linkVoltar & "'>Voltar</a></p>"
    Call Tela.MostraRodape()
End Function


'--------------------------------------------------------------------------------------------
'-- Imprime mensagem de erro em alguma transacao com o banco de dados
'-- Parametro: recebe o objeto Conection.Errors
'--------------------------------------------------------------------------------------------
function erroDB(menu, rodape, apenasErroSistema, Erro, linkVoltar, path)
	Dim objErro
	Call Tela.ImprimeCabecalho2(TITULO_SITE, menu, true, "", "Erro nao Gravação de Dados", "SO_IMPRESSORA", path)
	response.write "<br><p class='texto1'>"

	response.write "&nbsp;<span class='vermelho2'>&raquo;</span>&nbsp;<span style='font-size: 12px;'>Descrição do(s) erro(s) encontrado(s)</span><br><br>"

	For Each objErro In Erro
		'if (apenasErroSistema and objErro.NativeError = 50000) or (not apenasErroSistema) then
			'response.write "&nbsp;&nbsp;Nº Erro: " & objErro.Number & "<br>"
			response.write "&nbsp;&nbsp;<b>Descrição:</b> " & objErro.Description & "<br><br>"
			'response.write "&nbsp;&nbsp;Erro nativo: " & objErro.NativeError & "<br>"
			'response.write "&nbsp;&nbsp;Estado SQL: " & objErro.SQLState & "<br>"
			'response.write "&nbsp;&nbsp;Reportado por: " & objErro.Source & "<br>"
			'response.write "&nbsp;&nbsp;Arquivo de Help: " & objErro.HelpFile & "<br>"
			'response.write "&nbsp;&nbsp;ID de ajuda do contexto: " & objErro.HelpContext & "<br><br>"
		'end if
	Next
	response.write "</p>"
	response.write "<p class='texto1'>&nbsp;&nbsp;<a href='" & linkVoltar & "'>Voltar</a></p>"
	Call Tela.MostraRodape()
end function
%>
