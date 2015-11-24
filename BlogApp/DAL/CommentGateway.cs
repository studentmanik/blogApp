using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using BlogApp.Model;

namespace BlogApp.DAL
{
    public class CommentGateway
    {
        String connectionString = ConfigurationManager.ConnectionStrings["BlogInfoConString"].ConnectionString;
     
        public int InsertComment(Comment anComment)
        {
            SqlConnection connection = new SqlConnection(connectionString);

            string query = string.Format("INSERT INTO tbl_comment VALUES('"+anComment.UserId+"','"+anComment.PostId+"','"+anComment.CommentDescreption+"','"+DateTime.Now+"')");
            SqlCommand command = new SqlCommand(query, connection);

            connection.Open();

            int rowAffected = command.ExecuteNonQuery();

            connection.Close();

            return rowAffected;
        }

        public List<Comment> GetCommentById(string postId)
        {
            SqlConnection connection = new SqlConnection(connectionString);

            String query = "SELECT * FROM CommentView where PostId ='" + postId + "' order by CommentDate ASC";

            SqlCommand command = new SqlCommand(query, connection);

            connection.Open();

            SqlDataReader reader = command.ExecuteReader();

            List<Comment> aCommentsList = new List<Comment>();

            while (reader.Read())
            {
                Comment anComment = new Comment();
                anComment.CommentId = Convert.ToInt32(reader["CommentId"].ToString());
                anComment.PostId = Convert.ToInt32(reader["PostId"].ToString());
                anComment.UserId = Convert.ToInt32(reader["userId"].ToString());
                anComment.CommenterFullName = reader["FullName"].ToString();
                anComment.CommentDescreption = reader["Description"].ToString();
                anComment.CommentCreatedDate = reader["CommentDate"].ToString();


                aCommentsList.Add(anComment);
            }
            reader.Close();
            connection.Close();

            return aCommentsList;
        }

        public int GetCommentCount(int postId)
        {
            SqlConnection connection = new SqlConnection(connectionString);

            String query = "SELECT COUNT(PostId) FROM tbl_comment WHERE PostId="+postId;

            SqlCommand command = new SqlCommand(query, connection);

            connection.Open();
            int anCommentCount=0;
            SqlDataReader reader = command.ExecuteReader();
            while (reader.Read())
            {
               
                anCommentCount = Convert.ToInt32(reader[""].ToString());


            }
            reader.Close();
            connection.Close();

            return anCommentCount;
        }
    }
}