package com.ncu.webchat.controller;

import com.ncu.webchat.dao.IUserDao;
import com.ncu.webchat.pojo.Bigdatames;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

@Controller

public class bigdatacontroller {
    @Resource
    private IUserDao iUserDao;

    @RequestMapping("/bigdata")
    @ResponseBody
    public List<Bigdatames> bigdata() {
        List<Bigdatames> bigdatames = new ArrayList<Bigdatames>();
        Bigdatames men = new Bigdatames();
        men.setName("男性用户");
        men.setNum(iUserDao.selectsex("1").toString());
        bigdatames.add(men);
        Bigdatames women = new Bigdatames();
        women.setName("女性用户");
        women.setNum(iUserDao.selectsex("0").toString());
        bigdatames.add(women);
        return bigdatames;
    }

    @RequestMapping("/bigdatapage")
    public String page() {
        return "bigdata";
    }
}
