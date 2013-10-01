<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<%@ MasterType VirtualPath="~/Main.master" %>
<asp:Content ID="MainContent" ContentPlaceHolderID="ContentPlaceHolder" runat="Server">

    <div class="block right-block top-block" id="Info">
        <span class="block-title"><%=person.Fields["first_name"] %> <%=person.Fields["last_name"] %></span><span id="Status"><%=person.Fields["status"] %></span>
        <hr style="margin: 5px 0 0;" />
        <dl class="dl-horizontal">
            <dt>Дата рождения:</dt>
            <dd><%=Convert.ToDateTime(person.Fields["birthday"]).ToString("d MMMM yyyy") %></dd>
            <dt>Мобильный телефон:</dt>
            <dd><%=person.Fields["mobile"] %></dd>
            <dt>E-mail:</dt>
            <dd><%=person.Fields["email"] %></dd>
        </dl>
        <div id="MessageTyping">
            <div>
                <asp:TextBox placeholder="Введите сообщение" ID="messageTxt" Rows="5" CssClass="messageTextBox" runat="server" TextMode="MultiLine"></asp:TextBox>
            </div>
            <div>
                <asp:Button ID="sendMessage" runat="server" CssClass="btn btn-middle btn-send" Text="Отправить" />
            </div>
        </div>
    </div>
</asp:Content>

