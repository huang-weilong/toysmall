<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/1/25
  Time: 0:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>分类管理</title>
    <link rel="shortcut icon" href="images/frontEnd/long.ico">
    <link rel="stylesheet" href="css/bootstrap-3.3.7/css/bootstrap.css"/>
    <link rel="stylesheet" href="css/admin/admin.css"/>
    <script src="js/jquery-3.3.1/jquery-3.3.1.min.js"></script>
    <style>
        .delete div {
            padding: 5px 0;
            text-align: center;
            color: #ffffff;
            background-color: #44b3de;
        }
        .delete div:hover {
            background-color: #2d89ad;
        }
        .add-property div {
            padding: 5px 0;
            text-align: center;
            color: #ffffff;
            background-color: #52ce89;
        }
        .add-property div:hover {
            background-color: #379e65;
        }
    </style>
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
    <div class="title">分类列表</div>
    <div class="tip">
        <form action="searchCategory" method="post" autocomplete="off">
            分类名 <input id="keyword" class="search-input" type="text" name="keyword" value="${keyword}">
            <input type="submit" class="btn btn-info search-btn" value="搜索">
        </form>
    </div>
    <c:forEach items="${categories}" var="cs">
        <div class="index-box">
            <a href="adminEditCategory?id=${cs.id}">
                <span>
                    <div><img height="100px" src="images/category/${cs.id}.jpg"></div>
                    <div>${cs.name}</div>
                </span>
            </a>
            <a class="add-property" href="adminListProperty?cid=${cs.id}"><div>属性列表</div></a>
            <a class="delete" href="adminDeleteCategory?id=${cs.id}"><div>删除</div></a>
        </div>
    </c:forEach>
</div>
</body>
</html>
