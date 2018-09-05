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

//retorna =0 datas iguais; >0 data2 > data1; <0 data2 < data1
function comparaData(data1, data2) //formato dd/mm/aaaa
{
	ii = new Date(Date.UTC(data1.substring(6,10), data1.substring(3,5), data1.substring(0,2), 0, 0)) 
	ff = new Date(Date.UTC(data2.substring(6,10), data2.substring(3,5), data2.substring(0,2), 0, 0)) 
	return (ff-ii);  
}
