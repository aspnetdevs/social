<%@ WebHandler Language="C#" Class="AjaxUpdatesHandler" %>

using System;
using System.Web;

public class AjaxUpdatesHandler : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        if (context.Request.Cookies["user"] != null)
        {
        
        }
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}