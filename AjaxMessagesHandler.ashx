<%@ WebHandler Language="C#" Class="AjaxFriendsSearch" %>

using System;
using System.Web;
using System.Collections.Generic;
using System.Data;

public class AjaxFriendsSearch : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        if ((context.Request.Cookies["user"] != null) && (Convert.ToInt32(context.Request.Params["receiverId"]) > 0))
        {
            IDictionary<string, object> parameters = new Dictionary<string, object>();
            parameters.Add("@sender_id", context.Request.Cookies["user"].Value);
            parameters.Add("@receiver_id", context.Request.Params["receiverId"]);
            parameters.Add("@message", context.Request.Params["messageText"]);
            //May be it will be better to send date from client
            parameters.Add("@dispatch_date", DateTime.Now);
            Helper.SqlUpdateData("INSERT INTO messages(sender_id,receiver_id,message,dispatch_date) VALUES (@sender_id,@receiver_id,@message,@dispatch_date)", parameters);
        }
        else if ((context.Request.Cookies["user"] != null) && (context.Request.Params["lastMessageId"] != null) && (Convert.ToInt32(context.Request.Params["talkingFriendId"]) > 0))
        {
            DataTable dt = Helper.FindMessages(context.Request.Cookies["user"].Value, context.Request.Params["talkingFriendId"], context.Request.Params["lastMessageId"]);
            System.Text.StringBuilder str = new System.Text.StringBuilder();
            foreach (DataRow row in dt.Rows)
            {

                str.Append(string.Format("<div class='Message' data-messageid='{0}'><div class='MessageSender'>{1}</div><div class='MessageText'>{2}</div></div>", row["message_id"], row["first_name"], row["message"]));
            }
            context.Response.Write(str.ToString());
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