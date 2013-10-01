<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="Messages.aspx.cs" Inherits="Messages" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder" runat="Server">
    <input runat="server" type="hidden" clientidmode="Static" id="talkingFriendId" />
    <script>
        $(function () {
            var talkingFriendId = 0;
            function ReplaceSpacesToOne(str) {
                var reg = /(\s){2,}/;
                return str.replace(reg, " ");
            }

            $("#TalkToTxt").keyup(function () {
                //Allow only All symbols + backspace
                <%=ClientScript.GetPostBackEventReference(FriendListUPanel,"")%>
            });

            $("#FriendsToTalkBlock").delegate(".FriendAvatar", "click", function () {
                //It doesn't work
                //<=ClientScript.GetPostBackEventReference(FriendListUPanel,"empty")%>

                talkingFriendId = $(this).siblings().attr("data-id");
                if ($("#talkingFriendId").val() != talkingFriendId) {
                    $("#TalkToTxt").val(ReplaceSpacesToOne($(this).siblings().text().trim()));
                    //Some little manipulation. Need to pass data with _dopostback function
                    $("#talkingFriendId").val(talkingFriendId);
                    <%=ClientScript.GetPostBackEventReference(MessagesUPanel,"")%>
                    $("#<%=MessagesUPanel.ClientID%>").text("");
                }
            });

            $("#sendMessage").click(function () {
                $.ajax({
                    type: "POST",
                    url: "AjaxMessagesHandler.ashx",
                    data: { receiverId: talkingFriendId, messageText: $("#messageTxt").val() },
                    success: function () {
                        if (talkingFriendId > 0) {
                            $("#messageTxt").val("");
                        }
                    },
                    error: function () {
                        alert("Error in ajax to AjaxMessagesHandler");
                    }
                });
            });
            setInterval(function () {
                $.ajax({
                    type: "POST",
                    url: "AjaxMessagesHandler.ashx",
                    data: { lastMessageId: $("#<%=MessagesUPanel.ClientID%> div.Message").last().attr("data-messageid"), talkingFriendId: talkingFriendId },
                    success: function (result) {
                        $(result).appendTo($("#<%=MessagesUPanel.ClientID%>"));
                    },
                    error: function () {
                        alert("Error in get Last Messages")
                    }
                });
               }, 500);
        });
    </script>
    <asp:ScriptManager runat="server" ID="ScriptManager"></asp:ScriptManager>
    <div class="block right-block top-block" id="Messages">
        <div style="height: 7%;">
            <span class="block-title">Сообщения</span>
            <hr style="margin: 5px 0 0;" />
        </div>
        <div style="height: 93%;">
            <div id="FriendsToTalkBlock">
                <asp:UpdatePanel runat="server" ID="FriendListUPanel" UpdateMode="Conditional">
                    <ContentTemplate>
                        <asp:DataList ID="FriendsToTalkList" ClientIDMode="Static" RepeatDirection="Vertical" RepeatColumns="1" runat="server">
                            <ItemTemplate>
                                <div data-id='<%#Eval("id") %>' style="display: none;"></div>
                                <div class="FriendAvatar">
                                    <asp:Image ID="Image2" runat="server" ImageUrl='<%# Eval("mini_avatar") %>' />
                                </div>
                                <div class="FriendName">
                                    <%# Eval("first_name")%><br />
                                    <%# Eval("last_name") %>
                                </div>
                            </ItemTemplate>
                        </asp:DataList>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
            <div id="MessagesBlock">
                <div id="MessagesList">
                    <div id="TalkTo">
                        <div>
                            Кому:
                        <asp:TextBox runat="server" ClientIDMode="Static" ID="TalkToTxt" />
                        </div>
                    </div>
                    <asp:UpdateProgress DisplayAfter="100" ClientIDMode="Static" ID="MessagesProgress" runat="server" Visible="true" AssociatedUpdatePanelID="MessagesUPanel">
                        <ProgressTemplate>
                            <img src="img/loadingAnimation.gif" />
                        </ProgressTemplate>
                    </asp:UpdateProgress>
                    <div id="MessagesText">
                        <asp:UpdatePanel runat="server" ID="MessagesUPanel" UpdateMode="Conditional">
                            <ContentTemplate>
                                <asp:ListView runat="server" ID="MessagesListView" ClientIDMode="Static">
                                    <ItemTemplate>
                                        <div class="Message" data-messageid="<%# Eval("message_id") %>">
                                            <div class="MessageSender"><%#Eval("first_name") %></div>
                                            <div class="MessageText"><%# Eval("message") %></div>
                                        </div>
                                    </ItemTemplate>
                                </asp:ListView>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </div>
                <div id="MessageTyping">
                    <div>
                        <asp:TextBox placeholder="Введите сообщение" ID="messageTxt" ClientIDMode="Static" Rows="5" CssClass="messageTextBox" runat="server" TextMode="MultiLine"></asp:TextBox>
                    </div>
                    <div>
                        <asp:Button ID="sendMessage" runat="server" OnClientClick="return false" ClientIDMode="Static" CssClass="btn btn-middle btn-send" Text="Отправить" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

