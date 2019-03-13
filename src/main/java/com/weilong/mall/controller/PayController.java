package com.weilong.mall.controller;

import com.weilong.mall.pojo.Order;
import com.weilong.mall.pojo.OrderItem;
import com.weilong.mall.pojo.Product;
import com.weilong.mall.pojo.User;
import com.weilong.mall.service.OrderItemService;
import com.weilong.mall.service.OrderService;
import com.weilong.mall.service.ProductService;
import com.weilong.mall.util.YeePayUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.text.DecimalFormat;
import java.util.Date;
import java.util.List;

@Controller
public class PayController {
    @Autowired
    OrderService orderService;
    @Autowired
    OrderItemService orderItemService;
    @Autowired
    ProductService productService;

    //    支付方式，提交订单后执行的
    @RequestMapping("pay")
    public String pay(HttpSession session,int oid, float total, int payWay) {
        if (session.getAttribute("user") == null)
            return "redirect:loginPage";
        Order order = orderService.get(oid);
//        保留两位小数
        DecimalFormat decimalFormat = new DecimalFormat(".00");
        String totalStr = decimalFormat.format(total);
        if (payWay == 0) {
            // 易宝支付
            YeePayUtil yeePayUtil = new YeePayUtil();
            String content = yeePayUtil.pay(order, totalStr, "CCB-NET");
            return "redirect:"+content;
        } else {
            // 支付宝支付
            session.setAttribute("totalPrice", totalStr);
            session.setAttribute("orderNum", order.getOrderNum());
            session.setAttribute("orderId", order.getId());
            return "redirect:alipayPage";
        }
    }
//    从我的订单中选择去支付
    @RequestMapping("goToPay")
    public String goToPay(Model model, int oid, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null)
            return "redirect:loginPage";

        Order order = orderService.get(oid);
//        如果用户从浏览器修改oid发起请求，判断该订单是否属于该用户，订单状态是否为未支付
        if (order.getUid().intValue() != user.getId().intValue() || !order.getStatus().equals("waitPay")) {
            return "error";
        }
        float total = orderService.calculateTotal(oid);
        List<OrderItem> orderItems = orderItemService.listByOid(oid);
        model.addAttribute("order",order);
        model.addAttribute("total", total);
        model.addAttribute("orderItems", orderItems);
        return "frontEnd/goToPay";
    }
    @RequestMapping("payFromMyOrder")
    public String payFromMyOrder(int payWay, int oid, HttpSession session) {
        if (session.getAttribute("user") == null)
            return "redirect:loginPage";
        Order order = orderService.get(oid);
        float total = orderService.calculateTotal(order.getId());
//        保留两位小数
        DecimalFormat decimalFormat = new DecimalFormat(".00");
        String totalStr = decimalFormat.format(total);
        if (payWay == 1) {
            // 支付宝支付
            session.setAttribute("totalPrice", totalStr);
            session.setAttribute("orderNum", order.getOrderNum());
            session.setAttribute("orderId", order.getId());
            return "redirect:alipayPage";
        } else {
            // 易宝支付
            YeePayUtil yeePayUtil = new YeePayUtil();
            String content = yeePayUtil.pay(order, totalStr, "CCB-NET");
            return "redirect:"+content;
        }
    }
    /**********支付宝支付***********/
//    支付宝付款页面
    @RequestMapping("alipayPage")
    public String alipayPage() {
        return "frontEnd/alipay/alipay.trade.page.pay";
    }
//    支付宝支付后同步通知结果
    @RequestMapping("alipayReturn")
    public String alipayReturn() {
        return "frontEnd/alipay/return_url";
    }
//    支付宝异步通知结果
    @RequestMapping("alipayNotify")
    public String alipayNotify() {
        return "frontEnd/alipay/notify_url";
    }
//    支付宝成功支付，修改订单状态
    @RequestMapping("alipaySuccess")
    public String alipayConfirm(Model model, HttpSession session) {
        if (session.getAttribute("user") == null)
            return "redirect:loginPage";
        int oid = (int) session.getAttribute("orderId");
        Order order = orderService.get(oid);
        order.setStatus(OrderService.waitDelivery);
        order.setPayDate(new Date());
        orderService.update(order);
        String totalPrice = (String)session.getAttribute("totalPrice");

        session.removeAttribute("totalPrice");
        session.removeAttribute("orderNum");
        session.removeAttribute("orderId");

        model.addAttribute("total", totalPrice);
        model.addAttribute("oid", order.getId());
        return "redirect:paySuccess";
    }

    /******易宝支付********/
    //    易宝支付--支付成功后修改订单状态
    @RequestMapping("yeePaySuccess")
    public String confirmPay(@RequestParam("r5_Pid") int oid,@RequestParam("r3_Amt") float total, Model model, HttpSession session) {
        if (session.getAttribute("user") == null)
            return "redirect:loginPage";
        Order order = orderService.get(oid);
        order.setStatus(OrderService.waitDelivery);
        order.setPayDate(new Date());
        orderService.update(order);
        model.addAttribute("total", total);
        model.addAttribute("oid", order.getId());
        return "redirect:paySuccess";
    }
//    支付成功
    @RequestMapping("paySuccess")
    public String paySuccess(Model model, float total, int oid, HttpSession session) {
        if (session.getAttribute("user") == null)
            return "redirect:loginPage";
        Order order = orderService.get(oid);
        List<OrderItem> orderItems = orderItemService.listByOid(oid);
//        支付成功，更新商品销量
        for (OrderItem orderItem : orderItems) {
            Product product = productService.get(orderItem.getPid());
            product.setSaleCount(product.getSaleCount()+orderItem.getNumber());
            productService.update(product);
        }
        model.addAttribute("order", order);
        model.addAttribute("total", total);
        return "frontEnd/paySuccess";
    }
}
