using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BlogApp.Model
{
    public class Post
    {
        public int PostId { get; set; }
        public string PostTitle { get; set; }
        public string PostDescreption { get; set; }
        public string PostImage { get; set; }
        public string PostCreatedDate { get; set; }
        public bool PostIsPublished { get; set; }
        public int userId { get; set; }
        public string UserFullName { get; set; }
        public int ViewCount { get; set; }







    }
}