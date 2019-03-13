<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/2/1
  Time: 20:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <title>编辑属性</title>
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
    <div class="title">属性信息修改</div>
    <div class="tip">所属分类：${property.category.name}</div>
    <div>
        <form id="form" action="adminUpdateProperty" method="post">
            <table class="table">
                <tr>
                    <td>属性名称</td>
                    <td><input type="text" name="name" id="name" class="form-control text-css" value="${property.name}"></td>
                </tr>
                <tr>
                    <td>
                        <input type="hidden" name="id" value="${property.id}">
                        <input type="hidden" name="cid" value="${property.category.id}">
                    </td>
                    <td><input type="submit" class="btn btn-success btn-css" value="提交"/></td>
                </tr>
            </table>
        </form>
    </div>
</div>
</body>
</html>
