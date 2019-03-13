package com.weilong.mall.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.weilong.mall.pojo.Order;
import com.weilong.mall.service.OrderItemService;
import com.weilong.mall.service.OrderService;
import com.weilong.mall.util.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("")
public class OrderController {
    @Autowired
    OrderService orderService;
    @Autowired
    OrderItemService orderItemService;

    @RequestMapping("adminListOrder")
    public String list(Model model, Page page, HttpSession session) {
        if (session.getAttribute("admin") == null)
            return "redirect:adminLoginPage";
        page.setCount(10);
        PageHelper.offsetPage(page.getStart(), page.getCount());
        List<Order> orders = orderService.list();

        int total = (int) new PageInfo<Order>(orders).getTotal();
        page.setTotal(total);

        orderItemService.addOrderItems(orders);

        model.addAttribute("orders", orders);
        model.addAttribute("page", page);
        return "admin/listOrder";
    }

    @RequestMapping("adminOrderDelivery")
    @ResponseBody
    public String delivery(@RequestParam("oid") int oid, HttpSession session) {
        if (session.getAttribute("admin") == null)
            return "no";
        Order order = orderService.get(oid);
        if (!order.getStatus().equals("waitDelivery"))
            return "no";
        order.setDeliveryDate(new Date());
        order.setStatus(OrderService.waitConfirm);
        orderService.update(order);
        return "yes";
    }
    @RequestMapping("orderStatus")
    public String waitPayOrder(@RequestParam("status") String status, HttpSession session, Model model, Page page) {
        if (session.getAttribute("admin") == null)
            return "redirect:adminLoginPage";
        page.setCount(10);
        PageHelper.offsetPage(page.getStart(), page.getCount());
        List<Order> orders = orderService.list(status);
        int total = (int) new PageInfo<Order>(orders).getTotal();
        page.setTotal(total);
        page.setParam("&status="+status);
        orderItemService.addOrderItems(orders);
        model.addAttribute("orders", orders);
        model.addAttribute("page", page);
        model.addAttribute("status", status);
        return "admin/listOrder";
    }
    @RequestMapping("searchOrder")
    public String searchOrder(@RequestParam("keyword") String orderNum, Model model) {
        List<Order> orders = orderService.searchOrder(orderNum);
        orderItemService.addOrderItems(orders);
        model.addAttribute("orders", orders);
        model.addAttribute("keyword", orderNum);
        return "admin/listOrder";
    }
}
