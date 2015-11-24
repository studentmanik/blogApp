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
    public partial class author_profile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            string userId = Request.QueryString["id"];
            if (userId!=null)
            {
                UserManager anUserManager=new UserManager();
                User anUser= anUserManager.GetUserById(userId);

                name.InnerText = anUser.UserFullName;
                email.InnerText = anUser.UserEmail; 
            }
            
        }
    }
}