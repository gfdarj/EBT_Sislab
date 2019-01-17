/*** COMBO BOX ***/

/***
	A função aceita o valor quando vier formatado de acordo com o seguinte exemplo:

	VALOR[val]DESSCRICAO[fim]

**/
function montaCombo(combo, texto) {
	var d1 = texto.split('[fim]');
	var d2;

	combo.options.length = 0;
	combo.options[0] = new Option('--', '');

	for (i=0; i < d1.length-1; i++) {
		d2 = d1[i].split('[val]');
		combo.options[i+1] = new Option(d2[1], d2[0]);
	}
}

/***
	A função aceita o valor quando vier formatado de acordo com o seguinte exemplo:

	VALOR[val]DESSCRICAO[fim]

**/
function montaComboSemVazio(combo, texto) {
    var d1 = texto.split('[fim]');
    var d2;

    for (i = 0; i < d1.length - 1; i++) {
        d2 = d1[i].split('[val]');
        combo.options[i] = new Option(d2[1], d2[0]);

    }
}
