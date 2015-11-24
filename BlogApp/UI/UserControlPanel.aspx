<%@ Page Title="Dashboard" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="UserControlPanel.aspx.cs" Inherits="BlogApp.UI.UserControlPanel" %>
<%@ Import Namespace="BlogApp.BLL" %>
<%@ Import Namespace="BlogApp.Model" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <div id="site_title">
       <%-- <h1><strong>Welcome </strong><strong ID="userNameLabel" runat="server"></strong></h1>
     --%>    <h1><a href="#" target="_parent"><strong>Code Figher Blog</strong><span>Coding is the best way to learn Coding</span></a></h1>
    
    </div>
    <div class="dashboard">
        
        
<%--        <table style="width: 100%">
            <tr>
                <td style="text-align: right; width: 372px; height: 24px">
                    <asp:Label ID="Label1" runat="server" Text="Welcome "></asp:Label>
                </td>
                <td style="text-align: left; height: 24px; width: auto">
                    <asp:Label ID="userNameLabel" runat="server" Text=""></asp:Label>
                </td>
               
               
            </tr>
        </table>
        --%>
        
    </div>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="post_content" runat="server">


    <div> 
        <table class="post">
            <tr>
                <td style="text-align: right">
                    <asp:Button ID="createPostButton" runat="server" Text="Create Post" OnClick="createPostButton_Click"    />
                   
                </td>
            </tr>
           
        </table>
        

    </div>
   
     
        




    <%--    <div class="post_section">
        <div class="post_date">
            30<span>Nov</span>
        </div>
        <div class="post_content">

            <h2>
                <asp:Label ID="lbl1" runat="server" /></h2>
            <strong>Author:</strong> Steven | <strong>Category:</strong> <a href="#">PSD</a>, <a href="#">Templates</a>
            <p>
                <asp:Label ID="description1" runat="server" /></p>
        </div>
        <div class="cleaner"></div>
    </div>--%>
    <div id="userPost" runat="server" clientidmode="Static">
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="sidebar" runat="server">
   

</asp:Content>
