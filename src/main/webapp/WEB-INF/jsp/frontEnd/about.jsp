<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/4/2
  Time: 16:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>关于本站</title>
    <link rel="shortcut icon" href="images/frontEnd/long.ico">
    <style>
        .about-wrap {
            margin: 100px auto 150px;
            padding: 50px;
            width: 700px;
            border: 3px solid #3e8f3e;
        }
        .about-wrap .about {
            margin-bottom: 20px;
            font-size: 24px;
            font-weight: 700;
            text-align: center;
        }
        .about-wrap .about img {
            width: 270px;
            height: 58px;
        }
        .about-wrap p {
            margin-top: 10px;
        }
    </style>
</head>
<body>
<%@include file="common/navigation.jsp"%>
<div class="about-wrap">
    <div class="about"><img src="images/frontEnd/about.png" alt=""></div>
    <p>1、本网上玩具商城是一个毕业设计作品。</p>
    <p>2、本站是非营利性站点，所有的操作不做商业用途，用户购买商品不会涉及真正的发货等流程。</p>
    <p>3、本站所使用的易宝支付仅用于测试，支付宝支付为沙箱环境。用户使用真实的支付宝支付将会支付失败。</p>
    <p>4、本站商品图片均来源于网上，如果作者本人或版权方不想让相关商品图片信息出现在本站，请联系550456817@qq.com，本人将尽快删除，为此给您带来的不便，敬请谅解！</p>
</div>
<%@include file="common/footer.jsp"%>
</body>
</html>
