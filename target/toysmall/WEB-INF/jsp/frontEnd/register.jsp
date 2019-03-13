<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/2/19
  Time: 22:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>欢迎注册</title>
    <link rel="shortcut icon" href="images/frontEnd/long.ico">
    <link rel="stylesheet" href="css/frontEnd/register.css">
    <script src="js/jquery-3.3.1/jquery-3.3.1.min.js"></script>
    <script>
        $(function() {
            <c:if test="${!empty nameExist}">
                $(".tip-name").text("用户名已存在");
            </c:if>
            <c:if test="${!empty telOrCodeError}">
                $(".tip-tel").text("手机号或验证码错误");
            </c:if>
            <c:if test="${!empty passwordError}">
                $(".tip-repeatPwd").text("两次输入密码不一致");
            </c:if>
            <c:if test="${!empty passwordLengthError}">
                $(".tip-password").text("密码长度错误，应为6-20字符");
            </c:if>
            <c:if test="${!empty usernameLengthError}">
                $(".tip-name").text("用户名长度错误，应为4-20字符");
            </c:if>
            $("#username").focus(function(){
                if ($(this).val().length === 0) {
                    $(".tip-name").text("支持数字、字母和下划线");
                    $(".tip-name").css("color", "#ffffff");
                }
            });
            $("#username").blur(function(){
                if ($(this).val().length == 0){
                    $(".tip-name").css("color", "#ff1f1f");
                    $(".tip-name").text("用户名不能为空");
                }
            });

            $("#password").focus(function() {
                if ($(this).val().length === 0) {
                    $(".tip-password").text("建议使用字母、数字和符号两种以上组合，6-20字符");
                    $(".tip-password").css("color", "#ffffff");
                }
            });
            $("#password").blur(function() {
                $(".tip-password").text("");
                $(".tip-password").css("color", "#ff1f1f");
                if ($(this).val().length == 0)
                    $(".tip-password").text("密码不能为空");
                if ($(this).val().length != 0 && $(this).val().length < 6 || $(this).val().length > 20)
                    $(".tip-password").text("密码长度应为6-20字符");
                if ($(this).val().length != 0 && $(this).val() == $("#repeatPwd").val())
                    $(".tip-repeatPwd").text("");
            });

            $("#repeatPwd").focus(function() {
                $(".tip-repeatPwd").text("");
                $(".tip-repeatPwd").css("color", "#ffffff");
            });
            $("#repeatPwd").blur(function() {
                $(".tip-repeatPwd").css("color", "#ff1f1f");
                if ($(this).val().length == 0) {
                    $(".tip-repeatPwd").text("确认密码不能为空");
                }
                if ($("#password").val() != $(this).val()){
                    $(".tip-repeatPwd").text("两次输入的密码不一致");
                }
            });

            $("#tel").focus(function() {
                if ($(this).val().length === 0) {
                    $(".tip-tel").text("完成验证后，你可用该手机登录");
                    $(".tip-tel").css("color", "#ffffff");
                }
            });
            $("#tel").blur(function() {
                $(".tip-tel").text("");
                $(".tip-tel").css("color", "#ff1f1f");
                if ($(this).val().length == 0){
                    $(".tip-tel").text("手机号码不能为空");
                    return false;
                }
                //    验证手机格式
                var reg = /^1[34578][0-9]{9}$/;
                var phoneNum = $("#tel").val();
                if(!reg.test(phoneNum)) {
                    $(".tip-tel").text("手机号码格式错误，请重新输入");
                    return false;
                }
            });

            $("#code").focus(function() {
                $(".tip-code").text("");
            });
            $("#code").blur(function() {
                $(".tip-code").text("");
                $(".tip-code").css("color", "#ff1f1f");
                if ($(this).val().length == 0) {
                    $(".tip-code").text("验证码不能为空");
                }
            });

            // 验证用户名是否已被注册
            $("#username").keyup(function () {
                var regname = /^[a-zA-Z0-9_]{4,20}$/;
                var username = $(this).val();
                if (!regname.test(username)) {
                    $(".tip-name").text("用户名只能为数字、字母和下划线，4-20字符");
                    $(".tip-name").css("color", "#ff1f1f");
                    return false;
                }
                var url = "checkUsername";
                $.post(
                    url,
                    {"username": username},
                    function (result) {
                        // if (username.length != 0) {
                            if (result === "yes") {
                                $(".tip-name").text("该用户名可以使用");
                                $(".tip-name").css("color", "#ffffff");
                            } else {
                                $(".tip-name").text("该用户名已被注册");
                                $(".tip-name").css("color", "#ff1f1f");
                            }
                        // }
                    }
                )
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

                var url = "sendRegisterCode";
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
                        }else {
                            $(".tip-tel").text("该号码已被注册");
                        }
                    }
                );
            });

            //    提交表单时再次判断
            $("#form").submit(function() {
                var flag = 0;
                if($("#username").val().length == 0) {
                    $(".tip-name").text("用户名不能为空");
                    flag++;
                }
                if ($("#password").val().length == 0) {
                    $(".tip-password").text("密码不能为空");
                    flag++;
                }
                if ($("#repeatPwd").val().length == 0) {
                    $(".tip-repeatPwd").text("确认密码不能为空");
                    flag++;
                }
                if ($("#tel").val().length == 0) {
                    $(".tip-tel").text("手机号码不能为空");
                    flag++;
                }
                if ($("#code").val().length == 0) {
                    $(".tip-code").text("验证码不能为空");
                    flag++;
                }
                if (flag > 0)
                    return false;
                // 验证手机格式
                var reg = /^1[34578][0-9]{9}$/;
                var phoneNum = $("#tel").val();
                if(!reg.test(phoneNum)) {
                    $(".tip-tel").text("手机号码格式错误，请重新输入");
                    return false;
                }
                var regname = /^[a-zA-Z0-9_]{4,20}$/;
                var username = $("#username").val();
                if (!regname.test(username)) {
                    $(".tip-name").text("用户名只能为数字、字母和下划线，4-20字符");
                    $(".tip-name").css("color", "#ff1f1f");
                    return false;
                }
                return true;
            });
        });
    </script>
