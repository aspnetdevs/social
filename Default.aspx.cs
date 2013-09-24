using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Social;

public partial class _Default : System.Web.UI.Page
{
    public Person person = null;
    protected void Page_Load(object sender, EventArgs e)
    {
      string id = Request.QueryString["id"] ?? "";
        person = new Person(id).FindFriends();
        FriendsList.DataSource = person.Friends;
        FriendsList.DataBind();
        Image1.ImageUrl = !string.IsNullOrEmpty(person.AvatarUrl) ? person.AvatarUrl : "images/no_photo.jpg";
    }
}