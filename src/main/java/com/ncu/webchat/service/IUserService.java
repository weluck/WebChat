package com.ncu.webchat.service;

import com.ncu.webchat.pojo.User;

import java.util.List;

public interface IUserService {
    List<User> selectAll(int page, int pageSize);
    List<String> selectAllFriend(String userid);
    User selectUserByUserid(String userid);
    List<User> selectUsers(String userid,String sex);
    int selectCount(int pageSize);
    boolean insert(User user);
    boolean insertFriend(String userid,String friendid);
    boolean update(User user);
    boolean delete(String userid);
    boolean deleteFriend(String userid,String friendid);
    String getProfileheadByid(String userid);
}
