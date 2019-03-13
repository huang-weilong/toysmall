<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/2/3
  Time: 16:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <title>用户列表</title>
    <link rel="shortcut icon" href="images/frontEnd/long.ico">
    <link rel="stylesheet" href="css/bootstrap-3.3.7/css/bootstrap.css"/>
    <link rel="stylesheet" href="css/admin/admin.css"/>
    <script src="js/jquery-3.3.1/jquery-3.3.1.min.js"></script>
</head>
<body>
<%@include file="common/navigation.jsp"%>
<div class="wrap">
    <div class="title">用户列表</div>
    <div class="tip">
        <form action="searchUser" method="post" autocomplete="off">
            用户名 <input type="text" class="search-input" name="keywordName" value="${keywordName}">
            手机号 <input type="text" class="search-input" name="keywordTel" value="${keywordTel}">
            <input type="submit" class="btn btn-info search-btn" value="搜索">
        </form>
    </div>
    <div>
        <table class="table table-hover">
            <tr>
                <th>ID</th>
                <th>用户名</th>
                <th>用户手机号</th>
            </tr>
            <c:forEach items="${users}" var="user">
                <tr>
                    <td>${user.id}</td>
                    <td>${user.username}</td>
                    <td>${user.tel}</td>
                </tr>
            </c:forEach>
        </table>
    </div>
    <c:if test="${page.total > page.count}">
        <div class="page"><%@include file="common/page.jsp" %></div>
    </c:if>
</div>
</body>
</html>
