package com.weilong.mall.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ErrorController {
    @RequestMapping("error400")
    public String error400() {
        return "error";
    }
    @RequestMapping("error500")
    public String error500() {
        return "error";
    }
    @RequestMapping("error404")
    public String error404() {
        return "error404";
    }
}
