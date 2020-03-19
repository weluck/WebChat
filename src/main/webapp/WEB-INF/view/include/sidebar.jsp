<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!-- sidebar start -->
<div class="admin-sidebar am-offcanvas" id="admin-offcanvas">
    <div class="am-offcanvas-bar admin-offcanvas-bar">
        <ul class="am-list admin-sidebar-list">
            <li><a href="${ctx}/chat"><span class="am-icon-commenting"></span> 聊天</a></li>
            <li><a href="${ctx}/${userid}" class="am-cf"><span class="am-icon-book"></span> 个人信息<span class="am-icon-star am-fr am-margin-right admin-icon-yellow"></span></a></li>
            <li><a href="${ctx}/${userid}/config"><span class="am-icon-group"></span> 个人设置</a></li>
            <li><a href="${ctx}/${userid}/log"><span class="am-icon-inbox"></span> 系统日志<span class="am-badge am-badge-secondary am-margin-right am-fr"></span></a></li>
            <%--<li><a href="${ctx}/${userid}/notice"><span class="am-icon-bell"></span> 通知<span class="am-badge am-badge-danger am-margin-right am-fr am-round">2</span></a></li>--%>

            <li><a href="${ctx}/user/logout"><span class="am-icon-sign-out"></span> 注销</a></li>
        </ul>
        <div class="am-panel am-panel-default admin-sidebar-panel">
            <div class="am-panel-bd">
                <p><span class="am-icon-tag"></span> Welcome</p>
                <p>来了来了~</p>
            </div>
        </div>
    </div>
</div>
<!-- sidebar end -->