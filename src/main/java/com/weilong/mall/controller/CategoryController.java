package com.weilong.mall.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.weilong.mall.pojo.Category;
import com.weilong.mall.pojo.Order;
import com.weilong.mall.service.CategoryService;
import com.weilong.mall.util.ImageUtil;
import com.weilong.mall.util.Page;
import com.weilong.mall.util.UploadedImageFile;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpSession;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.List;

@Controller
@RequestMapping("")
public class CategoryController {
    @Autowired
    CategoryService categoryService;

//    分类列表
    @RequestMapping("adminListCategory")
    public String list(Model model, Page page, HttpSession session) {
        if (session.getAttribute("admin") == null)
            return "redirect:adminLoginPage";
//        page.setCount(10);
//        PageHelper.offsetPage(page.getStart(), page.getCount());
        List<Category> categories = categoryService.list();
//        int total = (int) new PageInfo<Category>(categories).getTotal();
//        page.setTotal(total);
        model.addAttribute("categories", categories);
//        model.addAttribute("page", page);
        return "admin/listCategory";
    }

//    增加分类
    @RequestMapping("adminAddCategory")
    public String add(Category category, HttpSession session, UploadedImageFile uploadedImageFile) throws IOException {
        if (session.getAttribute("admin") == null)
            return "redirect:adminLoginPage";
//        category接收页面提交的名称，session获取当前路径，uploadedImageFile接收上传的图片
        categoryService.add(category);
        File imageFolder = new File(session.getServletContext().getRealPath("images/category"));
        File file = new File(imageFolder, category.getId()+".jpg");
//        文件路径不存在，则创建文件目录
        if (!file.getParentFile().exists())
            file.getParentFile().mkdirs();
        uploadedImageFile.getImage().transferTo(file);
        BufferedImage img = ImageUtil.changeToJpg(file);
        ImageIO.write(img, "jpg", file);
        ImageUtil.resizeImage(file,100,100,file);
        return "redirect:adminListCategory";
    }

    @RequestMapping("addCategory")
    public String addCategory(HttpSession session) {
        if (session.getAttribute("admin") == null)
            return "redirect:adminLoginPage";
        return "admin/addCategory";
    }

    @RequestMapping("adminDeleteCategory")
    public String delete(int id, HttpSession session) {
        if (session.getAttribute("admin") == null)
            return "redirect:adminLoginPage";
        try {
            categoryService.delete(id);
            File imageFolder = new File(session.getServletContext().getRealPath("images/category"));
            File file = new File(imageFolder, id+".jpg");
            file.delete();
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        return "redirect:adminListCategory";
    }

    @RequestMapping("adminEditCategory")
    public String edit(int id, Model model, HttpSession session) {
        if (session.getAttribute("admin") == null)
            return "redirect:adminLoginPage";
        Category category = categoryService.get(id);
        if (category == null)
            return "admin/error";
        model.addAttribute("category", category);
        return "admin/editCategory";
    }

    @RequestMapping("adminUpdateCategory")
    public String update(Category category, HttpSession session, UploadedImageFile uploadedImageFile) throws IOException {
        if (session.getAttribute("admin") == null)
            return "redirect:adminLoginPage";
        categoryService.update(category);
        MultipartFile image = uploadedImageFile.getImage();
//        判断是否有上传图片
        if (image != null && !image.isEmpty()) {
            File imageFolder = new File(session.getServletContext().getRealPath("images/category"));
            File file = new File(imageFolder, category.getId() + ".jpg");
            image.transferTo(file);
            BufferedImage img = ImageUtil.changeToJpg(file);
            ImageIO.write(img, "jpg", file);
            ImageUtil.resizeImage(file,100,100,file);
        }
        return "redirect:adminListCategory";
    }
    @RequestMapping("searchCategory")
    public String searchOrder(@RequestParam("keyword") String keyword, Model model) {
        List<Category> categories = categoryService.searchCategory(keyword);
        model.addAttribute("categories", categories);
        model.addAttribute("keyword", keyword);
        return "admin/listCategory";
    }
}
