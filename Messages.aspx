<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="Messages.aspx.cs" Inherits="Messages" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder" runat="Server">
    <div class="block right-block top-block" id="Messages">
        <div style="height: 7%;">
            <span class="block-title">Сообщения</span>
            <hr style="margin: 5px 0 0;" />
        </div>
        <div style="height: 93%;">
            <div id="FriendsToTalkBlock">
                <div id="WrapperFriendsList">
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
                </div>
            </div>
            <div id="MessagesBlock">
                <div id="MessagesList">
                    <div id="TalkTo">
                        <div>
                            Кому:
                        <asp:TextBox runat="server" ClientIDMode="Static" ID="TalkToTxt" />
                        </div>
                    </div>
                    <div id="MessagesText">
                        <div id="WrapperMessagesListView">
                            <asp:ListView runat="server" ID="MessagesListView" ClientIDMode="Static">
                                <ItemTemplate>
                                    <div class="Message">
                                        <div class="MessageSender"><%#Eval("first_name") %></div>
                                        <div class="MessageText"><%# Eval("message") %></div>
                                    </div>
                                </ItemTemplate>
                            </asp:ListView>
                        </div>
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

