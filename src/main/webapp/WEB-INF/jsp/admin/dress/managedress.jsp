<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/css" var="css_url" />
<spring:url value="/img" var="img_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/setting.css">
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>MANAGE DRESS</title>
</head>
<script type="text/javascript">
	function showdialogBox(value) {
		$("#appendFeeCategoryId").empty();
		$(".feecategorycreateedit").show();
	}
	function hidefeecategorycreateedit() {
		$("#feeCategoryNamemsg").empty();
		$("#changedprice").val('');
		$(".feecategorycreateedit").hide();
	}
	function editPrices(id) {
		$("#appendFeeCategoryId").empty();
		$("#feeCategoryNamemsg").empty();
		$
				.ajax({
					type : "post",
					url : 'getDress',
					data : {
						'dressId' : id
					},
					success : function(data) {
						var obj = JSON.parse(data);
						$("#myModalLabel").text("Change Price");
						$("#appendFeeCategoryId")
								.append(
										'<input type="hidden" id="dressChangeId" name="dressId" value="'+id+'"/>');
					$(".feecategorycreateedit").show();
					},
					error : function(e) {
						
					}
				});
	}
	function getDressDetails(id)
	{
		var url = 'getDressDetails/' + id;
$
		.ajax({
			url : url,

			type : 'POST',
			success : function(data, status) {

				$("#dressDetails").empty();
				var j = JSON.parse(data);
				var st = "";
				var length = j.length;
		st = '<table cellpadding="0" cellspacing="0" width="100%" class="table"><thead><tr><th width="25%">Dress Name</th><th width="25%">Category</th><th width="25%">Size</th>'
			+'<th width="25%">Price</th><th width="25%">Operation</th></tr></thead><tbody>'
					for ( var i = 0; i < length; i++) {
						st += '<tr><td>'
								+ j[i].dressName
								+ '</td><td>' + j[i].category
								+ '</td><td>' + j[i].size
								+ '</td><td>' + j[i].price
								+ '</td><td><a href="javascript:editPrices('+j[i].dressId+')"><span class="label label-success">Change</span></a></td></tr>';
					}
					st += '</table>';
				
				$("#dressDetails").append(st);
			},
			error : function(error, status) {
			}
		});
}
function updatePrice()
{
	$("#feeCategoryNamemsg").empty();
	var flage = true;
	var regex1 = /^[0-9]*$/;
	if ($("#changedprice").val() == '') {
		$("#feeCategoryNamemsg").append(
				'<font color="red">This field is required</font>');
		flage = false;
	}
	else if (!regex1.test($("#changedprice").val())){
		$("#feeCategoryNamemsg").append(
				'<font color="red">Only Numeric value</font>');
		flage = false;
	}
	if(flage==true)
		{
	var changeId=$('#dressChangeId').val();
		var newprice = $('#changedprice').val();
		
		var url = 'updateprices/' + changeId+'/'+newprice;
		$
				.ajax({
					url : url,

					type : 'POST',
					success : function(data, status) {
						$(".feecategorycreateedit").hide();
						$("#dressDetails").empty();
						$('#changedprice').val('');
						var j = JSON.parse(data);
						var st = "";
						var length = j.length;
				st = '<table cellpadding="0" cellspacing="0" width="100%" class="table"><thead><tr><th width="25%">Dress Name</th><th width="25%">Category</th><th width="25%">Size</th>'
					+'<th width="25%">Price</th><th width="25%">Operation</th></tr></thead><tbody>'
							for ( var i = 0; i < length; i++) {
								st += '<tr><td>'
										+ j[i].dressName
										+ '</td><td>' + j[i].category
										+ '</td><td>' + j[i].size
										+ '</td><td>' + j[i].price
										+ '</td><td><a href="javascript:editPrices('+j[i].dressId+')"><span class="label label-success">Change</span></a></td></tr>';
							}
							st += '</table>';
						
						$("#dressDetails").append(st);
					},
					error : function(error, status) {
					}
				});
		}
	}

	
