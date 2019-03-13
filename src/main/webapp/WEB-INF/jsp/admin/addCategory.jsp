<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/2/4
  Time: 19:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>添加分类</title>
    <link rel="shortcut icon" href="images/frontEnd/long.ico">
    <link rel="stylesheet" href="css/bootstrap-3.3.7/css/bootstrap.css"/>
    <link rel="stylesheet" href="css/admin/admin.css"/>
    <script src="js/jquery-3.3.1/jquery-3.3.1.min.js"></script>
    <script>
        $(function() {
            $(".category-son").slideDown();
            $("#form").submit(function() {
                var flag = $("#flag").val();
                if (flag==0){
                    alert("请选择合适的所属大类");
                    return false;
                }
                if ($("#name").val().length === 0){
                    alert("分类名称不能为空！")
                    return false;
                }
                if ($("#image").val().length === 0){
                    alert("分类图片不能为空！");
                    return false;
                }
                return true;
            });
        });
    </script>
    <style>
        .dropdown {
            width: 100px;
            height: 34px;
            border-radius: 4px;
            border: 1px solid #ccc;
        }
    </style>
</head>
<body>
<%@include file="common/navigation.jsp"%>
<div class="wrap">
    <div class="title">添加分类</div>
    <div>
        <form id="form" action="adminAddCategory" method="post" enctype="multipart/form-data">
            <table class="table">
                <tr>
                    <td>所属的大类</td>
                    <td>
                        <select id="flag" name="flag" class="dropdown">
                            <option value="0">请选择</option>
                            <option value="1">益智玩具</option>
                            <option value="2">遥控电动</option>
                            <option value="3">积木拼插</option>
                            <option value="4">毛绒/娃娃</option>
                            <option value="5">健身玩具</option>
                            <option value="6">创意DIY</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>分类名称</td>
                    <td><input type="text" name="name" id="name" class="form-control text-css"></td>
                </tr>
                <tr>
                    <td>分类图片</td>
                    <td><input id="image" name="image" accept="image/*" type="file" /></td>
                </tr>
                <tr>
                    <td></td>
                    <td><input type="submit" class="btn btn-success btn-css" value="提交"></td>
                </tr>
            </table>
        </form>
    </div>
</div>
</body>
</html>
