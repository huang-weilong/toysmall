package com.weilong.mall.service.impl;

import com.weilong.mall.mapper.PropertyMapper;
import com.weilong.mall.pojo.Property;
import com.weilong.mall.pojo.PropertyExample;
import com.weilong.mall.service.PropertyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PropertyServiceImpl implements PropertyService{
    @Autowired
    PropertyMapper propertyMapper;

    @Override
    public void add(Property pt) {
        propertyMapper.insert(pt);
    }

    @Override
    public void delete(int id) {
        propertyMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void update(Property pt) {
        propertyMapper.updateByPrimaryKeySelective(pt);
    }

    @Override
    public Property get(int id) {
        return propertyMapper.selectByPrimaryKey(id);
    }

    @Override
    public List<Property> list(int cid) {
//        调用辅助查询类
        PropertyExample propertyExample = new PropertyExample();
//        查询cid字段
        propertyExample.createCriteria().andCidEqualTo(cid);
        propertyExample.setOrderByClause("id desc");
        return propertyMapper.selectByExample(propertyExample);
    }
}