</script>
<style>
.feecategorycreateedit {
	display: none;
	background-color: white;
	border: 1px solid grey;
	width: 450px;
	height: 266px;
	border-radius: 6px;
	margin-top: 60px;
	left: 220px;
	z-index: 1;
	position: absolute;
	background-color: white;
}

.feecategorycreateedit-header {
	width: 450px;
	margin-top: -10px;
	border-bottom: 1px solid gray;
	height: 50px;
}

</style>
<div class="feecategorycreateedit">
	<div class="feecategorycreateedit-header">
		<a href="javascript:hidefeecategorycreateedit();" class="close"
			data-dismiss="modal" style="margin-right: 10px; margin-top: 10px;"
			aria-hidden="true">×</a>
		<h3 id="myModalLabel">Change Price</h3>
	</div>
	<div class="row-fluid" style="margin-top: 20px;">
			<div class="block-fluid">
				<div id="appendFeeCategoryId"></div>
				<div class="row-form" style="height: 50px;">
					<div class="span12">
						<span class="top title">Price<font color="red">*</font>
							:-
						</span>
						<input id="changedprice" name="price" value=""
							style="width: 266px; margin-top: -25px; margin-left: 122px;">
						<div id="feeCategoryNamemsg"></div>
					</div>
				</div>
			</div>
		</div>
		<div class="feecategorycreateedit-footer">
			<a href="javascript:updatePrice();"><span
		class="label label-success"  style="margin-left: 332px; height: 23px; width: 46px;"><b>Change</b></span></a>
			
		</div>
	
</div>
<div class="content">
	<div id="content-header" style="height: 150px;">
		<img alt="Show_settings" src="${img_url}/uniform.jpg" style="width: 50px;">
		<h1>Manage Dress Prices</h1>
		<h3>View and edit dress prices</h3>
		<div id="app-back-button">
			<a href="home"><img alt="Back" border="0"
				src="${img_url}/home.png"
				style="margin-top: -6px; height: 40px; width: 40px;"></a> <a
				href="#" onclick="javascript:location.reload(true);"><img
				alt="Back" border="0" src="${img_url}/refresh.png"
				style="margin-top: -6px; height: 40px; width: 40px;"></a> <a
				href="#" onclick="history.back(); return false;"><img alt="Back"
				border="0" src="${img_url}/back.png"
				style="margin-top: -6px; height: 40px; width: 40px;"></a>
		</div>
	</div>

	<div class="row-fluid">
		<div class="span12">
			<div class="block">
				<div class="head blue" style="border-top-width: 10px; margin-top: 46px;">
					<div class="icon">
						<span class="ico-pen-2"></span>
					</div>
					<h2>Manage Dress</h2>
					<ul class="buttons">
						<li>Select Dress
							:- <select name="dressName" id="dressName"  onchange="getDressDetails(this.value);"
								style="width: 270px; margin-left:45px;background-color:gray;">
								<option value="${currentdress.dressId}">${currentdress.dressName}</option>
								<c:forEach var="list" items="${dresslist}">
									<option value="${list.dressId}"> ${list.dressName} </option>
								</c:forEach>
							</select></li>
					</ul>
				</div>
			
				<div class="data-fluid" id="dressDetails">
					<table cellpadding="0" cellspacing="0" width="100%" class="table">
						<thead>
							<tr>
								<th width="25%">Dress Name</th>
								<th width="25%">Category</th>
								<th width="25%">Size</th>
								<th width="25%">Price</th>
								<th width="25%">Operation</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${Dresses}" var="dress">
								<tr>
									<td>${dress.dressName}</td>
									<td>${dress.category}</td>
									<td>${dress.size}</td>
										<td>${dress.price}</td>
									
									<td><a
										href="javascript:editPrices(${dress.dressId})"><span
											class="label label-success">Change</span></a></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>

			</div>
		</div>
	</div>
</div>
<!-- Bootrstrap modal form -->
