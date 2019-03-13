package com.weilong.mall.controller;

import com.weilong.mall.pojo.Product;
import com.weilong.mall.pojo.PropertyValue;
import com.weilong.mall.service.ProductService;
import com.weilong.mall.service.PropertyValueService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("")
public class PropertyValueController {
    @Autowired
    PropertyValueService propertyValueService;
    @Autowired
    ProductService productService;

    @RequestMapping("adminEditPropertyValue")
    public String edit(Model model, int pid, HttpSession session) {
        if (session.getAttribute("admin") == null)
            return "redirect:adminLoginPage";
        Product product = productService.get(pid);
        if (product == null)
            return "admin/error";
//        初始化属性值
        propertyValueService.init(product);
//        根据产品id获取该产品的属性值集合
        List<PropertyValue> propertyValues = propertyValueService.list(product.getId());

        model.addAttribute("product", product);
        model.addAttribute("propertyValues", propertyValues);
        return "admin/editPropertyValue";
    }

    @RequestMapping("adminUpdatePropertyValue")
    @ResponseBody
    public String update(PropertyValue propertyValue) {
        propertyValueService.update(propertyValue);
        return "yes";
    }
}
