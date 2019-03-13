package com.weilong.mall.service;

import com.weilong.mall.pojo.Property;

import java.util.List;

public interface PropertyService {
    void add(Property pt);
    void delete(int id);
    void update(Property pt);
    Property get(int id);
    List<Property> list(int cid);
}
