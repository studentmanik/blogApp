using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BlogApp.BLL;
using BlogApp.Model;

namespace BlogApp.UI
{
    public partial class SignUpPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            User anUser = (User)Session["aUser"];
            if (anUser!= null)
            {
                Response.Redirect("Home.aspx");
            }
           
        }

        protected void signUpSubmitButton_Click(object sender, EventArgs e)
        {
            UserManager userManager=new UserManager();
            User aUser=new User();
            aUser.UserFullName = signUpFullName.Text;
            aUser.UserEmail = signUpEmailTextBox.Text;
            aUser.UserName = userName.Text;
            aUser.UserPassword = signUpPassword.Text;

            if (userManager.GetUser(aUser.UserName)!=null)
            {


                userName.BackColor = Color.Red;
            }

            else
            {
                if (userManager.InsertUser(aUser) > 0)
                {
                  

                    Response.Redirect("LoginPage.aspx");

                }
                
                
                
            }
            
        }

        protected void userName_TextChanged(object sender, EventArgs e)
        {

        }
    }
}