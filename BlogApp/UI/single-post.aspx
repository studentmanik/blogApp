<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="single-post.aspx.cs" Inherits="BlogApp.UI.single_post" %>

<%@ Import Namespace="System.Drawing.Printing" %>
<%@ Import Namespace="BlogApp.BLL" %>
<%@ Import Namespace="BlogApp.Model" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

   <div id="site_title">
        <h1><a href="#" target="_parent"><strong>Code Figher Blog</strong><span>Coding is the best way to learn Coding</span></a></h1>
    </div>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="post_content" runat="server">

    <div class="post_content">
        <h2 id="postitle" runat="server"></h2>
       <div id="postcontent" runat="server"></div>

        <%string postId = Request.QueryString["id"];
          CommentManager aCommentManager=new CommentManager();
          List<Comment> aCommentList= aCommentManager.GetCommentById(postId);
          
        %>
        <div class="comment_tab"><%Response.Write(aCommentList.Count); %> Comments</div>
        <div id="comment_section">
            <ol class="comments first_level">

                <%foreach (Comment aComment in aCommentList)
                  { %>
                <li>
                    <div class="comment_box commentbox1">
                        <div class="comment_text">
                            <div class="comment_author"><a href="author-profile.aspx?id=<%Response.Write(aComment.UserId); %>"><%Response.Write(aComment.CommenterFullName); %></a>
                                
                                <span class="date"><% Response.Write(aComment.CommentCreatedDate); %></span>

                            </div>
                            <p id="comment"><%Response.Write(aComment.CommentDescreption); %></p>
                        </div>
                        <div class="cleaner"></div>
                    </div>
                </li>
                <% } %>
            </ol>


        </div>
        

                <div id="comment_form">
                    <h3>Leave a comment</h3>
                    <asp:UpdatePanel runat="server">
            <ContentTemplate>
                <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                    <div id="login" runat="server">
                        <asp:Login ID="Login1" runat="server" Style="text-align: left" OnAuthenticate="Login1_Authenticate"></asp:Login>

                    </div>
                    </ContentTemplate>
        </asp:UpdatePanel>
                    <div class="form_row">
                        <label>Your comment</label><br />
                        <textarea id="commentText" clientidmode="Static" runat="server"></textarea>
                    </div>
                    <asp:Button ID="submit" runat="server" Text="Submit" OnClick="submit_Click" />
                    
                  
                </div>
            
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="sidebar" runat="server">
</asp:Content>
