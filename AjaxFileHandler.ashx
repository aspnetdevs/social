<%@ WebHandler Language="C#" Class="AjaxFileHandler" %>

using System;
using System.Web;
using System.IO;
using System.Web.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;

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
            IDictionary<string,object> parameters = new Dictionary<string,object>();
            parameters.Add("@avatar",catalog + file.FileName);
            Helper.SqlUpdateData("UPDATE persons SET avatar = @avatar WHERE id = " + context.Request.Cookies["user"].Value, parameters);
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