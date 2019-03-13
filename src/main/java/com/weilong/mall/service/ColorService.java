package com.weilong.mall.service;

import com.weilong.mall.pojo.Color;

import java.util.List;

public interface ColorService {
    void add(Color color);
    void delete(int id);
    void update(Color color);
    Color get(int id);
    List<Color> list(int pid);
}
