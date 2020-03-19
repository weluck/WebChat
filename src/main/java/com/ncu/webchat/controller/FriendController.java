package com.ncu.webchat.controller;

import com.ncu.webchat.pojo.User;
import com.ncu.webchat.service.IUserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/friend")
public class FriendController {
    @Resource
    private IUserService userService;

    @RequestMapping("/addFriend")
    public String addFriend(Model model){
        return "addFriend";
    }

    //获取好友列表
    @RequestMapping(value = "/getFriend", method = RequestMethod.POST)
    @ResponseBody
    public List<String> getFriend(@RequestParam("userid") String userid){
        List<String> friendlist = new ArrayList<String>();   //在线列表,记录用户名称
        friendlist = userService.selectAllFriend(userid);
        for( Object object : friendlist){
            System.out.println(object);
        }
        return friendlist;
    }

    @RequestMapping(value = "/searchFriend", method = RequestMethod.POST)
    @ResponseBody
    public List<User> searchFriend(@RequestParam("userid") String userid,@RequestParam("sex") String sex){
        List<User> userList = new ArrayList<User>();
        userList = userService.selectUsers(userid,sex);
//        userList.add(user);
        return userList;
    }

    @RequestMapping(value = "/insertFriend", method = RequestMethod.POST)
    @ResponseBody
    public List<User> insertFriend(String fromUserid, String toUserid){
        boolean bool1 = userService.insertFriend(fromUserid,toUserid);
        boolean bool2 = userService.insertFriend(toUserid,fromUserid);
        System.out.println(bool1);
        return null;
    }

    @RequestMapping(value = "/deleteFriend", method = RequestMethod.POST)
    @ResponseBody
    public List<User> deleteFriend(@RequestParam("userid") String userid,@RequestParam("friendid") String friendid){
        boolean bool1 = userService.deleteFriend(userid,friendid);
        boolean bool2 = userService.deleteFriend(friendid,userid);
        System.out.println(bool1);
        return null;
    }
}
