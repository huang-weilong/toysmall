package com.weilong.mall.mapper;

import com.weilong.mall.pojo.Color;
import com.weilong.mall.pojo.ColorExample;
import java.util.List;

public interface ColorMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Color record);

    int insertSelective(Color record);

    List<Color> selectByExample(ColorExample example);

    Color selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Color record);

    int updateByPrimaryKey(Color record);
}