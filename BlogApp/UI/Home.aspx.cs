using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BlogApp.BLL;
using BlogApp.Model;

namespace BlogApp
{
    public partial class Home : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                PostManager postManager=new PostManager();
                CommentManager anCommentManager=new CommentManager();
                List<Post> last5Posts = postManager.GetLast5Post();
                string allPosts = "";
                string oneLine = "";
                User aUser = (User) Session["aUser"];
                //List<Post> homePosts=(List<Post>) last5Posts.Take(5);
                foreach (Post anResultPost in last5Posts)
                {
                    if (anResultPost.PostDescreption.Length > 200)
                    {
                        oneLine = anResultPost.PostDescreption.Substring(0, 200);
                    }
                    else
                    {
                        oneLine = anResultPost.PostDescreption;
                    }
                    int commentCount = anCommentManager.GetCommentCount(anResultPost.PostId);
                    string edit="";
                    if (aUser != null && aUser.UserId == anResultPost.userId)
                    {
                        edit = "<a href='submit-post.aspx?id=" + anResultPost.PostId + "'>  Edit</a>";
                    }
                    allPosts += "<div class='post_section'><div class='post_date'><span>" + anResultPost.PostCreatedDate + "</span></div> <div class='post_content'><h2><a href='single-post.aspx?id=" + anResultPost.PostId + "'>" + anResultPost.PostTitle + "</a></h2> <strong>  Author:</strong> <a href='author-profile.aspx?id=" + anResultPost.userId + "'>" + anResultPost.UserFullName + "</a>  <strong>  Post View:  </strong>" + anResultPost.ViewCount + "<strong>  Comment:" + commentCount + "  </strong> " + edit + " <div> " + oneLine + "  <a href='single-post.aspx?id=" + anResultPost.PostId + "'>Read More</a></div></div> <div class='cleaner'></div></div>";


                }
                allpost.InnerHtml = allPosts;
               
                List<Post> popularPosts = postManager.GetPopularPost();

              
                string subDescription = "";
                string mostpopularpost = "";
                foreach (Post anPopularPost in popularPosts)
                {
                    if (anPopularPost.PostDescreption.Length > 200)
                    {
                        subDescription = anPopularPost.PostDescreption.Substring(0, 200);
                    }
                    else
                    {
                        subDescription = anPopularPost.PostDescreption;
                    }
                    string edit="";
                    if (aUser != null && aUser.UserId == anPopularPost.userId)
                    {
                        edit = "<a href='submit-post.aspx?id=" + anPopularPost.PostId + "'>  Edit Post</a>";
                    }
                    mostpopularpost += "<li><h6><a href='single-post.aspx?id=" + anPopularPost.PostId + "'>" + anPopularPost.PostTitle + "</a></h6><div><strong>Author: </strong><a href='author-profile.aspx?id=" + anPopularPost.userId + "'>" + anPopularPost.UserFullName + "</a><strong>  view: </strong> " + anPopularPost.ViewCount + "" + edit + " </div><p>" + subDescription + "  <a href='single-post.aspx?id=" + anPopularPost.PostId + "'>Read More</a> </p></li>";
          
                }

                popularpost.InnerHtml = mostpopularpost;
            }
            

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            
           // string searchText = searchTextBox.Text;
           // SearchHelper anSearchHelper=new SearchHelper();
           //string result = anSearchHelper.GetResultView(searchText);
           //     allpost.InnerHtml = result;
        }
    }
}