using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using BlogApp.Model;

namespace BlogApp.DAL
{
    public class PostGateway
    {
        String connectionString = ConfigurationManager.ConnectionStrings["BlogInfoConString"].ConnectionString;
     
        public List<Post> GetLast5Post()
        {
           SqlConnection connection = new SqlConnection(connectionString);

           String query = "SELECT top 5* FROM homePageView where IsPublished ='true' order by CreatedDate DESC";

            SqlCommand command = new SqlCommand(query, connection);

            connection.Open();

            SqlDataReader reader = command.ExecuteReader();

            List<Post> anPostList = new List<Post>();

            while (reader.Read())
            {
                Post anPost = new Post();
                anPost.PostId = Convert.ToInt32(reader["PostId"].ToString());
                anPost.userId = Convert.ToInt32(reader["userId"].ToString());
                anPost.PostTitle = reader["Title"].ToString();
                anPost.PostDescreption = reader["Description"].ToString();
                anPost.PostCreatedDate = reader["CreatedDate"].ToString();
                anPost.UserFullName = reader["FullName"].ToString();
                anPost.ViewCount = Convert.ToInt32(reader["ViewCount"].ToString());
                anPost.PostIsPublished = (bool)reader["IsPublished"];

                anPostList.Add(anPost);
            }
            reader.Close();
            connection.Close();

            return anPostList;
        }
        public List<Post> GetAllPost()
        {
            SqlConnection connection = new SqlConnection(connectionString);

            String query = "SELECT * FROM homePageView where IsPublished ='true' order by CreatedDate DESC";

            SqlCommand command = new SqlCommand(query, connection);

            connection.Open();

            SqlDataReader reader = command.ExecuteReader();

            List<Post> anPostList = new List<Post>();

            while (reader.Read())
            {
                Post anPost = new Post();
                anPost.PostId = Convert.ToInt32(reader["PostId"].ToString());
                anPost.userId = Convert.ToInt32(reader["userId"].ToString());
                anPost.PostTitle = reader["Title"].ToString();
                anPost.PostDescreption = reader["Description"].ToString();
                anPost.PostCreatedDate = reader["CreatedDate"].ToString();
                anPost.UserFullName = reader["FullName"].ToString();
                anPost.ViewCount = Convert.ToInt32(reader["ViewCount"].ToString());
                anPost.PostIsPublished = (bool)reader["IsPublished"];

                anPostList.Add(anPost);
            }
            reader.Close();
            connection.Close();

            return anPostList;
        }
        public int InsertPost(Post anPost)
        {
            SqlConnection connection = new SqlConnection(connectionString);

            string query = string.Format("INSERT INTO tbl_posts VALUES('" + anPost.userId + "','" + anPost.PostTitle + "','" + anPost.PostDescreption + "','" + "" + "','" + DateTime.Now + "','" + DateTime.Now + "','" + "" + "','" + anPost.PostIsPublished + "')");
            SqlCommand command = new SqlCommand(query, connection);

            connection.Open();

            int rowAffected = command.ExecuteNonQuery();

            connection.Close();

            return rowAffected;
        }



        public List<Post> GetUserData(int userId)
        {
            SqlConnection connection = new SqlConnection(connectionString);

            string query = "Select * from homePageView where UserId = '" + userId + "' order by CreatedDate DESC";

            SqlCommand aCommand = new SqlCommand(query, connection);
            List<Post> apostList = new List<Post>();

            connection.Open();
            SqlDataReader aReader = aCommand.ExecuteReader();

            while (aReader.Read())
            {


                Post aPost = new Post();

                aPost.PostId = int.Parse(aReader["PostId"].ToString());
                aPost.userId = int.Parse(aReader["UserId"].ToString());
                aPost.UserFullName = aReader["FullName"].ToString();
                aPost.PostTitle = aReader["Title"].ToString();
                aPost.PostDescreption = aReader["Description"].ToString();
                aPost.PostCreatedDate = aReader["CreatedDate"].ToString();
                aPost.ViewCount = int.Parse(aReader["ViewCount"].ToString());
                aPost.PostIsPublished = Convert.ToBoolean(aReader["IsPublished"].ToString());
                
                apostList.Add(aPost);

            }

            aReader.Close();
            connection.Close();
            return apostList;
        }


        public Post GetPostById(string id)
        {
            SqlConnection connection = new SqlConnection(connectionString);

            String query = "SELECT * FROM homePageView WHERE PostId=" + id;
            String query2="update tbl_posts set ViewCount = ((select ViewCount from tbl_posts where PostId =" + id + ")+1) where PostId=" + id;
           
            SqlCommand command = new SqlCommand(query, connection);
            SqlCommand command2 = new SqlCommand(query2, connection);

            connection.Open();

           
            SqlDataReader reader = command.ExecuteReader();

            
          
            
                Post anPost = new Post();
            while (reader.Read())
            {
                anPost.PostId = Convert.ToInt32(reader["PostId"].ToString());
                anPost.userId = Convert.ToInt32(reader["userId"].ToString());
                anPost.PostTitle = reader["Title"].ToString();
                anPost.PostDescreption = reader["Description"].ToString();
                anPost.PostCreatedDate=reader["CreatedDate"].ToString();
                anPost.UserFullName=reader["FullName"].ToString();
               anPost.ViewCount=Convert.ToInt32(reader["ViewCount"].ToString());
                anPost.PostIsPublished=(bool) reader["IsPublished"];
                

            }
              
              
            
            reader.Close();
            SqlDataReader reader1 =command2.ExecuteReader();
         
            reader1.Close();
            connection.Close();

            return anPost;

        }

