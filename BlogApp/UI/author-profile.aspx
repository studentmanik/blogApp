<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="author-profile.aspx.cs" Inherits="BlogApp.UI.author_profile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
   <div id="site_title">
        <h1><a href="#" target="_parent"><strong>Code Figher Blog</strong><span>Coding is the best way to learn Coding</span></a></h1>
    </div>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="post_content" runat="server">
    
    <table style="width: 100%;">
        <tr>
            <td>Name:</td>
            <td id="name" runat="server"></td>
            
        </tr>
        <tr>
            <td>Email</td>
            <td id="email" runat="server"></td>
            
        </tr>
        
    </table>
    
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="sidebar" runat="server">
</asp:Content>
