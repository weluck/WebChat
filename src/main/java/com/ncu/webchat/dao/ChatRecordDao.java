package com.ncu.webchat.dao;

import com.ncu.webchat.pojo.ChatRecord;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Service;

import java.util.List;
@Service(value = "ChatRecordDao")
public interface ChatRecordDao {
    /**
     * 传入两个用户ID查找聊天记录
     */
     List<ChatRecord> searchChatRecord(ChatRecord chatRecord);

    /**
     * 插入用户的聊天记录
     */
     int insertChatRecordByid(ChatRecord chatRecord);

    /**
     * 根据双方名字删除聊天记录
     */
     int deleteChatRecordByid(@Param("firstperson") String firstperson, @Param("secondperson") String secondperson);

    /**
     * 根据第一人名字删除聊天记录
     */
     int deleteChatRecordByFirstPerson(String firstperson);

    /**
     * 根据第二人名字删除聊天记录
     */
     int deleteChatRecordBySecondPerson(String secondperson);
}
