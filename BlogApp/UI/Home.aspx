<%@ Page Title="Home" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="BlogApp.Home" %>

<%@ Import Namespace="BlogApp.BLL" %>
<%@ Import Namespace="BlogApp.Model" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <div id="site_title">
        <h1><a href="#" target="_parent"><strong>Code Figher Blog</strong><span>Coding is the best way to learn Coding</span></a></h1>
    </div>
    <div>
        <%--<asp:TextBox ID="searchTextBox" runat="server"></asp:TextBox>
        <asp:Button ID="Button1" runat="server" Text="Search" OnClick="Button1_Click" />--%>
    </div>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="post_content" runat="server">

    <%-- <% PostManager anPostManager=new PostManager();
        List<Post> lastList= anPostManager.GetLast5Post();
        
        %>
               
          <% foreach (Post aPost in lastList)
             {
                          
                 %>
       <div class="post_section">
        <div class="post_date">
            30<span>Nov</span>
        </div>
        <div class="post_content">
             
            <h2><a href="<%Response.Write("single-post.aspx?id=" + aPost.PostId); %>"><%Response.Write(aPost.PostTitle); %></a></h2>
            <strong>Author:</strong> manik | <strong>Category:</strong> <a href="#">PSD</a>, <a href="#">Templates</a>
        <p><%Response.Write( aPost.PostDescreption ); %></p>
        </div>
        <div class="cleaner"></div>
    </div>
                
            <% } %> --%>
    <div >
        <h1 style="text-align: center">Resent Post</h1>
    </div>
    <div id="allpost" runat="server" clientidmode="Static">
        
    </div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="sidebar" runat="server">
    <h1>Most view</h1>
    <ul class="templatemo_list" id="popularpost" runat="server">
     <%--   <li id="popularpost" runat="server">
            <h6><a href="index.html"></a></h6>
            <div><strong>Author:</strong> manik <strong>view:</strong> 7 </div>
            <p> <a href="#">Read More</a> </p>
        </li>--%>
      
    </ul>

    <div class="cleaner_h40"></div>




</asp:Content>




