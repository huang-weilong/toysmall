<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/3/10
  Time: 14:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>请选择要查看商品的所属分类</title>
    <link rel="shortcut icon" href="images/frontEnd/long.ico">
    <link rel="stylesheet" href="css/bootstrap-3.3.7/css/bootstrap.css"/>
    <link rel="stylesheet" href="css/admin/admin.css"/>
    <script src="js/jquery-3.3.1/jquery-3.3.1.min.js"></script>
    <script>
        $(function () {
            $(".product-son").slideDown();
        })
    </script>
</head>
<body>
<%@include file="common/navigation.jsp"%>
<div class="wrap">
    <div class="title">您想看哪个分类下的商品呢</div>
    <div class="tip">
        <form action="searchCategoryProduct" method="post" autocomplete="off">
            分类名 <input id="keyword" class="search-input" type="text" name="keyword" value="${param.keyword}">
            <input type="submit" class="btn btn-info search-btn" value="搜索">
        </form>
    </div>
    <c:forEach items="${categories}" var="c">
        <div class="index-box">
            <a href="adminListProduct?cid=${c.id}">
                <span>
                    <div><img height="100px" src="images/category/${c.id}.jpg"></div>
                    <div>${c.name}</div>
                </span>
            </a>
        </div>
    </c:forEach>
</div>
</body>
</html>
