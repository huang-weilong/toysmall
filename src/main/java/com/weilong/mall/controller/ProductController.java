package com.weilong.mall.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.weilong.mall.pojo.Category;
import com.weilong.mall.pojo.Product;
import com.weilong.mall.service.CategoryService;
import com.weilong.mall.service.ProductService;
import com.weilong.mall.util.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.text.DecimalFormat;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("")
public class ProductController {
    @Autowired
    CategoryService categoryService;
    @Autowired
    ProductService productService;

//    增加商品
    @RequestMapping("adminAddProduct")
    public String add(Product product, int discount, HttpSession session) {
        if (session.getAttribute("admin") == null)
            return "redirect:adminLoginPage";
//        设置添加产品的时间
        product.setCreateDate(new Date());
        float discountPrice = product.getOriginalPrice() * discount / 10;
        product.setDiscountPrice(discountPrice);
        product.setTitle("【"+discount+"折优惠】"+product.getTitle());
        productService.add(product);
        return "redirect:adminListProduct?cid=" + product.getCid();
    }

//    添加商品首页
    @RequestMapping("addProductIndex")
    public String addProductIndex(Model model, HttpSession session) {
        if (session.getAttribute("admin") == null)
            return "redirect:adminLoginPage";
        List<Category> categories = categoryService.list();
        model.addAttribute("categories", categories);
        return "admin/addProductIndex";
    }
//    添加商品页面
    @RequestMapping("addProduct")
    public String addProduct(Model model, int cid, HttpSession session) {
        if (session.getAttribute("admin") == null)
            return "redirect:adminLoginPage";
        Category category = categoryService.get(cid);
        if (category == null)
            return "admin/error";
        model.addAttribute("category", category);
        return "admin/addProduct";
    }

//    下架
    @RequestMapping("unShelve")
    @ResponseBody
    public String unShelve(@RequestParam("pid") int pid, HttpSession session) {
        if (session.getAttribute("admin") == null)
            return "timeout";
        Product product;
        try {
            product = productService.get(pid);
        } catch (Exception e) {
            e.printStackTrace();
            return "no";
        }
//        将display设置为2代表下架
        product.setDisplay(2);
        productService.update(product);
        return "yes";
    }
    //    上架
    @RequestMapping("shelve")
    @ResponseBody
    public String shelve(@RequestParam("pid") int pid, HttpSession session) {
        if (session.getAttribute("admin") == null)
            return "timeout";
        Product product;
        try {
            product = productService.get(pid);
        } catch (Exception e) {
            e.printStackTrace();
            return "no";
        }
//        将display设置为1代表上架
        product.setDisplay(1);
        productService.update(product);
        return "yes";
    }
//    删除商品
    @RequestMapping("adminDeleteProduct")
    @ResponseBody
    public String delete(@RequestParam("pid") int pid, HttpSession session) {
        if (session.getAttribute("admin") == null)
            return "timeout";
        Product product;
        try {
            product = productService.get(pid);
        } catch (Exception e) {
            e.printStackTrace();
            return "no";
        }
//        将display设置为3代表删除
        product.setDisplay(3);
        productService.update(product);
        return "yes";
    }
//    显示已删除商品
    @RequestMapping("showDelete")
    public String showDelete(Model model,int cid, Page page,String sort, HttpSession session) {
        if (session.getAttribute("admin") == null)
            return "redirect:adminLoginPage";
        Category category = categoryService.get(cid);
        if (category == null)
            return "admin/error";
        page.setCount(10);
        PageHelper.offsetPage(page.getStart(), page.getCount());
        List<Product> products = productService.list(cid, 3, sort);
//        获取商品总数
        int total = (int) new PageInfo<Product>(products).getTotal();
//        总数设置给分页page
        page.setTotal(total);
//        商品分页是基于当前分类下的分页，所以需要传递cid
        page.setParam("&cid=" + category.getId());
        model.addAttribute("products", products);
        model.addAttribute("category", category);
        model.addAttribute("page", page);
        return "admin/listProduct";
    }
    //    恢复
    @RequestMapping("restore")
    @ResponseBody
    public String restore(@RequestParam("pid") int pid, HttpSession session) {
        if (null == session.getAttribute("admin"))
            return "timeout";
        Product product;
        try {
            product = productService.get(pid);
        } catch (Exception e) {
            e.printStackTrace();
            return "no";
        }
//        将display设置为2代表下架
        product.setDisplay(2);
        productService.update(product);
        return "yes";
    }
//    编辑商品信息（先显示原有产品信息）
    @RequestMapping("adminEditProduct")
    public String edit(Model model, int id, HttpSession session) {
        if (session.getAttribute("admin") == null)
            return "redirect:adminLoginPage";
        Product product = productService.get(id);
        if (product == null)
            return "admin/error";
        Category category = categoryService.get(product.getCid());
        product.setCategory(category);
//        根据原价、优惠价计算出折扣
        float discount = product.getDiscountPrice()/product.getOriginalPrice()*10;
        DecimalFormat df = new DecimalFormat("#.0");
        String flag = df.format(discount);
        discount = Float.parseFloat(flag);
//        去掉折扣前缀
        product.setTitle(product.getTitle().substring(6));
        model.addAttribute("discount", (int)discount);
        model.addAttribute("product", product);
        return "admin/editProduct";
    }

//    更新商品信息
    @RequestMapping("adminUpdateProduct")
    public String update(Product product, int discount, HttpSession session) {
        if (session.getAttribute("admin") == null)
            return "redirect:adminLoginPage";
        float discountPrice = product.getOriginalPrice() * discount / 10;
        product.setDiscountPrice(discountPrice);
        product.setTitle("【"+discount+"折优惠】"+product.getTitle());
        productService.update(product);
        return "redirect:adminListProduct?cid=" + product.getCid();
    }

//    商品列表（该分类下的商品列表）
    @RequestMapping("adminListProduct")
    public String list(int cid, Model model, Page page, HttpSession session) {
        if (session.getAttribute("admin") == null)
            return "redirect:adminLoginPage";
        Category category = categoryService.get(cid);
        if (category == null)
            return "admin/error";
        page.setCount(10);
        PageHelper.offsetPage(page.getStart(), page.getCount());
        List<Product> products = productService.list(cid);
//        获取商品总数
        int total = (int) new PageInfo<Product>(products).getTotal();
//        总数设置给分页page
        page.setTotal(total);
//        商品分页是基于当前分类下的分页，所以需要传递cid
        page.setParam("&cid=" + category.getId());

        model.addAttribute("products", products);
        model.addAttribute("category", category);
        model.addAttribute("page", page);
        model.addAttribute("normal", "normal");
        return "admin/listProduct";
    }
//    商品列表首页
    @RequestMapping("adminProductIndex")
    public String productIndex(Model model, HttpSession session) {
        if (session.getAttribute("admin") == null)
            return "redirect:adminLoginPage";
        List<Category> categories = categoryService.list();
        model.addAttribute("categories", categories);
        return "admin/listProductIndex";
    }
    @RequestMapping("searchCategoryProduct")
    public String searchCategoryProduct(@RequestParam("keyword") String keyword, Model model) {
        List<Category> categories = categoryService.searchCategory(keyword);
        model.addAttribute("categories", categories);
        model.addAttribute("keyword", keyword);
        return "admin/listProductIndex";
    }
    @RequestMapping("searchProduct")
    public String searchProduct(@RequestParam("keyword") String keyword, int cid, Page page, Model model) {
        Category category = categoryService.get(cid);
        if (category == null)
            return "admin/error";
        page.setCount(10);
        PageHelper.offsetPage(page.getStart(), page.getCount());
        List<Product> products = productService.searchProduct(cid, keyword);
        int total = (int) new PageInfo<Product>(products).getTotal();
        page.setTotal(total);

        page.setParam("&cid=" + category.getId());
        model.addAttribute("products", products);
        model.addAttribute("keyword", keyword);
        model.addAttribute("category", category);
        model.addAttribute("page", page);
        model.addAttribute("normal", "normal");
        return "admin/listProduct";
    }
}
