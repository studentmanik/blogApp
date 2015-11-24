<%@ Page Title="Login" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="LoginPage.aspx.cs" Inherits="BlogApp.UI.LoginPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <div id="site_title">
        <h1><a href="#" target="_parent"><strong>Code Figher Blog</strong><span>Coding is the best way to learn Coding</span></a></h1>
    </div>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="post_content" runat="server">
    
    <asp:Login ID="Login1" runat="server" Height="143px" OnAuthenticate="Login1_Authenticate" Width="253px"></asp:Login>
    
</asp:Content>
