<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<%@ MasterType VirtualPath="~/Main.master" %>
<asp:Content ID="MainContent" ContentPlaceHolderID="ContentPlaceHolder" runat="Server">
    <script>
        $(document).ready(function () {
            var Friends = $("#Friends");
            var FriendsList = $("#FriendsList");
            var top_block = $(".top-block");
            var heightF = Friends.css("height");
            var widthF = Friends.css("width");
            var marrginTopF = parseInt(top_block.css("margin-top"));
            var marginTop = parseInt(-Friends.position().top + parseInt(marrginTopF));
            $("#sizeFriends").click(function () {
                
                
                if ($(this).attr("class") == "Zoom") {
                    $(this).removeClass("Zoom");
                    Friends.animate({ "margin-top": "-=" + (marginTop - marrginTopF) + "px", "width": widthF, "height": heightF }, 300);
                    $(this).attr("src", "img/imgSocial/sizeFriends.png").removeClass("Zoom");
                }
                else {
                    Friends.animate({ "margin-top": marginTop+"px", "width": "100%", "height": "550px" }, 300);
                    $(this).attr("src", "img/imgSocial/ReSizeFriends.png").addClass("Zoom");
                }
                //Friends.load("Default.aspx #FriendsList", { RepeatColum: "1" });
                //  Friends.css({ "position": "absolute" });
            })
        })
    </script>

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

