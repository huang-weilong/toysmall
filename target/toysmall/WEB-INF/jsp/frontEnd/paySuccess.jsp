<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/2/27
  Time: 14:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>付款成功</title>
    <link rel="shortcut icon" href="images/frontEnd/long.ico">
    <link rel="stylesheet" href="css/frontEnd/paySuccess.css">
    <script src="js/jquery-3.3.1/jquery-3.3.1.min.js"></script>
    <script>
        $(function () {
            var times = 10;
            var timer = null;
            timer = setInterval(function() {
                times--;
                if(times == 0) {
                    $("#time").html("正在跳转...");
                    window.location.href = "index";
                    clearInterval(timer);
                } else {
                    $("#time").html(times+"秒后跳转至商城首页");
                }
            }, 1000);
        })
    </script>
</head>
<body>
<%@include file="common/navigation.jsp"%>
<div class="result-wrap">
    <div class="result-inner">
        <h3>付款结果</h3>
        <div class="line"></div>
        <div class="logo">
            <span class="bg"></span>
            <span class="hook"></span>
        </div>
        <div class="text">
            <div class="result-text">您已成功付款<fmt:formatNumber minFractionDigits="2" value="${total}"></fmt:formatNumber> 元</div>
            <div class="oid">订单号：${order.orderNum}</div>
        </div>
        <div class="jump"><span id="time">10秒后跳转至商城首页</span> <a href="index">立即跳转</a></div>
    </div>
</div>
</body>
</html>
