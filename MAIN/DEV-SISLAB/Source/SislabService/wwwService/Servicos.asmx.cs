using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using Embratel.Sislab.Classes;

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
        public string ObtemUsuario(string login)
        {
            UsuariosAD ad = new UsuariosAD();
            string ret = "";
            try
            {
                ret = ad.ObtemUsuario(login);
            }
            catch (Exception ex)
            {
                ret = "ERRO: " + ex.Message;
            }
            return ret;
        }

        [WebMethod]
        public string ObtemUsuarioDominio(string login, string dominio)
        {
            UsuariosAD ad = new UsuariosAD();
            string ret = "";
            try
            {
                ret = ad.ObtemUsuario(login);
            }
            catch (Exception ex)
            {
                ret = "ERRO: " + ex.Message;
            }
            return ret;
        }

        [WebMethod]
        public string EnviaEmail(string remetente, string destinatario, string assunto, string mensagem)
        {
            string ret = "OK";
            try
            {
                Email email = new Email();
                email.Enviar(remetente, destinatario, assunto, mensagem);
            }
            catch (Exception ex)
            {
                ret = "ERRO: " + ex.Message;
            }
            return ret;
        }

    }
}
