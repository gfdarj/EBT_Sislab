using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EmailTeste
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnEnviar_Click(object sender, EventArgs e)
        {
            try
            {
                svcSislab.UsuariosSoapClient email = new svcSislab.UsuariosSoapClient();
                String ret = email.EnviaEmail(txtRemetente.Text, txtDestinatario.Text, txtAssunto.Text, txtMensagem.Text);
                lblMensagem.Text = ret;
            }
            catch (Exception ex)
            {
                lblMensagem.Text = ex.Message;
            }
        }

        protected void txtEnviarGenerico_Click(object sender, EventArgs e)
        {
            try
            {
                
                svcSislab.UsuariosSoapClient email = new svcSislab.UsuariosSoapClient();
                String ret = email.EnviaEmailGenerico(txtSmtp.Text, txtPorta.Text, (txtSSL.Text == "T" ? true : false), txtRemetente.Text, txtSenha.Text, txtDestinatario.Text, txtAssunto.Text, txtMensagem.Text);
                lblMensagem.Text = ret;
            }
            catch (Exception ex)
            {
                lblMensagem.Text = ex.Message;
            }
        }
    }
}