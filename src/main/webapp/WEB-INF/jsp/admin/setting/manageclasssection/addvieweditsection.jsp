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
<title>CREATE EDIT VIEW FEE CATEGORY</title>
</head>
<script type="text/javascript">
	function showdialogBox(value) {
		$("#appendFeeCategoryId").empty();
		$(".feecategorycreateedit").show();
		$("#successmsg").hide();
		$("#submitbutton").show();
		if(value=='Add Class'){
			$('#submitform').attr('action', 'add-section.html');
		}
		else{
			$('#submitform').attr('action', 'update-section.html');
		}
	}
	function hidefeecategorycreateedit() {
		$('#className').prop('selectedIndex', 0);
		$("#feeCategoryNamemsg").empty();
		$("#sectionName").val('');
		$(".feecategorycreateedit").hide();
		$("#successmsg").hide();
		$("#submitbutton").show();
	}
	function validateform() {
		$("#feeCategoryNamemsg").empty();
		var flage = true;
		if ($("#sectionName").val() == '') {
			$("#feeCategoryNamemsg").append(
					'<font color="red">this field is required</font>');
			flage = false;
		}
		var regex1 = /^[a-zA-Z]*[a-zA-Z ]+$/;
		if (!regex1.test($("#sectionName").val())) {
			$("#feeCategoryNamemsg").append(
					'<font color="red">Enter only Letters</font>');
			flage = false;
		}
		return flage;
	}
	function editSection(id) {
		$("#appendFeeCategoryId").empty();
		$("#sectionName").val('');
		$("#feeCategoryNamemsg").empty();
		$
				.ajax({
					type : "post",
					url : 'getsection',
					data : {
						'sectionId' : id
					},
					success : function(data) {
						var obj = JSON.parse(data);
						$("#myModalLabel").text("Edit Section");
						$("#appendFeeCategoryId")
								.append(
										'<input type="hidden" name="sectionId" value="'+id+'"/>');
						$('#className').val(obj.classId);
						$("#sectionName").val(obj.sectionName);
						$("#hiddensectionname").val(obj.sectionName);
						$('#submitform').attr('action', 'update-section.html');
						$(".feecategorycreateedit").show();
					},
					error : function(e) {
						alert('Error: ' + e);
					}
				});
	}
	function checkClassName(sectionName) {
		$.ajax({
			type : "post",
			url : 'check_section_name',
			data : {
				'classId' : $("#className").val(),
				'sectionName' : sectionName
			},
			success : function(data) {
				var obj = JSON.parse(data);
				if (obj == 'YES') {
					if ($("#hiddensectionname").val() != sectionName) {
						$("#successmsg").show();
						$("#submitbutton").hide()
					}
				} else {
					$("#successmsg").hide();
					$("#submitbutton").show()
				}
			},
			error : function(e) {
				alert('Error: ' + e);
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
	height: 287px;
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
		<h3 id="myModalLabel">Add Section</h3>
	</div>
	<f:form commandName="Section" action="add-section.html" id="submitform"
		onsubmit="return validateform();">
		<div class="row-fluid" style="margin-top: 20px;">
			<div class="block-fluid">
				<div id="appendFeeCategoryId"></div>
				<div class="row-form" style="height: 50px;">
					<div class="span12">
						<span class="top title">Class Name<font color="red">*</font>
							:- <f:select path="studentClasses.classId" id="className"
								style="width: 270px; margin-left:45px;">
								<option value="">--select class name--</option>
								<c:forEach var="list" items="${StudentClasses}">
									<f:option value="${list.classId}"> ${list.className} </f:option>
								</c:forEach>
							</f:select></span>

					</div>
				</div>
			</div>
		</div>
		<div class="row-fluid" style="margin-top: 20px;">
			<div class="block-fluid">
				<div id="appendFeeCategoryId"></div>
				<div class="row-form" style="height: 50px;">
					<div class="span12">
						<span class="top title">Section Name<font color="red">*</font>
							:-
						</span>
						<f:input id="sectionName" path="sectionName" value=""
							onkeyup="checkClassName(this.value);" maxlength="2"
							style="width: 266px; margin-top: -25px; margin-left: 122px;" />
						<div id="feeCategoryNamemsg"></div>
						<input type="hidden" id="hiddensectionname">
						<div id="successmsg" style="display: none;">
							<font color="red">This Section Exist</font>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div id="feeCategoryNamemsg"></div>
		<div class="feecategorycreateedit-footer" style="float: right">
			<button class="btn btn-primary" data-dismiss="modal" type="submit"
				id="submitbutton" aria-hidden="true">Save updates</button>
			<a class="btn btn-warning" data-dismiss="modal"
				href="javascript:hidefeecategorycreateedit();"
				style="margin-right: 15px" aria-hidden="true">Close</a>
		</div>
	</f:form>
</div>
<div class="content">
	<div id="content-header" style="height: 150px;">
		<img alt="Show_settings" src="${img_url}/class.jpg"
			style="width: 50px;">
		<h1>Create View Edit Sections</h1>
		<h3>Manage Sections</h3>
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
				<div class="head blue"
					style="border-top-width: 10px; margin-top: 46px;">
					<div class="icon">
						<span class="ico-pen-2"></span>
					</div>
					<h2>Section</h2>
					<ul class="buttons">
						<li><a href="javascript:showdialogBox('Add Class');"
							role="button" id="addcategory" class="btn btn-primary"
							data-toggle="modal">Add Section</a></li>
					</ul>
				</div>
				<%-- <c:if test="${StudentClasses.}"></c:if> --%>
				<div class="data-fluid">
					<table cellpadding="0" cellspacing="0" width="100%" class="table">
						<thead>
							<tr>
								<th width="25%">Class Name</th>
								<th width="25%">Section Name</th>
								<th width="25%">Action</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${Sections}" var="sections">
								<tr>
									<td>${sections.className}</td>
									<td>${sections.sectionName}</td>
									<td><a
										href="javascript:editSection(${sections.sectionId});"><span
											class="label label-success">Edit</span></a><%-- |<a
										href="deletesection.html?sectionId=${sections.sectionId}"><span
											class="label label-important">Delete</span></a> --%></td>
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
