using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;

namespace Embratel.Sislab.Util
{
    public static class ConfigHelper
    {
        // Pensado para obter os parametros do WEB.CONFIG por aqui, ao invés de chamar
        // a todo instante o ConfigurationManager
        #region Propriedades
        public static string LDAP
        {
            get { return Convert.ToString(ConfigurationManager.AppSettings["LDAP"]); }
        }

        public static string Email
        {
            get { return Convert.ToString(ConfigurationManager.AppSettings["EMAIL"]); }
        }
        public static string DestinatarioEmailErro
        {
            get { return Convert.ToString(ConfigurationManager.AppSettings["DestinatarioEmailErro"]); }
        }

        #endregion

        #region Métodos
        #endregion
    }
}