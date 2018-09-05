function CPF(a) {
	
	var numero = "";
	var multipli = 0;
	var soma = 0;
	var cont = 1;
	var cont1 = 10;
	var NewCPF = ""

	for (i=0;i<a.length;i++) { 
		if (a.charAt(i) != " " && a.charAt(i) != "." && a.charAt(i) != "/" && a.charAt(i) != "-") {
			 NewCPF = NewCPF + a.charAt(i);
		}
	}
	a = NewCPF
	NewCPF = ""
	for (i=0;i<a.length;i++) { 
		if (i == 9)
				NewCPF = NewCPF + "-" + a.charAt(i);
		else
			NewCPF = NewCPF + a.charAt(i);
	}
	a = NewCPF
	if(a.length < 12) return false
	for(cont=0;cont<9;cont++) {
        numero = a.charAt(cont);
        multipli = numero * cont1;
        soma = soma + multipli;
        cont1 = cont1 - 1;
        numero = "";
	}

	soma = soma % 11;
	soma = 11 - soma;
	numero = a.charAt(10);

	if(soma > 9 ) {
		if(numero != 0) {
			return (false);
		}
	}
	else {
		if(soma != numero) {
			return (false);
		}
	}

	multipli = 0;
	soma = 0;
	cont = 1;
	cont1 = 11;

	for(cont=0;cont<11;cont++) {
		numero = a.charAt(cont);
		if(numero != "-") {
			multipli = numero * cont1;
			soma = soma + multipli;
			cont1 = cont1 - 1;
		}
        numero = "";
	}

	soma = soma % 11;
	soma = 11 - soma;
	numero = a.charAt(11);

	if(soma > 9 ) {
		if(numero != 0) {
			return (false);
		}
	}
	else {
		if(soma != numero) {
			return (false);
		}
	}
	NewCPF = "";
	for (i=0;i<a.length;i++) { 
		if (a.charAt(i) != "-") {
			 NewCPF = NewCPF + a.charAt(i);
		}
	}
	return (NewCPF);
}
