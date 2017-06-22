// Funcoes utilizadas na listagem de quantidades das caracteristicas
function ExtraiQtde(eu)
{	var i = eu.lastIndexOf( "(" );
	if (i <= 0) return eu; else return eu.substring( i, eu.length );
}

function ExtraiTexto(eu)
{	var i = eu.lastIndexOf( "(" );
	if (i <= 0) return eu; else return eu.substring( 0, i );
}

function ExtraiQtdeSemPar(eu)
{	var i = eu.lastIndexOf( "(" );
	if (i <= 0) return eu; else return eu.substring( i+1, eu.length-1 );
}
