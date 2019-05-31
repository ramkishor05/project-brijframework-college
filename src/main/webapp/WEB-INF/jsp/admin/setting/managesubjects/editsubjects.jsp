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
						'classId' : +$("#classId").val(),
						'sessionId' :+$("#sessionId").val(),
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
													+ '</td><td><a href="edit-update-subjects?subjectId='
													+ value.id
													+ '"><span class="label label-success">Edit</span></a>|<a href="javascript:deletesubjects('
													+ value.id
													+ ');"><span class="label label-success">Delete</span></td></tr>';
										});

						content += '</tbody></table></div>';
						$("#appendsubjects").append(content);
					},
					error : function(e) {
						
					}
				});
	}
	function deletesubjects(subjectId) {
		$.ajax({
			type : "post",
			url : '${base_url}deletesubjects',
			data : {
				'subjectId' : +subjectId,
			},
			success : function(data, status) {
				$("#deletemsg").show();
				getsubjectListList($("#sectionId").val());
			},
			error : function(e) {
				
			}
		});
	}
	function getClear()
	{
		$("#classId").val('');
		$("#sectionId").val('');
		$("#subjectName").val('');
		$("#appendsubjects").empty();
	}
</script>

<div class="content">
	<div id="content-header" style="height: 150px;">
		<img alt="Show_settings" src="${img_url}/city.jpg"
			style="width: 50px; margin-top: -12px;">
		<h1>Edit Subjects</h1>
		<h3>Select And Edit Subjects</h3>
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
	<div class="alert alert-success" id="deletemsg"
		style="height: 28px; padding-top: 0px; padding-bottom: 1px; margin-bottom: 0px;display: none;">
		<h5 align="center">
			<font color="red" id="font"><b>Subject Delete Successfully</b></font>
		</h5>
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
	<table style="width: 500px; height: 100px;">
		<tr>
				<td style="width: 200px;">Session</td>
				<td><select path="sessionId" class="form-control input-sm"
						id="sessionId" required="required"
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
			<td style="width: 200px;">Class Name:</td>
			<td><select class="form-control input-sm" id="classId"
				onchange="getSectionList(this.value)">
					<option selected="selected" value="" title="">-- Select
						Class --</option>
					<c:forEach var="list" items="${list}" varStatus="loop">
						<option value="${list.classId}" data-original-title="" title="">
							${list.className}</option>
					</c:forEach>
			</select></td>
		</tr>
		<tr>
			<td style="width: 200px;">Section Name</td>
			<td><div id="branch">
					<select class="form-control input-sm" id="sectionId"
						title="Specify the section for the selected class"
						onchange="getsubjectListList(this.value)">
						<option selected="selected" value="" data-original-title=""
							title="">-- Section Name --</option>
					</select>
				</div></td>
		</tr>
	</table>
	<div class="separator"></div>


	<div class="row-fluid">
		<div class="span12">
			<div class="block" id="appendsubjects"></div>
		</div>
	</div>



</div>