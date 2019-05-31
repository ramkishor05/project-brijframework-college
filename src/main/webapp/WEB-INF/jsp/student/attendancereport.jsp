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
	function getStudentAttendanceList() {
		var monthId = $('#monthId').val();
		$
				.ajax({
					type : 'post',
					url : 'show-student-attendance-list',
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
							st = '<div style="margin-left: -20px;"><div class="widget-body" style="padding: 10px 0 0;"><div class="separator"></div><div class="btn-group" style="wid">'
									+ '</div><div class="block"><div class="head blue" style=" height: 43px;"><h3 style="padding-left: 30px;">Attendance Report</h3></div>'
									+ '<table class="table table-bordered table-primary"><thead><tr>';
							for ( var i = 0; i < length; i++) {
								st += '<th>' + j[i].attendanceDate + '</th>'
							}
							st += '</tr></thead><tbody><tr>'
							for ( var i = 0; i < length; i++) {
								if (j[i].attendanceStatus == null) {
									st += '<td></td>';
								} else if (j[i].attendanceStatus == 's') {
									st += '<td style="background-color:red;"></td>';
								} else {
									if (j[i].attendanceStatus == 'PRESENT')
										st = st + '<td>P</td>';
									else if (j[i].attendanceStatus == 'ABSENT')
										st = st + '<td>A</td>';
									else if (j[i].attendanceStatus == 'LATE')
										st = st + '<td>LP</td>';
									else if (j[i].attendanceStatus == 'LEAVE')
										st = st + '<td>L</td>';
									else
										st = st + '<td>'
												+ j[i].attendanceStatus
												+ '</td>';
								}

							}

							st = st + '</tr></tbody></table></div></div></div>';
							for ( var i = length - 1; i < length; i++)
								st += '<h5>Total no. of days Present:&nbsp&nbsp&nbsp'
										+ j[i].totalPresent
										+ '/'
										+ j[i].totalAttendance
										+ ' </h5>'
										+ '<h5>Total no. of days Absent:&nbsp&nbsp&nbsp'
										+ j[i].totalAbsent + '</h5>'
										+ '<h5>Total no. of days Late:&nbsp&nbsp&nbsp'
										+ j[i].totalLate + '</h5>'
										+ '<h5>Total no. of days Leave:&nbsp&nbsp&nbsp'
										+ j[i].totalLeave + '</h5>'
										+ '<h5>Attendance Percentage:&nbsp&nbsp&nbsp'
										+ j[i].percent + '</h5>'
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
				<img alt="Show_settings" src="${img_url}/stuatt.png"
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
				href="#" onclick="history.back(); return false;"><img alt="Back"
				border="0" src="${img_url}/back.png"
				style="margin-top: -6px; height: 40px; width: 40px;"></a>
		</div>
			</div>
<div id="new" style="float: right;">
	<table><tr>
	<td>*P-Present</td></tr><tr>
	<td>*A-Absent</td></tr><tr>
	<td>*L-Leave</td></tr><tr>
	<td>*LP-Late Present</td></tr></table>
	</div>
			<div id="page-yield">
				<div class="row-form">
					<div class="span2">
						Select Month :<font color="red">*</font>
					</div>
					<div class="span4">
						<select id="monthId" onchange="getStudentAttendanceList();">
							<option value="">Select Month</option>
							<c:forEach var="month" items="${monthList}">
								<option value="${month.monthId}">${month.monthName}</option>
							</c:forEach>
						</select>
					</div>
				</div>
				<div id="AttendanceList"></div>
			</div>


		</div>
	</div>

	<div class="extender"></div>
</body>
</html>