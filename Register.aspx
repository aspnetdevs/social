<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Register.aspx.cs" Inherits="Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="script/jquery-2.0.0.min.js"></script>
    <link href="Styles/Register.css" rel="stylesheet" />
    <script src="script/Register.js"></script>
    <script src="script/ValidationReg.js"></script>
    <script src="script/jquery.selectbox.js"></script>
    <link href="style/selectbox.css" rel="stylesheet" />
    	<script>
    	    (function ($) {
    	        $(function () {
    	            $('select').selectbox();
    	        })
    	    })(jQuery)
	</script>
    <script>
       

    </script>
</head>

<body>
    <form id="form1" runat="server">
        <div class="backgroundBlock">
            <div class="RegisterCenterBlock">
                <div class="EnterDate">

                    <ul>
                        <li>Имя</li>
                        <li></li>
                    </ul>
                    <div class="RegisterTextBox">
                        <asp:TextBox placeholder="Введите имя" CssClass="ValidarionReg" ID="TBfirst_name" runat="server" MaxLength="30"></asp:TextBox>
                        <asp:Image CssClass="Mandetry" ImageUrl="img/imgRegister/Empty.png" ID="TBfirst_nameImg" runat="server" />
                    </div>

                    <ul>
                        <li>Фамилия</li>
                        <li></li>
                    </ul>
                    <div class="RegisterTextBox">
                        <asp:TextBox placeholder="Введите фамилию" CssClass="ValidarionReg" ID="TBlast_name" runat="server" MaxLength="30"></asp:TextBox>
                        <asp:Image ImageUrl="img/imgRegister/Empty.png" ID="TBlast_nameImg" runat="server" />
                    </div>

                    <ul>
                        <li>Пароль</li>
                        <li></li>
                    </ul>
                    <div class="RegisterTextBox">
                        <asp:TextBox placeholder="Больше 5 символов" CssClass="ValidarionReg" ID="TBPassword" runat="server" MaxLength="30" TextMode="Password"></asp:TextBox>
                        <asp:Image ImageUrl="img/imgRegister/Empty.png" ID="TBPasswordImg" runat="server" />
                    </div>

                    <ul>
                        <li>Подтверждение пароля</li>
                        <li></li>
                    </ul>
                    <div class="RegisterTextBox">
                        <asp:TextBox placeholder="Подтвердите пароль" CssClass="ValidarionReg" ID="TBConfirmPassword" runat="server" MaxLength="30" TextMode="Password"></asp:TextBox>
                        <asp:Image ImageUrl="img/imgRegister/Empty.png" ID="TBConfirmPasswordImg" runat="server" />
                    </div>


                    <p class="B_next">Next</p>
                    <asp:Button ID="Button1" runat="server" Text="Button" />
                </div>

            </div>
            <div class="RegisterCenterBlock">
                <div class="EnterDate">

                    <ul>
                        <li>Дата рождения</li>
                        <li></li>
                    </ul>
                    <div class="RegisterTextBox">
                        <asp:TextBox CssClass="ValidarionReg" ID="TBbirthday" runat="server" MaxLength="30">2012-12-12</asp:TextBox>
                        <asp:Image ImageUrl="img/imgRegister/Empty.png" ID="TBbirthdayImg" runat="server" />
                    </div>

                    <ul>
                        <li>Мобильный телефон</li>
                        <li></li>
                    </ul>
                    <div class="RegisterTextBox">
                        <asp:TextBox placeholder="+38(044)555-55-55" CssClass="ValidarionReg" ID="TBmobile" runat="server" MaxLength="30"></asp:TextBox>
                        <asp:Image ImageUrl="img/imgRegister/Empty.png" ID="TBmobileImg" runat="server" />
                    </div>
                    <div class="section maxheight">
                        <asp:DropDownList ID="DropDownListTBmobile" runat="server" ClientIDMode="Static">
                        </asp:DropDownList>
                    </div>
                    <ul>
                        <li>Skype</li>
                        <li></li>
                    </ul>
                    <div class="RegisterTextBox">
                        <asp:TextBox ID="TBSkype" runat="server" MaxLength="30"></asp:TextBox>
                    </div>

                    <ul>
                        <li>Мобильный телефон</li>
                        <li></li>
                    </ul>
                    <div class="RegisterTextBox">
                        <asp:TextBox ID="TextBox12" runat="server" MaxLength="30"></asp:TextBox>
                    </div>

                    <p class="B_previously">Previously</p>
                    <p class="B_next">Next</p>
                </div>
            </div>
            <div class="RegisterCenterBlock">
                <div class="EnterDate">
                    <ul>
                        <li>sdgdfhgdfgsdf</li>
                        <li></li>
                    </ul>
                    <div class="RegisterTextBox">
                        <asp:TextBox ID="TextBox1" runat="server" MaxLength="30"></asp:TextBox>
                    </div>

                    <ul>
                        <li>Фамилия</li>
                        <li></li>
                    </ul>
                    <div class="RegisterTextBox">
                        <asp:TextBox ID="TextBox2" runat="server" MaxLength="30"></asp:TextBox>
                    </div>

                    <ul>
                        <li>Дата рождения</li>
                        <li></li>
                    </ul>
                    <div class="RegisterTextBox">
                        <asp:TextBox ID="TextBox3" runat="server" MaxLength="30"></asp:TextBox>
                    </div>

                    <ul>
                        <li>Мобильный телефон</li>
                        <li></li>
                    </ul>
                    <div class="RegisterTextBox">
                        <asp:TextBox ID="TextBox4" runat="server" MaxLength="30"></asp:TextBox>
                    </div>

                    <p class="B_previously">Previously</p>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
