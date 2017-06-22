

<%
response.Write "ok"
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

<style type="text/css">
<!-- 
.font5 { color: black; text-decoration: bold; font-size: 9pt; font-family: Arial; }
-->
</style>

<body topmargin=0 leftmargin=0>
<script language=javascript> 
function carga()

{

    var erro = erro();
   	var pagina = pagina();
   	qstring="404.asp?erro='" + erro + "'&pagina='" + pagina + "'";
   	XMLSend= new ActiveXObject("Microsoft.XMLDOM");
   	XMLSend.async = false;
    XMLSend.load(qstring);
}

</script>


<script language=javascript> 

function pagina(){
<!--
// in real bits, urls get returned to our script like this:
// res://shdocvw.dll/http_404.htm#http://www.DocURL.com/bar.htm 

	//For testing use DocURL = "res://shdocvw.dll/http_404.htm#https://www.microsoft.com/bar.htm"
	DocURL = document.URL;
	
	//this is where the http or https will be, as found by searching for :// but skipping the res://
	protocolIndex=DocURL.indexOf("?", 4) + 1;

	//this finds the ending slash for the domain server 
	serverIndex=DocURL.indexOf(";",protocolIndex + 3);

	//for the href, we need a valid URL to the domain. We search for the # symbol to find the begining 
	//of the true URL, and add 1 to skip it - this is the BeginURL value. We use serverIndex as the end marker.
	//urlresult=DocURL.substring(protocolIndex - 4,serverIndex);
	//BeginURL=DocURL.indexOf("#",1) + 1;
	
	//erro=DocURL.substring(protocolIndex, serverIndex);

	pagina=DocURL.substring(serverIndex + 1);
			
	//for display, we need to skip after http://, and go to the next slash
	//displayresult=DocURL.substring(protocolIndex + 3 ,serverIndex);
     //alert (displayresult);	
	//InsertElementAnchor(urlresult, displayresult);
	InsertElementAnchor(pagina);
}

function Erro(){
<!--
// in real bits, urls get returned to our script like this:
// res://shdocvw.dll/http_404.htm#http://www.DocURL.com/bar.htm 

	//For testing use DocURL = "res://shdocvw.dll/http_404.htm#https://www.microsoft.com/bar.htm"
	DocURL = document.URL;
	
	//this is where the http or https will be, as found by searching for :// but skipping the res://
	protocolIndex=DocURL.indexOf("?", 4) + 1;

	//this finds the ending slash for the domain server 
	serverIndex=DocURL.indexOf(";",protocolIndex + 3);

		//for the href, we need a valid URL to the domain. We search for the # symbol to find the begining 
	//of the true URL, and add 1 to skip it - this is the BeginURL value. We use serverIndex as the end marker.
	//urlresult=DocURL.substring(protocolIndex - 4,serverIndex);
	//BeginURL=DocURL.indexOf("#",1) + 1;
	
	erro=DocURL.substring(protocolIndex, serverIndex);

	//pagina=DocURL.substring(serverIndex + 1);
			
	//for display, we need to skip after http://, and go to the next slash
	//displayresult=DocURL.substring(protocolIndex + 3 ,serverIndex);
     //alert (displayresult);	
	//InsertElementAnchor(urlresult, displayresult);
	InsertElementAnchor(erro);
}

function HtmlEncode(text)
{
    return text.replace(/&/g, '&amp').replace(/'/g, '&quot;').replace(/</g, '&lt;').replace(/>/g, '&gt;');
}

function TagAttrib(name, value)
{
    return ' '+name+'="'+HtmlEncode(value)+'"';
}

function PrintTag(inner){
    //document.write( '<' + tagName + attrib + '>' + HtmlEncode(inner) );
    //if (needCloseTag) document.write( '</' + tagName +'>' );
    document.write('<strong>' + inner + '</strong>');
}

function URI(href)
{
    IEVer = window.navigator.appVersion;
    IEVer = IEVer.substr( IEVer.indexOf('MSIE') + 5, 3 );

    return (IEVer.charAt(1)=='.' && IEVer >= '5.5') ?
        encodeURI(href) :
        escape(href).replace(/%3A/g, ':').replace(/%3B/g, ';');
}

function InsertElementAnchor(href)
{
    PrintTag(href);
}

//-->

</script>

<script language=javascript>
function x()
{
var x = erro();

}
</script>

<table class=font5 width=700 align="left" ID="Table1">
	<tr><td align=center>
		<table width="600" class="font5" ID="Table2" align=center cellpadding=6 cellspacing=2 bgcolor=lightblue>
			<tr><td class=font5 bgcolor=White width=599>
				<p align=center>
				<strong>Problemas com a Página Solicitada</strong></p>
				
			
				<p align="justify">
				Não foi possível encontrar a página solicitada no endereço correspondente.<br><br>
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
				<table cellpadding=2 cellspacing=2 width=600 bgcolor=#ffffdd align=center ID="Table30">
					<tr><td class=font5 colspan=2>
						Usuário: 
						<b><%= buscaNome( right( Request.ServerVariables("REMOTE_USER"), len( Request.ServerVariables("REMOTE_USER") ) - instrrev( Request.ServerVariables("REMOTE_USER"), "\" ) ) ) %> 
						<i>(<%= right( Request.ServerVariables("REMOTE_USER"), len( Request.ServerVariables("REMOTE_USER") ) - instrrev( Request.ServerVariables("REMOTE_USER"), "\" ) ) %>)</i>
						</b></td>
					</tr>
					<tr><td class=font5 colspan=2>Descrição:  <b>Página não encontrada</b></td></tr>
					<tr>
					<td class=font5 colspan=2>Página: 
					<script language=javascript>
						<!--
						if (!((window.navigator.userAgent.indexOf("MSIE") > 0) && (window.navigator.appVersion.charAt(0) == "2")))
						{ 
	  						pagina();
						}
						//-->
					</script> 
					</td>
					</tr>
					<tr>
					<td class=font5 colspan=2>Erro : 
					<script language=javascript>
						<!--
						if (!((window.navigator.userAgent.indexOf("MSIE") > 0) && (window.navigator.appVersion.charAt(0) == "2")))
						{ 
	  						Erro();
						}
						//-->
					</script> 
					</td>
					</tr>
					
				</table>
			</td></tr>
		</table>
	</td></tr>
</table>



