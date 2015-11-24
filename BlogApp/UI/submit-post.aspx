<%@ Page Title="Post" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="submit-post.aspx.cs" Inherits="BlogApp.UI.submit_post"  ValidateRequest="false" Debug="false" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <div id="site_title">
        <h1><a href="#" target="_parent"><strong>Code Figher Blog</strong><span>Coding is the best way to learn Coding</span></a></h1>
    </div>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="post_content" runat="server">
    
     <div id="comment_form" style="text-align: left">
         <h2 style="color: red" id="msg" runat="server"></h2>
            <h3>Submit a Post</h3>

           
                <div class="form_row">
                    <label style="text-align: left">Title ( Required )</label>&nbsp;
                    <asp:TextBox ID="titleTexbox" runat="server"></asp:TextBox>
                </div>
                
                <div class="form_row">
                    <label>Write a Post</label><br />
                    
                  <textarea  ClientIDMode="Static" id="edit" validateRequest="false" runat="server" name="content" ></textarea>
                </div>
         <div class="form_row">
             
             <div id="result" runat="server"></div>
         </div>
                <asp:DropDownList ID="DropDownList1" runat="server">
                    <asp:ListItem Selected="True">Select</asp:ListItem>
                    <asp:ListItem Value="true">Published</asp:ListItem>
                    <asp:ListItem Value="false">Unpublished</asp:ListItem>
                </asp:DropDownList>
                &nbsp;<!-- Include jQuery. --><script src="http://code.jquery.com/jquery-1.11.0.js"></script><!-- Include JS files. --><%-- <script src="../js/froala_editor.min.js"></script>--%><script src="../editor/js/froala_editor.min.js"></script><!-- Include IE8 JS. --><!--[if lt IE 9]><script src="../editor/js/froala_editor_ie8.min.js"></script><![endif]--><script src="../editor/js/plugins/colors.min.js"></script><script src="../editor/js/plugins/block_styles.min.js"></script><script src="../editor/js/plugins/char_counter.min.js"></script><script src="../editor/js/plugins/entities.min.js"></script><script src="../editor/js/plugins/file_upload.min.js"></script><script src="../editor/js/plugins/font_family.min.js"></script><script src="../editor/js/plugins/font_size.min.js"></script><script src="../editor/js/plugins/fullscreen.min.js"></script><script src="../editor/js/plugins/inline_styles.min.js"></script><script src="../editor/js/plugins/lists.min.js"></script><script src="../editor/js/plugins/media_manager.min.js"></script><script src="../editor/js/plugins/tables.min.js"></script><script src="../editor/js/plugins/urls.min.js"></script><script src="../editor/js/plugins/video.min.js"></script><!-- Initialize the editor. -->
      <script>
          $(function () {
              $('#edit').editable({
                  inlineMode: false,height: 300,alwaysBlank: true, imageButtons: ['floatImageLeft', 'floatImageNone', 'floatImageRight', 'linkImage', 'info', 'removeImage'], customImageButtons: {
                      info: {
                          title: 'Image source',
                          icon: {
                              type: 'font',
                              value: 'fa fa-info'
                          },
                          callback: function ($img) {
                              alert($img.attr('src'));
                          },
                          refresh: function ($img) {
                              console.log('Refresh image button');
                              console.log($img);
                          }
                      }
                  }
              })
          });
  </script>
          <script>
              $(document).ready(function () {
                  $("#forn1").validate({
                      rules: {
                          titleTexbox: "required",
                          edit: {
                              required: true,
                              
                          },
                         
                      },
                    
                  });
                 
                 
              });
    </script>
         <%--   
         <script>
      $(function () {
          $('#edit').editable({ inlineMode: false  });
      });
  </script>--%>
         <asp:Button ID="savebutton" runat="server" OnClick="Button1_Click" Text="Save" />
      
        </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="sidebar" runat="server">
</asp:Content>
