package com.weilong.mall.service.impl;

import com.weilong.mall.mapper.OrderItemMapper;
import com.weilong.mall.pojo.*;
import com.weilong.mall.service.ColorService;
import com.weilong.mall.service.OrderItemService;
import com.weilong.mall.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OrderItemServiceImpl implements OrderItemService{
    @Autowired
    OrderItemMapper orderItemMapper;
    @Autowired
    ProductService productService;
    @Autowired
    ColorService colorService;

    @Override
    public void add(OrderItem orderItem) {
        orderItemMapper.insert(orderItem);
    }

    @Override
    public void delete(int id) {
        orderItemMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void update(OrderItem orderItem) {
        orderItemMapper.updateByPrimaryKeySelective(orderItem);
    }

    @Override
    public OrderItem get(int id) {
        OrderItem orderItem = orderItemMapper.selectByPrimaryKey(id);
        setProduct(orderItem);
        setColor(orderItem);
        return orderItem;
    }

//    遍历订单
    @Override
    public List<OrderItem> list() {
        OrderItemExample orderItemExample = new OrderItemExample();
        orderItemExample.setOrderByClause("id desc");
        return orderItemMapper.selectByExample(orderItemExample);
    }

//    遍历每个订单
    @Override
    public void addOrderItems(List<Order> orders) {
        for (Order order : orders) {
            addOrderItems(order);
        }
    }

//    遍历订单下的多个订单项
    @Override
    public void addOrderItems(Order order) {
        OrderItemExample orderItemExample = new OrderItemExample();
//        根据订单id查出对应的订单项
        orderItemExample.createCriteria().andOidEqualTo(order.getId());
        orderItemExample.setOrderByClause("id desc");
        List<OrderItem> orderItems = orderItemMapper.selectByExample(orderItemExample);
//        为订单项设置产品属性
        setProduct(orderItems);
        setColor(orderItems);

//        计算订单总金额和总数量
        float total = 0;
        int totalNum = 0;
        for (OrderItem orderItem : orderItems) {
            total += orderItem.getNumber() * orderItem.getProduct().getDiscountPrice();
            totalNum += orderItem.getNumber();
        }
        order.setTotal(total);
        order.setTotalNum(totalNum);
//        把订单项设置到订单的orderItems属性上
        order.setOrderItems(orderItems);
    }

    @Override
    public List<OrderItem> listByUser(int uid) {
        OrderItemExample orderItemExample = new OrderItemExample();
//        查出该用户还未生成订单（oid为空）的购物信息，即在购物车内的商品
        orderItemExample.createCriteria().andUidEqualTo(uid).andOidIsNull();
        List<OrderItem> orderItems = orderItemMapper.selectByExample(orderItemExample);
        setProduct(orderItems);
        setColor(orderItems);
        return orderItems;
    }

    @Override
    public List<OrderItem> listByOid(int oid) {
        OrderItemExample orderItemExample = new OrderItemExample();
//        找出同一个订单下的所有订单项
        orderItemExample.createCriteria().andOidEqualTo(oid);
        List<OrderItem> orderItems = orderItemMapper.selectByExample(orderItemExample);
        setProduct(orderItems);
        setColor(orderItems);
        return orderItems;
    }

    public void setProduct(List<OrderItem> orderItems){
        for (OrderItem orderItem: orderItems) {
            setProduct(orderItem);
        }
    }

    private void setProduct(OrderItem orderItem) {
        Product product = productService.get(orderItem.getPid());
        orderItem.setProduct(product);
    }

    public void setColor(List<OrderItem> orderItems){
        for (OrderItem orderItem: orderItems) {
            setColor(orderItem);
        }
    }

    private void setColor(OrderItem orderItem) {
        Color color = colorService.get(orderItem.getColorId());
        orderItem.setColor(color);
    }
}
