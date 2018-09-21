using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.DirectoryServices;

namespace TesteAD_www
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
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

                txtResultado.Text = "";
                txtResultado.Text += "DC: " + domainContext + "\r\n";
                txtResultado.Text += "Username: " + name + "\r\n";
                // Go through all entries from the active directory.
                foreach (SearchResult singleADUser in adSearch.FindAll())
                {
                    txtResultado.Text += "The properties of the " + singleADUser.GetDirectoryEntry().Name + " are :" + "\r\n\r\n";
                    // Go through all the values found in the search
                    foreach (string singleAttribute in ((ResultPropertyCollection)singleADUser.Properties).PropertyNames)
                    {
                        txtResultado.Text += singleAttribute + " = ";
                        foreach (Object singleValue in ((ResultPropertyCollection)singleADUser.Properties)[singleAttribute])
                        {
                            txtResultado.Text += "\t" + singleValue + "\r\n\r\n";
                        }
                    }
                }
                txtResultado.Text += "\t\r\n*** FIM ***\r\n";
            }
            catch (Exception ex)
            {
                txtResultado.Text = ex.Message;
            }

        }

        protected void TextBox2_TextChanged(object sender, EventArgs e)
        {

        }
    }
}