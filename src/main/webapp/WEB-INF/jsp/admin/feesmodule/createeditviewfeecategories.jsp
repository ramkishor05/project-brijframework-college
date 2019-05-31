<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<spring:url value="/css" var="css_url" />
<spring:url value="/img" var="img_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/setting.css">
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>CREATE EDIT VIEW FEE CATEGORY</title>
</head>
<script type="text/javascript">
	function showdialogBox(value) {
		$("#appendFeeCategoryId").empty();
		$(".feecategorycreateedit").show();
		$("#myModalLabel").text("Add Fee Category");
	}
	function hidefeecategorycreateedit() {
		$("#feeCategoryNamemsg").empty();
		$("#feeamountmsg").empty();
		$("#feeCategoryName").val('');
		$("#feeAmount").val('');
		$(".feecategorycreateedit").hide();
	}
	function validateform() {
		$("#feeCategoryNamemsg").empty();
		$("#feeamountmsg").empty();
		var flage = true;
		var regex1 = /^[a-zA-Z ]+$/;
		if ($("#feeCategoryName").val() == '') {
			$("#feeCategoryNamemsg").append(
					'<font color="red">This field is required</font>');
			flage = false;
		}
		
		return flage;
	}
	function validname()
	{
		$("#feeCategoryNamemsg").empty();
			$.ajax({
				type : "get",
				url : 'verifyfeecategory',
				data : {
					'name' : $("#feeCategoryName").val(),
								},
				success : function(data) {
				if (data == 'false') {
						$("#feeCategoryNamemsg").append(
						'<font color="red">This category is already created</font>');
						$("#sbmt").hide();
					}
				else
					{
					$("#sbmt").show();
					$("#feeCategoryNamemsg").empty();
					}
				},
				error : function(e) {
				
				}
			});
			}
		
	function editfeecategory(id) {
		$("#appendFeeCategoryId").empty();
		$("#feeCategoryName").val('');
		$("#feeAmount").val('');
		$("#feeCategoryNamemsg").empty();
		$("#feeamountmsg").empty();
		$
				.ajax({
					type : "post",
					url : 'getcategories',
					data : {
						'feeCategoriesId' : +id
					},
					success : function(data) {
						var obj = JSON.parse(data);
						$("#myModalLabel").text("Edit Fee Category");
						$("#appendFeeCategoryId")
								.append(
										'<input type="hidden" name="feeCategoryId" value="'+id+'"/>');
						$("#feeCategoryName").val(obj.feeCategoryName);

						$('#submitform').attr('action',
								'update-fee-categories.html');
						$(".feecategorycreateedit").show();
					},
					error : function(e) {
						
					}
				});
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
		<h3 id="myModalLabel">Add Fee Category</h3>
	</div>
	<f:form commandName="FeesCategoriesDTO"
		action="add-fee-categories.html" id="submitform"
		onsubmit="return validateform();">
		<div class="row-fluid" style="margin-top: 20px;">
			<div class="block-fluid">
				<div id="appendFeeCategoryId"></div>
				<div class="row-form" style="height: 50px;">
					<div class="span12">
						<span class="top title">Fee Category name<font color="red">*</font>
							:
						</span>
						<f:input id="feeCategoryName" maxlength="35" path="feeCategoryName" value="" oninput="validname();"
							style="width: 266px; margin-top: -25px; margin-left: 122px;" />
						<div id="feeCategoryNamemsg"></div>
					</div>
				</div>

			</div>
		</div>
		<div class="feecategorycreateedit-footer" style="float: right">
			<button class="btn btn-primary" data-dismiss="modal" type="submit" id="sbmt"
				aria-hidden="true">Save updates</button>
			<a class="btn btn-warning" data-dismiss="modal"
				href="javascript:hidefeecategorycreateedit();"
				style="margin-right: 15px" aria-hidden="true">Close</a>
		</div>
	</f:form>
</div>
<div class="content">
	<div id="content-header" style="height: 150px;">
		<img alt="Show_settings" src="${img_url}/sfees.jpg" style="width: 50px;">
		<h1>Create View Edit Fee Categories</h1>
		<h3>Manage Fee Categories</h3>
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
			<div class="block" style="margin-top: 43px;">
				<div class="head blue">
					<div class="icon">
						<span class="ico-pen-2"></span>
					</div>
					<h2>Fee Categories</h2>
					<ul class="buttons">
						<li><a href="javascript:showdialogBox('Add Fee Category');"
							role="button" id="addcategory" class="btn btn-primary"
							data-toggle="modal">Add Fee Category</a> 
							</li>
					</ul>
				</div>
				<div class="data-fluid">
					<table cellpadding="0" cellspacing="0" width="100%" class="table">
						<thead>
							<tr>
								<th width="25%">Fee Category Name</th>

								<th width="25%">Action</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${FeeCategories}" var="FeeCategori">
								<tr>
									<td>${FeeCategori.feeCategoryName}</td>

									<td><a
										href="javascript:editfeecategory('${FeeCategori.feeCategoryId}')"><span
											class="label label-success">Edit</span></a>|<a
										href="deletefeecategories.html?feeCategoryId=${FeeCategori.feeCategoryId}"><span
											class="label label-important">Delete</span></a></td>
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
