function validacaoEmail(field)
{
    //var usuario = field.value.substring(0, field.value.indexOf("@"));
    //var dominio = field.value.substring(field.value.indexOf("@") + 1, field.value.length);
    var usuario = field.substring(0, field.indexOf("@"));
    var dominio = field.substring(field.indexOf("@") + 1, field.length);

    if ((usuario.length >=1) &&
        (dominio.length >=3) && 
        (usuario.search("@")==-1) && 
        (dominio.search("@")==-1) &&
        (usuario.search(" ")==-1) && 
        (dominio.search(" ")==-1) &&
        (dominio.search(".")!=-1) &&      
        (dominio.indexOf(".") >=1)&& 
        (dominio.lastIndexOf(".") < dominio.length - 1))
    {
        //document.getElementById("msgemail").innerHTML="E-mail válido";
        //alert("E-mail valido!");
        return true;
    }
    else
    {
        //document.getElementById("msgemail").innerHTML="<font color='red'>E-mail inválido </font>";
        //alert("E-mail invalido!");
        return false;
    }
}
