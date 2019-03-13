package com.weilong.mall.controller;

import com.weilong.mall.pojo.Color;
import com.weilong.mall.pojo.Product;
import com.weilong.mall.service.ColorService;
import com.weilong.mall.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("")
public class ColorController {
    @Autowired
    ColorService colorService;
    @Autowired
    ProductService productService;

//    增加颜色分类
    @RequestMapping("adminAddColor")
    public String add(Color color, HttpSession session) {
        if (session.getAttribute("admin") == null)
            return "redirect:adminLoginPage";
        colorService.add(color);
//        返回带pid参数的客户端跳转才会转向正确产品下的颜色分类
        return "redirect:adminListColor?pid=" + color.getPid();
    }

    @RequestMapping("adminDeleteColor")
    public String delete(@RequestParam("id") int id, HttpSession session) {
        if (session.getAttribute("admin") == null)
            return "redirect:adminLoginPage";
        Color color = colorService.get(id);
        if (color == null)
            return "admin/error";
        colorService.delete(id);
        return "redirect:adminListColor?pid=" + color.getPid();
    }

    @RequestMapping("adminEditColor")
    public String edit(Model model, int id, HttpSession session) {
        if (session.getAttribute("admin") == null)
            return "redirect:adminLoginPage";
        Color color = colorService.get(id);
        if (color == null)
            return "admin/error";
        Product product = productService.get(color.getPid());
        color.setProduct(product);
        model.addAttribute("color", color);
        return "admin/editColor";
    }

    @RequestMapping("adminUpdateColor")
    public String update(Color color, HttpSession session) {
        if (session.getAttribute("admin") == null)
            return "redirect:adminLoginPage";
        colorService.update(color);
        return "redirect:adminListColor?pid=" + color.getPid();
    }

    @RequestMapping("adminListColor")
    public String list(@RequestParam("pid") String id, Model model, HttpSession session) {
        if (session.getAttribute("admin") == null)
            return "redirect:adminLoginPage";
        int pid;
        Product product;
        try {
            pid = Integer.parseInt(id);
            product = productService.get(pid);
        } catch (Exception e) {
            e.printStackTrace();
            return "admin/error";
        }
        List<Color> colors = colorService.list(pid);
        model.addAttribute("colors", colors);
        model.addAttribute("product", product);
        return "admin/listColor";
    }
}
