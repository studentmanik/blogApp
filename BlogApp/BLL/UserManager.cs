using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using BlogApp.DAL;
using BlogApp.Model;

namespace BlogApp.BLL
{
    public class UserManager
    {
        UserGateway aUserGateway=new UserGateway();
        public int InsertUser(User aUser)
        {
            

            return aUserGateway.InsertUser(aUser);
        }

        public User GetUser(string userName)
        {

            
            return aUserGateway.GetUser(userName);

        }

        public User GetUserById(string userId)
        {
            return aUserGateway.GetUserById(userId);
        }
    }
}
