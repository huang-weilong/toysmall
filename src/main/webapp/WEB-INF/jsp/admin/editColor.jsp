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
    <title>编辑颜色分类</title>
    <link rel="shortcut icon" href="images/frontEnd/long.ico">
    <link rel="stylesheet" href="css/bootstrap-3.3.7/css/bootstrap.css"/>
    <link rel="stylesheet" href="css/admin/admin.css"/>
    <script src="js/jquery-3.3.1/jquery-3.3.1.min.js"></script>
    <script>
        $(function () {
            $(".product-son").slideDown();
           $("#form").submit(function () {
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
        });
    </script>
</head>
<body>
<%@include file="common/navigation.jsp"%>
<div class="wrap">
    <div class="title">颜色分类信息修改</div>
    <div class="tip">所属商品：${color.product.name}</div>
    <div>
        <form id="form" action="adminUpdateColor" method="post">
            <table class="table">
                <tr>
                    <td>颜色分类名称</td>
                    <td><input type="text" id="name" class="form-control" name="colorValue" value="${color.colorValue}"></td>
                </tr>
                <tr>
                    <td>颜色分类库存</td>
                    <td><input type="text" id="stock" class="form-control" name="stock" value="${color.stock}"></td>
                </tr>
                <tr>
                    <td>
                        <input type="hidden" name="id" value="${color.id}">
                        <input type="hidden" name="pid" value="${color.product.id}">
                    </td>
                    <td><input type="submit" class="btn btn-success btn-css" value="提交"></td>
                </tr>
            </table>
        </form>
    </div>
</div>
</body>
</html>
