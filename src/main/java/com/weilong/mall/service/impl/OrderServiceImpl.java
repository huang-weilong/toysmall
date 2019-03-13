package com.weilong.mall.service.impl;

import com.weilong.mall.mapper.OrderMapper;
import com.weilong.mall.pojo.*;
import com.weilong.mall.service.ColorService;
import com.weilong.mall.service.OrderItemService;
import com.weilong.mall.service.OrderService;
import com.weilong.mall.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpSession;
import java.io.*;
import java.util.List;

@Service
public class OrderServiceImpl implements OrderService{
    @Autowired
    OrderMapper orderMapper;
    @Autowired
    UserService userService;
    @Autowired
    OrderItemService orderItemService;
    @Autowired
    ColorService colorService;

    @Autowired
    private HttpSession session;

    public void add(Order order) {
        orderMapper.insert(order);
    }

    public void delete(int id) {
        orderMapper.deleteByPrimaryKey(id);
    }

    public void update(Order order) {
        orderMapper.updateByPrimaryKeySelective(order);
    }

    public Order get(int id) {
        return orderMapper.selectByPrimaryKey(id);
    }

    public List<Order> list() {
        OrderExample orderExample = new OrderExample();
        orderExample.setOrderByClause("id desc");
        List<Order> orders = orderMapper.selectByExample(orderExample);
        setUser(orders);
        return orders;
    }

    @Override
    @Transactional
    public void add(Order order, List<OrderItem> orderItems) throws IOException {
        add(order);
//        更新库存，更新订单项
        for (OrderItem orderItem : orderItems) {
            orderItem.setOid(order.getId());
            Color color = colorService.get(orderItem.getColorId());
            color.setStock(color.getStock()-orderItem.getNumber());
            orderItemService.update(orderItem);
            colorService.update(color);

//            复制商品小图到orderItem文件夹
            String src = session.getServletContext().getRealPath("images/goods_small")+"/"+orderItem.getProduct().getCoverImage().getId()+".jpg";
            String dest = session.getServletContext().getRealPath("images/orderItem")+"/"+orderItem.getId()+".jpg";
//            打开输入流
            FileInputStream fis = new FileInputStream(src);
//            打开输出流
            FileOutputStream fos = new FileOutputStream(dest);
//            读取和写入信息
            int len = 0;
            while ((len = fis.read())!= -1){
                fos.write(len);
            }
//            关闭流，先开后关，后开先关
            fos.close();
            fis.close();
        }
    }

    @Override
    public float calculateTotal(int id) {
        float total = 0;
        List<OrderItem> orderItems = orderItemService.listByOid(id);
        for (OrderItem orderItem : orderItems)
            total += orderItem.getNumber()*orderItem.getProduct().getDiscountPrice();
        return total;
    }

    @Override
    public List<Order> list(int uid, String status) {
        OrderExample orderExample = new OrderExample();
//        查找出某个用户指定状态的订单信息，不包括已删除的订单
        orderExample.createCriteria().andUidEqualTo(uid).andStatusLike("%" + status + "%").andStatusNotEqualTo("delete");
        orderExample.setOrderByClause("id desc");
        return orderMapper.selectByExample(orderExample);
    }

    //    查询某个状态的订单
    @Override
    public List<Order> list(String status) {
        OrderExample orderExample = new OrderExample();
        orderExample.createCriteria().andStatusEqualTo(status);
        orderExample.setOrderByClause("id desc");
        List<Order> orders = orderMapper.selectByExample(orderExample);
        setUser(orders);
        return orders;
    }

    @Override
    public List<Order> searchOrder(String orderNum) {
        OrderExample orderExample = new OrderExample();
        orderExample.createCriteria().andOrderNumLike("%" + orderNum + "%");
        orderExample.setOrderByClause("id desc");
        List<Order> orders = orderMapper.selectByExample(orderExample);
        setUser(orders);
        return orders;
    }

    public void setUser(List<Order> orders) {
        for (Order order : orders) {
            setUser(order);
        }
    }

    public void setUser(Order order) {
        int uid = order.getUid();
        User user = userService.get(uid);
        order.setUser(user);
    }
}
