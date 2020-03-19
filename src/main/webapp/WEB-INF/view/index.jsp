<%--
  Created by IntelliJ IDEA.
  User: iamso
  Date: 2019/12/13
  Time: 18:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<html>
<head>
    <title>聊天室 | 聊天</title>
    <jsp:include page="include/commonfile.jsp"/>
    <%--自定义样式覆盖amaze默认样式--%>
    <link href="${ctx}/static/source/css/index.css" rel='stylesheet' type='text/css' />
    <script src="${ctx}/static/plugins/sockjs/sockjs.js"></script>

    <style>
        .personal-info-title {
            font-size: 22.5px;
            margin-top: 65px;
        }
        .personal-info {
            list-style: none;
            padding: 0;
        }
        ul.personal-info li {
            margin-bottom: 9px;
            padding-left: 75px;
            position: relative;
            height: 30px;
            font-size: 12.5px;
        }
        .personal-info span {
            background: #111111;
            padding: 4px 10px 5px;
            color: #fff;
            display: inline-block;
            margin-left: 9px;
            height: 30px;
            /*text-transform: capitalize;*/
        }

        .personal-info label {
            position: absolute;
            left: 0;
            width: 75px;
            top: 0;
            bottom: 0;
            /*min-width: 75px;*/
            font-size: 12.5px;
            font-weight: 600;
            background: #f4d03f;
            margin-right: 10px;
            padding: 4px 10px 5px;
            margin: 0;
        }
        .description {
            height: 300px;
            position: relative;
            background-color: #fff;
            padding: 10px 30px;
            overflow: hidden;
        }

        .description p {
            margin: 0px 0px;
            padding-right: 75px;
        }

        #msg-box { border: 1px solid black; width: 500px; height: 350px; display: none; float: left; padding: 10px }
    </style>
</head>
<body onload="getFriendList()">
<jsp:include page="include/header.jsp"/>
<div class="am-cf admin-main">
    <jsp:include page="include/sidebar.jsp"/>

    <!-- content start -->
    <div class="admin-content">
        <input type="hidden" id="userid" value=<%=request.getSession().getAttribute("userid")%>/>
        <div class="" style="width: 80%;float:left;">
            <div id="msg-box" style="float: right;position: absolute;z-index: 1">
                <div class="description hidden">
                    <h3 class="personal-info-title title">好友简介</h3>
                    <ul class="personal-info">
                        <li><label>网名</label>&nbsp;&nbsp;<span id="userinfoname"></span></li>
                        <li><label>性别</label>&nbsp;&nbsp;<span id="userinfosex"></span></li>
                        <li><label>邮箱</label>&nbsp;&nbsp;<span id="userinfoemail"></span></li>
                        <li><label>个签</label>&nbsp;&nbsp;<span id="userinfoprofile"></span></li>
                    </ul>
                </div>
            </div>
            <!-- 聊天区 -->
            <div class="am-scrollable-vertical" id="chat-view" style="height: 510px;z-index: -1;">
                <ul class="am-comments-list am-comments-list-flip" id="chat">
                </ul>
            </div>
            <!-- 输入区 -->
            <div class="am-form-group am-form">
                <textarea class="" id="message" name="message" rows="5" placeholder="这里输入你想发送的信息..."></textarea>
            </div>
            <!-- 接收者 -->
            <div class="" style="float: left">
                <p class="am-kai">发送给 : <span id="sendto">全体成员</span>
                    <button class="am-btn am-btn-xs am-btn-danger" onclick="reAll()">复位</button>
                </p>
            </div>
            <!-- 按钮区 -->
            <div class="am-btn-group am-btn-group-xs" style="float:right;">
                <span><button class="am-btn am-btn-default" style="padding: .3em;" type="button" onclick="getConnection()"><span
                        class="am-icon-plug"></span> 连接
                </button></span>
                <span><button class="am-btn am-btn-default" style="padding: .3em;" type="button" onclick="closeConnection()"><span
                        class="am-icon-remove"></span> 断开
                </button></span>
                <span><button class="am-btn am-btn-default" style="padding: .3em;" type="button" onclick="checkConnection()"><span
                        class="am-icon-bug"></span> 检查
                </button></span>
                <span><button class="am-btn am-btn-default" style="padding: .3em;" type="button" onclick="clearConsole()"><span
                        class="am-icon-trash-o"></span> 清屏
                </button></span>
                <span id="record" hidden>
                <button id="rec" class="am-btn am-btn-default" style="padding: .3em;" type="button" onclick="chatRecord()"><span
                        class="am-icon-commenting"></span> 聊天记录
                </button>
                <button id="dowRec" class="am-btn am-btn-default" style="padding: .3em;" type="button" onclick="downloadchatRecord()"><span
                        class="am-icon-commenting"></span> 下载聊天记录
                </button>
                <button id="delRec" class="am-btn am-btn-default" style="padding: .3em;" type="button" onclick="deletechatRecord()"><span
                        class="am-icon-commenting"></span> 删除聊天记录
                </button>
                </span>
                <span><button class="am-btn am-btn-default" style="padding: .3em; background-color:#5eb95e; color: white" type="button" onclick="sendMessage()"><span
                        class="am-icon-commenting"></span> 发送
                </button></span>
            </div>

        </div>
        <!-- 列表区 -->
        <div class="am-panel am-panel-default" id="onlinelist" style="float:right;width: 20%;">
            <div class="am-panel-hd">
                <h3 class="am-panel-title">在线列表 [<span id="onlinenum"></span>]</h3>
            </div>

            <ul class="am-list am-list-static am-list-striped" id="list">
            </ul>
            <div class="am-panel-hd">
                <h3 class="am-panel-title">好友列表 [<span id="friendnum"></span>]</h3>
                <button class="add-btn"  onclick="addFriend()"></button>
            </div>
            <ul class="am-list am-list-static am-list-striped" id="friendlist">
            </ul>
        </div>
    </div>
    <!-- content end -->
