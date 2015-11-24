using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BlogApp
{
    public partial class MasterPage : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           

        }

        protected void searchButton_Click(object sender, EventArgs e)
        {
            SearchHelper anSearchHelper=new SearchHelper();
            string searchText=searchTextBox.Text.ToLower();
            

            if (anSearchHelper.CodeValidator(searchText))
            {
                templatemo_content.InnerHtml = "This is a HTML Tag";
            }
            else
            {
                string search = anSearchHelper.GetResultView(searchTextBox.Text);
                templatemo_content.InnerHtml = search;
            }
            
        }
    }
}