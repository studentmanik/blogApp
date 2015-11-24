using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BlogApp.Model
{
    public class Comment
    {
        public int CommentId { get; set; }
        public int PostId { get; set; }
        public int UserId { get; set; }
        public string CommentDescreption { get; set; }
        public string CommentCreatedDate { get; set; }
        public string CommenterFullName { get; set; }
    }
}