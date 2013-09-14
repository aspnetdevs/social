<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<asp:Content ID="MainContent" ContentPlaceHolderID="ContentPlaceHolder" runat="Server">
    <div id="MainBlock">
        <div id="InnerBlock">
            <div class="block left-block top-block" runat="server" clientidmode="Static" id="Avatar">
                <div id="AvatarContainer">
                    <div style="height: 100%">
                        <asp:Image ID="Image1" runat="server"></asp:Image>
                        <div id="UnderAvatarPanel">
                            <button id="selectPhoto" class="btn btn-mini btn-avatar-panel">Выбрать фото</button>
                        </div>
                    </div>
                </div>
                <div id="dialog" title="Выбор фото">
                    <div>
                        <span id="photoInputBtn" class="btn btn-large fileinput-button">
                            <span>Выбор фото</span>
                            <input id="fileupload" type="file" name="files[]" />
                        </span>
                        <button id="uploadPhoto" class="btn btn-large" style="display: none">Загрузить</button>
                        <br />
                        <br />
                        <div id="files" class="files"></div>
                        <br />
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h4 class="panel-title">Примечание:</h4>
                            </div>
                            <div class="panel-body">
                                <ul>
                                    <li>Максимальный размер изображения - <strong>5 МБ</strong></li>
                                    <li>Поддерживаются только (<strong>JPG, GIF, PNG</strong>) изображения</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
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
                        <div class="FriendAvatar">
                            <asp:Image runat="server" ImageUrl='<%# Eval("MiniAvatarUrl") %>'/></div>
                        <div class="FriendName">
                            <%# Eval("FirstName")%><br />
                            <%#Eval("LastName") %>
                        </div>
                    </ItemTemplate>
                </asp:DataList>
            </div>
        </div>
    </div>
</asp:Content>

