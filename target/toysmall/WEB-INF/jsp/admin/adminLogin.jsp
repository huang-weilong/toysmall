<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/2/22
  Time: 13:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>管理员登录</title>
    <link rel="shortcut icon" href="images/frontEnd/long.ico">
    <link rel="stylesheet" href="css/admin/adminLogin.css">
    <script src="js/jquery-3.3.1/jquery-3.3.1.min.js"></script>
    <script>
        $(function () {
            <c:if test="${!empty nameOrPwdError}">
                $(".tip-name").text("用户名或密码错误");
            </c:if>
            $("#username").focus(function () {
                $(".tip-name").text("");
            });
            $("#password").focus(function () {
                $(".tip-name").text("");
            });
            $("#adminLogin").submit(function () {
                if ($("#username").val().length == 0 || $("#password").val().length == 0) {
                    $(".tip-name").text("账号或密码不能为空");
                    return false;
                }
                return true;
            });
        });
    </script>
</head>
<body>
<div class="admin-login-wrap">
    <div class="logo">
        <img src="images/frontEnd/admin-login.png" alt="logo">
    </div>
    <div class="login-wrap">
        <div class="content">
            <div class="content-box">
                <form action="adminLogin" method="post" id="adminLogin" autocomplete="off">
                    <div class="login-i">
                        <img src="images/frontEnd/user.png" alt="">
                        <input id="username" name="username" type="text" placeholder="请输入管理员账号"/>
                    </div>
                    <label class="tip tip-name"></label>
                    <div class="login-i">
                        <img src="images/frontEnd/password.png" alt="">
                        <input id="password" name="password" type="password" placeholder="请输入密码"/>
                    </div>
                    <label class="tip tip-password"></label>
                    <div class="login-btn">
                        <input type="submit" value="登录">
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>
