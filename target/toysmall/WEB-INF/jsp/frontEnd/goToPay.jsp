<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/3/14
  Time: 17:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title>请选择付款方式</title>
    <link rel="shortcut icon" href="images/frontEnd/long.ico">
    <link rel="stylesheet" href="css/frontEnd/order.css">
    <link rel="stylesheet" href="css/frontEnd/goToPay.css">
    <script src="js/jquery-3.3.1/jquery-3.3.1.min.js"></script>
    <script>
        $(function () {
            $(".yeepay").click(function () {
                $("#yeepay").prop("checked", "true");
            });
            $(".alipay").click(function () {
                $("#alipay").prop("checked", "true");
            });
            $("#form").submit(function () {
                $("#oid").val(${order.id});
                // 判断有没选择付款方式
                var flag = 0;
                $(".payWay").each(function () {
                    if (this.checked == true){
                        flag = 1;
                    }
                });
                if (flag == 0) {
                    alert("请选择付款方式！");
                    return false;
                }
            });
        })
    </script>
</head>
<body>
<%@include file="common/navigation.jsp"%>
<div class="order-wrap">
    <div class="order-inner">
        <div class="order">
            <div class="header">
                <div class="date"><fmt:formatDate value="${order.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></div>
                <div class="order-num">订单号：<span>${order.orderNum}</span></div>
                <div class="receiver">收件人：<span>${order.receiver}</span></div>
                <div class="tel">联系电话：<span>${order.tel}</span></div>
                <div class="address">收货地址：<span>${order.address}</span></div>
                <div class="remarks">备注：<span>${order.remarks}</span></div>
            </div>
            <div class="order-item">
                <table>
                    <c:forEach items="${orderItems}" var="ois" varStatus="vs">
                        <tr>
                            <td class="img"><img src="images/orderItem/${ois.id}.jpg" alt=""></td>
                            <td class="name"><a href="product?pid=${ois.pid}">${ois.product.name}</a></td>
                            <td class="color">颜色分类：${ois.color.colorValue}</td>
                            <td class="num">${ois.number}件</td>
                            <td class="sub-total">小计：￥<fmt:formatNumber value="${ois.product.discountPrice*ois.number}" minFractionDigits="2"/></td>
                            <c:if test="${vs.count == 1}">
                                <td class="total" rowspan="${fn:length(orderItems)}">总额：￥<fmt:formatNumber value="${total}" minFractionDigits="2"/></td>
                                <td class="status" rowspan="${fn:length(orderItems)}">未付款</td>
                            </c:if>
                        </tr>
                    </c:forEach>
                </table>
            </div>
        </div>
        <div class="form">
            <form id="form" action="payFromMyOrder" method="post">
                <input type="hidden" name="oid" id="oid">
                <div class="payWayTitle">请选择支付方式</div>
                <div class="way">
                    <input id="yeepay" type="radio" name="payWay" class="payWay" value="0">
                    <label for="yeepay"></label>
                    <span class="yeepay"></span>
                    <div class="yeepay-tip">（仅支持中国建设银行支付）</div>
                </div>
                <div class="way">
                    <input id="alipay" type="radio" name="payWay" class="payWay" value="1">
                    <label for="alipay"></label>
                    <span class="alipay"></span>
                </div>
                <input type="submit" class="submit" value="去支付">
            </form>
        </div>
    </div>
</div>
</body>
</html>
