<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/2/7
  Time: 14:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="css/frontEnd/style.css"/>
<nav class="top">
    <div class="top-inner">
        <ul class="top-ul">
            <li><a href="index">long商城</a></li>
            <c:if test="${!empty user}">
                <li><a href="homePage">你好，${user.username}</a></li>
                <li><a href="logout">退出</a></li>
            </c:if>
            <c:if test="${empty user}">
                <li><a href="loginPage">你好，请登录</a></li>
                <li><a href="registerPage">免费注册</a></li>
            </c:if>
            <li><a href="showCart">购物车</a></li>
            <li><a href="userOrderStatus?status=">我的订单</a></li>
        </ul>
    </div>
</nav>
