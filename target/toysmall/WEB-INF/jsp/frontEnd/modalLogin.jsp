<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/2/21
  Time: 18:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <link rel="stylesheet" href="css/frontEnd/modalLogin.css">
    <link rel="shortcut icon" href="images/frontEnd/long.ico">
    <script>
        $(function() {
            <c:if test="${!empty nameOrPwdError}">
                $(".tip-name").text("用户名或密码错误");
            </c:if>
            <c:if test="${!empty telOrCodeError}">
                $(".tip-tel").text("手机或验证码错误");
            var i = $(this).index();
            $(".modal-tab-header li").removeClass("active").eq(i).addClass("active");
            $(".modal-content .content-box").removeClass("active").eq(i).addClass("active");
            </c:if>
            // 切换选项卡
            $(".modal-tab-header li").on("click", function(){
                var i = $(this).index();
                $(".modal-tab-header li").removeClass("active").eq(i).addClass("active");
                $(".modal-content .content-box").removeClass("active").eq(i).addClass("active");
            });

            $("#username").focus(function () {
                $(".tip-name").text("");
            });
            $("#password").focus(function () {
                $(".tip-name").text("");
            });
            // 使用用户名密码登录
            $("#loginForName").click(function () {
                if ($("#username").val().length == 0 || $("#password").val().length == 0) {
                    $(".tip-name").text("账号或密码不能为空");
                    return false;
                }
                var page = "loginModalUserName";
                $.get(
                    page,
                    {"username": $("#username").val(),"password": $("#password").val()},
                    function (result) {
                        if (result == "yes") {
                            location.reload();
                        } else {
                            $(".tip-name").text("账号或密码错误");
                            return false;
                        }
                    }
                );
                return true;
            });
            $("#tel").focus(function () {
                $(".tip-tel").text("");
            });
            $("#code").focus(function () {
                $(".tip-tel").text("");
            });
            // 使用手机号码登录
            $("#loginForTel").click(function () {
                if ($("#tel").val().length == 0 || $("#code").val().length == 0) {
                    $(".tip-tel").text("手机号或验证码不能为空");
                    return false;
                }
                // 验证手机格式
                var reg = /^1[34578][0-9]{9}$/;
                var phoneNum = $("#tel").val();
                if(!reg.test(phoneNum)) {
                    $(".tip-tel").text("手机号码格式错误，请重新输入");
                    return false;
                }
                var page = "loginModalTel";
                $.post(
                    page,
                    {"tel": $("#tel").val(),"code": $("#code").val()},
                    function (result) {
                        if (result == "yes") {
                            location.reload();
                        } else {
                            $(".tip-tel").text("手机或验证码错误");
                            return false;
                        }
                    }
                );
                return true;
            });
            // 发送验证码
            $("#sendCode").click(function() {
                if ($("#tel").val().length == 0) {
                    $(".tip-tel").text("请输入手机号码");
                    return false;
                }
                // 验证手机格式
                var reg = /^1[34578][0-9]{9}$/;
                var phoneNum = $("#tel").val();
                if(!reg.test(phoneNum)) {
                    $(".tip-tel").text("手机号码格式错误，请重新输入");
                    return false;
                }

                var url = "sendLoginCode";
                $.post(
                    url,
                    {"tel": $("#tel").val()},
                    function (result) {
                        if (result == "yes") {
                            // 倒数时间
                            var times = 60;
                            var timer = null;
                            timer = setInterval(function() {
                                times--;
                                if(times == 0) {
                                    $("#sendCode").val("发送验证码");
                                    clearInterval(timer);
                                    $("#sendCode").removeAttr("disabled");
                                    $("#sendCode").css({"background-color":"#30b1df","cursor":"pointer"});
                                } else {
                                    console.log(times+"秒后重试");
                                    $("#sendCode").val(times + "秒后重试");
                                    $("#sendCode").attr("disabled","disabled");
                                    $("#sendCode").css({"background-color":"#7e7e7e","cursor":"not-allowed"});
                                }
                            }, 1000);
                        } else {
                            $(".tip-tel").text("该手机号码未注册");
                            return false;
                        }
                    }
                );
            });

            $("#close").click(function () {
               $("#loginBox").css("display","none");
            });
        })
    </script>
</head>
<body>
<div class="wrap">
    <div class="modal-login-wrap" id="loginBox">
        <img src="images/frontEnd/close.png" class="close" id="close" alt="">
        <!-- 选项卡 -->
        <div class="modal-tab-header">
            <ul>
                <li class="active">账号密码登录</li>
                <li>手机登录</li>
            </ul>
        </div>
        <!-- 选项内容 -->
        <div class="modal-content">
            <div class="content-box first-content active">
                    <div class="login-i">
                        <img src="images/frontEnd/b-user.png" alt="">
                        <input id="username" name="username" type="text" placeholder="请输入用户名" minlength="4" maxlength="16"/>
                    </div>
                    <label class="tip tip-name"></label>
                    <div class="login-i">
                        <img src="images/frontEnd/b-password.png" alt="">
                        <input id="password" name="password" type="password" placeholder="请输入密码" minlength="6" maxlength="20"/>
                    </div>
                    <label class="tip tip-password"></label>
                    <div class="login-btn">
                        <input id="loginForName" type="submit" value="登录">
                    </div>
            </div>
            <div class="content-box second-content">
                    <div class="login-i">
                        <img src="images/frontEnd/b-tel.png" alt="">
                        <input id="tel" name="tel" type="tel" placeholder="请输入手机号码" minlength="11" maxlength="11"/>
                    </div>
                    <label class="tip tip-tel"></label>
                    <div class="login-i">
                        <img src="images/frontEnd/b-code.png" alt="">
                        <input id="code" name="code" type="text" placeholder="请输入验证码" maxlength="6"/>
                        <input type="button" id="sendCode" class="btn-code" value="发送验证码">
                    </div>
                    <label class="tip tip-code"></label>
                    <div class="login-btn">
                        <input id="loginForTel" type="submit" value="登录">
                    </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
