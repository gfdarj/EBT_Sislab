function mostraMenuCadastros(show) {
	if (show) {
		mostraMenuConsultas(false);
		mostraMenuRelatorios(false);
		mostraMenuMovimentacao(false);
		document.all.menuCadastros.style.display = 'block';
	} else {
		document.all.menuCadastros.style.display = 'none';
	}
}
function mostraMenuConsultas(show) {
	if (show) {
		mostraMenuCadastros(false);
		mostraMenuRelatorios(false);
		mostraMenuMovimentacao(false);
		document.all.menuConsultas.style.display = 'block';
	} else {
		document.all.menuConsultas.style.display = 'none';
	}
}
function mostraMenuRelatorios(show) {
	if (show) {
		mostraMenuConsultas(false);
		mostraMenuCadastros(false);
		mostraMenuMovimentacao(false);
		document.all.menuRelatorios.style.display = 'block';
	} else {
		document.all.menuRelatorios.style.display = 'none';
	}
}
function mostraMenuMovimentacao(show) {
	if (show) {
		mostraMenuConsultas(false);
		mostraMenuCadastros(false);
		mostraMenuRelatorios(false);
		document.all.menuMovimentacao.style.display = 'block';
	} else {
		document.all.menuMovimentacao.style.display = 'none';
	}
}
function testaMousePointer(type) {
	var myX = window.event.x;
	var myY = window.event.y;
	var scroll = window.document.body.scrollTop;
	myY += scroll;
	 
	if (type == 'cadastros') {
		if((myX - 2 < document.all.menuCadastros.style.posLeft) || (myX > (document.all.menuCadastros.style.posLeft + document.all.menuCadastros.style.pixelWidth)) ||
		     (myY < document.all.menuCadastros.style.posTop) || (myY > (document.all.menuCadastros.style.posTop + document.all.menuCadastros.style.pixelHeight))) {
			mostraMenuCadastros (false); 
		}
	} else if (type == 'consultas') {
		if((myX - 2 < document.all.menuConsultas.style.posLeft) || (myX > (document.all.menuConsultas.style.posLeft + document.all.menuConsultas.style.pixelWidth)) ||
		     (myY < document.all.menuConsultas.style.posTop) || (myY > (document.all.menuConsultas.style.posTop + document.all.menuConsultas.style.pixelHeight))) {
			mostraMenuConsultas (false); 
		}
	} else if (type == 'relatorios') {
		if((myX - 2 < document.all.menuRelatorios.style.posLeft) || (myX > (document.all.menuRelatorios.style.posLeft + document.all.menuRelatorios.style.pixelWidth)) ||
		     (myY < document.all.menuRelatorios.style.posTop) || (myY > (document.all.menuRelatorios.style.posTop + document.all.menuRelatorios.style.pixelHeight))) {
			mostraMenuRelatorios (false); 
		}
	} else if (type == 'movimentacao') {
		if((myX - 2 < document.all.menuMovimentacao.style.posLeft) || (myX > (document.all.menuMovimentacao.style.posLeft + document.all.menuMovimentacao.style.pixelWidth)) ||
		     (myY < document.all.menuMovimentacao.style.posTop) || (myY > (document.all.menuMovimentacao.style.posTop + document.all.menuMovimentacao.style.pixelHeight))) {
			mostraMenuMovimentacao (false); 
		}
	}
}
