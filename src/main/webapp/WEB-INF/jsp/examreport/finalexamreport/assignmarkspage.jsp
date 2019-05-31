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
		if ($("#sessionId").val() == '' || $("#annualExamType").val() == '') {
			alert("Select all the above fields");

		} else {
			$.ajax({
				type : "post",
				url : 'getsectionlist/' + id,
				success : function(data, status) {
					$("#examType").val('');
					$("#maxMarks").val('');
					$("#studentsubjects").empty()
					$("#sectionId").empty();
					$("#assignsubjectmarks").show();
					var j = JSON.parse(data);
					var content = '<option value="">Select Section</option>';
					for (var i = 0; i < j.length; i++) {
						content += '<option value='+j[i].sectionId+'>'
								+ j[i].sectionName + '</option>';
					}
					$("#sectionId").append(content);
				},
				error : function(e) {

				}
			});
		}

	}
	if ("${ROLE}" == 'ROLE_EMPLOYEE') {
		getStudentDataList('${CURRENTSESSIONID}', '${CLASSID}', '${SECTIONID}');
	}
	function getStudentList() {
		getStudentDataList($('#sessionId').val(), $('#classId').val(), $(
				'#sectionId').val());
	}

	function getStudentDataList() {
		$("#classmsg").empty();
		$("#sectionmsg").empty();
		$("#typemsg").empty();
		$("#reportmsg").empty();
		$("#maxmsg").empty();
		var flage = true;
		if ($("#classId").val() == '') {
			$("#classmsg")
					.append(
							'<span><font color="red" size="2">This field is required</font></span>');
			flage = false;
		}
		if ($("#sectionId").val() == '') {
			$("#sectionmsg")
					.append(
							'<span><font color="red" size="2">This field is required</font></span>');
			flage = false;
		}
		if ($("#examType").val() == '') {
			$("#typemsg")
					.append(
							'<span><font color="red" size="2">This field is required</font></span>');
			flage = false;
		}
		if ($("#annualExamType").val() == '') {
			$("#reportmsg")
					.append(
							'<span><font color="red" size="2">This field is required</font></span>');
			flage = false;
		}
		if ($("#maxMarks").val() == '' || isNaN($("#maxMarks").val())) {
			$("#maxmsg")
					.append(
							'<span><font color="red" size="2">Enter valid marks</font></span>');
			flage = false;
		}

		if (flage == true) {
			$("#assignsubjectmarks").hide();
			$
					.ajax({
						type : "post",
						url : '${base_url}students-for-annually-exam',
						data : {
							'classId' : $("#classId").val(),
							'sectionId' : $("#sectionId").val(),
							'sessionId' : $("#sessionId").val(),
							'examType' : $("#examType").val(),
							'annualExamType' : $("#annualExamType").val(),
						},
						success : function(data, status) {
							var obj = JSON.parse(data);
							var studentsubjects = '<table class="table table-bordered table-primary"><thead><tr>';
							studentsubjects += '<th>' + obj.PARENT.studentName
									+ '</th>';
							studentsubjects += '<th>' + obj.PARENT.fatherName
									+ '</th>';
							$.each(obj.PARENT.annualExamReportDTOs, function(
									key, value1) {
								studentsubjects += '<th>' + value1.subjectName
										+ '</th>';
							});
							studentsubjects += '</tr></thead><tbody>';
							$
									.each(
											obj.CHILD,
											function(key, value) {
												studentsubjects += '<tr><td><input type="hidden" value="'+value.studentId+'" name="annualExamReportDTOs['+key+'].studentId">'
														+ value.studentName
														+ '</td><td>'
														+ value.fatherName
														+ '</td>';
												$
														.each(
																value.annualExamReportDTOs,
																function(key1,
																		value1) {

																	var maxMarks = $(
																			"#maxMarks"
																					+ value1.subjectId
																					+ "")
																			.val();
																	studentsubjects += '<td><input type="hidden" value="'+value1.subjectId+'" name="annualExamReportDTOs['+key+'].annuallySubjectMarksDTOs['+key1+'].subjectsId"><input type="hidden" value="'+maxMarks+'" name="annualExamReportDTOs['+key+'].annuallySubjectMarksDTOs['+key1+'].maxMarks"><input type="text" class="marks" value="'+value1.gainMarks+'" name="annualExamReportDTOs['+key+'].annuallySubjectMarksDTOs['+key1+'].gainMarks"></td>';
																})
												studentsubjects += '</tr>';
											});

							studentsubjects += '</tbody></table>';
							studentsubjects += '<button id="assignbutton" class="btn"style="float: right;" type="submit">Assign Marks</button>';
							$("#studentsubjects").append(studentsubjects);
							$("#assignbutton").show();
						},
						error : function(e) {

						}
					});
		}
	}
	function showsubjects(value) {
		var subjectData = $("#assignSubjectData").val();
		var culno = '';
		if (value == 'button') {
			culno = 0;
		} else {
			$("#button" + value).remove();
			culno = parseInt(value) + 1;
		}
		if ($("#sessionId").val() == '' || $("#annualExamType").val() == ''
				|| $("#classId").val() == '' || $("#sectionId").val() == '') {
			alert("Select all the above fields");

		} else {
			$
					.ajax({
						type : "POST",
						url : '${base_url}getsubjectforannuallyexam',
						data : {
							'classId' : $("#classId").val(),
							'sectionId' : $("#sectionId").val(),
							'sessionId' : $("#sessionId").val(),
							'examType' : $("#examType").val(),
							'annualExamType' : $("#annualExamType").val(),
						},
						success : function(data, status) {
							var obj = JSON.parse(data);

							$("#maxMarks").val('');
							var showsubjects = '<table class="table" style="width: 100%;"><thead><th style="text-align: center; width: 50%;">Subject Name</th>';
							showsubjects += '<th style="text-align: center; width: 50%;">Max Marks</th></thead><tbody>';
							$
									.each(
											obj,
											function(key, value) {
												showsubjects += '<tr><td><input type="hidden" name="annuallySubjectMarksDTOs['+key+ '].subjectsId" value="'+ value.subjectsId +'">'
														+ value.subjectsName
														+ '</td>';
												showsubjects += '<td><input type="text" id="maxMarks'+value.subjectsId+'" class="marks" maxlength="3" value="'+value.maxMarks+'" name="annuallySubjectMarksDTOs['+key+'].maxMarks"></td></tr>';
											});
							showsubjects += '</tbody></table>';
							if (obj.length > 0) {
								$("#appendsubjectmarks").append(showsubjects);
							} else {
								$("#appendsubjectmarks")
										.append(
												'<font color="red">There is no subjects to assign marks</font>');
							}
						},
						error : function(e) {

						}
					});
		}
	}

	function validate() {
		var flage = true;
		var numeric = true;
		var valuegreater = true;
		$(".marks").each(
				function() {
					if (!$.isNumeric(this.value)
							|| !$.isNumeric($("#maxMarks").val())) {
						numeric = false;
						flage = false;
					}
					if (parseInt(this.value) > parseInt($("#maxMarks").val())) {
						valuegreater = false;
						flage = false;
					}
				});
		if (!numeric) {
			flage = numeric;
			alert("Max Marks and marks must be in numeric form");
		}
		if (!valuegreater) {
			flage = valuegreater;
			alert("Marks not be greater than Max Marks");
		}
		return flage;
	}
	function getClear() {
		$("#annualExamType").val('');
		$("#sectionId").val('');
		$("#classId").val('');
		$("#examType").val('');
		$("#maxMarks").val('');
		$("#studentsubjects").empty();
		$("#assignsubjectmarks").show();
	}
	function examrepottype() {
		$("#sectionId").val('');
		$("#classId").val('');
		$("#examType").val('');
		$("#maxMarks").val('');
		$("#studentsubjects").empty();
		$("#assignsubjectmarks").show();
	}
	function section() {
		$("#examType").val('');
		$("#maxMarks").val('');
		$("#studentsubjects").empty();
		$("#assignsubjectmarks").show();

	}
	function changetype() {
		$.ajax({
			type : "post",
			url : '${base_url}get-Max-marks',
			data : {
				'classId' : $("#classId").val(),
				'sectionId' : $("#sectionId").val(),
				'sessionId' : $("#sessionId").val(),
				'examType' : $("#examType").val(),
				'annualExamType' : $("#annualExamType").val(),
			},
			success : function(data, status) {
				var obj = JSON.parse(data);
				if (obj.length == 0) {
					$("#maxMarks").val('');
				} else

					$("#maxMarks").val(obj);

			},
			error : function(e) {

			}
		});

		$("#studentsubjects").empty();
		$("#assignsubjectmarks").show();
	}
