package com.weilong.mall.util;

import org.springframework.web.multipart.MultipartFile;

public class UploadedImageFile {
    //jsp页面中增加分类的input标签的type="file"的name值要和image一致
    MultipartFile image;

    public MultipartFile getImage() {
        return image;
    }

    public void setImage(MultipartFile image) {
        this.image = image;
    }
}
