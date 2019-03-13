<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/2/25
  Time: 18:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>确认订单信息</title>
    <link rel="shortcut icon" href="images/frontEnd/long.ico">
    <link rel="stylesheet" href="css/frontEnd/buy.css">
    <script src="js/jquery-3.3.1/jquery-3.3.1.min.js"></script>
    <script>
        $(function () {
            $(".yeepay").click(function () {
                $("#yeepay").prop("checked", "true");
            });
            $(".alipay").click(function () {
                $("#alipay").prop("checked", "true");
            });
            $(".edit-cart").click(function () {
                window.history.back();
            });
            $("#form").submit(function () {
                var flag = 0;
                // 判断有没有选择收货地址
                $(".select-address").each(function () {
                    if (this.checked == true){
                        flag = 1;
                    }
                });
                if (flag == 0) {
                    alert("请选择收货地址！");
                    return false;
                }
                flag =0;
                // 判断有没选择付款方式
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
        });
    </script>
</head>
<body>
<%@include file="common/navigation.jsp"%>
<div class="check-wrap">
    <form action="createOrder" method="post" id="form">
        <div class="check-top">
            <img src="images/frontEnd/buy.png" alt="">
        </div>
        <div class="check-inner">
            <p>填写并核对订单信息</p>
            <div class="inner-box">
                <div class="box-receiver">
                    <span class="receiver">收货人信息</span>
                    <a href="addAddressPage" class="new-address">新建收件地址</a>
                    <div class="address">
                        <table>
                            <c:forEach items="${addresses}" var="address">
                                <tr>
                                    <td><input type="radio" name="aid" class="select-address" value="${address.id}"></td>
                                    <td>${address.name}</td>
                                    <td>${address.tel}</td>
                                    <td>${address.address}</td>
                                    <td>${address.post}</td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty addresses}">
                                <tr>
                                    <td colspan="5" class="no-address">咦...还没有收货地址。快去新建一个吧~</td>
                                </tr>
                            </c:if>
                        </table>
                    </div>
                </div>
                <div class="box-list">
                    <span class="list">订单详情</span>
                    <span class="edit-cart">返回修改购物车</span>
                    <div class="list-detail">
                        <table>
                            <tr>
                                <th></th>
                                <th>商品名称</th>
                                <th>颜色分类</th>
                                <th>单价</th>
                                <th>数量</th>
                                <th>小计</th>
                            </tr>
                            <c:forEach items="${orderItems}" var="ois">
                            <tr class="detail">
                                <td><img src="images/goods_small/${ois.product.coverImage.id}.jpg" alt=""></td>
                                <td class="name">${ois.product.name}</td>
                                <td class="color">${ois.color.colorValue}</td>
                                <td class="price">￥<fmt:formatNumber value="${ois.product.discountPrice}" minFractionDigits="2"/></td>
                                <td class="num">${ois.number}</td>
                                <td class="subtotal">￥<fmt:formatNumber value="${ois.product.discountPrice*ois.number}" minFractionDigits="2"/></td>
                            </tr>
                            </c:forEach>
                        </table>
                    </div>
                </div>
                <div class="box-pay">
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
                    <div class="total-pay">
                        <span>￥<fmt:formatNumber value="${total}" minFractionDigits="2" /></span>
                    </div>
                    <div class="total-text">
                        <span>应付总额</span>
                    </div>
                    <div class="total-num">
                        共计<span>${num}</span>件商品
                    </div>
                </div>
                <div class="box-confirm">
                    <span class="message">备注<input type="text" name="message"></span>
                    <input type="submit" class="submit" value="提交订单">
                </div>

            </div>
        </div>
    </form>
</div>
<div class="footer"><%@include file="common/footer.jsp"%></div>
</body>
</html>
