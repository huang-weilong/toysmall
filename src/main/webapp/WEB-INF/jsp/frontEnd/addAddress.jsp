<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/2/27
  Time: 13:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>新增收货地址</title>
    <link rel="shortcut icon" href="images/frontEnd/long.ico">
    <link rel="stylesheet" href="css/frontEnd/addAddress.css">
    <script src="js/jquery-3.3.1/jquery-3.3.1.min.js"></script>
    <script src="js/jquery.citys.js"></script>
    <script src="http://int.dpool.sina.com.cn/iplookup/iplookup.php?format=js"></script>
    <script>
        $(function () {
            // 根据IP地址获取信息
            // if(remote_ip_info){
            //     $('#location').citys({province:remote_ip_info['province'],city:remote_ip_info['city'],area:remote_ip_info['district']});
            // }
            // 扩展显示行政区划第四级(街道)信息：
            var $town = $('#demo3 select[name="town"]');
            var townFormat = function(info){
                $town.hide().empty();
                if(info['code']%1e4&&info['code']<7e6){	//是否为“区”且不是港澳台地区
                    $.ajax({
                        url:'http://passer-by.com/data_location/town/'+info['code']+'.json',
                        dataType:'json',
                        success:function(town){
                            $town.show();
                            for(i in town){
                                $town.append('<option value="'+i+'">'+town[i]+'</option>');
                            }
                        }
                    });
                }
            };
            $('#demo3').citys({
                province:'广东',
                city:'广州',
                area:'花都',
                onChange:function(info){
                    townFormat(info);
                }
            },function(api){
                var info = api.getInfo();
                townFormat(info);
            });
            $(".receiver input").blur(function () {
                $(".tip-receiver").text("");
                if ($(".receiver input").val().length === 0){
                    $(".tip-receiver").text("请填写收货人姓名");
                }
            });
            $(".address-detail input").blur(function () {
                $(".tip-detail").text("");
                if ($(".address-detail input").val().length === 0){
                    $(".tip-detail").text("请填写详细地址");
                }
            });
            $(".tel input").blur(function () {
                $(".tip-tel").text("");
                if ($(".tel input").val().length === 0){
                    $(".tip-tel").text("请填写手机号码");
                    return false;
                }
                // 验证手机格式
                var reg = /^1[34578][0-9]{9}$/;
                var phoneNum = $(".tel input").val();
                if(!reg.test(phoneNum)) {
                    $(".tip-tel").text("手机号码格式错误，请重新输入");
                    return false;
                }
            });
            $(".post input").blur(function () {
                $(".tip-post").text("");
                var reg = /^\d{6}$/;
                var post = $(this).val();
                if (post.length != 0 && !reg.test(post)) {
                    $(".tip-post").text("邮政编码格式错误，请重新输入");
                    return false;
                }
            });
            $(".btn-submit").click(function () {
                if (check() == false)
                    return false;
                var tel = $(".tel input").val();
                var name = $(".receiver input").val();
                var post = $(".post input").val();
                var province = $(".province option:selected").text();
                var city = $(".city option:selected").text();
                var area = $(".area option:selected").text();
                var town = $(".town option:selected").text();
                var addressDetail = $(".address-detail input").val();
                var address = province+" "+city+" "+area+ " "+town+" "+addressDetail;
                var page = "addAddress";
                $.post(
                    page,
                    {
                        "name" : name,
                        "tel" : tel,
                        "address" : address,
                        "post" : post
                    },
                    function (result) {
                        if (result == "yes")
                            location.href = "homePage";
                        else
                            location.href="loginPage";
                    }
                )

            });
            function check() {
                if ($(".receiver input").val().length === 0){
                    $(".tip-receiver").text("请填写收货人姓名");
                    return false;
                }
                if ($(".address-detail input").val().length === 0){
                    $(".tip-detail").text("请填写详细地址");
                    return false;
                }
                if ($(".tel input").val().length === 0){
                    $(".tip-tel").text("请填写手机号码");
                    return false;
                }
                // 验证手机格式
                var reg = /^1[34578][0-9]{9}$/;
                var tel = $(".tel input").val();
                if(!reg.test(tel)) {
                    $(".tip-tel").text("手机号码格式错误，请重新输入");
                    return false;
                }
                // 验证邮编格式
                var reg_post = /^\d{6}$/;
                var post = $(".post input").val();
                if (post.length != 0 && !reg_post.test(post)) {
                    $(".tip-post").text("邮政编码格式错误，请重新输入");
                    return false;
                }
            }
        });
    </script>
</head>
<body>
<%@include file="common/navigation.jsp"%>
<div class="add-wrap">
    <div class="add-inner">
        <h3>新增收货地址</h3>
        <div class="receiver">
            <div><span class="star">*</span>收货人：</div>
            <input type="text" name="name">
            <label class="tip tip-receiver"></label>
        </div>
        <div class="select-area">
            <div><span class="star">*</span>所在地区：</div>
            <!-- 根据IP地址获得位置信息 -->
            <!-- <div id="location" class="citys">
                <select name="province"></select>
                <select name="city"></select>
                <select name="area"></select>
            </div> -->
            <!-- 显示行政区划第四级(街道)信息 -->
            <div id="demo3" class="citys">
                <select class="province" name="province"></select>
                <select class="city" name="city"></select>
                <select class="area" name="area"></select>
                <select class="town" name="town"></select>
            </div>
        </div>
        <div class="address-detail">
            <div><span class="star">*</span>详细地址：</div>
            <input type="text" name="address" id="">
            <label class="tip tip-detail"></label>
        </div>
        <div class="tel">
            <div><span class="star">*</span>手机号码：</div>
            <input type="tel" name="tel" maxlength="11">
            <label class="tip tip-tel"></label>
        </div>
        <div class="post">
            <div>邮政编码：</div>
            <input type="text" name="post" maxlength="6">
            <span>（选填）</span>
            <label class="tip tip-post"></label>
        </div>
        <div class="confirm">
            <span class="btn-submit">提交</span>
        </div>
    </div>
</div>
</body>
</html>
