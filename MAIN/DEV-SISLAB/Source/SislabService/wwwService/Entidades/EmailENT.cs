using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Embratel.Sislab.Entidades
{
    public class EmailENT
    {
        public string EMailRemetente { get; set; }
        public string NomeRemetente { get; set; }
        public string EMailDestinatario { get; set; }
        public string NomeDestinatario { get; set; }
        public string EMailCopia { get; set; }
        public string Assunto { get; set; }
        public string Corpo { get; set; }
        public string CorpoHtml { get; set; }
        public byte[] ArquivoAnexo { get; set; }
        public byte[] ArquivoAnexoSecundario { get; set; }
        public string NomeArquivoAnexo { get; set; }
        public string NomeArquivoAnexoSecundario { get; set; }
    }
}
