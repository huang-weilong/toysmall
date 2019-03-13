<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/2/2
  Time: 13:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>商品管理</title>
    <link rel="shortcut icon" href="images/frontEnd/long.ico">
    <link rel="stylesheet" href="css/bootstrap-3.3.7/css/bootstrap.css"/>
    <link rel="stylesheet" href="css/admin/admin.css"/>
    <script src="js/jquery-3.3.1/jquery-3.3.1.min.js"></script>
    <style>
        .add a {
            margin-right: 20px;
        }
        .add form {
            display: inline-block;
        }
    </style>
    <script>
        $(function () {
            $(".product-son").slideDown();
            // 下架
            $(".unshelve").click(function () {
                var url = "unShelve";
                var pid = $(this).attr("pid");
                $.post(
                    url,
                    {"pid": pid},
                    function (result) {
                        if (result === "yes")
                            location.reload();
                        else if (result === "timeout") {
                            alert("登录超时，请重新登录！");
                            location.href = "adminLoginPage";
                        }
                        else
                            alert("错误，请检查参数是否正确！");
                    }
                )
            });
            // 上架
            $(".shelve").click(function () {
                var url = "shelve";
                var pid = $(this).attr("pid");
                $.post(
                    url,
                    {"pid": pid},
                    function (result) {
                        if (result === "yes")
                            location.reload();
                        else if (result === "timeout") {
                            alert("登录超时，请重新登录！");
                            location.href = "adminLoginPage";
                        }
                        else
                            alert("错误，请检查参数是否正确！");
                    }
                )
            });
            // 恢复
            $(".restore").click(function () {
                var url = "restore";
                var pid = $(this).attr("pid");
                $.post(
                    url,
                    {"pid": pid},
                    function (result) {
                        if (result === "yes")
                            location.reload();
                        else if (result === "timeout") {
                            alert("登录超时，请重新登录！");
                            location.href = "adminLoginPage";
                        }
                        else
                            alert("错误，请检查参数是否正确！");
                    }
                )
            });
            $(".delete").click(function () {
                var flag = confirm("确认删除？");
                if (flag) {
                    var url = "adminDeleteProduct";
                    var pid = $(this).attr("pid");
                    $.post(
                        url,
                        {"pid": pid},
                        function (result) {
                            if (result === "yes")
                                location.reload();
                            else if (result === "timeout") {
                                alert("登录超时，请重新登录！");
                                location.href = "adminLoginPage";
                            }
                            else
                                alert("错误，请检查参数是否正确！");
                        }
                    )
                }
            });
        })
    </script>
</head>
<body>
<%@include file="common/navigation.jsp"%>
<div class="wrap">
    <c:if test="${!empty normal}">
        <div class="title">商品列表</div>
    </c:if>
    <c:if test="${empty normal}">
        <div class="title">商品列表（已删除）</div>
    </c:if>
    <div class="tip">所属分类：${category.name}</div>
    <div class="add">
        <a href="addProduct?cid=${category.id}">添加商品</a>
        <a href="showDelete?cid=${category.id}">查看已删除商品</a>
        <c:if test="${empty normal}">
            <a href="adminListProduct?cid=${category.id}">返回</a>
        </c:if>
        <c:if test="${!empty normal}">
            <form action="searchProduct" method="post" autocomplete="off">
                商品名 <input id="keyword" class="search-input" type="text" name="keyword" value="${keyword}">
                <input type="hidden" name="cid" value="${category.id}">
                <input type="submit" class="btn btn-info search-btn" value="搜索">
            </form>
        </c:if>
    </div>
    <div>
        <table class="table table-hover table-condensed product-tb">
            <tr>
                <th>ID</th>
                <th>商品图片</th>
                <th>商品名称</th>
                <th>小标题</th>
                <th>原价格</th>
                <th>优惠价格</th>
                <th width="40px">图片管理</th>
                <th width="40px">属性值</th>
                <th width="40px">颜色分类</th>
                <th width="40px">编辑</th>
                <th width="40px">操作</th>
                <c:if test="${!empty normal}">
                    <th width="40px">删除</th>
                </c:if>
            </tr>
            <c:forEach items="${products}" var="p">
                <tr>
                    <td>${p.id}</td>
                    <td><img width="50px" src="images/goods/${p.coverImage.id}.jpg"></td>
                    <td>${p.name}</td>
                    <td>${p.title}</td>
                    <td><fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" value="${p.originalPrice}"></fmt:formatNumber></td>
                    <td><fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" value="${p.discountPrice}"></fmt:formatNumber></td>
                    <td><a href="adminListProductImage?pid=${p.id}"><span class="glyphicon glyphicon-picture"></span></a></td>
                    <td><a href="adminEditPropertyValue?pid=${p.id}"><span class="glyphicon glyphicon-th-list"></span></a></td>
                    <td><a href="adminListColor?pid=${p.id}"><span class="glyphicon glyphicon-asterisk"></span></a></td>
                    <td><a href="adminEditProduct?id=${p.id}"><span class="glyphicon glyphicon-edit"></span></a></td>
                    <c:if test="${p.display == 1}">
                        <td><a class="unshelve" pid="${p.id}" href="javascript:void(0)">下架</a></td>
                    </c:if>
                    <c:if test="${p.display == 2}">
                        <td><a class="shelve" pid="${p.id}" href="javascript:void(0)">上架</a></td>
                    </c:if>
                    <c:if test="${p.display == 3}">
                        <td><a class="restore" pid="${p.id}" href="javascript:void(0)">恢复</a></td>
                    </c:if>
                    <c:if test="${p.display != 3}">
                        <td><a class="delete" pid="${p.id}" href="javascript:void(0)"><span class="glyphicon glyphicon-trash"></span></a></td>
                    </c:if>
                </tr>
            </c:forEach>
        </table>
    </div>
    <c:if test="${page.total > page.count}">
        <div class="page"><%@include file="common/page.jsp" %></div>
    </c:if>
</div>
</body>
</html>
