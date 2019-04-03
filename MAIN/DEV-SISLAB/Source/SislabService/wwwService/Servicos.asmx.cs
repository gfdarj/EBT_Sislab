using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO;
using System.Web.Services;
using System.Configuration;
using Embratel.Sislab.Classes;

namespace Embratel.Sislab.Servico
{
    /// <summary>
    /// Summary description for WebService1
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    // [System.Web.Script.Services.ScriptService]
    public class Usuarios : System.Web.Services.WebService
    {
        [WebMethod]
        public string ObtemUsuario(string login, string dominio)
        {
            UsuariosAD ad = new UsuariosAD();
            string ret = "";
            try
            {
                ret = ad.ObtemUsuario(login);
            }
            catch (Exception ex)
            {
                ret = "ERRO[ObtemUsuario]: " + ex.Message;
            }
            return ret;
        }

        [WebMethod]
        public string EnviaEmail(string remetente, string destinatario, string assunto, string mensagem)
        {
            string ret = "OK";
            try
            {
                Email email = new Email();
                email.Enviar(remetente, destinatario, assunto, mensagem);
            }
            catch (Exception ex)
            {
                ret = "ERRO[EnviaEmail]: " + ex.Message;
            }
            return ret;
        }

        [WebMethod]
        public string EnviaEmailGenerico(String smtpServer, String numeroPorta, Boolean habilitarSSL, String remetente, String senha, String destinatario, String assunto, String mensagem)
        {
            string ret = "OK";
            try
            {
                Email email = new Email();
                email.EnviarGenerico(smtpServer, numeroPorta, habilitarSSL, remetente, senha, destinatario, assunto, mensagem);
            }
            catch (Exception ex)
            {
                ret = "ERRO[EnviaEmailGenerico]: " + ex.Message;
            }
            return ret;
        }

        [WebMethod]
        public string UploadArquivo(string numeroAS, string nomeDoArquivo, byte[] arquivoByte)
        {
            string ret = "OK";
            try
            {
                String path = Path.GetDirectoryName(nomeDoArquivo);
                //ret = path;

                if (!Directory.Exists(path))
                {
                    Directory.CreateDirectory(path);
                }

                /*CRIANDO UM NOVO ARQUIVO E SALVANDO NO DIRETÓRIO ARQUIVOS*/
                File.WriteAllBytes(nomeDoArquivo, arquivoByte);
            }
            catch (Exception ex)
            {
                ret = ex.Message;
            }
            return ret;
        }

        [WebMethod]
        public byte[] DownloadArquivo(string nomeDoArquivo)
        {
            /*PEGA O CAMINHO DO ARQUIVO*/
            String arquivo = nomeDoArquivo;

            /*ACESSANDO O ARQUIVO*/
            FileStream fileStream = File.Open(arquivo, FileMode.Open, FileAccess.Read);

            /*CRIANDO E DEFININDO O TAMANHO DO OBJETO QUE VAMOS RETORNAR*/
            byte[] arquivoByte = new byte[fileStream.Length];

            /*LENDO O OBJETO STREAM E ADICIONANDO EM arquivoByte */
            fileStream.Read(arquivoByte, 0, Convert.ToInt32(fileStream.Length));

            /*FECHANDO O ARQUIVO*/
            fileStream.Close();

            return arquivoByte;
        }
    }
}
