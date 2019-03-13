<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/3/14
  Time: 13:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>请勿重复提交订单</title>
    <link rel="shortcut icon" href="images/frontEnd/long.ico">
    <style>
        body {
            background-color: #dfdfdf;
        }
        .error-wrap {
            margin: 100px auto 0;
            text-align: center;
        }
    </style>
</head>
<body>
<%@include file="common/navigation.jsp"%>
<div class="error-wrap">
    <img src="images/frontEnd/errorOrder.png" alt="">
</div>
</body>
</html>
