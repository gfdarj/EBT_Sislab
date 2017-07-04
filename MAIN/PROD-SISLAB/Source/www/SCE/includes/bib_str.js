/***
	Biblioteca de funcoes de STRING

	Gilberto Almeida - COPPETEC
***/

// retorna a data no formato AAAAMMDD
function concatenaData(dt) {
	return dt.substr(dt.length-4, 4) + dt.substr(3,2) + dt.substr(0,2);
}

// recebe uma data no formato dd/mm/aaaa e retorna true ou false
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

// recebe uma string e verifica se eh um numero ponto flutuante 
// O SEPARADOR PARA CASAS DECIMAIS EH O PONTO (.)
function isFloat(str)
{
	var erro=0;
	var k;
	var separador=0;
	for(i=0;i<str.length;i++)
	{
		k = str.substring(i,(i+1))
		if ((k==".")||(k==","))
		{
			separador += 1;	
			continue;
		}
		else if (isNaN(parseInt(k)) == true)
			erro = 1;
	}
	if ((erro==1)||(separador>1))
		return false;

	return true;
}

// recebe uma string e verifica se eh um numero
function isNumeric(str)
{
	var k;
	for(i=0;i<str.length;i++)
	{
		k = str.substring(i,(i+1))
		if (isNaN(parseInt(k)) == true)
			return false;
	}
	return true;
}

function formataData(elemento) {
	var data

	if (elemento.value.length > 0 )
	{
		if (elemento.value.length == 2)
		{
			data = elemento.value;
			elemento.value = data + '/';
			elemento.focus();
		}
		if (elemento.value.length == 5)
		{
			data = elemento.value;
			elemento.value = data + '/';
			elemento.focus();
		}
	}
	return 0;
}

/***

function trim(inputString)
{
	// Removes leading and trailing spaces from the passed string. Also removes
	// consecutive spaces and replaces it with one space. If something besides
	// a string is passed in (null, custom object, etc.) then return the input.
	if (typeof inputString != "string") { return inputString; }
	var retValue = inputString;
	var ch = retValue.substring(0, 1);
	while (ch == " ") { // Check for spaces at the beginning of the string
	retValue = retValue.substring(1, retValue.length);
	ch = retValue.substring(0, 1);
	}
	ch = retValue.substring(retValue.length-1, retValue.length);
	while (ch == " ") { // Check for spaces at the end of the string
	retValue = retValue.substring(0, retValue.length-1);
	ch = retValue.substring(retValue.length-1, retValue.length);
	}
	while (retValue.indexOf("  ") != -1) { // Note that there are two spaces in the string - look for multiple spaces within the string
	retValue = retValue.substring(0, retValue.indexOf("  ")) + retValue.substring(retValue.indexOf("  ")+1, retValue.length); // Again,
	there are two spaces in each of the strings
	}
	return retValue; // Return the trimmed string back to the user
} // Ends the "trim" function


function Quicksort(vec, loBound, hiBound)
{
	var pivot, pivot_text, loSwap, hiSwap, temp, temp_text;

	// Two items to sort
	if (hiBound - loBound == 1)
	{
		if (vec.options[loBound].text > vec.options[hiBound].text)
		{
			temp = vec.options[loBound].value;
			vec.options[loBound].value = vec.options[hiBound].value;
			vec.options[hiBound].value = temp;
			temp_text = vec.options[loBound].text;
			vec.options[loBound].text = vec.options[hiBound].text;
			vec.options[hiBound].text = temp_text;
		}
		return;
	}

	// Three or more items to sort
	pivot = vec.options[parseInt((loBound + hiBound) / 2)].value;
	pivot_text = vec.options[parseInt((loBound + hiBound) / 2)].text;
	vec.options[parseInt((loBound + hiBound) / 2)].value = vec.options[loBound].value;
	vec.options[loBound].value = pivot;
	vec.options[parseInt((loBound + hiBound) / 2)].text = vec.options[loBound].text;
	vec.options[loBound].text = pivot_text;
	loSwap = loBound + 1;
	hiSwap = hiBound;

	do {
		// Find the right loSwap
		while (loSwap <= hiSwap && vec.options[loSwap].text <= pivot_text)
		loSwap++;
	
		// Find the right hiSwap
		while (vec.options[hiSwap].text > pivot_text)
		hiSwap--;
	
		// Swap values if loSwap is less than hiSwap
		if (loSwap < hiSwap)
		{
			temp = vec.options[loSwap].value;
			vec.options[loSwap].value = vec.options[hiSwap].value;
			vec.options[hiSwap].value = temp;
			temp_text = vec.options[loSwap].text;
			vec.options[loSwap].text = vec.options[hiSwap].text;
			vec.options[hiSwap].text = temp_text;
		}
	} while (loSwap < hiSwap);

	vec.options[loBound].value = vec.options[hiSwap].value;
	vec.options[hiSwap].value = pivot;
	vec.options[loBound].text = vec.options[hiSwap].text;
	vec.options[hiSwap].text = pivot_text;

	// Recursively call function...  the beauty of quicksort

	// 2 or more items in first section
	if (loBound < hiSwap - 1)
	Quicksort(vec, loBound, hiSwap - 1);

	// 2 or more items in second section
	if (hiSwap + 1 < hiBound)
	Quicksort(vec, hiSwap + 1, hiBound);
}
***/