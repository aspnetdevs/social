﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Messages : System.Web.UI.Page
{
    public Person person;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.Cookies["user"] != null)
        {
            ScriptManager scriptManager = ScriptManager.GetCurrent(this);
            person = new Person(Request.Cookies["user"].Value);
            if (!scriptManager.IsInAsyncPostBack || scriptManager.AsyncPostBackSourceElementID == FriendListUPanel.UniqueID)
            {
                FriendsToTalkList.DataSource = person.FindFriends(TalkToTxt.Text == string.Empty ? "" : TalkToTxt.Text).Friends;
                FriendsToTalkList.DataBind();
            }
            else if (!scriptManager.IsInAsyncPostBack || scriptManager.AsyncPostBackSourceElementID == MessagesUPanel.UniqueID)
            {
                System.Threading.Thread.Sleep(1000);
                MessagesListView.DataSource = Helper.FindMessages(Request.Cookies["user"].Value, talkingFriendId.Value);
                MessagesListView.DataBind();
            }
            else
            {
                FriendsToTalkList.DataSource = person.FindFriends("").Friends;
                FriendsToTalkList.DataBind();

            }
            Items["isMyPage"] = true;
        }
        else
        {
            Response.Redirect("~/Login.aspx");
        }
    }
}