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
			checkformarksassign($("#subjectId").val());
		} else {
			alert("please select month first");
		}

	}

	function getStudentList() {
		hideshow();
		var sessionId = $('#sessionId').val();
		var classId = $('#classId').val();
		var sectionId = $('#sectionId').val();
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
			checkformarksassign($("#subjectId").val());
		}
	}
	function checkformarksassign(id) {
		var sessionId = $('#sessionId').val();
		var classId = $('#classId').val();
		var sectionId = $('#sectionId').val();
		var studentId = $('#studentId').val();
		var monthId = $('#monthId').val();
		if (classId == '' || sectionId == '') {
			alert("Fill Above Data First. Please!!");
		} else {
			$
					.ajax({
						type : "POST",
						url : '${base_url}checkformarksassign',
						data : {
							'studentId' : studentId,
							'classId' : classId,
							'sessionId' : sessionId,
							'sectionId' : sectionId,
							'subjectId' : id,
							'monthId' : monthId
						},
						success : function(data, status) {
							var obj = JSON.parse(data);
							alert(obj);
							if (obj == "OCCURE") {
								$("#appendmsg")
										.append(
												'<font color="red">This Subject Marks Assign Previouly. </font>');
								$("#assignbutton").hide();
							} else {
								hideshow();
							}
						},
						error : function(e) {
							alert('Error: ' + e);
						}
					});
		}
	}
	function promoteToCheckExistance() {
		checkformarksassign($("#subjectId").val());
		getClear();
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
		$('#monthId').val('');
	}
</script>
<div class="content">
	<div id="content-header" style="height: 150px;">
		<img alt="Show_settings" src="${img_url}/sfees.jpg"
			style="width: 50px; margin-top: -12px;">
		<h1>Assing Marks</h1>
		<h3>Makes Report For Monthly Marks</h3>
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
	<f:form commandName="MonthlyExamReportDTO" method="POSt"
		action="update-monthlygivenmarks.html" onsubmit="return validate();">
		<div id="searches" style="height: auto; width: auto;">
			<table>
				<tr>
					<td style="width: 200px;">Session</td>
					<td><f:select id="sessionId" class="validate[required]"
							required="required" onchange="getClear();" style="width: 250px;"
							path="sessionId">
							<c:forEach var="list" items="${sessionList}">
								<c:choose>
									<c:when
										test="${MonthlyExamReportDTO.sessionId==list.sessionId}">
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
							onchange="promoteToCheckExistance();" required="required"
							style="width: 250px;" name="monthId" path="monthId">
							<!-- <option value="">Select a month</option> -->
							<c:forEach var="list" items="${monthList}">
								<c:choose>
									<c:when test="${MonthlyExamReportDTO.monthId==list.monthId}">
										<option value="${list.monthId}" selected="selected">${list.monthName}</option>
									</c:when>
									<c:otherwise>
										<option value="${list.monthId}">${list.monthName}</option>
									</c:otherwise>
								</c:choose>
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
							<option value="${MonthlyExamReportDTO.studentId}">${MonthlyExamReportDTO.studentName}</option>
						</f:select></td>
				</tr>
				<tr>
					<td style="width: 200px;">Subject</td>
					<td><f:select id="subjectId" class="validate[required]"
							required="required" onchange="checkformarksassign(this.value);"
							style="width: 250px;" path="subjectId">
							<option value="${MonthlyExamReportDTO.subjectId}">${MonthlyExamReportDTO.subjectName}</option>
						</f:select></td>
				</tr>
				<tr>
					<td style="width: 200px;">Max Marks</td>
					<td><f:input class="validate[required]" required="required"
							style="width: 244px;" path="maxMarks" id="maxMarks" /></td>
				</tr>
				<tr>
					<td style="width: 200px;">Marks</td>
					<td><f:input class="validate[required]" required="required"
							style="width: 244px;" path="marks" id="marks" /></td>
				</tr>
				<tr>
					<td style="width: 200px;"></td>
					<td><div id="appendmsg"></div>
						<button id="assignbutton" class="btn" type="submit">Save</button>
					</td>
				</tr>
			</table>
			<f:hidden path="monthlyExamReportId" />
			<f:hidden path="createdAt" />
			<f:hidden path="updatedAt" />
			<input type="hidden" id="">
			<div class="separator"></div>
		</div>
	</f:form>

</div>