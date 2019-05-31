<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>CREATE EDIT VIEW FEE CATEGORY</title>
</head>
<script type="text/javascript">
	function showdialogBox(value) {
		$("#appendFeeCategoryId").empty();
		$(".feecategorycreateedit").show();
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
		if ($("#feeCategoryName").val() == '') {
			$("#feeCategoryNamemsg").append(
					'<font color="red">this field is required</font>');
			flage = false;
		}
		if ($("#feeAmount").val() == '') {
			$("#feeamountmsg").append(
					'<font color="red">this field is required</font>');
			flage = false;
		} 
		if(!$.isNumeric($("#feeAmount").val())){
			$("#feeamountmsg").append(
			'<font color="red">Numeric Value Only</font>');
			flage = false;
		}
		return flage;
	}
	function editfeecategory(id) {
		$("#appendFeeCategoryId").empty();
		$("#feeCategoryName").val('');
		$("#feeAmount").val('');
		$("#feeCategoryNamemsg").empty();
		$("#feeamountmsg").empty();
		$.ajax({
			type : "post",
			url : 'getcategory',
			data : {
				'feeCategoryId' : +id
			},
			success : function(data) {
				var obj = JSON.parse(data);
				$("#myModalLabel").text("Edit Fee Category");
				$("#appendFeeCategoryId").append(
						'<input type="hidden" name="feeCategoryId" value="'+id+'"/>');
				$("#feeCategoryName").val(obj.feeCategoryName);
				$("#feeAmount").val(obj.feeAmount);
				$('#submitform').attr('action', 'update-fee-category.html');
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
	<f:form commandName="FeeCategoryDTO" action="add-fee-category.html" id="submitform"
		onsubmit="return validateform();">
		<div class="row-fluid" style="margin-top: 20px;">
			<div class="block-fluid">
				<div id="appendFeeCategoryId"></div>
				<div class="row-form" style="height: 50px;">
					<div class="span12">
						<span class="top title">Fee Category name<font color="red">*</font>
							:
						</span>
						<f:input id="feeCategoryName" path="feeCategoryName" value="" maxlength="45"
							style="width: 266px; margin-top: -25px; margin-left: 122px;" />
						<div id="feeCategoryNamemsg"></div>
					</div>
				</div>
				<div class="row-form" style="height: 50px;">
					<div class="span12">
						<span class="top title">Fee Amount<font color="red">*</font>:
						</span>
						<f:input id="feeAmount" path="feeAmount" value="" maxlength="11"
							style="width: 266px; margin-top: -25px; margin-left: 122px;" />
						<div id="feeamountmsg"></div>
					</div>
				</div>
			</div>
		</div>
		<div class="feecategorycreateedit-footer" style="float: right">
			<button class="btn btn-primary" data-dismiss="modal" type="submit"
				aria-hidden="true">Save updates</button>
			<a class="btn btn-warning" data-dismiss="modal"
				href="javascript:hidefeecategorycreateedit();"
				style="margin-right: 15px" aria-hidden="true">Close</a>
		</div>
	</f:form>
</div>
<div class="content">
	<div class="page-header">
		<div class="icon">
			<span class="ico-layout-7"></span>
		</div>
		<h1>
			Manage Fee Category <small>Create Edit View Fee Category</small>
		</h1>
	</div>
	<div class="row-fluid">
		<div class="span12">
			<div class="block">
				<div class="head blue">
					<div class="icon">
						<span class="ico-pen-2"></span>
					</div>
					<h2>Fee Categories</h2>
					<ul class="buttons">
						<li><a href="javascript:showdialogBox('Add Fee Category');"
							role="button" id="addcategory" class="btn btn-primary"
							data-toggle="modal">Add Fee Category</a> <!-- <a href="#"
							onClick="source('table_default'); return false;"><div
									class="icon">
									<span class="ico-info"></span>
								</div></a> --></li>
					</ul>
				</div>
				<div class="data-fluid">
					<table cellpadding="0" cellspacing="0" width="100%" class="table">
						<thead>
							<tr>
								<th width="25%">Fee Category Name</th>
								<th width="25%">Fee Category Amount</th>
								<th width="25%">Action</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${FeeCategorys}" var="FeeCategori">
								<tr>
									<td>${FeeCategori.feeCategoryName}</td>
									<td>${FeeCategori.feeAmount}</td>
									<td><a href="javascript:editfeecategory('${FeeCategori.feeCategoryId}')"
										><span class="label label-success">Edit</span></a>|<a
										href="deletefeecategory.html?feeCategoryId=${FeeCategori.feeCategoryId}"><span class="label label-important">Delete</span></a></td>
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
