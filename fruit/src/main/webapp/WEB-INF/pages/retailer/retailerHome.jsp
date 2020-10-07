<%@ page language="java" import="java.util.*" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html >
  <head>
    <title>零售商管理</title>
    <style>
        *{margin:0; padding:0;} #menuContent a{text-decoration:none;color:#ffffff}
        .c{
          border-style: solid;width: 200px;height: 130px;
          margin: 4 23 0 23;border-radius:5px;
			display:block;
          background:#fff;
          margin:10% auto;
        }
        .mask,.addMask,.updateMask{
        	width:100%;
        	height:100%;
        	position: absolute;
        	background:rgba(0,0,0,.3);
        	display: none;
        }
		ul{
			margin:0;
			padding:0;
		} ul li{float: left; list-style: none;
			  margin:0;
			  padding:0;
			  /*display:inline;*/
			  line-height:30px;
			  border: white solid 2px;
			  background-color: #173e65;
		  }
		ul li a{
			color: white;
			text-decoration: none;
		}
    </style>
        
    <script type="text/javascript" 
  		src="${pageContext.request.contextPath }/js/jquery-1.4.4.min.js"></script>  
    <script type="text/javascript">
       function init(){
           var countNumber = document.getElementById("countNumber").value;
           var sumPage = document.getElementById("sumPageNumber").value;
           var currentPage = document.getElementById("currentPage").value;
           var info = "一共<font color='blue'>"+countNumber+"</font>条数据，"+
                      "共<font color='blue'>"+sumPage+"</font>页，"+
                      "当前第<font color='blue'>"+currentPage+"</font>页";
           document.getElementById("pageInfo").innerHTML=info;
       }
    
       function changeUpdateStatus(){
           var status = document.getElementById("indexStatus").value;
           document.getElementById("status").value=status;
       }

       function changeStatus() {
		   var status = document.getElementById("inStatus").value;
		   document.getElementById("status1").value=status;
	   }
       
       function toPrePage(){
           var currentPageObject = document.getElementById("currentPage");
           var currentPage = parseInt(currentPageObject.value);
           if(currentPage==1){
               alert("数据已到顶！");
           }else{
               currentPageObject.value = currentPage-1;
               var pageSize = parseInt(document.getElementById("pageSize").value);
               var startPageObject =document.getElementById("startPage");
               startPageObject.value = parseInt(startPageObject.value)-pageSize;
               document.getElementById("listForm").submit();
           }
       }
       
       function toNextPage(){
           var currentPageObject = document.getElementById("currentPage");
           var currentPage = parseInt(currentPageObject.value);
           var sumPage = parseInt(document.getElementById("sumPageNumber").value);
           if(currentPage>=sumPage){
               alert("数据已到底！");
           }else{
               currentPageObject.value = currentPage+1;
               var pageSize = parseInt(document.getElementById("pageSize").value);
               var startPageObject =document.getElementById("startPage");
               startPageObject.value = parseInt(startPageObject.value)+pageSize;
               document.getElementById("listForm").submit();
           }
       }
       
       function toLocationPage(){
           var pageNumber = document.getElementById("pageNumber").value;
           var currentPageObject = document.getElementById("currentPage");
           var currentPage = currentPageObject.value;
           if(pageNumber==null||pageNumber==""){
               alert("请输入要跳转的页数！");
           }else{
        	   pageNumber = parseInt(pageNumber);
               var sumPage = parseInt(document.getElementById("sumPageNumber").value);
	           if(pageNumber<1){
	               alert("数据已到顶！");
	           }else if(pageNumber>sumPage){
	               alert("数据已到底！");
	           }else{
	               currentPageObject.value = pageNumber;
	               var pageSize = parseInt(document.getElementById("pageSize").value);
                   var startPageObject =document.getElementById("startPage");
                   if(pageNumber>currentPage){
                       startPageObject.value = parseInt(startPageObject.value)+pageSize;
                   }else if(pageNumber<currentPage){
                       startPageObject.value = parseInt(startPageObject.value)-pageSize;
                   }
	               document.getElementById("listForm").submit();
	           }
           }
       }

	   function showUpdateMask(flag,name,telephone,address,status,retailerid){
		   if(flag=="true"){
			   $("#updateName").val(name);
			   $("#updateTelephone").val(telephone);
			   $("#updateAddress").val(address);
			   /*将要编辑的该零售商的的状态分别赋值给下拉列表和隐藏状态框
			   1.如果编辑时不选状态，则使用隐藏框中的值
			   2.如果选择下拉列表中的状态，则下拉列表中的值又通过使用函数赋值给隐藏框
			   最终隐藏框的值是将要被更新的值*/
			   $("#indexStatus").val(status);	//将要编辑的该零售商的的状态回显给下拉列表
			   $("#status").val(status);
			   $("#updateRetailerid").val(retailerid);
			   $(".updateMask").css("display","block");
		   }else{
			   $(".updateMask").css("display","none");
		   }
	   }

       function cancelEdit(){
    	   $(".mask").css("display","none");
       }

       function changeEditStatus(){
    	   var status = document.getElementById("editStatus").value;
           document.getElementById("eStatus").value=status;
       }

       function deleteRetailer(id,name){
    	   if(window.confirm("你确定要删除用户"+name+"吗？")){
    		   location.href="${pageContext.request.contextPath}/retailer/delRetailer?page=1&size=4&retailerid="+id+" &name=" + name;
            }
       }

	   function showAddMask(flag){
		    if(flag=="true"){
		 	   $(".addMask").css("display","block");
		    }else{
		 	   $(".addMask").css("display","none");
		    }
	   }

	   function checkAddRetailer(){
           if($("#addName").val()==null||$("#addName").val()==""){
               alert("用户名不能为空！");
               return false;
           }
           if($("#addTelephone").val()==null||$("#addTelephone").val()==""){
               alert("手机号不能为空！");
               return false;
           }
           var myreg = /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\d{8})$/; 
           if(!myreg.test($("#addTelephone").val()))
           { 
               alert("请输入有效的手机号码！"); 
               return false; 
           } 
           if($("#addAddress").val()==null||$("#addAddress").val()==""){
               alert("地址不能为空！");
               return false;
           }
           return true;
	   }

	   function checkUpdateRetailer() {
		   if($("#updateName").val() == null || $("#updateName").val() == "") {
			   alert("用户名不能为空！");
			   return false;
		   }
		   if($("#updateTelephone").val() == null || $("#updateTelephone").val() == "") {
			   alert("手机号不能为空！");
			   return false;
		   }
		   var myreg = /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\d{8})$/;
		   if(!myreg.test($("#updateTelephone").val())) {
			   alert("请输入有效的手机号码！");
			   return false;
		   }

		   if($("#updateAddress").val() == null || $("#updateAddress").val() == "") {
			   alert("地址不能为空！");
			   return false;
		   }
		   return true;
	   }

	   function changePageSize() {
		   //获取下拉框的值
		   var pageSize = $("#changePageSize").val();
		   //向服务器发送请求，改变每一页显示的条数
		   location.href="${pageContext.request.contextPath}/retailer/findAllRetailer?page=1&size="+pageSize+
				   "&name=${name}&address=${address}&telephone=${telephone}&status1=${status1}&startTime=${startTime}&endTime=${endTime}";
	   }

    </script>
  </head>
  <body onload="init()">
      <%@ include file="../menu.jsp" %><br/>
   <div class="addMask">
	   <div class="c">
	     <div style="background-color:#173e65;height:20px;color:#fff;font-size:12px;padding-left:7px;">
	     	添加信息<font style="float:right;padding-right: 10px;" onclick="showAddMask('false')">x</font>
	     </div>
	     <form id="addForm"
			   action="${pageContext.request.contextPath}/retailer/addRetailer?page=1&size=4"
			   method="post" onsubmit="return checkAddRetailer()">
		        姓名：<input type="text" id="addName" name="name" style="width:120px"/> <br/>
		        手机：<input type="text" id="addTelephone" name="telephone" style="width:120px"/><br/>
		        地址：<input type="text" id="addAddress" name="address" style="width:120px"/><br/>
