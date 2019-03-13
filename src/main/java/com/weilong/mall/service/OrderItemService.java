package com.weilong.mall.service;

import com.weilong.mall.pojo.Order;
import com.weilong.mall.pojo.OrderItem;
import org.aspectj.weaver.ast.Or;

import java.util.List;

public interface OrderItemService {
    void add(OrderItem orderItem);
    void delete(int id);
    void update(OrderItem orderItem);
    OrderItem get(int id);
    List<OrderItem> list();
    void addOrderItems(List<Order> orders);
    void addOrderItems(Order order);
    List<OrderItem> listByUser(int uid);
    List<OrderItem> listByOid(int oid);
}
