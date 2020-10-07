<%@ page language="java" import="java.util.*" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html >
  <head>
    <title>货物管理</title>
      <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/homeView.css">
    <style>
        *{margin:0; padding:0;} #menuContent a{text-decoration:none;color:#ffffff}
        .c{
          border-style: solid;width: 200px;height: 130px;
          margin: 4 23 0 23;border-radius:5;display:block;
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
  		src="${pageContext.request.contextPath}/js/jquery-1.4.4.min.js"></script>
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
    
       function changeStatus(){
           var status = document.getElementById("indexStatus").value;
           document.getElementById("status").value=status;
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

       function cancelEdit(){
    	   $(".mask").css("display","none");
       }

      /*  function changeEditStatus(){
    	   var status = document.getElementById("editStatus").value;
           document.getElementById("eStatus").value=status;
       } */

       /*function deleteCommodities(id,name){
    	   if(window.confirm("你确定要删除附属品"+name+"吗？")){
    		   $("#dFruitId").val(id);//向form中引入id
        	   //引入分页信息至该form表单
               $("#dStartPage").val($("#startPage").val());
               $("#dCurrentPage").val($("#currentPage").val());
               $("#dPageSize").val($("#pageSize").val());
               $("#deleteForm").submit();//提交表单
            }
       }*/

	   function showAddMask(flag){
		    if(flag=="true"){
		 	   $(".addMask").css("display","block");
		    }else{
		 	   $(".addMask").css("display","none");
		    }
	   }

       function showUpdateMask(flag,name,locality,price,fruitid){
           if(flag=="true"){
                $("#updateName").val(name);
                $("#updateLocality").val(locality);
                $("#updatePrice").val(price);
                $("#updateFruitid").val(fruitid);
               $(".updateMask").css("display","block");
           }else{
               $(".updateMask").css("display","none");
           }
       }
       //添加货物验证
       function checkAddCommodities() {
           if($("#addName").val() == null || $("#addName").val() == "") {
               alert("商品名不能为空！");
               return false;
           }
           if($("#addPrice").val() == null || $("#addPrice").val() == "") {
               alert("价格不能为空！");
               return false;
           }
           var reg = /(^[1-9]\d*(\.\d{1,2})?$)|(^0(\.\d{1,2})?$)/;
           if(!reg.test($("#addPrice").val()))
           {
               alert("请输入有效的价格！");
               return false;
           }
           if($("#addLocality").val() == null || $("#addLocality").val() == "") {
               alert("产地不能为空！");
               return false;
           }

           $("#aCurrentPage").val($("#currentPage").val());
           $("#aStartPage").val($("#startPage").val());
           $("#aPageSize").val($("#pageSize").val());
           return true;
       }

       //修改货物验证
       function checkUpdateCommodities() {
           if($("#updateName").val() == null || $("#updateName").val() == "") {
               alert("商品名不能为空！");
               return false;
           }
           if($("#updatePrice").val() == null || $("#updatePrice").val() == "") {
               alert("价格不能为空！");
               return false;
           }
           var reg = /(^[1-9]\d*(\.\d{1,2})?$)|(^0(\.\d{1,2})?$)/;
           if(!reg.test($("#updatePrice").val()))
           {
               alert("请输入有效的价格！");
               return false;
           }

           if($("#updateLocality").val() == null || $("#updateLocality").val() == "") {
               alert("产地不能为空！");
               return false;
           }
           return true;
       }

	   function openwin(id) { 
		   var url="${pageContext.request.contextPath}/accessory/findAccessory?fruitid="+id;
	       window.open (url,"附属品","height=400,width=700,scrollbars=yes"); 
	   } 
	   
	   function changePageSize() {
            //获取下拉框的值
           var pageSize = $("#changePageSize").val();
           //向服务器发送请求，改变每一页显示的条数
           location.href="${pageContext.request.contextPath}/commodities/findCommodities?page=1&size="+pageSize+
               "&name=${name}&locality=${locality}&startPrice=${startPrice}&endPrice=${endPrice}&startTime=${startTime}&endTime=${endTime}";
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
               action="${pageContext.request.contextPath}/commodities/addCommodities?page=1&size=4" method="post" onsubmit="return checkAddCommodities()">
		        名称：<input type="text" id="addName" name="name" style="width:120px"/> <br/>
                价格：<input type="text" id="addPrice" name="price" style="width:120px"/><br/>
		        产地：<input type="text" id="addLocality" name="locality" style="width:120px"/><br/>
		     <input type="hidden" name="status" value="1"/>
		     <input type="submit" value="添加" style="background-color:#173e65;color:#ffffff;width:70px;"/>
	     </form>
	    </div>
   </div>
      <div class="updateMask">
          <div class="c">
              <div style="background-color:#173e65;height:20px;color:#fff;font-size:12px;padding-left:7px;">
                  编辑信息<font style="float:right;padding-right: 10px;"
                            onclick="showUpdateMask('false')">x</font>
              </div>
              <form id="updateForm"
                    action="${pageContext.request.contextPath}/commodities/updateCommodities?page=1&size=4"
                    method="post" onsubmit="return checkUpdateCommodities()">
                  名称：<input type="text" id="updateName" name="name" style="width:120px"
                            value=""/> <br/>
                  价格：<input type="text" id="updatePrice" name="price" style="width:120px"/><br/>
                  产地：<input type="text" id="updateLocality" name="locality" style="width:120px"/><br/>
                  <input type="hidden" id="updateFruitid" name="fruitid" value=""/>
                  <input type="hidden" name="status" value="1"/>
                  <input type="submit" value="更新"
                         style="background-color:#173e65;color:#ffffff;width:70px;"/>
              </form>
          </div>
      </div>
   <div class="mask">

  </div>
  <form id="listForm" action="${pageContext.request.contextPath}/commodities/findCommodities?page=1&size=4"
        method="post">
        名称：<input type="text" name="name" style="width:120px" value="${name}"/>
        产地：<input type="text" name="locality" style="width:120px" value="${locality}"/>
        价格：<input id="price1" name="startPrice" type="number" min="0.0" step="0.1" style="width:60px" value="${startPrice}"/>
        - <input id="price2" name="endPrice" type="number" min="0.0" step="0.1" style="width:60px" value="${endPrice}"/><br/><br/>
        创建日期：<input type="datetime-local" name="startTime" value="${startTime}"/> - <input type="datetime-local" name="endTime" value="${endTime}"/>
     <input type="submit" value="搜索" style="background-color:#173e65;color:#ffffff;width:70px;"/> <br/>
  </form>
  <hr style="margin-top: 10px;"/> 
  <button onclick="showAddMask('true')" style="background-color:#173e65;color:#ffffff;width:70px;">添加</button>
  <c:if test="${pageInfo.list!=null}">
	  <table style="margin-top: 10px;width:700px;text-align:center;" border=1>  
	    <tr>  
	      <td>序号</td><td>名称</td><td>价格</td><td>产地</td>
	      <td>创建日期</td><td>操作</td>
	   </tr>  
      <c:forEach items="${pageInfo.list}" var="item" varStatus="status">
	     <tr>  
	       <td>${status.index+1}</td><td>${item.name }</td>
	       <td>${item.price}</td><td>${item.locality }</td>  
	       <td>${item.ctime}</td>
	       <td>
	       		<a href="#"
                   onclick="showUpdateMask('true','${item.name}','${item.locality}',
                           '${item.price}','${item.fruitid}')">编辑</a>|
	       		<a href="${pageContext.request.contextPath}/commodities/delCommodities?fruitid=
	       		${item.fruitid}&page=1&size=4" onclick="">删除</a>|
	       		<a href="#" onclick="openwin('${item.fruitid}')">附属品</a>
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
                      href="${pageContext.request.contextPath}/commodities/findCommodities?page=1&size=${pageInfo.pageSize}&name=${name}&locality=${locality}&startPrice=${startPrice}&endPrice=${endPrice}&startTime=${startTime}&endTime=${endTime}"
                      aria-lable="Previous">首页
              </a></li>
              <li><a
                      href="${pageContext.request.contextPath}/commodities/findCommodities?page=${pageInfo.pageNum-1}&size=${pageInfo.pageSize}&name=${name}&locality=${locality}&startPrice=${startPrice}&endPrice=${endPrice}&startTime=${startTime}&endTime=${endTime}">上一页</a></li>
              <c:forEach begin="1" end="${pageInfo.pages}" var="pageNum">
                  <li style="background-color: white"><a style="color: black"
                                                         href="${pageContext.request.contextPath}/commodities/findCommodities?page=${pageNum}&size=${pageInfo.pageSize}&name=${name}&locality=${locality}&startPrice=${startPrice}&endPrice=${endPrice}&startTime=${startTime}&endTime=${endTime}">${pageNum}</a></li>
              </c:forEach>

              <li><a
                      href="${pageContext.request.contextPath}/commodities/findCommodities?page=${pageInfo.pageNum+1}&size=${pageInfo.pageSize}&name=${name}&locality=${locality}&startPrice=${startPrice}&endPrice=${endPrice}&startTime=${startTime}&endTime=${endTime}">下一页
              </a></li>
              <li><a href="${pageContext.request.contextPath}/commodities/findCommodities?page=${pageInfo.pages}&size=${pageInfo.pageSize}&name=${name}&locality=${locality}&startPrice=${startPrice}&endPrice=${endPrice}&startTime=${startTime}&endTime=${endTime}"
                     aria-lable="Next">尾页</a></li>
          </ul>
      </div>
   </c:if>
   <c:if test="${pageInfo.list==null}">
       <b>搜索结果为空！</b>
   </c:if>
      <div class="mask">
          <div class="c">
              <div class="change">
                  修改信息<font onclick="cancelEdit()" class="font1">x</font>
              </div>
              <form action="edit.action" id="editForm" method="post" onsubmit="return checkUpdateCommodities()">
                  姓名：<input type="text" id="editName" name="name" class="width1" /><br />
                  价格：<input type="number" min="0.0" step="0.1" id="editPrice" name="price" /><br />
                  产地：<input type="text" id="editLocality" name="locality" class="width1" /><br />
                  <input type="hidden" name="fruitId" id="fruitId">
                  <input type="hidden" name="startPage" id="eStartPage">
                  <input type="hidden" name="currentPage" id="eCurrentPage">
                  <input type="hidden" name="pageSize" id="ePageSize">
                  <input type="submit" value="提交">
              </form>
          </div>
      </div>
  </body>
</html>
