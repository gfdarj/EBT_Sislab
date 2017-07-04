<script language="JavaScript1.1">
function FormataCNPJ(Campo, teclapres){

	var tecla = teclapres.keyCode;

	var vr = new String(Campo.value);
	vr = vr.replace(".", "");
	vr = vr.replace(".", "");
	vr = vr.replace("/", "");
	vr = vr.replace("-", "");

	tam = vr.length + 1 ;

	
	if (tecla != 9 && tecla != 8){
		if (tam > 2 && tam < 6)
			Campo.value = vr.substr(0, 2) + '.' + vr.substr(2, tam);
		if (tam >= 6 && tam < 9)
			Campo.value = vr.substr(0,2) + '.' + vr.substr(2,3) + '.' + vr.substr(5,tam-5);
		if (tam >= 9 && tam < 13)
			Campo.value = vr.substr(0,2) + '.' + vr.substr(2,3) + '.' + vr.substr(5,3) + '/' + vr.substr(8,tam-8);
		if (tam >= 13 && tam < 15)
			Campo.value = vr.substr(0,2) + '.' + vr.substr(2,3) + '.' + vr.substr(5,3) + '/' + vr.substr(8,4)+ '-' + vr.substr(12,tam-12);
		}
}
</script>
<SCRIPT LANGUAGE="vbScript">
function formataMoeda(mystr)
	formataMoeda=formatCurrency(mystr,2)
end function

Function Mask(sfString,sfMask,bfMode)
Dim sfPart, i, ifContChar, sfFormated,sfFormatedi
   sfPart = ""
   sfFormated  = ""
   sfFormatedi = ""
   if not bfMode then
      for i = 1 to Len(sfMask)   
         sfPart = Mid(sfMask,i,1)
         if sfPart = "#" then
            ifContChar = ifContChar + 1 
            sfFormated = sfFormated & Mid(sfString,ifContChar,1)
         else
            sfFormated = sfFormated & sfPart
         end if
      next
   else
      i          = Len(sfMask)   
      ifContChar = Len(sfString) 
      do while ifContChar > 0 and i > 0
         sfPart = Mid(sfMask,i,1)
         if sfPart = "#" then
            sfFormatedi = sfFormatedi & Mid(sfString,ifContChar,1) 
            ifContChar  = ifContChar - 1 
         else if sfPart <> "#" then
            sfFormatedi = sfFormatedi & sfPart 
            end if
         end if
         i = i - 1
      loop

	  i = Len(sfFormatedi)
      do while i > 0
         sfFormated = sfFormated & Mid(sfFormatedi,i,1)
         i = i - 1 
      loop
   end if

   Mask = sfFormated

End Function

function formataTel(mystr)
	if mystr<>"" then
		mystraux=replace(mystr,"-","")
		if isnumeric(mystraux) then
			if len(mystraux)<=4 then
				formataTel=mystr
			end if
			if len(mystraux)>4 then
				formataTel=mask(mystraux,"####-####", true)
			end if
		else
			formataTel=mystr
		end if
	else
		formataTel=mystr
	end if
end function

function formataEmCima (mystr)
	if isnumeric(mystr) then
		mystr=removeVirgula(removePonto(mystr))
		if len(mystr)<3 then
			formataEmCima=mask(mystr,",##",true)
		end if
		if len(mystr)>=3 and len(mystr)<6 then
			formataEmCima=mask(mystr,"###,##",true)
		end if
		if len(mystr)>=6 and len(mystr)<9 then
			formataEmCima=mask(mystr,"###.###,##",true)
		end if
		if len(mystr)>=9 and len(mystr)<12 then
			formataEmCima=mask(mystr,"###.###.###,##",true)
		end if		
	end if
end function

function removeVirgula(mystr)
	removeVirgula=replace(mystr,".","")
end function

function removePonto(mystr)
	removePonto=replace(replace(mystr,".","",1,-1),",",".",1,-1)
