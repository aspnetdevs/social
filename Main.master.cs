using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using System.Web.Services;


public partial class Main : System.Web.UI.MasterPage
{
    public Person person;
    protected IDictionary<string, object> obj = null;
    protected void Page_Load(object sender, EventArgs e)
    {
        
        if (Request.Cookies["user"] != null)
        {
            string id = Request.QueryString["id"] != null ? Request.QueryString["id"] : Request.Cookies["user"].Value;
            person = new Person(id).FindFriends("");
            if (MainScriptManager.IsInAsyncPostBack && MainScriptManager.AsyncPostBackSourceElementID == MainFriendsUPanel.UniqueID)
            {
                JavaScriptSerializer json = new JavaScriptSerializer();
                obj = json.Deserialize<IDictionary<string, object>>(Request["__EVENTARGUMENT"]);
                if (obj.ContainsKey("repeatColumn"))
                FriendsList.RepeatColumns = (int)obj["repeatColumn"];
                if (obj.ContainsKey("Online"))
                {
                    person = new Person(id).FindFriendsOnline("");
                }

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

