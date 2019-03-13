package com.weilong.mall.service;

import com.weilong.mall.pojo.Category;

import java.util.List;

public interface CategoryService {
    void add(Category category);
    void delete(int id);
    void update(Category category);
    Category get(int id);
    List<Category> list();
//    后台查找分类使用
    List<Category> searchCategory(String keyword);
}
