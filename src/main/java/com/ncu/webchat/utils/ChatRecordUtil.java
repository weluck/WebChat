package com.ncu.webchat.utils;

import com.ncu.webchat.pojo.ChatRecord;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.List;

public class ChatRecordUtil {

    public String storechatrecord(String id1, String id2,List<ChatRecord> chatRecords) throws IOException {
        System.out.println("zhongwen-------------------");
        String path = "D:/tomcat/webapps/upload/webchat/" + id1;
        File f1 = new File(path);//新建一个文件对象，如果不存在则创建一个该文件
        FileWriter fw;

        f1.mkdir();
        String path1 = path + "/" + id1 + id2 + ".txt";
        File f = new File(path1);
        try {
            fw = new FileWriter(f);
            for (ChatRecord chatRecord : chatRecords) {
                if (chatRecord.getState().equals("1")) {
                    fw.write(" 接收人 ： " + chatRecord.getFirstperson());
                    fw.write(" 发送人 ： " + chatRecord.getSecondperson());
                }
                else {
                    fw.write(" 接收人 ： " + chatRecord.getSecondperson());
                    fw.write(" 发送人 ： " + chatRecord.getFirstperson());
                }
                fw.write(" 内容 ： "+chatRecord.getContent());
                fw.write(" 发送时间 ： "+chatRecord.getTime());
                fw.write('\n');
            }
            fw.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return path1;
    }
}
