using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Text.RegularExpressions;
using System.Web.Services;
using System.Data.Common;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Web.Configuration;
using System.Net.Mail;
using System.Security.Cryptography;

public partial class Register : System.Web.UI.Page
{
    private int AmountError = 0;
    private string CorrectImg = @"~/img/imgRegister/Correct.png";
    private string ErrorImg = @"~/img/imgRegister/Error.png";
    protected void Validation(TextBox txt, Image image, string regV, bool mandatory)
    {
        if (Regex.IsMatch(txt.Text, regV))
        {
            image.ImageUrl = CorrectImg;
        }
        else
        {
            if (txt.Text.Count() == 0 && mandatory == false)
                image.ImageUrl = CorrectImg;
            else
            {
                AmountError++;
                image.ImageUrl = ErrorImg;
            }
        }
    }
    protected void PickCodeCountru()
    {
        this.DropDownListTBmobile.Items.Insert(0, new ListItem("Украина (+380)", "+380"));
        this.DropDownListTBmobile.Items.Insert(0, new ListItem("Россия (+7)", "+7"));
        this.DropDownListTBmobile.Items.Insert(0, new ListItem("Вибор страны", ""));
    }

    protected void PickCountry()
    {
        SqlConnection conn;
        string connString = WebConfigurationManager.ConnectionStrings["connString"].ConnectionString;
        conn = new SqlConnection(connString);
        //To check id string for security
        DataTable dt = new DataTable("persons");
        SqlDataAdapter ad = new SqlDataAdapter("SELECT * FROM countries", conn);
        conn.Open();
        ad.Fill(dt);
        conn.Close();
        if (dt.Rows.Count != 0)
        {
            int NuvbersRow = dt.Rows.Count;
            string[] Array_country_name = new string[NuvbersRow];
            for (int i = 0; i < NuvbersRow; i++)
            {
                DataRow dr = dt.Rows[i];
                this.DropDownListTBcountry.Items.Insert(0, new ListItem(dr["country_name"].ToString(), dr["country_id"].ToString()));
            }
            this.DropDownListTBcountry.Items.Insert(0, new ListItem("Пусто", "0"));
            
        } 
    }
    protected void PickCity()
    {
        SqlConnection conn;
        string connString = WebConfigurationManager.ConnectionStrings["connString"].ConnectionString;
        conn = new SqlConnection(connString);
        //To check id string for security
        DataTable dt = new DataTable("persons");
        SqlDataAdapter ad = new SqlDataAdapter("SELECT * FROM cities", conn);
        conn.Open();
        ad.Fill(dt);
        conn.Close();
        if (dt.Rows.Count != 0)
        {
            int NuvbersRow = dt.Rows.Count;
            string[] Array_country_name = new string[NuvbersRow];
            for (int i = 0; i < NuvbersRow; i++)
            {
                DataRow dr = dt.Rows[i];
                this.DropDownListTBcity.Items.Insert(0, new ListItem(dr["city_name"].ToString(), dr["country_id"].ToString()));
            }


        }
    }
    string GetHashString(string s)
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
    protected void Page_Load(object sender, EventArgs e)
    {
       // this.TBfirst_name.Text = Request.QueryString["id"] ?? "";
        if (this.Page.IsPostBack)
        {
            Validation(this.TBfirst_name, this.TBfirst_nameImg, @"(^[a-zA-Zа-яёА-ЯЁіІїЇєЄ]{2,}$)", true);
            Validation(this.TBlast_name, this.TBlast_nameImg, @"(^[a-zA-Zа-яёА-ЯЁіІїЇєЄ]{2,}$)", true);
            Validation(this.TBbirthday, this.TBbirthdayImg, @"(?<![\W\w])((\d){4}-(\d){2}-(\d){2})(?![\W\w])", true);
            Validation(this.TBmobile, this.TBmobileImg, @"^\+\d{7,}$", false);
            Validation(this.TBPassword, this.TBPasswordImg, @"^([0-9a-zA-Z]{5,}$)", true);
            if(GetEmal(this.TBemail.Text)==0)
            {
                Validation(this.TBemail, this.TBemailImg, @"(^[A-Za-z0-9](([_\.\-]?[a-zA-Z0-9]+)*)@([A-Za-z0-9]+)(([\.\-]?[a-zA-Z0-9]+)*)\.([A-Za-z]{2,})$)", true);
            }
            else Validation(this.TBemail, this.TBemailImg, @"^(asdsfdgsdf96gsdfg9sd76fgsfd56g7sdf4gsdfg70sdf6g0sdf6gs9d8f6gs9df)", true);
            if (this.TBcountry.Text != "")
            {
                var dic = GetCountry(this.TBcountry.Text);
                if (dic.Count == 0)
                {
                    Validation(this.TBcountry, this.TB1Img, @"^(asdsfdgsdf96gsdfg9sd76fgsfd56g7sdf4gsdfg70sdf6g0sdf6gs9d8f6gs9df)", false);
                    AmountError++;
                }
                else Validation(this.TBcountry, this.TB1Img, @"(^[a-zA-Zа-яёА-ЯЁІіЇїЄє\s]{2,}$)", false);
                
            }
            if (this.TBcity.Text != "")
            {
              
                Validation(this.TBcity, this.TB2Img, @"(^[a-zA-Zа-яёА-ЯЁІіЇїЄє\s]{2,}$)", false);
                
            }
            if (AmountError == 0)
            {
                AddUser add = new AddUser(
                    this.TBfirst_name.Text,
                    this.TBlast_name.Text,
                    this.TBPassword.Text,
                    this.TBbirthday.Text,
                    this.TBmobile.Text,
                    this.TBemail.Text,
                    this.TBcountry.Text,
                    this.TBcity.Text
                    );
            }
            AmountError = 0;

        }
        else
        {
            PickCodeCountru();
            PickCountry();
            PickCity();
        }
        this.TBcountry.Text = "";
        this.TBcity.Text = "";
    }

