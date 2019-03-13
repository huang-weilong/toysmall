package com.weilong.mall.pojo;

import com.weilong.mall.service.OrderService;

import java.util.Date;
import java.util.List;

public class Order {
    private Integer id;

    private Integer uid;

    private String orderNum;

    private String address;

    private String post;

    private String receiver;

    private String tel;

    private String remarks;

    private String status;

    private Date createDate;

    private Date payDate;

    private Date deliveryDate;

    private Date confirmDate;
//    该订单的订单项列表
    private List<OrderItem> orderItems;
//    该订单对应的用户
    private User user;
//    该订单总金额
    private float total;
//    该订单总数量
    private int totalNum;

    public List<OrderItem> getOrderItems() {
        return orderItems;
    }

    public void setOrderItems(List<OrderItem> orderItems) {
        this.orderItems = orderItems;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public float getTotal() {
        return total;
    }

    public void setTotal(float total) {
        this.total = total;
    }

    public int getTotalNum() {
        return totalNum;
    }

    public void setTotalNum(int totalNum) {
        this.totalNum = totalNum;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getUid() {
        return uid;
    }

    public void setUid(Integer uid) {
        this.uid = uid;
    }

    public String getOrderNum() {
        return orderNum;
    }

    public void setOrderNum(String orderNum) {
        this.orderNum = orderNum == null ? null : orderNum.trim();
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address == null ? null : address.trim();
    }

    public String getPost() {
        return post;
    }

    public void setPost(String post) {
        this.post = post == null ? null : post.trim();
    }

    public String getReceiver() {
        return receiver;
    }

    public void setReceiver(String receiver) {
        this.receiver = receiver == null ? null : receiver.trim();
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel == null ? null : tel.trim();
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks == null ? null : remarks.trim();
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status == null ? null : status.trim();
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public Date getPayDate() {
        return payDate;
    }

    public void setPayDate(Date payDate) {
        this.payDate = payDate;
    }

    public Date getDeliveryDate() {
        return deliveryDate;
    }

    public void setDeliveryDate(Date deliveryDate) {
        this.deliveryDate = deliveryDate;
    }

    public Date getConfirmDate() {
        return confirmDate;
    }

    public void setConfirmDate(Date confirmDate) {
        this.confirmDate = confirmDate;
    }

    public String getTheStatus() {
        String s = "未知";
        switch(status){
            case OrderService.waitPay:
                s = "待付款";
                break;
            case OrderService.waitDelivery:
                s = "待发货";
                break;
            case OrderService.waitConfirm:
                s = "待收货";
                break;
            case OrderService.waitReview:
                s = "待评价";
                break;
            case OrderService.finish:
                s = "完成";
                break;
            case OrderService.delete:
                s = "刪除";
                break;
            default:
                s = "未知";
        }
        return s;
    }

    @Override
    public String toString() {
        return "Order{" +
                "id=" + id +
                ", uid=" + uid +
                ", orderNum='" + orderNum + '\'' +
                ", address='" + address + '\'' +
                ", post='" + post + '\'' +
                ", receiver='" + receiver + '\'' +
                ", tel='" + tel + '\'' +
                ", remarks='" + remarks + '\'' +
                ", status='" + status + '\'' +
                ", createDate=" + createDate +
                ", payDate=" + payDate +
                ", deliveryDate=" + deliveryDate +
                ", confirmDate=" + confirmDate +
                ", orderItems=" + orderItems +
                ", user=" + user +
                ", total=" + total +
                ", totalNum=" + totalNum +
                '}';
    }
}