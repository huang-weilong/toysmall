<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/2/19
  Time: 22:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>注册成功</title>
    <link rel="shortcut icon" href="images/frontEnd/long.ico">
    <script src="js/jquery-3.3.1/jquery-3.3.1.min.js"></script>
    <style>
        .result-wrap {
            margin: 100px auto 0;
            width: 360px;
        }
        .result-wrap .result-inner .logo{
            position: relative;
        }
        .result-wrap .result-inner .bg {
            position: absolute;
            display: inline-block;
            width: 80px;
            height: 80px;
            background-color: #3bbb5b;
            border-radius: 50%;
        }
        .result-wrap .result-inner .hook {
            position: absolute;
            display: inline-block;
            left: 26px;
            top: 10px;
            width: 20px;
            height: 40px;
            border: 6px solid rgb(255, 255, 255);
            border-top: none;
            border-left: none;
            transform: rotate(45deg);
        }
        .result-wrap .result-inner .text {
            margin-left: 100px;
        }
        .result-wrap .result-inner .text .result-text{
            margin-bottom: 10px;
            font-size: 28px;
        }
        .result-wrap .result-inner .text a {
            color: #3e9fc3;
        }
        .result-wrap .result-inner .line {
            margin-top: 30px;
            border-top: 3px solid #cecece;
        }
    </style>
    <script>
        $(function () {
            var times = 10;
            var timer = null;
            timer = setInterval(function() {
                times--;
                if(times == 0) {
                    $("#time").html("正在跳转");
                    window.location.href = "index";
                    clearInterval(timer);
                } else {
                    $("#time").html(times+"秒后跳转至商城首页");
                }
            }, 1000);
        });
    </script>
</head>
<body>
<div class="result-wrap">
    <div class="result-inner">
        <div class="logo">
            <span class="bg"></span>
            <span class="hook"></span>
        </div>
        <div class="text">
            <div class="result-text">恭喜你，注册成功！</div>
            <div class="jump"><span id="time">10秒后跳转至商城首页</span> <a href="index">立即跳转</a></div>
        </div>
        <div class="line"></div>
    </div>
</div>
</body>
</html>
