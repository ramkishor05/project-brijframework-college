<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/css" var="css_url" />
<spring:url value="/img" var="img_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/setting.css">
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<script type="text/javascript">
	function showdialogBox(value) {
		$("#appendFeeCategoryId").empty();
		$(".feecategorycreateedit").show();
		$("#documentName").val('');
		$("#documentType").val('Student');
		$('#submitform').attr('action', 'add-document-category');
	}
	function hidefeecategorycreateedit() {
		$("#feeCategoryNamemsg").empty();
		$(".feecategorycreateedit").hide();
	}
	function validateform() {
		$("#feeCategoryNamemsg").empty();
		var flage = true;
		if ($("#documentName").val() == '') {
			$("#feeCategoryNamemsg").append(
					'<font color="red">*This field is required</font>');
			flage = false;
		}

		return flage;
	}
	function getDocuments(type) {
		$('#duedates').empty();
		if (type != '') {
			$
					.ajax({
						type : "post",
						url : 'get-documentbyType',
						data : {
							'type' : type,
						},
						success : function(data) {
							var j = JSON.parse(data);
							if (j.length == 0) {
								var duedates = '<span><font color="red">No record found</font></color>';
							} else {

								var duedates = '<table cellpadding="0" cellspacing="0" width="100%" class="table"><thead>'
										+ '<tr><th width="50%">Category</th><th width="50%">Name</th><th width="50%">Operations</th><th></th></tr></thead><tbody>'
								$
										.each(
												j,
												function(key, value) {
													duedates += '<tr><td>'
															+ value.documentType
															+ '</td><td>'
															+ value.documentName
															+ '</td><td><a href="javascript:editDocument('
															+ value.documentCategoryId
															+ ')"><span'
									+' class="label label-success">Update</span></a></td><td><a href="delete-document-category?id='
															+ value.documentCategoryId
															+ '"><span'
									+' class="label label-important">Delete</span></a></td></tr>';
												});

								duedates += '</tbody></table>';
							}
							$('#duedates').append(duedates);
						},
						error : function(e) {

						}
					});
		} else {
			alert("Select Category")
		}
	}
	function editDocument(id) {
		$
		.ajax({
			type : "post",
			url : 'get-documentbyId',
			data : {
				'id' : id,
			},
			success : function(data) {
				
				var j = JSON.parse(data);
				
				$("#documentName").val(j.documentCategoryName);
				$("#documentType").val(j.documentType);
			},
			error : function(e) {

			}
		});
		$("#appendFeeCategoryId").empty();
		$("#feeCategoryNamemsg").empty();
        $("#myModalLabel").text("Edit Document Category");
		$("#appendFeeCategoryId")
				.append(
						'<input type="hidden" name="documentCategoryId" value="'+id+'"/>');
		$('#submitform').attr('action', 'edit-document-category');
		$(".feecategorycreateedit").show();
	}
</script>
<style>
.feecategorycreateedit {
	display: none;
	background-color: white;
	border: 1px solid grey;
	width: 450px;
	height: 240px;
	border-radius: 6px;
	margin-top: 170px;
	left: 230px;
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

	<f:form commandName="documentCategoryDTO" id="submitform"
		onsubmit="return validateform();">

		<div class="row-fluid" style="margin-top: 20px;">
			<div class="block-fluid">
				<div id="appendFeeCategoryId"></div>
				<div class="row-form" style="height: 50px;">
					<div class="row-form" id="months">
						<div class="span4">
							<font color="red">*</font>Select Type :
						</div>
						<div class="span5" style="margin-left: 39px;">
							<select name="documentType" class="form-control input-sm"
								style="width: 200px;" id="documentType" x-data-toggle-x="tooltip"
								title="Specify the Category"
								data-original-title="Specify session">

								<option value="Student">Student</option>
								<option value="Employee">Employee</option>

							</select>
						</div>
					</div>
					<div class="row-form">
						<div class="span4" style="width: 150px;">
							<font color="red">*</font>Document Name :
						</div>
						<div class="span5">
							<f:input id="documentName" path="documentName" value=""
								class="validate[required]" style="width: 200px;" />
						</div>
					</div>
					<div class="row-form">
						<div id="feeCategoryNamemsg"></div>
					</div>
				</div>
			</div>
		</div>
		<div class="feecategorycreateedit-footer"
			style="float: right; margin-top: 40px;">
			<button class="btn btn-primary" data-dismiss="modal" type="submit"
				aria-hidden="true">Save</button>
			<a class="btn btn-warning" data-dismiss="modal"
				href="javascript:hidefeecategorycreateedit();"
				style="margin-right: 85px" aria-hidden="true">Close</a>
		</div>
	</f:form>
</div>
<div class="content">
	<div id="content-header" style="height: 150px;">
		<img alt="Show_settings" src="${img_url}/document.jpg"
			style="width: 50px;">
		<h1>Manage Documents</h1>
		<h3>Manage Document Categories</h3>
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

	<br> <br>

	<div
		class="widget widget-2 widget-tabs widget-tabs-2 tabs-right border-bottom-none"
		style="margin-top: -69px;"></div>
	<div class="row-form" style="margin-top: -93px;">
		<div class="span2">
			Select Category :<font color="red">*</font>
		</div>
		<div class="span4" style="z-index: -1;">
			<select name="type" class="form-control input-sm"
				style="width: 200px;" id="type" x-data-toggle-x="tooltip"
				onchange="getDocuments(this.value);"
				data-original-title="Specify session">
				<option value="">Choose Document For</option>
				<option value="Student">Student</option>
				<option value="Employee">Employee</option>
			</select>
		</div>
	</div>

	<c:if test="${msg!=null}">
		<div class="successmsg"
			style="height: 24px; margin-top: 51px; margin-bottom: -47px;">
			<h5 align="center">${msg}</h5>
		</div>
	</c:if>


	<div class="row-fluid">
		<div class="span12">
			<div class="block">
				<div class="head blue"
					style="border-top-width: 10px; margin-top: 79px;">
					<div class="icon">
						<span class="ico-pen-2"></span>
					</div>
					<h2>Document Categories</h2>
					<ul class="buttons">
						<li><a
							href="javascript:showdialogBox('Add Document Category');"
							role="button" id="addcategory" class="btn btn-primary"
							data-toggle="modal">Add Document Category</a></li>
					</ul>
				</div>
				<div class="data-fluid" id="duedates"></div>
			</div>
		</div>
	</div>
</div>