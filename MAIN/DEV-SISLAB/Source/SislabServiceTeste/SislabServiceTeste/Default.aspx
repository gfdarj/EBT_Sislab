<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="SislabServiceTeste.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            TESTE<br />
            <br />
            Usuário remoto:
            <asp:Label ID="lblRemoteUser" runat="server" Text="Label"></asp:Label>
            <br />
            <br />
            Usuário:
            <asp:TextBox ID="txtUsuario" runat="server"></asp:TextBox>
            <br />
            <br />
            Domínio:
            <asp:TextBox ID="txtDominio" runat="server"></asp:TextBox>
            <br />
            <br />
            <asp:Label ID="lblAviso" runat="server" ForeColor="Red" Text="Label"></asp:Label>
            <br />
            <br />
            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Executa ObtemUsuarioTeste" />
            <br />
            <br />
            <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="Executa ObtemUsuario" />
            <br />
            <br />
            <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
        </div>
    </form>
</body>
</html>
