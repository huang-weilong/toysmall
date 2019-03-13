package com.weilong.mall.service.impl;

import com.weilong.mall.mapper.PropertyValueMapper;
import com.weilong.mall.pojo.Product;
import com.weilong.mall.pojo.Property;
import com.weilong.mall.pojo.PropertyValue;
import com.weilong.mall.pojo.PropertyValueExample;
import com.weilong.mall.service.PropertyService;
import com.weilong.mall.service.PropertyValueService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PropertyValueServiceImpl implements PropertyValueService{
    @Autowired
    PropertyValueMapper propertyValueMapper;
    @Autowired
    PropertyService propertyService;

    public void init(Product product) {
        List<Property> properties = propertyService.list(product.getCid());
        for (Property property : properties) {
            PropertyValue propertyValue = get(property.getId(), product.getId());
            if (propertyValue == null) {
                propertyValue = new PropertyValue();
                propertyValue.setPtid(property.getId());
                propertyValue.setPid(product.getId());
                propertyValueMapper.insert(propertyValue);
            }
        }
    }

    public void update(PropertyValue propertyValue) {
        propertyValueMapper.updateByPrimaryKeySelective(propertyValue);
    }

    public PropertyValue get(int ptid, int pid) {
        PropertyValueExample propertyValueExample = new PropertyValueExample();
        propertyValueExample.createCriteria().andPtidEqualTo(ptid).andPidEqualTo(pid);
        List<PropertyValue> propertyValues = propertyValueMapper.selectByExample(propertyValueExample);
        if (propertyValues.isEmpty())
            return null;
        return propertyValues.get(0);
    }

    public List<PropertyValue> list(int pid) {
        PropertyValueExample propertyValueExample = new PropertyValueExample();
        propertyValueExample.createCriteria().andPidEqualTo(pid);
        List<PropertyValue> propertyValues = propertyValueMapper.selectByExample(propertyValueExample);
        for (PropertyValue propertyValue : propertyValues) {
            Property property = propertyService.get(propertyValue.getPtid());
            propertyValue.setProperty(property);
        }
        return propertyValues;
    }
}
