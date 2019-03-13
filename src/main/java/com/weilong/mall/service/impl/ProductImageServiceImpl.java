package com.weilong.mall.service.impl;

import com.weilong.mall.mapper.ProductImageMapper;
import com.weilong.mall.pojo.ProductImage;
import com.weilong.mall.pojo.ProductImageExample;
import com.weilong.mall.service.ProductImageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProductImageServiceImpl implements ProductImageService{
    @Autowired
    ProductImageMapper productImageMapper;

//    增加图片
    public void add(ProductImage productImage) {
        productImageMapper.insert(productImage);
    }

//    删除图片
    public void delete(int id) {
        productImageMapper.deleteByPrimaryKey(id);
    }

//    获取图片id
    public ProductImage get(int id) {
        return productImageMapper.selectByPrimaryKey(id);
    }

//    更新图片信息
    public void update(ProductImage productImage) {
        productImageMapper.updateByPrimaryKeySelective(productImage);
    }

//    图片列表
    public List<ProductImage> list(int pid, String type) {
        ProductImageExample productImageExample = new ProductImageExample();
//        同时匹配pid和type
        productImageExample.createCriteria().andPidEqualTo(pid).andTypeEqualTo(type);
        productImageExample.setOrderByClause("id asc");
        return productImageMapper.selectByExample(productImageExample);
    }
}
