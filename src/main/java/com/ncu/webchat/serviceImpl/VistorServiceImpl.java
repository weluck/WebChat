package com.ncu.webchat.serviceImpl;

import com.ncu.webchat.pojo.User;
import com.ncu.webchat.service.ChatRecordService;
import com.ncu.webchat.service.ILogService;
import com.ncu.webchat.service.IUserService;
import com.ncu.webchat.service.VistorService;
import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.io.File;
import java.io.IOException;

@Service(value = "vistorService")
public class VistorServiceImpl implements VistorService {
    @Resource
    private IUserService iUserService;
    @Resource
    private ChatRecordService chatRecordService;
    @Resource
    private ILogService iLogService;


    @Override
    public int insertvistor(User user) {
        return 0;
    }

    @Override
    public void logoutvistor(User user) {


        iLogService.deleteThisUser(user.getUserid());
        chatRecordService.deleteChatRecordByFirstPerson(user.getUserid());
        chatRecordService.deleteChatRecordBySecondPerson(user.getUserid());
        iUserService.delete(user.getUserid());
        String path = "E:/apache-tomcat-9.0.8/webapps/upload/webchat/"+user.getUserid();
        File file = new File(path);
        if(file.exists()){
            FileUtils fileUtils = new FileUtils();
            try {
                fileUtils.deleteDirectory(file);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

    }
}
