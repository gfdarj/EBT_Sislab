<!--#include file="includes/Sislab_Lib.asp"-->
<html>
<head>
	<title>SISLAB</title>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<style></style>
	<link rel="stylesheet" href="estilos/principal.css" type="text/css">

<style type="text/css">
/*Example CSS for the two demo scrollers*/
#pscroller1{
	width: 130px;
	height: 70px;
	border: none;
	padding: 0px;
	background-color: none;
}

.someclass{ //class to apply to your scroller(s) if desired }
</style>

<script language="JavaScript">
function novaJanela(id_noticia)
{
	var jan = window.open('noticias_exibe.asp?id_noticia=' + id_noticia, 'Noticias_CRT', 'toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,copyhistory=no,width=690,height=400,top=5,left=5');
	jan.focus();
}
</script>

<script type="text/javascript">

/*Example message arrays for the two demo scrollers*/

var pausecontent=new Array();

<%
Dim objRS, sSQL, conta

sSQL = "select * From Plantao Where PLA_DATATERMINO >= GETDATE() order by PLA_CODNOTICIA desc"
Call Env.RecordSet( true, objRS, sSQL)
conta = 0
if not (objRS.EOF and objRS.BOF) then
	while not objRS.EOF
		conta = conta + 1
		if Not(IsNull(objRS("PLA_LINK")) or objRS("PLA_LINK")="") then%>
pausecontent[<%=conta-1%>]= '&raquo;&nbsp;<a href="#" onclick="javascript:novaJanela(<%=objRS("pla_codnoticia")%>);" class="texto" style="text-align: left; display: inline;" target="_self"><%=Reticencias(trim(objRS("PLA_TITNOTICIA")),80)%></a>';
<%		else%>
pausecontent[<%=conta-1%>]=  '&raquo;&nbsp;<font class="texto"><%=Reticencias(objRS("PLA_TitNoticia"),80)%></font>';
<%		end if
		objRS.MoveNext
	wend%>
pausecontent[<%=conta%>]=  '';
<%
Else%>
pausecontent[0]=  '<center><i>Nenhuma notícia cadastrada</i></center>';
<%
End If
Call Env.RecordSet(false, objRS, null)
%>
</script>

<script type="text/javascript">
/***********************************************
* Pausing up-down scroller- © Dynamic Drive (www.dynamicdrive.com)
* This notice MUST stay intact for legal use
* Visit http://www.dynamicdrive.com/ for this script and 100s more.
***********************************************/
function pausescroller(content, divId, divClass, delay)
{
	this.content=content //message array content
	this.tickerid=divId //ID of ticker div to display information
	this.delay=delay //Delay between msg change, in miliseconds.
	this.mouseoverBol=0 //Boolean to indicate whether mouse is currently over scroller (and pause it if it is)
	this.hiddendivpointer=1 //index of message array for hidden div
	document.write('<div id="'+divId+'" class="'+divClass+'" style="position: relative; overflow: hidden"><div class="innerDiv" style="position: absolute; width: 100%" id="'+divId+'1">'+content[0]+'</div><div class="innerDiv" style="position: absolute; width: 100%; visibility: hidden" id="'+divId+'2">'+content[1]+'</div></div>')

	var scrollerinstance=this

	if (window.addEventListener) //run onload in DOM2 browsers
		window.addEventListener("load", function(){scrollerinstance.initialize()}, false)
	else if (window.attachEvent) //run onload in IE5.5+
		window.attachEvent("onload", function(){scrollerinstance.initialize()})
	else if (document.getElementById) //if legacy DOM browsers, just start scroller after 0.5 sec
		setTimeout(function(){scrollerinstance.initialize()}, 500)
}

// -------------------------------------------------------------------
// initialize()- Initialize scroller method.
// -Get div objects, set initial positions, start up down animation
// -------------------------------------------------------------------
pausescroller.prototype.initialize=function()
{
	this.tickerdiv=document.getElementById(this.tickerid)
	this.visiblediv=document.getElementById(this.tickerid+"1")
	this.hiddendiv=document.getElementById(this.tickerid+"2")
	this.visibledivtop=parseInt(pausescroller.getCSSpadding(this.tickerdiv))

	//set width of inner DIVs to outer DIV's width minus padding (padding assumed to be top padding x 2)
	this.visiblediv.style.width=this.hiddendiv.style.width=this.tickerdiv.offsetWidth-(this.visibledivtop*2)+"px"
	this.getinline(this.visiblediv, this.hiddendiv)
	this.hiddendiv.style.visibility="visible"

	var scrollerinstance=this

	document.getElementById(this.tickerid).onmouseover=function(){scrollerinstance.mouseoverBol=1}
	document.getElementById(this.tickerid).onmouseout=function(){scrollerinstance.mouseoverBol=0}

	if (window.attachEvent) //Clean up loose references in IE
		window.attachEvent("onunload", function(){scrollerinstance.tickerdiv.onmouseover=scrollerinstance.tickerdiv.onmouseout=null})

	setTimeout(function(){scrollerinstance.animateup()}, this.delay)
}


// -------------------------------------------------------------------
// animateup()- Move the two inner divs of the scroller up and in sync
// -------------------------------------------------------------------
pausescroller.prototype.animateup = function()
{
	var scrollerinstance=this
	if (parseInt(this.hiddendiv.style.top)>(this.visibledivtop+5))
	{
		this.visiblediv.style.top=parseInt(this.visiblediv.style.top)-5+"px"
		this.hiddendiv.style.top=parseInt(this.hiddendiv.style.top)-5+"px"
		setTimeout(function(){scrollerinstance.animateup()}, 50)
	}
	else
	{
		this.getinline(this.hiddendiv, this.visiblediv)
		this.swapdivs()
		setTimeout(function(){scrollerinstance.setmessage()}, this.delay)
	}
}

// -------------------------------------------------------------------
// swapdivs()- Swap between which is the visible and which is the hidden div
// -------------------------------------------------------------------
pausescroller.prototype.swapdivs = function()
{
	var tempcontainer=this.visiblediv
	this.visiblediv=this.hiddendiv
	this.hiddendiv=tempcontainer
}

pausescroller.prototype.getinline=function(div1, div2)
{
	div1.style.top=this.visibledivtop+"px"
	div2.style.top=Math.max(div1.parentNode.offsetHeight, div1.offsetHeight)+"px"
}

// -------------------------------------------------------------------
// setmessage()- Populate the hidden div with the next message before it's visible
// -------------------------------------------------------------------
pausescroller.prototype.setmessage=function()
{
	var scrollerinstance=this

	if (this.mouseoverBol==1) //if mouse is currently over scoller, do nothing (pause it)
		setTimeout(function(){scrollerinstance.setmessage()}, 100)
	else
	{
		var i=this.hiddendivpointer
		var ceiling=this.content.length
		this.hiddendivpointer=(i+1>ceiling-1)? 0 : i+1
		this.hiddendiv.innerHTML=this.content[this.hiddendivpointer]
		this.animateup()
	}
}

pausescroller.getCSSpadding = function(tickerobj)
{	//get CSS padding value, if any
	if (tickerobj.currentStyle)
		return tickerobj.currentStyle["paddingTop"]
	else if (window.getComputedStyle) //if DOM2
		return window.getComputedStyle(tickerobj, "").getPropertyValue("padding-top")
	else
		return 0
}
</script>

</head>

<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0">
<script type="text/javascript">
<%
If Conta > 0 Then
%>
	//new pausescroller(name_of_message_array, CSS_ID, CSS_classname, pause_in_miliseconds)
	new pausescroller(pausecontent, "pscroller1", "someclass", 3000)
	document.write("<br/>")
<%
Else
%>
	document.write(pausecontent[0]);
<%
End If
%>
</script>
</body>
</html>
