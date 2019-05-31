<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<spring:url value="/css" var="css_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/setting.css">
<spring:url value="/js" var="js_url" />
<spring:url value="/" var="baseUrl" />
<spring:url value="/img" var="img_url" />
<c:url value="/style/theme/images" var="hr1" />
<c:url value="/style/theme/images" var="backurl" />

<link rel="stylesheet"
	href="${js_url}/fullcalendar/jquery-ui-1.10.4.custom.min.css">
<div class="content">
	<div id="content-header" style="height: 150px;">
		<img alt="Show_settings" src="${img_url}/empatt.jpg"
			style="width: 57px;">
		<h1>Employee Attendance</h1>
		<h3>Employee Attendance Report</h3>
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

	<script type="text/javascript">
		function getEmployeeAttendanceList() {
			var fromDate = $('#fromDate').val();
			var toDate = $('#toDate').val();
			$
					.ajax({
						type : 'post',
						url : 'show-employees-attendance-list',
						data : {
							'fromDate' : fromDate,
							'toDate' : toDate
						},
						success : function(data, status) {
							$("#AttendanceList").empty();
							var cDate = new Date;
							var dmy = cDate.getFullYear() + '-'
									+ (cDate.getMonth() + 1) + '-'
									+ cDate.getDate();
							var j = JSON.parse(data);
							var length = j.length;
							var st = '<div style="float:right;"><a target="_blank" href="view-employee-report-as-pdf?fromDate='
									+ fromDate
									+ '&toDate='
									+ toDate
									+ '"></a></div><div><div class="widget-body" style="padding: 10px 0 0;"><div class="separator"></div><div class="btn-group" style="width: 1059px;">'
									+ '</div><div class="block" style="width: 100%; overflow: scroll; "><div class="head blue" style="width: 100%;"><div class="icon"><span class="ico-pen-2"></span></div><h2>Attendance Report</h2></div>'
									+ '<table class="table table-bordered table-primary"><tr><td>Name</td>';
							var arr = [];
							for (var i = 0; i < 1; i++) {
								var attenDanceList = j[i].employeeAttendanceDTOs;
								for (var k = 0; k < attenDanceList.length; k++) {
									arr
											.push(attenDanceList[k].dateOfAttendance);
									st = st
											+ '<td><b>'
											+ attenDanceList[k].dateOfAttendance
											+ '</td>';
								}
								st += '<td><b>Action</b></td>';
							}

							for (var i = 0; i < length; i++) {
								var attenDanceList = j[i].employeeAttendanceDTOs;

								st = st + '</tr><tr><td><b>' + j[i].fullName
										+ '</b></td>';
								if (attenDanceList.length == 0) {
									for (var m = 0; m < arr.length; m++)
										st += '<td>-</td>';
								}

								for (var m = 0, l = 0; m < arr.length - 1,
										l < attenDanceList.length; m++, l++) {

									if (arr[m] == attenDanceList[l].dateOfAttendance) {

										st += '<td>'
												+ attenDanceList[l].attendanceStatus
												+ '</td>';

									} else {
										st += '<td>-</td>';
										if (attenDanceList.length < arr.length
												&& m < arr.length - 1) {
											l--;
										}
									}
								}
								st += '<td><a target="_blank" href="view-employee-report-as-pdf?fromDate='
										+ fromDate
										+ '&toDate='
										+ toDate
										+ '&id='
										+ j[i].id
										+ '"><img src="${img_url}/pdf.png" target="_blank"/></a></td></tr>';
							}
							st = st + '</table>';
							$("#AttendanceList").append(st);
						},
						error : function(error, status) {

						}
					});
		}
	</script>

	<div class="row-form">
		<div class="span2">
			Select From Date :<font color="red">*</font>
		</div>
		<div class="span4">
			<input type="text" class="datepicker validate[required]"
				placeholder="Select From Date" id="fromDate">
		</div>
	</div>

	<div class="row-form">
		<div class="span2">
			Select To Date :<font color="red">*</font>
		</div>
		<div class="span4">
			<input type="text" class="datepicker validate[required]"
				placeholder="Select To Date" id="toDate"
				onchange="getEmployeeAttendanceList();">
		</div>
	</div><br>
	<hr><br>
	<div id="AttendanceList"></div>
</div>