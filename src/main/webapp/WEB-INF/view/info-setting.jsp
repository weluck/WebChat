<%--
  Created by IntelliJ IDEA.
  User: fenglin
  Date: 2019/12/11
  Time: 19:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>聊天室 | 个人设置</title>
    <jsp:include page="include/commonfile.jsp"/>
</head>
<body>
<jsp:include page="include/header.jsp"/>
<div class="am-cf admin-main">
    <jsp:include page="include/sidebar.jsp"/>

    <!-- content start -->
    <div class="admin-content">

        <div class="am-cf am-padding">
            <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">个人设置</strong> / <small>form</small></div>
        </div>

        <div class="am-tabs am-margin" data-am-tabs>
            <ul class="am-tabs-nav am-nav am-nav-tabs">
                <li class="am-active"><a href="#tab1">基本信息</a></li>
                <li><a href="#tab2">修改头像</a></li>
                <li><a href="#tab3">修改密码</a></li>
                <%--<li><a href="#tab4">好友印象</a> </li>--%>
            </ul>

            <div class="am-tabs-bd">
                <div class="am-tab-panel am-fade am-in am-active" id="tab1">
                    <c:set value="${user}" var="user"/>
                    <form class="am-form am-form-horizontal" id="information-form" action="${ctx}/${userid}/update" method="post" data-am-validator>
                        <div class="am-form-group">
                            <label for="userid" class="am-u-sm-2 am-form-label">用户名</label>
                            <div class="am-u-sm-10">
                                <input type="text" id="userid" name="userid" value="${user.userid}" disabled>
                            </div>
                        </div>

                        <div class="am-form-group">
                            <label for="nickname" class="am-u-sm-2 am-form-label">昵称</label>
                            <div class="am-u-sm-10">
                                <input type="text" id="nickname" name="nickname" value="${user.nickname}" required placeholder="这里输入你的昵称...">
                            </div>
                        </div>

                        <div class="am-form-group">
                            <label for="sex" class="am-u-sm-2 am-form-label" >性别</label>
                            <div class="am-u-sm-10" >
                                <select id="sex" name="sex" data-am-selected >
                                    <option selected></option>
                                    <option value="1">男</option>
                                    <option value="2">女</option>
                                </select>
                            </div>
                            <script>
                                $('#sex').find('option').eq(${user.sex}).attr('selected', true);
                            </script>
                        </div>
                        <div class="am-form-group">
                            <label for="age" class="am-u-sm-2 am-form-label">年龄</label>
                            <div class="am-u-sm-10">
                                <input type="number" id="age" name="age" min="1" max="100" value="${user.age}" placeholder="这里输入你的年龄...">
                            </div>
                        </div>

                        <div class="am-form-group">
                            <label for="nickname" class="am-u-sm-2 am-form-label">电子邮箱</label>
                            <div class="am-u-sm-10">
                                <input type="email" id="email" name="email" value="${user.email}" required placeholder="这里输入你的电子邮箱...">
                            </div>
                        </div>

                        <div class="am-form-group">
                            <label for="profile" class="am-u-sm-2 am-form-label">个性签名</label>
                            <div class="am-u-sm-10">
                                <textarea class="" id="profile" name="profile" rows="5" placeholder="这里可以写下你的个性签名..."></textarea>
                            </div>
                            <script>
                                $("#profile").val("${user.profile}");
                            </script>
                        </div>
                        <div class="am-form-group">
                            <div class="am-u-sm-10 am-u-sm-offset-2">
                                <button type="submit" onclick="return updateInfo()"  class="am-btn am-round am-btn-success"><span class="am-icon-send"></span> 提交</button>
                            </div>
                        </div>
                    </form>
                </div>

                <div class="am-tab-panel am-fade" id="tab2">
                    <form class="am-form am-form-horizontal" action="${ctx}/${userid}/upload" enctype="multipart/form-data" method="post" onsubmit="return checkFileType();" style="text-align: center;">
                        <div style="text-align: center;margin-bottom: 10px">
                            <img class="am-circle" src="${ctx}/static/profilehead/${user.profilehead}" width="140" height="140" alt="Amayadream"/>
                        </div>
                        <div class="am-form-group am-form-file">
                            <button type="button" class="am-btn am-btn-secondary am-btn-sm">
                                <i class="am-icon-cloud-upload"></i> 选择要上传的文件</button>
                            <input id="file" type="file" name="file" multiple>
                        </div>
                        <div id="file-list"></div>
                        <button type="submit" onclick="return updateInfo()"  class="am-btn am-round am-btn-success"><span class="am-icon-upload"></span> 上传头像</button>
                        <script>
                            $(function() {
                                $('#file').on('change', function() {
                                    var fileNames = '';
                                    $.each(this.files, function() {
                                        fileNames += '<span class="am-badge">' + this.name + '</span> ';
                                    });
                                    $('#file-list').html(fileNames);
                                });
                            });
                        </script>
                    </form>
                </div>

                <div class="am-tab-panel am-fade" id="tab3">
                    <form class="am-form am-form-horizontal" data-am-validator action="${ctx}/${userid}/pass" method="post">
                        <div class="am-form-group">
                            <label for="password1" class="am-u-sm-2 am-form-label">原密码</label>
                            <div class="am-u-sm-10">
                                <input type="password" id="password1" name="oldpass" required placeholder="请输入原密码...">
                            </div>
                        </div>

                        <div class="am-form-group">
                            <label for="password2" class="am-u-sm-2 am-form-label">新密码</label>
                            <div class="am-u-sm-10">
                                <input type="password" id="password2" name="newpass" required placeholder="请输入新密码...">
                            </div>
                        </div>

                        <div class="am-form-group">
                            <label for="password3" class="am-u-sm-2 am-form-label">确认新密码</label>
                            <div class="am-u-sm-10">
                                <input type="password" id="password3" data-equal-to="#password2" required placeholder="请确认新密码...">
                            </div>
                        </div>

                        <div class="am-form-group">
                            <div class="am-u-sm-10 am-u-sm-offset-2">
                                <button type="submit" onclick="return updateInfo()"  class="am-btn am-round am-btn-success"><span class="am-icon-send"></span> 提交修改</button>
                            </div>
                        </div>
                    </form>
                </div>

                <%--<div class="am-tab-panel am-fade am-in am-active" id="tab4">--%>
                    <%--<c:set value="${user}" var="user"/>--%>
                    <%--<form class="am-form am-form-horizontal" id="information-form" action="${ctx}/${userid}/update" method="post" data-am-validator>--%>

                        <%--<div class="am-form-group">--%>
                            <%--<label for="impression1" class="am-u-sm-2 am-form-label">好友印象1</label>--%>
                            <%--<div class="am-u-sm-10">--%>
                                <%--<input type="text" id="impression1" name="impression1" value="${user.impression1}">--%>
                            <%--</div>--%>
                        <%--</div>--%>

                        <%--<div class="am-form-group">--%>
                            <%--<label for="impression2" class="am-u-sm-2 am-form-label">好友印象2</label>--%>
                            <%--<div class="am-u-sm-10">--%>
                                <%--<input type="text" id="impression2" name="impression2" value="${user.impression2}">--%>
                            <%--</div>--%>
                        <%--</div>--%>

                        <%--<div class="am-form-group">--%>
                            <%--<label for="impression3" class="am-u-sm-2 am-form-label">好友印象3</label>--%>
                            <%--<div class="am-u-sm-10">--%>
                                <%--<input type="text" id="impression3" name="impression3" value="${user.impression3}">--%>
                            <%--</div>--%>
                        <%--</div>--%>

                        <%--<div class="am-form-group">--%>
                            <%--<label for="impression4" class="am-u-sm-2 am-form-label">好友印象4</label>--%>
                            <%--<div class="am-u-sm-10">--%>
                                <%--<input type="text" id="impression4" name="impression4" value="${user.impression4}">--%>
                            <%--</div>--%>
                        <%--</div>--%>

                        <%--<div class="am-form-group">--%>
                            <%--<label for="impression5" class="am-u-sm-2 am-form-label">好友印象5</label>--%>
                            <%--<div class="am-u-sm-10">--%>
                                <%--<input type="text" id="impression5" name="impression5" value="${user.impression5}">--%>
                            <%--</div>--%>
                        <%--</div>--%>

                        <%--<div class="am-form-group">--%>
                            <%--<label for="impression6" class="am-u-sm-2 am-form-label">好友印象6</label>--%>
                            <%--<div class="am-u-sm-10">--%>
                                <%--<input type="text" id="impression6" name="impression6" value="${user.impression6}">--%>
                            <%--</div>--%>
                        <%--</div>--%>

                        <%--<div class="am-form-group">--%>
                            <%--<div class="am-u-sm-10 am-u-sm-offset-2">--%>
                                <%--<button type="submit" onclick="return updateInfo()"  onclick="return updateInfo()"  class="am-btn am-round am-btn-success"><span class="am-icon-send"></span> 提交</button>--%>
                            <%--</div>--%>
                        <%--</div>--%>
                    <%--</form>--%>
                <%--</div>--%>
            </div>
        </div>
    </div>
    <!-- content end -->
