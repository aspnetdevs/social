<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Register.aspx.cs" Inherits="Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="script/jquery-2.0.0.min.js"></script>
    <link href="style/Register.css" rel="stylesheet" />
    <script src="script/Register.js"></script>
    <script src="script/jquery.selectbox.js"></script>
    <script src="script/ValidationReg.js"></script>
    <link href="style/selectbox.css" rel="stylesheet" />
    <script>

        $(function () {

         
            $('#DropDownListTBcountry').selectbox({
                flexbox: true,
                input: {
                    classinput: "ValidarionReg",
                    idinput :"TB1"
                },
                transferIputId: "TBcountry",
                noMatches: true,
                cleanAlsoDropDovnId: "DropDownListTBcity"
            });
            $('#DropDownListTBcity').selectbox({
                flexbox: true,
                CompareVal:"DropDownListTBcountry",
                input: {
                    classinput: "ValidarionReg",
                    idinput: "TB2"
                },
                transferIputId: "TBcity"
            });


            $("#DropDownListTBmobile").selectbox();
  
        });

    </script>
    <script>
       

    </script>
</head>

<body>
    <form id="form1" runat="server">
        <div class="backgroundBlock">
            <div class="RegisterCenterBlock">
                <div class="EnterDate">
                    <ul class="ulline">
                        <li>Имя</li>
                        <li></li>
                    </ul>
                    <div class="RegisterTextBox">
                        <asp:TextBox placeholder="Введите имя" CssClass="ValidarionReg" ID="TBfirst_name" runat="server" MaxLength="30"></asp:TextBox>
                        <asp:Image CssClass="Mandetry" ImageUrl="img/imgRegister/Empty.png" ID="TBfirst_nameImg" runat="server" />
                    </div>

                    <ul class="ulline">
                        <li>Фамилия</li>
                        <asp:EntityDataSource ID="EntityDataSource1" runat="server">
                        </asp:EntityDataSource>

                        <li></li>
                    </ul>
                    <div class="RegisterTextBox">
                        <asp:TextBox placeholder="Введите фамилию" CssClass="ValidarionReg" ID="TBlast_name" runat="server" MaxLength="30"></asp:TextBox>
                        <asp:Image ImageUrl="img/imgRegister/Empty.png" ID="TBlast_nameImg" runat="server" />
                    </div>

                    <ul class="ulline">
                        <li>Пароль</li>
                        <li></li>
                    </ul>
                    <div class="RegisterTextBox">
                        <asp:TextBox placeholder="Больше 5 символов" CssClass="ValidarionReg" ID="TBPassword" runat="server" MaxLength="30" TextMode="SingleLine"></asp:TextBox>
                        <asp:Image ImageUrl="img/imgRegister/Empty.png" ID="TBPasswordImg" runat="server" />
                    </div>

                    <ul class="ulline">
                        <li>Почта</li>
                        <li></li>
                    </ul>
                    <div class="RegisterTextBox">
                        <asp:TextBox placeholder="obschaga@gmal.ru" CssClass="ValidarionReg" ID="TBemail" runat="server" MaxLength="30" TextMode="SingleLine"></asp:TextBox>
                        <asp:Image ImageUrl="img/imgRegister/Empty.png" ID="TBemailImg" runat="server" />
                    </div>

                    <p class="B_next">Дале</p>
                </div>

            </div>
            <div class="RegisterCenterBlock">
                <div class="EnterDate">
                    <ul class="ulline">
                        <li>Страна</li>
                        <li></li>
                    </ul>
                    <div class="RegisterTextBox">
                    <asp:TextBox Style="margin-top:-9999px" ID="TBcountry" runat="server" AutoPostBack="False"></asp:TextBox>
                    <asp:Image Style="float: right" ImageUrl="img/imgRegister/Empty.png" ID="TB1Img" runat="server" />
                    <asp:DropDownList CssClass="DropDownListTBcountry" ID="DropDownListTBcountry" runat="server" ClientIDMode="Static">
                    </asp:DropDownList>
                    </div>

                    <ul class="ulline">
                        <li>Город</li>
                        <li></li>
                    </ul>
                    <div class="RegisterTextBox">
                        <asp:TextBox Style="margin-top:-9999px" ID="TBcity" runat="server"></asp:TextBox>
                    <asp:Image Style="float: right" ImageUrl="img/imgRegister/Empty.png" ID="TB2Img" runat="server" />
                    <asp:DropDownList CssClass="DropDownListTBcountry" ID="DropDownListTBcity" runat="server" ClientIDMode="Static">
                    </asp:DropDownList>
                        </div>

                    <ul class="ulline">
                        <li>Мобильный телефон</li>
                        <li></li>
                    </ul>
                    <div class="RegisterTextBox">
                        <asp:TextBox placeholder="+380445555555" CssClass="ValidarionReg" ID="TBmobile" runat="server" MaxLength="30"></asp:TextBox>
                        <asp:Image ImageUrl="img/imgRegister/Empty.png" ID="TBmobileImg" runat="server" />
                    </div>
                    <div class="section maxheight">
                        <asp:DropDownList ID="DropDownListTBmobile" runat="server" ClientIDMode="Static">
                        </asp:DropDownList>
                    </div>

                    <ul class="ulline">
                        <li>Дата рождения</li>
                        <li></li>
                    </ul>
                    <div class="RegisterTextBox">
                        <asp:TextBox CssClass="ValidarionReg" ID="TBbirthday" runat="server" MaxLength="30">2012-12-12</asp:TextBox>
                        <asp:Image ImageUrl="img/imgRegister/Empty.png" ID="TBbirthdayImg" runat="server" />
                    </div>
                    <p class="B_previously">Назад</p>
                   <asp:Button  runat="server" Text="Зарегистрироваться" />
                </div>
            </div>
        </div>
    </form>
</body>
</html>
