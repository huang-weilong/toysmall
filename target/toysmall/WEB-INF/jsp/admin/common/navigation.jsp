<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/1/24
  Time: 21:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>
    .menu{
        position: fixed;
        float: left;
        width: 200px;
        height: 100%;
        list-style: none;
        color: #ffffff;
        text-align: center;
        background-color: #333333;
    }
    .menu span {
        display: inline-block;
        padding-top: 10px;
        font-size: 14px;
    }
    .menu .logout {
        font-size: 14px;
    }
    .menu img {
        margin: 15px 0;
        width: 100px;
    }
    .menu li {
        font-size: 18px;
        text-align: center;
        padding: 10px 0;
        cursor: pointer;
    }
    .menu li:hover {
        background-color: #444444;
    }
    .menu .category-son,
    .menu .product-son{
        display: none;
        padding-left: 10px;
        font-size: 16px;
    }
    .menu a{
        color: #ffffff;
        text-decoration: none;
    }
</style>
<script>
    $(function(){
        $(".category").click(function(){
            $(".category-son").slideToggle();
            $(".product-son").slideUp();
        });
        $(".product").click(function(){
            $(".product-son").slideToggle();
            $(".category-son").slideUp();
        });
    })
</script>
<ul class="menu">
    <span>你好，${admin.username}</span>
    <a href="adminLogout"><li class="logout">退出</li></a>
    <img src="images/frontEnd/long.jpg" alt="">
    <a href="adminIndex"><li>后台首页</li></a>
    <li class="category">分类管理</li>
    <a href="adminListCategory"><li class="category-son">分类列表</li></a>
    <a href="addCategory"><li class="category-son">添加分类</li></a>
    <li class="product">商品管理</li>
    <a href="adminProductIndex"><li class="product-son">商品列表</li></a>
    <a href="addProductIndex"><li class="product-son">添加商品</li></a>
    <a href="adminListUser"><li>用户管理</li></a>
    <a href="adminListOrder"><li>订单管理</li></a>
</ul>
