<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<asp:Content ID="MainContent" ContentPlaceHolderID="ContentPlaceHolder" runat="Server">
    <div id="MainBlock">
        <div id="InnerBlock">
            <div class="block left-block" id="Avatar">
            </div>
            <div class="block right-block" id="Info"></div>
            <div class="block left-block" id="Friends">
            </div>
            <div class="block right-block" id="QuickMessage">
                <div id="MessageText">
                    <asp:TextBox ID="messageTxt" Rows="5" CssClass="messageTextBox" runat="server" TextMode="MultiLine"></asp:TextBox>
                </div>
                <div id="ControlPanel">
                    <asp:Button ID="sendMessage" runat="server" CssClass="btn btn-middle btn-send" Text="Отправить" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>

