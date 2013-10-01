using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;


public partial class Main : System.Web.UI.MasterPage
{
    public Person person;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.Cookies["user"] != null)
        {
            string id = Request.QueryString["id"] != null ? Request.QueryString["id"] : Request.Cookies["user"].Value;
            person = new Person(id).FindFriends("");
            if (MainScriptManager.IsInAsyncPostBack && MainScriptManager.AsyncPostBackSourceElementID == MainFriendsUPanel.UniqueID)
            {
                JavaScriptSerializer json = new JavaScriptSerializer();
                var obj = json.Deserialize<IDictionary<string, int>>(Request["__EVENTARGUMENT"]);
                FriendsList.RepeatColumns = obj["repeatColumn"];
 
            }
            FriendsList.DataSource = person.Friends;
            FriendsList.DataBind();
            Image1.ImageUrl = person.Fields["avatar"].ToString();
            
        }
    }
    protected void mainNavItem_Click(object sender, EventArgs e)
    {
        if (Request.Cookies["user"] != null)
        {
            Response.Redirect("~/Default.aspx?id=" + Request.Cookies["user"].Value);
        }
        else
            Response.Redirect("~/Login.aspx");
    }
    protected void logoutNavItem_Click(object sender, EventArgs e)
    {
        Request.Cookies["user"].Expires = DateTime.Now.AddDays(-1);
        Response.Cookies.Add(Request.Cookies["user"]);
        Response.Redirect("~/Login.aspx");

    }
    protected void messagesNavItem_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Messages.aspx");
    }
    
}

