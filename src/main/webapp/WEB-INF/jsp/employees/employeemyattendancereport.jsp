<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<spring:url value="/" var="baseurl"></spring:url>
<spring:url value="/style/datepicks" var="datepicks" />
<spring:url value="/img" var="img_url" />
<spring:url value="/style" var="style_url" />
<spring:url value="/css" var="css_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/setting.css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Attendance-Report</title>
<script type="text/javascript">
	function getEmployeeAttendanceList() {
		var monthId = $('#monthId').val();
		$
				.ajax({
					type : 'post',
					url : 'show-employee-attendance-list',
					data : {
						'monthId' : monthId
					},
					success : function(data, status) {
						$("#AttendanceList").empty();
						var j = JSON.parse(data);
						var length = j.length;
						var st = "";
						if (length == 0) {
							st = '<div class="alert alert-success"><h5 align="center"><font color="red"><b>No Report Found</b></font></h5></div>';
						} else {
							var st = '<div><div class="widget-body" style="padding: 10px 0 0;"><div class="separator"></div><div class="btn-group" style="width: 1059px;">'
									+ '</div><div class="block"><div class="head blue"><h2>Attendance Report</h2></div>'
									+ '<table class="table table-bordered table-primary"><tr>';
							for ( var i = 0; i < length; i++) {
								st += '<td>' + j[i].dateOfAttendance + '</td>'
							}
							st += '</tr><tr>'
							for ( var i = 0; i < length; i++) {
								if (j[i].attendanceStatus == null) {
									st += '<td style="background-color:yellow;"></td>';
								} else if (j[i].attendanceStatus == 's') {
									st += '<td style="background-color:rgb(237, 168, 173);"></td>';
								} else if (j[i].attendanceStatus == 'PRESENT') {
									st += '<td style="background-color:rgb(139, 239, 139);">P</td>';
								} else if (j[i].attendanceStatus == 'LATE') {
									st += '<td style="background-color:rgb(139, 239, 139);">LP</td>';
								} else if (j[i].attendanceStatus == 'LEAVE') {
									st += '<td style="background-color:rgb(139, 239, 139);">LE</td>';
								} else if (j[i].attendanceStatus == 'ABSENT') {
									st += '<td style="background-color:rgb(244, 56, 88);">A</td>';
								} else if (j[i].attendanceStatus == ' ') {
									st += '<td style=""></td>';
								}
							}
							st = st + '</tr></table>';
							for ( var i = length - 1; i < length; i++) {
								st += '<div><h5>Total no. of days :&nbsp&nbsp&nbsp'
										+ j[i].totalNoOfDays
										+ ' </h5>'
										+ '<h5>Total no. of days Present:&nbsp&nbsp&nbsp'
										+ j[i].noOfDaysPresent
										+ ' </h5>'
										+ '<h5>Percentage Of Attendance :&nbsp&nbsp&nbsp'
										+ j[i].percentageOfAttendance
										+ '%</h5></div>'
							}

							$("#AttendanceList").append(st);
						}

					},
					error : function(error, status) {
						alert(error);
					}
				});
	}
</script>
</head>
<body>
	<div id="content_wrapper">
		<div id="side_bar">

			<div id="sidebar_news_area"></div>
		</div>
		<div id="content">





			<div id="content-header">
				<img alt="Show_settings" src="${img_url}/attendance.jpg"
					style="width: 74px; height: 74px;">
				<h1>Attendance</h1>
				<h3>My Attendance Report</h3>
				<div id="app-back-button">
					<a href="home"><img alt="Back" border="0"
						src="${img_url}/home.png"
						style="margin-top: -6px; height: 40px; width: 40px;"></a> <a
						href="#" onclick="javascript:location.reload(true);"><img
						alt="Back" border="0" src="${img_url}/refresh.png"
						style="margin-top: -6px; height: 40px; width: 40px;"></a> <a
						href="#" onclick="history.back(); return false;"><img
						alt="Back" border="0" src="${img_url}/back.png"
						style="margin-top: -6px; height: 40px; width: 40px;"></a>
				</div>
			</div>

			<div id="page-yield">


				<div class="row-form">
					<div class="span2">
						Select Month :<font color="red">*</font>
					</div>
					<div class="span4">
						<select id="monthId" onchange="getEmployeeAttendanceList();">
							<option value="">Select Month</option>
							<c:forEach var="month" items="${monthList}">
								<option value="${month.monthId}">${month.monthName}</option>
							</c:forEach>
						</select>
					</div>
				</div>
				<hr>
				<div id="AttendanceList"></div>
			</div>


		</div>
	</div>

	<div class="extender"></div>
</body>
</html>