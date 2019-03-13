<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/2/28
  Time: 13:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>个人中心</title>
    <link rel="shortcut icon" href="images/frontEnd/long.ico">
    <link rel="stylesheet" href="css/frontEnd/homePage.css">
    <script src="js/jquery-3.3.1/jquery-3.3.1.min.js"></script>
    <script>
        $(function () {
           $(".delete").click(function () {
               var aid = $(this).attr("aid");
               if (confirm("确认删除？")) {
                   var page = "deleteAddress";
                   $.post(
                       page,
                       {"aid" : aid},
                       function (result) {
                           if (result == "yes")
                               location.reload();
                           else
                               location.href="loginPage";
                       }
                   );
               }
           });
        });
    </script>
</head>
<body>
<%@include file="common/navigation.jsp"%>
<div class="home-wrap">
    <div class="home-inner">
        <div style="text-align: center; font-size: 24px; font-weight: 700">个人中心</div>
        <span class="my-address">我的收货地址</span>
        <a class="new-address" href="addAddressPage">新增</a>
        <a class="edit-password" href="editPasswordPage">修改密码</a>
        <table>
            <tr>
                <th>收货人</th>
                <th>手机号码</th>
                <th>收货地址</th>
                <th>邮政编码</th>
                <th>操作</th>
            </tr>
            <c:forEach items="${addresses}" var="address">
            <tr>
                <td class="name">${address.name}</td>
                <td class="tel">${address.tel}</td>
                <td class="address-detail">${address.address}</td>
                <td class="post">${address.post}</td>
                <td class="delete" aid="${address.id}"><span>删除</span></td>
            </tr>
            </c:forEach>
            <c:if test="${empty addresses}">
            <tr>
                <td colspan="5" class="no-address">你还没有收货地址哦~快去添加吧！</td>
            </tr>
            </c:if>
        </table>
    </div>
</div>
</body>
</html>
