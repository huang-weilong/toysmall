package com.weilong.mall.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.weilong.mall.pojo.User;
import com.weilong.mall.service.UserService;
import com.weilong.mall.util.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("")
public class UserController {
    @Autowired
    UserService userService;

    @RequestMapping("adminListUser")
    public String list(Model model, Page page, HttpSession session) {
        if (session.getAttribute("admin") == null)
            return "redirect:adminLoginPage";
        page.setCount(10);
        PageHelper.offsetPage(page.getStart(), page.getCount());
        List<User> users = userService.list();

        int total = (int) new PageInfo<User>(users).getTotal();
        page.setTotal(total);

        model.addAttribute("users", users);
        model.addAttribute("page", page);
        return "admin/listUser";
    }

    @RequestMapping("searchUser")
    public String searchUser(@RequestParam("keywordName") String keywordName, @RequestParam("keywordTel") String keywordTel, Model model) {
        List<User> users = userService.searchUser(keywordName, keywordTel);
        model.addAttribute("keywordName", keywordName);
        model.addAttribute("keywordTel", keywordTel);
        model.addAttribute("users", users);
        return "admin/listUser";
    }
}
