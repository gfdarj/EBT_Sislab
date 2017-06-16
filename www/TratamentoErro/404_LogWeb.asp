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
end function 
%>

<html>
	<head>
		<title>Test Page</title>
		<script language="JavaScript" src="404_LogWeb.js"></script>
	</head>
	<body onload="LogPage();">
	
<br><br><br>
	
<table class=font5 width=700 align="center" ID="Table1">
	<tr><td align=center>
	
		<table width="600" class="font5" ID="Table2" align=center cellpadding=6 cellspacing=2 bgcolor=lightblue>
			<tr><td class=font5 bgcolor=White width=599>
				<p align=center>
				<strong>Problemas com a Página Solicitada</strong></p>
				
			   <b>Sr(a) : <%= buscaNome( right( Request.ServerVariables("REMOTE_USER"), len( Request.ServerVariables("REMOTE_USER") ) - instrrev( Request.ServerVariables("REMOTE_USER"), "\" ) ) ) %> 
				<i>(<%= right( Request.ServerVariables("REMOTE_USER"), len( Request.ServerVariables("REMOTE_USER") ) - instrrev( Request.ServerVariables("REMOTE_USER"), "\" ) ) %>)</i>
				</b>
				<p align="justify">
				Não foi possível encontrar a página solicitada no endereço correspondente.<br><br>
				Estamos recolhendo as informações correspondentes aos problemas e encaminhando-as aos
				responsáveis pelo Site para que possam ser regularizadas no menor tempo possível.<br><br>
				Pedimos desculpas pelo transtorno.<br><br>
				Coordenação da Intranet</p>
			    </td>
			    </tr>
		</table>
		
	</td></tr>
	
	<tr><td align=center><hr size=1></td></tr>	
	
</table>



	</body>
</html>
