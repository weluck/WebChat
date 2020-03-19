package com.ncu.webchat.service;

import com.ncu.webchat.pojo.Notice;

import java.util.List;

public interface INoticeService {
    List<Notice> selectAll(int page, int pageSize);

    List<Notice> selectNoticeByUserid(String userid);
    String getNoticeNum(String userid);
    boolean deleteNotice(String userid);
    boolean addNotice(String toUserid,String fromUserid,String content);
    int selectCount(int pageSize);
    boolean update(Notice user);
    boolean delete(String userid);
}
