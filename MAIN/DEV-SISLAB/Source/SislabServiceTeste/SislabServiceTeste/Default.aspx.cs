using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SislabServiceTeste;

namespace SislabServiceTeste
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Label1.Text = "";
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            var cliente = new UsuarioSvc.UsuariosSoapClient();

            Label1.Text = cliente.ObtemUsuarioTeste();
        }
    }
}