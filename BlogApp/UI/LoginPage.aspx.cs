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
    public partial class LoginPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["aUser"]!=null)
            {
                Response.Redirect("Home.aspx");
            }
        }

        protected void Login1_Authenticate(object sender, AuthenticateEventArgs e)
        {
            string userName=Login1.UserName;
            string password = Login1.Password;
            UserManager userManager=new UserManager();
           User anUser= userManager.GetUser(userName);
           if (anUser != null && anUser.UserPassword == password)
            {


                Session["aUser"] = userManager.GetUser(userName);
               



                Session["aUser"] = anUser;
                Model.User na = (User) Session["aUser"];


                
                Response.Redirect("UserControlPanel.aspx");

            }

          
        }
    }
}