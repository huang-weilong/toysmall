package com.weilong.mall.pojo;

public class PropertyValue {
    private Integer id;

    private Integer pid;

    private Integer ptid;

    private String ptValue;

//    非数据库字段
    private Property property;

    public Property getProperty() {
        return property;
    }

    public void setProperty(Property property) {
        this.property = property;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getPid() {
        return pid;
    }

    public void setPid(Integer pid) {
        this.pid = pid;
    }

    public Integer getPtid() {
        return ptid;
    }

    public void setPtid(Integer ptid) {
        this.ptid = ptid;
    }

    public String getPtValue() {
        return ptValue;
    }

    public void setPtValue(String ptValue) {
        this.ptValue = ptValue == null ? null : ptValue.trim();
    }
}