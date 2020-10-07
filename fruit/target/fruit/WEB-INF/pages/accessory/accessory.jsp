<%--
  Created by IntelliJ IDEA.
  User: 白玉东
  Date: 2020/9/13
  Time: 16:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>test</title>
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet"/>
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery-1.4.4.min.js"></script>
</head>
<body>
<form class="form-inline" action="findUserByCondition" method="post"
      style=";text-align: center;margin-top: 100px">

    <%--<div class="form-group">
        <label for="exampleInputName2">用户姓名：</label>
        <input type="text" class="form-control" id="exampleInputName2" placeholder="name"
               name="name">
    </div>
    <div class="form-group">
        <label for="exampleInputEmail2">账号：</label>
        <input type="text" class="form-control" id="exampleInputEmail2"
               placeholder="username" name="username">
    </div>
    <div class="form-group">
        <label for="exampleInputEmail3">电话：</label>
        <input type="text" class="form-control" id="exampleInputEmail3"
               placeholder="telephone" name="telephone">
    </div>
    <button type="submit" class="btn btn-default" style="background-color: #173e65;color:
             white">查&nbsp;&nbsp;询</button>
--%>
</form>
<table class="table table-striped" style="width: 800px;margin: auto">
    <tr>
        <th>序号</th>
        <th>附属品名称</th>
        <th>附属品价格</th>
        <th>创建日期</th>
    </tr>
    <c:forEach items="${accessoryList}" var="accessory" varStatus="status">
        <tr>
            <td>${status.index+1}</td>
            <td>${accessory.name }</td>
            <td>${accessory.price}</td>
            <td>${accessory.ctime}</td>
        </tr>
    </c:forEach>
</table>
</body>
</html>