</div>
<a href="#" class="am-show-sm-only admin-menu" data-am-offcanvas="{target: '#admin-offcanvas'}">
    <span class="am-icon-btn am-icon-th-list"></span>
</a>
<jsp:include page="include/footer.jsp"/>

<script>
    function reAll(){
         var sendto = $("#sendto");
         sendto.text("全体成员");
         clearConsole();
         document.getElementById("record").hidden = true;
    }
    $(function () {
        context.init({preventDoubleContext: false});
        context.settings({compress: true});
        context.attach('#chat-view', [
            {header: '操作菜单'},
            {text: '清理', action: clearConsole},
            {divider: true},
            {
                text: '选项', subMenu: [
                    {header: '连接选项'},
                    {text: '检查', action: checkConnection},
                    {text: '连接', action: getConnection},
                    {text: '断开', action: closeConnection},

                ]
            },
            {
                text: '销毁菜单', action: function (e) {
                    e.preventDefault();
                    context.destroy('#chat-view');
                }
            }
        ]);
    });
    if ("${message}") {
        layer.msg('${message}', {
            offset: 0
        });
    }
    if ("${error}") {
        layer.msg('${error}', {
            offset: 0,
            shift: 6
        });
    }
    var wsServer = null;
    var ws = null;
    wsServer = "ws://" + location.host + "${pageContext.request.contextPath}" + "/chatServer";
    ws = new WebSocket(wsServer); //创建WebSocket对象
    ws.onopen = function (evt) {
        layer.msg("已经建立连接", {offset: 0});
    };
    ws.onmessage = function (evt) {
        analysisMessage(evt.data);  //解析后台传回的消息,并予以展示
    };
    ws.onerror = function (evt) {
        layer.msg("产生异常", {offset: 0});
    };
    ws.onclose = function (evt) {
        layer.msg("已经关闭连接", {offset: 0});
    };

    /**
     * 连接
     */
    function getConnection() {
        if (ws == null) {
            ws = new WebSocket(wsServer); //创建WebSocket对象
            ws.onopen = function (evt) {
                layer.msg("成功建立连接!", {offset: 0});
            };
            ws.onmessage = function (evt) {
                analysisMessage(evt.data);  //解析后台传回的消息,并予以展示
            };
            ws.onerror = function (evt) {
                layer.msg("产生异常", {offset: 0});
            };
            ws.onclose = function (evt) {
                layer.msg("已经关闭连接", {offset: 0});
            };
        } else {
            layer.msg("连接已存在!", {offset: 0, shift: 6});
        }
    }

    /**
     * 关闭连接
     */
    function closeConnection() {
        if (ws != null) {
            ws.close();
            ws = null;
            $("#list").html("");    //清空在线列表
            layer.msg("已经关闭连接", {offset: 0});
        } else {
            layer.msg("未开启连接", {offset: 0, shift: 6});
        }
    }

    /**
     * 检查连接
     */
    function checkConnection() {
        if (ws != null) {
            layer.msg(ws.readyState == 0 ? "连接异常" : "连接正常", {offset: 0});
        } else {
            layer.msg("连接未开启!", {offset: 0, shift: 6});
        }
    }

    /**
     * 显示聊天记录
     * **/
    function chatRecord() {
        var secondperson = $("#sendto").text();
        console.log(secondperson);
        var firstperson = $("#userid").val();
        console.log(firstperson);
        if (secondperson != "全体成员" && firstperson != null) {
            $.ajax({
                type: 'post',
                url: '/chatrecord/search/' + firstperson + '/' + secondperson,
                success: function (data) {
                    clearConsole();
                    var json = eval(data);
                    $.each(json, function (index, item) {
                        var firstperson = json[index].firstperson;
                        var secondperson = json[index].secondperson;
                        var content = json[index].content;
                        var state = json[index].state;
                        var time = json[index].time;
                        var userProfile;
                        if (state == '1') {
                            $.ajax({
                                async: false,
                                url: "${pageContext.request.contextPath}/getUserProfile",
                                data: {'userId':firstperson},
                                success: function (data1) {
                                    userProfile = data1;
                                },
                                error: function () {
                                }
                            });
                            var html = "<li class=\"am-comment " + "am-comment-flip" + " am-comment-primary\"><img width=\"48\" height=\"48\" class=\"am-comment-avatar\" alt=\"\" src=\"${ctx}/static/profilehead/" + userProfile + "\"><div class=\"am-comment-main\">\n" +
                                "<header class=\"am-comment-hd\"><div class=\"am-comment-meta\">   <a class=\"am-comment-author\" >" + firstperson + "</a> 发表于<time> " + time + "</time> 发送给: " + secondperson + " </div></header><div class=\"am-comment-bd\"> <p>" + content + "</p></div></div></li>";
                            $("#chat").append(html);
                        } else {
                            $.ajax({
                                async: false,
                                url: "${pageContext.request.contextPath}/getUserProfile",
                                data: {'userId':secondperson},
                                success: function (data1) {
                                    userProfile = data1;
                                },
                                error: function () {
                                }
                            });
                            var html = "<li class=\"am-comment " + "" + " am-comment-primary\"><img width=\"48\" height=\"48\" class=\"am-comment-avatar\" alt=\"\" src=\"${ctx}/static/profilehead/" + userProfile + "\"><div class=\"am-comment-main\">\n" +
                                "<header class=\"am-comment-hd\"><div class=\"am-comment-meta\">   <a class=\"am-comment-author\">" + secondperson + "</a> 发表于<time> " + time + "</time> 发送给: " + firstperson + " </div></header><div class=\"am-comment-bd\"> <p>" + content + "</p></div></div></li>";
                            $("#chat").append(html);
                        }

                    });

                    console.log(data)

                }
            })
        }


    }

    /**
     *删除聊天记录
     **/
    function deletechatRecord() {
        var secondperson = $("#sendto").text();
        console.log(secondperson);
        var firstperson = $("#userid").val();
        console.log(firstperson);
        $.ajax({
            type: 'post',
            url: '${ctx}/chatrecord/deleterecord/' + firstperson + '/' + secondperson,
            success: function () {
                console.log(删除成功);
            }
        });
    }

    /**
     * 下载聊天记录到本地
     * */
    function downloadchatRecord() {
        var secondperson = $("#sendto").text();
        console.log(secondperson);
        var firstperson = $("#userid").val();
        console.log(firstperson);
        window.location.href = "${ctx}/chatrecord/downloadFile/" + firstperson + "/" + secondperson;
        // $.ajax({
        //
        //     url: "/chatrecord/downloadFile/"+firstperson+'/'+secondperson,
        //     success:function () {
        //         console.log("下载完成")
        //     }
        //
        //
        // })

    }

    /**
     * 发送信息给后台
     */
    function sendMessage() {
        if (ws == null) {
            layer.msg("连接未开启!", {offset: 0, shift: 6});
            return;
        }
        var message = $("#message").val();
        var to = $("#sendto").text() == "全体成员" ? "" : $("#sendto").text();
        if (message == null || message == "") {
            layer.msg("请不要惜字如金!", {offset: 0, shift: 6});
            return;
        }
        if(message.length >= 140){
            layer.msg("字数请限制在140以下!", {offset: 0, shift: 6});
            return;
        }
        $("#tuling").text() == "已上线" ? tuling(message) : console.log("图灵机器人未开启");  //检测是否加入图灵机器人
        ws.send(JSON.stringify({
            message: {
                content: message,
                from: '${userid}',
                to: to,      //接收人,如果没有则置空,如果有多个接收人则用,分隔
                time: getDateFull()
            },
            type: "message"
        }));
    }

    /**
     * 解析后台传来的消息
     * "massage" : {
     *              "from" : "xxx",
     *              "to" : "xxx",
     *              "content" : "xxx",
     *              "time" : "xxxx.xx.xx"
     *          },
     * "type" : {notice|message},
     * "list" : {[xx],[xx],[xx]}
     */
    function analysisMessage(message) {
        message = JSON.parse(message);
        if (message.type == "message") {      //会话消息
            showChat(message.message);
        }
        if (message.type == "notice") {       //提示消息
            showNotice(message.message);
        }
        if (message.list != null && message.list != undefined) {      //在线列表
            showOnline(message.list);
        }
        if(message.friendlist != null && message.friendlist != undefined){      //好友列表
            showFriend(message.friendlist);
        }
    }

    /**
     * 展示提示信息
     */
    function showNotice(notice) {
        $("#chat").append("<div><p class=\"am-text-success\" style=\"text-align:center\"><span class=\"am-icon-bell\"></span> " + notice + "</p></div>");
        var chat = $("#chat-view");
        chat.scrollTop(chat[0].scrollHeight);   //让聊天区始终滚动到最下面
    }

    /**
     * 展示会话信息
     */
    function showChat(message) {
        var to = message.to == null || message.to == "" ? "全体成员" : message.to;   //获取接收人
        var isSef = '${userid}' == message.from ? "am-comment-flip" : "";   //如果是自己则显示在右边,他人信息显示在左边
        var userProfile;
        $.ajax({
            async: false,
            url: "${pageContext.request.contextPath}/getUserProfile",
            data: {'userId':message.from},
            success: function (data) {
                userProfile = data;
            },
            error: function () {
            }
        });
        var html = "<li class=\"am-comment " + isSef + " am-comment-primary\"><img width=\"48\" height=\"48\" class=\"am-comment-avatar\" alt=\"\" src=\"${ctx}/static/profilehead/" + userProfile + "\"><div class=\"am-comment-main\">\n" +
            "<header class=\"am-comment-hd\"><div class=\"am-comment-meta\">   <a class=\"am-comment-author\">" + message.from + "</a> 发表于<time> " + message.time + "</time> 发送给: " + to + " </div></header><div class=\"am-comment-bd\"> <p>" + message.content + "</p></div></div></li>";
        $("#chat").append(html);
        $("#message").val("");  //清空输入区
        var chat = $("#chat-view");
        chat.scrollTop(chat[0].scrollHeight);   //让聊天区始终滚动到最下面
    }

    /**
     * 展示在线列表
     */
    function showOnline(list) {
        $("#list").html("");    //清空在线列表

        $.each(list, function(index, item){     //添加私聊按钮
            var li = "<li>"+item+"</li>";
            var userProfile;
            $.ajax({
                async: false,
                url: "${pageContext.request.contextPath}/getUserProfile",
                data: {'userId':item},
                success: function (data) {
                    userProfile = data;
                },
                error: function () {
                }
            });
            if('${userid}' != item){    //排除自己
                li = "<li><img onmouseover=\"showmes('" + item + "');\" onmouseout=\"hidemes();\" width='40px' height='40px' class='avatar' src=\"${ctx}/static/profilehead/"
                    + userProfile + "\" >"+item;

            }
            $("#list").append(li);
        });
        $("#onlinenum").text($("#list li").length);     //获取在线人数
    }

    /**
     * 展示好友列表
     */
    function getFriendList() {
        var friendlist;
        $.ajax({
            type: 'POST',
            url: '/friend/getFriend?userid=${userid}',
            // data: data,
            success: function (data) {
                console.log("相关信息"+data);
                friendlist = data;
                showFriend(friendlist);
            },
            error: function () {
              console("69567845865487")
            }
        });
    }
    /**
     * 跳转至用户个人信息界面
     */
    function showUser(userId) {
        window.location.href="${ctx} /info/"+userId;
    }
    function showFriend(friendlist){
        var userProfile;
        $("#friendlist").html("");    //清空好友列表
        $.each(friendlist, function(index, item){     //添加私聊按钮
            var li = "<li>"+item+"</li>";
            if('${userid}' != item){    //排除自己
                $.ajax({
                    async: false,
                    url: "${pageContext.request.contextPath}/getUserProfile",
                    data: {'userId':item},
                    success: function (data) {
                        userProfile = data;
                    },
                    error: function () {
                    }
                });
                li = "<li class='friendlist'><img onmouseover=\"showmes('" + item + "');\" onmouseout=\"hidemes();\""+" onclick=\"addChat('"+item
                    +"')\" width='40px' height='40px' class='avatar' src=\"${ctx}/static/profilehead/" + userProfile + "\">"
                    +"<span "+"onclick=\"showUser('"+item+"');\"" +">"+item+"</span>"+" <button class=\"delete-btn\" " +
                    " onclick=\"deleteFriend('"+item+"')\"></button></li>" ;
            }
            $("#friendlist").append(li);
        });
        $("#friendnum").text($("#friendlist li").length);     //获取好友人数
    }

    function deleteFriend(friendid) {
        $.ajax({
            type: 'POST',
            url: '${ctx}/friend/deleteFriend?userid=${userid}&friendid='+friendid,
            // data: data,
            success: function (data) {
                getFriendList();
            }
        });
    }
    /**
     * 迷你资料卡展示信息
     * */
    function showmes(data) {
        var width = $("#onlinelist").width();
        $("#msg-box").css("right",width);
        $.ajax({
            type: 'post',
            url: ${ctx}data+'/showuserinfo' ,
            success: function (mes) {
                var json = eval(mes);
                $.each(json, function (index, item) {
                    var userid = json[index].userid;
                    var sex = json[index].sex;
                    var email = json[index].email;
                    var profile = json[index].profile;
                    document.getElementById("userinfoname").innerHTML = userid;
                    //$("#userinfoname").style.backgroundColor = 'red';

                    if (sex==1){
                        document.getElementById("userinfosex").innerHTML = '男';
                    } else if(sex==2){
                        document.getElementById("userinfosex").innerHTML = '女';
                    }else{
                        document.getElementById("userinfosex").innerHTML = '未知';
                    }
                    document.getElementById("userinfoemail").innerHTML = email.toLowerCase();
                    document.getElementById("userinfoprofile").innerHTML = profile;

            });
        }
        });
        $("#msg-box").toggle();
    }
