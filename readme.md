## 基于SSM的玩具网上商城
这是本人的毕业设计作品。

运行本程序建议使用Intellij IDEA

根目录下的toysmall.sql为数据库文件，使用mysql作为数据库

相关的配置在程序中的resource文件夹中

### 关于短信服务
本程序的短信服务使用了阿里云的短信服务，需要使用的可自行开通，并根据注释替换util中SendVerificationCode.java相关参数

### 关于支付
本程序使用了易宝支付和支付宝支付（支付宝为沙箱环境）。同样的，需要使用可去对应官网申请相关服务。  
易宝支付修改merchantInfo.properties文件内的信息
支付宝支付修改util包中AlipayConfig.java相关信息