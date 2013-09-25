<%@ WebHandler Language="C#" Class="AjaxFileHandler" %>

using System;
using System.Web;
using System.IO;
using System.Web.Configuration;
using System.Data;
using System.Data.SqlClient;

public class AjaxFileHandler : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        if (context.Request.Files.Count > 0)
        {
            string catalog = "images/";
            string path = context.Server.MapPath("~/"+catalog);
            var file = context.Request.Files[0];
            string filename = Path.Combine(path, file.FileName);
            file.SaveAs(filename);
            context.Response.ContentType = "text/plain";
            var serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
            var result = new { name = file.FileName };
            context.Response.Write(serializer.Serialize(result));
            string connString = WebConfigurationManager.ConnectionStrings["connString"].ConnectionString;
            SqlConnection conn = new SqlConnection(connString);
            SqlCommand cmd = new SqlCommand("UPDATE persons SET avatar = @avatar WHERE id = "+context.Request.Cookies["user"].Value,conn);
            cmd.Parameters.AddWithValue("@avatar", catalog + file.FileName);
            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
        }
    }
    
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}