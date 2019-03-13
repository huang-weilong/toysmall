<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/3/13
  Time: 23:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>支付宝支付</title>
</head>
<body>
<form action="alipayPage" name="alipayment" method="post" target="_blank">
    <table>
        <tr>
            <td>商户订单号</td>
            <td><input type="text" id="WIDout_trade_no" name="WIDout_trade_no"></td>
        </tr>
        <tr>
            <td>订单名称</td>
            <td><input type="text" id="WIDsubject" name="WIDsubject"></td>
        </tr>
        <tr>
            <td>付款金额</td>
            <td><input type="text" id="WIDtotal_amount" name="WIDtotal_amount"></td>
        </tr>
        <tr>
            <td>商品描述</td>
            <td><input type="text" id="WIDbody" name="WIDbody"></td>
        </tr>
        <tr>
            <td><input type="submit" value="去付款"></td>
        </tr>
    </table>
</form>
<script language="javascript">
    var tabs = document.getElementsByName('tab');
    var contents = document.getElementsByName('divcontent');

    (function changeTab(tab) {
        for(var i = 0, len = tabs.length; i < len; i++) {
            tabs[i].onmouseover = showTab;
        }
    })();

    function showTab() {
        for(var i = 0, len = tabs.length; i < len; i++) {
            if(tabs[i] === this) {
                tabs[i].className = 'selected';
                contents[i].className = 'show';
            } else {
                tabs[i].className = '';
                contents[i].className = 'tab-content';
            }
        }
    }

    function GetDateNow() {
        var vNow = new Date();
        var sNow = "";
        sNow += String(vNow.getFullYear());
        sNow += String(vNow.getMonth() + 1);
        sNow += String(vNow.getDate());
        sNow += String(vNow.getHours());
        sNow += String(vNow.getMinutes());
        sNow += String(vNow.getSeconds());
        sNow += String(vNow.getMilliseconds());
        document.getElementById("WIDout_trade_no").value =  sNow;
        document.getElementById("WIDsubject").value = "测试";
        document.getElementById("WIDtotal_amount").value = <%=session.getAttribute("totalPrice") %>;
    }
    GetDateNow();
</script>
</body>
</html>
