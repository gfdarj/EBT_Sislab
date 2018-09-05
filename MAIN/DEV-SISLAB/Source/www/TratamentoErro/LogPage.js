function LogPage() {
	
   	var browserName = navigator.appName;
   	var browserVersion = navigator.appVersion;
   	qstring="LogPage.asp?browserName='" + browserName + "'&browserVersion='" + browserVersion + "'";
   	XMLSend= new ActiveXObject("Microsoft.XMLDOM");
   	XMLSend.async = false;
    XMLSend.load(qstring);
    alert("ok");
   
   	
   
}
