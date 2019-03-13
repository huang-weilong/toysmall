<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/2/4
  Time: 14:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <title>颜色分类管理</title>
    <link rel="shortcut icon" href="images/frontEnd/long.ico">
    <link rel="stylesheet" href="css/bootstrap-3.3.7/css/bootstrap.css"/>
    <link rel="stylesheet" href="css/admin/admin.css"/>
    <script src="js/jquery-3.3.1/jquery-3.3.1.min.js"></script>
    <script>
        $(function() {
            $(".product-son").slideDown();
            $("#form").submit(function() {
                var stock = $("#stock").val();
                if ($("#name").val().length === 0) {
                    alert("颜色分类名称不能为空！");
                    return false;
                }
                if (stock.length === 0) {
                    alert("库存不能为空！");
                    return false;
                }
                //验证正整数
                var reg = /^\+?[1-9][0-9]*$/;
                if (!reg.test(stock)) {
                    alert("库存数值不正确，请重新输入！");
                    return false;
                }
                return true;
            });
            $(".delete").click(function () {
                var flag = confirm("确认删除？");
                return flag;
            });
        });
    </script>
</head>
<body>
<%@include file="common/navigation.jsp"%>
<div class="wrap">
    <div class="title">颜色分类与库存管理</div>
    <div class="tip">所属商品：${product.name}</div>
    <div class="back"><a href="adminListProduct?cid=${product.cid}">返回</a></div>
    <div class="color-box">
        <table class="table table-hover">
            <tr>
                <th>ID</th>
                <th>颜色分类名称</th>
                <th>库存</th>
                <th>编辑</th>
                <th>删除</th>
            </tr>
            <c:forEach items="${colors}" var="color">
                <tr>
                    <td>${color.id}</td>
                    <td>${color.colorValue}</td>
                    <td>${color.stock}</td>
                    <td><a href="adminEditColor?id=${color.id}"><span class="glyphicon glyphicon-edit"></span></a></td>
                    <td><a class="delete" href="adminDeleteColor?id=${color.id}"><span class="glyphicon glyphicon-trash"></span></a></td>
                </tr>
            </c:forEach>
        </table>
    </div>
    <div class="add-color-box">
        <div class="name">新增颜色分类</div>
        <form id="form" action="adminAddColor" method="post">
            <table class="table">
                <tr>
                    <td>颜色名称</td>
                    <td><input type="text" id="name" class="form-control" name="colorValue"></td>
                </tr>
                <tr>
                    <td>库存</td>
                    <td><input type="text" id="stock" class="form-control" name="stock"></td>
                </tr>
                <tr>
                    <td><input type="hidden" name="pid" value="${product.id}"></td>
                    <td><input type="submit" class="btn btn-success btn-css" value="增加"></td>
                </tr>
            </table>
        </form>
    </div>
</div>
</body>
</html>
