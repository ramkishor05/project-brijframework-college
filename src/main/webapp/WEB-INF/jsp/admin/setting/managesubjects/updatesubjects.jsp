<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/" var="base_url" />
<spring:url value="/img" var="img_url" />
<spring:url value="/css" var="css_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/setting.css">
<script type="text/javascript">
	function getSectionList(id) {
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
	function getsubjectListList(sectionId) {
		$
				.ajax({
					type : "post",
					url : '${base_url}getsubjectlist',
					data : {
						'sectionId' : +sectionId,
						'classId' : +$("#classId").val()
					},
					success : function(data, status) {
						$("#appendsubjects").empty();
						var obj = JSON.parse(data);
						var content = '<div class="head blue"><div class="icon"><span class="ico-pen-2"></span></div>';
						content += '<h2>View Subjects, Class And Section Vise</h2></div><div class="data-fluid">';
						content += '<table width="100%" cellspacing="0" cellpadding="0" class="table"><thead>';
						content += '<tr><th width="25%">Subject Name</th><th width="25%">Operation</th></tr></thead><tbody>';
						$
								.each(
										obj,
										function(key, value) {
											content += '<tr><td>'
													+ value.subjectName
													+ '</td><td><span class="label label-success">Edit|Delete</span></td></tr>';
										});

						content += '</tbody></table></div>';
						$("#appendsubjects").append(content);
					},
					error : function(e) {
						alert('Error: ' + e);
					}
				});
	}

	function checkforexistanceofsubject() {
		if ($("#orignalSubjectName").val() != $("#subjectName").val()) {
			$
					.ajax({
						type : "post",
						url : '${base_url}checkforexistanceofsubject',
						data : {
							'subjectName' : $("#subjectName").val(),
							'sectionId' : +$("#sectionId").val(),
							'classId' : +$("#classId").val(),
							'sessionId' : $("#sessionId").val(),
						},
						success : function(data, status) {
							var obj = JSON.parse(data);
							if (obj == 'YES') {
								$("#submitbutton").hide();
								$("#appendmsg")
										.append(
												'<div class="failedmsg">This Subject has been already Created </div>');
							} else {
								$("#submitbutton").show();
								$("#appendmsg").empty();
							}
						},
						error : function(e) {
							alert('Error: ' + e);
						}
					});
		}
	}
	function getClear() {
		$("#classId").val('');
		$("#sectionId").val('');
		$("#subjectName").val('');
	}
</script>

<div class="content">
	<div id="content-header" style="height: 150px;">
		<img alt="Show_settings" src="${img_url}/city.jpg"
			style="width: 50px; margin-top: -12px;">
		<h1>Edit Subjects</h1>
		<h3>Update Subject Name and details</h3>
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
		<div class="successmsg">${msg}</div>
	</c:if>
	<f:form action="update-subjects" method="post" commandName="SubjectDTO">
		<br>
		<input type="hidden" id="orignalSubjectName"
			value="${SubjectDTO.subjectName}">
		<f:hidden path="id" value="${SubjectDTO.id}" />
		<table style="width: 500px; height: 100px;">
			<tr>
				<td style="width: 200px;">Session</td>
				<td><f:select path="sessionId" class="form-control input-sm"
						id="sessionId" required="required" onchange="getClear();">
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
			</tr>
			<tr>
				<td style="width: 200px;">Class Name:</td>
				<td><f:select path="classId" class="form-control input-sm"
						id="classId" required="required"
						onchange="getSectionList(this.value)">
						<option selected="selected" value="" title="">-- Select
							Class --</option>
						<c:forEach var="list" items="${list}" varStatus="loop">
							<c:choose>
								<c:when test="${SubjectDTO.classId==list.classId}">
									<option value="${list.classId}" data-original-title=""
										selected="selected" title="">${list.className}</option>
								</c:when>
								<c:otherwise>
									<option value="${list.classId}" data-original-title="" title="">
										${list.className}</option>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</f:select></td>
			</tr>
			<tr>
				<td style="width: 200px;">Section Name</td>
				<td><div id="branch">
						<f:select path="sectionId" class="form-control input-sm"
							id="sectionId" required="required"
							title="Specify the section for the selected class">
							<option value="${SubjectDTO.sectionId}" data-original-title=""
								title="">${SubjectDTO.sectionName}</option>
						</f:select>
					</div></td>
			</tr>
			<tr>
				<td style="width: 200px;">Enter Subject Name</td>
				<td><f:input path="subjectName" required="required" value=""
						onkeyup="checkforexistanceofsubject();" id="subjectName"
						style="width: 300px;" /></td>
			</tr>
			<tr>
				<td style="width: 200px;"></td>
				<td><div id="appendmsg"></div>
					<button style="float: right;" class="btn btn-success"
						id="submitbutton" type="submit">Submit</button></td>
			</tr>
		</table>
		<div class="separator"></div>
		<f:hidden path="active" value="true" />


	</f:form>

</div>