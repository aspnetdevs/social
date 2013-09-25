using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net.Mail;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Configuration;

/// <summary>
/// Summary description for AddUser
/// </summary>
public class AddUser
{
    private string GetHashString(string s)
    {
        //переводим строку в байт-массим  
        byte[] bytes = Encoding.Unicode.GetBytes(s);
        //создаем объект для получения средст шифрования  
        MD5CryptoServiceProvider CSP =
            new MD5CryptoServiceProvider();
        //вычисляем хеш-представление в байтах  
        byte[] byteHash = CSP.ComputeHash(bytes);
        string hash = string.Empty;
        //формируем одну цельную строку из массива  
        foreach (byte b in byteHash)
            hash += string.Format("{0:x2}", b);
        return hash;
    }
    private int GetAdress(string prefix, string slect)
    {
        int AdressId = 0;
        SqlConnection conn;
        string connString = WebConfigurationManager.ConnectionStrings["connString"].ConnectionString;
        conn = new SqlConnection(connString);
        SqlDataAdapter ad = new SqlDataAdapter("" + slect + prefix + "'", conn);

        DataTable dt = new DataTable("persons");
        conn.Open();
        ad.Fill(dt);
        conn.Close();
        if (dt.Rows.Count != 0)
        {
            DataRow dr = dt.Rows[0];
            AdressId = Convert.ToInt32(dr["country_id"].ToString());
            return AdressId;
        }
        else return AdressId;
    }
    public AddUser(string first_name, string last_name, string password, string birthday, string mobile, string email, string country, string city)
    {

        int CountriId = GetAdress(country, "SELECT * FROM countries WHERE country_name='");
        int cityId = GetAdress(city, "SELECT  * FROM cities WHERE country_id=" + CountriId + " AND city_name='");
        string city_name = "";
        if (cityId == 0) city_name = city;
        DateTime dt = DateTime.Now;
        string confirmation_by_email = GetHashString(first_name + last_name + password);

        SqlConnection conn;
        string connString = WebConfigurationManager.ConnectionStrings["connString"].ConnectionString;
        conn = new SqlConnection(connString);
        SqlCommand cmd = new SqlCommand("INSERT INTO persons (first_name,last_name,password,IsMale,birthday,mobile,email,country_id,city_id,city_name,isAutorized,register_date,confirmation_by_email) VALUES (@first_name,@last_name,@password,@IsMale,@birthday,@mobile,@email,@country_id,@city_id,@city_name,@isAutorized,@register_date,@confirmation_by_email)", conn);
        conn.Open();
        cmd.Parameters.Add(new SqlParameter("@first_name", first_name));
        cmd.Parameters.Add(new SqlParameter("@last_name", last_name));
        cmd.Parameters.Add(new SqlParameter("@password", password));
        cmd.Parameters.Add(new SqlParameter("@IsMale", true));
        cmd.Parameters.Add(new SqlParameter("@birthday", Convert.ToDateTime(birthday)));
        cmd.Parameters.Add(new SqlParameter("@mobile", mobile));
        cmd.Parameters.Add(new SqlParameter("@email", email));
        cmd.Parameters.Add(new SqlParameter("@country_id", CountriId));
        cmd.Parameters.Add(new SqlParameter("@city_id", cityId));
        cmd.Parameters.Add(new SqlParameter("@city_name", city_name));
        cmd.Parameters.Add(new SqlParameter("@isAutorized", false));
        cmd.Parameters.Add(new SqlParameter("@register_date", dt));
        cmd.Parameters.Add(new SqlParameter("@confirmation_by_email", confirmation_by_email));
        cmd.ExecuteNonQuery();
        conn.Close();


        var mailmsg = new System.Net.Mail.MailMessage();
        mailmsg.From = new MailAddress("phalyush@gmail.com");
        mailmsg.To.Add(email);
        mailmsg.Subject = "subject";
        mailmsg.IsBodyHtml = true;
        string refsite = @"http://localhost/social/isAvtorized.aspx?avt=";
        mailmsg.Body = "<a href='" + refsite + confirmation_by_email + "'>Авторизация</a>";
        mailmsg.Priority = System.Net.Mail.MailPriority.Normal;
        var client = new System.Net.Mail.SmtpClient();
        client.Host = "smtp.gmail.com";
        client.Port = 587;
        client.Credentials = new System.Net.NetworkCredential("phalyush@gmail.com", "5297648fac");
        client.EnableSsl = true;
        var userstate = mailmsg;
        client.Send(mailmsg);

    }
}