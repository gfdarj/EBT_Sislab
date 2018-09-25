using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Xml;
using System.Xml.Linq;
using System.Text;
using System.Windows.Forms;
using System.DirectoryServices;

namespace TesteAD
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
            txtLDAP.Text = "10.53.22.129";
        }

        private void btnPesquisar_Click(object sender, EventArgs e)
        {
            try
            {
                // Get the currently logged in user
                //string name = Environment.UserName;
                string name = txtUsuario.Text;
                string domainContext = "";
                string domainContext_2 = "";

                if (txtLDAP.Text == "")
                {
                    // Get the currently connected LDAP context 
                    DirectoryEntry entry1 = new DirectoryEntry("LDAP://RootDSE");
                    // Use the default naming context as the connected context may not work for searches
                    domainContext = entry1.Properties["defaultNamingContext"].Value as string;
                }
                else
                {
                    domainContext = txtLDAP.Text;
                }

                DirectoryEntry entry = new DirectoryEntry("LDAP://" + domainContext + domainContext_2);
                DirectorySearcher adSearch = new DirectorySearcher(entry);

                adSearch.Filter = "(&(objectClass=user)(anr=" + name + "))";

                txtResultado.Clear();
                txtResultado.AppendText("Username: " + name + "\r\n");
                // Go through all entries from the active directory.
                foreach (SearchResult singleADUser in adSearch.FindAll())
                {
                    txtResultado.AppendText("The properties of the " + singleADUser.GetDirectoryEntry().Name + " are :" + "\r\n\r\n");
                    // Go through all the values found in the search
                    foreach (string singleAttribute in ((ResultPropertyCollection)singleADUser.Properties).PropertyNames)
                    {
                        txtResultado.AppendText(singleAttribute + " = ");
                        foreach (Object singleValue in ((ResultPropertyCollection)singleADUser.Properties)[singleAttribute])
                        {
                            txtResultado.AppendText("\t" + singleValue + "\r\n\r\n");
                        }
                    }
                }
                txtResultado.AppendText("\t\r\n*** FIM ***\r\n");
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Erro no acesso ao AD");
            }

        }

        private void btnXML_Click(object sender, EventArgs e)
        {
            XmlDocument xmldoc = new XmlDocument();
            XmlNode xmlnode = xmldoc.CreateXmlDeclaration("1.0", "UTF-8", null);
            xmldoc.AppendChild(xmlnode);

            //tag Documentos <Documentos>
            xmlnode = xmldoc.CreateElement("", "Usuario", "");

            string _ano = DateTime.Today.ToString().Substring(0, 4);
            string _mes = DateTime.Today.ToString().Substring(4, 2);
            string _dia = DateTime.Today.ToString().Substring(6, 2);

            //Elemento Data
            XmlNode xmlNodeData = xmldoc.CreateElement("Documentos", "Data", null);
            xmlNodeData.InnerText = _ano + "-" + _mes + "-" + _dia;
            xmlnode.AppendChild(xmlNodeData);

            //Elemento Chave
            XmlNode xmlNodeChave = xmldoc.CreateElement("Documentos", "Chave", null);
            xmlNodeChave.InnerText = "chave1";
            xmlnode.AppendChild(xmlNodeChave);

            //Elemento Tipo
            XmlNode xmlNodeTipo = xmldoc.CreateElement("Documentos", "Tipo", null);
            xmlNodeTipo.InnerText = "TIPO OPERAÇÃO";
            xmlnode.AppendChild(xmlNodeTipo);

            //adiciona no xml
            xmldoc.AppendChild(xmlnode);

            txtResultado.AppendText(xmldoc.OuterXml);
        }
    }
}
