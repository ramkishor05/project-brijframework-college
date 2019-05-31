<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<spring:url value="/" var="baseurl"></spring:url>
<spring:url value="/img" var="img_url" />
<spring:url value="/style" var="style_url" />
<spring:url value="/css" var="css_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/setting.css">

<script type="text/javascript">

function getSectionList(id) {
	$("#gatePassDetails").empty();
	$("#previousDetails").empty();
	$("#studentData").empty();
	$("#leavingWith").val('');
	$("#reason").val('');
	$("#gatePasses").hide();
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
				for (var i = 0; i < j.length; i++) {
					students += '<option value='+j[i].admissionNo+'>'
							+ j[i].fullName + '</option>';
				}
				$("#studentId").append(students);
			},
			error : function(e) {

			}
		});
	}
}


</script>
<div id="content_wrapper">
	<div id="side_bar">

		<div id="sidebar_news_area"></div>
	</div>
	<div id="content">

		<div id="content-header" >
			<img alt="Show_settings" src="${img_url}/bluediamond-logo.jpg"
				 style="width: 50px;height: 50">
			<h1>Character Certificate</h1>
			<h3>Character Certificate Details</h3>
			<div id="app-back-button">
				<a href="home"><img alt="Back" border="0"
					src="${img_url}/home.png"
					style="margin-top: -6px; height: 40px; width: 40px;"></a> <a
					href="#" onclick="javascript:location.reload(true);"><img
					alt="Back" border="0" src="${img_url}/refresh.png"
					style="margin-top: -6px; height: 40px; width: 40px;"></a> <a
					href="#" onclick="history.back(); return false;"><img
					alt="Back" border="0" src="${img_url}/back.png"
					style="margin-top: -6px; height: 40px; width: 40px;"></a>
			</div>
		</div>
		
		<f:form id="validate" method="POST" enctype="multipart/form-data"
		action="savecharacter" commandName="characterDTO">
		
	<div class="row-fluid">
		<div class="span2" style="width: 605px;">

			<div class="block" style="left: -188px;">
				<table
					style="width: 604px; height: 0px; margin-left: 131px; margin-top: 15px;">
					
					<tr>
				<td style="width: 200px;">Session</td>
				<td><select id="sessionId" class="validate[required]"
					onchange="getClear();" style="width: 250px;" name="session"
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
					name="classes" class="select">
						<option value="">Select a Class</option>
						<c:forEach var="list" items="${classList}">
							<option value="${list.classId}">${list.className}</option>
						</c:forEach>
				</select></td>
			</tr>
					<tr>
				<td style="width: 200px;">Section</td>
				<td><select id="sectionId"  class="validate[required]"
					onchange="getStudentList();" style="width: 250px;" name="sectionName"
					class="select">
						<option value="">Select a Section</option>
				</select></td>
			</tr>

			<tr>
				<td style="width: 200px;">Students</td>
				<td><select id="studentId"  class="validate[required]"
					onchange=" " style="width: 250px;"
					name="fullName" class="select">
						<option value="">Select Student</option>
				</select></td>
			</tr>
					
					<tr>
						<td style="width: 200px;"><span id="s">Character<font
								color="red">*</font></span></td>
						<td><input type="text" name="character" placeholder="Enter Good/Bad"
							class="validate[required]"
							 style="width: 252px;"></td>
						<td></td>
					</tr>
					
						
				</table>
				<tr>
					<div class="btn-group">
								<input type="submit"  class="btn" value="Create" style="margin-left: 444px; margin-top: 40px;">
							</div>
					</tr>	
</f:form>
			</div>



		</div>	
		