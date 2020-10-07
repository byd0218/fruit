<%@ page language="java" pageEncoding="UTF-8"  isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>登录</title>
	<link href="${pageContext.request.contextPath}/css/regcss.css" type="text/css"
		  rel="stylesheet"/>
	  <script type="text/javascript"
			  src="${pageContext.request.contextPath }/js/jquery-1.4.4.min.js"></script>
	  <script type="text/javascript">
	 function  validate(){
          if($("#username").val()=="" || $("#username").val()==null){
                  alert("用户名不能为空");
                  return false;
          }
          if($("#password").val()=="" || $("#password").val()==null){
                  alert("密码不能为空");
                  return false;
          }
          return true;
     }
	</script> 
  </head>
<body>
	<div id="content">
		<div id="form">
		  <h1>用户登录</h1><br/>
		  <form action="${pageContext.request.contextPath}/user/testLogin" method="post" id="myform"
				onsubmit="return validate()">
		         用户名：<input type="text" id="username" name="username" style="width:190px;
		         height:26px; margin-left:39px;"/><br/>
		  	  密码：<input type="password" id="password" name="password" style="width:190px;
		  	  height:26px; margin-top:8px;margin-left:54px;"/><br/>
			  <input type="submit" value="登录" style="width:50px; height:30px; margin-top:8px;"/>
			  <a href="${pageContext.request.contextPath}/user/testRegister">注册</a>
		  </form>
		  <!-- 显示错误信息 -->
		  <c:if test="${errorMsg!=null}">
		      <font color="red">${errorMsg}</font>    
		  </c:if>
		  <!-- 显示提示 -->
		  <c:if test="${noticeMsg!=null}"> 
		      <font color="green">${noticeMsg}</font>    
		  </c:if>
			<c:if test="${MessageSuccess != null}">
				<font color="#32cd32">${MessageSuccess}</font>
			</c:if>
	  </div>
	</div>
</body>
</html>
