using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using Embratel.Sislab.Classes;
using Embratel.Sislab.Entidades;

namespace Embratel.Sislab.Servico
{
    /// <summary>
    /// Summary description for WebService1
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    // [System.Web.Script.Services.ScriptService]
    public class Usuarios : System.Web.Services.WebService
    {
        [WebMethod]
        public string HelloWorld()
        {
            return "Hello World";
        }

        [WebMethod]
        public string ObtemUsuario(string login)
        {
            UsuariosAD ad = new UsuariosAD();

            return ad.ObtemUsuario(login);
        }
    }
}
