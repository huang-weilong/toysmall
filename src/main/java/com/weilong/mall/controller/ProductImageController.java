package com.weilong.mall.controller;

import com.weilong.mall.pojo.Product;
import com.weilong.mall.pojo.ProductImage;
import com.weilong.mall.service.ProductImageService;
import com.weilong.mall.service.ProductService;
import com.weilong.mall.util.ImageUtil;
import com.weilong.mall.util.UploadedImageFile;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpSession;
import java.awt.image.BufferedImage;
import java.io.File;
import java.util.List;

@Controller
@RequestMapping("")
public class ProductImageController {
    @Autowired
    ProductService productService;
    @Autowired
    ProductImageService productImageService;

//    添加图片
    @RequestMapping("adminAddProductImage")
    public String add(ProductImage productImage, HttpSession session, UploadedImageFile uploadedImageFile) {
        if (session.getAttribute("admin") == null)
            return "redirect:adminLoginPage";
//        从jsp页面会获得产品id和图片类型，插入数据库中
        productImageService.add(productImage);
//        图片用图片id来命名
        String fileName = productImage.getId() + ".jpg";
        String imageFolder;
        String imageFolderSmall = null;
        if (ProductImageService.type_goods.equals(productImage.getType())) {
//            定位存放商品图片的路径，商品图片分尺寸存放
            imageFolder = session.getServletContext().getRealPath("images/goods");
            imageFolderSmall = session.getServletContext().getRealPath("images/goods_small");
        }
        else {
//            商品详情图片
            imageFolder = session.getServletContext().getRealPath("images/detail");
        }

        File imageFile = new File(imageFolder, fileName);
        imageFile.getParentFile().mkdirs();
        try {
//            保存上传的文件
            uploadedImageFile.getImage().transferTo(imageFile);
            BufferedImage image = ImageUtil.changeToJpg(imageFile);
            ImageIO.write(image, "jpg", imageFile);
            if (ProductImageService.type_goods.equals(productImage.getType())) {
                File imageFileSmall = new File(imageFolderSmall, fileName);
//                产品图片需要生成新尺寸的图片
                ImageUtil.resizeImage(imageFile, 340, 340, imageFile);
                ImageUtil.resizeImage(imageFile, 80, 80, imageFileSmall);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "redirect:adminListProductImage?pid=" + productImage.getPid();
    }

//    删除图片
    @RequestMapping("adminDeleteProductImage")
    @ResponseBody
    public String delete(int imageId, HttpSession session) {
        if (session.getAttribute("admin") == null)
            return "timeout";
        ProductImage productImage = productImageService.get(imageId);
        if (productImage == null)
            return "no";
        String fileName = productImage.getId() + ".jpg";
        String imageFolder;
        String imageFolderSmall;

//        产品图片需要删除2张
        if (ProductImageService.type_goods.equals(productImage.getType())) {
            imageFolder = session.getServletContext().getRealPath("images/goods");
            imageFolderSmall = session.getServletContext().getRealPath("images/goods_small");
            File imageFile = new File(imageFolder, fileName);
            File imageFileSmall = new File(imageFolderSmall, fileName);
            imageFile.delete();
            imageFileSmall.delete();
        }
//        详情图片删除1张
        else {
            imageFolder = session.getServletContext().getRealPath("images/detail");
            File imageFile = new File(imageFolder, fileName);
            imageFile.delete();
        }
//        删除数据库中的内容
        productImageService.delete(imageId);
        return "yes";
    }

//    查询图片列表
    @RequestMapping("adminListProductImage")
    public String list(@RequestParam("pid") int pid, Model model, HttpSession session) {
        if (session.getAttribute("admin") == null)
            return "redirect:adminLoginPage";
//        获取产品对象
        Product product;
        try {
            product = productService.get(pid);
        }catch (Exception e) {
            e.printStackTrace();
            return "admin/error";
        }
//        根据产品id查出图片信息
        List<ProductImage> productImageListGoods = productImageService.list(pid, productImageService.type_goods);
        List<ProductImage> productImageListDetail = productImageService.list(pid, productImageService.type_detail);

        model.addAttribute("product", product);
        model.addAttribute("productImageListGoods", productImageListGoods);
        model.addAttribute("productImageListDetail",productImageListDetail);

        return "admin/listProductImage";
    }
}
