using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using BlogApp.BLL;
using BlogApp.DAL;
using BlogApp.Model;

namespace BlogApp
{
    public class SearchHelper
    {
        string result = "";
        string text = "";
        string reTitleText = "";
        string reNameText = "";
        string reDescriptionText = "";
        string oneLine="";
        PostGateway anPostGateway=new PostGateway();
        CommentManager anCommentManager=new CommentManager();
        public string GetResultView(string searchText)
        {
            List<Post> searchResult;
            if (searchText!="")
            {
                searchResult= anPostGateway.SearchInPost(searchText);
            }
            else
            {
                searchResult = anPostGateway.GetAllPost();
            }
            
            foreach (Post anResultPost in searchResult)
            {
               
                if (anResultPost.PostDescreption.Length > 200)
                {
                    oneLine = anResultPost.PostDescreption.Substring(0, 200);
                }
                else
                {
                    oneLine = anResultPost.PostDescreption;
                }

                if (text!="")
                {
                    text = "<strong>" + searchText + "</strong>";
                    reTitleText = anResultPost.PostTitle.Replace(searchText, text);
                    reDescriptionText = oneLine.Replace(searchText, text);
                    reNameText = anResultPost.UserFullName.Replace(searchText, text);
                }
                else
                {
                    reTitleText = anResultPost.PostTitle;
                    reDescriptionText = oneLine;
                    reNameText = anResultPost.UserFullName;
                }
                int commentCount = anCommentManager.GetCommentCount(anResultPost.PostId);
                result += "<div class='post_section'><div class='post_date'><span>" + anResultPost.PostCreatedDate + "</span></div> <div class='post_content'><h2><a href='single-post.aspx?id=" + anResultPost.PostId + "'>" + reTitleText + "</a></h2> <strong>Author:</strong> <a href='author-profile.aspx?id=" + anResultPost.userId + "'>" + reNameText + "</a> <strong>  Comment:" + commentCount + "  </strong> <p> " + reDescriptionText + " <a href='single-post.aspx?id=" + anResultPost.PostId + "'>Read More</a></p></div> <div class='cleaner'></div></div>";
            }
            return result;
        }

        public bool CodeValidator(string searchText)
        {
            return anPostGateway.CodeValidator(searchText);
        }
    }
}