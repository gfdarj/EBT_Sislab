<!--#Include File=Biblio.asp-->
<%

'Erro=request.QueryString ("Erro") ' nr do erro
Pagina=request.QueryString ("Pagina") ' página com erro

Erro="404" ' nr do erro

vUsername = right( Request.ServerVariables("REMOTE_USER"), len( Request.ServerVariables("REMOTE_USER") ) - instrrev( Request.ServerVariables("REMOTE_USER"), "\" ) )
vDescricao = "Pagina não encontrada"

Conecta_Base

sSQL = "INSERT WEB_TratamentoErro (Username, ASPCode, NumeroErro, Pagina, Categoria, "
sSQL = sSQL & "Arquivo, Linha, Coluna, Descricao, ASPDescricao, Origem, Servidor, Site ) "
sSQL = sSQL & "VALUES ('" & vUsername & "', NULL, " & Erro & ", '"
sSQL = sSQL & Pagina & "', 404, '" & Pagina & "', NULL, NULL, NULL, '"
sSQL = sSQL &  vDescricao & "', '404_LogWeb.asp', 'NTSPO901', , '1130010201')"

Objconn.execute sSQL
Desconecta_Conn

%>