<%--			 如果没有赋值，那就使用默认值，否则使用赋的值--%>
		     <input type="hidden" name="status" value="1"/>
		     <input type="submit" value="添加"
					style="background-color:#173e65;color:#ffffff;width:70px;" id="sub"/>
	     </form>
	    </div>
   </div>
	  </div>
	  <div class="updateMask">
		  <div class="c">
			  <div style="background-color:#173e65;height:20px;color:#fff;font-size:12px;padding-left:7px;">
				  编辑信息<font style="float:right;padding-right: 10px;"
							onclick="showUpdateMask('false')">x</font>
			  </div>
			  <form id="updateForm"
					action="${pageContext.request.contextPath}/retailer/updateRetailer?page=1&size=4"
					method="post" onsubmit="return checkUpdateRetailer()">
				  姓名：<input type="text" id="updateName" name="name" style="width:120px"
							value=""/> <br/>
				  电话：<input type="text" id="updateTelephone" name="telephone"
							style="width:120px"/><br/>
				  地址：<input type="text" id="updateAddress" name="address" style="width:120px"/><br/>
				  状态：
				  <select id="indexStatus" onchange="changeUpdateStatus()">
					  <option value="1">启用</option>
					  <option value="0">停用</option>
				  </select><br>
				  <input type="hidden" name="status1" id="status">
				  <input type="hidden" id="updateRetailerid" name="retailerid" value=""/>
				  <%--				  <input type="hidden" name="status" value="1"/>--%>
				  <input type="submit" value="更新"
						 style="background-color:#173e65;color:#ffffff;width:70px;"/>
			  </form>
		  </div>
	  </div>
  <form id="listForm"
		action="${pageContext.request.contextPath}/retailer/findAllRetailer?page=1&size=4" method="post">
        姓名：<input type="text" name="name" style="width:120px" value="${name}"/>
        手机：<input type="text" name="telephone" style="width:120px" value="${telephone}"/>
        地址：<input type="text" name="address" style="width:120px" value="${address}"/><br/><br/>
        状态：<select id="inStatus"  onchange="changeStatus()">
			<c:choose>
				<c:when test="${status1 == -1}">
					<option value="-1" selected="selected">全部</option>
				</c:when>
				<c:otherwise>
					<option value="-1">全部</option>
				</c:otherwise>
			</c:choose>
			<c:choose>
				<c:when test="${status1 == 1 }">
					<option value="1" selected="selected">启用</option>
				</c:when>
				<c:otherwise>
					<option value="1">启用</option>
				</c:otherwise>
			</c:choose>
			<c:choose>
				<c:when test="${status1 == 0 }">
					<option value="0" selected="selected">停用</option>
				</c:when>
				<c:otherwise>
					<option value="0">停用</option>
				</c:otherwise>
			</c:choose>
     </select>
