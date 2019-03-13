package com.weilong.mall.service;

import com.weilong.mall.pojo.Product;
import com.weilong.mall.pojo.PropertyValue;

import java.util.List;

public interface PropertyValueService {
    void init(Product product);
    void update(PropertyValue propertyValue);
    PropertyValue get(int ptid, int pid);
    List<PropertyValue> list(int pid);
}
