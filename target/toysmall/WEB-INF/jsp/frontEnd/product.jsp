<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/2/11
  Time: 15:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <%@include file="common/navigation.jsp"%>
    <title>${product.name}</title>
    <link rel="shortcut icon" href="images/frontEnd/long.ico">
    <link rel="stylesheet" href="css/frontEnd/product.css">
    <script src="js/jquery-3.3.1/jquery-3.3.1.min.js"></script>
    <script src="js/jquery.cookie.js"></script>
    <script src="js/back-to-top.js"></script>
    <script>
        $(function(){
            // 选项卡cookie,0是商品详情，1是商品评论
            var i = $.cookie("tab-flag");
            if (i == null)
                i=0;

            $(".tab-header li").removeClass("active").eq(i).addClass("active");
            $(".content .content-box").removeClass("active").eq(i).addClass("active");
            // 切换图片
            $(".p-image-small img").mouseenter(function(){
                var bigImageURL = $(this).attr("burl");
                $(".p-img").attr("src",bigImageURL);
            });
            // 选择颜色分类
            $(".c").click(function () {
                if($(this).hasClass("c-selected")) return;

                $(".c-selected").removeClass("c-selected");
                $(this).addClass("c-selected");
                var stock = parseInt($(this).attr("data-stock"));
                // 设置对应颜色分类的库存
                $("#stock").text(stock);
                $("#num").attr("max", stock);
                var num = parseInt($("#num").val());
                if (num > stock)
                    $("#num").val(stock);
            });
            $(".add").click(function(){
                var num = parseInt($(".num-input").val());
                var max = parseInt($(".num-input").attr("max"));
                num++;
                if(num>max)
                    num = max;
                $(".num-input").val(num);
            });
            $(".sub").click(function(){
                var num = parseInt($(".num-input").val());
                num--;
                if(num<1)
                    num = 1;
                $(".num-input").val(num);
            });
            //实时监控输入框的数量，控制范围
            $(".num-input").on("input",function () {
                var num = parseInt($(this).val());
                var max = parseInt($(this).attr("max"));
                if (num>max)
                    $(this).val(max);
                if (num<1)
                    $(this).val(1);
            });
            // 切换选项卡
            $(".tab-header li").on("click", function(){
                var i = $(this).index();
                $(".tab-header li").removeClass("active").eq(i).addClass("active");
                $(".content .content-box").removeClass("active").eq(i).addClass("active");
                $.cookie("tab-flag",i);
                console.log(i);
            });
            // 加入购物车按钮
            $("#addCart").click(function () {
                // 判断用户是否登录
                var check = "checkLogin";
                $.post(
                    check,
                    function (result) {
                        if (result == "yes") {
                            console.log("已登录");
                        } else {
                            console.log("未登录");
                            $("#loginBox").css("display","block");
                            return false;
                        }
                    }
                );
                // 判断是否选择颜色分类
                if ($(".c").hasClass("c-selected") == false) {
                    alert("请选择颜色分类");
                    console.log("请选择颜色分类");
                    return false;
                }
                // 当前选中的颜色分类的id
                var colorId = $(".c-selected").attr("data-value");
                var colorValue = $(".c-selected").text();
                // 加入购物车
                var add = "addCart";
                $.post(
                    add,
                    {"pid": ${product.id},"num": $("#num").val(),"colorValue": colorValue,"colorId":colorId},
                    function (result) {
                        if (result == "success") {
                            showSuccess();
                        }
                        console.log("加入购物车成功");
                    }
                );
            });
            function showSuccess() {
                var times = 2;
                var timer = null;
                timer = setInterval(function() {
                    times--;
                    if(times == 0) {
                        $(".add-cart-success").css("display","none");
                        clearInterval(timer);
                    } else {
                        console.log(times+"秒后自动跳转");
                        $(".add-cart-success").css("display","inline-block");
                    }
                }, 1000);
            }
        });
    </script>
