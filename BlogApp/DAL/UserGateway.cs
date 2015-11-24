using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls.WebParts;
using BlogApp.Model;

namespace BlogApp.DAL
{
    public class UserGateway
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["BlogInfoConString"].ConnectionString;
      
        public int InsertUser(User aUser)
        {
            SqlConnection connection = new SqlConnection(connectionString);

            string query = string.Format("INSERT INTO tbl_user VALUES('" + aUser.UserEmail + "','" + aUser.UserFullName + "','" + aUser.UserPassword + "','" + aUser.UserName + "')");
            SqlCommand command = new SqlCommand(query, connection);

            connection.Open();

            int rowAffected = command.ExecuteNonQuery();

            connection.Close();

            return rowAffected;
        }

        public User GetUser(string userName)
        {
            SqlConnection connection = new SqlConnection(connectionString);
            string query2 = string.Format("SELECT * FROM tbl_user WHERE UserName='"+userName+"'");

            SqlCommand command2 = new SqlCommand(query2, connection);
            User aUser = null;
            connection.Open();
            SqlDataReader reader = command2.ExecuteReader();

            while (reader.Read())
            {
               aUser =new User();
                aUser.UserId = Convert.ToInt32(reader["UserId"].ToString());
                aUser.UserFullName = reader["FullName"].ToString();
                aUser.UserName = reader["UserName"].ToString();
                aUser.UserEmail = reader["Email"].ToString();
                aUser.UserPassword = reader["Password"].ToString();

            }
            connection.Close();
            return aUser;
        }

        public User GetUserById(string userId)
        {
            SqlConnection connection = new SqlConnection(connectionString);
            string query2 = string.Format("SELECT * FROM tbl_user WHERE UserId='" + userId + "'");

            SqlCommand command2 = new SqlCommand(query2, connection);
            User aUser=new User();
            connection.Open();
            SqlDataReader reader = command2.ExecuteReader();

            while (reader.Read())
            {
                aUser.UserId = Convert.ToInt32(reader["UserId"].ToString());
                aUser.UserFullName = reader["FullName"].ToString();
                aUser.UserName = reader["UserName"].ToString();
                aUser.UserEmail = reader["Email"].ToString();
                aUser.UserPassword = reader["Password"].ToString();

            }
            connection.Close();
            return aUser;
        }
    }
}