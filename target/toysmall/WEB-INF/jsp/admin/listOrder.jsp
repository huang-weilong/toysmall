<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/2/3
  Time: 21:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>订单管理</title>
    <link rel="shortcut icon" href="images/frontEnd/long.ico">
    <link rel="stylesheet" href="css/bootstrap-3.3.7/css/bootstrap.css"/>
    <link rel="stylesheet" href="css/admin/admin.css"/>
    <script src="js/jquery-3.3.1/jquery-3.3.1.min.js"></script>
    <script>
        $(function(){
            $(".btn-order-detail").click(function(){
                var oid = $(this).attr("oid");
                $(".order-detail[oid="+oid+"]").toggle();
            });
            $(".delivery").click(function () {
                var url = "adminOrderDelivery";
                var oid = $(this).attr("oid");
                $.post(
                    url,
                    {"oid": oid},
                    function (result) {
                        if (result === "yes")
                            location.reload();
                        else
                            alert("错误！发货失败，请重试");
                    }
                )
            });
            if ("" === "${status}" ) {
                $(".all").addClass("select-a");
            }
            if ("waitPay" === "${status}" ) {
                $(".wait-pay").addClass("select-a");
            }
            if ("waitDelivery" === "${status}" ) {
                $(".wait-delivery").addClass("select-a");
            }
            if ("waitConfirm" === "${status}" ) {
                $(".wait-confirm").addClass("select-a");
            }
            if ("waitReview" === "${status}" ) {
                $(".wait-review").addClass("select-a");
            }
            if ("finish" === "${status}" ) {
                $(".finish").addClass("select-a");
            }
            if ("delete" === "${status}") {
                $(".delete").addClass("select-a");
            }
        });
    </script>
    <style>
        td {
            font-size: 14px;
        }
    </style>
</head>
<body>
<%@include file="common/navigation.jsp"%>
<div class="wrap">
    <div class="title">订单列表</div>
    <div class="order-status tip">
        <a class="all" href="adminListOrder">全部</a>
        <a class="wait-pay" href="orderStatus?status=waitPay">待付款</a>
        <a class="wait-delivery" href="orderStatus?status=waitDelivery">待发货</a>
        <a class="wait-confirm" href="orderStatus?status=waitConfirm">待收货</a>
        <a class="wait-review" href="orderStatus?status=waitReview">待评价</a>
        <a class="finish" href="orderStatus?status=finish">完成</a>
        <a class="delete" href="orderStatus?status=delete">已删除</a>
        <form action="searchOrder" method="post" autocomplete="off">
            <span class="search-order">
                订单号<input id="keyword" class="search-input" type="text" name="keyword" value="${param.keyword}">
                <input type="submit" class="btn btn-info search-btn" value="查询">
            </span>
        </form>
    </div>
    <div>
        <table class="table table-hover table-condensed">
            <tr>
                <th>用户名</th>
                <th>订单号</th>
                <th>买家姓名</th>
                <th>总计</th>
                <th>商品数量</th>
                <th>创建日期</th>
                <th>支付日期</th>
                <th>发货时间</th>
                <th>确认收货时间</th>
                <th>备注</th>
                <th>订单状态</th>
                <th>操作</th>
            </tr>
            <c:forEach items="${orders}" var="os">
                <tr>
                    <td>${os.user.username}</td>
                    <td>${os.orderNum}</td>
                    <td>${os.receiver}</td>
                    <td>￥<fmt:formatNumber value="${os.total}" minFractionDigits="2"/></td>
                    <td>${os.totalNum}</td>
                    <td><fmt:formatDate value="${os.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                    <td><fmt:formatDate value="${os.payDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                    <td><fmt:formatDate value="${os.deliveryDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                    <td><fmt:formatDate value="${os.confirmDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                    <td>${os.remarks}</td>
                    <td>${os.theStatus}</td>
                    <td>
                        <span class="btn btn-primary btn-xs btn-order-detail" oid="${os.id}">详情</span>
                        <c:if test="${os.status=='waitDelivery'}">
                            <span class="btn btn-success btn-xs delivery" oid="${os.id}">发货</span>
                        </c:if>
                    </td>
                </tr>
                <tr class="order-detail" oid="${os.id}">
                    <td colspan="10">
                        <table class="table">
                            <c:forEach items="${os.orderItems}" var="ois">
                                <tr>
                                    <td><img width="50px" height="50px" src="images/orderItem/${ois.id}.jpg"></td>
                                    <td><a href="product?pid=${ois.product.id}"><span>${ois.product.name}</span></a></td>
                                    <td>颜色分类：${ois.color.colorValue}</td>
                                    <td>${ois.number}个</td>
                                    <td>单价：￥${ois.product.discountPrice}</td>
                                </tr>
                            </c:forEach>
                        </table>
                    </td>
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
