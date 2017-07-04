<style type="text/css">
<!-- 
.font5 { color: black; text-decoration: bold; font-size: 9pt; font-family: Arial; }
-->
</style>
<!--#Include file=Biblio.asp-->

<%

function buscaNome( login )
	dim objMat, objDados, Dados
	if( not isNull( login ) ) then
		if( login <> "" ) then
			set objMat = Server.CreateObject( "WebEmbratel.ClsUsername" )
			set objDados = Server.CreateObject( "WebEmbratel.ClsCadastro" )
			set Dados = objDados.GetDados( objMat.getMatricula( login ) )
			if( Dados is nothing ) then
				buscaNome = ""
			else
				buscaNome = trim( Dados( "Nome_Reduzido" ) )
			end if
			set Dados = nothing
			set objDados = nothing
			set objMat = nothing
		else
			buscaNome = ""
		end if
	else
		buscaNome = ""
	end if
end function %>

<script language="JavaScript1.2">
	function verifica()
	{
		if( document.bug.desc.value.length > 1022 && !confirm( "O campo descrição é excessivamente longo e será cortado. Deseja continuar?" ) )
			return;
		else
			document.bug.submit();
	}
</script>

<%
if( request.querystring( "manual" ) <> "1" ) then
	dim objErro
	set objErro = server.getLastError() 
end if
%>

<table class=font5 width=700 align="left" ID="Table1">
	<tr><td align=center>
		<table width="600" class="font5" ID="Table2" align=center cellpadding=6 cellspacing=2 bgcolor=lightblue>
			<tr><td class=font5 bgcolor=White width=599>
				<p align=center>
				<strong>Problemas com a Página Solicitada</strong></p>
				
			
				<p align="justify">
				A página solicitada está com problemas técnicos que estão impedindo sua exibição normal.<br><br>
				Estamos recolhendo as informações correspondentes aos problemas e encaminhando-as aos
				responsáveis pelo Site para que possam ser regularizadas no menor tempo possível.<br><br>
				Pedimos desculpas pelo transtorno.<br><br>
				Coordenação da Intranet</p>
			</td></tr>
		</table>
	</td></tr>
	
	<tr><td align=center><hr size=1></td></tr>	
	
	<tr><td align=center>
		<table class=font5 align="center" ID="Table19" width="600" cellpadding=2 cellspacing=2 >
			<tr><td class=font5>
				<p align=center>
				<strong>Informações complementares sobre o problema</strong></p>
			</td></tr>
			<tr><td  class=font5 align=left>
				<table cellpadding=2 cellspacing=2 width=600 bgcolor=#ffffdd align=center>
					<tr><td class=font5 colspan=2>
						Usuário: 
						<b><%= buscaNome( right( Request.ServerVariables("REMOTE_USER"), len( Request.ServerVariables("REMOTE_USER") ) - instrrev( Request.ServerVariables("REMOTE_USER"), "\" ) ) ) %> 
						<i>(<%= right( Request.ServerVariables("REMOTE_USER"), len( Request.ServerVariables("REMOTE_USER") ) - instrrev( Request.ServerVariables("REMOTE_USER"), "\" ) ) %>)</i>
						</b></td>
					</tr>
					<tr><td class=font5>ASP Code: <b><%= objErro.ASPCode %></b></td>
					<td class=font5>Número Erro: <b><%= objErro.Number %></b></td>
					</tr>
					<tr><td class=font5>Página: <b><%= objErro.Source %></b></td>
					<td class=font5>Categoria: <b><%= objErro.Category %></b></td>
					</tr>
					<tr><td class=font5>Arquivo: <b><%= objErro.File %></b></td>
					<td class=font5>Linha / Coluna: <b><%= objErro.Line %> / <%= objErro.Column %></b></td>
					</tr>
					<tr><td class=font5 colspan=2>Descrição:  <b><%= objErro.Description %></b></td></tr>
					<tr><td class=font5 colspan=2>ASP Descrição: <b><%= objErro.ASPDescription %></b></td></tr>
				</table>
			</td></tr>
		</table>
	</td></tr>
</table><%
vUsername = right( Request.ServerVariables("REMOTE_USER"), len( Request.ServerVariables("REMOTE_USER") ) - instrrev( Request.ServerVariables("REMOTE_USER"), "\" ) )
vDescricao = replace(objErro.Description,"'","-")
vASPDescricao = replace(objErro.ASPDescription,"'","-")
Conecta_Base
sSQL = "INSERT WEB_TratamentoErro (Username, ASPCode, NumeroErro, Pagina, Categoria, "
sSQL = sSQL & "Arquivo, Linha, Coluna, Descricao, ASPDescricao, origem, Servidor, Site ) "
sSQL = sSQL & "VALUES ( '" & vUsername & "', '" & objErro.ASPCode & "', " & objErro.Number & ", "
sSQL = sSQL & " '" & objErro.Source & "', '" & objErro.Category & "', '" & objErro.File & "', " & objErro.Line & ", "
sSQL = sSQL & objErro.Column & ", '" & vDescricao & "', '" & vASPDescricao & "', 'ProcErro.asp', 'NTSPO901', '1130010201') "


Objconn.execute sSQL
Desconecta_Conn

%>
