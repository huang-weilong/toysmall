package com.weilong.mall.service;

import com.sun.tools.corba.se.idl.constExpr.Or;
import com.weilong.mall.pojo.Order;
import com.weilong.mall.pojo.OrderItem;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.List;

public interface OrderService {
    String waitPay = "waitPay";
    String waitDelivery = "waitDelivery";
    String waitConfirm = "waitConfirm";
    String waitReview = "waitReview";
    String finish = "finish";
    String delete = "delete";

    void add(Order order);
    void delete(int id);
    void update(Order order);
    Order get(int id);
    List<Order> list();
    void add(Order order, List<OrderItem> orderItems) throws IOException;
    float calculateTotal(int id);
//    某个用户的订单信息（用户我的订单使用）
    List<Order> list(int uid, String status);
//    查询某个状态的订单
    List<Order> list(String status);
    List<Order> searchOrder(String orderNum);
}
