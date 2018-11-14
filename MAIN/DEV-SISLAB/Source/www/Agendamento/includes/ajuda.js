<span id="CAIXOTE" style="position:absolute; top: 0px; left: 0px;">
	<div id="AJUDATEXTO" style="background-color : #BDE5D8;font-family : Verdana, Geneva, Arial, Helvetica, sans-serif;height : 200px;width : 230px;left : 0px;top: -5000px;position: absolute;overflow : auto;scrollbar-arrow-color : Black;scrollbar-base-color : #BDE5D8;cursor: help;">
		<div align="justify" style="width: 210px;">
		</div>
	</div>
</span>
<script type="text/javascript">
MenuStatus = "hide"
window.onscroll=RolaCaixa
var menu, caixa, Teto
if (document.all){
	menu = document.all.AJUDATEXTO.style;
	caixa = document.all.CAIXOTE.style;
	Teto = "0px"
}
else if (document.layers){
	menu = document.AJUDATEXTO.layers;	
	caixa = document.CAIXOTE.layers;
	Teto="0pt"
}
else if (document.getElementById){
	menu = document.getElementById('AJUDATEXTO').style;
	caixa = document.getElementById('CAIXOTE').style;
	Teto = "0pt"
}
function RolaCaixa(){
	if(MenuStatus=="show"){
		Topo = parseInt(caixa.top)
		Esquerda = parseInt(caixa.left)
		tempoAnima = setInterval('AnimaCaixa()', 10)
	}
}
function AnimaCaixa(){
	TempTopo = parseInt(document.body.scrollTop)
	TempEsq = parseInt(document.body.scrollLeft)
	if(TempTopo > Topo) caixa.top = Topo++
	else if(TempTopo < Topo) caixa.top = Topo--
	else if(TempEsq > Esquerda) caixa.left = Esquerda++
	else if(TempEsq < Esquerda) caixa.left = Esquerda--
	else{
		caixa.top = document.body.scrollTop
		caixa.left = document.body.scrollLeft
		clearInterval(tempoAnima)
	}
}
function AjudaMe(){
	if (MenuStatus=="hide"){
		if (window.mescond)	clearInterval(mescond)
		MenuStatus="show"
		menu.top = "-200px"
		caixa.top = document.body.scrollTop
		caixa.left = document.body.scrollLeft
		mmostra=setInterval('MMenu()',1)
	}
	else if (MenuStatus=="show"){
		if (window.mmostra)	clearInterval(mmostra)
		MenuStatus="hide"
		mescond=setInterval('EMenu()',1)
	}
}	
function MMenu(){
	if (menu.top != Teto) menu.top = parseInt(menu.top)+4
	else clearInterval(mmostra)
}
function EMenu(){
	if (menu.top != "-200px") menu.top = parseInt(menu.top)-4
	else{
		menu.top = "-5000px"
		clearInterval(mescond)
	}
}
</script>
