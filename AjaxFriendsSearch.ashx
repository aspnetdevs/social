<%@ WebHandler Language="C#" Class="AjaxFriendsSearch" %>

using System;
using System.Web;

public class AjaxFriendsSearch : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}