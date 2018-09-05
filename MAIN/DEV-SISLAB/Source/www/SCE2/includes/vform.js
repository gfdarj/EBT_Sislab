function vdform() {
//############################################################################################
//Por Bernardo Heynemann
//Para usar basta chamar a função da seguinte maneira:
//vdform('nomedoform','nomedocampo','Texto a aparecer na mensagem de erro','Tipo de Validação',...)
//
//O Primeiro Argumento a ser passado deve ser o nome do form em que estão os objetos.
//
//
//Os tipos válidos para Tipo de Validação são:
//NEmail - Valida campos para e-mail somente se alguma coisa foi digitada.
//NNumber - Valida campos para valor numérico somente se alguma coisa foi digitada.
//NRangeX:Y - Valida campos para valor numérico entre X e Y se alguma coisa foi digitada.
//NCpf - Valida campos para valor com CPF se algum valor foi digitado.
//REmail - Valida campos para e-mail requeridos.
//RNumber - Valida campos para valor numérico requeridos.
//RRangeX:Y - Valida campos para valor numérico entre X e Y requeridos.
//RCpf - Valida campos para valor com CPF requeridos.
//############################################################################################
 
  var i=0;     //Contador de Loops do FOR
  var erro='';    //Variável com a String de Erro
  var args=vdform.arguments;  //Variável com os argumentos passados à função
  var teste='';    //Variável usada para indicar o tipo de teste a ser executado no campo atual.
  var nome='';    //Variável contendo a string a ser usada na mensagem de erro.
  var temp=0;    //Variável usada para testes das posições de @ e :
  var min=0;    //Variável contendo o mínimo do range de número
  var max=0    //Variável contendo o máximo do range de número
  var nomeform=args[0];   //Variável contendo o nome do form
  var num=0;    //Variável contendo o número para testar range
  var campoatual;
 
  campoatual="";
  for (i=1;i<(args.length-2);i+=3) {
    teste=args[i+2];
    nome=args[i+1];
    objeto=eval('document.'+nomeform+'.'+args[i]);
 
    if (objeto){
      if (objeto.value!=''){
        //TESTANDO E-MAIL NÃO REQUERIDO
        if (teste.indexOf('Email')!=-1) {
          temp=objeto.value.indexOf('@');
          if (temp<1 || temp==(objeto.value.length-1)) {
		  	campoatual=objeto;
            erro+='- O Campo '+nome+' deve conter um endereço de e-mail válido.\n';
          }
        }
 		//Testando CPF Não Requerido
        if (teste.indexOf('CPF')!=-1) {
		  mystr=objeto.value;
		  mystr=mystr.replace(".","");
  		  mystr=mystr.replace(".","");
		  mystr=mystr.replace("-","");
          temp=isCPF(mystr);
          if (!temp) {
		  	if (campoatual==""){
				campoatual=objeto;
			}
            erro+='- O Campo '+nome+' deve conter um cpf válido.\n';
          }
        }
		//Testando CNPJ Não Requerido
        if (teste.indexOf('CNPJ')!=-1) {
		  mystr=objeto.value;
          temp=VerifyCNPJ(mystr);
          if (!temp) {
		  	if (campoatual==""){
				campoatual=objeto;
			}
            erro+='- O Campo '+nome+' deve conter um cnpj válido.\n';
          }
        }
 
        //TESTANDO NÚMEROS NÃO REQUERIDO
        if (teste.indexOf('Number')!=-1) {
		  num = parseFloat(objeto.value);
          if (isNaN(num)) {
		  	if (campoatual==""){
				campoatual=objeto;
			}		  
            erro+='- O Campo '+nome+' deve conter um número.\n';
          }
        }
 
        //TESTANDO NÚMEROS ENTRE X E Y NÃO REQUERIDO
        if (teste.indexOf('Range')!=-1) {
   num = parseFloat(objeto.value);
          if (isNaN(num)) {
		  	if (campoatual==""){
				campoatual=objeto;
			}		  
            erro+='- O Campo '+nome+' deve conter um número.\n';
          }
          else{
            temp=teste.indexOf(':');
            min=teste.substring(6,temp); 
            max=teste.substring(temp+1);
            if (num<min || max<num)  {
			  	if (campoatual==""){
					campoatual=objeto;
				}			
              erro+='- O Campo '+nome+' deve conter um número entre '+min+' e '+max+' .\n';
            }
          }
        }
      }
      else {
        //TESTANDO CAMPO REQUERIDO
        if (teste.indexOf('R')==0) {
		  	if (campoatual==""){
				campoatual=objeto;
			}		
//     alert(teste.indexOf('R'));
            erro+='- O Campo '+nome+' deve ser preenchido.\n';
        }
      }
    }
  }
  if (erro) {
 	alert('O(s) seguinte(s) erro(s) ocorreu(ram):\n'+erro); //Você pode editar a frase do erro aqui.
	campoatual.focus();
  }
  document.ValorPassou = (erro=='');
}

