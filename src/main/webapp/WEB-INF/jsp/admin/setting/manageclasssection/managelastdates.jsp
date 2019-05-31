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
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>CHANGE DUE DATES</title>
</head>
<script type="text/javascript">
	function showdialogBox(value) {
		$("#appendFeeCategoryId").empty();
		$(".feecategorycreateedit").show();
		$("#months").show();
		$('#session').val($('#sessionId').val());
		$('#submitform').attr('action', 'create-lastdate.html');
	}
	function hidefeecategorycreateedit() {
		$("#feeCategoryNamemsg").empty();
		$(".feecategorycreateedit").hide();
	}
	function validateform() {
		$("#feeCategoryNamemsg").empty();
		var flage = true;
		if ($("#lastdate").val() == '') {
			$("#feeCategoryNamemsg").append(
					'<font color="red">*This field is required</font>');
			flage = false;
		}

		return flage;
	}
	function editLastDate(id) {
		var s = $("#sessionId").val();

		$("#appendFeeCategoryId").empty();
		$("#months").hide();
		$("#feeCategoryNamemsg").empty();

		$("#myModalLabel").text("Change Last Date");
		$("#appendFeeCategoryId")
				.append(
						'<input type="hidden" name="lastdateId" value="'+id+'"/><input type="hidden" name="sessionId" value="'+s+'"/>');
		$('#submitform').attr('action', 'update-lastdate.html');
		$(".feecategorycreateedit").show();
	}
	function getLastDateList(sessionId) {
		if (sessionId != '') {
			$
					.ajax({
						type : "post",
						url : 'getduedatebysessionid',
						data : {
							'sessionId' : sessionId,
						},
						success : function(data) {
							var j = JSON.parse(data);
							$('#duedates').empty();
							var duedates = '<table cellpadding="0" cellspacing="0" width="100%" class="table"><thead>'
									+ '<tr><th width="50%">Month</th><th width="50%">Due Date</th><th width="50%">Operation</th></tr></thead><tbody>'
							$.each(j, function(key, value) {
								duedates += '<tr><td>' + value.monthName
										+ '</td><td>' + value.lastdate
										+ '</td><td><a href="javascript:editLastDate('+value.lastdateId+')"><span'
										+' class="label label-success">Change</span></a></td></tr>';
							});

							duedates += '</tbody></table>';
							$('#duedates').append(duedates);
						},
						error : function(e) {
							alert('Error: ' + e);
						}
					});
		} else {
			alert("Select Valid Session")
		}
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

	<f:form commandName="LastDateDTO" id="submitform"
		onsubmit="return validateform();">

		<div class="row-fluid" style="margin-top: 20px;">
			<div class="block-fluid">
				<div id="appendFeeCategoryId"></div>
				<div class="row-form" style="height: 50px;">
					<input type="hidden" id="session" name="sessionId">
					<div class="row-form" id="months">
						<div class="span4">
							<font color="red">*</font>Select Month :
						</div>
						<div class="span5">
							<select name="monthId" class="form-control input-sm"
								style="width: 200px;" id="monthId" x-data-toggle-x="tooltip"
								title="Specify the month of the due date"
								data-original-title="Specify session">
									<c:forEach var="month" items="${months}" begin="0"
					end="${fn:length(months)-2}">
					<option value="${month.monthId}">${month.monthName}</option>
				</c:forEach>
							</select>
						</div>
					</div>
					<div class="row-form">
						<div class="span4">
							<font color="red">*</font>Due Date :
						</div>
						<div class="span5">
							<f:input id="lastdate" path="lastdate" value=""
								class="datepicker validate[required]" style="width: 200px;" />
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
		<img alt="Show_settings" src="${img_url}/class.jpg"
			style="width: 50px;">
		<h1>Manage Due Dates</h1>
		<h3>Change Fee Payment Last Dates</h3>
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
			Select Session :<font color="red">*</font>
		</div>
		<div class="span4" style="z-index: -1;">
			<select name="sessionId" class="form-control input-sm"
				style="width: 200px;" id="sessionId" x-data-toggle-x="tooltip"
				title="Specify the session of the student"
				onchange="getLastDateList(this.value);"
				data-original-title="Specify session">
				<c:forEach var="list" items="${sessionList}">
					<c:choose>
						<c:when test="${current.sessionId==list.sessionId}">
							<option selected="selected" value="${list.sessionId}">${list.sessionDuration}</option>
						</c:when>
						<c:otherwise>
							<option value="${list.sessionId}">${list.sessionDuration}</option>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</select>
		</div>
	</div>
	<div
		style="text-align: center; color: red; margin-top: 15px; margin-bottom: -45px;">
		<span style="color: red;">${msg}</span><span style="color: green;">${msg1}</span>
	</div>

	<c:if test="${result=='true'}">
		<div class="successmsg" style="height: 24px; margin-top: 51px; margin-bottom: -47px;">
			<h5 align="center">
				Updated Successfully
			</h5>
		</div>
	</c:if>
	<c:if test="${result=='false'}">
		<div class="failedmsg" style="height: 24px; margin-top: 51px; margin-bottom: -47px;">
			<h5 align="center">
				Payment Already Done for this month
			</h5>
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
					<h2>Monthly Due Dates</h2>
					<ul class="buttons">
						<li><a href="javascript:showdialogBox('Create Due Dates');"
							role="button" id="addcategory" class="btn btn-primary"
							data-toggle="modal">Create Due Date</a></li>
					</ul>
				</div>
				<div class="data-fluid" id="duedates">
					<table cellpadding="0" cellspacing="0" width="100%" class="table">
						<thead>
							<tr>
								<th width="50%">Month</th>
								<th width="50%">Due Date</th>
								<th width="25%">Action</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${lastdates}" var="list">
								<tr>
									<td>${list.monthName}</td>
									<td>${list.lastdate}</td>
									<td><a href="javascript:editLastDate(${list.lastdateId})"><span
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
