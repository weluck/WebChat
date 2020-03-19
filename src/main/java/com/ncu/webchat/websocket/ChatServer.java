package com.ncu.webchat.websocket;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

import com.ncu.webchat.service.IUserService;
import com.ncu.webchat.utils.MyEndpointConfigure;
import org.springframework.beans.factory.annotation.Autowired;

import com.ncu.webchat.dao.ChatRecordDao;
import com.ncu.webchat.pojo.ChatRecord;
import com.ncu.webchat.service.VistorService;

import javax.annotation.Resource;

import javax.servlet.http.HttpSession;
import javax.websocket.*;
import javax.websocket.server.ServerEndpoint;
import java.io.IOException;

import java.text.SimpleDateFormat;

import java.util.*;
import java.util.concurrent.CopyOnWriteArraySet;

/**
 * 注解是一个类层次的注解，它的功能主要是将目前的类定义成一个websocket服务器端,
 * * 注解的值将被用于监听用户连接的终端访问URL地址,客户端可以通过这个URL来连接到WebSocket服务器端
 * websocket服务
 *
 */

@ServerEndpoint(value = "/chatServer", configurator = MyEndpointConfigure.class)
public class ChatServer {
    @Resource
    private IUserService iUserService;
    @Resource
    private VistorService vistorService;
    @Autowired
    private ChatRecordDao chatRecordDao;
  @Autowired
//    @Resource
    private IUserService userService;



    private static int onlineCount = 0; //静态变量，用来记录当前在线连接数。应该把它设计成线程安全的。
    private static CopyOnWriteArraySet<ChatServer> webSocketSet = new CopyOnWriteArraySet<ChatServer>();//类似于HashSet
    private Session session;    //与某个客户端的连接会话，需要通过它来给客户端发送数据
    private String userid;      //用户名
    private HttpSession httpSession;    //request的session

    private static List list = new ArrayList();   //在线列表,记录用户名称
    private static Map routetab = new HashMap();  //用户名和websocket的session绑定的路由表

    /**
     * 连接建立成功调用的方法
     *
     * @param session 可选的参数。session为与某个客户端的连接会话，需要通过它来给客户端发送数据
     */
    @OnOpen
    public void onOpen(Session session, EndpointConfig config){

        int flag=0;

        this.session = session;
        webSocketSet.add(this);     //加入set中
        addOnlineCount();           //在线数加1;
        this.httpSession = (HttpSession) config.getUserProperties().get(HttpSession.class.getName());

        this.userid=(String) httpSession.getAttribute("userid");    //获取当前用户
        //验证SESSION中是否已经存在该用户
        for (Iterator it = list.iterator(); it.hasNext(); ) {
            if (it.next() == this.userid) {
                flag = 1;
            }
        }
        if (flag == 1) {
            String message = getMessage("[" + userid + "]加入聊天室,当前在线人数为" + getOnlineCount() + "位", "notice", list);
            broadcast(message);     //广播
        } else {
            list.add(userid);           //将用户名加入在线列表
            routetab.put(userid, session);   //将用户名和session绑定到路由表
            String message = getMessage("[" + userid + "]加入聊天室,当前在线人数为" + getOnlineCount() + "位", "notice", list);
            broadcast(message);     //广播
        }


    }

    /**
     * 连接关闭调用的方法
     */
    @OnClose
    public void onClose() {

//        if (iUserService.selectUserByUserid(userid).getStatus() == 2) {
//            vistorService.logoutvistor(iUserService.selectUserByUserid(userid));
//        }
        webSocketSet.remove(this);  //从set中删除
        subOnlineCount();           //在线数减1
        list.remove(userid);        //从在线列表移除这个用户
        routetab.remove(userid);
        String message = getMessage("[" + userid + "]离开了聊天室,当前在线人数为" + getOnlineCount() + "位", "notice", list);
        broadcast(message);         //广播
    }

    /**
     * 接收客户端的message,判断是否有接收人而选择进行广播还是指定发送
     *
     * @param _message 客户端发送过来的消息
     */
    @OnMessage
    public void onMessage(String _message) {
        JSONObject chat = JSON.parseObject(_message);
        JSONObject message = JSON.parseObject(chat.get("message").toString());
        if (message.get("to") == null || message.get("to").equals("")) {      //如果to为空,则广播;如果不为空,则对指定的用户发送消息
            broadcast(_message);
        } else {
            String[] userlist = message.get("to").toString().split(",");
            singleSend(_message, (Session) routetab.get(message.get("from")));      //发送给自己,这个别忘了
            for (String user : userlist) {
                if (!user.equals(message.get("from"))) {
                    ChatRecord chatRecord = new ChatRecord();
                    chatRecord.setFirstperson(message.get("from").toString());
                    chatRecord.setSecondperson(user);
                    String mes = message.get("content").toString();
                    chatRecord.setContent(message.get("content").toString());
                    SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                    chatRecord.setTime(df.format(new Date()));
                    chatRecord.setState("1");
                    chatRecordDao.insertChatRecordByid(chatRecord);
                    chatRecord.setFirstperson(user);
                    chatRecord.setSecondperson(message.get("from").toString());
                    chatRecord.setContent(message.get("content").toString());
                    chatRecord.setTime(df.format(new Date()));
                    chatRecord.setState("2");
                    chatRecordDao.insertChatRecordByid(chatRecord);
                    singleSend(_message, (Session) routetab.get(user));     //分别发送给每个指定用户
                }
            }
        }
    }

    /**
     * 发生错误时调用
     *
     * @param error
     */
    @OnError
    public void onError(Throwable error) {
        error.printStackTrace();
    }

    /**
     * 广播消息
     */
    public void broadcast(String message) {

        for (Iterator<String> it = list.iterator(); it.hasNext(); ) {
            singleSend(message, (Session) routetab.get(it.next()));
        }

//        for(ChatServer chat: webSocketSet){
//            try {
//                chat.session.getBasicRemote().sendText(message);
//            } catch (IOException e) {
//                e.printStackTrace();
//                continue;
//            }
//        }
    }

    /**
     * 对特定用户发送消息
     *
     * @param message
     * @param session
     */
    public void singleSend(String message, Session session) {
        try {
            session.getBasicRemote().sendText(message);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    /**
     * 组装返回给前台的消息
     *
     * @param message 交互信息
     * @param type    信息类型
     * @param list    在线列表
     * @return
     */
    public String getMessage(String message, String type, List list) {
        JSONObject member = new JSONObject();
        member.put("message", message);
        member.put("type", type);
        member.put("list", list);
        return member.toString();
    }

    public int getOnlineCount() {
        return onlineCount;
    }

    public void addOnlineCount() {
        ChatServer.onlineCount++;
    }

    public void subOnlineCount() {
        ChatServer.onlineCount--;
    }
}