function isNum(str)
{
      var VBlnIsNum;
      VIntTam = str.length;
      VBlnIsNum = true;
      if (VIntTam == 0)
      {
                  return false;
        }
      else
      {
                  for (i=0; i < VIntTam; i++)
                  {
                                 if (str.substring(i,i+1) < '0' || str.substring(i,i+1) >
'9')
                                 {
                                             VBlnIsNum = false;
                                 }
                   }
                     return VBlnIsNum;
      }
}

//Função de validação de CPF
function isCPF(st) {
if (st == "")
  return (false);
l = st.length;

//aleterado para se usuário não digitar os zeros na frente do CPF, completar sozinho
if ((l == 9) || (l == 8))
{
            for (i = l ; i < 10; i++)
            {
                        st = '0' + st
            }
}
l = st.length;
st2 = "";
for (i = 0; i < l; i++) {
  caracter = st.substring(i,i+1);
  if ((caracter >= '0') && (caracter <= '9'));
     st2 = st2 + caracter;
}
if ((st2.length > 11) || (st2.length < 10))
   return (false);
if (st2.length==10)
   st2 = '0' + st2;
digito1 = st2.substring(9,10);
digito2 = st2.substring(10,11);
digito1 = parseInt(digito1,10);
digito2 = parseInt(digito2,10);
sum = 0; mul = 10;
for (i = 0; i < 9 ; i++) {
    digit = st2.substring(i,i+1);
    tproduct = parseInt(digit ,10) * mul;
    sum += tproduct;
    mul--;
}
dig1 = ( sum % 11 );
if ( dig1==0 || dig1==1 )
   dig1=0;
else
  dig1 = 11 - dig1;
if (dig1!=digito1)
  return (false);
sum = 0;
mul = 11;
for (i = 0; i < 10 ; i++) {
    digit = st2.substring(i,i+1);
    tproduct = parseInt(digit ,10)*mul;
    sum += tproduct;
    mul--;
}
dig2 = (sum % 11);
if ( dig2==0 || dig2==1 )
  dig2=0;
else
  dig2 = 11 - dig2;
if (dig2 != digito2)
  return (false);
return (true);
}

function isNUMB(c)
	{
	if((cx=c.indexOf(","))!=-1)
		{		
		c = c.substring(0,cx)+"."+c.substring(cx+1);
		}
	if((parseFloat(c) / c != 1))
		{
		if(parseFloat(c) * c == 0)
			{
			return(1);
			}
		else
			{
			return(0);
			}
		}
	else
		{
		return(1);
		}
	}

function LIMP(c)
	{
	while((cx=c.indexOf("-"))!=-1)
		{		
		c = c.substring(0,cx)+c.substring(cx+1);
		}
	while((cx=c.indexOf("/"))!=-1)
		{		
		c = c.substring(0,cx)+c.substring(cx+1);
		}
	while((cx=c.indexOf(","))!=-1)
		{		
		c = c.substring(0,cx)+c.substring(cx+1);
		}
	while((cx=c.indexOf("."))!=-1)
		{		
		c = c.substring(0,cx)+c.substring(cx+1);
		}
	while((cx=c.indexOf("("))!=-1)
		{		
		c = c.substring(0,cx)+c.substring(cx+1);
		}
	while((cx=c.indexOf(")"))!=-1)
		{		
		c = c.substring(0,cx)+c.substring(cx+1);
		}
	while((cx=c.indexOf(" "))!=-1)
		{		
		c = c.substring(0,cx)+c.substring(cx+1);
		}
	return(c);
	}

function VerifyCNPJ(CNPJ)
	{
	CNPJ = LIMP(CNPJ);
	if(isNUMB(CNPJ) != 1)
		{
		return(0);
		}
	else
		{
		if(CNPJ == 0)
			{
			return(0);
			}
		else
			{
			g=CNPJ.length-2;
			if(RealTestaCNPJ(CNPJ,g) == 1)
				{
				g=CNPJ.length-1;
				if(RealTestaCNPJ(CNPJ,g) == 1)
					{	
					return(1);
					}
				else
					{
					return(0);
					}
				}
			else
				{
				return(0);
				}
			}
		}
	}
function RealTestaCNPJ(CNPJ,g)
	{
	var VerCNPJ=0;
	var ind=2;
	var tam;
	for(f=g;f>0;f--)
		{
		VerCNPJ+=parseInt(CNPJ.charAt(f-1))*ind;
		if(ind>8)
			{
			ind=2;
			}
		else
			{
			ind++;
			}
		}
		VerCNPJ%=11;
		if(VerCNPJ==0 || VerCNPJ==1)
			{
			VerCNPJ=0;
			}
		else
			{
			VerCNPJ=11-VerCNPJ;
			}
	if(VerCNPJ!=parseInt(CNPJ.charAt(g)))
		{
		return(0);
		}
	else
		{
		return(1);
		}
	}
