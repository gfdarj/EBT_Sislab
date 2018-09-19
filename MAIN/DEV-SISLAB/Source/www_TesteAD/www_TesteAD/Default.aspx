<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="www_TesteAD.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
         <br />
        LDAP:<br />
        <asp:TextBox ID="txtLDAP" runat="server" Width="200px"></asp:TextBox>
         <br />
        Usuário:<br />
        <asp:TextBox ID="txtUsuario" runat="server" Width="200px"></asp:TextBox>
        &nbsp;<asp:Button ID="btnProcura" runat="server" OnClick="btnProcura_Click" Text="Pesquisar" />
     </div>
    </form>
</body>
</html>
