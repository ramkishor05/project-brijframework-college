
<%@taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<spring:url value="/js" var="js_url" />
<c:url value="style/theme/images" var="backurl" />
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/img" var="img_url" />
<spring:url value="/css" var="css_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/setting.css">
<script>
	function getCancelledList(sessionId) {
		var url = 'regCancelledList/' + sessionId;
		$
				.ajax({
					url : url,
					type : 'POST',
					success : function(data, status) {
						$("#students").empty();
						var j = JSON.parse(data);
						var length = j.length;
						var st = "";
						if (length == 0) {
							st = '<div class="failedmsg">There Are No Students</h5></div>';
						} else {
							st = '<div><div class="widget-body" style="padding: 10px 0 0;"><div class="separator"></div><div class="btn-group" style="width: 1059px;">'
									+ '</div><div class="block"><div class="head blue"><div class="icon"><span class="ico-pen-2"></span></div><h2>Students List</h2></div>'
									+ '<table class="table table-bordered table-primary"><thead><tr><th>Reg.No.</th><th>Student Name</th><th>Father Name</th><th>Mother Name</th><th>Class</th><th>DOB</th><th>Phone No</th><th>View Form</th><th>Delete</th></tr></thead><tbody>';

							for ( var i = 0; i < length; i++) {
								st = st
										+ '<tr><td style="width: 200px;"><a href="show-application?id='
										+ j[i].studentId
										+ '">'+j[i].regNo+'</a></td><td>'
										+ j[i].studentName
										+ '</td><td>'
										+ j[i].fatherName
										+ '</td><td>'
										+ j[i].motherName + '</td>' + '<td>'
										+ j[i].className + '</td>' + '<td>'
										+ j[i].dateOfBirth + '</td><td>'
										+ j[i].phoneNo + '</td><td><a href="show-application?id='+ j[i].studentId+'" target="_blank"><span class="label label-primary">View</span></a></td>'
										+'<td><a href="delete-registration?id='+ j[i].studentId+'"><span class="label label-important">Delete</span></a></td></tr>';

							}

							st = st + '</tbody></table></div></div></div>';
						}
						$("#students").append(st);

					},
					error : function(error, status) {

					}
				});

	}

	window.onload = function() {
		var se = $("#sessionId").val();
		getCancelledList(se);
	}
</script>
<div class="content">
	<div id="content-header" style="height: 150px;">
		<img alt="Show_settings" src="${img_url}/cancels.jpg"
			style="width: 50px; margin-top: -12px;">
		<h1>Cancelled Students</h1>
		<h3>List of Students whose registration has been cancelled</h3>
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

	<div
		class="widget widget-2 widget-tabs widget-tabs-2 tabs-right border-bottom-none"></div>
	<div class="row-form" style="margin-top: -160px;">
		<div class="span2">
			Select Session :<font color="red">*</font>
		</div>
		<div class="span4">
			<select name="sessionId" class="form-control input-sm"
				style="width: 200px;" id="sessionId" x-data-toggle-x="tooltip"
				title="Specify the session of the student"
				onchange="getCancelledList(this.value);"
				data-original-title="Specify session">
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
			</select>
		</div>
	</div>
	<div id="students"></div>
</div>