using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Text;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (this.Page.IsPostBack)
        {
            string email = this.TBemail.Text;
            string password = this.TBpasswrd.Text;
            SqlConnection conn;
            string connString = WebConfigurationManager.ConnectionStrings["connString"].ConnectionString;
            conn = new SqlConnection(connString);
            SqlCommand cmd = new SqlCommand("SELECT id FROM persons WHERE email=@email AND password=@password", conn);
            cmd.Parameters.Add("@email", email);
            cmd.Parameters.Add("@password", password);
            conn.Open();
            var a = cmd.ExecuteReader();
            int id=0;
            if (a.Read())
                 id = a.GetInt32(0);

            if (id != 0)
            {
                //============!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!Replace cookie!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                HttpCookie cookie = new HttpCookie("id", id.ToString());
                cookie.Expires = DateTime.Now.AddMinutes(1);
                Response.Cookies.Add(cookie);
                Response.Redirect("http://localhost/social/Default.aspx?id="+id);
            }
         
        }

    }
}