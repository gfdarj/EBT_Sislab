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

