// Identificação de browser
var isNav4, isNav, isIE;
if (parseInt(navigator.appVersion.charAt(0)) >= 4) {
  isNav = (navigator.appName=="Netscape") ? true : false;
  isIE = (navigator.appName.indexOf("Microsoft") != -1) ? true : false;
}
if (navigator.appName=="Netscape") {
	isNav4 = (parseInt(navigator.appVersion.charAt(0))==4);
}

function max(e,valor)
{
if (e.value.length + 1> valor)
	if (isIE) event.keyCode=0;
}
//funcao de correcao do IE 5.5
function onClickHandler(e){
	var el = null;
	var flag = true;
	el = (isNav) ? e.target.parentNode : event.srcElement;
	while (flag && el){
		if (el.tagName == "A"){
			flag = false;
			if (el.protocol.toUpperCase() == "JAVASCRIPT:"){
				eval(unescape(el.href));
			}
			else return true;
			return false;
		}
		else {
			el = (isNav) ? el.parentNode : el.parentElement;
		}
	}
}

function checkDecimal(campo) {
	if (campo.value.length == 2)
		campo.value = '0,' + campo.value;
	if (campo.value.length == 1)
		campo.value = '0,' + campo.value + '0';
}

function formata(valor) {
    var str="";
    var j=0;
    range(valor);
    if(valor.value=="") {
        valor.value="0"
    }
    str = valor.value + ","
    arredonda(valor)
}

function range(campo) {
    for(var i=0; i<=(eval(campo.value.length)-1); i++)
        if(campo.value.charAt(i)!='0' && campo.value.charAt(i)!='1' && campo.value.charAt(i)!='2'
           && campo.value.charAt(i)!='3' && campo.value.charAt(i)!='4' && campo.value.charAt(i)!='5'
           && campo.value.charAt(i)!='6' && campo.value.charAt(i)!='7' && campo.value.charAt(i)!='8'
           && campo.value.charAt(i)!='9' && campo.value.charAt(i)!=',')
        {
            alert("Valor inválido. Favor redigitar.");
            campo.value=0
        }
}

function Formatador(campo,tammax,teclapres) {
var tecla = teclapres.keyCode;
vr = campo.value;
vr = vr.replace( "/", "" );
vr = vr.replace( "/", "" );
vr = vr.replace( ",", "" );
vr = vr.replace( ".", "" );
vr = vr.replace( ".", "" );
vr = vr.replace( ".", "" );
vr = vr.replace( ".", "" );
tam = vr.length;

if (tam < tammax && tecla != 8){ tam = vr.length + 1 ; }
if (tecla == 8 ){	tam = tam - 1 ; }
if ( tecla == 8 || tecla >= 48 && tecla <= 57 || tecla >= 96 && tecla <= 105 ){
if ( tam <= 2 ){ campo.value = vr ; }
if ( (tam > 2) && (tam <= 5) ){campo.value = vr.substr( 0, tam - 2 ) + ',' + vr.substr( tam - 2, tam ) ; }
if ( (tam >= 6) && (tam <= 8) ){campo.value = vr.substr( 0, tam - 5 ) + '.' + vr.substr( tam - 5, 3 ) + ',' + vr.substr( tam - 2, tam ) ; }
if ( (tam >= 9) && (tam <= 11) ){campo.value = vr.substr( 0, tam - 8 ) + '.' + vr.substr( tam - 8, 3 ) + '.' + vr.substr( tam - 5, 3 ) + ',' + vr.substr( tam - 2, tam ) ; }
if ( (tam >= 12) && (tam <= 14) ){campo.value = vr.substr( 0, tam - 11 ) + '.' + vr.substr( tam - 11, 3 ) + '.' + vr.substr( tam - 8, 3 ) + '.' + vr.substr( tam - 5, 3 ) + ',' + vr.substr( tam - 2, tam ) ; }
if ( (tam >= 15) && (tam <= 17) ){campo.value = vr.substr( 0, tam - 14 ) + '.' + vr.substr( tam - 14, 3 ) + '.' + vr.substr( tam - 11, 3 ) + '.' + vr.substr( tam - 8, 3 ) + '.' + 
vr.substr( tam - 5, 3 ) + ',' + vr.substr( tam - 2, tam ) ;}
	}
}

function onlynum(e) {
	var keyNumber = (isIE) ? event.keyCode : e.which;
	if (((keyNumber<48)||(keyNumber>57)) && (keyNumber!=13) && (keyNumber!="0") && (keyNumber!=8)) {
		if (isIE) event.keyCode=0;
		return false;
	}
}

function tiraAlpha(e) {
	var str = e.value;
	var str2 = "",ch
	var j=1;
	j = str.length;
	for(i=0 ; i < j; i++){
		ch = str.charCodeAt(i)

		if (!((ch<48)||(ch>57)))
			str2 += str.charAt(i)
	}
	e.value =  str2;
}
function refreshCampo(obj){
	if (isIE) {
		obj.value = obj.value;
	}
}


