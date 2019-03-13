<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/1/26
  Time: 16:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>分类信息修改</title>
    <link rel="shortcut icon" href="images/frontEnd/long.ico">
    <link rel="stylesheet" href="css/bootstrap-3.3.7/css/bootstrap.css"/>
    <link rel="stylesheet" href="css/admin/admin.css"/>
    <script src="js/jquery-3.3.1/jquery-3.3.1.min.js"></script>
    <script>
        $(function(){
            $(".category-son").slideDown();
            $("#form").submit(function(){
                if ($("#name").val().length === 0){
                    alert("分类名称不能为空！")
                    return false;
                }
                return true;
            });
        });
    </script>
</head>
<body>
<%@ include file="common/navigation.jsp"%>
<div class="wrap">
    <div class="title">分类信息修改</div>
    <div>
        <form id="form" action="adminUpdateCategory" method="post" enctype="multipart/form-data">
            <table class="table">
                <tr>
                    <td>分类名称</td>
                    <td><input id="name" class="form-control text-css" type="text" name="name" value="${category.name}"></td>
                </tr>
                <tr>
                    <td>分类图片</td>
                    <td><input id="image" name="image" accept="image/*" type="file"/></td>
                </tr>
                <tr>
                    <td><input type="hidden" name="id" value="${category.id}"></td>
                    <td><input type="submit" class="btn btn-success btn-css" value="提交"></td>
                </tr>
            </table>
        </form>
    </div>
</div>
</body>
</html>
