<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url value="/style/theme/images" var="imageurl" />
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/img" var="img_url" />
<spring:url value="/css" var="css_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/setting.css">
<spring:url value="/style/js" var="words" />
<script type="text/javascript" src="${words}/towards.js">
	
</script>

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

	function getStudentList() {
		var sessionId = $('#sessionId').val();
		var classId = $('#classId').val();
		var sectionId = $('#sectionId').val();
		if (sessionId == '' || classId == '' || sectionId == '') {
			alert("Fill Above Data First. Please!!");
		} else {
			$.ajax({
				type : "post",
				url : 'get-student-list',
				data : {
					'classId' : classId,
					'sectionId' : sectionId,
					'sessionId' : sessionId,
				},
				success : function(data, status) {
					$("#studentId").empty();
					var j = JSON.parse(data);
					var students = '<option value="">Select Student</option>';
					for ( var i = 0; i < j.length; i++) {
						students += '<option value='+j[i].admissionNo+'>'
								+ j[i].fullName + '</option>';
					}
					$("#studentId").append(students);
				},
				error : function(e) {
					alert('Error: ' + e);
				}
			});
		}
	}
	function getStudentFeeDetails(id) {
		$("#classwise").empty();
		$("#sectionwise").empty();
		$("#studentwise").empty();
		var sessionId = $('#sessionId').val();
		var classId = $('#classId').val();
		var sectionId = $('#sectionId').val();
		if (classId == '' || sectionId == '') {
			alert("Fill Above Data First. Please!!");
		} else {
			$
					.ajax({
						type : "post",
						url : 'getstudentallotedfee',
						data : {
							'studentAdmissionNo' : id,
							'classId' : classId,
							'sessionId' : sessionId,
							'sectionId' : sectionId
						},
						success : function(data, status) {

							var obj = JSON.parse(data);
							var classwise = '<div class="head blue"><div class="icon"><span class="ico-pen-2"></span></div><h2>Class Wise</h2></div>';
							classwise += '<div class="data-fluid"><table width="100%" cellspacing="0" cellpadding="0" class="table">';
							classwise += '<thead><tr><th width="25%">Session</th><th width="25%">FeeCategory</th><th width="25%">Alloted Month</th><th width="25%">Action</th></tr></thead><tbody>';
							$
									.each(
											obj.ClassWiseFeeDTOs,
											function(key, value) {
												classwise += '<tr><td>'
														+ value.sessionName
														+ '</td><td>'
														+ value.feesCategoriesName
														+ '</td><td>'
														+ value.monthName
														+ '</td><td><a id="" href=javascript:sendtoeditpage("ClassWise",'
														+ value.monthId
														+ ','
														+ value.feesCategoriesId
														+ ','
														+ value.feeAmount
														+ ',"'
														+ value.monthName
														+ '");><span class="label label-success">Edit</span></a></td></tr>';
											});
							classwise += '</tbody></table></div>';

							var sectionwise = '<div class="head green"><div class="icon"><span class="ico-pen-2"></span></div><h2>Section Wise</h2></div>';
							sectionwise += '<div class="data-fluid"><table width="100%" cellspacing="0" cellpadding="0" class="table">';
							sectionwise += '<thead><tr><th width="25%">Session</th><th width="25%">FeeCategory</th><th width="25%">Alloted Month</th><th width="25%">Action</th></tr></thead><tbody>';
							$
									.each(
											obj.SectionWiseFeeDTOs,
											function(key, value) {
												sectionwise += '<tr><td>'
														+ value.sessionName
														+ '</td><td>'
														+ value.feesCategoriesName
														+ '</td><td>'
														+ value.monthName
														+ '</td><td><a href=javascript:sendtoeditpage("SectionWise",'
														+ value.monthId
														+ ','
														+ value.feesCategoriesId
														+ ','
														+ value.feeAmount
														+ ',"'
														+ value.monthName
														+ '");><span class="label label-success">Edit</span></a></td></tr>';
											});
							sectionwise += '</tbody></table></div>';

							var studentwise = '<div class="head purple"><div class="icon"><span class="ico-pen-2"></span></div><h2>Student Wise Fee</h2></div>';
							studentwise += '<div class="data-fluid"><table width="100%" cellspacing="0" cellpadding="0" class="table">';
							studentwise += '<thead><tr><th width="25%">Session</th><th width="25%">FeeCategory</th><th width="25%">Alloted Month</th><th width="25%">Action</th></tr></thead><tbody>';
							$
									.each(
											obj.StudentWiseFeeDTOs,
											function(key, value) {
												studentwise += '<tr><td>'
														+ value.sessionName
														+ '</td><td>'
														+ value.feesCategoriesName
														+ '</td><td>'
														+ value.monthName
														+ '</td><td><a href=javascript:sendtoeditpage("StudentWise",'
														+ value.monthId
														+ ','
														+ value.feesCategoriesId
														+ ','
														+ value.feeAmount
														+ ',"'
														+ value.monthName
														+ '");><span class="label label-success">Edit</span></a></td></tr>';
											});
							studentwise += '</tbody></table></div>';
							if (obj.ClassWiseFeeDTOs.length > 0) {
								$("#classwise").append(classwise);
							}
							if (obj.SectionWiseFeeDTOs.length > 0) {
								$("#sectionwise").append(sectionwise);
							}
							if (obj.StudentWiseFeeDTOs.length > 0) {
								$("#studentwise").append(studentwise);
							}
						},
						error : function(e) {
							alert('Error: ' + e);
						}
					});
		}
	}
	function sendtoeditpage(variableStatus, monthId, feeCategoryId, feeAmount,
			monthName) {
		var sessionId = $('#sessionId').val();
		var classId = $('#classId').val();
		var sectionId = $('#sectionId').val();
		var studentId = $('#studentId').val();
		document.location.href = "changeallotedfeeamount?monthId=" + monthId
				+ "&sessionId=" + sessionId + "&feeCategoryId=" + feeCategoryId
				+ "&classId=" + classId + "&sectionId=" + sectionId
				+ "&studentId=" + studentId + "&datatype=" + variableStatus
				+ "&feeAmount=" + feeAmount + "&monthName=" + monthName;

	}