<%--	  如果没有根据该id赋值那就使用默认值，如果赋值了那就使用赋的值--%>
     <input type="hidden" name="status1" id="status1" value="-1">
        创建日期：<input type="datetime-local" name="startTime" value="${startTime}"/> - <input type="datetime-local" name="endTime" value="${endTime}"/>
     <input type="submit" value="搜索" style="background-color:#173e65;color:#ffffff;width:70px;"/> <br/>
     <!-- 显示错误信息 -->  
	 <c:if test="${errorMsg}">   
	     <font color="red">${errorMsg}</font><br/>
	 </c:if>
  </form>
  <hr style="margin-top: 10px;"/> 
  <button onclick="showAddMask('true')" style="background-color:#173e65;color:#ffffff;width:70px;">添加</button>
	  <c:if test="${pageInfo.list!=null}">
		  <table style="margin-top: 10px;width:700px;text-align:center;" border=1>
			  <tr>
				  <td>序号</td><td>零售商姓名</td><td>电话</td><td>地址</td>
				  <td>状态</td>
				  <td>创建时间</td>
				  <td>操作</td>
			  </tr>
			  <c:forEach items="${pageInfo.list}" var="item" varStatus="status">
				  <tr>
					  <td>${status.index+1}</td><td>${item.name }</td>
					  <td>${item.telephone}</td><td>${item.address }</td>
					  <td>
						  <c:if test="${item.status==1}">
						  <font color="blue">启用</font>
					  </c:if>
						  <c:if test="${item.status==0}">
							  <font color="red">停用</font>
						  </c:if>
						  </td>
					  <td>${item.ctime}</td>
					  <td>
						  <a href="#" onclick="showUpdateMask('true','${item.name}','${item.telephone}',
								  '${item.address}','${item.status}','${item.retailerid}')">编辑</a>|
						  <a href="#"
							 onclick="deleteRetailer('${item.retailerid}','${item.name }')">删除
						  </a>
					  </td>
				  </tr>
			  </c:forEach>
		  </table>
		  <div>
			  <div>
				  <div>
					  <c:if test="${page == 0 }">
						  第${page+1}页，
					  </c:if>
					  <c:if test="${page == pageInfo.pages +1}">
						  第${pageInfo.pages}页，
					  </c:if>
					  <c:if test="${page != pageInfo.pages +1 && page !=0}">
						  第${page}页，
					  </c:if>
					  总共${pageInfo.pages}页，共${pageInfo.total}条数据,每页
					  <select  id="changePageSize"  onchange="changePageSize()">
						  <option>${size}</option>
						  <option>1</option>
						  <option>2</option>
						  <option>3</option>
						  <option>4</option>
						  <option>5</option>
					  </select>条

				  </div>
			  </div>
		  </div>
		  <div class="box-tools pull-right">
			  <ul class="pagination">
				  <li><a
						  href="${pageContext.request.contextPath}/retailer/findAllRetailer?page=1&size=${pageInfo.pageSize}&name=${name}&address=${address}&telephone=${telephone}&status1=${status1}&startTime=${startTime}&endTime=${endTime}"
						  aria-lable="Previous">首页
				  </a></li>
				  <li><a
						  href="${pageContext.request.contextPath}/retailer/findAllRetailer?page=${pageInfo.pageNum-1}&size=${pageInfo.pageSize}&name=${name}&address=${address}&telephone=${telephone}&status1=${status1}&startTime=${startTime}&endTime=${endTime}">上一页</a></li>
				  <c:forEach begin="1" end="${pageInfo.pages}" var="pageNum">
					  <li style="background-color: white"><a style="color: black"
															 href="${pageContext.request.contextPath}/retailer/findAllRetailer?page=${pageNum}&size=${pageInfo.pageSize}&name=${name}&address=${address}&telephone=${telephone}&status1=${status1}&startTime=${startTime}&endTime=${endTime}">${pageNum}</a></li>
				  </c:forEach>

				  <li><a
						  href="${pageContext.request.contextPath}/retailer/findAllRetailer?page=${pageInfo.pageNum+1}&size=${pageInfo.pageSize}&name=${name}&address=${address}&telephone=${telephone}&status1=${status1}&startTime=${startTime}&endTime=${endTime}">下一页
				  </a></li>
				  <li><a href="${pageContext.request.contextPath}/retailer/findAllRetailer?page=${pageInfo.pages}&size=${pageInfo.pageSize}&name=${name}&address=${address}&telephone=${telephone}&status1=${status1}&startTime=${startTime}&endTime=${endTime}"
						 aria-lable="Next">尾页</a></li>
			  </ul>
		  </div>
	  </c:if>
   <c:if test="${pageInfo.list==null}">
       <b>搜索结果为空！</b>
   </c:if>
	  <c:if test="${errorMessage!=null}">
		  <font color="red">${errorMessage}</font>
	  </c:if>


  </body>
</html>
