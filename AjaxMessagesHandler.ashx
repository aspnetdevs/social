<%@ WebHandler Language="C#" Class="AjaxFriendsSearch" %>

using System;
using System.Web;
using System.Collections.Generic;

public class AjaxFriendsSearch : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        if ((context.Request.Cookies["user"] != null) && (Convert.ToInt32(context.Request.Params["receiverId"])>0))
        {
            IDictionary<string,object> parameters = new Dictionary<string,object>();
            parameters.Add("@sender_id",context.Request.Cookies["user"].Value);
            parameters.Add("@receiver_id",context.Request.Params["receiverId"]);
            parameters.Add("@message", context.Request.Params["messageText"]);
            //May be it will be better to send date from client
            parameters.Add("@dispatch_date",DateTime.Now);
            Helper.SqlUpdateData("INSERT INTO messages(sender_id,receiver_id,message,dispatch_date) VALUES (@sender_id,@receiver_id,@message,@dispatch_date)",parameters);
        }
        
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}