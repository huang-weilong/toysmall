<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/2/2
  Time: 17:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <title>图片管理</title>
    <link rel="shortcut icon" href="images/frontEnd/long.ico">
    <link rel="stylesheet" href="css/bootstrap-3.3.7/css/bootstrap.css"/>
    <link rel="stylesheet" href="css/admin/admin.css"/>
    <script src="js/jquery-3.3.1/jquery-3.3.1.min.js"></script>
    <script>
        $(function(){
            $(".product-son").slideDown();
            $("#addGoods").submit(function(){
                if($("#goodsImage").val().length == 0){
                    alert("请选择图片");
                    return false;
                }
                return true;
            });
            $("#addDetail").submit(function(){
                if($("#detailImage").val().length == 0){
                    alert("请选择图片");
                    return false;
                }
                return true;
            });
            $(".delete").click(function () {
                var flag = confirm("确认删除？");
                if (flag) {
                    var url = "adminDeleteProductImage";
                    var imageId = $(this).attr("imageId");
                    $.post(
                        url,
                        {"imageId": imageId},
                        function (result) {
                            if (result == "yes")
                                location.reload();
                            else if (result == "timeout") {
                                alert("登录超时，请重新登录！");
                                location.href = "adminLoginPage";
                            }
                            else
                                alert("错误，请检查参数是否正确！");
                        }
                    )
                }
            });
        });
    </script>
</head>
<body>
<%@include file="common/navigation.jsp"%>
<div class="wrap">
    <div class="title">图片管理</div>
    <div class="tip">所属商品：${product.name}</div>
    <div class="back"><a href="adminListProduct?cid=${product.cid}">返回</a></div>
    <table class="table">
        <tr>
            <td>
                <form id="addGoods" action="adminAddProductImage" method="post" enctype="multipart/form-data">
                    <table class="table">
                        <tr>
                            <td style="font-size: 18px;font-weight: 700;text-align: center">添加商品图片，最多5张</td>
                        </tr>
                        <tr>
                            <td><input id="goodsImage" type="file" name="image" /></td>
                        </tr>
                        <tr>
                            <td>
                                <input type="hidden" name="type" value="goods" />
                                <input type="hidden" name="pid" value="${product.id}" />
                                <input type="submit" class="btn btn-success btn-css" value="添加">
                            </td>
                        </tr>
                    </table>
                </form>
                <table class="table table-hover">
                    <tr>
                        <th>ID</th>
                        <th>商品图片</th>
                        <th>删除</th>
                    </tr>
                    <c:forEach items="${productImageListGoods}" var="goods">
                        <tr>
                            <td>${goods.id}</td>
                            <td>
                                <a href="images/goods/${goods.id}.jpg" target="_blank" title="点击查看原图">
                                    <img height="50px" src="images/goods/${goods.id}.jpg">
                                </a>
                            </td>
                            <td><a class="delete" imageId="${goods.id}" href="javascript:void(0)"><span class="glyphicon glyphicon-trash"></span></a></td>
                        </tr>
                    </c:forEach>
                </table>
            </td>
            <td>
                <form id="addDetail" action="adminAddProductImage" method="post" enctype="multipart/form-data">
                    <table class="table">
                        <tr>
                            <td style="font-size: 18px;font-weight: 700;text-align: center">添加商品详情图</td>
                        </tr>
                        <tr>
                            <td><input id="detailImage" type="file" name="image" /></td>
                        </tr>
                        <tr>
                            <td>
                                <input type="hidden" name="type" value="detail" />
                                <input type="hidden" name="pid" value="${product.id}" />
                                <input type="submit" class="btn btn-success btn-css" value="添加">
                            </td>
                        </tr>
                    </table>
                </form>
                <table class="table table-hover">
                    <tr>
                        <th>ID</th>
                        <th>商品详情图</th>
                        <th>删除</th>
                    </tr>
                    <c:forEach items="${productImageListDetail}" var="detail">
                        <tr>
                            <td>${detail.id}</td>
                            <td>
                                <a href="images/detail/${detail.id}.jpg" target="_blank" title="点击查看原图" >
                                    <img height="50px" src="images/detail/${detail.id}.jpg">
                                </a>
                            </td>
                            <td><a class="delete" imageId="${detail.id}" href="javascript:void(0)"><span class="glyphicon glyphicon-trash"></span></a></td>
                        </tr>
                    </c:forEach>
                </table>
            </td>
        </tr>
    </table>
</div>
</body>
</html>
