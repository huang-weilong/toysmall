package com.weilong.mall.util;

import com.weilong.mall.pojo.Order;
import com.yeepay.Configuration;
import com.yeepay.PaymentForOnlineService;


public class YeePayUtil {
    public String pay(Order order, String total, String pd_FrpId){
        //定义易宝支付的参数
        //业务类型 固定 Buy
        String p0_Cmd = "Buy";
        //商户编号
        String p1_MerId = Configuration.getInstance().getValue("p1_MerId");
        //商户订单号
        String p2_Order = order.getOrderNum();
        //支付金额
//        String p3_Amt = String.valueOf(total);//实际价格
        String p3_Amt = "0.01";
        //交易币种 固定值 CNY
        String p4_Cur = "CNY";
        //订单ID
        String p5_Oid = String.valueOf(order.getId());
        //商品种类
        String p6_Pcat = "";
        //商品描述
        String p7_Pdesc = "";
        //商户接收支付成功数据的地址
        String p8_Url = Configuration.getInstance().getValue("callBackURL");//回调url
        //送货地址为“1”: 需要用户将送货地址留在易宝支付系统;为“0”: 不需要，默认为 ”0”.
        String p9_SAF = "0";
        //商户扩展信息
        String pa_MP = "";
        //应答机制
        String pr_NeedResponse = "1";
        //商户秘钥
        String keyValue = Configuration.getInstance().getValue("keyValue");
        //生成hmac码
        String hmac = PaymentForOnlineService.getReqMd5HmacForOnlinePayment(p0_Cmd, p1_MerId, p2_Order, p3_Amt, p4_Cur, p5_Oid, p6_Pcat, p7_Pdesc, p8_Url, p9_SAF, pa_MP, pd_FrpId, pr_NeedResponse, keyValue);
        return concat(p0_Cmd, p1_MerId, p2_Order, p3_Amt, p4_Cur, p5_Oid, p6_Pcat, p7_Pdesc, p8_Url, p9_SAF, pa_MP, pd_FrpId, pr_NeedResponse, hmac);
    }

    private String concat(String p0_Cmd, String p1_MerId, String p2_Order,
                          String p3_Amt, String p4_Cur, String p5_Pid, String p6_Pcat,
                          String p7_Pdesc, String p8_Url, String p9_SAF, String pa_MP,
                          String pd_FrpId, String pr_NeedResponse, String hmac){
        StringBuffer sb = new StringBuffer();
        String yeepayCommonReqURL = Configuration.getInstance().getValue("yeepayCommonReqURL");
        sb.append(yeepayCommonReqURL).append("?");
        sb.append("p0_Cmd").append("=").append(p0_Cmd).append("&");
        sb.append("p1_MerId").append("=").append(p1_MerId).append("&");
        sb.append("p2_Order").append("=").append(p2_Order).append("&");
        sb.append("p3_Amt").append("=").append(p3_Amt).append("&");
        sb.append("p4_Cur").append("=").append(p4_Cur).append("&");
        sb.append("p5_Pid").append("=").append(p5_Pid).append("&");
        sb.append("p6_Pcat").append("=").append(p6_Pcat).append("&");
        sb.append("p7_Pdesc").append("=").append(p7_Pdesc).append("&");
        sb.append("p8_Url").append("=").append(p8_Url).append("&");
        sb.append("p9_SAF").append("=").append(p9_SAF).append("&");
        sb.append("pa_MP").append("=").append(pa_MP).append("&");
        sb.append("pd_FrpId").append("=").append(pd_FrpId).append("&");
        sb.append("pr_NeedResponse").append("=").append(pr_NeedResponse).append("&");
        sb.append("hmac").append("=").append(hmac);
        return sb.toString();
    }
}
