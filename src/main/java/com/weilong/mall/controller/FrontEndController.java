package com.weilong.mall.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.weilong.mall.pojo.*;
import com.weilong.mall.service.*;
import com.weilong.mall.util.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping("")
public class FrontEndController {
    @Autowired
    CategoryService categoryService;
    @Autowired
    ColorService colorService;
    @Autowired
    OrderItemService orderItemService;
    @Autowired
    OrderService orderService;
    @Autowired
    ProductService productService;
    @Autowired
    ProductImageService productImageService;
    @Autowired
    PropertyValueService propertyValueService;
    @Autowired
    UserService userService;
    @Autowired
    ReviewService reviewService;
    @Autowired
    AddressService addressService;

//    首页
    @RequestMapping("index")
    public String index(Model model){
        List<Category> categories = categoryService.list();
        model.addAttribute("categories", categories);
        return "frontEnd/index";
    }
//    注册页面
    @RequestMapping("registerPage")
    public String registerPage() {
        return "frontEnd/register";
    }
//    注册成功页面
    @RequestMapping("registerSuccessPage")
    public String registerSuccessPage() {
        return "frontEnd/registerSuccess";
    }
//    登录页面
    @RequestMapping("loginPage")
    public String loginPage() {
        return "frontEnd/login";
    }
//    注销
    @RequestMapping("logout")
    public String logout(HttpSession session) {
        session.removeAttribute("user");
        return "redirect:index";
    }
//    检查是否登录
    @RequestMapping("checkLogin")
    @ResponseBody
    public String checkLogin(HttpSession session) {
        User user = (User)session.getAttribute("user");
        if (user == null)
            return "no";
        return "yes";
    }
//    注册
    @RequestMapping("register")
    public String register(Model model, User user, @RequestParam("repeatPassword") String repeatPassword, HttpSession session) {
//        获取用户输入的用户名、验证码和手机号
        String username = user.getUsername();
        String code = user.getCode();
        String tel = user.getTel();
//        获取后台发送的验证码
        String regCode = (String)session.getAttribute("regCode");
//        获取后台接收验证码的手机号
        String regTel = (String)session.getAttribute("regTel");
//        判断用户名是否存在
        boolean exist = userService.isExistUser(username);
        if (exist) {
            model.addAttribute("nameExist", "用户名已存在");
            return "frontEnd/register";
        }
        if (!user.getPassword().equals(repeatPassword)) {
            model.addAttribute("passwordError", "两次输入的密码不一致");
            return "frontEnd/register";
        }
        if (user.getUsername().length() < 4 || user.getUsername().length() > 20) {
            model.addAttribute("usernameLengthError", "用户名长度不正确");
            return "frontEnd/register";
        }
//        判断密码长度是否符合6-20位
        if (user.getPassword().length() < 6 || user.getPassword().length() > 20) {
            model.addAttribute("passwordLengthError", "密码长度不正确");
            return "frontEnd/register";
        }
//        判断手机号有没有在获得验证码后被更改
//        判断验证码是否正确
        if (!tel.equals(regTel) || !code.equals(regCode)) {
            model.addAttribute("telOrCodeError", "手机或验证码错误");
            return "frontEnd/register";
        }
        userService.add(user);
        //注册成功将验证码和注册手机号的session销毁
        session.removeAttribute("regCode");
        session.removeAttribute("regTel");
        return "redirect:registerSuccessPage";
    }
//    判断用户名是否已经被注册
    @RequestMapping("checkUsername")
    @ResponseBody
    public String checkUsername(@RequestParam("username") String username) {
        boolean exist = userService.isExistUser(username);
        if (exist)
            return "no";
        return "yes";
    }
//    使用用户名密码登录
    @RequestMapping("loginForName")
    public String loginForName(@RequestParam("username") String username, @RequestParam("password") String password, Model model, HttpSession session) {
        User user = userService.getName(username, password);
        if (user == null) {
            model.addAttribute("nameOrPwdError", "账号或密码错误");
            return "frontEnd/login";
        }
        session.setAttribute("user", user);
        return "redirect:index";
    }
//    使用手机号码登录
    @RequestMapping("loginForTel")
    public String loginForTel(@RequestParam("tel") String tel, @RequestParam("code") String code, Model model, HttpSession session) {
//        获取后台发送的验证码
        String loginCode = (String)session.getAttribute("loginCode");
        String loginTel = (String)session.getAttribute("loginTel");
        User user = userService.getTel(tel);
//        判断手机号是否存在，输入手机号是否正确，验证码是否正确
        if (user == null || !tel.equals(loginTel) || !code.equals(loginCode)) {
            model.addAttribute("telOrCodeError", "手机或验证码错误");
            return "frontEnd/login";
        }
        session.setAttribute("user", user);
        session.removeAttribute("loginCode");
        session.removeAttribute("loginTel");
        return "redirect:index";
    }
//    用户名密码模态登录
    @RequestMapping("loginModalUserName")
    @ResponseBody
    public String loginModalUserName(@RequestParam("username") String username, @RequestParam("password") String password, HttpSession session) {
        User user = userService.getName(username, password);
        if (user == null)
            return "no";
        session.setAttribute("user", user);
        return "yes";
    }
//    手机号模态登陆
    @RequestMapping("loginModalTel")
    @ResponseBody
    public String loginModalTel(@RequestParam("tel") String tel, @RequestParam("code") String code, HttpSession session) {
//        获取后台发送的验证码
        String loginCode = (String)session.getAttribute("loginCode");
        String loginTel = (String)session.getAttribute("loginTel");
        User user = userService.getTel(tel);
        if (user == null || !tel.equals(loginTel) || !code.equals(loginCode)) {
            return "no";
        }
        session.setAttribute("user", user);
        session.removeAttribute("loginCode");
        session.removeAttribute("loginTel");
        return "yes";
    }
//    个人中心
    @RequestMapping("homePage")
    public String homePage(Model model, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null)
            return "redirect:loginPage";
        List<Address> addresses = addressService.list(user.getId());
        model.addAttribute("addresses", addresses);
        return "frontEnd/homePage";
    }
