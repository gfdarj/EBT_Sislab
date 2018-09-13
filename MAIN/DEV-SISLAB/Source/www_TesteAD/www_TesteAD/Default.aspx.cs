using System;
using System.DirectoryServices; // You need to add this as reference in the project
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace www_TesteAD
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnProcura_Click(object sender, EventArgs e)
        {
            // Get the currently logged in user
            //string name = Environment.UserName;
            string name = TextBox1.Text;

            // Get the currently connected LDAP context 
            DirectoryEntry entry1 = new DirectoryEntry("LDAP://RootDSE");
            string domainContext = entry1.Properties["defaultNamingContext"].Value as string;
            // Use the default naming context as the connected context may not work for searches
            DirectoryEntry entry = new DirectoryEntry("LDAP://" + domainContext);
            DirectorySearcher adSearch = new DirectorySearcher(entry);

            adSearch.Filter = "(&(objectClass=user)(anr=" + name + "))";

            Response.Write("Username: " + name + "<br /><br />");
            // Go through all entries from the active directory.
            foreach (SearchResult singleADUser in adSearch.FindAll())
            {
                Response.Write("The properties of the " + singleADUser.GetDirectoryEntry().Name + " are :" + "<br />");
                // Go through all the values found in the search
                foreach (string singleAttribute in ((ResultPropertyCollection)singleADUser.Properties).PropertyNames)
                {
                    Response.Write(singleAttribute + " = ");
                    foreach (Object singleValue in ((ResultPropertyCollection)singleADUser.Properties)[singleAttribute])
                    {
                        Response.Write("\t" + singleValue + "<br />");
                    }
                }
            }
        }
    }
}