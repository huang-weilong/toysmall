package com.weilong.mall.service.impl;

import com.weilong.mall.mapper.CategoryMapper;
import com.weilong.mall.pojo.Category;
import com.weilong.mall.pojo.CategoryExample;
import com.weilong.mall.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CategoryServiceImpl implements CategoryService{
    @Autowired
    CategoryMapper categoryMapper;

    public List<Category> list() {
        CategoryExample categoryExample = new CategoryExample();
        categoryExample.setOrderByClause("id asc");
        return categoryMapper.selectByExample(categoryExample);
    }

    @Override
    public List<Category> searchCategory(String keyword) {
        CategoryExample categoryExample = new CategoryExample();
        categoryExample.createCriteria().andNameLike("%" + keyword + "%");
        categoryExample.setOrderByClause("id desc");
        return categoryMapper.selectByExample(categoryExample);
    }

    public void add(Category category) {
        categoryMapper.insert(category);
    }

    public void delete(int id) {
        categoryMapper.deleteByPrimaryKey(id);
    }

    public Category get(int id) {
        return categoryMapper.selectByPrimaryKey(id);
    }

    public void update(Category category) {
        categoryMapper.updateByPrimaryKeySelective(category);
    }
}