//    修改密码页面
    @RequestMapping("editPasswordPage")
    public String editPasswordPage(HttpSession session) {
        if (session.getAttribute("user") == null)
            return "redirect:loginPage";
        return "frontEnd/editPassword";
    }
//    修改密码
    @RequestMapping("editPassword")
    public String editPassword(@RequestParam("password") String password, @RequestParam("repeatPassword") String repeat,Model model, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null)
            return "redirect:loginPage";
        if (!password.equals(repeat)) {
            model.addAttribute("passwordError", "密码不一致");
            return "frontEnd/editPassword";
        }
//        判断密码长度是否符合6-20位
        if (password.length() < 6 || password.length() > 20) {
            model.addAttribute("passwordLengthError", "密码长度不正确");
            return "frontEnd/editPassword";
        }
        user.setPassword(password);
        userService.update(user);
        return "redirect:editPasswordSuccess";
    }
//    修改密码成功
    @RequestMapping("editPasswordSuccess")
    public String editPasswordSuccess() {
        return "frontEnd/editPasswordSuccess";
    }
//    新增收货地址页面
    @RequestMapping("addAddressPage")
    public String addAddressPage(HttpSession session) {
        if (session.getAttribute("user") == null)
            return "redirect:loginPage";
        return "frontEnd/addAddress";
    }
//    新增收货地址
    @RequestMapping("addAddress")
    @ResponseBody
    public String addAddress(Address address, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null)
            return "no";
        address.setUid(user.getId());
//        如果用户没有输入邮政编码则设置为000000
        if (address.getPost().equals(""))
            address.setPost("000000");
        addressService.add(address);
        return "yes";
    }
