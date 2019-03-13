package com.weilong.mall.service.impl;

import com.weilong.mall.mapper.AdminMapper;
import com.weilong.mall.pojo.Admin;
import com.weilong.mall.pojo.AdminExample;
import com.weilong.mall.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AdminServiceImpl implements AdminService{
    @Autowired
    AdminMapper adminMapper;

    @Override
    public void add(Admin admin) {
        adminMapper.insert(admin);
    }

    @Override
    public void delete(int id) {
        adminMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void update(Admin admin) {
        adminMapper.updateByPrimaryKey(admin);
    }

    @Override
    public Admin get(int id) {
        return adminMapper.selectByPrimaryKey(id);
    }

    @Override
    public List<Admin> list() {
        AdminExample adminExample = new AdminExample();
        adminExample.setOrderByClause("id desc");
        return adminMapper.selectByExample(adminExample);
    }

    @Override
    public Admin get(String username, String password) {
        AdminExample adminExample = new AdminExample();
        adminExample.createCriteria().andUsernameEqualTo(username).andPasswordEqualTo(password);
        List<Admin> admins = adminMapper.selectByExample(adminExample);
        if (admins.isEmpty())
            return null;
        return admins.get(0);
    }
}
