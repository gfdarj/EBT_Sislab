var myCarrosselIndex = 0;

function carrossel(className, intervalo)
{
    var i;
    var x = document.getElementsByClassName(className);
    for (i = 0; i < x.length; i++) {
        x[i].style.display = "none";
    }
    myCarrosselIndex++;
    if (myCarrosselIndex > x.length) { myCarrosselIndex = 1 }
    x[myCarrosselIndex - 1].style.display = "block";
    setTimeout(carrossel, intervalo); // Change image every 2 seconds
    alert(myCarrosselIndex);
}
