using System;
using System.Collections.Generic;
using System.Linq;
using System.Xml;
using System.Xml.Linq;
using System.Web;
using System.DirectoryServices;
using Embratel.Sislab.Entidades;
using Embratel.Sislab.Util;

namespace Embratel.Sislab.Classes
{
    public class UsuariosAD
    {
        public string ObtemUsuario(string login)
        {
            return GeraXML(BuscaDadosAD(login));
        }

        private UsuarioENT BuscaDadosAD(string login)
        {
            UsuarioENT ent = new UsuarioENT();

            // Get the currently connected LDAP context 
            DirectoryEntry entry1 = new DirectoryEntry(ConfigHelper.LDAP);
            // Use the default naming context as the connected context may not work for searches
            string domainContext = entry1.Properties["defaultNamingContext"].Value as string;

            DirectoryEntry entry = new DirectoryEntry("LDAP://" + domainContext);
            DirectorySearcher adSearch = new DirectorySearcher(entry);

            adSearch.Filter = "(&(objectClass=user)(anr=" + login + "))";
            //adSearch.PropertiesToLoad.Add("mail");
            //adSearch.PropertiesToLoad.Add("displayname");

            SearchResult singleADUser = adSearch.FindOne();


            // Go through all entries from the active directory.
            if (singleADUser != null)
            {
                // Go through all the values found in the search
                ent.DN = (string)singleADUser.Properties["distinguishedName"][0];
                ent.Email = (string)singleADUser.Properties["mail"][0];
                ent.Nome = (string)singleADUser.Properties["displayname"][0].ToString();

                /*                ent.CodigoLotacao = ((ResultPropertyCollection)singleADUser.Properties)["embratellotacao"].ToString();
                                ent.Departamento = ((ResultPropertyCollection)singleADUser.Properties)["department"].ToString();
                                ent.Diretoria = ((ResultPropertyCollection)singleADUser.Properties)["embrateldescdsmdlotacao"].ToString();
                                ent.Sexo = ((ResultPropertyCollection)singleADUser.Properties)["embratelsexo"].ToString();
                                ent.CategoriaEmpregado = ((ResultPropertyCollection)singleADUser.Properties)["embratelcatempregado"].ToString();
                                ent.DataAdmissao = ((ResultPropertyCollection)singleADUser.Properties)["embrateladmissao"].ToString();
                                ent.AreaLotacao = ((ResultPropertyCollection)singleADUser.Properties)["embratelarealotacao"].ToString();
                                ent.CategoriaCargo = ((ResultPropertyCollection)singleADUser.Properties)["embratelcatcargo"].ToString();
                                ent.Lotacao = ((ResultPropertyCollection)singleADUser.Properties)["embrateldesclotacao"].ToString();
                                ent.Matricula = ((ResultPropertyCollection)singleADUser.Properties)["employeeid"].ToString();
                                ent.DataNascimento = ((ResultPropertyCollection)singleADUser.Properties)["embrateldatanasc"].ToString();
                                ent.Empresa = ((ResultPropertyCollection)singleADUser.Properties)["company"].ToString();
                                ent.Telefone = ((ResultPropertyCollection)singleADUser.Properties)["telephonenumber"].ToString();
                                ent.Celular = ((ResultPropertyCollection)singleADUser.Properties)["mobile"].ToString();
                */
            }

            return ent;
        }

        private string GeraXML(UsuarioENT ent)
        {
            XmlDocument xmldoc = new XmlDocument();
            XmlNode xmlnode = xmldoc.CreateXmlDeclaration("1.0", "UTF-8", null);
            xmldoc.AppendChild(xmlnode);
            //XmlNode xmlnode;   //retira o cabeçalho

            //tag Documentos <Documentos>
            xmlnode = xmldoc.CreateElement("", "Usuario", "");

            //Elemento Data
            XmlNode xmlNodeDN = xmldoc.CreateElement("Documentos", "DN", null);
            xmlNodeDN.InnerText = ent.DN;
            xmlnode.AppendChild(xmlNodeDN);

            //Elemento Chave
            XmlNode xmlNodeEmail = xmldoc.CreateElement("Documentos", "Email", null);
            xmlNodeEmail.InnerText = ent.Email;
            xmlnode.AppendChild(xmlNodeEmail);

            //Elemento Tipo
            XmlNode xmlNodeNome = xmldoc.CreateElement("Documentos", "Nome", null);
            xmlNodeNome.InnerText = ent.Nome;
            xmlnode.AppendChild(xmlNodeNome);
/*
            //Elemento Tipo
            XmlNode xmlNodeTipo = xmldoc.CreateElement("Documentos", "Nome", null);
            xmlNodeTipo.InnerText = ent.Nome;
            xmlnode.AppendChild(xmlNodeTipo);

            //Elemento Tipo
            XmlNode xmlNodeTipo = xmldoc.CreateElement("Documentos", "Nome", null);
            xmlNodeTipo.InnerText = ent.Nome;
            xmlnode.AppendChild(xmlNodeTipo);

            //Elemento Tipo
            XmlNode xmlNodeTipo = xmldoc.CreateElement("Documentos", "Nome", null);
            xmlNodeTipo.InnerText = ent.Nome;
            xmlnode.AppendChild(xmlNodeTipo);

            //Elemento Tipo
            XmlNode xmlNodeTipo = xmldoc.CreateElement("Documentos", "Nome", null);
            xmlNodeTipo.InnerText = ent.Nome;
            xmlnode.AppendChild(xmlNodeTipo);
*/
            //adiciona no xml
            xmldoc.AppendChild(xmlnode);

            return xmldoc.OuterXml;
        }
    }
}



