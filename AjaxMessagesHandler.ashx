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
                //May be it will be better to send only messagetext and user to client and on render message block with js
                str.Append(string.Format(@"<div class='Message' data-senderid='{3}' data-messageid='{0}'><div class='MessageSender'>{1}</div><div class='MessageText'>{2}</div><div class='MessageControl'>
                                                <div class='DeleteMessage'>
                                                    <img src='img/delete.png' />
                                                </div>
                                            </div></div>", row["message_id"], row["first_name"], row["message"], row["id"]));
            }
            context.Response.Write(str.ToString());
        }
        else if ((context.Request.Cookies["user"] != null) && (context.Request.Params["messageId"] != null) && (context.Request.Params["senderId"] != null))
        {
            IDictionary<string,object> parameters = new Dictionary<string,object>();
            parameters.Add("@message_id", context.Request.Params["messageId"]);
            int updatedRows = Convert.ToInt32(context.Request.Cookies["user"].Value) == Convert.ToInt32(context.Request.Params["senderId"]) ?
                Helper.SqlUpdateData("UPDATE messages SET sender_delete = 1 WHERE message_id = @message_id", parameters) :
                Helper.SqlUpdateData("UPDATE messages SET receiver_delete = 1 WHERE message_id = @message_id", parameters);
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