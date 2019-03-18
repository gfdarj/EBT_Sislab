<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="EmailTeste.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h1>TESTE DE ENVIO DE EMAIL</h1>

            Smtp server: <asp:TextBox ID="txtSmtp" runat="server" Text="smtp.gmail.com"></asp:TextBox><br />
            <br />
            Número da Porta: <asp:TextBox ID="txtPorta" runat="server" Text="587"></asp:TextBox><br />
            <br />
            Habilitar SSL: <asp:TextBox ID="txtSSL" runat="server" Text="T"></asp:TextBox><br />
            <br />
            Remetente: <asp:TextBox ID="txtRemetente" runat="server" Text="gilbertorjo@gmail.com"></asp:TextBox><br />
            <br />
            Senha: <asp:TextBox ID="txtSenha" runat="server" Text="Timbau230175c"></asp:TextBox><br />
            <br />
            Destinatario: <asp:TextBox ID="txtDestinatario" runat="server" Text="gilbertorjo@gmail.com"></asp:TextBox><br />
            <br />
            Assunto: <asp:TextBox ID="txtAssunto" runat="server" Text="Assunto do e-mail"></asp:TextBox><br />
            <br />
            Mensagem: <asp:TextBox ID="txtMensagem" Rows="5" runat="server" Text="Mensagem de Teste"></asp:TextBox><br />
            <br />
            <asp:Button ID="btnEnviar" runat="server" Text="Enviar EBT" OnClick="btnEnviar_Click" />
            &nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="txtEnviarGenerico" runat="server" Text="Enviar Genérico" OnClick="txtEnviarGenerico_Click"  />
            <br />
            <br />
            <asp:Label runat="server" ID="lblMensagem" Text="" style="color: red; font-weight: bold;"></asp:Label>
        </div>
    </form>
</body>
</html>