//    删除收货地址
    @RequestMapping("deleteAddress")
    @ResponseBody
    public String deleteAddress(@RequestParam("aid") int aid, HttpSession session) {
        if (session.getAttribute("user") == null)
            return "no";
        addressService.delete(aid);
        return "yes";
    }
//    商品结果页
    @RequestMapping("productResult")
    public String productResult(Model model, @RequestParam("cid") int cid, String sort, Page page) {
        page.setCount(20);
        PageHelper.offsetPage(page.getStart(), page.getCount());
        List<Product> products = productService.list(cid, 1, sort);
        int total = (int) new PageInfo<Product>(products).getTotal();
        page.setTotal(total);
        page.setParam("&cid=" + cid + "&sort=" + sort);
        Category category = categoryService.get(cid);

        model.addAttribute("products", products);
        model.addAttribute("page", page);
        model.addAttribute("category", category);
        model.addAttribute("sort", sort);
        return "frontEnd/productResult";
    }
//    单个商品详情
    @RequestMapping("product")
    public String product(Model model, int pid, Page page) {
        Product product = productService.get(pid);
        if (product.getDisplay() != 1)
            return "error404";
        List<ProductImage> productGoodImages = productImageService.list(product.getId(), ProductImageService.type_goods);
        List<ProductImage> productDetailImages = productImageService.list(product.getId(), ProductImageService.type_detail);
        product.setProductGoodImages(productGoodImages);
        product.setProductDetailImages(productDetailImages);

        List<Color> colors = colorService.list(pid);
//        所有颜色分类总库存
        int sumStock = 0;
        for (Color color : colors)
            sumStock += color.getStock();

        List<PropertyValue> propertyValues = propertyValueService.list(product.getId());

        page.setCount(20);
        PageHelper.offsetPage(page.getStart(), page.getCount());
        List<Review> reviews = reviewService.list(product.getId());
        int total = (int) new PageInfo<Review>(reviews).getTotal();
        page.setTotal(total);
        page.setParam("&pid="+pid);

        model.addAttribute("product", product);
        model.addAttribute("propertyValues", propertyValues);
        model.addAttribute("reviews", reviews);
        model.addAttribute("colors", colors);
        model.addAttribute("sumStock", sumStock);
        model.addAttribute("page", page);
        return "frontEnd/product";
    }
//    搜索
    @RequestMapping("search")
    public String search(String keyword, Model model, String sort, Page page) {
        if (keyword.isEmpty())
            return "redirect:index";
        page.setCount(20);
        PageHelper.offsetPage(page.getStart(), page.getCount());
        List<Product> products = productService.search(keyword, sort);
        int total = (int) new PageInfo<Product>(products).getTotal();
        page.setTotal(total);
        page.setParam("&keyword="+keyword + "&sort=" + sort);

        model.addAttribute("keyword", keyword);
        model.addAttribute("products", products);
        model.addAttribute("page", page);
        model.addAttribute("sort", sort);
        return "frontEnd/searchResult";
    }
//    加入购物车
    @RequestMapping("addCart")
    @ResponseBody
    public String addCart(@RequestParam("pid") int pid, @RequestParam("num") int num,@RequestParam("colorValue") String colorValue,@RequestParam("colorId") int colorId, HttpSession session) {
//        拿到这个产品信息
        Product product = productService.get(pid);
        User user = (User)session.getAttribute("user");
        Color color = colorService.get(colorId);
//        在购物车内的商品信息（没有oid的订单项）
        List<OrderItem> orderItems = orderItemService.listByUser(user.getId());
        boolean flag = false;
        for (OrderItem orderItem : orderItems) {
//            购物车内有相同的商品信息，且颜色分类相同，则更新数量
            if (orderItem.getPid().intValue() == product.getId().intValue() &&
                    orderItem.getColor().getColorValue().equals(colorValue)) {
                orderItem.setNumber(orderItem.getNumber() + num);
//                如果加入的数量大于库存量，数量则改为库存量
                if (orderItem.getNumber() > color.getStock())
                    orderItem.setNumber(color.getStock());
                orderItemService.update(orderItem);
                flag = true;
                break;
            }
        }
//        若购物车内没有一模一样的商品信息，则新建一个订单项
        if (!flag) {
            OrderItem orderItem = new OrderItem();
            orderItem.setUid(user.getId());
            orderItem.setPid(pid);
            orderItem.setNumber(num);
            orderItem.setColorId(color.getId());
            orderItem.setFlag(0);
            orderItemService.add(orderItem);
        }
        return "success";
    }
