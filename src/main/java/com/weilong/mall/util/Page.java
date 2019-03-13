package com.weilong.mall.util;

public class Page {
    private int start;//起始页
    private int count;//每页个数
    private int total;//总个数
    private String param;//参数

    public int getStart() {
        return start;
    }

    public void setStart(int start) {
        this.start = start;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }

    public int getTotal() {
        return total;
    }

    public void setTotal(int total) {
        this.total = total;
    }

    public String getParam() {
        return param;
    }

    public void setParam(String param) {
        this.param = param;
    }

//    判断是否有前一页
    public boolean isHasPreviouse() {
        return start != 0;
    }
//    判断是否有下一页
    public boolean isHasNext() {
        return start != getLast();
    }
//    计算最后一页的起始数（如5个一页（0~4），则第二页的起始数就是5）
    public int getLast() {
        int last;
        if (total % count == 0)
            last = total - count;
        else
            last = total - total % count;
        last = last < 0 ? 0 : last;
        return last;
    }
//    计算总页数
    public int getTotalPage() {
        int totalPage;
        if (total % count == 0)
            totalPage = total / count;
        else
            totalPage = total / count + 1;
        if (totalPage == 0)
            totalPage = 1;
        return totalPage;
    }

    @Override
    public String toString() {
        return "Page{" +
                "start=" + start +
                ", count=" + count +
                ", total=" + total +
                ", getStart()=" + getStart() +
                ", getCount()=" + getCount() +
                ", isHasPreviouse()=" + isHasPreviouse() +
                ", isHasNext()=" + isHasNext() +
                ", getTotalPage()=" + getTotalPage() +
                ", getLast()=" + getLast() +
                ", param='" + param + '\'' +
                '}';
    }
}
