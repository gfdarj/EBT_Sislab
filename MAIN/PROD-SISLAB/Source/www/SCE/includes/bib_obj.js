/***
	Biblioteca de funcoes de OJBETOS

	Gilberto Almeida - COPPETEC
***/

// pula para o prox objeto
function proxCampo(curObj, nextObj) {
	if((event.keyCode == 13) || (curObj.value.length == curObj.maxLength) || (curObj.type.substr(0,6) == 'select')) {
		nextObj.focus();  if(nextObj.type == 'text') nextObj.select();
		event.keyCode = null;
		return true;
	}
	if(!(event.keyCode >= 48 && event.keyCode <= 57)) {
		return false;
	}
	return true;
}

function comboSimNao(escreve, id_combo, padrao) {
	var str = '';
	str += '<select name="' + id_combo + '" class="form">';
	str += '<option value="1"' + (padrao == '1'? ' selected ' : '') + '>Sim</option>';
	str += '<option value="0"' + (padrao == '0'? ' selected ' : '') + '>Não</option>';
	str += '</select>';
	if(escreve) document.write(str);
	return str;
}

function comboAmostraEq(escreve, id_combo, padrao) {
	var str = '';
	str += '<select name="' + id_combo + '" class="form">';
	str += '<option value="A"' + (padrao == 'A'? ' selected ' : '') + '>Amostra</option>';
	str += '<option value="E"' + (padrao == 'E'? ' selected ' : '') + '>Equipamento</option>';
	str += '</select>';
	if(escreve) document.write(str);
	return str;
}

function inputText(escreve, id_input, padrao, sizeInput, maxlength, eventos) {
    var str = '';
    str += '<input type="text" name="' + id_input + '" id="' + id_input + '" ';
    str += 'value="' + padrao + '" size="' + sizeInput + '" maxlength="' + maxlength + '" ';
    str += eventos + ' >';   // eventos deve conter apenas aspas duplas !!!
    if (escreve) document.write(str);
    return str;
}
