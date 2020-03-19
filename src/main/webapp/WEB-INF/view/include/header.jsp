<%--
  Created by IntelliJ IDEA.
  User: iamso
  Date: 2019/12/11
  Time: 18:29
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<style>
    .notice{
        float: right;
        position: absolute;
        top:15px;
        right: 150px;
        border: 0;
        outline: none;
        background-color:#f8f8f8;
    }
    .notice span{
        width: 25px;
        height: 25px;
    }
    #noticeNum{
        position: absolute;
        width: 20px;
        height: auto;
        right: -5px;
        top: 10px;
    }
</style>
<header class="am-topbar admin-header">
    <div class="am-topbar-brand">
        <i class="am-icon-weixin"></i> <strong>WebChat</strong> <small> 聊天室</small>
    </div>
    <div class="am-collapse am-topbar-collapse" id="topbar-collapse">
        <ul class="am-nav am-nav-pills am-topbar-nav am-topbar-right admin-header-list">
            <li class="am-dropdown" data-am-dropdown>
                <a class="am-dropdown-toggle" data-am-dropdown-toggle href="javascript:;">
                    ${userid} <span class="am-icon-caret-down"></span>
                </a>
                <ul class="am-dropdown-content">
                    <li><a href="${ctx}/${userid}"><span class="am-icon-user"></span> 资料</a></li>
                    <li><a href="${ctx}/${userid}/config"><span class="am-icon-cog"></span> 设置</a></li>
                    <li><a href="${ctx}/user/logout"><span class="am-icon-power-off"></span> 注销</a></li>
                </ul>
            </li>
        </ul>
        <button class="notice" onclick="checkNotice()">
            <span  class="am-icon-bell  am-icon-sm"></span>
            <span id="noticeNum" class="am-badge am-badge-danger am-round" style="display: none">0</span>
            <%--<span id="noticeNum" class="am-badge am-badge-danger am-margin-right am-fr am-round">2</span>--%>
        </button>
    </div>
</header>
<script>
    getNoticeNum();
    function checkNotice() {
        layer.closeAll();
        layer.open({
            type: 2,
            title: '查看通知',
            offset: '100px',
            area: ['800px', '400px'],
            shade:false,
            content: '${ctx}/${userid}/notice'
        });
    }

    function getNoticeNum(){
        $.ajax({
            type: 'POST',
            url: '/${userid}/getNoticeNum?=${userid}',
            success: function (data) {
                console.log(data);
                if(data!='0'){
                    $('#noticeNum').text(data);
                    $('#noticeNum').show();
                }
                else {
                    $('#noticeNum').hide();
                }
            }
        });
    }
    //消息3s轮询一次，或者websocket实现
    setInterval(function(){
        getNoticeNum();
    },3000);

</script>