</script>
<div class="content">
	<div id="content-header" style="height: 150px;">
		<img alt="Show_settings" src="${img_url}/sfees.jpg"
			style="width: 50px; margin-top: -12px;">
		<h1>Student Alloted Fees</h1>
		<h3>View Student Alloted Fees</h3>
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
	<c:if test="${! empty msg}">
		<div class="successmsg">${msg}</div>
	</c:if>
	<div id="searches" style="height: auto; width: auto;">
		<br> <br> <br>
		<table>
			<tr>
				<td style="width: 200px;">Session</td>
				<td><select id="sessionId" class="validate[required]"
					onchange="getClear();" style="width: 250px;" name="sessionId"
					class="select">
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
					style="width: 250px;" onchange="getSectionList(this.value);"
					name="classId" class="select">
						<option value="">Select a Class</option>
						<c:forEach var="list" items="${classesList}">
							<option value="${list.classId}">${list.className}</option>
						</c:forEach>
				</select></td>
			</tr>
			<tr>
				<td style="width: 200px;">Section</td>
				<td><select id="sectionId" class="validate[required]"
					onchange="getStudentList();" style="width: 250px;" name="sectionId"
					class="select">
						<option value="">Select a Section</option>
				</select></td>
			</tr>
			<tr>
				<td style="width: 200px;">Students</td>
				<td><select id="studentId" class="validate[required]"
					onchange="getStudentFeeDetails(this.value);" style="width: 250px;"
					name="studentAdmissionNo" class="select">
						<option value="">Select Student</option>
				</select></td>
			</tr>
		</table>
		<div class="separator"></div>
	</div>
	<div class="row-fluid">
		<div class="span12">
			<div class="block" id="classwise"></div>
			<div class="block" id="sectionwise"></div>
			<div class="block" id="studentwise"></div>
		</div>
	</div>
</div>