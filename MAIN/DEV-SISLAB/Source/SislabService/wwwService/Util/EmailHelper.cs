using System;
using System.IO;
using System.Collections.Generic;
using System.Text;
using System.Linq;
using System.Net.Mail;
using System.Net.Configuration;
using System.Configuration;
using System.Runtime.Serialization;
using System.Runtime.Serialization.Formatters.Binary;
using Embratel.Sislab.Entidades;

namespace Embratel.Sislab.Util
{
    public class EMailHelper : MailMessage
    {
        #region Atributos

        private SmtpClient clientSmtp = new SmtpClient();
        private string emailRemetente;
        private string nomeRemetente;
        private string senha;
        private bool habilitarSSL;
        private int? numeroPorta;

        #endregion

        #region Propriedades

        public string EMailRemetente
        {
            get { return emailRemetente; }
            set { emailRemetente = value; }
        }

        public string NomeRemetente
        {
            get { return nomeRemetente; }
            set { nomeRemetente = value; }
        }

        public string Senha
        {
            get { return senha; }
            set { senha = value; }
        }

        public string Assunto
        {
            get { return this.Subject.ToString(); }
            set { this.Subject = value; }
        }

        public MailPriority Prioridade
        {
            set { this.Priority = value; }
        }

        public bool CorpoEmHtml
        {
            set { this.IsBodyHtml = value; }
        }

        public string Corpo
        {
            set { this.Body = value; }
        }

        public bool HabilitarSSL
        {
            get { return habilitarSSL; }
            set { habilitarSSL = value; }
        }

        public int? NumeroPorta
        {
            get { return numeroPorta; }
            set { numeroPorta = value; }
        }

        #endregion

        #region Métodos Públicos

        public EMailHelper()
        {
            InciarConfiguracao();
            CarregarSmtp();
        }

        public bool Enviar()
        {
            try
            {
                //Remetente
                this.From = new MailAddress(emailRemetente, nomeRemetente, System.Text.Encoding.UTF8);

                //Enviar
                clientSmtp.Send(this);

                return true;
            }
            catch (SmtpException se)
            {
                throw new SmtpException("Erro ao enviar o email", se);
            }
            catch (Exception ex)
            {
                throw new Exception("Falha ao enviar o email", ex);
            }
        }

        public bool Enviar(EmailENT entEmail)
        {
            return Enviar(entEmail, true);
        }

        public bool Enviar(EmailENT entEmail, bool salvarEmailComfirmacao)
        {
            try
            {
                //Adiciona o Remetente
                this.From = new MailAddress(entEmail.EMailRemetente, entEmail.NomeRemetente, System.Text.Encoding.UTF8);

                //Adiciona os destinatários
                if (string.IsNullOrEmpty(entEmail.EMailDestinatario))
                    throw new Exception("E-Mail não pode ser enviado. Informe um e-mail de destino.");

                bool bGravaEmail;
                string[] destinatario = entEmail.EMailDestinatario.Split(new char[] { ',' });
                for (int i = 0; i < destinatario.Length; i++)
                {
                    bGravaEmail = true;
                    foreach (MailAddress emailTo in this.To)
                    {
                        if (emailTo.Address == destinatario[i])
                            bGravaEmail = false;
                    }
                    if (bGravaEmail)
                        this.To.Add(destinatario[i]);
                }

                //Adicionar os e-mails de cópia
                if (!string.IsNullOrEmpty(entEmail.EMailCopia))
                {
                    string[] copia = entEmail.EMailCopia.Split(new char[] { ',' });

                    for (int i = 0; i < copia.Length; i++)
                        this.Bcc.Add(copia[i]);  //this.CC.Add(copia[i]);
                }

                //Assunto
                this.Subject = entEmail.Assunto;

                //Corpo
                if (entEmail.CorpoHtml != null)
                {
                    this.Body = entEmail.CorpoHtml;
                    this.IsBodyHtml = true;
                }
                else
                {
                    this.Body = entEmail.Corpo;
                    this.IsBodyHtml = false;
                }

                //Anexo
                if (entEmail.ArquivoAnexo != null && entEmail.ArquivoAnexo.Length > 0)
                {
                    MemoryStream ms = new MemoryStream(entEmail.ArquivoAnexo);
                    Attachment anexo = new Attachment(ms, entEmail.NomeArquivoAnexo);
                    this.Attachments.Add(anexo);
                }

                //Anexo Secundário
                if (entEmail.ArquivoAnexoSecundario != null && entEmail.ArquivoAnexoSecundario.Length > 0)
                {
                    MemoryStream ms = new MemoryStream(entEmail.ArquivoAnexoSecundario);
                    Attachment anexoSecundario = new Attachment(ms, entEmail.NomeArquivoAnexoSecundario);
                    this.Attachments.Add(anexoSecundario);
                }


                //SalvarEmailComfirmacao
                if (salvarEmailComfirmacao)
                {
                    //SalvarEmailConfirmacao(entEmail);
                }

                //Enviar
                clientSmtp.Send(this);

                return true;
            }
            catch (SmtpException se)
            {
                throw new SmtpException(se.Message, se);
            }
        }

