package com.ncu.webchat.serviceImpl;

import com.ncu.webchat.dao.ChatRecordDao;
import com.ncu.webchat.pojo.ChatRecord;
import com.ncu.webchat.service.ChatRecordService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class ChatRecordServiceImpl implements ChatRecordService {
    @Autowired
    private ChatRecordDao chatRecordDao;
    @Override
    public List<ChatRecord> searchChatRecord(ChatRecord chatRecord) {
        return chatRecordDao.searchChatRecord(chatRecord);
    }

    @Override
    public int insertChatRecordByid(ChatRecord chatRecord) {
        return chatRecordDao.insertChatRecordByid(chatRecord);
    }

    @Override
    public int deleteChatRecordByFirstPerson(String firstperson) {
        return chatRecordDao.deleteChatRecordByFirstPerson(firstperson);
    }

    @Override
    public int deleteChatRecordBySecondPerson(String secondperson) {
        return chatRecordDao.deleteChatRecordBySecondPerson(secondperson);
    }
}
