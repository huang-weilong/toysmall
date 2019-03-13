package com.weilong.mall.service;

import com.weilong.mall.pojo.Address;

import java.util.List;

public interface AddressService {
    void add(Address address);
    void delete(int id);
    void update(Address address);
    Address get(int id);
    List<Address> list(int uid);
}