/**
 *
 * */
    function hidemes() {
    $("#msg-box").toggle();
}

    /**
     * 添加接收人
     */
    function addChat(user) {
        chatRecord();
        document.getElementById("record").hidden = false;
        var sendto = $("#sendto");
        var receive = sendto.text() == "全体成员" ? "" : sendto.text() + ",";
        if (receive.indexOf(user) == -1) {    //排除重复
            sendto.text(user);
        }
    }

    /**
     * 清空聊天区
     */
    function clearConsole() {
        $("#chat").html("");
    }

    function appendZero(s) {
        return ("00" + s).substr((s + "").length);
    }  //补0函数

    function getDateFull() {
        var date = new Date();
        var currentdate = date.getFullYear() + "-" + appendZero(date.getMonth() + 1) + "-" + appendZero(date.getDate()) + " " + appendZero(date.getHours()) + ":" + appendZero(date.getMinutes()) + ":" + appendZero(date.getSeconds());
        return currentdate;
    }

    /**
     * 添加好友
     */
    function addFriend() {
        layer.closeAll();
        layer.open({
            type: 2,
            title: '添加好友',
            offset: '100px',
            area: ['800px', '400px'],
            shade:false,
            content: '${ctx}/friend/addFriend'
        });
    }
    function showdelte() {
        if(document.getElementById("sendto").innerText != "全体成员"){
            document.getElementById("quanti")
        }
    }
</script>
</body>
</html>
