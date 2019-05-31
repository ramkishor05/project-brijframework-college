<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url value="/style/theme/images" var="imageurl" />
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/img" var="img_url" />
<spring:url value="/css" var="css_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/setting.css">
<spring:url value="/img" var="img" />
<style>
#err {
	color: red;
	font-weight: normal;
	font-size: 20px;
	padding: 2px 8px 0px;
	margin-top: 2px;
	margin-bottom: -2px;
}
</style>
<script>
	function getTodayGatePass() {
		var dates=$("#leavingDate").val();
		$("#GatePassList").empty();
		$("#GatePassList")
				.append('<center><img src="${img}/loads.gif" alt="Loading" style="width=200px;height=200px;"></center>');
		
		$
		.ajax({
			type : "post",
			url : 'gettodaygatepass',
			data : {
				'dates' : dates,

			},
					success : function(data, status) {
						$("#GatePassList").empty();
						var j = JSON.parse(data);
						var st = "";
						var length = j.length;
						if (length == 0) {
							st = '<div class="failedmsg">No Gate Pass Issued on the selected date</div>';
						} else {
                        	st = st
									+ '<div><div class="widget-body"  style="padding: 10px 0px 0px; margin-top: -50px;"><div class="separator"></div><div class="btn-group" style="width: 400px;">'
									+ '</div><div class="block"><div class="head blue"><h4 style="text-align:center">Gate Pass Details</h4></div>'
									+ '<table class="table table-bordered table-primary"><thead><tr><th>S.no</th><th>Student Name</th><th>Student Id</th><th>Father Name</th><th>Class</th><th>Section</th><th>Mobile<th>Time</th><th>Accompanied By</th><th>Reason</th></tr></thead><tbody>';
							for ( var i = 0; i < length; i++) {
								st += '<tr><td>' + (i + 1) + '. </td><td>'
								+ j[i].firstName + " "
								+ j[i].middleName + " " + j[i].lastName
								+ '</td><td>' + j[i].studentId
								+ '</td><td>' + j[i].fatherName
								+ '</td><td>' + j[i].className
								+ '</td><td>' + j[i].sectionName
								+ '</td><td>' + j[i].mobile
								+ '</td><td>' + j[i].leavingTime
								+ '</td><td>' + j[i].leavingWith
								+ '</td><td>' + j[i].reason
								+ '</td></tr>';
							}
							st += '</table>';
									
						}
						$("#GatePassList").append(st);
					},
					error : function(error, status) {
					}
				});
	}
	

	window.onload = function() {
		
		getTodayGatePass();
	}
</script>
<div class="content">
	<div id="content-header" style="height: 150px;">
		<img alt="Show_settings" src="${img_url}/gates.png"
			 style="width: 126px;">
		<h1>Gate Pass List</h1>
		<h3>Check Details of Issued Gate Pass</h3>
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


	<br>

	<table
		style="width: 700px; height: 200px; margin-left: 231px; margin-top: -50px;">

		<tr>
			<td style="width: 200px;">Date</td>
			<td><input id="leavingDate" type="text" value="${today}"
				onchange="getTodayGatePass();" style="width: 250px;" readonly="readonly"
				name="LeavingDate" class="datepicker validate[required]">
				</td>

		</tr>




	</table>

	<div class="separator"></div>
	<hr>
	<div id="GatePassList"></div>
	<div class="separator"></div>

	<div id="err" class="form-inline">
		<p id="v1"></p>

	</div>


</div>
