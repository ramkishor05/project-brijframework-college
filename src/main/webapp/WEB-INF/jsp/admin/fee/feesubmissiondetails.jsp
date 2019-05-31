<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url value="/style/theme/images" var="imageurl" />
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/img" var="img_url" />
<spring:url value="/css" var="css_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/setting.css">
<spring:url value="/img" var="img" />

<script type="text/javascript">
	function getStudentsListsbyclass() {
		$("#students").empty();
		$("#students")
				.append(
						'<center><img src="${img}/loads.gif" alt="Loading" style="width=200px;height=200px;"></center>');
		var sessionId = $("#sessionId").val();
		var classId = $("#classId").val();
		var sectionId = $("#sectionId").val();

		var url = 'getStudentsListsbyclassforfee/' + classId + '/' + sectionId
				+ '/' + sessionId;
		$
				.ajax({
					url : url,

					type : 'POST',
					success : function(data, status) {

						$("#students").empty();
						$("#details").empty();
						var j = JSON.parse(data);

						var length = j.length;
						var st = "";

						if (length == 0) {
							st = '<div class="alert alert-success"><h5 align="center"><font color="red"><b>There are no students</b></font></h5></div>';
						} else {
							if (j[0].categoryName == 'Nothing')
								st = '<div class="failedmsg">Due Date is not assigned for all months.Go to Settings-> Manage Due Date->and Create Due Date.</div>';
							else {
								st = st
										+ '<div><div class="widget-body" style="padding: 10px 0 0;"><div class="separator"></div><div class="btn-group" style="width: 400px;">'
										+ '</div><div class="block"><div class="head blue"><h3 style="text-align:center">Students List</h3></div>'
										+ '<table class="table table-bordered table-primary"><thead><tr><th style="width: 255px;">Student Name</th><th>Contact No.</th></tr></thead><tbody>';

								for (var i = 0; i < length; i++) {
									if (j[i].defaulterStatus == 0) {
										st = st
												+ '<tr><td style="width: 100px;color:green;"><img src=../img/right.PNG>&nbsp;&nbsp;<a href="javascript:void(0)" onclick="javascript:showsubmissiondetails('
												+ j[i].admissionNo
												+ ')">'
												+ j[i].firstName
												+ '\t'
												+ j[i].middleName
												+ '\t'
												+ j[i].lastName
												+ '</td><td  style="color:green;">'
												+ j[i].mobile + '</td></tr>';
									}
									if (j[i].defaulterStatus == 1) {
										st = st
												+ '<tr><td style="width: 100px;color:red;"><img src=../img/wrong.PNG>&nbsp;&nbsp;<a href="javascript:void(0)" onclick="javascript:showsubmissiondetails('
												+ j[i].admissionNo
												+ ')">'
												+ j[i].firstName
												+ '\t'
												+ j[i].middleName
												+ '\t'
												+ j[i].lastName
												+ '</td><td  style="color:red;">'
												+ j[i].mobile + '</td></tr>';
									}
								}
								st = st + '</tbody></table></div></div>';
							}
						}
						$("#students").append(st);

					},
					error : function(error, status) {

					}
				});

	}
	function showsubmissiondetails(id) {

		var sessionId = $('#sessionId').val();

		var url = 'showsubmissiondetails/' + id + '/' + sessionId;
		$
				.ajax({
					url : url,

					type : 'POST',
					success : function(data, status) {

						$("#details").empty();

						var j = JSON.parse(data);

						var length = j.length;

						var st = "";
						if (length == 0) {
							st = '<div><h3 align="center"><font color="red"><b>There are no submissions</b></font></h3></div>';
						} else {
							st = st
									+ '<div><div class="widget-body" style="padding: 10px 0 0;"><div class="separator"></div><div class="btn-group" style="width: 1059px;">'
									+ '</div><div class="block"><div class="head green"><h3 style="text-align:center">Students Fee Submission Details</h3></div>'
									+ '<table class="table table-bordered table-primary"><thead><tr><th>Date</th><th>Amount</th><th>Month</th><th>See Receipt</th></tr></thead><tbody>';

							for (var i = 0; i < length; i++) {

								st = st
										+ '<tr><td style="width: 100px;">'
										+ j[i].feePaidDate
										+ '</td>'
										+ '<td>'
										+ Math.round(j[i].paidAmount)
										+ '</td><td>'
										+ j[i].month
										+ '</td>'
										+ '<td><a href="generatePDF.html?slipNo='
										+ j[i].recieptNo
										+ '&studentAdmissionNo='
										+ j[i].studentAdmissionNo
										+ '&toDate='
										+ j[i].toDate
										+ '&fromDate='
										+ j[i].fromDate
										+ '&feeSubDetailId='
										+ j[i].studentFeeSubmissionDetailsId
										+ '" target="_blank">See Receipt</a></td></tr>';

							}
							st = st + '</tbody></table></div></div>';
						}
						$("#details").append(st);

					},
					error : function(error, status) {

					}
				});

	}
	function getSectionList(id) {
		$("#sectionId").empty();
		$.ajax({
			type : "post",
			url : 'getsectionlist/' + id,
			success : function(data, status) {

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
	function getClear() {
		$("#classId").val('');
		$("#sectionId").val('');
	}

	function getStudentDatabyName(studentname) {
		$("#students").empty();
		$("#students")
				.append(
						'<center><img src="${img}/loads.gif" alt="Loading" style="width=200px;height=200px;"></center>');
		
		
			$
					.ajax({
						url : 'get-student-list-byName',
						type : 'post',
						data : {
							
							'name' : studentname,
						},
						success : function(data, status) {
							$("#students").empty();
							$("#details").empty();
							var j = JSON.parse(data);

							var length = j.length;
							var st = "";

							if (length == 0) {
								st = '<div class="alert alert-success"><h5 align="center"><font color="red"><b>There are no students</b></font></h5></div>';
							} else {
								if (j[0].categoryName == 'Nothing')
									st = '<div class="failedmsg">Due Date is not assigned for all months.Go to Settings-> Manage Due Date->and Create Due Date.</div>';
								else {
									st = st
											+ '<div><div class="widget-body" style="padding: 10px 0 0;"><div class="separator"></div><div class="btn-group" style="width: 400px;">'
											+ '</div><div class="block"><div class="head blue"><h3 style="text-align:center">Students List</h3></div>'
											+ '<table class="table table-bordered table-primary"><thead><tr><th style="width: 255px;">Student Name</th><th>Contact No.</th></tr></thead><tbody>';

									for (var i = 0; i < length; i++) {
										if (j[i].defaulterStatus == 0) {
											st = st
													+ '<tr><td style="width: 100px;color:green;"><img src=../img/right.PNG>&nbsp;&nbsp;<a href="javascript:void(0)" onclick="javascript:showsubmissiondetails('
													+ j[i].admissionNo
													+ ')">'
													+ j[i].firstName
													+ '\t'
													+ j[i].middleName
													+ '\t'
													+ j[i].lastName
													+ '</td><td  style="color:green;">'
													+ j[i].mobile
													+ '</td></tr>';
										}
										if (j[i].defaulterStatus == 1) {
											st = st
													+ '<tr><td style="width: 100px;color:red;"><img src=../img/wrong.PNG>&nbsp;&nbsp;<a href="javascript:void(0)" onclick="javascript:showsubmissiondetails('
													+ j[i].admissionNo
													+ ')">'
													+ j[i].firstName
													+ '\t'
													+ j[i].middleName
													+ '\t'
													+ j[i].lastName
													+ '</td><td  style="color:red;">'
													+ j[i].mobile
													+ '</td></tr>';
										}
									}
									st = st + '</tbody></table></div></div>';
								}
							}
							$("#students").append(st);
						},
						error : function(e) {
							alert(e)
						}
					});
		

	}
</script>
<div class="content">
	<div id="content-header" style="height: 150px;">
		<img alt="Show_settings" src="${img_url}/sfees.jpg"
			style="width: 50px; margin-top: -12px;">
		<h1>Fee Submission Record</h1>
		<h3>View Fee Submission Record</h3>
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

</div>
<div id="searches">
	<f:form action="student-details" method="post" commandName="studentDTO">
		<br>


		<%-- <table style="width: 1059px;">

			<tr>
				<td style="width: 200px;"></td>
				<td><select name="sessionId" class="form-control input-sm" hidden="true"
					style="width: 250px;" id="sessionId" x-data-toggle-x="tooltip"
					title="Specify the session of the student" onchange="getClear();"
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
				</select></td>
			</tr>
			</table>
			<tr>
				<td style="width: 200px;">Class</td>
				<td><select id="classId" class="validate[required]"
					onchange="getSectionList(this.value);" style="width: 250px;"
					name="classId" class="select">
						<option value="">Select a class</option>
						<c:forEach var="list" items="${classList}">
							<option value="${list.classId}">${list.className}</option>
						</c:forEach>
				</select></td>
			</tr>
			<tr>
				<td style="width: 200px;">Section</td>
				<td><select id="sectionId" class="validate[required]"
					style="width: 250px;" onchange="getStudentsListsbyclass();"
					name="sectionId" class="select">
						<option value="">Select a Section</option>
						<c:forEach var="list" items="${sectionList}">
							<option value="${list.sectionId}">${list.sectionName}</option>
						</c:forEach>
				</select></td>
			</tr>
			<tr>
				<td style="width: 200px;">Student Name</td>
				<td><input type="text" name="studentName"
					oninput="getStudentDatabyName(this.value)" style="width: 250px;"></td>
			</tr>

		</table> --%>

		<div class="separator"></div>
		<div class="span4">
				<div class="block" style="width: 299px;">
					<div id="searches1"
						style="height: auto; width: 297px; border: 1px solid lightgray; background-color: rgb(238, 238, 238); border-radius: 5px;">
						
						
						
						<div class="data-fluid">			 	
						
							<div class="row-form">
								<div class="span4" style="margin-left: 0px; width: 100px;">Session :</div>
								<div class="span8">
									<select id="sessionId" class="validate[required]"
										onchange="getClear();" name="sessionId" class="select" style="width: 200px; margin-left: 44px; margin-top: -27px;">
										<option value="${current.sessionId}">${current.sessionDuration}</option>
										<c:forEach var="list" items="${sessionList}">
											<option value="${list.sessionId}">${list.sessionDuration}</option>
										</c:forEach>
									</select>
								</div>
							</div>
							<div class="row-form">
								<div class="span4" style="margin-left: 0px; width: 100px;">Name :</div>
								<div class="span8">
									<input type="text" name="studentName"
										oninput="getStudentDatabyName(this.value)" style="width: 200px; margin-left: 44px; margin-top: -27px;">
								</div>
							</div>

						</div>
						
					</div>
				</div>
			</div>


	</f:form>
</div>
<!-- <div id="students"></div>
		<div id="details"></div> -->
<div class="row-fluid">
	<div class="span6">
		<div class="block">

			<div class="data-fluid" id="students"></div>
		</div>
	</div>
	<div class="span6">
		<div class="block">
			<div class="block" id="details"></div>
		</div>
	</div>

</div>

