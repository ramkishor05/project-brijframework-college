<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/" var="base_url" />
<spring:url value="/img" var="img_url" />
<spring:url value="/css" var="css_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/setting.css">

<style>
.popup {
	display: none;
	background-color: white;
	border: 1px solid lightgray;
	width: 400px;
	height: 100px;
	border-radius: 6px;
	margin: auto;
	z-index: 1;
	position: fixed;
	display: block;
	top: 152px;
	left: 200px;
	padding: 40px;
}
</style>
<script type="text/javascript">
	function getSectionList(id) {
		$.ajax({
			type : "post",
			url : 'getsectionlist/' + id,
			success : function(data, status) {
				$("#msg").empty();
				$("#failedmsg").hide();
				$("#studentId").empty();
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
	function getsubjectList(sectionId) {
		$
				.ajax({
					type : "post",
					url : '${base_url}getsubjectlist',
					data : {
						'sessionId' : $("#sessionId").val(),
						'sectionId' : +sectionId,
						'classId' : +$("#classId").val()
					},
					success : function(data, status) {
						$("#failedmsg").hide();
						$("#appendsubjects").empty();
						var obj = JSON.parse(data);
						if (obj == '') {
							$("#appendsubjects")
									.append(
											'<div class="failedmsg">Subject Not Found</div>');
						} else {
							var content = '<div class="head blue"><div class="icon"><span class="ico-pen-2"></span></div>';
							content += '<h2>View Subjects List</h2></div><div class="data-fluid">';
							content += '<table width="100%" cellspacing="0" cellpadding="0" class="table"><thead>';
							content += '<tr><th width="25%">Subject Name</th><th width="25%">Operation</th></tr></thead><tbody>';
							$
									.each(
											obj,
											function(key, value) {
												content += '<tr><td>'
														+ value.subjectName
														+ '</td><td><a href="javascript:editSubject(subjectId='
														+ value.id
														+ ')"><span class="label label-success">Edit</span></a>|<a href="javascript:deletesubjects('
														+ value.id
														+ ');"><span class="label label-success">Delete</span></td></tr>';
											});

							content += '</tbody></table></div>';
							$("#appendsubjects").append(content);
						}
					},
					error : function(e) {
						alert('Error: ' + e);
					}

				});
	}
	function editSubject(subjectId) {
		$('#popup').show();
		$.ajax({
			type : "post",
			url : '${base_url}getsubjectname',
			data : {
				'subjectId' : subjectId,
			},
			success : function(data, status) {
				$("#msg").empty();
				$("#failedmsg").hide();
				$('#editSubjectId').val('');
				$('#editSubjectName').val('');
				var j = JSON.parse(data);
				$('#editSubjectId').val(subjectId);
				$('#editSubjectName').val(j.subjectName);
			},
			error : function(e) {
				alert('Error: ' + e);
			}
		});
	}
	function updateSubject() {
		var subjectId = $('#editSubjectId').val();
		var subjectName = $('#editSubjectName').val();
		$
				.ajax({
					type : "post",
					url : '${base_url}updatesubjectname',
					data : {
						'subjectId' : subjectId,
						'subjectName' : subjectName,
					},
					success : function(data, status) {
						var j = JSON.parse(data);
						if (j != '') {
							$("#msg")
									.append(
											'<div class="successmsg">Subject Updated Success</div>');
							$('#editSubjectId').val('');
							$('#editSubjectName').val('');
							$('#popup').hide();
							getsubjectList($("#sectionId").val());
						}
					},
					error : function(e) {
						alert('Error: ' + e);
					}
				});
	}

	function checkforexistanceofsubject(subjectName) {
		$
				.ajax({
					type : "post",
					url : '${base_url}checkforexistanceofsubject',
					data : {
						'sectionId' : $("#sectionId").val(),
						'classId' : $("#classId").val(),
						'subjectName' : subjectName,
						'sessionId' : $("#sessionId").val(),
					},
					success : function(data, status) {
						$("#msg").empty();
						$("#failedmsg").hide();
						var obj = JSON.parse(data);
						if (obj == 'YES') {
							$("#submitbutton").hide();
							$("#msg")
									.append(
											'<div class="failedmsg">This Subject has been already Created </div>');
						} else {
							$("#submitbutton").show();
							$("#appendmsg").empty();
						}
					},
					error : function(e) {

					}
				});
	}
	function deletesubjects(subjectId) {
		$
				.ajax({
					type : "post",
					url : '${base_url}deletesubjects',
					data : {
						'subjectId' : +subjectId,
					},
					success : function(data, status) {
						$("#msg").empty();
						$("#failedmsg").hide();
						$("#msg")
								.append(
										'<div class="failedmsg">Subject Deleted Successfully</div>');
						getsubjectList($("#sectionId").val());
					},
					error : function(e) {
						alert('Error: ' + e);
					}
				});
	}
	function getClear() {
		$("#msg").empty();
		$("#failedmsg").hide();
		$("#classId").val('');
		$("#sectionId").val('');
		$("#subjectName").val('');
	}
	function closePopup() {
		$('#popup').hide();
	}
</script>

<div class="content">
	<div id="content-header" style="height: 150px;">
		<img alt="Show_settings" src="${img_url}/subject.png"
			style="width: 50px; margin-top: -12px;">
		<h1>Manage Subjects</h1>
		<h3>Create/Edit/View Subjects</h3>
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

	<f:form action="create-subjects" method="post" commandName="SubjectDTO" id="validate">
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
							<option value="${list.classId}" data-original-title="" title="">
								${list.className}</option>
						</c:forEach>
					</f:select></td>
			</tr>
			<tr>
				<td style="width: 200px;">Section Name</td>
				<td><div id="branch">
						<f:select path="sectionId" class="form-control input-sm"
							id="sectionId" required="required"
							title="Specify the section for the selected class"
							onchange="getsubjectList(this.value)">
							<option selected="selected" value="" data-original-title=""
								title="">-- Section Name --</option>
						</f:select>
					</div></td>
			</tr>
			<tr>
				<td style="width: 200px;">Enter Subject Name</td>
				<td><f:input path="subjectName" class="validate[required,maxSize[15],custom[onlyLetterSp]]"
						oninput="checkforexistanceofsubject(this.value);" id="subjectName"
						style="width: 300px;" /></td>
			</tr>
			<tr>
				<td style="width: 200px;"></td>
				<td>
					<button style="float: left;" class="btn btn-success"
						id="submitbutton" type="submit">Submit</button>
				</td>
			</tr>
		</table>
		<div class="separator"></div>
		<f:hidden path="active" value="true" />
	</f:form>
	<hr>
	<div id="msg"></div>
	<c:if test="${! empty msg}">
		<div class="failedmsg" id="failedmsg">${msg}</div>
	</c:if>
	<div class="row-fluid">
		<div class="span12">
			<div class="block" id="appendsubjects"></div>
		</div>
	</div>
	<div id="popup" class="popup" style="display: none;">
		<table>
			<tr>
				<td style="width: 200px;">Change Subject Name:</td>
				<td><input type="hidden" required="required" value=""
					id="editSubjectId" style="width: 200px;" /> <input
					required="required" value="" id="editSubjectName"
					style="width: 200px;" /></td>
			</tr>
			<tr style="height: 10px;">
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td></td>
				<td><div id="appendmsg"></div>
					<button style="float: left; margin-right: 5px;"
						class="btn btn-success" id="submitbutton"
						onclick="updateSubject()" type="submit">Update</button>

					<button style="float: left;" class="btn btn-success"
						id="submitbutton" type="submit" onclick="closePopup()">Close</button></td>
			</tr>
		</table>
	</div>
</div>