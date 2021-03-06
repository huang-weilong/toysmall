<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/2/7
  Time: 16:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>${category.name}</title>
    <link rel="shortcut icon" href="images/frontEnd/long.ico">
    <link rel="stylesheet" href="css/frontEnd/productResult.css">
    <script src="js/jquery-3.3.1/jquery-3.3.1.min.js"></script>
    <script src="js/back-to-top.js"></script>
    <script>
        $(function () {
            $(".sortPrice").click(function () {
                var url = "productResult";
                var sort = "sortByPrice";
                $.post(
                    url,
                    {"sort": sort},
                    function (re) {

                    }
                );
            });
            $(".sortSale").click(function () {
                var url = "productResult";
                var sort = "sortBySale";
                $.post(
                    url,
                    {"sort": sort}
                );
            });
            if ("" === "${sort}" ) {
                $(".by-composite").addClass("sort-select");
            }
            if ("sortByComposite" === "${sort}" ) {
                $(".by-composite").addClass("sort-select");
            }
            if ("sortByPriceAsc" === "${sort}" ) {
                $(".by-price-ase").addClass("sort-select");
            }
            if ("sortByPriceDesc" === "${sort}" ) {
                $(".by-price-desc").addClass("sort-select");
            }
            if ("sortBySale" === "${sort}" ) {
                $(".by-sale").addClass("sort-select");
            }
            if ("sortByReview" === "${sort}" ) {
                $(".by-review").addClass("sort-select");
            }
        });
    </script>
</head>
<body>
<%@include file="common/navigation.jsp"%>
<%@include file="common/search.jsp"%>
<div class="product-wrap">
    <div class="product-inner">
        <div class="sort">
            <a class="by-composite" href="productResult?cid=${category.id}&sort=sortByComposite">综合</a>
            <a class="by-price-ase" href="productResult?cid=${category.id}&sort=sortByPriceAsc">价格升序<span class="glyphicon glyphicon-arrow-up"></span></a>
            <a class="by-price-desc" href="productResult?cid=${category.id}&sort=sortByPriceDesc">价格降序<span class="glyphicon glyphicon-arrow-down"></span></a>
            <a class="by-sale" href="productResult?cid=${category.id}&sort=sortBySale">销量<span class="glyphicon glyphicon-arrow-down"></span></a>
            <a class="by-review" href="productResult?cid=${category.id}&sort=sortByReview">评论数<span class="glyphicon glyphicon-arrow-down"></span></a>
        </div>
        <c:forEach items="${products}" var="p">
            <div class="product-box">
                <a href="product?pid=${p.id}"><img src="images/goods/${p.coverImage.id}.jpg" alt=""></a>
                <h3>￥<fmt:formatNumber minFractionDigits="2" value="${p.discountPrice}"></fmt:formatNumber></h3>
                <a href="product?pid=${p.id}" class="pname">
                    <p>${p.name}</p>
                </a>
                <div>
                    <a href="javascript:void(0)" class="review">评论 <span>${p.reviewCount}</span></a>
                    <a href="javascript:void(0)" class="sale-count">销量 <span>${p.saleCount}</span></a>
                </div>
            </div>
        </c:forEach>

        <c:if test="${empty products}">
            <div class="noMatch">
                <div><img src="images/frontEnd/noProduct.png" alt="noProduct"></div>
                <div>抱歉，没有满足条件的产品！</div>
            </div>
        </c:if>
    </div>
    <%--如果总页数大于每页个数才显示分页--%>
    <c:if test="${page.total > page.count}">
        <div class="page"><%@include file="common/page.jsp" %></div>
    </c:if>
</div>
<div style="clear:both;height: 50px"></div>
<img src="images/frontEnd/top1.png" class="back-top" alt="">
<div class="footer"><%@include file="common/footer.jsp"%></div>
</body>
</html>
