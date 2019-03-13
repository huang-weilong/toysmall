package com.weilong.mall.service.impl;

import com.weilong.mall.mapper.AddressMapper;
import com.weilong.mall.pojo.Address;
import com.weilong.mall.pojo.AddressExample;
import com.weilong.mall.service.AddressService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AddressServiceImpl implements AddressService{
    @Autowired
    AddressMapper addressMapper;

    @Override
    public void add(Address address) {
        addressMapper.insert(address);
    }

    @Override
    public void delete(int id) {
        addressMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void update(Address address) {
        addressMapper.updateByPrimaryKeySelective(address);
    }

    @Override
    public Address get(int id) {
        return addressMapper.selectByPrimaryKey(id);
    }

    @Override
    public List<Address> list(int uid) {
        AddressExample addressExample = new AddressExample();
        addressExample.createCriteria().andUidEqualTo(uid);
        addressExample.setOrderByClause("id asc");
        return addressMapper.selectByExample(addressExample);
    }
}
