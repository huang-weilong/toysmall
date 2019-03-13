package com.weilong.mall.service.impl;

import com.weilong.mall.mapper.ColorMapper;
import com.weilong.mall.pojo.Color;
import com.weilong.mall.pojo.ColorExample;
import com.weilong.mall.service.ColorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ColorServiceImpl implements ColorService{
    @Autowired
    ColorMapper colorMapper;

    @Override
    public void add(Color color) {
        colorMapper.insert(color);
    }

    @Override
    public void delete(int id) {
        colorMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void update(Color color) {
        colorMapper.updateByPrimaryKeySelective(color);
    }

    @Override
    public Color get(int id) {
        return colorMapper.selectByPrimaryKey(id);
    }

    @Override
    public List<Color> list(int pid) {
//        调用辅助查询类
        ColorExample colorExample = new ColorExample();
//        查询pid字段
        colorExample.createCriteria().andPidEqualTo(pid);
        colorExample.setOrderByClause("id desc");
        return colorMapper.selectByExample(colorExample);
    }
}
