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
            Remetente: <asp:TextBox ID="txtRemetente" runat="server" Text="ilab@embratel.com.br"></asp:TextBox><br />
            <br />
            Destinatario: <asp:TextBox ID="txtDestinatario" runat="server" Text="gilbertorjo@gmail.com"></asp:TextBox><br />
            <br />
            Assunto: <asp:TextBox ID="txtAssunto" runat="server" Text="Assunto do e-mail"></asp:TextBox><br />
            <br />
            Mensagem: <asp:TextBox ID="txtMensagem" Rows="5" runat="server" Text="Mensagem de Teste"></asp:TextBox><br />
            <br />
            <asp:Button ID="btnEnviar" runat="server" Text="Button" OnClick="btnEnviar_Click" />
            <br />
            <br />
            <asp:Label runat="server" ID="lblMensagem" Text=""></asp:Label>
        </div>
    </form>
</body>
</html>
