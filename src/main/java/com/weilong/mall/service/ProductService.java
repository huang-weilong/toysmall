package com.weilong.mall.service;

import com.weilong.mall.pojo.Product;

import java.util.List;

public interface ProductService {
    void add(Product product);
    void delete(int id);
    Product get(int id);
    void update(Product product);
//    某分类下的商品，后台用
    List<Product> list(int cid);
//    某分类下状态为上架的商品，前台用，后台删除商品用
    List<Product> list(int cid, int flag, String sort);

    void setCoverImage(Product product);
//    前台用户搜索商品
    List<Product> search(String keyword, String sort);
//    管理员查询某分类下的商品
    List<Product> searchProduct(int cid, String keyword);
}
