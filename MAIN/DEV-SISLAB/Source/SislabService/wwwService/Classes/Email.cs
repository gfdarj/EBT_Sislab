using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Embratel.Sislab.Entidades;
using Embratel.Sislab.Util;

namespace Embratel.Sislab.Classes
{
    public class Email
    {
        public void Enviar(EmailENT entEmail)
        {
            EMailHelper sendMail = new EMailHelper();
            sendMail.Enviar(entEmail);
        }

        public void Enviar(string remetente, string destinatario, string assunto, string mensagem)
        {
            EmailENT entEmail = new EmailENT();

            entEmail.Assunto = assunto;
            entEmail.EMailRemetente = remetente;
            entEmail.EMailDestinatario = destinatario;
            entEmail.Corpo = mensagem;

            this.Enviar(entEmail);
        }

        public void EnviarGenerico(String smtpServer, String numeroPorta, Boolean habilitarSSL, String emailRemetente, String senha, String emailDestinatario, String assunto, String mensagem)
        {
            EmailENT entEmail = new EmailENT();

            entEmail.Assunto = assunto;
            entEmail.EMailRemetente = emailRemetente;
            entEmail.EMailDestinatario = emailDestinatario;
            entEmail.Corpo = mensagem;

            EMailHelper sendMail = new EMailHelper();
            sendMail.EnviarGenerico(entEmail, smtpServer, numeroPorta, habilitarSSL, emailRemetente, senha);
        }

    }
}
