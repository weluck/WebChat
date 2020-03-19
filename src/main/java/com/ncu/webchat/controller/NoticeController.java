package com.ncu.webchat.controller;

import com.ncu.webchat.pojo.Notice;
import com.ncu.webchat.service.INoticeService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

/**
 */
@Controller
@RequestMapping(value = "")
public class NoticeController {
    @Resource
    private INoticeService noticeService;

    @RequestMapping(value = "{userid}/notice", method = RequestMethod.GET)
    public String checkNotice(Model model){
        return "notice";
    }

    @RequestMapping(value = "{userid}/notice", method = RequestMethod.POST)
    @ResponseBody
    public List<Notice> getNotice(@PathVariable("userid") String userid){
        List<Notice> noticeList = new ArrayList<Notice>();
        System.out.println(userid);
        noticeList = noticeService.selectNoticeByUserid(userid);
        return noticeList;
    }

    @RequestMapping(value = "{userid}/deleteNotice", method = RequestMethod.POST)
    @ResponseBody
    public List<Notice> deleteNotice(String fromUserid){
        System.out.println(fromUserid);
        boolean bool =  noticeService.deleteNotice(fromUserid);
        System.out.println(bool);
        return null;
    }

    @RequestMapping(value = "{userid}/addNotice", method = RequestMethod.POST)
    @ResponseBody
    public List<Notice> addNotice(String fromUserid,@PathVariable("userid") String toUserid){
        System.out.println(fromUserid+toUserid);
        String content = "请求添加你为好友";
        boolean bool =  noticeService.addNotice(toUserid,fromUserid,content);
        System.out.println(bool);
        return null;
    }

    @RequestMapping(value = "{userid}/getNoticeNum", method = RequestMethod.POST)
    @ResponseBody
    public String getNoticeNum(@PathVariable("userid") String toUserid){
        return noticeService.getNoticeNum(toUserid);
    }

}
