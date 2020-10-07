<%@ page language="java" import="java.util.*" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html >
  <head>
    <title>购销合同管理</title>
    <style>
		*{
			margin:0; padding:0;
		}
		#menuContent a{
			text-decoration:none;
			color:#ffffff
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
	    function changeType(){
	        var type = document.getElementById("indexType").value;
	        document.getElementById("type").value=type;
	    }

	    function changeStatus(){
            var type = $("#indexType").val();
            $("#type").val(type);
        }

	    function addContract() { 
		   var url="${pageContext.request.contextPath}/contract/addContract";
	       window.open (url,"创建合同","height=700,width=700,scrollbars=yes"); 
	    } 
	    function getContractDetail(id) { 
		   var url="${pageContext.request.contextPath}/contract/getContractDetail?contractid="+id;
	       window.open (url,"合同详情","height=700,width=700,scrollbars=yes"); 
	    }
	    function deleteContract(id,barcode){
	    	if(window.confirm("你确定要删除编号为"+barcode+"的合同信息吗？")){
				location.href="${pageContext.request.contextPath}/contract/delContract?page=1&size=4&contractid="+id;
            }
		}

		function editContract(id) {
			var url =
					"${pageContext.request.contextPath}/contract/updateContract?contractid=" + id;
			window.open(url,"编辑合同","height=700,width=700,scrollbars=yes");
		}

		function changePageSize() {
			//获取下拉框的值
			var pageSize = $("#changePageSize").val();
			//向服务器发送请求，改变每一页显示的条数
			location.href="${pageContext.request.contextPath}/contract/findAllContract?page=1&size="+pageSize+
					"&barcode=${condition.barcode}&retailerName=${condition.retailerName}&type1\n" +
					"=${type1}&startTime=${startTime}&endTime=${endTime}";
		}
    </script>
  </head>
  <body onload="init()">
      <%@ include file="../menu.jsp" %><br/>
      <form id="listForm"
			action="${pageContext.request.contextPath}/contract/findAllContract?page=1&size=4" method="post">
	        合同号：<input type="text" name="barcode" id="barcode" style="width:120px"
					   value="${condition.barcode}"/>

	        零售商：<input type="text" name="retailerName" value="${condition.retailerName}"
					   style="width:120px"/>
	        类型：

		  <select id="indexType" onchange="changeType()">
			   <c:choose>
				   <c:when test="${type1 == -1 }">
					   <option value="-1" selected="selected">全部</option>
				   </c:when>
				   <c:otherwise>
					   <option value="-1">全部</option>
				   </c:otherwise>
			   </c:choose>

			   <c:choose>
				   <c:when test="${type1 == 2 }">
					   <option value="2" selected="selected">省外</option>
				   </c:when>
				   <c:otherwise>
					   <option value="2">省外</option>
				   </c:otherwise>
			   </c:choose>

			   <c:choose>
				   <c:when test="${type1 == 1 }">
					   <option value="1" selected="selected">省内</option>
				   </c:when>
				   <c:otherwise>
					   <option value="1">省内</option>
				   </c:otherwise>
			   </c:choose>
        </select>
        <input type="hidden" name="type1" id="type" value="${type1}"><br/><br>
	        创建日期：<input type="datetime-local" name="startTime" value="${startTime}" />
	        - <input type="datetime-local" name="endTime" value="${endTime}"/>
         <input type="submit" value="搜索" style="background-color:#173e65;color:#ffffff;width:70px;"/> <br/>
	     <!-- 显示错误信息 -->  
		 <c:if test="${errorMsg}">   
		     <font color="red">${errorMsg}</font><br/>
		 </c:if>
      </form>
      <hr style="margin-top: 10px;"/> 
      <button onclick="addContract()" style="background-color:#173e65;color:#ffffff;width:70px;">添加</button>
      <c:if test="${pageInfo.list!=null}">
		  <table style="margin-top: 10px;width:700px;text-align:center;" border=1>  
		    <tr>  
		      <td>序号</td><td>合同编号</td><td>零售商</td>
		      <td>类型</td><td>创建日期</td><td>操作</td>
		   </tr>  
	       <c:forEach items="${pageInfo.list}" var="item" varStatus="status">
		     <tr>  
		       <td>${status.index+1}</td><td><a href="#"
												onclick="getContractDetail('${item.contractid}')">${item.barcode }</a></td>
		       <td>${item.retailerName}</td>
		       <td><c:if test="${item.type==1}">
		               <font color="blue">省内</font>
		           </c:if>
		           <c:if test="${item.type==2}">
		               <font color="green">省外</font>
		           </c:if></td>
		       <td>${item.ctime}</td>
		       <td>
		       		<a href="#" onclick="editContract('${item.contractid}')">编辑</a>|
		       		<a href="#"
					   onclick="deleteContract('${item.contractid}','${item.barcode }')">删除</a>
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
						  href="${pageContext.request.contextPath}/contract/findAllContract?page=1&size=${pageInfo.pageSize}&barcode=${condition.barcode}&retailerName=${condition.retailerName}&type1=${type1}&startTime=${startTime}&endTime=${endTime}"
						  aria-lable="Previous">首页
				  </a></li>
				  <li><a
						  href="${pageContext.request.contextPath}/contract/findAllContract?page=${pageInfo.pageNum-1}&size=${pageInfo.pageSize}&barcode=${condition.barcode}&retailerName=${condition.retailerName}&type1=${type1}&startTime=${startTime}&endTime=${endTime}">上一页</a></li>
				  <c:forEach begin="1" end="${pageInfo.pages}" var="pageNum">
					  <li style="background-color: white"><a style="color: black" href="${pageContext.request.contextPath}/contract/findAllContract?page=${pageNum}&size=${pageInfo.pageSize}&barcode=${condition.barcode}&retailerName=${condition.retailerName}&type1=${type1}&startTime=${startTime}&endTime=${endTime}">${pageNum}</a></li>
				  </c:forEach>

				  <li><a
						  href="${pageContext.request.contextPath}/contract/findAllContract?page=${pageInfo.pageNum+1}&size=${pageInfo.pageSize}&barcode=${condition.barcode}&retailerName=${condition.retailerName}&type1=${type1}&startTime=${startTime}&endTime=${endTime}">下一页
				  </a></li>
				  <li><a href="${pageContext.request.contextPath}/contract/findAllContract?page=${pageInfo.pages}&size=${pageInfo.pageSize}&barcode=${condition.barcode}&retailerName=${condition.retailerName}&type1=${type1}&startTime=${startTime}&endTime=${endTime}"
						 aria-lable="Next">尾页</a></li>
			  </ul>
		  </div>
       </c:if>
	   <c:if test="${pageInfo.list==null}">
	       <b>搜索结果为空！</b>
	   </c:if>

  </body>
</html>
