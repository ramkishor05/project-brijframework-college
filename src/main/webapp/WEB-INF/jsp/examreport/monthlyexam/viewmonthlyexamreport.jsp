<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/style/datepicks" var="datepicks" />
<spring:url value="/img" var="img_url" />
<spring:url value="/css" var="css_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/admission.css">
<link href="${datepicks}/jquery.datepick.css" rel="stylesheet">
<script src="${datepicks}/jquery.plugin.js"></script>
<script src="${datepicks}/jquery.datepick.js"></script>
<spring:url value="/" var="base_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/setting.css">
<script>
	function getSectionList(id) {
		$("#classwise").empty();
		$("#sectionwise").empty();
		$("#studentwise").empty();
		$("#studentId").empty();
		$.ajax({
			type : "post",
			url : 'getsectionlist/' + id,
			success : function(data, status) {
				$("#sectionId").empty();
				var j = JSON.parse(data);
				var content = '<option value="">Select Section</option>';
				for ( var i = 0; i < j.length; i++) {
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
	if ("${ROLE}"=='ROLE_EMPLOYEE') {
		getStudentDataList('${CURRENTSESSIONID}', '${CLASSID}', '${SECTIONID}');
	}
	function getStudentList() {
		getStudentDataList($('#sessionId').val(), $('#classId').val(), $(
				'#sectionId').val());
	}
	function getStudentDataList(sessionId, classId, sectionId) {
		/* var sessionId = $('#sessionId').val();
		var classId = $('#classId').val();
		var sectionId = $('#sectionId').val(); */
		if (sessionId == '' || classId == '' || sectionId == '') {
			alert("Fill Above Data First. Please!!");
		} else {
			$.ajax({
				type : "post",
				url : '${base_url}get-student-subject-list',
				data : {
					'classId' : classId,
					'sectionId' : sectionId,
					'sessionId' : sessionId,
				},
				success : function(data, status) {
					$("#studentId").empty();
					var j = JSON.parse(data);
					var students = '<option value="">Select Student</option>';
					$.each(j.StudentList, function(key, value) {
						students += '<option value='+value.admissionNo+'>'
								+ value.fullName + '</option>';
					});

					$("#studentId").append(students);
				},
				error : function(e) {
					alert('Error: ' + e);
				}
			});
		}
	}
function getStudentdetails(id) {
		
		$
				.ajax({
					type : "post",
					url : 'getstudentsdata/' + id,
					success : function(data, status) {
						$("#Student").empty();
						var j = JSON.parse(data);
						var st = '';
						st = '<div id="box" style="border: 1px solid; border-radius: 10px; height: 99px; width: 267px; margin-left: 0px; margin-top: -184px;">'
						st += '<table style="width: 530px; margin-left: 10px; margin-top: 7px;"><tr><td><span><font size="2"><b>Name :</b></td><td colspan="3" ><span><font size="2">'
								+ j.firstName
								+ '\t'
								+ j.middleName
								+ '\t'
								+ j.lastName
								+ '</font></span></td></tr><tr><td style="width: 99px;"><span><font size="2"><b>Father Name:</font></span></b></td><td style="width: 369px;"colspan="3"><span><font size="2">'
								+ j.fatherName
								+ '</font></span></td></tr><tr><td style="width: 99px;"><span><font size="2"><b>Mother Name:</font></span></b></td><td style="width: 369px;"colspan="3"><span><font size="2">'
								+ j.motherName
								+ '</font></span></td></tr><tr><td><span><font size="2"><b>Roll No:</font></span></b></td><td colspan="3"><span><font size="2">'
								+ j.rollno
								+ '</font></span></td></tr></table></div>';
						$("#Student").append(st);
					},
					error : function(e) {

					}
				});
	}
	function getStudentAssignSubject(studentId) {
		getStudentdetails(studentId);
		$("#markstable").empty();
		$
				.ajax({
					type : "POST",
					url : '${base_url}getsubjectmarks',
					data : {
						'studentId' : $("#studentId").val(),
						'classId' : $("#classId").val(),
						'sessionId' : $("#sessionId").val(),
						'sectionId' : $("#sectionId").val(),
					},
					success : function(data, status) {
						//<ul class="buttons"><li><a class="btn btn-primary" href="javascript:generatePDF();">Generate PDF</a></li></ul>
						var obj = JSON.parse(data);
						var markstable = '<div class="head blue"><div class="icon"><span class="ico-pen-2"></span></div><h2>View Monthly Report</h2><ul class="buttons"><li><a class="btn btn-primary" href="pdf-viewmonthlysubjectmarks?id='+studentId+'" target="_blank">View PDF Report</a>&nbsp;<a class="btn btn-primary" href="viewmonthlysubjectmarks.html">Edit Data</a></li></ul></div>';
						markstable += '<div class="data-fluid"><table width="100%" cellspacing="0" cellpadding="0" class="table"><thead>';
						markstable += '<tr><th>Subject Name</th>';
						$
								.each(
										obj.MonthDTO,
										function(key, value) {
											markstable += '<th><center>'
													+ value.monthName
													+ '</center><div style="width:100%;float:left;"><div style="width:50%;float:left;"><center>Max </center></div> <div style="width:49%;float:left;"><center>Gain </center></div></div></th>';
										});
						markstable += '</tr></thead><tbody>';
						$
								.each(
										obj.SubjectDTO,
										function(key, value) {
											markstable += '<tr><td>'
													+ value.subjectName
													+ '</td>';
											$
													.each(
															value.commonDTOs,
															function(key,
																	value1) {
																markstable += '<td><div style="width:100%;float:left;"><div style="width:50%;float:left;"><center>'
																		+ value1.maxMarks
																		+ '</center></div> <div style="width:49%;float:left;"><center>'
																		+ value1.gainMarks
																		+ '</center></div></div></td>';
															});
											markstable += '</tr>';
										});
						markstable += '</tbody></table></div>';
						$("#markstable").append(markstable);
					},
					error : function(e) {
						
					}
				});
	}

	function generatePDF() {
		document.location.href = "generatemonthlyexamreprot?sessionId="
				+ $("#sessionId").val() + "&classId=" + $("#classId").val()
				+ "&sectionId=" + $("#sectionId").val() + "&studentId="
				+ $("#studentId");
	}
</script>
<div class="content">
	<div id="content-header" style="height: 150px;">
		<img alt="Show_settings"
			src="${img_url}/employeeImages/viewmonthlyreportcard.png"
			style="width: 50px; margin-top: -12px;">
		<h1>View Monthly Exam Report</h1>
		<h3>View Monthly Exam Report Per Student</h3>
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
	<div id="searches" style="height: auto; width: auto;">
		<table>
			<tr>
				<td style="width: 200px;">Session</td>
				<td><select id="sessionId" class="validate[required]"
					required="required" onchange="getClear();" style="width: 250px;"
					name="sessionId">
						<c:forEach var="list" items="${sessionList}">
							<c:choose>
								<c:when test="${current.sessionId==list.sessionId}">
									<option value="${list.sessionId}" selected="selected">${list.sessionDuration}</option>
								</c:when>
								<c:otherwise>
									<option value="${list.sessionId}">${list.sessionDuration}</option>
								</c:otherwise>
							</c:choose>
						</c:forEach>
				</select></td>
			</tr>
			<tr>
				<td style="width: 200px;">Class</td>
				<td><select id="classId" class="validate[required]"
					required="required" style="width: 250px;"
					onchange="getSectionList(this.value);" path="classId">
						<c:choose>
								<c:when test="${ROLE=='ROLE_EMPLOYEE'}">
									<option value="${StudentClassesDTO.classId}"
										selected="selected">${StudentClassesDTO.className}</option>
								</c:when>
								<c:otherwise>
									<option value="">Select a Class</option>
									<c:forEach var="list" items="${classesList}">
										<option value="${list.classId}">${list.className}</option>
									</c:forEach>
								</c:otherwise>
							</c:choose>
				</select></td>
			</tr>
			<tr>
				<td style="width: 200px;">Section</td>
				<td><select id="sectionId" class="validate[required]"
					required="required" onchange="getStudentList();"
					style="width: 250px;" path="sectionId">
					<c:choose>
								<c:when test="${ROLE=='ROLE_EMPLOYEE'}">
									<option value="${StudentClassesDTO.sectionId}"
										selected="selected">${StudentClassesDTO.sectionName}</option>
								</c:when>
								<c:otherwise>
									<option value="">Select a Section</option>
								</c:otherwise>
							</c:choose>
				</select></td>
			</tr>
			<tr>
				<td style="width: 200px;">Students</td>
				<td><select id="studentId" class="validate[required]"
					required="required" onchange="getStudentAssignSubject(this.value);"
					style="width: 250px;" path="studentId">
						<option value="">Select Student</option>
				</select></td>
			</tr>
		</table>
		<div class="separator"></div>
	</div>
	<br>
	<hr>
	<div style="width: 48%; float: right;">
		<div id="Student"></div>
		</div>
	<hr>
	<div class="row-fluid">
		<div class="span12">
			<div class="block" id="markstable"></div>
		</div>
	</div>
</div>