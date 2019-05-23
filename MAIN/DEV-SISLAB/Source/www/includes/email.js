/* 
        validação de e-mail 
*/
function IsValidEmail(field)
{
    usuario = field.value.substring(0, field.value.indexOf("@"));
    dominio = field.value.substring(field.value.indexOf("@")+ 1, field.value.length);
 
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
        return true;
    }
    else
    {
        return false;
    }
}


function IsValidClaroEmail(field)
{
    var str = field.value.toLowerCase();

    if ((str.search("@claro.com.br") != -1) || (str.search("@embratel.com.br") != -1) || (str.search("@net.com.br") != -1))
    {
        //alert("1: " + str.search("@claro"));
        //alert(IsValidEmail(field));
        return IsValidEmail(field);
    }
    else
    {
        //alert("2: " + str.search("@claro"));
        return false;
    }
}