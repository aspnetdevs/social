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
                <asp:DataList ID="FriendsList" ClientIDMode="Static" RepeatDirection="Vertical" RepeatColumns="1" runat="server">
                    <ItemTemplate>
                        <div data-id='<%#Eval("ID") %>' style="display:none;"></div>
                        <div class="FriendAvatar">
                            <asp:Image ID="Image2" runat="server" ImageUrl='<%# Eval("MiniAvatarUrl") %>' />
                        </div>
                        <div class="FriendName">
                            <%# Eval("FirstName")%><br />
                            <%#Eval("LastName") %>
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
                </div>
                <div id="MessageTyping">
                    <div id="MessageText">
                        <asp:TextBox placeholder="Введите сообщение" ID="messageTxt" Rows="5" CssClass="messageTextBox" runat="server" TextMode="MultiLine"></asp:TextBox>
                    </div>
                    <div id="ControlPanel">
                        <asp:Button ID="sendMessage" runat="server" CssClass="btn btn-middle btn-send" Text="Отправить" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

