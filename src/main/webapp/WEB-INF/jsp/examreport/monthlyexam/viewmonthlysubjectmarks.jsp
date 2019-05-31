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
		hideshow();
		$("#classwise").empty();
		$("#sectionwise").empty();
		$("#studentwise").empty();
		$("#studentId").empty();
		if ($("#monthId").val() != '') {
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
		} else {
			alert("please select month first");
		}

	}
	if ("${ROLE}"=='ROLE_EMPLOYEE') {
		getStudentDataList('${CURRENTSESSIONID}', '${CLASSID}', '${SECTIONID}');
	}
	function getStudentList() {
		getStudentDataList($('#sessionId').val(), $('#classId').val(), $(
				'#sectionId').val());
	}
	function getStudentDataList(sessionId, classId, sectionId) {
		hideshow();
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
					$("#subjectId").empty();
					$("#studentId").empty();
					var j = JSON.parse(data);
					var students = '<option value="">Select Student</option>';
					$.each(j.StudentList, function(key, value) {
						students += '<option value='+value.admissionNo+'>'
								+ value.fullName + '</option>';
					});
					var subjects = '<option value="">Select Subjects</option>';
					$.each(j.SubjectList, function(key, value) {
						subjects += '<option value='+value.id+'>'
								+ value.subjectName + '</option>';
					});

					$("#studentId").append(students);
					$("#subjectId").append(subjects);
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
	function getStudentAssignSubject(id) {
		getStudentdetails(id);
		var sessionId = $('#sessionId').val();
		var classId = $('#classId').val();
		var sectionId = $('#sectionId').val();
		var studentId = $('#studentId').val();
		var monthId = $('#monthId').val();
		$("#markstable").empty();
		if (classId == '' || sectionId == '' || monthId=='') {
			alert("Fill Above Data First. Please!!");
		} else {
			$
					.ajax({
						type : "POST",
						url : '${base_url}getmonthwisesunjectmarks',
						data : {
							'studentId' : id,
							'classId' : classId,
							'sessionId' : sessionId,
							'sectionId' : sectionId,
							'monthId' : monthId
						},
						success : function(data, status) {
							var obj = JSON.parse(data);
							var markstable = '<div class="head blue"><div class="icon"><span class="ico-pen-2"></span></div>';
							markstable += '<h2>' + obj.MonthName
									+ ' Month subject Marks Report</h2></div>';
							markstable += '<div class="data-fluid"><table width="100%" cellspacing="0" cellpadding="0" class="table"><thead><tr>';
							markstable += '<th width="25%">Subject Name</th><th width="25%">Max Marks</th><th width="25%">Gain Marks</th><th width="25%">Action</th></tr></thead><tbody>';
							$
									.each(
											obj.MonthlyExamReportDTO,
											function(key, value) {
												markstable += '<tr><td>'
														+ value.subjectName
														+ '</td><td>'
														+ value.maxMarks
														+ '</td><td>'
														+ value.marks
														+ '</td><td><a href="edit-monthlygivenmarks?monthlyExamReportId='
														+ value.monthlyExamReportId
														+ '"><span class="label label-success">Edit</span></a>|<a href="delete-monthlygivenmarks?monthlyExamReportId='
														+ value.monthlyExamReportId
														+ '"><span class="label label-success">Delete</span></a></td></tr>';

											});
							markstable += '</tbody></table></div>';
							$("#markstable").append(markstable);
						},
						error : function(e) {
							alert('Error: ' + e);
						}
					});
		}
	}

	function hideshow() {
		$("#appendmsg").empty();
		$("#assignbutton").show();
	}
	function generatePDF() {
		document.location.href = "generatemonthlyexamreprot?sessionId="
				+ $("#sessionId").val() + "&classId=" + $("#classId").val()
				+ "&sectionId=" + $("#sectionId").val() + "&studentId="
				+ $("#studentId");
	}
	function validate() {
		var flage = true;
		if (!$.isNumeric($("#marks").val())
				|| !$.isNumeric($("#maxMarks").val())) {
			alert("Max Marks and marks must be in numeric form");
			flage = false;
		}
		return flage;
	}
	function getClear() {
		$('#classId').val('');
		$('#sectionId').val('');
		$('#studentId').val('');
	}
</script>
<div class="content">
	<div id="content-header" style="height: 150px;">
		<img alt="Show_settings"
			src="${img_url}/employeeImages/editmonthlyexammarks.png"
			style="width: 50px; margin-top: -12px;">
		<h1>Edit Given Marks</h1>
		<h3>Edit Given Marks Subject view</h3>
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
	<c:if test="${! empty msg}">
		<div class="alert alert-success"
			style="height: 28px; padding-top: 0px; padding-bottom: 1px; margin-bottom: 0px;">
			<h5 align="center">
				<font color="red"><b>${msg}</b></font>
			</h5>
		</div>
	</c:if>

	<br>
	<f:form commandName="MonthlyExamReportDTO" method="POSt"
		action="assign-marks-to-student.html" onsubmit="return validate();">
		<div id="searches" style="height: auto; width: auto;">
			<table>
				<tr>
					<td style="width: 200px;">Session</td>
					<td><f:select id="sessionId" class="validate[required]"
							required="required" onchange="getClear();" style="width: 250px;"
							path="sessionId">
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
						</f:select></td>
				</tr>
				<tr>
					<td style="width: 200px;">Month</td>
					<td><f:select id="monthId" class="validate[required]"
							onchange="getClear();" required="required" style="width: 250px;"
							path="monthId">
							<option value="">Select a month</option>
							<c:forEach var="list" items="${monthList}">
								<option value="${list.monthId}">${list.monthName}</option>
							</c:forEach>
						</f:select></td>
				</tr>
				<tr>
					<td style="width: 200px;">Class</td>
					<td><f:select id="classId" class="validate[required]"
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
						</f:select></td>
				</tr>
				<tr>
					<td style="width: 200px;">Section</td>
					<td><f:select id="sectionId" class="validate[required]"
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
						</f:select></td>
				</tr>
				<tr>
					<td style="width: 200px;">Students</td>
					<td><f:select id="studentId" class="validate[required]"
							required="required"
							onchange="getStudentAssignSubject(this.value);"
							style="width: 250px;" path="studentId">
							<option value="">Select Student</option>
						</f:select></td>
				</tr>
			</table>
			<div class="separator"></div>
		</div>
	</f:form>
	<br>
	<hr>
	<div style="width: 48%; float: right;">
		<div id="Student"></div>
		</div>

	<div class="row-fluid">
		<div class="span12">
			<div class="block" id="markstable"></div>
		</div>
	</div>
</div>