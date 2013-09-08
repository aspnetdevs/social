$(document).ready(function () {

    var doc = $(document);
    var B_next = $(".B_next");
    var B_previously = $(".B_previously");
    var AllBlocks = $(".AllBlocks");
    var RegisterCenterBlock = $(".RegisterCenterBlock");
    var width_blocks = RegisterCenterBlock.length * $(document).width();
    var current = 0;
    //sort blocks
    function sort_blocks() {
        RegisterCenterBlock.each(function (key, value) {
            $(this).css({ "left": (key * $(document).width()), "top": -key * $(this).height() });
        })
    }
    sort_blocks();

    //sort again when we will change size
    $(window).resize(function () {
        sort_blocks();
        RegisterCenterBlock.each(function (key, value) {
            $(this).animate({ "left": (key * $(document).width()) - ($(document).width() * current) }, 0);
        })
    })

    //next step registry
    B_next.click(function () {

        current = -parseInt(RegisterCenterBlock.eq(0).css("left")) / $(document).width() + 1;
        RegisterCenterBlock.each(function (key, value) {
            if (current < RegisterCenterBlock.length)
                $(this).animate({ "left": (key * $(document).width()) - ($(document).width() * current) }, 500);
        })
    });
    //previously step registry
    B_previously.click(function () {

        current = -parseInt(RegisterCenterBlock.eq(0).css("left")) / $(document).width();

        RegisterCenterBlock.each(function (key, value) {
            if (current > 0)
                $(this).animate({ "left": "+=" + ($(document).width()) }, 500);
        })
    });

});