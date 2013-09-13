using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Text.RegularExpressions;

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
        this.DropDownListTBmobile.Items.Insert(0, new ListItem("Россия (+7)", "+7"));
        this.DropDownListTBmobile.Items.Insert(0, new ListItem("Россия (+7)", "+7"));
        this.DropDownListTBmobile.Items.Insert(0, new ListItem("Россия (+7)", "+7"));
        this.DropDownListTBmobile.Items.Insert(0, new ListItem("Россия (+7)", "+7"));
        this.DropDownListTBmobile.Items.Insert(0, new ListItem("Россия (+7)", "+7"));
        this.DropDownListTBmobile.Items.Insert(0, new ListItem("Россия (+7)", "+7"));
        this.DropDownListTBmobile.Items.Insert(0, new ListItem("Россия (+7)", "+7"));
        this.DropDownListTBmobile.Items.Insert(0, new ListItem("Россия (+7)", "+7"));
        this.DropDownListTBmobile.Items.Insert(0, new ListItem("Россия (+7)", "+7"));
        this.DropDownListTBmobile.Items.Insert(0, new ListItem("Россия (+7)", "+7"));
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (this.Page.IsPostBack)
        {
            Validation(this.TBfirst_name, this.TBfirst_nameImg, @"(^[a-zA-Zа-яёА-ЯЁіІїЇєЄ]{2,}$)", true);
            Validation(this.TBlast_name, this.TBlast_nameImg, @"(^[a-zA-Zа-яёА-ЯЁіІїЇєЄ]{2,}$)", true);
            Validation(this.TBbirthday, this.TBbirthdayImg, @"(?<![\W\w])((\d){4}-(\d){2}-(\d){2})(?![\W\w])", true);
            Validation(this.TBmobile, this.TBmobileImg, @"^\+\d{7,}$", false);
            Validation(this.TBPassword, this.TBPasswordImg, @"^([0-9a-zA-Z]{5,}$)", true);
            if (this.TBPassword.Text == this.TBConfirmPassword.Text && this.TBConfirmPassword.Text.Length != 0)
                this.TBConfirmPasswordImg.ImageUrl = CorrectImg;
            else
            {
                AmountError++;
                this.TBConfirmPasswordImg.ImageUrl = ErrorImg;
            }
            this.TBfirst_name.Text = AmountError.ToString();
            AmountError = 0;

        }
        else
        {
            PickCodeCountru();
        }
    }
}