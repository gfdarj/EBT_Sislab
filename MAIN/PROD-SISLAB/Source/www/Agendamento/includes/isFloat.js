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
