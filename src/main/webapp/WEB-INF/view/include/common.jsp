<%--
  Created by IntelliJ IDEA.
  User: iamso
  Date: 2019/12/10
  Time: 13:49
  To change this template use File | Settings | File Templates.
--%>
<% String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() ;
    request.setAttribute("basePath", basePath);%>