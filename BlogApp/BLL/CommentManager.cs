using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using BlogApp.DAL;
using BlogApp.Model;

namespace BlogApp.BLL
{
    public class CommentManager
    {
        CommentGateway andCommentGateway=new CommentGateway();
        public int InsertComment(Comment anComment)
        {
            return andCommentGateway.InsertComment(anComment);
        }

        public List<Comment> GetCommentById(string postId)
        {
             return andCommentGateway.GetCommentById(postId);
        }

        public int GetCommentCount(int postId)
        {
            return andCommentGateway.GetCommentCount(postId);
        }
    }
    }
