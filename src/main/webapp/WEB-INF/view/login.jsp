<%--
  Created by IntelliJ IDEA.
  User: fenglin
  Date: 2019/12/11
  Time: 19:12
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!--path是web项目的根路径 -->
<%String path = request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
  <title>聊天室 | 登陆</title>
  <link href="<%=path%>/static/source/css/login.css" rel='stylesheet' type='text/css' />
  <script src="<%=path%>/static/plugins/jquery/jquery-2.1.4.min.js"></script>
  <script src="<%=path%>/static/plugins/layer/layer.js"></script>
</head>
<body>

<h1>聊天室</h1>
<div class="login-form">

  <div class="clear"> </div>
  <div class="avtar"><img src="<%=path%>/static/source/img/th(1).jpg" /></div>
  <!--onsubmit 为表单提交的时候的事件 -->
  <form id="login-form" action="<%=path%>/user/login" method="post" onsubmit="return checkLoginForm()">
    <div class="key">
      <input type="text" id="username" name="userid" placeholder="请输入账号" >
    </div>

    <div class="key" >
      <input type="password" id="password" name="password" placeholder="请输入密码">
    </div>
    <div class="signin">
      <input type="submit" id="submit" value="登录" >
    </div>
  </form>
  <form id="register" action="<%=path%>/user/register">
    <div class="signin">
      <input type="button" id="button" value="注册" onclick="resgister()" >
    </div>
  </form>
  <form id="Visitorlogin" action="<%=path%>/user/visitorlogin">
    <div class="signin">
      <input type="button" style="background-color: silver" id="Visitorloginbutton" value="游客登录" onclick="Visitorlogin()" >
    </div>
  </form>
</div>

<script>
  function resgister() {
      $("#register").submit();
      //window.location.href="register";
  }
function Visitorlogin(){
    $("#Visitorlogin").submit();
}
  $(function(){
    <c:if test="${not empty param.timeout}">
      layer.msg('连接超时,请重新登陆!', {
        offset: 0,
        shift: 6
      });
    </c:if>

    if("${error}"){
      $('#submit').attr('value',"${error}").css('background','red');
    }

    if("${message}"){
      layer.msg('${message}', {
        offset: 0,
      });
    }

    $('.close').on('click', function(c){
      $('.login-form').fadeOut('slow', function(c){
        $('.login-form').remove();
      });
    });

    $('#username,#password').change(function(){
      $('#submit').attr('value','登录').css('background','#3ea751');
    });
  });

  /**
   * check the login form before user login.
   * @returns {boolean}
   */
  function checkLoginForm(){
    var username = $('#username').val();
    var password = $('#password').val();
    if(isNull(username) && isNull(password)){
      $('#submit').attr('value','请输入账号和密码!!!').css('background','red');
      return false;
    }
    if(isNull(username)){
      $('#submit').attr('value','请输入账号!!!').css('background','red');
      return false;
    }
    if(isNull(password)){
      $('#submit').attr('value','请输入密码!!!').css('background','red');
      return false;
    }
    //if(username != 'Amaya' || password != '123456'){
    //	$('#submit').attr('value','账号或密码错误!!!').css('background','red');
    //	return false;
    //}
    else{
      $('#submit').attr('value','登陆中~');
      return true;
    }
  }

  /**
   * check the param if it's null or '' or undefined
   * @param input
   * @returns {boolean}
   */
  function isNull(input){
    if(input == null || input == '' || input == undefined){
      return true;
    }
    else{
      return false;
    }
  }
</script>
</body>
</html>