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
	function getStudentDataList(sessionId,classId,sectionId) {
		hideshow();
	/* 	var sessionId = $('#sessionId').val();
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
					var subjects = '<option value="">Select Subjects</option>';
					$.each(j.SubjectList, function(key, value) {
						subjects += '<option value='+value.id+'>'
								+ value.subjectName + '</option>';
					});

					$("#studentId").append(students);
				},
				error : function(e) {
					
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
						st = '<div id="box" style="border: 1px solid; border-radius: 10px; height: 99px; width: 267px; margin-left: 0px; margin-top: -133px;">'
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
	function getStudentAssignSubject() {
		getStudentdetails($("#studentId").val());
		$("#markstable").empty();
		if (classId == '' || sectionId == '') {
			alert("Fill Above Data First. Please!!");
		} else {
			$
					.ajax({
						type : "POST",
						url : '${base_url}getdataforreportcard',
						data : {
							'studentId' : $("#studentId").val(),
							'classId' : $("#classId").val(),
							'sessionId' : $("#sessionId").val(),
							'sectionId' : $("#sectionId").val(),
						},
						success : function(data, status) {
							
							var obj = JSON.parse(data);
							var markstable = '<div style="width: 100%;height:50px;padding-top:15px;"><div style="width: 50%; float: left;text-align: center;">Half Yearly Exam</div>';
							markstable += '<div style="width: 50%; float: right;text-align: center;">&nbsp&nbsp&nbsp&nbsp Annual Exam &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp <a href="generate-student-report-card-pdf.html?sessionId='
									+ $("#sessionId").val()
									+ '&classId='
									+ $("#classId").val()
									+ '&sectionId='
									+ $("#sectionId").val()
									+ '&studentId='
									+ $("#studentId").val()
									+ '" class="btn" target="_blank">Generate PDF</a></div>';
							markstable += '<div class="block" style="width:90%;margin-left:50px"><div class="data-fluid"><table width="100%" cellspacing="0" cellpadding="0" class="table">';
							markstable += '<thead><tr><th style="border-right:1px solid red;">S.No</th><th  style="border-right:1px solid red;">Subject</th><th style="border-right:1px solid red;">U.T+ORAL+Project</th><th style="border-right:1px solid red;">Exam</th><th style="border-right:1px solid red;">Total</th>';
							markstable += '<th style="border-right:1px solid red;">U.T+ORAL+Project</th><th style="border-right:1px solid red;">Exam</th><th style="border-right:1px solid red;">Total</th><th style="border-right:1px solid red;">Grand Total</th></tr></thead><tbody>';
							$
									.each(
											obj.SubjectDTOs,
											function(key, value) {
												if (key == 0) {
													markstable += '<tr><td style="border-right:1px solid red;">';
												} else {
													markstable += '<tr><td style="border-right:1px solid red;">'
															+ key + '';
												}
												markstable += '</td><td style="border-right:1px solid red;">'
														+ value.subjectName
														+ '</td><td style="border-right:1px solid red;">'
														+ value.halfYearlyTU
														+ '</td><td style="border-right:1px solid red;">'
														+ value.halfYearlyExam
														+ '</td><td style="border-right:1px solid red;">'
														+ value.halfYearlyTotal
														+ '</td><td style="border-right:1px solid red;">'
														+ value.annualYearlyTU
														+ '</td><td style="border-right:1px solid red;">'
														+ value.annualYearlyExam
														+ '</td><td style="border-right:1px solid red;">'
														+ value.annualYearlyTotal
														+ '</td><td style="border-right:1px solid red;">'
														+ value.grandTotal
														+ '</td></tr style="border-right:1px solid red;">';
											});
							markstable += '<tr><td style="border-top: 1px solid; border-bottom: 1px solid;border-right:1px solid red;">=></td><td style="border-right:1px solid red;border-top: 1px solid; border-bottom: 1px solid">Total</td>';
							markstable += '<td style="border-top: 1px solid; border-bottom: 1px solid;border-right:1px solid red;"></td><td style="border-right:1px solid red;border-top: 1px solid; border-bottom: 1px solid"></td>';
							markstable += '<td style="border-right:1px solid red;border-top: 1px solid; border-bottom: 1px solid">'
									+ obj.halfYearlyTotal
									+ '</td><td style="border-right:1px solid red;border-top: 1px solid; border-bottom: 1px solid"></td>';
							markstable += '<td style="border-right:1px solid red;border-top: 1px solid; border-bottom: 1px solid"></td><td style="border-right:1px solid red;border-top: 1px solid; border-bottom: 1px solid">'
									+ obj.annuallyTotal + '</td>';
							markstable += '<td style="border-right:1px solid red;border-top: 1px solid; border-bottom: 1px solid">'
									+ obj.grandTotal + '</td></tr>';

							markstable += '<tr><td style="border-right:1px solid red;">*</td><td style="border-right:1px solid red;">% of marks obtained</td><td style="border-right:1px solid red;"></td><td style="border-right:1px solid red;"></td>';
							markstable += '<td style="border-right:1px solid red;">'
									+ obj.halfYearGainPercenatge
									+ '</td><td style="border-right:1px solid red;"></td><td style="border-right:1px solid red;"></td>';
							markstable += '<td style="border-right:1px solid red;">'
									+ obj.annuallyGainPercentage
									+ '</td><td style="border-right:1px solid red;">'
									+ obj.grandGainPercentage + '</td></tr>';

							markstable += '<tr><td style="border-right:1px solid red;">*</td><td style="border-right:1px solid red;">Higest % in Class</td><td style="border-right:1px solid red;"></td><td style="border-right:1px solid red;"></td>';
							markstable += '<td style="border-right:1px solid red;">'
									+ obj.halfYearlyMaxGainPercentage
									+ '</td><td style="border-right:1px solid red;"></td><td style="border-right:1px solid red;"></td>';
							markstable += '<td style="border-right:1px solid red;">'
									+ obj.annuallyMaxGainPercentage
									+ '</td><td style="border-right:1px solid red;">'
									+ obj.grandMaxGainPercentage + '</td></tr>';

							markstable += '<tr><td style="border-right:1px solid red;">*</td><td style="border-right:1px solid red;">Rank</td><td style="border-right:1px solid red;"></td><td style="border-right:1px solid red;"></td><td style="border-right:1px solid red;"></td><td style="border-right:1px solid red;"></td><td style="border-right:1px solid red;"></td><td style="border-right:1px solid red;"></td><td  style="border-right:1px solid red;"></td></tr>';

							markstable += '<tr><td style="border-right:1px solid red;">*</td><td style="border-right:1px solid red;">Attendance in %</td><td style="border-right:1px solid red;"></td><td style="border-right:1px solid red;"></td><td style="border-right:1px solid red;"></td><td style="border-right:1px solid red;"></td><td style="border-right:1px solid red;"></td><td style="border-right:1px solid red;"> </td><td style="border-right:1px solid red;"></td></tr>';

							markstable += ' <tr><td style="border-right:1px solid red;">*</td><td style="border-right:1px solid red;">Uniform & Performance</td><td style="border-right:1px solid red;"></td><td style="border-right:1px solid red;"></td><td style="border-right:1px solid red;"></span></td><td style="border-right:1px solid red;"></td><td style="border-right:1px solid red;"></td><td style="border-right:1px solid red;"></td><td style="border-right:1px solid red;"></td></tr>';

							markstable += '<tr><td style="border-right:1px solid red;">*</td><td style="border-right:1px solid red;">Sign. of class teacher</td><td style="border-right:1px solid red;"></td><td style="border-right:1px solid red;"></td><td style="border-right:1px solid red;"></td><td style="border-right:1px solid red;"></td><td style="border-right:1px solid red;"></td><td style="border-right:1px solid red;"></td><td style="border-right:1px solid red;"></td></tr>';

							markstable += '<tr><td style="border-right:1px solid red;">*</td><td style="border-right:1px solid red;">Sign. of principal</td><td style="border-right:1px solid red;"></td><td style="border-right:1px solid red;"></td><td style="border-right:1px solid red;"></td><td style="border-right:1px solid red;"></td><td style="border-right:1px solid red;"></td><td style="border-right:1px solid red;"></td><td style="border-right:1px solid red;"></td></tr>';

							markstable += '<tr><td style="border-right:1px solid red;">*</td><td style="border-right:1px solid red;">Sign. of parents</td><td style="border-right:1px solid red;"></td><td style="border-right:1px solid red;"></td><td style="border-right:1px solid red;"></td><td style="border-right:1px solid red;"></td><td style="border-right:1px solid red;"></td><td style="border-right:1px solid red;"></td><td style="border-right:1px solid red;"></td></tr>';

							markstable += '</tbody></table></div>';
							$("#markstable").append(markstable);
							$("#markstable").css({
								"border" : "1px solid gray",
								"background-color" : "red"
							});
						},
						error : function(e) {
							
						}
					});
		}
	}

	function hideshow() {
		$("#markstable").css({
			"border" : "1px white",
			"background-color" : "white"
		});
		$("#markstable").empty();
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
	function getClear()
	{
		
		$("#sectionId").val('');
		$("#studentId").val('');
		$("#classId").val('');
		
	}
</script>
<div class="content">
	<div id="content-header" style="height: 150px;">
		<img alt="Show_settings"
			src="${img_url}/employeeImages/viewreportcard.png"
			style="width: 50px; margin-top: -12px;">
		<h1>View Final Exam Result</h1>
		<h3>View Final Exam Report Card</h3>
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
	<div id="searches" style="height: auto; width: auto;">
		<table>
			<tr>
						<td style="width: 200px;">Session</td>
						<td style="width: 200px;"><select name="sessionId"
								class="form-control input-sm" id="sessionId" required="required"
								onchange="getClear();">
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
					required="required" onchange="getStudentAssignSubject();"
					style="width: 250px;" path="studentId">
						<option value="">Select Student</option>
				</select></td>
			</tr>
		</table>
		<div class="separator"></div>
	</div>
		<div style="width: 48%; float: right;">
		<div id="Student"></div>
		</div>
	<hr>
	<div class="row-fluid">
		<div class="span12" id="markstable">
			<!-- <div style="width: 100%;">
				<div style="width: 50%; float: left; text-align: center;">
					Half Yearly Exam</div>
				<div style="width: 50%; float: right; text-align: center;">
					Annual Yearly Exam</div>
			</div>
			<div class="block">
				<div class="data-fluid">
					<table width="100%" cellspacing="0" cellpadding="0" class="table">

						<tbody>
							<tr>
								<td style="border-top: 1px solid; border-bottom: 1px solid">1</td>
								<td style="border-top: 1px solid; border-bottom: 1px solid">Total</td>
								<td style="border-top: 1px solid; border-bottom: 1px solid"></td>
								<td style="border-top: 1px solid; border-bottom: 1px solid"></td>
								<td style="border-top: 1px solid; border-bottom: 1px solid"><span
									class="label label-success">Developer</span></td>
								<td style="border-top: 1px solid; border-bottom: 1px solid"></td>
								<td style="border-top: 1px solid; border-bottom: 1px solid"></td>
								<td style="border-top: 1px solid; border-bottom: 1px solid">DT-SV35582</td>
								<td style="border-top: 1px solid; border-bottom: 1px solid"><span
									class="label label-success">Developer</span></td>
							</tr>
							<tr>
								<td>*</td>
								<td>% of marks obtained</td>
								<td></td>
								<td></td>
								<td><span class="label label-success">Developer</span></td>
								<td></td>
								<td></td>
								<td>DT-SV35582</td>
								<td><span class="label label-success">Developer</span></td>
							</tr>
							<tr>
								<td>*</td>
								<td>Higest % in Class</td>
								<td></td>
								<td></td>
								<td><span class="label label-success">Developer</span></td>
								<td></td>
								<td></td>
								<td>DT-SV35582</td>
								<td><span class="label label-success">Developer</span></td>
							</tr>
							<tr>
								<td>*</td>
								<td>Rank</td>
								<td></td>
								<td></td>
								<td><span class="label label-success">Developer</span></td>
								<td></td>
								<td></td>
								<td>DT-SV35582</td>
								<td><span class="label label-success">Developer</span></td>
							</tr>
							<tr>
								<td>*</td>
								<td>Attendance in %</td>
								<td></td>
								<td></td>
								<td><span class="label label-success">Developer</span></td>
								<td></td>
								<td></td>
								<td>DT-SV35582</td>
								<td><span class="label label-success">Developer</span></td>
							</tr>
							<tr>
								<td>*</td>
								<td>Uniform & Performance</td>
								<td></td>
								<td></td>
								<td><span class="label label-success">Developer</span></td>
								<td></td>
								<td></td>
								<td>DT-SV35582</td>
								<td><span class="label label-success">Developer</span></td>
							</tr>
							<tr>
								<td>*</td>
								<td>Sign. of class teacher</td>
								<td></td>
								<td></td>
								<td><span class="label label-success">Developer</span></td>
								<td></td>
								<td></td>
								<td>DT-SV35582</td>
								<td><span class="label label-success">Developer</span></td>
							</tr>
							<tr>
								<td>*</td>
								<td>Sign. of principal</td>
								<td></td>
								<td></td>
								<td><span class="label label-success">Developer</span></td>
								<td></td>
								<td></td>
								<td>DT-SV35582</td>
								<td><span class="label label-success">Developer</span></td>
							</tr>
							<tr>
								<td>*</td>
								<td>Sign. of parents</td>
								<td></td>
								<td></td>
								<td><span class="label label-success">Developer</span></td>
								<td></td>
								<td></td>
								<td>DT-SV35582</td>
								<td><span class="label label-success">Developer</span></td>
							</tr>
						</tbody>
					</table>
				</div>
			</div> -->
		</div>
	</div>