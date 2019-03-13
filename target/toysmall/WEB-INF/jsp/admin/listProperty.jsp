<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/2/1
  Time: 20:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <title>属性管理</title>
    <link rel="shortcut icon" href="images/frontEnd/long.ico">
    <link rel="stylesheet" href="css/bootstrap-3.3.7/css/bootstrap.css"/>
    <link rel="stylesheet" href="css/admin/admin.css"/>
    <script src="js/jquery-3.3.1/jquery-3.3.1.min.js"></script>
    <script>
        $(function () {
            $(".category-son").slideDown();
            $(".delete").click(function () {
                var flag = confirm("确认删除？");
                return flag;
            });
        })
    </script>
</head>
<body>
<%@include file="common/navigation.jsp"%>
<div class="wrap">
    <div class="title">属性列表</div>
    <div class="tip">所属分类：${category.name}</div>
    <div class="add"><a href="addProperty?cid=${category.id}">添加属性</a></div>
    <div>
        <table class="table">
            <tr>
                <th>ID</th>
                <th>属性名称</th>
                <th>编辑</th>
                <th>删除</th>
            </tr>
            <c:forEach items="${properties}" var="p">
            <tr>
                <td>${p.id}</td>
                <td>${p.name}</td>
                <td><a href="adminEditProperty?id=${p.id}"><span class="glyphicon glyphicon-edit"></span></a></td>
                <td><a class="delete" href="adminDeleteProperty?id=${p.id}"><span class="glyphicon glyphicon-trash"></span></a></td>
            </tr>
            </c:forEach>
        </table>
    </div>
</div>
</body>
</html>
