<%@ page language="java" import="java.util.*" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>test</title>
      <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet"/>
      <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
      <script type="text/javascript"
              src="${pageContext.request.contextPath}/js/jquery-1.4.4.min.js"></script>
      <script type="text/javascript">


          function validate() {
              if ($("#yuanMi").val() == "" || $("#yuanMi").val()==null) {
                  alert("原密码不能为空");
                  <%--alert(${password});--%>
                  return false;
              } else if ($("#xinMi").val() == "") {
                  alert("新密码不能为空");
                  return false;
              } else if ($("#yuanMi").val()!=${User.password}){
                  alert("原密码错误");
                  return false;
              }
              else if ($("#xinMi").val() == ${User.password}){
                  alert("新密码与原密码重复");
                  return false;
              }
              return true;
          }
      </script>
  </head>
  <body>
<div id="content">
    <div id="form">
        <label style="margin-top: 20px;margin-left: 25px">用户姓名：${User.name}</label><br>
        <form action="${pageContext.request.contextPath}/user/updatePassword?userid=${User.userid}" method="post" id="myform" onsubmit="return validate()">
            <label for="exampleInputName2" style="margin-left: 25px">原密码：</label>
            <input type="text" id="yuanMi"  class="form-control" style="width:190px;
		         height:26px; margin-left: 25px"/>
            <label for="exampleInputName2" style="margin-left: 25px">新密码：</label>
            <input type="password" id="xinMi" name="password" class="form-control"
                   style="width:190px;height:26px;margin-left: 25px"/><br/>
<%--            <input type="submit" value="修改密码" style="margin-left: 25px;width:50px; height:30px;--%>
<%--            margin-top:8px;"/>--%>
            <button type="submit" class="btn btn-default" id="btn"
                    style="margin-left: 25px;background-color: #173e65;color:
             white">修&nbsp;&nbsp;改</button>
        </form>
    </div>
</div>
      <form class="form-inline" action="findUserByCondition" method="post" style="text-align: center">

          <div class="form-group">
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

      </form>
      <table class="table table-striped" style="width: 800px;margin: auto">
          <tr>
              <th>序号</th>
              <th>姓名</th>
              <th>账号</th>
              <th>电话</th>
          </tr>
          <c:forEach items="${userList}" var="fruit" varStatus="status">
              <tr>
                  <td>${status.index+1}</td>
                  <td>${fruit.name }</td>
                  <td>${fruit.username }</td>
                  <td>${fruit.telephone}</td>
              </tr>
          </c:forEach>
      </table>
  </body>
</html>
