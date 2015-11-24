<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ajaxlogin.aspx.cs" Inherits="BlogApp.UI.ajaxlogin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                
                <div id="buton" runat="server">
                    <asp:Login ID="Login1" runat="server" OnAuthenticate="Login1_Authenticate"></asp:Login>
                    <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
                </div>
                <asp:Button ID="Button1" runat="server" Text="Button" OnClick="Button1_Click" />
                
            </ContentTemplate>
        </asp:UpdatePanel>
    </form>
</body>
</html>
