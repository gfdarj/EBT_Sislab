/* Abre uma janela centralizada na tela */
function NewWindow(mypage, myname, w, h, scroll)
{
	var winl = (screen.width - w) / 2;
	var wint = (screen.height - h) / 2;
	winprops = 'height='+h+',width='+w+',top='+wint+',left='+winl+',scrollbars='+scroll+',resizable'
	win = window.open(mypage, myname, winprops)
	if (parseInt(navigator.appVersion) >= 4) { win.window.focus(); }
}

function trim(str)
{
	while (str.charAt(0) == " ")
	str = str.substr(1,str.length -1);

	while (str.charAt(str.length-1) == " ")
	str = str.substr(0,str.length-1);

	return str;
}

function MudaCampo(obj,i)
{
	var keyNumber = (isIE) ? event.keyCode : obj.which;

	if (keyNumber==9 || keyNumber==16) {
		if (isIE) event.keyCode=0;
		return false;
	}
	if (obj.value.length == obj.getAttribute("maxlength"))
	{
		i = i + 1
		obj.form.elements[i].focus()
	}
}
function isDate(desData)
{
  var err=0
  if (desData.length != 10) err=1
  datDia = parseInt(desData.substring(0, 2), 10) // day
  desBarra1 = desData.substring(2, 3)// '/'
  datMes = parseInt(desData.substring(3, 5), 10)// month
  desBarra2 = desData.substring(5, 6)// '/'
  datAno = parseInt(desData.substring(6, 10), 10)// year
  // erros basicos
  if (datMes<1 || datMes>12) err = 1
  if (desBarra1 != '/') err = 1
  if (datDia<1 || datDia>31) err = 1
  if (desBarra2 != '/') err = 1
  if (datAno<0) err = 1
  // erros avancados
  // meses com 30 dias
  if (datMes==4 || datMes==6 || datMes==9 || datMes==11)
  {
    if (datDia>30) err=1
  }
  // fevereiro...
  if (datMes==2)
  {
    var g=parseInt(datAno/4)
    if (isNaN(g)) 
    {
      err=1
    }
    if (datDia>29) err=1
    if (datDia==29 && ((datAno/4)!=parseInt(datAno/4))) err=1
  }
	if (err == 0) return true;
	else return false;
}

function VerificarEmail(PVstrEmail)
{
var x = PVstrEmail;
var filter  = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9])+$/;

if (filter.test(x)) return true;
else return false;

}

function reload(init) 
{ //reloads the window if Nav4 resized
	if (init==true) with (navigator) 
	{
		if((appName=="Netscape")&&(parseInt(appVersion)==4)) 
		{
			document.pgW=innerWidth; document.pgH=innerHeight;
			onresize=reload; 
		}
	}
	else if (innerWidth!=document.pgW || innerHeight!=document.pgH)
		location.reload();
}
reload(true);

function encontraObjeto(n, d) 
{ //v4.0
	var p,i,x; 
	if(!d) d=document;
	if((p=n.indexOf("?"))>0&&parent.frames.length) 
	{
		d=parent.frames[n.substring(p+1)].document; 
		n=n.substring(0,p);
	}
	if(!(x=d[n])&&d.all) x=d.all[n]; 
	for (i=0;!x&&i<d.forms.length;i++)
		x=d.forms[i][n];
	for(i=0;!x&&d.layers&&i<d.layers.length;i++)
		x=encontraObjeto(n,d.layers[i].document);
	if(!x && document.getElementById) x=document.getElementById(n); 
	return x;
}

function showHideLayers() 
{ //v3.0
	var i,p,v,v1,obj,args = showHideLayers.arguments;
	for (i=0; i<(args.length-2); i+=3) 
		if ((obj=encontraObjeto(args[i]))!=null)
		{ 
			v=args[i+2];
			if (obj.style) 
			{ 
				obj=obj.style;
				v=(v=='show')?'visible':(v=='hide')?'hidden':v; 
			}
			obj.visibility=v; 
		}
}
function statusObjeto() 
{ 
	var i, v,obj,args = statusObjeto.arguments;
	for (i=0; i<(args.length-2); i+=3) 
		if ((obj=encontraObjeto(args[i]))!=null)
		{ 
			v=(obj.style.visibility=='visible')?true:false; 
			return v; 
		}
}
function mostra(objeto)
{
	if (document.all)	eval("document.all['"+objeto+"'].style.display = 'block';");
//	else showHideLayers(objeto,"","show");
	else mudaEstilo(objeto, "display", "");
}
function esconde(objeto)
{
	if (document.all)	eval("document.all['"+objeto+"'].style.display = 'none';");
//	else showHideLayers(objeto,"","hide");
	else mudaEstilo(objeto, "display", "none");
}

function habilitar() 
{ 
	var i,p,v,obj,args = habilitar.arguments;
	for (i=0; i<(args.length-2); i+=3) 
		if ((obj=encontraObjeto(args[i]))!=null)
		{ 
			v=args[i+2];
			v=(v=='sim')?false:(v=='nao')?true:v; 
			obj.disabled = v;
		}
}
function visivel(objeto)
{
	if (document.all)
	{
		var q = eval("document.all."+objeto+".style.display");
		if (q == 'block')	return true;
		else return false;
	}
	else return statusObjeto(objeto,"","");
}
function desabilita(objeto)
{
	habilitar(objeto,"","nao")
}
function habilita(objeto)
{
	habilitar(objeto,"","sim")
}

function mudarEstilo()
{
	var tipoEstilo,valorEstilo,i,obj,args = mudarEstilo.arguments;
	for (i=0; i<(args.length-2); i+=3) 
		if ((obj=encontraObjeto(args[i]))!=null)
		{ 
			tipoEstilo  = args[i+1];
			valorEstilo = args[i+2];
			if (obj.style) 
			{ 
				obj=obj.style;
			}
			eval("obj."+tipoEstilo+"=valorEstilo"); 
		}
}
function mudaEstilo(objeto, estilo, cor)
{
	mudarEstilo(objeto, estilo, cor)
}
function mudarConteudo()
{
	var tipoEstilo,valorEstilo,i,obj,args = mudarConteudo.arguments;
	for (i=0; i<(args.length-2); i+=3) 
		if ((obj=encontraObjeto(args[i]+"?0"))!=null)
		{ 
			tipoEstilo  = args[i+1];
			valorEstilo = args[i+2];
//			alert(eval("obj."+tipoEstilo+"=valorEstilo"));
			eval("obj."+tipoEstilo+"=valorEstilo"); 
		}
}

function mudaConteudo(objeto, tipoestilo, valorestilo)
{
	mudarConteudo(objeto, tipoestilo, valorestilo);
}
