<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/2/3
  Time: 14:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <title>编辑商品属性值</title>
    <link rel="shortcut icon" href="images/frontEnd/long.ico">
    <link rel="stylesheet" href="css/bootstrap-3.3.7/css/bootstrap.css"/>
    <link rel="stylesheet" href="css/admin/admin.css"/>
    <script src="js/jquery-3.3.1/jquery-3.3.1.min.js"></script>
    <script>
        $(function() {
            $(".product-son").slideDown();
            $(".propertyValue").keyup(function(){
                var value = $(this).val();
                var page = "adminUpdatePropertyValue";
                var pvid = $(this).attr("pvid");
                var border = $(this);
                // if (value.length === 0){
                //     alert("属性值不能为空，请重新输入！");
                //     return false;
                // }
                $.post(
                    page,
                    {"ptValue": value,"id": pvid},
                    function(result){
                        if(result === "yes")
                            border.css("border","1px solid green");
                        else
                            border.css("border","1px solid red");
                    }
                );
            });
        });
    </script>
</head>
<body>
<%@include file="common/navigation.jsp"%>
<div class="wrap">
    <div class="title">属性值信息修改</div>
    <div class="tip">请直接在输入框内输入属性值</div>
    <div class="back"><a href="adminListProduct?cid=${product.cid}">返回</a></div>
    <div class="value-box">
        <table class="table table-condensed table-hover">
        <c:forEach items="${propertyValues}" var="pvs">
            <tr>
                <td style="text-align: right">${pvs.property.name}</td>
                <td><input type="text" class="propertyValue" pvid="${pvs.id}" value="${pvs.ptValue}"/></td>
            </tr>
        </c:forEach>
        </table>
    </div>
</div>
</body>
</html>
