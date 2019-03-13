package com.weilong.mall.controller;

import com.aliyuncs.exceptions.ClientException;
import com.weilong.mall.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpSession;

import static com.weilong.mall.util.SendVerificationCode.sendVerificationCode;

@Controller
@RequestMapping("")
public class SendMessageController extends HttpServlet{
    @Autowired
    UserService userService;

//    注册验证码发送
    @RequestMapping("sendRegisterCode")
    @ResponseBody
    public String sendMessage(@RequestParam("tel") String tel, HttpSession session) {
//        判断号码是否已经注册
        boolean exist = userService.isExistTel(tel);
        if (exist) {
            System.out.println("该号码已被注册！");
            return "no";
        } else {
            try {
                //        生成六位随机数
                int a = (int)((Math.random()*9+1)*100000);
                String regCode = String.valueOf(a);
                session.setAttribute("regCode", regCode);
                //flag为0表示发送注册验证码
                int flag = 0;
//                将该号码先保存，防止发送完验证码后将手机号修改
                session.setAttribute("regTel",tel);
                sendVerificationCode(regCode, tel, flag);
            }catch (ClientException e){
                e.printStackTrace();
            }
        }
        return "yes";
    }
//    登录验证码发送
    @RequestMapping("sendLoginCode")
    @ResponseBody
    public String sendLoginCode(@RequestParam("tel") String tel, HttpSession session) {
//        判断号码是否已经注册
        boolean exist = userService.isExistTel(tel);
        if (exist) {
            try {
                //        生成六位随机数
                int a = (int)((Math.random()*9+1)*100000);
                String loginCode = String.valueOf(a);
                session.setAttribute("loginCode", loginCode);
                //flag为1表示发送登录验证码
                int flag = 1;
//                将该号码先保存，防止发送完验证码后将手机号修改
                session.setAttribute("loginTel", tel);
                sendVerificationCode(loginCode, tel, flag);
            }catch (ClientException e){
                e.printStackTrace();
            }
        } else {
            System.out.println("该号码未注册！");
            return "no";
        }
        return "yes";
    }
}
