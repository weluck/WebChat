package com.ncu.webchat.service;

import com.ncu.webchat.pojo.User;

public interface VistorService {
    /**
     * 插入游客信息
     * @return
     */
   int insertvistor(User user);

    /**
     * 游客注销或者退出的时候删除有关信息
     */
   void logoutvistor(User user);
}
