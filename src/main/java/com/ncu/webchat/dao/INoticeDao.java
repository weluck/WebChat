package com.ncu.webchat.dao;

import com.ncu.webchat.pojo.Notice;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface INoticeDao {
//    List<Notice> selectAll(int page, int pageSize);
    List<Notice> selectNoticeByUserid(String userid);
    String getNoticeNum(String userid);
    boolean deleteNotice(String userid);
    boolean addNotice(@Param("toUserid")String toUserid, @Param("fromUserid")String fromUserid, @Param("content")String content);
//    int selectCount(int pageSize);
//    boolean insert(Notice user);
//    boolean update(Notice user);
//    boolean delete(String userid);
}