//    查看购物车
    @RequestMapping("showCart")
    public String showCart(Model model, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null)
            return "redirect:loginPage";
        List<OrderItem> orderItems = orderItemService.listByUser(user.getId());
        model.addAttribute("orderItems", orderItems);
//        session.setAttribute("orderItems", orderItems);
        return "frontEnd/showCart";
    }
//    更新购物车信息
    @RequestMapping("updateOrderItem")
    @ResponseBody
    public String updateOrderItem(int oiid, int num, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null)
            return "no";
        List<OrderItem> orderItems = orderItemService.listByUser(user.getId());
        for (OrderItem orderItem : orderItems) {
            if (orderItem.getId() == oiid) {
                orderItem.setNumber(num);
                orderItemService.update(orderItem);
                break;
            }
        }
        return "yes";
    }
//    删除购物车内订单项
    @RequestMapping("deleteOrderItem")
    @ResponseBody
    public String deleteOrderItem(int oiid, HttpSession session) {
        if (session.getAttribute("user") == null)
            return "no";
        orderItemService.delete(oiid);
        return "yes";
    }
//    结算购买
    @RequestMapping("buy")
    public String buy(Model model, String[] oiid, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null)
            return "redirect:loginPage";
        List<Address> addresses = addressService.list(user.getId());
        List<OrderItem> orderItems = new ArrayList<>();
        float total = 0;
        int num = 0;
        for (String s : oiid) {
            int id = Integer.parseInt(s);
            OrderItem orderItem = orderItemService.get(id);
//            如果用户在浏览器请求了别的oiid订单项，判断是不是该用户的，并且该订单项是否已经关联订单
            if (user.getId().intValue() != orderItem.getUid().intValue() || orderItem.getOid() != null){
                return "error";
            }
            total += orderItem.getProduct().getDiscountPrice()*orderItem.getNumber();
            num += orderItem.getNumber();
            orderItems.add(orderItem);
        }
        model.addAttribute("user", user);
        model.addAttribute("addresses", addresses);
        session.setAttribute("orderItems", orderItems);
        model.addAttribute("total", total);
        model.addAttribute("num", num);
        return "frontEnd/buy";
    }
//    提交创建订单
    @RequestMapping("createOrder")
    public String createOrder(Order order, String message, int aid, int payWay, HttpSession session) throws IOException {
        User user = (User) session.getAttribute("user");
        if (user == null)
            return "redirect:loginPage";
        Address address = addressService.get(aid);
//        生成六位随机数
        int a = (int)((Math.random()*9+1)*100000);
//        获取当前时间字符串
        String simpleDateFormat = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
        String orderNum = String.valueOf(a) + simpleDateFormat;
        order.setOrderNum(orderNum);
        order.setUid(user.getId());
        order.setCreateDate(new Date());
        order.setStatus(OrderService.waitPay);
        order.setRemarks(message);
        order.setTel(address.getTel());
        order.setReceiver(address.getName());
        order.setAddress(address.getAddress());
        order.setPost(address.getPost());

        List<OrderItem> orderItems = (List<OrderItem>) session.getAttribute("orderItems");
//        避免重复提交订单
        for (OrderItem orderItem : orderItems) {
            if (orderItem.getOid() != null) {
                return "frontEnd/repeatOrder";
            }
        }
//        创建订单，并将订单项和订单关联起来
        orderService.add(order, orderItems);
//        计算订单总价
        float total = orderService.calculateTotal(order.getId());
        return "redirect:pay?oid=" + order.getId() + "&total=" + total + "&payWay=" + payWay;
    }

