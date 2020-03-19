package com.ncu.webchat.serviceImpl;

import com.ncu.webchat.dao.IUserDao;
import com.ncu.webchat.pojo.User;
import com.ncu.webchat.service.IUserService;

import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service(value = "userService")
public class UserServiceImpl implements IUserService {

    @Resource
    private IUserDao userDao;

    @Override
    public List<User> selectAll(int page, int pageSize) {
        return userDao.selectAll(page, pageSize);
    }

    @Override
    public List<String> selectAllFriend(String userid) {
        return userDao.selectAllFriend(userid);
    }

    @Override
    public User selectUserByUserid(String userid) {
        return userDao.selectUserByUserid(userid);
    }

    @Override
    public List<User>  selectUsers(String userid,String sex) {
        return userDao.selectUsers(userid,sex);
    }

    @Override
    public int selectCount(int pageSize) {
        int pageCount = Integer.parseInt(userDao.selectCount().getUserid());
        return pageCount % pageSize == 0 ? pageCount/pageSize : pageCount/pageSize + 1;
    }

    @Override
    public boolean insert(User user) {
        return userDao.insert(user);
    }

    @Override
    public boolean insertFriend(String userid,String friendid) {
        return userDao.insertFriend(userid,friendid);
    }

    @Override
    public boolean update(User user) {
        return userDao.update(user);
    }

    @Override
    public boolean delete(String userid) {
        return userDao.delete(userid);
    }

    @Override
    public boolean deleteFriend(String userid,String friendid) {
        return userDao.deleteFriend(userid,friendid);
    }

    @Override
    public String getProfileheadByid(String userid) {
        return userDao.getProfileheadById(userid);
    }
}
