<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/2/6
  Time: 20:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>商城首页</title>
    <link rel="shortcut icon" href="images/frontEnd/long.ico">
    <link rel="stylesheet" href="css/frontEnd/index.css">
    <script src="js/jquery-3.3.1/jquery-3.3.1.min.js"></script>
    <script src="js/carousel.js"></script>
    <script src="js/back-to-top.js"></script>
</head>
<body>
<%@include file="common/navigation.jsp"%>
<%@include file="common/search.jsp"%>
<div class="wrap">
    <div class="category-wrap">
        <h2 class="toys-category">玩具商品分类</h2>
        <div class="toys-category-bd">
            <div class="toys-category-item">
                <h3 class="toys-category-title">益智玩具</h3>
                <p class="toys-category-list">
                    <c:forEach items="${categories}" var="cs">
                        <c:if test="${cs.flag==1}">
                            <a href="productResult?cid=${cs.id}&sort=sortByComposite">${cs.name}</a>
                        </c:if>
                    </c:forEach>
                </p>
            </div>
            <div class="toys-category-item">
                <h3 class="toys-category-title">遥控电动</h3>
                <p class="toys-category-list">
                    <c:forEach items="${categories}" var="cs">
                        <c:if test="${cs.flag==2}">
                            <a href="productResult?cid=${cs.id}&sort=sortByComposite">${cs.name}</a>
                        </c:if>
                    </c:forEach>
                </p>
            </div>
            <div class="toys-category-item">
                <h3 class="toys-category-title">积木拼插</h3>
                <p class="toys-category-list">
                    <c:forEach items="${categories}" var="cs">
                        <c:if test="${cs.flag==3}">
                            <a href="productResult?cid=${cs.id}&sort=sortByComposite">${cs.name}</a>
                        </c:if>
                    </c:forEach>
                </p>
            </div>
            <div class="toys-category-item">
                <h3 class="toys-category-title">毛绒/娃娃</h3>
                <p class="toys-category-list">
                    <c:forEach items="${categories}" var="cs">
                        <c:if test="${cs.flag==4}">
                            <a href="productResult?cid=${cs.id}&sort=sortByComposite">${cs.name}</a>
                        </c:if>
                    </c:forEach>
                </p>
            </div>
            <div class="toys-category-item">
                <h3 class="toys-category-title">健身玩具</h3>
                <p class="toys-category-list">
                    <c:forEach items="${categories}" var="cs">
                        <c:if test="${cs.flag==5}">
                            <a href="productResult?cid=${cs.id}&sort=sortByComposite">${cs.name}</a>
                        </c:if>
                    </c:forEach>
                </p>
            </div>
            <div class="toys-category-item">
                <h3 class="toys-category-title">创意IDY</h3>
                <p class="toys-category-list">
                    <c:forEach items="${categories}" var="cs">
                        <c:if test="${cs.flag==6}">
                            <a href="productResult?cid=${cs.id}&sort=sortByComposite">${cs.name}</a>
                        </c:if>
                    </c:forEach>
                </p>
            </div>
        </div>
    </div>
    <%--轮播图--%>
    <div class="carousel-wrap">
        <div class="ft-carousel" id="carousel">
            <ul class="carousel-inner">
                <li class="carousel-item"><a href="#"><img src="images/banner/a1.jpg"/></a></li>
                <li class="carousel-item"><a href="#"><img src="images/banner/a2.jpg" alt="兰博基尼遥控车"/></a></li>
                <li class="carousel-item"><img src="images/banner/a3.jpg"/></li>
                <li class="carousel-item"><a href="#"><img src="images/banner/a4.jpg" alt="无人机"/></a></li>
                <li class="carousel-item"><img src="images/banner/a5.jpg"/></li>
            </ul>
        </div>
    </div>
    <script type="text/javascript">
        $("#carousel").FtCarousel();
    </script>
</div>
<div class="wrap-all">
    <div class="category-title">
        <div style="float: left;width:497px;background: url('images/frontEnd/border3.png')repeat">&nbsp;</div>
        <div style="float:left;padding: 0 55px">益智玩具</div>
        <div style="float: left;width:497px;background: url('images/frontEnd/border3.png')repeat">&nbsp;</div>
    </div>
    <div class="wrap-grid">
        <div class="product-p1"><a href="#"><img src="images/index/734.jpg" alt=""></a></div>
        <div class="product-p2"><a href="#"><img src="images/index/311.jpg" alt=""></a></div>
        <div class="product-p3"><a href="#"><img src="images/index/462.jpg" alt=""></a></div>
        <div class="product-p4"><a href="#"><img src="images/index/757.jpg" alt=""></a></div>
        <div class="product-p5"><a href="#"><img src="images/index/743.jpg" alt=""></a></div>
    </div>
</div>
<div class="wrap-all">
    <div class="category-title">
        <div style="float: left;width:497px;background: url('images/frontEnd/border3.png')repeat">&nbsp;</div>
        <div style="float:left;padding: 0 55px">遥控电动</div>
        <div style="float: left;width:497px;background: url('images/frontEnd/border3.png')repeat">&nbsp;</div>
    </div>
    <div class="wrap-grid">
        <div class="product-p1"><a href="#"><img src="images/index/930.jpg" alt=""></a></div>
        <div class="product-p2"><a href="#"><img src="images/index/1534.jpg" alt=""></a></div>
        <div class="product-p3"><a href="#"><img src="images/index/1653.jpg" alt=""></a></div>
        <div class="product-p4"><a href="#"><img src="images/index/962.jpg" alt=""></a></div>
        <div class="product-p5"><a href="#"><img src="images/index/1518.jpg" alt=""></a></div>
    </div>
</div>
<div class="wrap-all">
    <div class="category-title">
        <div style="float: left;width:497px;background: url('images/frontEnd/border3.png')repeat">&nbsp;</div>
        <div style="float:left;padding: 0 55px">积木拼插</div>
        <div style="float: left;width:497px;background: url('images/frontEnd/border3.png')repeat">&nbsp;</div>
    </div>
    <div class="wrap-grid">
        <div class="product-p1"><a href="#"><img src="images/index/1913.jpg" alt=""></a></div>
        <div class="product-p2"><a href="#"><img src="images/index/2201.jpg" alt=""></a></div>
        <div class="product-p3"><a href="#"><img src="images/index/2100.jpg" alt=""></a></div>
        <div class="product-p4"><a href="#"><img src="images/index/1968.jpg" alt=""></a></div>
        <div class="product-p5"><a href="#"><img src="images/index/1999.jpg" alt=""></a></div>
    </div>
</div>
<div class="wrap-all">
    <div class="category-title">
        <div style="float: left;width:497px;background: url('images/frontEnd/border3.png')repeat">&nbsp;</div>
        <div style="float:left;padding: 0 49px">毛绒/娃娃</div>
        <div style="float: left;width:497px;background: url('images/frontEnd/border3.png')repeat">&nbsp;</div>
    </div>
    <div class="wrap-grid">
        <div class="product-p1"><a href="#"><img src="images/index/2249.jpg" alt=""></a></div>
        <div class="product-p2"><a href="#"><img src="images/index/2310.jpg" alt=""></a></div>
        <div class="product-p3"><a href="#"><img src="images/index/2405.jpg" alt=""></a></div>
        <div class="product-p4"><a href="#"><img src="images/index/2491.jpg" alt=""></a></div>
        <div class="product-p5"><a href="#"><img src="images/index/2250.jpg" alt=""></a></div>
    </div>
</div>
<img src="images/frontEnd/top1.png" class="back-top" alt="返回顶部">
<%@include file="common/footer.jsp"%>
</body>
</html>
