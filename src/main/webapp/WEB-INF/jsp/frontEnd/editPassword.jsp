<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/3/1
  Time: 15:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>修改密码</title>
    <link rel="shortcut icon" href="images/frontEnd/long.ico">
    <link rel="stylesheet" href="css/frontEnd/editPassword.css">
    <script src="js/jquery-3.3.1/jquery-3.3.1.min.js"></script>
    <script>
        $(function () {
            <c:if test="${!empty passwordError}">
                $(".tip-repeat").text("两次输入的密码不一致");
            </c:if>
            <c:if test="${!empty passwordLengthError}">
                $(".tip-new").text("密码应为在6-20字符");
            </c:if>
            $(".new-password input").focus(function () {
                $(".tip-new").text("");
            });
            $(".new-password input").blur(function () {
                if ($(this).val().length == 0)
                    $(".tip-new").text("新密码不能为空");
            });
            $(".new-repeat input").focus(function () {
                $(".tip-repeat").text("");
            });
           $(".new-repeat input").blur(function () {
               if ($(this).val().length == 0)
                   $(".tip-repeat").text("确认密码不能为空");
               if ($(".new-password input").val() != $(this).val())
                   $(".tip-repeat").text("两次输入的密码不一致");
           });
           $("#form").submit(function () {
               if ($(".new-password input").val().length == 0) {
                   $(".tip-new").text("新密码不能为空");
                   return false;
               }
               if ($(".new-repeat input").val().length == 0) {
                   $(".tip-repeat").text("确认密码不能为空");
                   return false;
               }
               if ($(".new-password input").val() != $(".new-repeat input").val()) {
                   $(".tip-repeat").text("两次输入的密码不一致");
                   return false;
               }
           });
        });
    </script>
</head>
<body>
<%@include file="common/navigation.jsp"%>
<div class="edit-wrap">
    <div class="edit-inner">
        <form action="editPassword" id="form" method="post">
            <h3>修改密码</h3>
            <div class="new-password">
                <span>新 密 码 ：</span>
                <input type="password" name="password" minlength="6" maxlength="20">
                <label class="tip-new"></label>
            </div>
            <div class="new-repeat">
                <span>确认密码：</span>
                <input type="password" name="repeatPassword" minlength="6" maxlength="20">
                <label class="tip-repeat"></label>
            </div>
            <div class="btn-submit">
                <input type="submit" value="确认">
            </div>
        </form>
    </div>
</div>
</body>
</html>
