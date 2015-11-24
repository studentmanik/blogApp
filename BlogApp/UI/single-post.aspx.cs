using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BlogApp.BLL;
using BlogApp.Model;

namespace BlogApp.UI
{
    public partial class single_post : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                User aUser = (User)Session["aUser"];
                string id = Request.QueryString["id"];
                PostManager anPostManager=new PostManager();
                Post anPost= anPostManager.GetPostById(id);
                string edit="";
                postitle.InnerHtml = anPost.PostTitle;
                if (aUser!=null && aUser.UserId==anPost.userId)
                {
                    edit = "<a href='submit-post.aspx?id=" + anPost.PostId + "'>  Edit</a>";
                }
                string postdes = "<strong>Author:</strong><a href='author-profile.aspx?id=" + anPost.userId + "'>" + anPost.UserFullName + "</a>|<strong>Post View: </strong>" + anPost.ViewCount + " " + edit + "  <p>" + anPost.PostDescreption + "</p>";

                postcontent.InnerHtml = postdes;
                if (Session["aUser"] != null)
                {
                    

                    Login1.Visible = false;
                    login.InnerText = "Hi " + aUser.UserFullName;
                }

            }
            
       
                
           
        }

        protected void submit_Click(object sender, EventArgs e)
        {User aUser = (User)Session["aUser"];
          
            if (aUser != null)
            {
               Comment anComment=new Comment();

                anComment.PostId = Convert.ToInt32(Request.QueryString["id"]);
                anComment.UserId = aUser.UserId;
                anComment.CommentDescreption = commentText.InnerText;
                
                CommentManager anCommentManager=new CommentManager();
                anCommentManager.InsertComment(anComment);
                commentText.InnerText = "";


            }
            else
            {
                Response.Redirect("LoginPage.aspx");
            }
            
        }

        protected void Login1_Authenticate(object sender, AuthenticateEventArgs e)
        {
            string userName=Login1.UserName;
            string password = Login1.Password;
            UserManager userManager=new UserManager();
            User anUser = userManager.GetUser(userName);
            if (anUser != null && anUser.UserPassword == password)
            {
                Session["aUser"] = userManager.GetUser(userName);
                Login1.Visible = false;
                
                login.InnerText = "Hi " + anUser.UserFullName;
            }
        }
    }
}