        public void EnviaErro(Exception ex)
        {
            try
            {
                EmailENT entEmail = new EmailENT();

                entEmail.Assunto = "[SISLAB] - ERRO";
                entEmail.EMailRemetente = ConfigHelper.Email;
                entEmail.EMailDestinatario = ConfigHelper.DestinatarioEmailErro;
                entEmail.Corpo = ex.Message;

                EMailHelper sendMail = new EMailHelper();
                sendMail.Enviar(entEmail);
            }
            catch (SmtpException se)
            {
                throw new SmtpException("Erro ao enviar o email " + se.Message, se);
            }
        }

        public void AdicionarDestinatario(string enderecoEMail)
        {
            this.To.Add(enderecoEMail);
        }

        public void AdicionarCopia(string enderecoEMail)
        {
            this.CC.Add(enderecoEMail);
        }

        #endregion

        #region Métodos Privados

        private void InciarConfiguracao()
        {
            this.SubjectEncoding = Encoding.GetEncoding("utf-8");
            this.BodyEncoding = Encoding.GetEncoding("utf-8");
        }

        private void CarregarSmtp()
        {
            //Servidor SMTP
            string smtp = Convert.ToString(ConfigurationManager.AppSettings["smtpServer"]);

            if (smtp != null)
            {
                clientSmtp.Host = smtp;

                //Porta de Segurança
                if (numeroPorta != null)
                    clientSmtp.Port = Convert.ToInt32(numeroPorta);
                else if (ConfigurationManager.AppSettings["numberPort"] != null &&
                         !string.IsNullOrEmpty(ConfigurationManager.AppSettings["numberPort"].ToString()))
                    clientSmtp.Port = Convert.ToInt32(ConfigurationManager.AppSettings["numberPort"].ToString());

                //SSL
                if (ConfigurationManager.AppSettings["enableSSL"] != null &&
                    !string.IsNullOrEmpty(ConfigurationManager.AppSettings["enableSSL"].ToString()))
                    clientSmtp.EnableSsl = Convert.ToBoolean(ConfigurationManager.AppSettings["enableSSL"].ToString());
                else
                    clientSmtp.EnableSsl = habilitarSSL;

                //Credencial
                if (!string.IsNullOrEmpty(senha))
                    clientSmtp.Credentials = new System.Net.NetworkCredential(emailRemetente, senha);
                else if ((ConfigurationManager.AppSettings["emailRemetente"] != null &&
                          !string.IsNullOrEmpty(ConfigurationManager.AppSettings["emailRemetente"].ToString())) &&
                         (ConfigurationManager.AppSettings["credencial"] != null &&
                          !string.IsNullOrEmpty(ConfigurationManager.AppSettings["credencial"].ToString())))
                    clientSmtp.Credentials = new System.Net.NetworkCredential(ConfigurationManager.AppSettings["emailRemetente"].ToString(),
                                                                              ConfigurationManager.AppSettings["credencial"].ToString());
            }
        }

        public byte[] ObjetoparaByteArray(EmailENT entEmail)
        {
            if (entEmail == null)
                return null;
            BinaryFormatter bf = new BinaryFormatter();
            MemoryStream ms = new MemoryStream();
            bf.Serialize(ms, entEmail);

            return ms.ToArray();
        }

        public EmailENT ByteArrayParaObjeto(byte[] arrBytes)
        {
            MemoryStream memStream = new MemoryStream();
            BinaryFormatter binForm = new BinaryFormatter();
            memStream.Write(arrBytes, 0, arrBytes.Length);
            memStream.Seek(0, SeekOrigin.Begin);
            EmailENT obj = (EmailENT)binForm.Deserialize(memStream);
            return obj;
        }

        #endregion

    }
}