</script>
<div class="content">
	<div id="content-header" style="height: 150px;">
		<img alt="Show_settings"
			src="${img_url}/employeeImages/createreportcard.png"
			style="width: 50px; margin-top: -12px;">
		<h1>Assing Marks</h1>
		<h3>Assign Marks For Annual result</h3>
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
		<div class="failedmsg">${msg}</div>
	</c:if>
	<br>
	<div style="width: 100%">
		<f:form commandName="AnnualExamReportDTO" method="POST" id="validate"
			action="assign-annual-marks-to-student.html"
			onsubmit="return validate();">
			<div id="searches" style="height: auto; width: 685px; float: left;">

				<table style="width: 631px;">
					<tr>
						<td style="width: 200px;">Session</td>
						<td style="width: 282px;"><f:select path="sessionId"
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
							</f:select></td>
						<td></td>
					</tr>
					<tr>
						<td style="width: 200px;">Exam Report Type</td>
						<td style="width: 282px;"><f:select id="annualExamType"
								onchange="examrepottype();" class="validate[required]"
								required="required" style="width: 282px;" name="monthId"
								path="annualExamType">
								<option value="">Select Exam Report Type</option>
								<option value="HALF-YEARLY">HALF-YEARLY</option>
								<option value="ANNUALLY">ANNUALLY</option>
							</f:select></td>
						<td><div id="reportmsg"></div></td>
					</tr>
					<tr>
						<td style="width: 200px;">Class</td>
						<td style="width: 282px;"><f:select id="classId"
								class="validate[required]" required="required"
								style="width: 282px;" onchange="getSectionList(this.value);"
								path="classId">
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
						<td><div id="classmsg"></div></td>
					</tr>
					<tr>
						<td style="width: 200px;">Section</td>
						<td style="width: 282px;"><f:select id="sectionId"
								onchange="section();" class="validate[required]"
								required="required" style="width: 282px;" path="sectionId">
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
						<td><div id="sectionmsg"></div></td>
					</tr>
					<tr>
						<td style="width: 200px;">Exam Type</td>
						<td style="width: 282px;"><f:select
								class="validate[required]" required="required" id="examType"
								style="width: 282px;" path="examType" onchange="changetype();">
								<option value="">Select Exam Type</option>
								<option value="UT+ORAL+PROJECT">UT+ORAL+PROJECT</option>
								<option value="MAIN EXAM">MAIN EXAM</option>
							</f:select></td>
						<td><div id="typemsg"></div></td>
					</tr>
					<tr>
						<td style="width: 200px;">Max Marks</td>
						<td style="width: 282px;"><f:input path="maxMarks"
								id="maxMarks"
								class="validate[required,maxSize[3],custom[integer]]" /></td>
						<td><div id="maxmsg"></div></td>
					</tr>
					<tr>
						<td style="width: 200px;"></td>
						<!-- id="assignsubjectmarks" -->
						<td style="width: 282px;"><a class="btn"
							id="assignsubjectmarks" href="javascript:getStudentList();">Assign</a></td>
					</tr>
				</table>
				<div class="separator"></div>
			</div>
			<div class="block" id="studentsubjects"></div>
		</f:form>
		<div style="width: 48%; float: right;">
			<div id="Student"></div>
			<div class="row-fluid">
				<div class="span12">
					<div id="appendassignsubjectmarks" class="block" style="top: 20px;"></div>
				</div>
			</div>
		</div>
	</div>
</div>