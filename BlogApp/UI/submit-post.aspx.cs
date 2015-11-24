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
    public partial class submit_post : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Model.User anUser = (User) Session["aUser"];
                string queryst = Request.QueryString["id"];
                if (anUser == null)
                {
                    Response.Redirect("LoginPage.aspx");
                }
                else if (queryst != null)
                {
                    PostManager anPostManager = new PostManager();
                    Post aPost = anPostManager.GetPostById(queryst);

                    if (aPost.userId == anUser.UserId)
                    {
                        titleTexbox.Text = aPost.PostTitle;
                        edit.InnerText = aPost.PostDescreption;
                        if (aPost.PostIsPublished)
                        {
                            DropDownList1.SelectedItem.Text = "Published";
                            DropDownList1.SelectedItem.Value = "True";
                        }
                        else
                        {
                            DropDownList1.SelectedItem.Text = "UnPublished";
                            DropDownList1.SelectedItem.Value = "false";
                        }
                        
                    }
                    else
                    {
                        Response.Redirect("LoginPage.aspx");
                    }

                }

            }
        }
           
        protected void Button1_Click(object sender, EventArgs e)
        {
            string queryst= Request.QueryString["id"];
            if (queryst != null)
            {
                PostManager anPostManager=new PostManager();
                Post anPost=new Post();
                anPost.PostId = Convert.ToInt32(queryst);
                anPost.PostTitle = titleTexbox.Text;
                anPost.PostDescreption = edit.InnerText;
                if (DropDownList1.SelectedValue == "true")
                {
                    anPost.PostIsPublished = true;
                }
                else
                {
                    anPost.PostIsPublished = false;
                }

                Model.User anUser = (User)Session["aUser"];

                anPost.userId = anUser.UserId;

                if (anPost.PostTitle != "" && anPost.PostDescreption != "")
                {
                    if (anPostManager.UpdatePostById(anPost) > 0)
                    {
                        Response.Redirect("UserControlPanel.aspx");

                    }
                }
                else
                {
                    msg.InnerText = "Please Enter Both title and Description";
                }
               
            }
            else
            {
                PostManager anPostManager=new PostManager();
                Post anPost=new Post();
                anPost.PostTitle = titleTexbox.Text;
                anPost.PostDescreption = edit.Value;
                if (DropDownList1.SelectedValue == "true")
                {
                    anPost.PostIsPublished = true;
                }
                else
                {
                    anPost.PostIsPublished = false;
                }

                Model.User anUser = (User)Session["aUser"];

                anPost.userId = anUser.UserId;
  if (anPost.PostTitle != "" && anPost.PostDescreption != "")
                {
                if (anPostManager.InsertPost(anPost) > 0)
                {
                    Response.Redirect("UserControlPanel.aspx");
                    
                }
                }
  else
  {
      msg.InnerText = "Please Enter Both title and Description";
  }

            }
            
            
        }

       
    }
}