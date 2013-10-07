<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="Messages.aspx.cs" Inherits="Messages" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder" runat="Server">
    <input runat="server" type="hidden" clientidmode="Static" id="talkingFriendId" />

    <script>
        $(function () {

            var scrollMessagesList = jQuery('#MessagesList').jScrollPane({ showArrows: true });
            var apiSML = scrollMessagesList.data('jsp');
            var scrollFriendsList = jQuery('#FriendsToTalkBlock').jScrollPane({ showArrows: true, contentWidth: '0px' });
            var apiSFL = scrollFriendsList.data('jsp');


            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
                apiSML.reinitialise();
                apiSML.scrollToBottom();
            });

            var talkingFriendId = 0;
            function ReplaceSpacesToOne(str) {
                var reg = /(\s){2,}/;
                return str.replace(reg, " ");
            }

            $("#TalkToTxt").keyup(function () {
                //Allow only All symbols + backspace
                <%=ClientScript.GetPostBackEventReference(FriendListUPanel,"")%>
            });

            $("#MessagesText").delegate(".DeleteMessage", "click", function () {
                var $MessageDiv = $(this).closest(".Message");
                $.ajax({
                    type: "POST",
                    url: "AjaxMessagesHandler.ashx",
                    data: { messageId: $MessageDiv.attr("data-messageid"), senderId: $MessageDiv.attr("data-senderid") },
                    success: function ()
                    {
                        $MessageDiv.remove();
                        apiSML.reinitialise();
                        apiSML.scrollToBottom();
                    }
                });
            });

            $("#FriendsToTalkBlock").delegate(".FriendAvatar", "click", function () {
                //It doesn't work
                //<=ClientScript.GetPostBackEventReference(FriendListUPanel,"empty")%>

                talkingFriendId = $(this).siblings().attr("data-id");
                if ($("#talkingFriendId").val() != talkingFriendId) {
                    $("#TalkToTxt").val(ReplaceSpacesToOne($(this).siblings().text().trim()));
                    //Some little manipulation. Need to pass data with _dopostback function
                    $("#talkingFriendId").val(talkingFriendId);
                    $("#<%=MessagesUPanel.ClientID%>").text("");
                    apiSML.reinitialise();
                    <%=ClientScript.GetPostBackEventReference(MessagesUPanel,"")%>
                }
            });

            $("#MessagesList").delegate(".Message", "mouseout", function () {
                $(this).removeClass("hover");
                $(this).find(".MessageControl").hide();
            });
            $("#MessagesList").delegate(".Message", "mouseover", function () {
                $(this).addClass("hover");
                $(this).find(".MessageControl").show();
            });


            $("#sendMessage").click(function () {
                if ($("#messageTxt").val()) {
                    $.ajax({
                        type: "POST",
                        url: "AjaxMessagesHandler.ashx",
                        data: { action:"sendMessage", receiverId: talkingFriendId, messageText: $("#messageTxt").val() },
                        success: function () {
                            if (talkingFriendId > 0) {
                                $("#messageTxt").val("");
                            }
                        },
                        error: function () {
                            alert("Error in ajax to AjaxMessagesHandler");
                        }
                    });
                }
            });
            setInterval(function () {
                $.ajax({
                    type: "POST",
                    url: "AjaxMessagesHandler.ashx",
                    data: { action:"getLastMessages",lastMessageId: $("#<%=MessagesUPanel.ClientID%> div.Message").last().attr("data-messageid"), talkingFriendId: talkingFriendId },
                    success: function (result) {
                        if (result) {
                            $(result).appendTo($("#<%=MessagesUPanel.ClientID%>"));
                            apiSML.reinitialise();
                            apiSML.scrollToBottom();
                        }
                        else {
                            //Label "No messages"
                        }
                    },
                    error: function () {
                        alert("Error in get Last Messages")
                    }
                });
            }, 1000);
        });
    </script>

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
                <asp:UpdateProgress DisplayAfter="100" ClientIDMode="Static" ID="MessagesProgress" runat="server" Visible="true" AssociatedUpdatePanelID="MessagesUPanel">
                    <ProgressTemplate>
                        <img src="img/loadingAnimation.gif" />
                    </ProgressTemplate>
                </asp:UpdateProgress>
                <div id="TalkTo">
                    <div>
                        Кому:
                        <asp:TextBox runat="server" ClientIDMode="Static" ID="TalkToTxt" />
                    </div>
                </div>
                <div id="MessagesList">

                    <div id="MessagesText">
                        <asp:UpdatePanel runat="server" ID="MessagesUPanel" UpdateMode="Conditional">
                            <ContentTemplate>
                                <asp:ListView runat="server" ID="MessagesListView" ClientIDMode="Static">
                                    <ItemTemplate>
                                        <div class="Message" data-senderid="<%# Eval("id") %>" data-messageid="<%# Eval("message_id") %>">
                                            <div class="MessageSender"><%#Eval("first_name") %></div>
                                            <div class="MessageText"><%# Eval("message") %></div>
                                            <div class="MessageControl">
                                                <div class="DeleteMessage">
                                                    <img src="img/delete.png" />
                                                </div>
                                            </div>
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

