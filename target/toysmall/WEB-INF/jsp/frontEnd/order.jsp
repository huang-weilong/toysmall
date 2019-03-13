<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/2/27
  Time: 19:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title>我的订单</title>
    <link rel="shortcut icon" href="images/frontEnd/long.ico">
    <link rel="stylesheet" href="css/frontEnd/order.css">
    <script src="js/jquery-3.3.1/jquery-3.3.1.min.js"></script>
    <script src="js/back-to-top.js"></script>
    <script>
        $(function () {
           $(".delete").click(function () {
               if (confirm("确认删除？删除后不可恢复！")) {
                   var page = "deleteOrder";
                   var oid = $(this).attr("oid");
                   $.post(
                       page,
                       {"oid": oid},
                       function (result) {
                           if (result == "yes")
                               location.reload();
                           else
                               location.href="loginPage";
                       }
                   )
               }
           });
           $(".review span").click(function () {
               var pid = $(this).attr("pid");
               var oiid = $(this).attr("oiid");
               var page = "review";
               console.log(pid);
               $.post(
                   page,
                   {"pid": pid, "oiid": oiid},
                   function (result) {
                       if (result == "yes")
                           location.href = "reviewPage";
                   }
               )
           });
           $(".confirm").click(function () {
               if (confirm("请确认收到商品再确认收货，是否确认？")) {
                   var url = "confirm";
                   var oid = $(this).attr("oid");
                   $.post(
                        url,
                       {"oid": oid},
                       function (result) {
                           if (result == "yes")
                               location.reload();
                           else
                               location.href = "error400";
                       }
                   );
               }
           });
            if ("" === "${status}" ) {
                $(".all").addClass("select-status");
                $(".all a").addClass("select-a");
            }
            if ("waitPay" === "${status}" ) {
                $(".wait-pay").addClass("select-status");
                $(".wait-pay a").addClass("select-a");
            }
            if ("waitDelivery" === "${status}" ) {
                $(".wait-delivery").addClass("select-status");
                $(".wait-delivery a").addClass("select-a");
            }
            if ("waitConfirm" === "${status}" ) {
                $(".wait-confirm").addClass("select-status");
                $(".wait-confirm a").addClass("select-a");
            }
            if ("waitReview" === "${status}" ) {
                $(".wait-review").addClass("select-status");
                $(".wait-review a").addClass("select-a");
            }
            if ("finish" === "${status}" ) {
                $(".finish").addClass("select-status");
                $(".finish a").addClass("select-a");
            }
        });
    </script>
</head>
<body>
<%@include file="common/navigation.jsp"%>
<div class="order-wrap">
    <div class="order-inner">
        <div class="order-status">
            <span class="all"><a href="userOrderStatus?status=">全部订单</a></span>
            <span class="wait-pay"><a href="userOrderStatus?status=waitPay">待付款</a></span>
            <span class="wait-delivery"><a href="userOrderStatus?status=waitDelivery">待发货</a></span>
            <span class="wait-confirm"><a href="userOrderStatus?status=waitConfirm">待收货</a></span>
            <span class="wait-review"><a href="userOrderStatus?status=waitReview">待评价</a></span>
            <span class="finish"><a href="userOrderStatus?status=finish">完成</a></span>
        </div>
        <c:forEach items="${orders}" var="order">
        <div class="order">
            <div class="header">
                <div class="date"><fmt:formatDate value="${order.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></div>
                <div class="order-num">订单号：<span>${order.orderNum}</span></div>
                <div class="receiver">收件人：<span>${order.receiver}</span></div>
                <div class="tel">联系电话：<span>${order.tel}</span></div>
                <div class="address">收货地址：<span>${order.address}</span></div>
                <div class="remarks">备注：<span>${order.remarks}</span></div>
                <%--等待评论和完成的订单才能被删除--%>
                <c:if test="${order.status == 'waitReview' || order.status == 'finish'}">
                    <div class="delete" oid="${order.id}">删除</div>
                </c:if>
            </div>
            <div class="order-item">
                <table>
                    <c:forEach items="${order.orderItems}" var="ois" varStatus="vs">
                    <tr>
                        <td class="img"><img src="images/orderItem/${ois.id}.jpg" alt=""></td>
                        <td class="name"><a href="product?pid=${ois.pid}">${ois.product.name}</a></td>
                        <td class="color">颜色分类：${ois.color.colorValue}</td>
                        <td class="num">${ois.number}件</td>
                        <td class="sub-total">小计：￥<fmt:formatNumber value="${ois.product.discountPrice*ois.number}" minFractionDigits="2"/></td>
                        <c:if test="${vs.count == 1}">
                            <td class="total" rowspan="${fn:length(order.orderItems)}">总额：￥<fmt:formatNumber value="${order.total}" minFractionDigits="2"/></td>
                        </c:if>
                        <c:if test="${vs.count == 1 && order.status != 'waitReview'}">
                            <td class="status" rowspan="${fn:length(order.orderItems)}">
                                <c:if test="${order.status == 'waitPay'}">
                                    <a class="gotopay" href="goToPay?oid=${order.id}">去付款</a>
                                </c:if>
                                <c:if test="${order.status == 'waitDelivery'}">等待发货</c:if>
                                <c:if test="${order.status == 'waitConfirm'}">
                                    <span class="confirm" oid="${order.id}">确认收货</span>
                                </c:if>
                                <c:if test="${order.status == 'finish'}">完成</c:if>
                                </td>
                        </c:if>
                        <c:if test="${order.status == 'waitReview'}">
                            <c:if test="${ois.flag == 1}">
                                <td>完成</td>
                            </c:if>
                            <c:if test="${ois.flag == 0}">
                                <td class="review"><span pid="${ois.pid}" oiid="${ois.id}">去评价</span></td>
                            </c:if>
                        </c:if>
                    </tr>
                    </c:forEach>
                </table>
            </div>
        </div>
        </c:forEach>
    </div>
</div>
<img src="images/frontEnd/top1.png" class="back-top" alt="返回顶部">
<div class="footer"><%@include file="common/footer.jsp"%></div>
</body>
</html>
