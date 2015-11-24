using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BlogApp.Model;
using BlogApp.BLL;

namespace BlogApp.UI
{
    public partial class UserControlPanel : System.Web.UI.Page
    {
        PostManager aPostManager = new PostManager();
        protected void Page_Load(object sender, EventArgs e)
        {
            User anUser = (User)Session["aUser"];
            if (anUser != null)
            {
              //  userNameLabel.InnerText = anUser.UserFullName;

                string allPosts = "";
                string oneLine = "";

                PostManager aPostManager = new PostManager();
                CommentManager anCommentManager=new CommentManager();

                List<Post> aPostList = aPostManager.GetUserData(anUser.UserId);

                foreach (Post anResultPost in aPostList)
                {
                   

                    if (anResultPost.PostDescreption.Length > 200)
                    {
                        oneLine = anResultPost.PostDescreption.Substring(0, 200);
                    }
                    else
                    {
                        oneLine = anResultPost.PostDescreption;
                    }
                    string isPublished;
                    if (anResultPost.PostIsPublished)
                    {
                        isPublished = "Published";
                    }
                    else
                    {
                        isPublished = "Unpublished";
                    }
                    int commentCount = anCommentManager.GetCommentCount(anResultPost.PostId);
                    allPosts += "<div class='post_section'><div class='post_date'><span>" + anResultPost.PostCreatedDate + "</span></div> <div class='post_content'><h2><a href='single-post.aspx?id=" + anResultPost.PostId + "'>" + anResultPost.PostTitle + "</a></h2> <strong>Author:</strong> " + anResultPost.UserFullName + "  <strong>Post View:  </strong>" + anResultPost.ViewCount + " <strong>Post Status:" + isPublished + "  </strong><strong>  Comment:" + commentCount + "  </strong><strong>  <a href='submit-post.aspx?id=" + anResultPost.PostId + "'>  Edit</a> </strong> <div> " + oneLine + "  <a href='single-post.aspx?id=" + anResultPost.PostId + "'>Read More</a></div></div> <div class='cleaner'></div></div>";
                }
                userPost.InnerHtml = allPosts;

            }

            else
            {
                Response.Redirect("LoginPage.aspx");
            }


            //authorLabel.Text = anUser.UserFullName;


            //GetUserData(anUser.UserId);

        }

        protected void userControlEditButton_Click(object sender, EventArgs e)
        {

        }

        protected void createPostButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("submit-post.aspx");
        }

        //public void GetUserData( int userId )
        //{

        //    PostManager aPostManager = new PostManager();

        //    List<Post> aPostList = aPostManager.GetUserData(userId);

        //    foreach (Post userPost in aPostList)
        //    {

        //    }
        //}



    }
}