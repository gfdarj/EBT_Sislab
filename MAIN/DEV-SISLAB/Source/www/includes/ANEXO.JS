// Verificação do Campos antes de subimetê-los.
var isNav4, isNav, isIE;


if (parseInt(navigator.appVersion.charAt(0)) >= 4) {
  isNav = (navigator.appName=="Netscape") ? true : false;
  isIE = (navigator.appName.indexOf("Microsoft") != -1) ? true : false;
}
if (navigator.appName=="Netscape") {
	isNav4 = (parseInt(navigator.appVersion.charAt(0))==4);
}

//não permite outras teclas além de números (EX: onkeypress='onlynum(this)')
function onlynum(e) {
	var keyNumber = (isIE) ? event.keyCode : e.which;
	if (((keyNumber<48)||(keyNumber>57)) && (keyNumber!=13) && (keyNumber!="0") && (keyNumber!=8)) {
		if (isIE) event.keyCode=0;
		return false;
	}
}

function noEnter(e){
	var keyNumber = (isIE) ? event.keyCode : e.which;
	if (keyNumber == 13) {
		if (isIE) event.keyCode=0;
		return false;
	}
}
function isDate(pdata){
	var dia, mes, ano;
	var meses = new Array(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
	dia = pdata.substr(0, 2);
	mes = pdata.substr(3, 2);
	ano = pdata.substr(6, 4);
	if (ano%4 == 0)
		meses[1] = 29;
	return(mes>=1 && mes<=12 && dia>=1 && dia<=meses[mes-1]);
}

function ValidaDataMesAno(data,campo)
{
	var dia,mes,ano;
	var obj,auxcampo;
	obj = data;
	auxcampo=campo
	var varauxbissexto;
	if(obj==""||obj=="dd/mm/aaaa"||obj.length!=10)
	{			
	  alert(auxcampo + " - Data Invalida.\nInforme no formato (dd/mm/aaaa).");
    	  return false;
	}

	if(obj.length==8)
	{
		dia = parseInt(obj.substring(0,2),10);
		mes = parseInt(obj.substring(2,4),10);
		ano = parseInt(obj.substring(4,8),10)
	}
	else
	{
		dia = parseInt(obj.substring(0,2),10);
		mes = parseInt(obj.substring(3,5),10);
		ano = parseInt(obj.substring(6,10),10)
		
		if((obj.charAt(2)!='/')||(obj.charAt(5)!='/'))
		{
			if(obj!="")
			{			
				alert(auxcampo + " - Data Invalida.\nInforme a Data no formato (dd/mm/aaaa).");
				return false;
			}
		}
	}	

	//critica data
	if((dia > 31) || (dia == 0))
	{
		alert(auxcampo + " - Dia Inválido.");
		return false;		
	}
	if ((mes > 12) || (mes == 0))
	{
		alert(auxcampo + " - Mês Inválido.");
		return false;		
	}

	if ((ano == 0) || (ano == ''))
	{
		alert(auxcampo + " - Ano Inválido.");
		return false;		
	}

	if(ano%4 == 0)
		varauxbissexto = 1;
	else
		varauxbissexto = 0;
	if(((mes == 2) && (dia > (28 + parseInt(varauxbissexto,10)))) || (mes == 4 || mes == 6 || mes == 9 || mes == 11) && (dia > 30))
	{
		alert(auxcampo + "  - Preenchimento inválido.");
		return false;
	}	
	return true;
}

function AchaAspas(texto)
{
auxtamanho=texto.length;
var i=0;
while (i<=auxtamanho-1)
{
if ((escape(texto.charAt(i)) == escape("'"))||(escape(texto.charAt(i)) == "%22"))
{
   return true;
}
   else
     {	
	i++;
      }
}
return false;
}

// Se Data1 for >= Data2 retorna True
function DataMaiorIgual(data1,data2)
{
// Var auxano1,auxano2,auxmes1,auxmes2,auxdia2,auxdia1;
auxdia1=parseInt(data1.substring(0,2),10);
auxdia2=parseInt(data2.substring(0,2),10);
auxmes1=parseInt(data1.substring(3,5),10);
auxmes2=parseInt(data2.substring(3,5),10);
auxano1=parseInt(data1.substring(6,10),10);
auxano2=parseInt(data2.substring(6,10),10);

//Se ano de expiracao > ano de inicio -> Erro
if (auxano1>auxano2)
  {
	return true;
  } 
// else
//  {
//Se mes de expiracao > mes de inicio -> OK
     if ((auxmes1>auxmes2)&&(auxano1==auxano2))
	{
	    return true;
	}
           if ((auxdia1>auxdia2)&&(auxano1==auxano2)&&(auxmes1==auxmes2))
	      {
		   return true;
	      } 
  return false;
}

function trimJs(str)
{
	return str.replace(/ /g,'');
}

function extractFileName(texto)
{
	var fileName = texto.substring(texto.lastIndexOf('\\')+1);
	return fileName;
}

//Método que remove acentos, espaços e carateres indesejados
function validaNomeArquivo(texto)
{
	var temCharInvalido = false;
//	var ComAcentos = new String("!@#$%¨&*()-?:{}][ÄÅÁÂÀÃäáâàãÉÊËÈéêëèÍÎÏÌíîïìÖÓÔÒÕöóôòõÜÚÛüúûùÇç ");
//	var SemAcentos = new String("_________________AAAAAAaaaaaEEEEeeeeIIIIiiiiOOOOOoooooUUUuuuuCc_");
	var ComAcentos = new String("!@#$%¨&*()?:{}][ÄÅÁÂÀÃäáâàãÉÊËÈéêëèÍÎÏÌíîïìÖÓÔÒÕöóôòõÜÚÛüúûùÇç");
	var SemAcentos = new String("________________AAAAAAaaaaaEEEEeeeeIIIIiiiiOOOOOoooooUUUuuuuCc");

	for(i=0; i < ComAcentos.length; i++)
	{
		//se achar 1 char invalido, entao nao precisa procurar mais
		if(!temCharInvalido)
		{
			//alert('texto.indexOf(ComAcentos.charAt(i)): ' + texto.indexOf(ComAcentos.charAt(i)));
			if(texto.indexOf(ComAcentos.charAt(i)) != -1)
			{
				temCharInvalido = true;
				i = ComAcentos.length;
			}		
		}
	}
	return (!temCharInvalido);
/*
        $novo = strtolower($novo);
        $novo = str_replace("á","a", $novo);
        $novo = str_replace("à","a", $novo);
        $novo = str_replace("â","a", $novo);
        $novo = str_replace("ã","a", $novo);
        $novo = str_replace("ê","e", $novo);
        $novo = str_replace("é","e", $novo);
        $novo = str_replace("í","i", $novo);
        $novo = str_replace("ì","i", $novo);
        $novo = str_replace("õ","o", $novo);
        $novo = str_replace("ô","o", $novo);
        $novo = str_replace("ó","o", $novo);
        $novo = str_replace("ú","u", $novo);
        $novo = str_replace("ù","u", $novo);
        $novo = str_replace("ç","c", $novo);
        $novo = str_replace(" ","_", $novo);
*/
}

/* nao consegui por pra funcionar essa funcao */
function tiraAcentos(texto)
{
	var ComAcentos = new String("!@#$%¨&*()-?:{}][ÄÅÁÂÀÃäáâàãÉÊËÈéêëèÍÎÏÌíîïìÖÓÔÒÕöóôòõÜÚÛüúûùÇç ");
	var SemAcentos = new String("_________________AAAAAAaaaaaEEEEeeeeIIIIiiiiOOOOOoooooUUUuuuuCc_");

	for(i=0; i < ComAcentos.length; i++)
	{
		//texto = texto.replace(ComAcentos.charAt(i), SemAcentos.charAt(i));
	}
	return texto;
}
