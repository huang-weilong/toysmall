$(function () {
    $(window).scroll(function(){
        var windowScrollTop = $(window).scrollTop();
        if (windowScrollTop > 100) {
            $(".back-top").fadeIn();
        }else {
            $(".back-top").fadeOut();
        }
    });
    // 返回顶部
    $(".back-top").on("click",function () {
        $(".back-top").addClass("back-top-animation");
        $("html,body").animate({
            scrollTop:0
        }, 1000,function () {
            $(".back-top").removeClass("back-top-animation");
        });
    });
    $(".back-top").mouseover(function () {
        $(this).attr("src","images/frontEnd/top2.png");
    });
    $(".back-top").mouseout(function () {
        $(this).attr("src","images/frontEnd/top1.png");
    })
});