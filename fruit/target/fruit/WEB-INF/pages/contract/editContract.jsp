<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>合同编辑</title>
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/css/updateContract.css">
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-1.4.4.min.js"></script>
<script type="text/javascript">
	function checkEditContract() {
		if($("#retailer_info").css("display") == "block" && $("#commodities_info").css("display")
				== "block") {
			var numberArrays = document.getElementsByName("numberArrays");
			for(var i = 0;i < numberArrays.length;i++)
				if(numberArrays[i].value <= 0) {
					alert("斤数必须大于0！");
					return false;
				}
			return true;	
		}
		else {
			alert("信息不完整！");
			return false;
		}
	}
	
	function changeType() {
		$("#type").val($("#indexType").val());
	}
	
	function editRetailer(name) {
		$("#retailerList").html("");
		var message = "";
		if(name != null)
			message = "{'name':'" + name + "'}";
		else
			message = "{'name':''}";
		//alert(message);
		$.ajax({
			type:'post',
			url:'${pageContext.request.contextPath}/contract/getRetailer',
			contentType:'application/json;charset=utf-8',
			data:message,
			success:function(data) {
				for(var i = 0;i < data.length;i++) {
					var oldHtml = $("#retailerList").html();
					var info = "<p onclick=\"selectRetailer('" + data[i].retailerid + "','" +
							data[i].name + "','"
							+ data[i].telephone + "','" + data[i].address + "')\">" + data[i].name + "</p>";
					$("#retailerList").html(oldHtml + info);
				}
				$(".retailerMask").css("display","block");
			},
			error:function(data) {
				alert("通信异常！");
			}
		})
	}
	
	function editFruits(name) {
		var message = "";
		if(name != null)
			message = "{'name':'" + name + "'}";
		else
			message = "{'name':''}";
		$.ajax({
			type:'post',
			url:'${pageContext.request.contextPath}/contract/getAllCommodities',
			contentType:'application/json;charset=utf-8',
			data:message,
			success:function(data) {
				var tableHead = "<tr>" + "<td><input type='checkbox' onclick='checkAll(this)'></td>" + 
				"<td>名称</td><td>价格</td><td>产地</td>" + "</tr>";
				$("#commoditiesList").html(tableHead);
				for(var i = 0;i < data.length;i++) {
					var oldHtml = $("#commoditiesList").html();
					var info = "<tr><td><input type='checkbox' name='arrays' value='" +
							data[i].fruitid + "'></td>" +
					"<td>" + data[i].name + "</td>" + "<td>" + data[i].price + "</td>" + "<td>" + data[i].locality + "</td>" + "</tr>";
					$("#commoditiesList").html(oldHtml + info);
				}
				$("#commoditiesList").html("<table border=1>" + $("#commoditiesList").html() + "</table>");
				$(".commoditiesMask").css("display","block");
			},
			error:function(data) {
				alert("通信异常！");
			}
		})
	}
	
	function searchRetailer() {
		editRetailer($("#retailerName").val());
	}
	
	function cancelRetailerEdit() {
		$(".retailerMask").css("display","none");
	}
	
	function selectRetailer(retailerId,name,telephone,address) {
		$("#retailerId").val(retailerId);
		$("#retailer_name").html("姓名：" + name);
		$("#retailer_telephone").html("联系电话：" + telephone);
		$("#retailer_address").html("送货地址：" + address);
		cancelRetailerEdit();
		$("#retailer_info").css("display","block");
	}
	
	function cancelCommoditiesEdit() {
		$(".commoditiesMask").css("display","none");
	}
	
	function searchCommodities() {
		editFruits($("#commoditiesName").val());
	}
	
	function checkAll(obj) {
		var isCheck = obj.checked;
		var checkList = document.getElementsByName("arrays");
		for(var i = 0;i < checkList.length;i++)
			checkList[i].checked = isCheck;
	}
	
	function selectCommodities() {
		$("#commodities_info").html("");
		var myArray = new Array();
		var len = 0;
		var arrays = document.getElementsByName("arrays");
		for(var i = 0;i < arrays.length;i++)
			if(arrays[i].checked)
				myArray[len++] = arrays[i].value;
		$.ajax({
			type:'post',
			url:'${pageContext.request.contextPath}/contract/getCommoditiesAndAccessory',
			data:{"arrays":myArray},
			traditional:true,
			success:function(data) {
				var tableHead = "<tr>" + "<td>名称</td><td>价格</td><td>产地</td><td>附属品</td><td>数量</td>" + "</tr>";
				$("#commodities_info").html(tableHead);
				for(var i = 0;i < data.length;i++) {
					var commodities = data[i].commodities;
					var accessoryList = data[i].accessoryList;
					var accessoryStr = "";
					for(var j = 0;j < accessoryList.length;j++) {
						accessoryStr += accessoryList[j].name + ":" + accessoryList[j].price + "元";
						if(j != accessoryList.length - 1)
							accessoryStr += "<br />";
					}
					accessoryStr = accessoryList == "" ? "无" : accessoryStr;
					var oldHtml = $("#commodities_info").html();
					var info = "<tr>" + "<td>" + commodities.name + "</td><td>" + commodities.price + "</td><td>"
					+ commodities.locality + "</td><td>" + accessoryStr + "</td><td>" + 
					"<input type='number' class='inputNumber' name='numberArrays'>斤</td>" +
					"</tr><input type='hidden' name='commoditiesIdArrays' value='" +
							commodities.fruitid + "'>";
					$("#commodities_info").html(oldHtml + info);
				}
				$("#commodities_info").html("<table class='selectedCommoditiesTable' border=1>" + $("#commodities_info").html() + "</table>");
				cancelCommoditiesEdit();
				$("#commodities_info").css("display","block");
			},
			error: function(data) {
				alert("通信异常！");
			}
		})
	}
