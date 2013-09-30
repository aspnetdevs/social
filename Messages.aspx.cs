using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Messages : System.Web.UI.Page
{
    public Person person;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.Cookies["user"] != null)
        {
            if (Request.Params["receiverId"] != null)
            {
                MessagesListView.DataSource = Helper.FindMessages(Request.Cookies["user"].Value, Request.Params["receiverId"]);
                MessagesListView.DataBind();
            }
            else
            {
                person = new Person(Request.Cookies["user"].Value).FindFriends(Request.Params["partName"] == null ? "" : Request.Params["partName"]);
                FriendsToTalkList.DataSource = person.Friends;
                FriendsToTalkList.DataBind();

            }
            Items["isMyPage"] = true;
        }
        else
        {
            Response.Redirect("~/Login.aspx");
        }
    }
}