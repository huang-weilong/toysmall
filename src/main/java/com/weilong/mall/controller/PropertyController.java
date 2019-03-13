package com.weilong.mall.controller;

import com.weilong.mall.pojo.Category;
import com.weilong.mall.pojo.Property;
import com.weilong.mall.service.CategoryService;
import com.weilong.mall.service.PropertyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("")
public class PropertyController {
    @Autowired
    CategoryService categoryService;
    @Autowired
    PropertyService propertyService;

//    增加属性
    @RequestMapping("adminAddProperty")
    public String add(Property property, HttpSession session) {
        if (session.getAttribute("admin") == null)
            return "redirect:adminLoginPage";
        propertyService.add(property);
//        返回带cid参数的客户端跳转才会转向正确分类下的属性列表
        return "redirect:adminListProperty?cid=" +property.getCid();
    }

    @RequestMapping("addProperty")
    public String addProperty(Model model, int cid, HttpSession session) {
        if (session.getAttribute("admin") == null)
            return "redirect:adminLoginPage";
        Category category = categoryService.get(cid);
        if (category == null)
            return "admin/error";
        model.addAttribute("category", category);
        return "admin/addProperty";
    }

//    删除属性
    @RequestMapping("adminDeleteProperty")
    public String delete(int id, HttpSession session) {
        if (session.getAttribute("admin") == null)
            return "redirect:adminLoginPage";
        Property property = propertyService.get(id);
        if (property == null)
            return "admin/error";
        propertyService.delete(id);
        return "redirect:adminListProperty?cid=" +property.getCid();
    }

//    编辑属性
    @RequestMapping("adminEditProperty")
    public String edit(Model model, int id, HttpSession session) {
        if (session.getAttribute("admin") == null)
            return "redirect:adminLoginPage";
        Property property = propertyService.get(id);
        if (property == null)
            return "admin/error";
        Category category = categoryService.get(property.getCid());
        property.setCategory(category);
        model.addAttribute("property", property);
        return "admin/editProperty";
    }

//    更新属性
    @RequestMapping("adminUpdateProperty")
    public String update(Property property, HttpSession session) {
        if (session.getAttribute("admin") == null)
            return "redirect:adminLoginPage";
        propertyService.update(property);
        return "redirect:adminListProperty?cid=" + property.getCid();
    }

//    查询属性列表
    @RequestMapping("adminListProperty")
    public String list(int cid, Model model, HttpSession session) {
        if (session.getAttribute("admin") == null)
            return "redirect:adminLoginPage";
        Category category = categoryService.get(cid);
        if (category == null)
            return "admin/error";
        List<Property> properties = propertyService.list(cid);
        model.addAttribute("properties", properties);
        model.addAttribute("category", category);
        return "admin/listProperty";
    }
}
