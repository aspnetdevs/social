<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="Styles/Register.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
    <div  class="FonBlock">
         <div class="CenterBlock">
             <div class="Welcome">
               <p>Добро пожаловать</p>
             </div>

             <div class="SelectRegistry">
                 <ul>
                     <li>E-mail</li>
                     <li></li>
                 </ul>
                 <div class="RegTextBox">
                     <asp:TextBox ID="TBfirst_name" runat="server" MaxLength="30"></asp:TextBox>
                 </div>
                 <ul>
                     <li>Пароль</li>
                     <li></li>
                 </ul>
                 <div class="RegTextBox">
                     <asp:TextBox ID="TBlast_name" runat="server" MaxLength="30"></asp:TextBox>
                 </div>
                 <div class="EnterButton">
                     <asp:Button ID="TBenter" runat="server" Text="Вход" BorderStyle="None" />
                 </div>

             </div>
         </div>
    </div>
    </form>
</body>
</html>
