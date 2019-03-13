package com.weilong.mall.service.impl;

import com.weilong.mall.mapper.ReviewMapper;
import com.weilong.mall.pojo.OrderItem;
import com.weilong.mall.pojo.Review;
import com.weilong.mall.pojo.ReviewExample;
import com.weilong.mall.pojo.User;
import com.weilong.mall.service.OrderItemService;
import com.weilong.mall.service.ReviewService;
import com.weilong.mall.service.UserService;
import org.aspectj.weaver.ast.Or;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ReviewServiceImpl implements ReviewService {
    @Autowired
    ReviewMapper reviewMapper;
    @Autowired
    UserService userService;
    @Autowired
    OrderItemService orderItemService;

    @Override
    public void add(Review review) {
        reviewMapper.insert(review);
    }

    @Override
    public void delete(int id) {
        reviewMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void update(Review review) {
        reviewMapper.updateByPrimaryKeySelective(review);
    }

    @Override
    public Review get(int id) {
        return reviewMapper.selectByPrimaryKey(id);
    }

    @Override
    public List<Review> list(int pid) {
        ReviewExample reviewExample = new ReviewExample();
        reviewExample.createCriteria().andPidEqualTo(pid);
        reviewExample.setOrderByClause("id desc");

        List<Review> reviews = reviewMapper.selectByExample(reviewExample);
        setUser(reviews);
        setOrderItem(reviews);
        return reviews;
    }

    @Override
    public List<Review> listByOid(int oid) {
        ReviewExample reviewExample = new ReviewExample();
        reviewExample.createCriteria().andOidEqualTo(oid);
        return reviewMapper.selectByExample(reviewExample);
    }

    public void setUser(List<Review> reviews) {
        for (Review review : reviews) {
            setUser(review);
        }
    }

    public void setUser(Review review) {
        int uid = review.getUid();
        User user = userService.get(uid);
        review.setUser(user);
    }

    public void setOrderItem(List<Review> reviews) {
        for (Review review : reviews) {
            setOrderItem(review);
        }
    }

    public void setOrderItem(Review review) {
        int oiid = review.getOiid();
        OrderItem orderItem = orderItemService.get(oiid);
        review.setOrderItem(orderItem);
    }
}
