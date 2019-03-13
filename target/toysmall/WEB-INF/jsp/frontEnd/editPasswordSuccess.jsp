<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/3/15
  Time: 20:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>密码修改成功</title>
    <link rel="shortcut icon" href="images/frontEnd/long.ico">
    <style>
        .success-wrap {
            margin: 100px auto 0;
            width: 250px;
        }
        .success-wrap .logo{
            position: relative;
        }
        .success-wrap .logo .bg {
            position: absolute;
            display: inline-block;
            width: 60px;
            height: 60px;
            background-color: #3bbb5b;
            border-radius: 50%;
        }
        .success-wrap .logo .hook {
            position: absolute;
            display: inline-block;
            left: 20px;
            top: 10px;
            width: 15px;
            height: 30px;
            border: 6px solid rgb(255, 255, 255);
            border-top: none;
            border-left: none;
            transform: rotate(45deg);
        }
        .success-wrap .logo div {
            margin-left: 70px;
            padding: 12px;
            font-size: 26px;
        }
    </style>
</head>
<body>
<%@include file="common/navigation.jsp"%>
<div class="success-wrap">
    <div class="logo">
        <span class="bg"></span>
        <span class="hook"></span>
        <div>密码修改成功</div>
    </div>
</div>
</body>
</html>