</head>
<body>
<%@include file="modalLogin.jsp"%>
<%@include file="common/search.jsp"%>
<div class="product-detail-wrap">
    <div class="product-detail-inner">
        <div class="product-detail-box">
            <h3>${product.category.name}</h3>
            <%--左边图片部分--%>
            <div class="p-image">
                <img src="images/goods/${product.coverImage.id}.jpg" class="p-img">
                <div class="p-image-small">
                    <c:forEach items="${product.productGoodImages}" var="pi">
                        <img src="images/goods_small/${pi.id}.jpg" burl="images/goods/${pi.id}.jpg">
                    </c:forEach>
                </div>
            </div>
            <%--右边文字部分--%>
            <div class="p-right">
                <h3>${product.name}</h3>
                <h4>${product.title}</h4>
                <div class="p-box">
                    <p class="o-price">原价：<del><span><fmt:formatNumber minFractionDigits="2" value="${product.originalPrice}"></fmt:formatNumber></span>元</del></p>
                    <p class="d-price">现价：<span><fmt:formatNumber minFractionDigits="2" value="${product.discountPrice}"></fmt:formatNumber></span>元</p>
                    <p class="rs">销量：<span>${product.saleCount}</span></p>
                </div>
                <div class="color-box">
                    <p>颜色分类：</p>
                    <c:forEach items="${colors}" var="color">
                        <c:if test="${color.stock != 0}">
                            <a href="javascript:void(0)" class="c" data-value="${color.id}" data-stock="${color.stock}">${color.colorValue}</a>
                        </c:if>
                    </c:forEach>
                </div>
                <div class="num-wrap">
                    <p>数量</p>
                    <div class="num">
                        <input type="number" class="num-input" id="num" min="1" max="${sumStock}" value="1"/>
                        <span class="add-sub">
                            <a href="javascript:void(0)" class="add">+</a>
                            <a href="javascript:void(0)" class="sub">-</a>
                        </span>
                    </div>
                    <p>（库存：<span id="stock">${sumStock}</span>件）</p>
                </div>
                <a href="javascript:void(0)" id="addCart" class="add-cart">加入购物车</a>
                <%--<span class="add-cart-success">加入购物车成功</span>--%>
            </div>
        </div>
        <%--商品详情和评论部分--%>
        <div class="review-detail-box">
            <!-- 选项卡 -->
            <div class="tab-header">
                <ul>
                    <li class="active" status="1">商品详情</li>
                    <li status="0">商品评论 (${product.reviewCount}条)</li>
                </ul>
            </div>
            <!-- 选项内容 -->
            <div class="content">
                <div class="content-box first-content active">
                    <ul>
                        <c:forEach items="${propertyValues}" var="ptv">
                            <li>${ptv.property.name}:${ptv.ptValue}</li>
                        </c:forEach>
                    </ul>
                    <c:forEach items="${product.productDetailImages}" var="pdi">
                        <img src="images/detail/${pdi.id}.jpg" style="max-width: 800px" alt="">
                    </c:forEach>
                </div>
                <div class="content-box second-content">
                    <table>
                        <c:forEach items="${reviews}" var="r">
                            <tr>
                                <td class="name" rowspan="2">${r.user.anonymousName}</td>
                                <td class="message">${r.message}</td>
                            </tr>
                            <tr>
                                <td class="color-date">颜色分类：${r.orderItem.color.colorValue}&nbsp; &nbsp; &nbsp;
                                    <fmt:formatDate value="${r.createDate}" pattern="yyyy-MM-dd" />
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                    <c:if test="${page.total > page.count}">
                        <div class="page"><%@include file="common/page.jsp" %></div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
    <img src="images/frontEnd/top1.png" class="back-top" alt="">
    <span class="add-cart-success">加入购物车成功</span>
</div>
<div class="footer"><%@include file="common/footer.jsp"%></div>
</body>
</html>
