<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="TesteAD_www.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <br />
            <asp:Label ID="Label1" runat="server" Text="Usuário"></asp:Label>
            <br />
            <asp:TextBox ID="txtUsuario" runat="server"></asp:TextBox>
            <br />
            <br />
            <asp:Label ID="Label2" runat="server" Text="LDAP"></asp:Label>
            <br />
            <asp:TextBox ID="txtLDAP" runat="server"></asp:TextBox>
            <br />
            <br />
            <br />
            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="PESQUISAR NO AD" />
            <br />
            <br />
            <br />
            <asp:TextBox ID="txtResultado" runat="server" Height="153px" OnTextChanged="TextBox2_TextChanged" TextMode="MultiLine" Width="680px"></asp:TextBox>
            <br />
            <br />
        </div>
    </form>
</body>
</html>
