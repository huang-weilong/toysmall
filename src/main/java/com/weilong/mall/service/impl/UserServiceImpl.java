package com.weilong.mall.service.impl;

import com.weilong.mall.mapper.UserMapper;
import com.weilong.mall.pojo.User;
import com.weilong.mall.pojo.UserExample;
import com.weilong.mall.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImpl implements UserService{
    @Autowired
    UserMapper userMapper;

    public void add(User user) {
        userMapper.insert(user);
    }

    public void delete(int id) {
        userMapper.deleteByPrimaryKey(id);
    }

    public void update(User user) {
        userMapper.updateByPrimaryKeySelective(user);
    }

    public User get(int id) {
        return userMapper.selectByPrimaryKey(id);
    }

    public List<User> list() {
        UserExample userExample = new UserExample();
        userExample.setOrderByClause("id desc");
        return userMapper.selectByExample(userExample);
    }

    @Override
    public boolean isExistUser(String username) {
        UserExample userExample = new UserExample();
        userExample.createCriteria().andUsernameEqualTo(username);
        List<User> result = userMapper.selectByExample(userExample);
        return !result.isEmpty();
    }

    @Override
    public boolean isExistTel(String tel) {
        UserExample userExample = new UserExample();
        userExample.createCriteria().andTelEqualTo(tel);
        List<User> result = userMapper.selectByExample(userExample);
        if (!result.isEmpty())
            return true;
        return false;
    }

    @Override
    public User getName(String username, String password) {
        UserExample userExample = new UserExample();
        userExample.createCriteria().andUsernameEqualTo(username).andPasswordEqualTo(password);
        List<User> result = userMapper.selectByExample(userExample);
        if (result.isEmpty())
            return null;
        return result.get(0);
    }

    @Override
    public User getTel(String tel) {
        UserExample userExample = new UserExample();
        userExample.createCriteria().andTelEqualTo(tel);
        List<User> result = userMapper.selectByExample(userExample);
        if (result.isEmpty())
            return null;
        return result.get(0);
    }

    @Override
    public List<User> searchUser(String keywordName, String keywordTel) {
        UserExample userExample = new UserExample();
        userExample.createCriteria().andUsernameLike("%" + keywordName + "%").andTelLike("%" + keywordTel + "%");
        return userMapper.selectByExample(userExample);
    }
}
