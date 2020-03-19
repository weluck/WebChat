package com.ncu.webchat.dao;

import com.ncu.webchat.pojo.User;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Service;

import java.util.List;

@Service(value = "userDao")
public interface IUserDao {
    List<User> selectAll(@Param("offset") int offset, @Param("limit") int limit);

    List<String> selectAllFriend(String userid);

    User selectUserByUserid(String userid);

    List<User> selectUsers(@Param("userid")String userid, @Param("sex")String sex);

    User selectCount();

    boolean insert(User user);

    boolean insertFriend(@Param("userid")String userid,@Param("friendid")String friendid);

    boolean update(User user);

    boolean delete(String userid);

    boolean deleteFriend(@Param("userid")String userid,@Param("friendid")String friendid);

    Long selectsex(@Param("sex")String sex);
    String getProfileheadById(@Param("userid")String userid);


}