function tirarZerosEsquerda(STR){

  var sAux='';
  var i=0;
  STR=new String(STR);
  
  while (i < STR.length ){
    if ((STR.charAt(i)!='.') && (STR.charAt(i)!=',')){
	  sAux += STR.charAt(i);
    }
	i++
  }
  
  
  STR = new String(sAux);
  sAux = '';
  i=0;
  
  while (i < STR.length ){
    if (STR.charAt(i) != '0'){
      sAux = STR.substring(i,STR.length)
	  i = STR.length;
	}
    i++;
  }
  
  return  sAux;
}

  
function formatarOnKeyUp(OBJ){
  var decimal,inteiro;
  var i,count;
  STR = new String(OBJ.value);
  STR = tirarZerosEsquerda(STR);
  inteiro='';
  if (isIE) {
		if (STR.length == 0){
		return;
		}
		if (STR.length == 1){
			  inteiro  = '0';
			  decimal = '0' + STR;
			}
			else { 
			  if (STR.length == 2){
				  inteiro  = '0';
				  decimal = STR;
				}
				else{
				  decimal = STR.substring(STR.length-2,STR.length);
				  i=3;
				  count=0;
				  while (i<=STR.length){
			 		if (count==3) {
					  inteiro = '.' + inteiro;
					  count = 0;
					}
				    inteiro = STR.charAt(STR.length-i) + inteiro;
					count++;
					i++;
				  }
				}
			}
    
  
		if (inteiro == '') {
		  inteiro = '0';
		}
  
		if (decimal == '') {
		  decimal = '00';
		}
		OBJ.value = inteiro+','+decimal;
  }
}

function formatarvalor(STR){
  var decimal,inteiro;
  var i,count;
  STR = new String(STR);
  STR = tirarZerosEsquerda(STR);
  inteiro='';
  if (STR.length == 1){
	  inteiro  = '0';
	  decimal = '0' + STR;
	}
	else { 
	  if (STR.length == 2){
		  inteiro  = '0';
		  decimal = STR;
		}
		else{
		  decimal = STR.substring(STR.length-2,STR.length);
		  i=3;
		  count=0;
		  while (i<=STR.length){
		 		if (count==3) {
				  inteiro = '.' + inteiro;
				  count = 0;
				}
		    inteiro = STR.charAt(STR.length-i) + inteiro;
				count++;
				i++;
		  }
		}
	}
  if (inteiro == '') {
    inteiro = '0';
  }
  if (decimal == '') {
    decimal = '00';
  }
  return inteiro+','+decimal;
}

function formatarNumber(OBJ){
  var decimal,inteiro;
  var i,count;
  STR = new String(OBJ.value);
  STR = tirarZerosEsquerda(STR);
  inteiro='';
		if (STR.length == 1){
			  inteiro  = '0';
			  decimal = '0' + STR;
			}
			else { 
			  if (STR.length == 2){
				  inteiro  = '0';
				  decimal = STR;
				}
				else{
				  decimal = STR.substring(STR.length-2,STR.length);
				  i=3;
				  count=0;
				  while (i<=STR.length){
			 		if (count==3) {
					  inteiro = '.' + inteiro;
					  count = 0;
					}
				    inteiro = STR.charAt(STR.length-i) + inteiro;
					count++;
					i++;
				  }
				}
			}
    
  
		if (inteiro == '') {
		  inteiro = '0';
		}
  
		if (decimal == '') {
		  decimal = '00';
		}
		OBJ.value = inteiro+','+decimal;

}

function formatarOnKeyDown(OBJ){
  var decimal,inteiro;
  var i,count;
  STR = new String(OBJ.value);
  
  inteiro='';
  
  if (isIE) {	  
	if (event.keyCode == 46){
		OBJ.value = '';
		return;
	}

	if (OBJ.maxLength > STR.length){     
	  STR = tirarZerosEsquerda(STR); //ESTA FUNCAO TIRA TAMBEM PONTO E VIRGULA
	  if ( ((event.keyCode > 47) && (event.keyCode < 59)) || ((event.keyCode > 95) && (event.keyCode < 106))   ){
	      
			if (STR.length == 0){
			  inteiro  = '0';
			  decimal = '0' + STR;
			}
			else { 
			  if (STR.length == 1){
			    inteiro  = '0';
			    decimal = STR;
			  }
			  else{
			    decimal = STR.substring(STR.length-1,STR.length);
			    i=2;
			    count=0;
			    while (i<=STR.length){
			 		if (count==3) {
			  	  inteiro = '.' + inteiro;
			  	  count = 0;
			  	}
			      inteiro = STR.charAt(STR.length-i) + inteiro;
			  	count++;
			  	i++;
			    }
			  }
			}   
	 
	  }
	  else{ 
	    if (event.keyCode == 8){

	      if (STR.length == 0){
			  inteiro  = '0';
			  decimal = '000';
			}
			else { 
			  if (STR.length == 1){
			    inteiro  = '0';
			    decimal = '00' + STR;
			  }
			  else { 
			    if (STR.length == 2){
		          inteiro  = '0';
			      decimal = '0' + STR;
			     }
		         else{
	 			   decimal = STR.substring(STR.length-3,STR.length);
				   i=4;
				   count=0;
				   while (i<=STR.length){
			 		 if (count==3) {
					   inteiro = '.' + inteiro;
					   count = 0;
					  }
				      inteiro = STR.charAt(STR.length-i) + inteiro;
					  count++;
					  i++;
				    }
			     }
			  } 
	      }
	    }
	    else {
	      
	      if (STR.length == 1){
		 	  inteiro  = '0';
		      decimal = '0' + STR;
			}
			else { 
			  if (STR.length == 2){
				  inteiro  = '0';
				  decimal = STR;
				}
				else{
				  decimal = STR.substring(STR.length-2,STR.length);
				  i=3;
				  count=0;
				  while (i<=STR.length){
			 		if (count==3) {
					  inteiro = '.' + inteiro;
					  count = 0;
					}
				    inteiro = STR.charAt(STR.length-i) + inteiro;
					count++;
					i++;
				  }
				}
			}        
	    }
	  }
	  
	  if (inteiro == '') {
	    inteiro = '0';
	  }
  
	  if (decimal == '') {
	    decimal = '00';
	  }
	  OBJ.value = inteiro+','+decimal;
	}
  }
}