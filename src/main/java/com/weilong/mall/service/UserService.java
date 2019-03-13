package com.weilong.mall.service;

import com.weilong.mall.pojo.User;

import java.util.List;

public interface UserService {
    void add(User user);
    void delete(int id);
    void update(User user);
    User get(int id);
    List<User> list();
//    判断用户名是否存在
    boolean isExistUser(String username);
//    判断手机号是否存在
    boolean isExistTel(String tel);
//    通过账号密码登录
    User getName(String username, String password);
//    通过手机登录
    User getTel(String tel);
//    根据用户名查询
    List<User> searchUser(String keywordName, String keywordTel);
}