    public static int GetEmal(string prefix)
    {
       int email = 0;
       SqlConnection conn;
        string connString = WebConfigurationManager.ConnectionStrings["connString"].ConnectionString;
        conn = new SqlConnection(connString);
        //To check id string for security
        DataTable dt = new DataTable("persons");
        SqlDataAdapter ad = new SqlDataAdapter("SELECT * FROM persons WHERE email='" + prefix + "'", conn);
        conn.Open();
        ad.Fill(dt);
        conn.Close();
        if (dt.Rows.Count != 0)
        {
            email=1;
            return email;
        }
        else return email;
    }
    [WebMethod]
    public static Dictionary<string, string> GetCountry(string prefix)
    {
        var Country = new Dictionary<string, string>();
       SqlConnection conn;
        string connString = WebConfigurationManager.ConnectionStrings["connString"].ConnectionString;
        conn = new SqlConnection(connString);
        //To check id string for security
        DataTable dt = new DataTable("persons");
        SqlDataAdapter ad = new SqlDataAdapter("SELECT * FROM countries WHERE country_name='" + prefix + "'", conn);
        conn.Open();
        ad.Fill(dt);
        conn.Close();
        if (dt.Rows.Count != 0)
        {
            int NuvbersRow = dt.Rows.Count;
            string[] Array_country_name = new string[NuvbersRow];
            for (int i=0; i < NuvbersRow; i++)
            {
                DataRow dr = dt.Rows[i];
                Country.Add(dr["country_id"].ToString(), dr["country_name"].ToString());
                Array_country_name[i] = dr["country_name"].ToString();
            }
            return Country;
        }
        else return Country;
        
    }

    [WebMethod]
    public static Dictionary<string, string> GetCity(string prefix,string id)
    {
           var City = new Dictionary<string, string>();
            SqlConnection conn;
            string connString = WebConfigurationManager.ConnectionStrings["connString"].ConnectionString;
            conn = new SqlConnection(connString);
            //To check id string for security
            DataTable dt = new DataTable("persons");
            string Top = "";
            if (prefix.Length == 0)
            {
                Top = "TOP 3";
            }
            SqlDataAdapter ad = new SqlDataAdapter("SELECT " + Top + " * FROM cities WHERE country_id=" + id + " AND city_name LIKE '" + prefix + "%'", conn);
            conn.Open();
            ad.Fill(dt);
            conn.Close();
            if (dt.Rows.Count != 0)
            {
                int NuvbersRow = dt.Rows.Count;
                string[] Array_country_name = new string[NuvbersRow];
                for (int i = 0; i < NuvbersRow; i++)
                {
                    DataRow dr = dt.Rows[i];
                    City.Add(dr["city_id"].ToString(), dr["city_name"].ToString());
                    Array_country_name[i] = dr["city_name"].ToString();
                }
                return City;
            }

            return City;
    }
}