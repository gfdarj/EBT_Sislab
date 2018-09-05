// Adiciona 1 zero a um numero entre 0 e 9
function Zeros(num) {
  if (num<10) 
    return ('0' + num);
  else return num;
}

function isNumeric(numero)
{
	var i=0;
	while(i<numero.length) {
		if (isNaN(numero.charAt(i)))
			return false;
		i++;
	}     
	return true;
}

// Procura aspas em uma string
function AchaAspas(texto)
{
  auxtamanho=texto.length;
  var i=0;
  while( i <= auxtamanho - 1 )
	{
    if ( (escape( texto.charAt( i )) == escape("'")) || (escape(texto.charAt(i)) == "%22"))
      return true;
    else
  	i++;
  }
  return false;
}

