<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/2/24
  Time: 18:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>购物车</title>
    <link rel="shortcut icon" href="images/frontEnd/long.ico">
    <script src="js/jquery-3.3.1/jquery-3.3.1.min.js"></script>
    <link rel="stylesheet" href="css/frontEnd/showCart.css">
    <script>
        $(function () {
            // 全选
           $("#select-all").click(function () {
               var all = $("input[name='select-p']");
               if (this.checked == true) {
                   for (var i = 0; i < all.length; i++)
                       all[i].checked = true;
                   selectOrNot();
                   calculate();
               } else {
                   for (var i = 0; i < all.length; i++)
                      all[i].checked = false;
                   selectOrNot();
                   calculate();
               }
           });
           // 单选
            $(".cartItem").click(function () {
                // 判断是否全选了
                var selectAll = true;
                $(".cartItem").each(function () {
                    if (this.checked == false) {
                        selectAll = false;
                    }
                });
                if (selectAll)
                    $("#select-all")[0].checked = true;
                else
                    $("#select-all")[0].checked = false;
                selectOrNot();
                calculate();
            });
            // 是否选择了至少一个订单项
            function selectOrNot() {
                var selectOrNot = false;
                $(".cartItem").each(function () {
                    if (this.checked == true)
                        selectOrNot = true;
                    if (selectOrNot) {
                        $(".btn-submit span").css("background-color", "#df3033");
                        $(".btn-submit span").css("cursor", "pointer");
                        $(".btn-submit span").removeAttr("disabled");
                        $(".btn-submit span").attr("href", "##");
                    }else {
                        $(".btn-submit span").css("background-color", "#bbbbbb");
                        $(".btn-submit span").css("cursor", "not-allowed");
                        $(".btn-submit span").attr("disabled", "disabled");
                        $(".btn-submit span").attr("href", "#");
                    }
                });
            }
            // 计算总价和件数
            function calculate() {
                var sum = 0;
                var count = 0;
                $("input[name='select-p']:checked").each(function () {
                    var oiid = $(this).attr("oiid");
                    // 小计是存在自定义的sub-t属性中的，因为text中含有“￥”，取值不方便
                    var price = $(".subtotal[oiid="+oiid+"]").attr("sub-t");
                    sum+=new Number(price);
                    var num = $(".num[oiid="+oiid+"]").val();
                    count+=new Number(num);
                });
                $(".total span").text("￥"+sum.toFixed(2));
                $(".count span").text(count);
            }
            // 数量减少
            $(".sub").click(function () {
                var oiid = $(this).attr("oiid");
                var num = $(".num[oiid="+oiid+"]").val();
                var price = $(this).attr("price");
                --num;
                if (num <= 1)
                    num = 1;
                calculatePrice(oiid, num, price);
            });
            // 数量增加
            $(".add").click(function () {
                var oiid = $(this).attr("oiid");
                var num = parseInt($(".num[oiid="+oiid+"]").val());
                var stock = parseInt($(this).attr("stock"));
                var price = $(this).attr("price");
                ++num;
                if (num > stock)
                    num = stock;
                calculatePrice(oiid, num, price);
            });
            // 键盘输入改变数量
            $(".num").keyup(function () {
                var oiid = $(this).attr("oiid");
                var num = $(".num[oiid="+oiid+"]").val();
                var stock = parseInt($(this).attr("stock"));
                var price = parseInt($(this).attr("price"));
                if (isNaN(num))
                    num = 1;
                if (num > stock)
                    num = stock;
                if (num < 0)
                    num = 1;
                calculatePrice(oiid, num, price);
            });
            // 计算小计总数并更新后台数据
            function calculatePrice(oiid, num, price) {
                $(".num[oiid="+oiid+"]").val(num);
                var subTotal = new Number(num*price);
                $(".subtotal[oiid="+oiid+"]").text("￥"+subTotal.toFixed(2));
                $(".subtotal[oiid="+oiid+"]").attr("sub-t", subTotal.toFixed(2));
                calculate();
                var page = "updateOrderItem";
                $.post(
                    page,
                    {"oiid":oiid, "num":num},
                    function (result) {
                        if (result != "yes")
                            location.href="loginPage";
                    }
                );
            }
            // 删除订单项
            $(".operating a").click(function () {
                var oiid = $(this).attr("oiid");
                if (confirm("确认删除吗？")){
                    var page = "deleteOrderItem";
                    $.post(
                        page,
                        {"oiid":oiid},
                        function (result) {
                            if (result == "yes")
                                location.reload();
                            else
                                location.href="loginPage";
                        }
                    );
                }
            });
            //去结算
            $(".btn-submit span").click(function () {
                var params = "";
                $(".cartItem").each(function () {
                    if (this.checked == true) {
                        var oiid = $(this).attr("oiid");
                        params += "&oiid=" + oiid;
                    }
                });
                if (params == "")
                    return false;
                params = params.substring(1);
                // http的参数是以key-value的形式传递的，springMVC会自动绑定key与形参名相同的参数。
                location.href = "buy?" + params;
            });
            selectOrNot();
            calculate();
        });
    </script>
