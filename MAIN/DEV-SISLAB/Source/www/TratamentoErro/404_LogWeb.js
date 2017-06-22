
var Erro;
var Pagina;

function PaginaErro()
{

	DocURL = document.URL;
		
	protocolIndex=DocURL.indexOf("?", 4) + 1;

	serverIndex=DocURL.indexOf(";",protocolIndex + 3);

	Pagina=DocURL.substring(serverIndex + 1);
		
}

function ErroPagina()
{

	DocURL = document.URL;
	
	protocolIndex=DocURL.indexOf("?", 4) + 1;

	serverIndex=DocURL.indexOf(";",protocolIndex + 3);

	Erro=DocURL.substring(protocolIndex, serverIndex);
	
}

function LogPage()
 {
	// This only works with IE 5+
	if ((navigator.appVersion.indexOf("MSIE") > 0) && (parseInt(navigator.appVersion) >= 4))
	   {
   		   PaginaErro();
   		   ErroPagina();
   		   qstring = "404_IncluirDB.asp?Erro=" + Erro + "&Pagina=" + Pagina;
   		   XMLSend = new ActiveXObject("Microsoft.XMLDOM");
   		   XMLSend.async = false;
   		   XMLSend.load(qstring);
       }
 }

  