//    “我的订单”里指定状态的订单
    @RequestMapping("userOrderStatus")
    public String userOrderStatus(String status, Model model, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null)
            return "redirect:loginPage";
        List<Order> orders = orderService.list(user.getId(), status);
        orderItemService.addOrderItems(orders);
        model.addAttribute("orders", orders);
        model.addAttribute("status", status);
        return "frontEnd/order";
    }
//    确认收货
    @RequestMapping("confirm")
    @ResponseBody
    public String confirm(@RequestParam("oid") int oid, HttpSession session){
        User user = (User) session.getAttribute("user");
        Order order = orderService.get(oid);
        if (user.getId().intValue() != order.getUid().intValue() || !order.getStatus().equals("waitConfirm"))
            return "no";
        order.setStatus(OrderService.waitReview);
        order.setConfirmDate(new Date());
        orderService.update(order);
        return "yes";
    }
//    删除订单
    @RequestMapping("deleteOrder")
    @ResponseBody
    public String deleteOrder(@RequestParam("oid") int oid, HttpSession session) {
        if (session.getAttribute("user") == null)
            return "no";
        Order order = orderService.get(oid);
//        删除订单只是改变状态，并不是真的删除
        order.setStatus(OrderService.delete);
        orderService.update(order);
        return "yes";
    }
//    评论页
    @RequestMapping("reviewPage")
    public String reviewPage(HttpSession session) {
        if (session.getAttribute("user") == null)
            return "redirect:loginPage";
        return "frontEnd/review";
    }
//    去评论
    @RequestMapping("review")
    @ResponseBody
    public String review(@RequestParam("pid") int pid, int oiid, HttpSession session) {
        if (session.getAttribute("user") == null)
            return "no";
        Product product = productService.get(pid);
//        设置当前用户点击的去评论的商品和对应的订单项id
        session.setAttribute("product", product);
        session.setAttribute("oiid", oiid);
        return "yes";
    }
//    增加评论
    @RequestMapping("addReview")
    @ResponseBody
    public String addReview(Review review, @RequestParam("message") String message, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null)
            return "no";
        if (message.length() == 0) {
            message = "默认好评！";
        }
        int oiid = (int) session.getAttribute("oiid");
        OrderItem orderItem = orderItemService.get(oiid);
        int oid = orderItem.getOid();
        Order order = orderService.get(oid);

        review.setPid(orderItem.getPid());
        review.setUid(user.getId());
        review.setOiid(oiid);
        review.setOid(oid);
        review.setMessage(message);
        review.setCreateDate(new Date());
        reviewService.add(review);
//        将评论的标记设为1，即已评论
        orderItem.setFlag(1);
        orderItemService.update(orderItem);

//        商品的评论数加1
        Product product = productService.get(orderItem.getPid());
        product.setReviewCount(product.getReviewCount()+1);
        productService.update(product);

//        判断该订单下的所有商品是否都已评论，根据oid的个数来判断
        List<OrderItem> orderItems = orderItemService.listByOid(oid);
        List<Review> reviews = reviewService.listByOid(oid);
        if (orderItems.size() == reviews.size()) {
            order.setStatus(OrderService.finish);
            orderService.update(order);
        }
        return "yes";
    }
//    评价成功
    @RequestMapping("reviewSuccess")
    public String reviewSuccess(Model model, HttpSession session) {
        if (session.getAttribute("user") == null)
            return "redirect:loginPage";
        model.addAttribute("addReviewSuccess", "评价成功");
        return "frontEnd/review";
    }
//    关于本站
    @RequestMapping("about")
    public String about() {
        return "frontEnd/about";
    }
}
