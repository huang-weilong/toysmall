<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/2/4
  Time: 19:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <title>添加商品</title>
    <link rel="shortcut icon" href="images/frontEnd/long.ico">
    <link rel="stylesheet" href="css/bootstrap-3.3.7/css/bootstrap.css"/>
    <link rel="stylesheet" href="css/admin/admin.css"/>
    <script src="js/jquery-3.3.1/jquery-3.3.1.min.js"></script>
    <style>
        .dropdown {
            width: 100%;
            height: 34px;
            border-radius: 4px;
            border: 1px solid #ccc;
        }
    </style>
    <script>
        $(function() {
            $(".product-son").slideDown();
            // 改变折扣时计算优惠价格
            $("#flag").change(function () {
                console.log($(this).val())
                $(".discountPrice").text(($("#originalPrice").val() / 10 * $(this).val()).toFixed(2) );
            })
            $("#form").submit(function() {
                if ($("#name").val().length === 0) {
                    alert("商品名称不能为空！");
                    return false;
                }
                if ($("#title").val().length === 0) {
                    alert("商品小标题不能为空！");
                    return false;
                }
                var originalPrice = $("#originalPrice").val();
                if (originalPrice.length === 0) {
                    alert("商品原价格不能为空！");
                    return false;
                }
                if ($("#flag").val()==0){
                    alert("请选择折扣");
                    return false;
                }
                //验证数字
                var reg = /^[+]{0,1}(\d+)$|^[+]{0,1}(\d+\.\d+)$/;
                if (!reg.test(originalPrice)) {
                    alert("商品原价格数值不正确，请重新输入！");
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
    <div class="title">添加商品</div>
    <div class="tip">所属分类：${category.name}</div>
    <div class="back"><a href="adminListProduct?cid=${category.id}">返回</a></div>
    <div>
        <form id="form" action="adminAddProduct" method="post">
            <table class="table">
                <tr>
                    <td>商品名称</td>
                    <td><input id="name" type="text" name="name" class="form-control"></td>
                </tr>
                <tr>
                    <td>商品小标题</td>
                    <td><input id="title" type="text" name="title" class="form-control"></td>
                </tr>
                <tr>
                    <td>原价格</td>
                    <td><input id="originalPrice" type="text" name="originalPrice" class="form-control"></td>
                </tr>
                <tr>
                    <td>折扣</td>
                    <td>
                        <select id="flag" name="discount" class="dropdown">
                            <option value="0">请选择</option>
                            <option value="9">9折</option>
                            <option value="8">8折</option>
                            <option value="7">7折</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>优惠价格</td>
                    <td><span class="discountPrice"></span></td>
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