</head>
<body>
<div class="wrap">
    <div class="logo">
        <a href="index"><img src="images/frontEnd/long-reg.png" alt="logo"></a>
    </div>
    <div class="register">
        <form action="register" method="post" id="form" autocomplete="off">
            <div class="register-d">
                <span>用 户 名</span>
                <input type="text" id="username" name="username" placeholder="请输入用户名"/>
            </div>
            <label class="tip tip-name"></label>
            <div class="register-d">
                <span>设置密码</span>
                <input type="password" id="password" name="password" placeholder="请输入密码" minlength="6" maxlength="20"/>
            </div>
            <label class="tip tip-password"></label>
            <div class="register-d">
                <span>确认密码</span>
                <input type="password" id="repeatPwd" name="repeatPassword" placeholder="请再次输入密码" minlength="6" maxlength="20"/>
            </div>
            <label class="tip tip-repeatPwd"></label>
            <div class="register-d">
                <span>手机号码</span>
                <input type="tel" id="tel" name="tel" placeholder="请输入手机号码" minlength="11" maxlength="11"/>
            </div>
            <label class="tip tip-tel"></label>
            <div class="register-d">
                <span>验 证 码</span>
                <input type="text" id="code" name="code" placeholder="请输入验证码" maxlength="6"/>
                <input type="button" id="sendCode" class="btn-code" value="发送验证码">
            </div>
            <label class="tip tip-code"></label>
            <div class="register-btn">
                <input type="submit" value="注册">
            </div>
        </form>
        <a class="login" href="loginPage">已有账号？去登陆</a>
    </div>
</div>
</body>
</html>
