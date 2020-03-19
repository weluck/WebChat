package com.ncu.webchat.service;

import com.ncu.webchat.pojo.ChatRecord;

import java.util.List;

public interface ChatRecordService {
    /**
     * 传入两个用户ID查找聊天记录
     */
    List<ChatRecord> searchChatRecord(ChatRecord chatRecord);

    /**
     * 插入用户的聊天记录
     */
    int insertChatRecordByid(ChatRecord chatRecord);
    /**
     * 根据第一人名字删除聊天记录
     */
    int deleteChatRecordByFirstPerson(String firstperson);

    /**
     * 根据第二人名字删除聊天记录
     */
    int deleteChatRecordBySecondPerson(String secondperson);
}
