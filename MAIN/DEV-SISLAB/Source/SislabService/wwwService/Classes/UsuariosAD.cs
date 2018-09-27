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

            /*
            // Get the currently connected LDAP context 
            DirectoryEntry entry1 = new DirectoryEntry(ConfigHelper.LDAP);
            // Use the default naming context as the connected context may not work for searches
            string domainContext = "LDA P://" + entry1.Properties["defaultNamingContext"].Value as string;
            */

            string domainContext = ConfigHelper.LDAP;

            DirectoryEntry entry = new DirectoryEntry(domainContext);
            DirectorySearcher adSearch = new DirectorySearcher(entry);

            adSearch.Filter = "(&(objectClass=user)(anr=" + login + "))"; // "(distinguishedname=*OU=Ingegneria*)" +
            //adSearch.PropertiesToLoad.Add("mail");
            //adSearch.PropertiesToLoad.Add("displayname");

            SearchResult singleADUser = adSearch.FindOne();

            // Go through all entries from the active directory.
            if (singleADUser != null)
            {
                // Go through all the values found in the search
                ent.DN = (string)singleADUser.Properties["distinguishedName"][0];
                ent.Nome = (string)singleADUser.Properties["displayname"][0].ToString();
                try { ent.Email = (string)singleADUser.Properties["mail"][0]; } catch { ent.Email = (string)singleADUser.Properties["sAMAccountName"][0]; }

                if (ConfigHelper.Ambiente == "EMBRATEL")
                {
                    try { ent.CodigoLotacao = (string)singleADUser.Properties["embratellotacao"][0]; } catch { ent.CodigoLotacao = ""; }
                    try { ent.Diretoria = (string)singleADUser.Properties["embrateldescdsmdlotacao"][0]; } catch { ent.Diretoria = ""; }
                    try { ent.Sexo = (string)singleADUser.Properties["embratelsexo"][0]; } catch { ent.Sexo = ""; }
                    try { ent.CategoriaEmpregado = (string)singleADUser.Properties["embratelcatempregado"][0]; } catch { ent.CategoriaEmpregado = ""; }
                    try { ent.DataAdmissao = (string)singleADUser.Properties["embrateladmissao"][0]; } catch { ent.DataAdmissao = ""; }
                    try { ent.AreaLotacao = (string)singleADUser.Properties["embratelarealotacao"][0]; } catch { ent.AreaLotacao = ""; }
                    try { ent.CategoriaCargo = (string)singleADUser.Properties["embratelcatcargo"][0]; } catch { ent.CategoriaCargo = ""; }
                    try { ent.Lotacao = (string)singleADUser.Properties["embrateldesclotacao"][0]; } catch { ent.Lotacao = ""; }
                    try { ent.Matricula = (string)singleADUser.Properties["employeeid"][0]; } catch { ent.Matricula = ""; }
                    try { ent.DataNascimento = (string)singleADUser.Properties["embrateldatanasc"][0]; } catch { ent.DataNascimento = ""; }
                    try { ent.Empresa = (string)singleADUser.Properties["company"][0]; } catch { ent.Empresa = ""; }
                    try { ent.Telefone = (string)singleADUser.Properties["telephonenumber"][0]; } catch { ent.Telefone = ""; }
                    try { ent.Celular = (string)singleADUser.Properties["mobile"][0]; } catch { ent.Celular = ""; }
                }
                else
                {
                    ent.CodigoLotacao = ""; ent.Diretoria = "";  ent.Sexo = ""; ent.CategoriaEmpregado = ""; 
                    ent.DataAdmissao = ""; ent.AreaLotacao = ""; ent.CategoriaCargo = ""; ent.Lotacao = ""; 
                    ent.Matricula = ""; ent.DataNascimento = ""; ent.Empresa = ""; ent.Telefone = ""; ent.Celular = "";
                }
            }

            return ent;
        }

        private string GeraXML(UsuarioENT ent)
        {
            XmlDocument xmldoc = new XmlDocument();

            //COM O CABEÇALHO XML
            XmlNode xmlnode = xmldoc.CreateXmlDeclaration("1.0", "UTF-8", null);  //coloca o cabeçalho do XML
            xmldoc.AppendChild(xmlnode);

            //SEM O CABEÇALHO XML
            //XmlNode xmlnode;   //retira o cabeçalho

            //tag Documentos <Documentos>
            xmlnode = xmldoc.CreateElement("", "Usuario", "");

            //Elemento DN
            XmlNode xmlNodeDN = xmldoc.CreateElement("Dados", "DN", null);
            xmlNodeDN.InnerText = ent.DN;
            xmlnode.AppendChild(xmlNodeDN);

            //Elemento Email
            XmlNode xmlNodeEmail = xmldoc.CreateElement("Dados", "Email", null);
            xmlNodeEmail.InnerText = ent.Email;
            xmlnode.AppendChild(xmlNodeEmail);

            //Elemento Nome
            XmlNode xmlNodeNome = xmldoc.CreateElement("Dados", "Nome", null);
            xmlNodeNome.InnerText = ent.Nome;
            xmlnode.AppendChild(xmlNodeNome);

            XmlNode xmlNodeCodigoLotacao = xmldoc.CreateElement("Dados", "CodigoLotacao", null);
            xmlNodeCodigoLotacao.InnerText = ent.CodigoLotacao;
            xmlnode.AppendChild(xmlNodeCodigoLotacao);

            XmlNode xmlNodeDepartamento = xmldoc.CreateElement("Dados", "Departamento", null);
            xmlNodeDepartamento.InnerText = ent.Departamento;
            xmlnode.AppendChild(xmlNodeDepartamento);

            XmlNode xmlNodeDiretoria = xmldoc.CreateElement("Dados", "Diretoria", null);
            xmlNodeDiretoria.InnerText = ent.Diretoria;
            xmlnode.AppendChild(xmlNodeDiretoria);

            XmlNode xmlNodeSexo = xmldoc.CreateElement("Dados", "Sexo", null);
            xmlNodeSexo.InnerText = ent.Sexo;
            xmlnode.AppendChild(xmlNodeSexo);

            XmlNode xmlNodeCategoriaEmpregado = xmldoc.CreateElement("Dados", "CategoriaEmpregado", null);
            xmlNodeCategoriaEmpregado.InnerText = ent.CategoriaEmpregado;
            xmlnode.AppendChild(xmlNodeCategoriaEmpregado);

            XmlNode xmlNodeDataAdmissao = xmldoc.CreateElement("Dados", "DataAdmissao", null);
            xmlNodeDataAdmissao.InnerText = ent.DataAdmissao;
            xmlnode.AppendChild(xmlNodeDataAdmissao);

            XmlNode xmlNodeAreaLotacao = xmldoc.CreateElement("Dados", "AreaLotacao", null);
            xmlNodeAreaLotacao.InnerText = ent.AreaLotacao;
            xmlnode.AppendChild(xmlNodeAreaLotacao);

            XmlNode xmlNodeCategoriaCargo = xmldoc.CreateElement("Dados", "CategoriaCargo", null);
            xmlNodeCategoriaCargo.InnerText = ent.CategoriaCargo;
            xmlnode.AppendChild(xmlNodeCategoriaCargo);

            XmlNode xmlNodeLotacao = xmldoc.CreateElement("Dados", "Lotacao", null);
            xmlNodeLotacao.InnerText = ent.Lotacao;
            xmlnode.AppendChild(xmlNodeLotacao);

            XmlNode xmlNodeMatricula = xmldoc.CreateElement("Dados", "Matricula", null);
            xmlNodeMatricula.InnerText = ent.Matricula;
            xmlnode.AppendChild(xmlNodeMatricula);

            XmlNode xmlNodeDataNascimento = xmldoc.CreateElement("Dados", "DataNascimento", null);
            xmlNodeDataNascimento.InnerText = ent.DataNascimento;
            xmlnode.AppendChild(xmlNodeDataNascimento);

            XmlNode xmlNodeEmpresa = xmldoc.CreateElement("Dados", "Empresa", null);
            xmlNodeEmpresa.InnerText = ent.Empresa;
            xmlnode.AppendChild(xmlNodeEmpresa);

            XmlNode xmlNodeTelefone = xmldoc.CreateElement("Dados", "Telefone", null);
            xmlNodeTelefone.InnerText = ent.Telefone;
            xmlnode.AppendChild(xmlNodeTelefone);

            XmlNode xmlNodeCelular = xmldoc.CreateElement("Dados", "Celular", null);
            xmlNodeCelular.InnerText = ent.Celular;
            xmlnode.AppendChild(xmlNodeCelular);

            //adiciona no xml
            xmldoc.AppendChild(xmlnode);

            return xmldoc.OuterXml;
        }
    }
}



