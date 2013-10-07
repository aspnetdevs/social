using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;


public partial class _Default : System.Web.UI.Page
{
    [WebMethod]
    public static string DelUser(string DelId, string ourId)
    {
        string connString = WebConfigurationManager.ConnectionStrings["connString"].ConnectionString;
        SqlConnection conn = new SqlConnection(connString);
        SqlCommand cmd = new SqlCommand("DELETE FROM persons_to_friends WHERE person_id=@person_id AND friend_id=@friend_id ", conn);
        cmd.Parameters.Add(new SqlParameter("@person_id", ourId));
        cmd.Parameters.Add(new SqlParameter("@friend_id", DelId));
        conn.Open();
        cmd.ExecuteNonQuery();
        conn.Close();

        return DelId;
    }
    public Person person = null;
    protected void Page_Load(object sender, EventArgs e)
    {
        
        HttpCookie cookie = Request.Cookies["user"];
        if (cookie == null)
            Response.Redirect("~/Login.aspx");
        else
        {
            if (Request.QueryString["id"] == null)
                Response.Redirect("~/Default.aspx?id=" + cookie.Value);
            Items["isMyPage"] = Request.QueryString["id"] == Request.Cookies["user"].Value;
        }
        string id = Request.QueryString["id"] ?? "";
        person = new Person(id);
        //if (Request.Params["col"] != null)
        //{
        //    person = new Person("1").FindFriends("");
        //    FriendsList.RepeatColumns = Convert.ToInt32(Request.Params["col"]);
        //    FriendsList.RepeatDirection = RepeatDirection.Vertical;
        //    FriendsList.DataSource = person.Friends;
        //    FriendsList.DataBind();
        //}
    }
}