</script>
</head>
<body>
	<form action="${pageContext.request.contextPath}/contract/editContract?"
		  id="editContractForm" method="post" onsubmit="return checkEditContract()">
		合同编码：<font class="barCode">${contract.barcode}</font><br />
		<input type="hidden" name="barcode" value="${contract.barcode }">
		类型：<select id="indexType" onchange="changeType()">
			<c:if test="${contract.type == 1 }">
				<option value="1" selected="selected">省内</option>
				<option value="2">省外</option>
			</c:if>
			<c:if test="${contract.type == 2 }">
				<option value="1">省内</option>
				<option value="2" selected="selected">省外</option>
			</c:if>
		</select>
		<input type="hidden" name="type1" id="type" value="${contract.type }"><br/>
		<input type="hidden" name="createtime" value="${contract.createtime }">
<%--		利用该contractid修改利用该contract表和中间表（每个合同所对应的水果种类不同，所以两个表都要改）--%>
		<input type="hidden" name="contractid" value="${contract.contractid }">
		<!-- <input type="hidden" name="retailer" value="${contract.retailer }">
		<input type="hidden" name="commoditiesList" value="${contract.commoditiesList }"> -->
		<div class="info">
			零售商信息：
			<div class="btn btn-div btn1" onclick="editRetailer(null)">
				关联
			</div><br />
			
			<div id="retailer_info" style="display:block;">
				<p id="retailer_name">姓名：${contract.retailer.name }</p>
				<p id="retailer_telephone">联系电话：${contract.retailer.telephone }</p>
				<p id="retailer_address">送货地址：${contract.retailer.address }</p>
				<input type="hidden" name="retailerid" id="retailerId"
					   value="${contract.retailer.retailerid}">
			</div>
		</div>
		<div class="info">
			货物信息：
			<div class="btn btn-div btn1" onclick="editFruits(null)">
				添加
			</div><br />
			<div id="commodities_info" style="display: block;">
				<table class="selectedCommoditiesTable" border=1>
					<tr>
						<td>名称</td>
						<td>价格</td>
						<td>产地</td>
						<td>附属品</td>
						<td>数量</td>
					</tr>
					
					<c:forEach items="${commodityVOList}" var="item">
						<tr>
							<td>${item.name}</td>
							<td>${item.price}元/斤</td>
							<td>${item.locality }</td>
							<td>
								<c:if test="${item.accessoryList != null }">
									<c:forEach items="${item.accessoryList }" var="accessoryItem">
										${accessoryItem.name }:${accessoryItem.price }元/斤<br />
									</c:forEach>
								</c:if>
								<c:if test="${item.accessoryList == null || item.accessoryList.size() == 0 }">
									无
								</c:if>
							</td>
							<td>${item.number}斤</td>
						</tr>
						<input id="com" type="hidden" name="commoditiesIdArrays"
							   value="${item.fruitid }" >
						<input id="num" type="hidden" name="numberArrays" value="${item.number}" >
					</c:forEach>
				</table>
			</div>
		</div> 
		<input type="submit" value="提交" class="btn"> 
	</form>
	
	<div class="retailerMask">
		<div class="c">
			<div class="change">
				零售商信息<font class="font1" onclick="cancelRetailerEdit()">x</font>
			</div>
			<input id="retailerName" type="text" class="inputText"><br />
			<button class="btn btn2" onclick="searchRetailer()">查询</button>
			<div id="retailerList" class="showRetailer">
				
			</div>
		</div>
	</div>
	
	<div class="commoditiesMask">
		<div class="c1">
			<div class="change">
				水果列表<font class="font1" onclick="cancelCommoditiesEdit()">x</font>
			</div>
			<input id="commoditiesName" type="text" class="inputText"><br />
			<button class="btn btn2" onclick="searchCommodities()">查询</button>
			<div id="commoditiesList" class="showCommodities" >
				
			</div>
			<button class="btn btn2" onclick="selectCommodities()">确定</button>
		</div>
	</div> 
	
	<c:if test="${resultMessage != null }">
		<br /><font color="red">${resultMessage }</font>
	</c:if>
</body>
</html>