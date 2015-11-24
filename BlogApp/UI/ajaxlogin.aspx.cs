using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BlogApp.UI
{
    public partial class ajaxlogin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["userName"] != null)
            {
                Login1.Visible = false;
                Label1.Text = "hi " + Session["userName"];
            }
          
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            //Login1.Visible = false;
            String queryString = "id=" + 1;
            Response.Redirect("single-post.aspx?"+queryString);

        }

        protected void Login1_Authenticate(object sender, AuthenticateEventArgs e)
        {
            Session["userName"]=Login1.UserName;
            Session["passwod"] = Login1.Password;
            Login1.Visible = false;
            Label1.Text = "success";

        }
        }
    }
