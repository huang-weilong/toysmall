package com.weilong.mall.pojo;

public class User {
    private Integer id;

    private String username;

    private String password;

    private String tel;

//    非数据库字段
    private String code;

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username == null ? null : username.trim();
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password == null ? null : password.trim();
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel == null ? null : tel.trim();
    }

    public String getAnonymousName(){
        char[] name =username.toCharArray();
        char[] middle_name = new char[10];
        if (name.length < 9) {
            for (int i = 1; i < name.length-1; i++) {
                name[i]='*';
            }
        } else {
            middle_name[0] = name[0];
            middle_name[1] = name[1];
            middle_name[8] = name[name.length-2];
            middle_name[9] = name[name.length-1];
            for (int i=2 ; i < 8; i++) {
                middle_name[i] = '*';
            }
            name = middle_name;
        }
        return new String(name);
    }
}