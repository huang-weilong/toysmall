package com.weilong.mall.service.impl;

import com.weilong.mall.mapper.ProductMapper;
import com.weilong.mall.pojo.*;
import com.weilong.mall.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProductServiceImpl implements ProductService{
    @Autowired
    ProductMapper productMapper;
    @Autowired
    CategoryService categoryService;
    @Autowired
    ProductImageService productImageService;
    @Autowired
    OrderItemService orderItemService;
    @Autowired
    ReviewService reviewService;

//    增加产品
    @Override
    public void add(Product product) {
        productMapper.insert(product);
    }

//    删除产品
    @Override
    public void delete(int id) {
        productMapper.deleteByPrimaryKey(id);
    }

//    获取产品id
    @Override
    public Product get(int id) {
        Product product = productMapper.selectByPrimaryKey(id);
        setCoverImage(product);
        setCategory(product);
        return product;
    }

//    更新产品信息
    @Override
    public void update(Product product) {
        productMapper.updateByPrimaryKeySelective(product);
    }

//    指定分类下的商品列表
    @Override
    public List<Product> list(int cid) {
        ProductExample productExample = new ProductExample();
//        display为3的商品为删除状态。
        productExample.createCriteria().andCidEqualTo(cid).andDisplayNotEqualTo(3);
        productExample.setOrderByClause("id desc");
        List<Product> result = productMapper.selectByExample(productExample);
        setCoverImage(result);
        setCategory(result);
        return result;
    }

    @Override
    public List<Product> list(int cid, int flag, String sort) {
        ProductExample productExample = new ProductExample();
//        前端显示display状态为1的商品
        productExample.createCriteria().andCidEqualTo(cid).andDisplayEqualTo(flag);
        if (flag == 3)
            productExample.setOrderByClause("id desc");
        if (sort != null) {
            switch (sort){
                case "sortByPriceDesc": productExample.setOrderByClause("discountPrice desc"); break;
                case "sortByPriceAsc": productExample.setOrderByClause("discountPrice asc"); break;
                case "sortBySale": productExample.setOrderByClause("saleCount desc"); break;
                case "sortByReview": productExample.setOrderByClause("reviewCount desc"); break;
                case "sortByComposite": productExample.setOrderByClause("saleCount+reviewCount desc"); break;
            }
        }
        List<Product> result = productMapper.selectByExample(productExample);
        setCoverImage(result);
        setCategory(result);
        return result;
    }

    @Override
    public void setCoverImage(Product product) {
        List<ProductImage> productImages = productImageService.list(product.getId(), productImageService.type_goods);
        if (!productImages.isEmpty()) {
            ProductImage productImage = productImages.get(0);
            product.setCoverImage(productImage);
        }
    }

    @Override
    public List<Product> search(String keyword, String sort) {
        ProductExample productExample = new ProductExample();
//        通过关键字模糊查询
        productExample.createCriteria().andNameLike("%" + keyword + "%").andDisplayEqualTo(1);
        switch (sort){
            case "sortByPriceDesc":productExample.setOrderByClause("discountPrice desc"); break;
            case "sortByPriceAsc":productExample.setOrderByClause("discountPrice asc"); break;
            case "sortBySale":productExample.setOrderByClause("saleCount desc"); break;
            case "sortByReview":productExample.setOrderByClause("reviewCount desc"); break;
            default: productExample.setOrderByClause("saleCount+reviewCount desc"); break;
        }
        List<Product> result = productMapper.selectByExample(productExample);
        setCoverImage(result);
        setCategory(result);
        return result;
    }

    @Override
    public List<Product> searchProduct(int cid, String keyword) {
        ProductExample productExample = new ProductExample();
        productExample.createCriteria().andCidEqualTo(cid).andNameLike("%" + keyword + "%");
        productExample.setOrderByClause("id desc");
        List<Product> products = productMapper.selectByExample(productExample);
        setCoverImage(products);
        setCategory(products);
        return products;
    }

    public void setCoverImage(List<Product> products) {
        for (Product product : products) {
            setCoverImage(product);
        }
    }

    public void setCategory(List<Product> products){
        for (Product product : products)
            setCategory(product);
    }

//    给产品设置对应的分类
    public void setCategory(Product product){
        int cid = product.getCid();
        Category category = categoryService.get(cid);
        product.setCategory(category);
    }
}
