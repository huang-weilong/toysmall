package test;

import com.weilong.mall.pojo.Category;
import com.weilong.mall.service.CategoryService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:applicationContext.xml")
public class TestToysMall {
    @Autowired
    private CategoryService categoryService;

    @Test
    public void add(){
        Category category = new Category();
        for (int i=1;i<=10;i++){
            category.setName("category");
            categoryService.add(category);
        }
        List<Category> categories = categoryService.list();
        for (Category c : categories){
            System.out.println(c.getName());
        }

    }
    @Test
    public void random() {
        int a = (int)((Math.random()*9+1)*100000);
        String simpleDateFormat = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
        String aa =  String.valueOf(a)+simpleDateFormat;
        System.out.println(simpleDateFormat);
        System.out.println(aa);
    }
    @Test
    public void testSub() {
        String aa = "aa15";
//        aa="abcd".substring(1,3);
        System.out.println(aa);
    }
}
