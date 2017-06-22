function showAguardeClock(){
	try{
		var x="<table><tr><td><img src=img/tempo.gif></td><td>&nbsp;&nbsp;Aguarde...</td></tr></table>";
		var d = document;
		var id="divAguarde";
		var el=d.getElementById?d.getElementById(id):d.all?d.all[id]:d.layers[id];

		var ns = (navigator.appName.indexOf("Netscape") != -1);
		var screenSize = ns ? innerWidth : document.body.clientWidth;
		var screenHeight = ns ? pageYOffset : document.body.scrollTop;
		el.style.left=(screenSize-150)/2;
		el.style.top= screenHeight + 100;
			
		el.innerHTML=x;
	} 
	catch(e){
	}
}
	
/*Funcoes para mostrar div de aguarde. */
function showAguarde(){
		try{
			//hideComboBox();			
			var d = document;
			var id="divAguarde";
			var el=d.getElementById?d.getElementById(id):d.all?d.all[id]:d.layers[id];
			el.style.visibility="visible";
			el.style.display="block";
			if(d.layers)el.style=el;
			
			var ns = (navigator.appName.indexOf("Netscape") != -1);
			var screenSize = ns ? innerWidth : document.body.clientWidth;
			var screenHeight = ns ? pageYOffset : document.body.scrollTop;
			el.style.left=(screenSize-150)/2;
			el.style.top= screenHeight + 100;	
			
			
			setTimeout("showAguardeClock()", 10);
		} catch(e){
			alert(e);// Não tem o aguarde definido na página.
		}
}
	
//Esconde o Aguarde no caso dele ter sido chamado para mostrar uma window.
function hideAguarde(){
//		var el = getParentElement("divAguarde");
//		var d = document;
//		var el = d.getElementId("divAguarde");
		var el = document.all.divAguarde;

		el.style.visibility="hidden";
		el.style.display="none";
		//showComboBox();
}

