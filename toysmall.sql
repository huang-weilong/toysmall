/*
Navicat MySQL Data Transfer

Source Server         : long
Source Server Version : 80015
Source Host           : localhost:3306
Source Database       : toysmall

Target Server Type    : MYSQL
Target Server Version : 80015
File Encoding         : 65001

Date: 2019-03-13 22:23:52
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for address
-- ----------------------------
DROP TABLE IF EXISTS `address`;
CREATE TABLE `address` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `tel` varchar(11) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `post` varchar(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_address_user` (`uid`),
  CONSTRAINT `fk_address_user` FOREIGN KEY (`uid`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of address
-- ----------------------------
INSERT INTO `address` VALUES ('1', '1', 'long', '13555555555', '广东省 惠州市 惠城区  test', '000000');

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('1', 'admin', 'admin');

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `flag` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES ('1', '早教机', '1');
INSERT INTO `category` VALUES ('2', '点读笔', '1');
INSERT INTO `category` VALUES ('3', '遥控车', '2');
INSERT INTO `category` VALUES ('4', '遥控飞机', '2');
INSERT INTO `category` VALUES ('5', '遥控船', '2');
INSERT INTO `category` VALUES ('6', '积木', '3');
INSERT INTO `category` VALUES ('7', '拼图', '3');
INSERT INTO `category` VALUES ('8', '玩具熊', '4');
INSERT INTO `category` VALUES ('9', '洋娃娃', '4');
INSERT INTO `category` VALUES ('10', '戏水玩具', '5');
INSERT INTO `category` VALUES ('11', '情景玩具', '6');

-- ----------------------------
-- Table structure for color
-- ----------------------------
DROP TABLE IF EXISTS `color`;
CREATE TABLE `color` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) DEFAULT NULL,
  `colorValue` varchar(255) DEFAULT NULL,
  `stock` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_color_product` (`pid`),
  CONSTRAINT `fk_color_product` FOREIGN KEY (`pid`) REFERENCES `product` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of color
-- ----------------------------
INSERT INTO `color` VALUES ('1', '1', '9英寸 WiFi版 蓝色', '33');
INSERT INTO `color` VALUES ('2', '1', '9英寸 WiFi版 粉色', '73');
INSERT INTO `color` VALUES ('3', '2', '法拉利 红', '219');
INSERT INTO `color` VALUES ('4', '2', '法拉利 黄', '89');
INSERT INTO `color` VALUES ('5', '2', '法拉利 灰', '136');

-- ----------------------------
-- Table structure for orderitem
-- ----------------------------
DROP TABLE IF EXISTS `orderitem`;
CREATE TABLE `orderitem` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `oid` int(11) DEFAULT NULL,
  `uid` int(11) DEFAULT NULL,
  `pid` int(11) DEFAULT NULL,
  `number` int(11) DEFAULT NULL,
  `coverImage` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `price` float DEFAULT NULL,
  `color` varchar(255) DEFAULT NULL,
  `colorStock` int(11) DEFAULT NULL,
  `colorId` int(11) DEFAULT NULL,
  `flag` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_orderItem_order` (`oid`),
  KEY `fk_orderItem_user` (`uid`),
  CONSTRAINT `fk_orderItem_order` FOREIGN KEY (`oid`) REFERENCES `order_` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_orderItem_user` FOREIGN KEY (`uid`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of orderitem
-- ----------------------------
INSERT INTO `orderitem` VALUES ('3', '3', '1', '2', '2', null, null, null, null, null, null, '5', '1');
INSERT INTO `orderitem` VALUES ('4', '3', '1', '2', '2', null, null, null, null, null, null, '4', '1');
INSERT INTO `orderitem` VALUES ('5', '4', '1', '2', '1', null, null, null, null, null, null, '4', '0');
INSERT INTO `orderitem` VALUES ('6', '4', '1', '1', '2', null, null, null, null, null, null, '1', '0');
INSERT INTO `orderitem` VALUES ('7', '5', '1', '2', '1', null, null, null, null, null, null, '5', '0');
INSERT INTO `orderitem` VALUES ('8', '6', '1', '1', '1', null, null, null, null, null, null, '2', '0');
INSERT INTO `orderitem` VALUES ('9', '7', '1', '2', '1', null, null, null, null, null, null, '5', '0');
INSERT INTO `orderitem` VALUES ('10', '8', '1', '1', '1', null, null, null, null, null, null, '2', '0');
INSERT INTO `orderitem` VALUES ('11', '9', '1', '1', '1', null, null, null, null, null, null, '1', '0');

-- ----------------------------
-- Table structure for order_
-- ----------------------------
DROP TABLE IF EXISTS `order_`;
CREATE TABLE `order_` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT NULL,
  `orderNum` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `post` varchar(255) DEFAULT NULL,
  `receiver` varchar(255) DEFAULT NULL,
  `tel` varchar(11) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `payDate` datetime DEFAULT NULL,
  `deliveryDate` datetime DEFAULT NULL,
  `confirmDate` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_order_user` (`uid`),
  CONSTRAINT `fk_order_user` FOREIGN KEY (`uid`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of order_
-- ----------------------------
INSERT INTO `order_` VALUES ('3', '1', '37050420190311182511', '广东省 惠州市 惠城区  test', '000000', 'long', '13555555555', '', 'finish', '2019-03-11 18:25:11', '2019-03-11 18:25:46', '2019-03-13 21:09:21', '2019-03-13 21:09:31');
INSERT INTO `order_` VALUES ('4', '1', '17540820190311182727', '广东省 惠州市 惠城区  test', '000000', 'long', '13555555555', '', 'waitConfirm', '2019-03-11 18:27:27', '2019-03-11 18:28:01', '2019-03-11 18:28:10', null);
INSERT INTO `order_` VALUES ('5', '1', '91744720190313204510', '广东省 惠州市 惠城区  test', '000000', 'long', '13555555555', '', 'waitPay', '2019-03-13 20:45:10', null, null, null);
INSERT INTO `order_` VALUES ('6', '1', '43855220190313211021', '广东省 惠州市 惠城区  test', '000000', 'long', '13555555555', '', 'waitReview', '2019-03-13 21:10:21', '2019-03-13 21:11:15', '2019-03-13 21:12:51', '2019-03-13 21:13:05');
INSERT INTO `order_` VALUES ('7', '1', '75175620190313211152', '广东省 惠州市 惠城区  test', '000000', 'long', '13555555555', '', 'waitDelivery', '2019-03-13 21:11:52', '2019-03-13 21:12:33', null, null);
INSERT INTO `order_` VALUES ('8', '1', '65328420190313215314', '广东省 惠州市 惠城区  test', '000000', 'long', '13555555555', '', 'waitPay', '2019-03-13 21:53:15', null, null, null);
INSERT INTO `order_` VALUES ('9', '1', '77288120190313221716', '广东省 惠州市 惠城区  test', '000000', 'long', '13555555555', '', 'waitPay', '2019-03-13 22:17:16', null, null, null);

-- ----------------------------
-- Table structure for product
-- ----------------------------
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `originalPrice` float DEFAULT NULL,
  `discountPrice` float DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `cid` int(11) DEFAULT NULL,
  `display` int(11) DEFAULT '2',
  `saleCount` int(11) DEFAULT '0',
  `reviewCount` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_product_category` (`cid`),
  CONSTRAINT `fk_product_category` FOREIGN KEY (`cid`) REFERENCES `category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of product
-- ----------------------------
INSERT INTO `product` VALUES ('1', '儿童早教机可连wifi安卓触摸屏宝宝学习机可视频聊天故事机国学机0-3-6岁可充电幼儿玩具', '【9折优惠】下单即送礼品包装盒、防摔包、双话筒等', '278', '250.2', '2019-03-11 15:57:22', '1', '1', '3', '0');
INSERT INTO `product` VALUES ('2', '男孩儿童玩具遥控车跑车模型 内置充电一键遥控敞篷可漂移 74560 红色', '【8折优惠】萌娃开学季，满199减60,299减100,399减150', '399', '319.2', '2019-03-11 18:14:06', '3', '1', '9', '2');

-- ----------------------------
-- Table structure for productimage
-- ----------------------------
DROP TABLE IF EXISTS `productimage`;
CREATE TABLE `productimage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_productImage_product` (`pid`),
  CONSTRAINT `fk_productImage_product` FOREIGN KEY (`pid`) REFERENCES `product` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of productimage
-- ----------------------------
INSERT INTO `productimage` VALUES ('1', '1', 'goods');
INSERT INTO `productimage` VALUES ('2', '1', 'goods');
INSERT INTO `productimage` VALUES ('3', '1', 'goods');
INSERT INTO `productimage` VALUES ('4', '1', 'goods');
INSERT INTO `productimage` VALUES ('5', '1', 'detail');
INSERT INTO `productimage` VALUES ('6', '1', 'detail');
INSERT INTO `productimage` VALUES ('7', '2', 'goods');
INSERT INTO `productimage` VALUES ('8', '2', 'goods');
INSERT INTO `productimage` VALUES ('9', '2', 'goods');
INSERT INTO `productimage` VALUES ('10', '2', 'goods');
INSERT INTO `productimage` VALUES ('11', '2', 'detail');
INSERT INTO `productimage` VALUES ('12', '2', 'detail');
INSERT INTO `productimage` VALUES ('13', '2', 'detail');
INSERT INTO `productimage` VALUES ('14', '2', 'detail');

-- ----------------------------
-- Table structure for property
-- ----------------------------
DROP TABLE IF EXISTS `property`;
CREATE TABLE `property` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `cid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_property_category` (`cid`),
  CONSTRAINT `fk_property_category` FOREIGN KEY (`cid`) REFERENCES `category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of property
-- ----------------------------
INSERT INTO `property` VALUES ('1', '产地', '1');
INSERT INTO `property` VALUES ('2', '型号', '1');
INSERT INTO `property` VALUES ('3', '材质', '1');
INSERT INTO `property` VALUES ('4', '商品编号', '3');
INSERT INTO `property` VALUES ('5', '商品产地', '3');
INSERT INTO `property` VALUES ('6', '控制类型', '3');
INSERT INTO `property` VALUES ('7', '电源类型', '3');

-- ----------------------------
-- Table structure for propertyvalue
-- ----------------------------
DROP TABLE IF EXISTS `propertyvalue`;
CREATE TABLE `propertyvalue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) DEFAULT NULL,
  `ptid` int(11) DEFAULT NULL,
  `ptValue` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_propertyvalue_property` (`ptid`),
  KEY `fk_propertyvalue_product` (`pid`),
  CONSTRAINT `fk_propertyvalue_product` FOREIGN KEY (`pid`) REFERENCES `product` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_propertyvalue_property` FOREIGN KEY (`ptid`) REFERENCES `property` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of propertyvalue
-- ----------------------------
INSERT INTO `propertyvalue` VALUES ('1', '1', '3', '塑料');
INSERT INTO `propertyvalue` VALUES ('2', '1', '2', '智力快车');
INSERT INTO `propertyvalue` VALUES ('3', '1', '1', '中国大陆');
INSERT INTO `propertyvalue` VALUES ('4', '2', '7', '充电电池');
INSERT INTO `propertyvalue` VALUES ('5', '2', '6', '无线遥控');
INSERT INTO `propertyvalue` VALUES ('6', '2', '5', '广东汕头');
INSERT INTO `propertyvalue` VALUES ('7', '2', '4', '2495730');

-- ----------------------------
-- Table structure for review
-- ----------------------------
DROP TABLE IF EXISTS `review`;
CREATE TABLE `review` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) DEFAULT NULL,
  `uid` int(11) DEFAULT NULL,
  `oiid` int(11) DEFAULT NULL,
  `oid` int(11) DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_review_user` (`uid`),
  KEY `fk_review_product` (`pid`),
  KEY `fk_review_orderitem` (`oiid`),
  CONSTRAINT `fk_review_orderitem` FOREIGN KEY (`oiid`) REFERENCES `orderitem` (`id`),
  CONSTRAINT `fk_review_product` FOREIGN KEY (`pid`) REFERENCES `product` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_review_user` FOREIGN KEY (`uid`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of review
-- ----------------------------
INSERT INTO `review` VALUES ('1', '2', '1', '4', '3', '66666666666', '2019-03-13 21:09:42');
INSERT INTO `review` VALUES ('2', '2', '1', '3', '3', '66666666', '2019-03-13 21:09:53');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `tel` varchar(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'long', 'long1234', '13555555555');
