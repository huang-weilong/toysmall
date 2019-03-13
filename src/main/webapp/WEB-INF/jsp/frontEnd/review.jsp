<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/3/2
  Time: 13:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>评价</title>
    <link rel="shortcut icon" href="images/frontEnd/long.ico">
    <link rel="stylesheet" href="css/frontEnd/review.css">
    <script src="js/jquery-3.3.1/jquery-3.3.1.min.js"></script>
    <script>
        $(function () {
           $("#btn-submit").click(function () {
               var message = $("#message").val();
               // if (message.length == 0) {
               //     alert("请输入评价信息");
               //     return false;
               // }
               if (message.length > 200) {
                   alert("评价内容限200字以内！");
                   return false;
               }
               var page = "addReview";
               $.post(
                   page,
                   {"message": message},
                   function (result) {
                       if (result == "yes")
                           location.href=("reviewSuccess");
                       else
                           location.href=("loginPage");
                   }
               );
           });
        });
    </script>
</head>
<body>
<%@include file="common/navigation.jsp"%>
<div class="review-wrap">
    <div class="review-inner">
        <c:if test="${empty addReviewSuccess}">
            <p class="name">${product.name}</p>
            <div><img src="images/goods/${product.coverImage.id}.jpg" alt=""></div>
            <p class="review">买家评价</p>
            <div><textarea name="message" id="message" placeholder="请输入你对商品的评价~限200字以内" maxlength="200"></textarea></div>
            <div id="btn-submit" class="btn-submit">提交</div>
        </c:if>
        <c:if test="${!empty addReviewSuccess}">
            <div class="review-success">评价成功！</div>
        </c:if>
    </div>
</div>
</body>
</html>
