<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<asp:Content ID="MainContent" ContentPlaceHolderID="ContentPlaceHolder" runat="Server">
    <div id="MainBlock">
        <div id="InnerBlock">
            <div class="block left-block top-block" runat="server" clientidmode="Static" id="Avatar">
            </div>
            <div class="block right-block top-block" id="Info">
                <span id="FullName"><%=person.FirstName %> <%=person.LastName %></span><span id="Status"><%=person.Status %></span>
                <hr style="margin: 5px 0 0;" />
                <dl class="dl-horizontal">
                    <dt>Дата рождения:</dt>
                    <dd><%=person.Birthday.ToString("d MMMM yyyy") %></dd>
                    <dt>Мобильный телефон:</dt>
                    <dd><%=person.Mobile %></dd>
                    <dt>E-mail:</dt>
                    <dd><%=person.Email %></dd>
                </dl>
                <div id="QuickMessage">
                    <div id="MessageText">
                        <asp:TextBox placeholder="Введите сообщение" ID="messageTxt" Rows="5" CssClass="messageTextBox" runat="server" TextMode="MultiLine"></asp:TextBox>
                    </div>
                    <div id="ControlPanel">
                        <asp:Button ID="sendMessage" runat="server" CssClass="btn btn-middle btn-send" Text="Отправить" />
                    </div>
                </div>
            </div>
            <div class="block left-block bottom-block" id="Friends">
                <asp:DataList ID="FriendsList" ClientIDMode="Static" RepeatDirection="Horizontal" RepeatColumns="4" runat="server">
                    <ItemTemplate>
                        <div class="FriendAvatar">&nbsp</div>
                        <div class="FriendName"><%# Eval("FirstName")%><br />
                            <%#Eval("LastName") %></div>
                    </ItemTemplate>
                </asp:DataList>
                <%--                <% if (person.Friends != null)
                   {
                       foreach (var friend in person.Friends)
                       { %>
                <div class="FriendBlock">
                    <div class="FriendAvatar">
                    </div>
                    <div class="FriendName">
                        <a href="Default.aspx?id=<%=friend.ID %>"><%=friend.FirstName + " " + friend.LastName%></a>
                    </div>
                </div>
                <% }
                   } %>--%>
            </div>
    </div>
    </div>
</asp:Content>

