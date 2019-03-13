<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/2/7
  Time: 14:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="search-form">
    <div class="logo">
        <img src="images/frontEnd/long.png" alt="">
    </div>
    <div class="search-hd">
        <form action="search" method="post">
            <div class="search-bg"></div>
            <input type="text" id="search" name="keyword" class="search-input" placeholder="输入要搜索的内容" value="${param.keyword}">
            <input type="hidden" name="sort" value="sortByComposite">
            <button id="submit" class="btn-search" value="搜索">搜索</button>
        </form>
    </div>
</div>
