package com.weilong.mall.service;

import com.weilong.mall.pojo.Admin;

import java.util.List;

public interface AdminService {
    void add(Admin admin);
    void delete(int id);
    void update(Admin admin);
    Admin get(int id);
    List<Admin> list();
    Admin get(String username, String password);
}
