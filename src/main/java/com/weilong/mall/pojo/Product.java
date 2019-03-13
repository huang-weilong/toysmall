package com.weilong.mall.pojo;

import java.util.Date;
import java.util.List;

public class Product {
    private Integer id;

    private String name;

    private String title;

    private Float originalPrice;

    private Float discountPrice;

    private Date createDate;

    private Integer cid;

    private Integer display;

    private Integer saleCount;

    private Integer reviewCount;
    //    非数据库字段
    private Category category;

    private ProductImage coverImage;
    //    商品图片集合
    private List<ProductImage> productGoodImages;
    //    商品详情图片集合
    private List<ProductImage> productDetailImages;

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public ProductImage getCoverImage() {
        return coverImage;
    }

    public void setCoverImage(ProductImage coverImage) {
        this.coverImage = coverImage;
    }

    public List<ProductImage> getProductGoodImages() {
        return productGoodImages;
    }

    public void setProductGoodImages(List<ProductImage> productGoodImages) {
        this.productGoodImages = productGoodImages;
    }

    public List<ProductImage> getProductDetailImages() {
        return productDetailImages;
    }

    public void setProductDetailImages(List<ProductImage> productDetailImages) {
        this.productDetailImages = productDetailImages;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title == null ? null : title.trim();
    }

    public Float getOriginalPrice() {
        return originalPrice;
    }

    public void setOriginalPrice(Float originalPrice) {
        this.originalPrice = originalPrice;
    }

    public Float getDiscountPrice() {
        return discountPrice;
    }

    public void setDiscountPrice(Float discountPrice) {
        this.discountPrice = discountPrice;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public Integer getCid() {
        return cid;
    }

    public void setCid(Integer cid) {
        this.cid = cid;
    }

    public Integer getDisplay() {
        return display;
    }

    public void setDisplay(Integer display) {
        this.display = display;
    }

    public Integer getSaleCount() {
        return saleCount;
    }

    public void setSaleCount(Integer saleCount) {
        this.saleCount = saleCount;
    }

    public Integer getReviewCount() {
        return reviewCount;
    }

    public void setReviewCount(Integer reviewCount) {
        this.reviewCount = reviewCount;
    }
}