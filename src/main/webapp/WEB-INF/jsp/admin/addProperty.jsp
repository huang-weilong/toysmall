<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/2/4
  Time: 19:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <title>添加属性</title>
    <link rel="shortcut icon" href="images/frontEnd/long.ico">
    <link rel="stylesheet" href="css/bootstrap-3.3.7/css/bootstrap.css"/>
    <link rel="stylesheet" href="css/admin/admin.css"/>
    <script src="js/jquery-3.3.1/jquery-3.3.1.min.js"></script>
    <script>
        $(function () {
            $(".category-son").slideDown();
            $("#form").submit(function () {
                if ($("#name").val().length === 0) {
                    alert("属性名称不能为空！");
                    return false;
                }
                return true;
            });
        })
    </script>
</head>
<body>
<%@include file="common/navigation.jsp"%>
<div class="wrap">
    <div class="title">添加属性</div>
    <div class="tip">所属分类：${category.name}</div>
    <div class="back"><a href="adminListProperty?cid=${category.id}">返回</a></div>
    <div>
        <form id="form" action="adminAddProperty" method="post">
            <table class="table">
                <tr>
                    <td>属性名称</td>
                    <td><input type="text" id="name" class="form-control text-css" name="name"></td>
                </tr>
                <tr>
                    <td><input type="hidden" name="cid" value="${category.id}"></td>
                    <td><input type="submit" class="btn btn-success btn-css" value="提交"></td>
                </tr>
            </table>
        </form>
    </div>
</div>
</body>
</html>
