using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
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
    }
}
