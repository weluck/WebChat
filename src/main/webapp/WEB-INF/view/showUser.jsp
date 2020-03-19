<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>WebChat | 好友信息</title>
    <jsp:include page="include/commonfile.jsp"/>
</head>
<body
>
<jsp:include page="include/header.jsp"/>
<div class="am-cf admin-main">
    <jsp:include page="include/sidebar.jsp"/>

    <!-- content start -->
    <div class="admin-content">
        <div class="am-cf am-padding">
            <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">好友信息</strong> / <small>info</small></div>
        </div>
        <div class="am-tabs am-margin" data-am-tabs>
            <ul class="am-tabs-nav am-nav am-nav-tabs">
                <li class="am-active"><a href="#tab1">好友信息</a></li>
            </ul>
            <div class="am-tabs-bd">
                <div class="am-tab-panel am-fade am-in am-active" id="tab1">
                    <div class="am-g" style="background-color: #caebfb;">
                        <c:set value="${user}" var="user"/>
                        <div class="am-g" style="transform: translate(44%,0px);">
                            <img class="am-circle" src="${ctx}/static/profilehead/${user.profilehead}" width="140" height="140" alt="${user.nickname}"/>
                        </div>
                        <div class="am-g" style="transform: translate(48%,0px);">
                            ${user.nickname}
                        </div>
                        <div class="am-g" style="transform: translate(47%,0px);">
                            <c:if test="${user.sex == null || user.sex == ''}">未知</c:if>
                            <c:if test="${user.sex != null && user.sex != ''}">
                                <c:if test="${user.sex == 1}">男</c:if>
                                <c:if test="${user.sex == 0}">女</c:if>
                                <c:if test="${user.sex == -1}">保密</c:if>
                            </c:if> &nbsp;&nbsp;|&nbsp;&nbsp;
                            <c:if test="${user.age == null || user.age == ''}">未知</c:if>
                            <c:if test="${user.age != null && user.age != ''}">${user.age}</c:if>
                        </div>
                    </div>
                </div>
            </div>
            <div class="am-tabs-bd">
                <div class="am-tab-panel am-fade am-in am-active" id="tab2">
                    <div class="am-g">
                        <div class="am-u-md-3" style="padding: 15px;font-size: 20px;"><b>好友简介:</b></div>
                        <div class="am-u-md-9" style="padding: 15px ;font-size: 20px;">
                            <c:if test="${user.profile == null || user.profile == ''}">
                                这个人很懒,什么都没有留下!
                            </c:if>
                            <c:if test="${user.profile != null && user.profile != ''}">
                                ${user.profile}
                            </c:if>
                        </div>
                    </div>
                    <div class="am-g">
                        <div class="am-u-md-3" style="padding: 15px ;font-size: 20px;"><b>注册时间</b></div>
                        <div class="am-u-md-9" style="padding: 15px ;font-size: 20px;">${user.firsttime}</div>
                    </div>
                    <div class="am-g">
                        <div class="am-u-md-3" style="padding: 15px ;font-size: 20px;"><b>最后登录</b></div>
                        <div class="am-u-md-9" style="padding: 15px ;font-size: 20px;">${user.lasttime}</div>
                    </div>
                    <div class="am-g">
                        <div class="am-u-md-3" style="padding: 15px ;font-size: 20px;"><b>好友印象</b></div>
                        <div style="margin-left: 20px;font-size: 32px; color: slateblue;" id="impressionOld">${user.impression}</div>
                    </div>
                    <div class="am-tabs-bd">
                        <div class="am-tab-panel am-fade am-in am-active" id="tab4">
                            <c:set value="${user}" var="user"/>
                            <form class="am-form am-form-horizontal"  id="information-form" action="${ctx}/info/${user.userid}/update" method="post" data-am-validator>
                                <div class="am-form-group">
                                    <label for="impression"></label>
                                    <input placeholder="添加好友印象" type="text" id="impression" name="impression">
                                </div>
                                <div class="am-form-group">
                                        <button type="submit" onclick="return updateInfo()"  class="am-btn am-round am-btn-success"><span class="am-icon-send"></span> 提交</button>
                                </div>
                            </form>
                        </div>
                    </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>

<!-- content end -->
</div>
<a href="#" class="am-show-sm-only admin-menu" data-am-offcanvas="{target: '#admin-offcanvas'}">
    <span class="am-icon-btn am-icon-th-list"></span>
</a>
<script type="text/javascript">
    /**
     * 好友印象添加
     * */
    function updateInfo() {
        var impression1=document.getElementById("impression").value;
        if(impression1.length>=11){
            alert("好友印象不宜太长超过11个字符");
            return false;
        }
        if(impression1.length==0){
            alert("好友印象有空项\n");
            return false;
        }
         var impression=document.getElementById("impressionOld").innerText + "&nbsp;&nbsp;#" +impression1;
        document.getElementById("impression").value = impression;
        return true;
    }
    /**
     * 好友印象颜色更改
     * */
    function randomColor() {	//16进制方式表示颜色0-F
        var arrHex = ["0","1","2","3","4","5","6","7","8","9","A","B","C","D","E","F"];
        var strHex = "#";
        var index;
        for(var i = 0; i < 6; i++) {	//取得0-15之间的随机整数
            index = Math.round(Math.random() * 15);
            strHex += arrHex[index];
        }
        return strHex;
    }
    function changeColor(){
        var links = document.getElementsByClassName("impress");
        for(var i=0;i<links.length;i++){
            var bgColor = randomColor();//改变背景色的代码
            links[i].style.backgroundColor = "white";
        }
    }
    changeColor();
</script>
<jsp:include page="include/footer.jsp"/>
</body>
</html>