        public List<Post> SearchInPost(string searchText)
        {
            SqlConnection connection = new SqlConnection(connectionString);

            string query = "Select * from homePageView where (patindex('%" + searchText + "%' , Title) > 0 or patindex('%" + searchText + "%' , Description) > 0 or patindex('%" + searchText + "%' , FullName) > 0) AND IsPublished ='true'";


            SqlCommand aCommand = new SqlCommand(query, connection);
            List<Post> searchResultList = new List<Post>();

            connection.Open();
            SqlDataReader aReader = aCommand.ExecuteReader();

            while (aReader.Read())
            {


                Post aPost = new Post();

                aPost.PostId = int.Parse(aReader["PostId"].ToString());
                aPost.userId = int.Parse(aReader["UserId"].ToString());
                aPost.UserFullName = aReader["FullName"].ToString();
                aPost.PostTitle = aReader["Title"].ToString();
                aPost.PostDescreption = aReader["Description"].ToString();
                aPost.PostCreatedDate = aReader["CreatedDate"].ToString();
                aPost.ViewCount = int.Parse(aReader["ViewCount"].ToString());
                searchResultList.Add(aPost);

            }

            aReader.Close();
            connection.Close();
            return searchResultList;
        }

        public List<Post> GetPopularPost()
        {
            SqlConnection connection = new SqlConnection(connectionString);

            String query = "SELECT top 5* FROM homePageView where IsPublished ='true' order by ViewCount DESC";

            SqlCommand command = new SqlCommand(query, connection);

            connection.Open();

            SqlDataReader reader = command.ExecuteReader();

            List<Post> anPostList = new List<Post>();

            while (reader.Read())
            {
                Post anPost = new Post();
                anPost.PostId = Convert.ToInt32(reader["PostId"].ToString());
                anPost.userId = Convert.ToInt32(reader["userId"].ToString());
                anPost.PostTitle = reader["Title"].ToString();
                anPost.PostDescreption = reader["Description"].ToString();
                anPost.PostCreatedDate = reader["CreatedDate"].ToString();
                anPost.UserFullName = reader["FullName"].ToString();
                anPost.ViewCount = Convert.ToInt32(reader["ViewCount"].ToString());
                anPost.PostIsPublished = (bool)reader["IsPublished"];

                anPostList.Add(anPost);
            }
            reader.Close();
            connection.Close();

            return anPostList;
        }

        public int UpdatePostById(Post anPost)
        {
            SqlConnection connection = new SqlConnection(connectionString);

           
            string query = string.Format("UPDATE tbl_posts SET Title='" + anPost.PostTitle + "', Description='" + anPost.PostDescreption + "',CreatedDate='" + DateTime.Now + "',IsPublished='" + anPost.PostIsPublished + "' WHERE PostId='" + anPost.PostId + "'");
            SqlCommand command = new SqlCommand(query, connection);

            connection.Open();

            int rowAffected = command.ExecuteNonQuery();

            connection.Close();

            return rowAffected;
        }

        public bool CodeValidator(string searchText)
        {

            SqlConnection connection = new SqlConnection(connectionString);

            string query = "Select * from homePageView where (patindex('%<" + searchText + ">%' , Title) > 0 or patindex('%<" + searchText + ">%' , Description) > 0 or  patindex('%</" + searchText + ">%' , Description) > 0 or patindex('%<" + searchText + ">%' , FullName) > 0) AND IsPublished ='true'";


            SqlCommand aCommand = new SqlCommand(query, connection);
            List<Post> searchResultList = new List<Post>();

            connection.Open();
            SqlDataReader aReader = aCommand.ExecuteReader();
            bool result = aReader.Read();
            //while (aReader.Read())
            //{


            //    Post aPost = new Post();

            //    aPost.PostId = int.Parse(aReader["PostId"].ToString());
            //    aPost.userId = int.Parse(aReader["UserId"].ToString());
            //    aPost.UserFullName = aReader["FullName"].ToString();
            //    aPost.PostTitle = aReader["Title"].ToString();
            //    aPost.PostDescreption = aReader["Description"].ToString();
            //    aPost.PostCreatedDate = aReader["CreatedDate"].ToString();
            //    aPost.ViewCount = int.Parse(aReader["ViewCount"].ToString());
            //    searchResultList.Add(aPost);

            //}

            //aReader.Close();
            //connection.Close();
            return aReader.Read();
        }
    }
}