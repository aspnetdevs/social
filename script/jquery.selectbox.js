/*
 * jQuery SelectBox Styler v1.0.1
 * http://dimox.name/styling-select-boxes-using-jquery-css/
 *
 * Copyright 2012 Dimox (http://dimox.name/)
 * Released under the MIT license.
 *
 * Date: 2012.10.07
 *
 */

(function($) {
    $.fn.selectbox = function (Base) {
        var number_invoke = $(this);
        $(this).each(function () {

	            Base = $.extend({
	                flexbox: false,
	                CompareVal:"",
	                input: {
	                    classinput: "",
	                    idinput: "inputselect"
	                },
	                addParamAjax: {
	                },
	                transferIputId: "",
	                noMatches: false,
	                cleanAlsoDropDovnId:""
	            }, Base);

			var select = $(this);
			if (select.prev('span.selectbox').length < 1) {
				function doSelect() {
					var option = select.find('option');
					var optionSelected = option.filter(':selected');
					var optionText = option.filter(':first').text();
					if (optionSelected.length) optionText = optionSelected.text();
					var ddlist = '';
					for (var i = 0; i < option.length; i++) {
						var selected = '';
						var disabled = ' class="disabled"';
						if (option.eq(i).is(':selected')) selected = ' class="selected sel"';
						if (option.eq(i).is(':disabled')) selected = disabled;
						ddlist += '<li name="' + option.eq(i).attr("value")+ '"' + selected + '>' + option.eq(i).text() + '</li>';
					}
					var inputFlexbox = "";
					if (Base.flexbox)
					{
					    inputFlexbox = '<input style="background: #d1cfcf; font-size: 20px; margin-left: 10px; outline: none; border: 0px; width: 300px;" name="0" id="' + Base.input.idinput + '" class="inputselect ' + Base.input.classinput + '" type="text" maxlength="30">'

					}
					var selectbox =
						$('<span class="selectbox" style=" float:left; display:inline-block;position:relative">' +
                        inputFlexbox+
								'<div class="select" style="float:left;position:relative;z-index:3"><div class="text">' + optionText + '</div>'+
									'<b class="trigger"><i class="arrow"></i></b>'+
								'</div>'+
								'<div class="dropdown" style="position:absolute;z-index:5;overflow:auto;overflow-x:hidden;list-style:none">'+
									'<ul>' + ddlist + '</ul>'+
								'</div>'+
							'</span>');
					select.before(selectbox).css({position: 'absolute', top: -9999});
					var divSelect = selectbox.find('div.select');
					var divText = selectbox.find('div.text');
					var dropdown = selectbox.find('div.dropdown');
					var li = dropdown.find('li');
					var inputbox = selectbox.find(".inputselect");
					var selectHeight = selectbox.outerHeight();
					if (dropdown.css('left') == 'auto') dropdown.css({left: 0});
					if (dropdown.css('top') == 'auto') dropdown.css({top: selectHeight});
					var liHeight = li.outerHeight();
					var position = dropdown.css('top');
					dropdown.hide();

					inputbox.blur(function () {
					    if (inputbox.attr("name") == 0 && Base.noMatches) {
					        inputbox.val("");
					        if (Base.cleanAlsoDropDovnId != "")
					            $("#" + Base.cleanAlsoDropDovnId).prev().find("input").val("");
					    }
					})
				    //sort out DropDown 
					inputbox.keyup(function () {
					    $("#" + Base.transferIputId).val($(this).val());

					    inputbox.attr("name", 0);
					    if (Base.CompareVal == "") {
					        for (var i = 0; i < li.length; i++) {
					            if (inputbox.val() != "") {
					                var re = new RegExp("^(" + inputbox.val() + ")", 'gi');
					                if (re.test(li.eq(i).html())) {
					                    re = new RegExp("^(" + li.eq(i).html() + ")$", 'gi');
					                    if (re.test(inputbox.val()))
					                        inputbox.attr("name", li.eq(i).attr("name"));
					                    else inputbox.attr("name", 0)
					                    li.eq(i).show()
					                }
					                else { li.eq(i).hide(); }
					            }
					            else li.eq(i).show();
					        }
					    }
					    else {
					        for (var i = 0; i < li.length; i++) {
					            if (li.eq(i).attr("name") == $("#" + Base.CompareVal).prev().find("input").attr("name")) {
					                var re = new RegExp("^(" + inputbox.val() + ")", 'gi');
					                if (re.test(li.eq(i).html())) {
					                    re = new RegExp("^(" + li.eq(i).html() + ")$", 'gi');
					                    if (re.test(inputbox.val()))
					                        inputbox.attr("name", li.eq(i).attr("name"));
					                    else inputbox.attr("name", 0)
					                    li.eq(i).show()
					                }
					                else { li.eq(i).hide(); }
					            }
					            else { li.eq(i).hide(); }
					        }
					    }
			

					});
					var ipnputFocus = false;
					var currentValInput = "";
					inputbox.focus(function () {
					    dropdown.hide();
					    divSelect.click();
					    ipnputFocus = true;
					    currentValInput = $(this).val();
					});

					divSelect.click(function () {
                        //correct open DropDown
					    if (ipnputFocus) {
					        dropdown.hide();
					        ipnputFocus = false;
					    }
					    //sort out DropDown
					    if (Base.CompareVal == "") {

					        for (i = 0; i < li.length; i++) {
					            li.eq(i).show();
					        };
					    }
					    else {
					        for (var i = 0; i < li.length; i++) {
					            if (li.eq(i).attr("name") == $("#" + Base.CompareVal).prev().find("input").attr("name")) {
					                li.eq(i).show();
					            }
					            else { li.eq(i).hide(); }
					        }
					    }
					    /* умное позиционирование */
						var topOffset = selectbox.offset().top;
						var bottomOffset = $(window).height() - selectHeight - (topOffset - $(window).scrollTop());
						if (bottomOffset < 0 || bottomOffset < liHeight * 6)	{
							dropdown.height('auto').css({top: 'auto', bottom: position});
							if (dropdown.outerHeight() > topOffset - $(window).scrollTop() - 20 ) {
								dropdown.height(Math.floor((topOffset - $(window).scrollTop() - 20) / liHeight) * liHeight);
							}
						} else if (bottomOffset > liHeight * 6) {
							dropdown.height('auto').css({bottom: 'auto', top: position});
							if (dropdown.outerHeight() > bottomOffset - 20 ) {
								dropdown.height(Math.floor((bottomOffset - 20) / liHeight) * liHeight);
							}
						}
						$('span.selectbox').css({zIndex: 1}).removeClass('focused');
						selectbox.css({zIndex: 2});
						if (dropdown.is(':hidden')) {
							$('div.dropdown:visible').hide();
							dropdown.show();
						} else {
							dropdown.hide();
						}
					});
					/* при наведении курсора на пункт списка */
					li.hover(function() {
						$(this).siblings().removeClass('selected');
					});
					var selectedText = li.filter('.selected').text();
					/* при клике на пункт списка */
					li.filter(':not(.disabled)').click(function() {
						var liText = $(this).text();
						if ( selectedText != liText ) {
							$(this).addClass('selected sel').siblings().removeClass('selected sel');
							option.removeAttr('selected').eq($(this).index()).attr('selected', true);
							selectedText = liText;
							divText.text(liText);
							select.change();
						}
						if (currentValInput != $(this).html()) {
						    if (Base.cleanAlsoDropDovnId != "")
						        $("#" + Base.cleanAlsoDropDovnId).prev().find("input").val("");
						}
						if (Base.transferIputId!="")
						    $("#" + Base.transferIputId).val($(this).html());
						
						inputbox.val($(this).html()).attr("name", $(this).attr("name"));
						inputbox.focus().blur();
						dropdown.hide();
					});
					dropdown.mouseout(function() {
						dropdown.find('li.sel').addClass('selected');
					});
					/* фокус на селекте */
					select.focus(function() {
						$('span.selectbox').removeClass('focused');
						selectbox.addClass('focused');
					})
					/* меняем селект с клавиатуры */
					.keyup(function() {
						divText.text(option.filter(':selected').text());
						li.removeClass('selected sel').eq(option.filter(':selected').index()).addClass('selected sel');
					});
					/* прячем выпадающий список при клике за пределами селекта */
					$(document).on('click', function(e) {
						if (!$(e.target).parents().hasClass('selectbox')) {
							dropdown.hide().find('li.sel').addClass('selected');
							selectbox.removeClass('focused');
						}
					});
				}
				doSelect();
				// обновление при динамическом изменении
				select.on('refresh', function() {
					select.prev().remove();
					doSelect();
				})
			}
		});
	}
})(jQuery)