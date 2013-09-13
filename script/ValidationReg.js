$(document).ready(function () {
    var ValidarionReg = $(".ValidarionReg");
    var SpeedAnimation = 500;
    var CorrectImg = "img/imgRegister/Correct.png";
    var ErrorImg = "img/imgRegister/Error.png";
    var CodeCountry = ["+380", "+7"];

    function Animation(Item, src) {
        if (src != $("#" + Item + " ~ img").attr("src"))
            $("#" + Item + " ~ img")
                    .css("opacity", "0")
                    .attr("src", src)
                    .animate({ "opacity": "1" }, SpeedAnimation);
    }
    function ValidationCheck(RegV, Item,Mandetry) {
        var ValueItem = $("#" + Item).val();
        if (RegV.test(ValueItem) && ValueItem.length!=0) {
            Animation(Item, CorrectImg);
        }
        else {
            if (ValueItem.length == 0 && Mandetry == false)
                Animation(Item, CorrectImg);
            else
                Animation(Item, ErrorImg);
           
        }
    }


    ValidarionReg.keyup(function () {
        var IdItem = $(this).attr("id");
        var valIdItem = $("#" + IdItem).val();
        function UpperFirstLiter() {
            if (valIdItem.length>0)
            $("#" + IdItem).val(valIdItem[0].toUpperCase() + valIdItem.substring(1, valIdItem.length));
        }
        switch (IdItem) {
            case "TBfirst_name":
                UpperFirstLiter();
                ValidationCheck(/(^[a-zA-Zа-яёА-ЯЁІіЇїЄє]{2,}$)/, IdItem, true);
                break;
            case "TBlast_name":
                UpperFirstLiter();
                ValidationCheck(/(^[a-zA-Zа-яёА-ЯЁІіЇїЄє]{2,}$)/, IdItem, true);
                break;
            case "TBbirthday":
                ValidationCheck(/^(\d){4}-(\d){2}-(\d){2}/, IdItem,true);//(?<![\W\w])((\d){4}-(\d){2}-(\d){2})(?![\W\w])
                break;
            case "TBmobile":
                ValidationCheck(/^\+\d{7,}$/, IdItem, false);
                break;
            case "TBPassword":
                ValidationCheck(/^([0-9a-zA-Z]{5,}$)/, IdItem, true);
                break;
            case "TBConfirmPassword":
                if ($("#" + IdItem).val() == $("#TBPassword").val())
                    Animation(IdItem, CorrectImg)
                else Animation(IdItem, ErrorImg);
                break;
        }
    })
    
    $("#DropDownListTBmobile").change(function () {
        var currentCodeCountry = "";
        if ($("#TBmobile").val().length != 0) {
            for (var i = 0; i < CodeCountry.length; ++i) {
                if ($("#TBmobile").val().indexOf(CodeCountry[i]) == 0)
                { $("#TBmobile").val($("#TBmobile").val().replace(CodeCountry[i], $(this).val())).focus(); }
            };
        }
        else { $("#TBmobile").val($(this).val()).focus();}
      
    })
});