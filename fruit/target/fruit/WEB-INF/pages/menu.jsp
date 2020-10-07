<%@ page language="java" import="java.util.*" pageEncoding="utf-8" isELIgnored="false" %>
<div id="menuContent" style="background-color:#173e65;color:#ffffff;height:100px;">
   <h1 style="margin-left: 10px;margin-top:10px;">
           水果网络销售平台</h1><br/>
     <div style="margin-left: 10px;">
<%--     告知每页显示4条语句--%>
     <a href="${pageContext.request.contextPath}/commodities/findCommodities?page=1&size=4" >货物管理
     </a>|
     <a
             href="${pageContext.request.contextPath}/retailer/findAllRetailer?page=1&size=4&status1=-1">零售商管理</a>|
     <a href="${pageContext.request.contextPath}/contract/findAllContract?page=1&size=4">
         购销合同</a>|
     <a
             href="${pageContext.request.contextPath}/user/test?name=${user.name}&password=${user.password}&userid=${user.userid}">用户设置</a></div>
</div>
<div style="background-color:#cccccc;">
     <span style="margin-left: 10px;">欢迎您，${User.name} </span>

    <a href="${pageContext.request.contextPath}/user/Logout"
           style="text-decoration: none;margin-left: 1350px">退出!</a>
</div>