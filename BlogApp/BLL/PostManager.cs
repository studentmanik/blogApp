using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using BlogApp.DAL;
using BlogApp.Model;

namespace BlogApp.BLL
{
    public class PostManager
    {
        PostGateway postGateway=new PostGateway();
        public List<Post> GetLast5Post()
        {
            return postGateway.GetLast5Post();
        }

        public int InsertPost(Post anPost)
        {
            return postGateway.InsertPost(anPost);
        }



        public List<Post> GetUserData(int userId)
        {
            return postGateway.GetUserData(userId);
        }

        public Post GetPostById(string id)
        {
            return postGateway.GetPostById(id);
        }

        //public Post GetPostById(string id)
        //{
        //    return postGateway.GetPostById(id);

        //}
        public List<Post> SearchInPost(string searchText)
        {
            return postGateway.SearchInPost(searchText);
        }

        public List<Post> GetPopularPost()
        {
            return postGateway.GetPopularPost();
        }

        public int UpdatePostById(Post anPost)
        {
            return postGateway.UpdatePostById(anPost);
        }

       
    }
    }
