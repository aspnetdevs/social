using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        SmtpClient Smtp = new SmtpClient("smtp.gmail.com", 465);
        Smtp.Credentials = new NetworkCredential("phalyush@gmail.com", "Phalyush@bk.ru");
        Smtp.EnableSsl = true;
        MailMessage Message = new MailMessage();
        Message.SubjectEncoding = Encoding.GetEncoding(1251);
        Message.BodyEncoding = Encoding.GetEncoding(1251);
        Message.From = new MailAddress("phalyush@gmail.com");
        Message.To.Add(new MailAddress("Phalyush@bk.ru"));
        Message.Subject = "тема";
        Message.Body = "сообщение";
       Smtp.Send(Message);
        
       
    }
}