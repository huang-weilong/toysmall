package com.weilong.mall.service;

import com.weilong.mall.pojo.ProductImage;

import java.util.List;

public interface ProductImageService {
//    产品图片类型
    String type_goods = "goods";
//    详情页图片类型
    String type_detail = "detail";

    void add(ProductImage productImage);
    void delete(int id);
    ProductImage get(int id);
    void update(ProductImage productImage);
    List<ProductImage> list(int pid, String type);
}