end function
</SCRIPT>
<SCRIPT>

function FormataCpf(campo,tammax,teclapres) {
 var tecla = teclapres.keyCode;
  
 vr = event.srcElement.value;
 vr = vr.replace( "/", "" );
 vr = vr.replace( "/", "" );
 vr = vr.replace( ",", "" );
 vr = vr.replace( ".", "" );
 vr = vr.replace( ".", "" );
 vr = vr.replace( ".", "" );
 vr = vr.replace( ".", "" );
 vr = vr.replace( "-", "" );
 vr = vr.replace( "-", "" );
 vr = vr.replace( "-", "" );
 vr = vr.replace( "-", "" );
 vr = vr.replace( "-", "" );
 tam = vr.length;

 if (tam < tammax && tecla != 8){ tam = vr.length + 1 ; }

 if (tecla == 8 ){ tam = tam - 1 ; }
  
 if ( tecla == 8 || tecla >= 48 && tecla <= 57 || tecla >= 96 && tecla <= 105 ){
  if ( tam <= 2 ){ 
    event.srcElement.value = vr ; }
   if ( (tam > 2) && (tam <= 5) ){
    event.srcElement.value = vr.substr( 0, tam - 2 ) + '-' + vr.substr( tam - 2, tam ) ; }
   if ( (tam >= 6) && (tam <= 8) ){
    event.srcElement.value = vr.substr( 0, tam - 5 ) + '.' + vr.substr( tam - 5, 3 ) + '-' + vr.substr( tam - 2, tam ) ; }
   if ( (tam >= 9) && (tam <= 11) ){
    event.srcElement.value = vr.substr( 0, tam - 8 ) + '.' + vr.substr( tam - 8, 3 ) + '.' + vr.substr( tam - 5, 3 ) + '-' + vr.substr( tam - 2, tam ) ; }
   if ( (tam >= 12) && (tam <= 14) ){
    event.srcElement.value = vr.substr( 0, tam - 11 ) + '.' + vr.substr( tam - 11, 3 ) + '.' + vr.substr( tam - 8, 3 ) + '.' + vr.substr( tam - 5, 3 ) + '-' + vr.substr( tam - 2, tam ) ; }
   if ( (tam >= 15) && (tam <= 17) ){
    event.srcElement.value = vr.substr( 0, tam - 14 ) + '.' + vr.substr( tam - 14, 3 ) + '.' + vr.substr( tam - 11, 3 ) + '.' + vr.substr( tam - 8, 3 ) + '.' + vr.substr( tam - 5, 3 ) + '-' + vr.substr( tam - 2, tam ) ;}
 }  
}

function atualizaBase(){
	objrec=document.getElementById('recibosemitidos');
	objdesp=document.getElementById('despesasdolivro');
	objbase=document.getElementById('basedecalculo');
//	objimp=document.getElementById('impantes');
	
	rec=removePonto(objrec.value);
	desp=removePonto(objdesp.value);
	
	if (rec!=''){
		objrec.value=formataEmCima(objrec.value);
	}
	if (desp!=''){
		objdesp.value=formataEmCima(objdesp.value);
	}
	
	rec=removePonto(objrec.value);
	desp=removePonto(objdesp.value);

//	alert (rec);
//	alert (desp);
	
	if (objrec.value!=''&&objdesp.value!=''){
		if (!isNaN(parseInt(rec))&&!isNaN(parseInt(desp))){
		imppag=rec-desp;
		objbase.innerHTML=formataMoeda(imppag);
//			if (imppag<1058){
//				imppag=0;
//			}
//			else{
//				if (imppag<=2115) {
//					imppag=((imppag*0.15)-158.7);
//				}
//				else{
//					imppag=((imppag*0.275)-423.08);
//				}
//			}
//		objimp.innerHTML=(formataMoeda(Math.round(imppag)+1));
		}
	}
}
</SCRIPT>