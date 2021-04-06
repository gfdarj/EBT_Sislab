using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections.Specialized;
using SislabServiceTeste;

namespace SislabServiceTeste
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Label1.Text = "";
            lblAviso.Text = "";

            NameValueCollection colecao;
            colecao = Request.ServerVariables;
            string remoteUser = colecao.GetValues("REMOTE_USER").ToString();
            if (remoteUser == null)
                lblRemoteUser.Text = "--";
            else
                lblRemoteUser.Text = remoteUser;
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            lblAviso.Text = "";

            var cliente = new UsuarioSvc.UsuariosSoapClient();
            Label1.Text = cliente.ObtemUsuarioTeste();

            lblAviso.Text = "pronto!";
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            lblAviso.Text = "";

            var cliente = new UsuarioSvc.UsuariosSoapClient();
            Label1.Text = cliente.ObtemUsuario(txtUsuario.Text, txtDominio.Text);

            lblAviso.Text = "pronto!";
        }

    }
}