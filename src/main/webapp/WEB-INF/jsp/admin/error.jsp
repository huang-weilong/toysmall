<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/3/15
  Time: 13:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>出错啦...</title>
    <link rel="shortcut icon" href="images/frontEnd/long.ico">
    <style>
        body {
            background-color: #dfdfdf;
        }
        .error-wrap {
            margin: 100px auto 0;
            text-align: center;
        }
        .error-wrap .go-back {
            margin-top: 20px;
        }
        .error-wrap a {
            display: inline-block;
            width: 180px;
            height: 40px;
            line-height: 40px;
            font-size: 16px;
            color: #ffffff;
            background-color: #39a239;
            text-decoration: none;
        }
        .error-wrap a:hover {
            background-color: #3e8f3e;
        }
    </style>
</head>
<body>
<div class="error-wrap">
    <img src="images/frontEnd/error.png" alt="错误">
    <div class="go-back"><a href="adminIndex">返回首页</a></div>
</div>
</body>
</html>
