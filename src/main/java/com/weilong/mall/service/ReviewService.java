package com.weilong.mall.service;

import com.weilong.mall.pojo.Review;

import java.util.List;

public interface ReviewService {
    void add(Review review);
    void delete(int id);
    void update(Review review);
    Review get(int id);
    List<Review> list(int pid);
    List<Review> listByOid(int oid);
}
