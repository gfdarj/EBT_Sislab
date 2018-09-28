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

            Enviar(entEmail);
        }

    }
}
