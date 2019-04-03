using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

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

        protected void btnUpload_Click(object sender, EventArgs e)
        {
            lblMensagem.Text = "";
            try
            {
                FileStream fileStream = File.Open(txtUpload.Text, FileMode.Open, FileAccess.Read);

                /*CRIANDO E DEFININDO O TAMANHO DO OBJETO QUE VAMOS RETORNAR*/
                byte[] arquivoByte = new byte[fileStream.Length];

                /*LENDO O OBJETO STREAM E ADICIONANDO EM arquivoByte */
                fileStream.Read(arquivoByte, 0, Convert.ToInt32(fileStream.Length));

                /*FECHANDO O ARQUIVO*/
                fileStream.Close();

                svcSislab.UsuariosSoapClient upload = new svcSislab.UsuariosSoapClient();

                lblMensagem.Text = upload.UploadArquivo(null, "D:\\Backup\\" + Path.GetFileName(txtUpload.Text), arquivoByte);
            }
            catch (Exception ex)
            {
                lblMensagem.Text = ex.Message;
            }
        }
    }
}
