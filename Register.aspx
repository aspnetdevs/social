<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Register.aspx.cs" Inherits="Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="js/jquery-1.7.1.min.js"></script>
    <link href="Styles/Register.css" rel="stylesheet" />
    <script src="js/Register.js"></script>
    <script>

        function validation_name(control, args) {
            args.IsValid = false;
            if (/\s/.test(args.Value) || !args.Value) {
                 $("#Validator_first_name").css("opacity", "0")
                     .html('<img src="img/imgRegister/Error.png" />')
                 .animate({ "opacity": "1" }, 500);
            }
            else { args.IsValid = true; }
            
        }

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
                        <asp:TextBox ID="TBfirst_name" runat="server" MaxLength="30"></asp:TextBox>
                        <asp:CustomValidator ID="Validator_first_name" runat="server" ErrorMessage="*" ClientValidationFunction="validation_name" ControlToValidate="TBfirst_name" ClientIDMode="Static">*</asp:CustomValidator>
                    </div>

                    <ul>
                        <li>Фамилия</li>
                        <li></li>
                    </ul>
                    <div class="RegisterTextBox">
                        <asp:TextBox ID="TBlast_name" runat="server" MaxLength="30"></asp:TextBox>
                    </div>

                    <ul>
                        <li>Дата рождения</li>
                        <li></li>
                    </ul>
                    <div class="RegisterTextBox">
                        <asp:TextBox ID="TBbirthday" runat="server" MaxLength="30"></asp:TextBox>
                    </div>

                    <ul>
                        <li>Мобильный телефон</li>
                        <li></li>
                    </ul>
                    <div class="RegisterTextBox">
                        <asp:TextBox ID="mobile" runat="server" MaxLength="30"></asp:TextBox>
                    </div>

                    <p class="B_next">Next</p>
                    <asp:Button ID="Button1" runat="server" Text="Button" />
                </div>

            </div>
            <div class="RegisterCenterBlock">
                <div class="EnterDate">

                    <ul>
                        <li>2222</li>
                        <li></li>
                    </ul>
                    <div class="RegisterTextBox">
                        <asp:TextBox ID="TextBox9" runat="server" MaxLength="30"></asp:TextBox>
                    </div>

                    <ul>
                        <li>Фамилия</li>
                        <li></li>
                    </ul>
                    <div class="RegisterTextBox">
                        <asp:TextBox ID="TextBox10" runat="server" MaxLength="30"></asp:TextBox>
                    </div>

                    <ul>
                        <li>Дата рождения</li>
                        <li></li>
                    </ul>
                    <div class="RegisterTextBox">
                        <asp:TextBox ID="TextBox11" runat="server" MaxLength="30"></asp:TextBox>
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
                        <li>3333</li>
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
