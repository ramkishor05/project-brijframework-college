<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<spring:url value="/" var="baseurl"></spring:url>
<spring:url value="/img" var="img_url" />
<spring:url value="/style" var="style_url" />
<spring:url value="/css" var="css_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/setting.css">


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
	function getSectionList(id) {
		$('#sectionId').val('');
		$('#monthId').val('');
		$.ajax({
			type : "post",
			url : 'getsectionlist/' + id,
			success : function(data, status) {
				$("#sectionId").empty();
				var j = JSON.parse(data);
				var content = '<option value="">Select Section</option>';
				for (var i = 0; i < j.length; i++) {
					content += '<option value='+j[i].sectionId+'>'
							+ j[i].sectionName + '</option>';
				}
				$("#sectionId").append(content);
			},
			error : function(e) {
				alert('Error: ' + e);
			}
		});
	}
	function getStudentAttendanceList(monthId) {

		var classId = $('#classId').val();
		var sectionId = $('#sectionId').val();
		if (classId == '' || sectionId == '') {
			alert("Select Class Section First.");
		} else {
			$
					.ajax({
						type : 'post',
						url : 'students-attendance-report',
						data : {
							'classId' : classId,
							'sectionId' : sectionId,
							'monthId' : monthId
						},
						success : function(data, status) {
							$("#AttendanceList").empty();
							var j = JSON.parse(data);
							var studentAtt = j[0].studentAttendanceDTOs;
							var length = j.length;
							var st = "";
							if (length == 0) {
								st = '<div class="alert alert-success"><h5 align="center"><font color="red"><b>No Report Found</b></font></h5></div>';
							} else {
								st = '<div style="float:right;"><a target="_blank" href="view-student-report-as-pdf?classId='
										+ classId
										+ '&sectionId='
										+ sectionId
										+ '&monthId='
										+ monthId
										+ '"><img title="Generate PDF" src="${img_url}/pdf.png"></a><a target="_blank" href="view-student-report-as-excel?classId='
										+ classId
										+ '&sectionId='
										+ sectionId
										+ '&monthId='
										+ monthId
										+ '"><img title="Generate Excel" src="${img_url}/excels.jpg"></a></div><div><div class="widget-body" style="padding: 10px 0 0;"><div class="separator"></div><div class="btn-group" style="width: 1059px;">'
										+ '</div><div class="block" style="left: -13px;"><div class="head blue" style="width: 1077px; margin-left: -1px;"><div class="icon"><span class="ico-pen-2"></span></div><h2>Attendance Report</h2></div>'
										+ '<table class="table table-bordered table-primary"><thead><tr><th>Roll No.</th><th>Name</th>';
								for (var i = 0; i < studentAtt.length; i++) {
									st += '<th>' + studentAtt[i].attendanceDate
											+ '</th>'
								}
								st += '</tr></thead><tbody>'
								for (var i = 0; i < length; i++) {
									st += '<tr><td>' + j[i].rollno + '</td>'
									st += '<td>' + j[i].fullName + '</td>'
									var stuAtt = j[i].studentAttendanceDTOs;
									for (var k = 0; k < stuAtt.length; k++) {
										if (stuAtt[k].attendanceStatus == null) {
											st += '<td></td>';
										} else {
											if (stuAtt[k].status == 's') {
												st += '<td style="background-color:red;">';
											} else {
												st += '<td>';
											}

											if (stuAtt[k].attendanceStatus == 'PRESENT')
												st = st + 'P</td>';
											else if (stuAtt[k].attendanceStatus == 'ABSENT')
												st = st + 'A</td>';
											else if (stuAtt[k].attendanceStatus == 'LATE')
												st = st + 'LP</td>';
											else if (stuAtt[k].attendanceStatus == 'LEAVE')
												st = st + 'L</td>';
											else
												st = st
														+ ''
														+ stuAtt[k].attendanceStatus
														+ '</td>';
										}
									}
									st += '</tr>';
								}
								st = st + '</tbody></table></div></div></div>';
								$("#AttendanceList").append(st);
							}

						},
						error : function(error, status) {
							
						}
					});
		}
	}
</script>
<div class="content">

	<div id="content-header">
		<img alt="Show_settings" src="${img_url}/stuatt.png"
			style="width: 80px;">
		<h1>Attendance Report</h1>
		<h3>View Monthly Attendance Report</h3>
		<div id="app-back-button" style="top: 22px;">
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
	<hr>
	<div
		class="widget widget-2 widget-tabs widget-tabs-2 tabs-right border-bottom-none"
		style="margin-top: 2px;"></div>

	<div class="row-form" style="margin-top: -160px;">
		<div class="span2">
			Class :<font color="red">*</font>
		</div>
		<div class="span4">
			<select id="classId" class="validate[required]" style="width: 250px;"
				onchange="getSectionList(this.value);" name="classId" class="select">

				<c:choose>
					<c:when test="${ROLE=='ROLE_EMPLOYEE'}">
						<option value="${StudentClassesDTO.classId}" selected="selected">${StudentClassesDTO.className}</option>
					</c:when>
					<c:otherwise>
						<option value="">Select a Class</option>
						<c:forEach var="list" items="${classesList}">
							<option value="${list.classId}">${list.className}</option>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</select>
		</div>
	</div>

	<div class="row-form">
		<div class="span2">
			Section<font color="red">*</font>:
		</div>
		<div class="span4">
			<select id="sectionId" class="validate[required]"
				style="width: 250px;" name="sectionId" class="select">
				<c:choose>
					<c:when test="${ROLE=='ROLE_EMPLOYEE'}">
						<option value="${StudentClassesDTO.sectionId}" selected="selected">${StudentClassesDTO.sectionName}</option>
					</c:when>
					<c:otherwise>
						<option value="">Select a Section</option>
					</c:otherwise>
				</c:choose>
			</select>
		</div>
	</div>
	<div class="row-form">
		<div class="span2">
			Month :<font color="red">*</font>
		</div>
		<div class="span4" id="monthId">
			<select class="form-control input-sm" id="monthId" name="month"
				style="width: 250px;" data-original-title="" title=""
				onchange="getStudentAttendanceList(this.value);">
				<option value="" data-original-title="" title="">Select
					Month Here</option>
				<c:forEach var="month" items="${monthList}">
					<option value="${month.monthId}">${month.monthName}</option>
				</c:forEach>
			</select>
		</div>
	</div>

	<div id="new"
		style="float: right; margin-top: -155px; margin-right: 174px;">
		<h6>*P-Present</h6>
		<h6>*A-Absent</h6>
		<h6>*L-Leave</h6>
		<h6>*LP-Late Present</h6>
	</div>
	<div class="separator"></div>


	<div id="AttendanceList"></div>
	<div class="separator"></div>

	<div id="err" class="form-inline">
		<p id="v1"></p>
	</div>
</div>