</head>
<body>
<%@include file="common/navigation.jsp"%>
<div class="cart-wrap">
    <div class="logo">
        <img src="images/frontEnd/cart.png" alt="">
    </div>
    <div class="content">
        <table>
            <tr class="header">
                <td class="h-select">
                    <input type="checkbox" id="select-all" name="select-all">
                    <span>全选</span>
                </td>
                <td>商品</td>
                <td>单价</td>
                <td>数量</td>
                <td>小计</td>
                <td>操作</td>
            </tr>
            <c:forEach items="${orderItems}" var="orderItem">
            <tr>
                <td class="select">
                    <div class="box">
                        <input oiid="${orderItem.id}" type="checkbox" name="select-p" class="cartItem">
                    </div>
                    <img src="images/goods_small/${orderItem.product.coverImage.id}.jpg" alt="">
                </td>
                <td class="product">
                    <div class="p-name"><a href="product?pid=${orderItem.pid}">${orderItem.product.name}</a></div>
                    <div class="p-color">颜色：${orderItem.color.colorValue}</div>
                </td>
                <td class="price">￥${orderItem.product.discountPrice}</td>
                <td class="num-wrap">
                    <div class="num-inner">
                        <span class="sub" stock="${orderItem.color.stock}" oiid="${orderItem.id}" price="${orderItem.product.discountPrice}">-</span>
                        <input type="text" class="num" stock="${orderItem.color.stock}"  price="${orderItem.product.discountPrice}" oiid="${orderItem.id}" pid="${orderItem.pid}" value="${orderItem.number>orderItem.color.stock?orderItem.color.stock:orderItem.number}">
                        <span class="add" stock="${orderItem.color.stock}" oiid="${orderItem.id}" price="${orderItem.product.discountPrice}">+</span>
                    </div>
                </td>
                <td class="subtotal" oiid="${orderItem.id}" sub-t="${orderItem.product.discountPrice*orderItem.number}">
                    ￥<fmt:formatNumber type="number" value="${orderItem.product.discountPrice*orderItem.number}" minFractionDigits="2"/>
                </td>
                <td class="operating"><a href="#" oiid="${orderItem.id}">删除</a></td>
            </tr>
            </c:forEach>
            <c:if test="${empty orderItems}">
                <tr>
                    <td colspan="6" style="text-align: center"><img src="images/frontEnd/noProduct.png" width="300px" alt=""></td>
                </tr>
                <tr>
                    <td colspan="6" class="no-order-item">购物车空空如也，快去商城看看吧~</td>
                </tr>
            </c:if>
            <tr class="end">
                <td colspan="2"></td>
                <td  class="count">已选择<span>0</span>件商品</td>
                <td colspan="2" class="total">总计：<span>￥0.00</span></td>
                <td class="btn-submit"><span>去结算</span></td>
            </tr>
        </table>
    </div>
</div>
<div class="footer"><%@include file="common/footer.jsp"%></div>
</body>
</html>
