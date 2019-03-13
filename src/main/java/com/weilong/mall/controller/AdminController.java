package com.weilong.mall.controller;

import com.weilong.mall.pojo.Admin;
import com.weilong.mall.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("")
public class AdminController {
    @Autowired
    AdminService adminService;

//    管理员登录页面
    @RequestMapping("adminLoginPage")
    public String adminLoginPage() {
        return "admin/adminLogin";
    }
//    登录首页
    @RequestMapping("adminIndex")
    public String adminIndex(HttpSession session) {
        if (session.getAttribute("admin") == null)
            return "redirect:adminLoginPage";
        return "admin/adminIndex";
    }
//    登录
    @RequestMapping("adminLogin")
    public String adminLogin(@RequestParam("username") String username, @RequestParam("password") String password, Model model, HttpSession session) {
        Admin admin = adminService.get(username, password);
        if (admin == null) {
            model.addAttribute("nameOrPwdError", "账号或密码错误");
            return "admin/adminLogin";
        }
        session.setAttribute("admin", admin);
        return "redirect:adminIndex";
    }
//    注销
    @RequestMapping("adminLogout")
    public String adminLogout(HttpSession session) {
        session.removeAttribute("admin");
        return "redirect:adminLoginPage";
    }
}
