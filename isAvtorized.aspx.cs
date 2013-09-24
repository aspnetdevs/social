using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class isAvtorized : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string confirmation_by_email = Request.QueryString["avt"] ?? "";
        if (confirmation_by_email != "")
        {
            SqlConnection conn;
            string connString = WebConfigurationManager.ConnectionStrings["connString"].ConnectionString;
            conn = new SqlConnection(connString);
            //To check id string for security
            DataTable dt = new DataTable("persons");
            SqlDataAdapter ad = new SqlDataAdapter("SELECT * FROM persons WHERE confirmation_by_email='" + confirmation_by_email + "'", conn);
            conn.Open();
            ad.Fill(dt);
            conn.Close();
            if (dt.Rows.Count != 0)
            {
                SqlCommand adapter = new SqlCommand("UPDATE persons SET isAutorized='True' WHERE confirmation_by_email='" + confirmation_by_email + "'", conn);
                conn.Open();
                adapter.ExecuteNonQuery();
                conn.Close();
                this.Label1.Text = "Авторизирован";
            }
        }
    }
}