</div>
<a href="#" class="am-show-sm-only admin-menu" data-am-offcanvas="{target: '#admin-offcanvas'}">
    <span class="am-icon-btn am-icon-th-list"></span>
</a>
<jsp:include page="include/footer.jsp"/>
<script>
    function check() {
        var userEmail = document.getElementById("email").value;
        if(userEmail.length==0)
            s+="用户邮箱为空\n";
        else if (userEmail == "") {
        } else {
            var reg = /^\w+((-\w+)|(\.\w+))*@[A-Za-z0-9]+(([.\-])[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/;
            isok = reg.test(userEmail);
            if (!isok) {
                alert("邮箱格式不正确，请重新输入！");
                return false;
            }
            else {
                return true;
            }
        }
    }
</script>
<script>
    if("${message}"){
        layer.msg('${message}', {
            offset: 0
        });
    }
    if("${error}"){
        layer.msg('${error}', {
            offset: 0,
            shift: 6
        });
    }

    function checkFileType(){
        var format = ["bmp","jpg","gif","png"];
        var filename = $("#file").val();
        var ext = filename.substring(filename.lastIndexOf('.') + 1).toLowerCase();
        if(jQuery.inArray(ext, format) != -1){
            return true;
        }else{
            layer.msg('头像格式只能是bmp,jpg,gif,png!', {
                offset: 0,
                shift: 6
            });
            return false;
        }
    }
    function updateInfo() {
        var flag=check();
        if(!flag)
            return false;
        var nickname=document.getElementById("nickname").value;
        var profile=document.getElementById("profile").value;
        var password2=document.getElementById("password2").value;
        var password3=document.getElementById("password3").value;
        var impression1=document.getElementById("impression1").value;
        var impression2=document.getElementById("impression2").value;
        var impression3=document.getElementById("impression3").value;
        var impression4=document.getElementById("impression4").value;
        var impression5=document.getElementById("impression5").value;
        var impression6=document.getElementById("impression6").value;
        if(nickname.length>=20){
            alert("您的昵称有点长\n不宜超过20个字符");
            return false;
        }
        if(profile.length>=50){
            alert("您的签名太长了，请简短精悍点\n不宜超过50个字符");
            return false;
        }

        if(password2.length>=30||password3.length>=30){
            alert("密码不宜过长超过30个字符");
            return false;
        }
        if(impression1.length>=11||impression2.length>=11||impression3.length>=11||
            impression4.length>=11||impression5.length>=11||impression6.length>=11){
            alert("好友印象不宜太长超过11个字符");
            return false;
        }
        if(impression1.length==0||impression2.length==0||impression3.length==0||
            impression4.length==0||impression5.length==0||impression6.length==0){
            alert("好友印象有空项\n");
            return false;
        }
        return true;
    }
</script>
</body>
</html>
