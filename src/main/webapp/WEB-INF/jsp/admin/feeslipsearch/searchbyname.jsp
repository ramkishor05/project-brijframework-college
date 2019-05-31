<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/img" var="img_url" />
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<spring:url value="/css" var="css_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/setting.css">
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<style>
#err {
	color: red;
	font-weight: normal;
	font-size: 20px;
	padding: 2px 8px 0px;
	margin-top: 2px;
	margin-bottom: -2px;
}
</style>

<script type="text/javascript">
	
	function searchbyslipno() {
		var classId= $("#classById").val();
		var sessionId=$("#sessionId").val()
		if ((classId == "" || classId == null) ||(sessionId == "" || sessionId == null))
		{
			document.getElementById("err").innerHTML = "Fill all above fields first";
			
			}
		else
			{
			document.getElementById("err").innerHTML = "";
		$
				.ajax({
					type : "post",
					url : 'getfeedetaibyname',
					data : {
						'classId' : $("#classById").val(),
						'sessionId' : $("#sessionId").val(),
						'name' : $("#name").val()
					},
					success : function(data) {
						$("#appenddata").empty();
						var obj = JSON.parse(data);
						var content = '<table cellspacing="0" cellpadding="0" width="100%" class="table"><thead><tr>';
						content += '<th>Student Name</th><th>Months</th><th>Class</th><th>Section</th>';
						content += '<th>Slip No</th><th>L.F.No</th><th>Paid Amount</th><th>Paid Status</th>';
						content += '<th >Paid Date</th><th>Action</th></tr></thead><tbody>';
						$
								.each(
										obj,
										function(key, value) {
											if(value.feePaidStatus=='completed')
											{
										content += ' <tr><td style="color:green;"><a href="show-student-details?id='
												+ value.studentAdmissionNo
												+ '"><img src=../img/right.PNG>&nbsp;&nbsp;'
												+ value.studentName
												+ '</a></td><td style="color:green;">'
												+ value.month
												+ '</td><td style="color:green;">'
												+ value.className
												+ '</td><td style="color:green;">'
												+ value.sectionName
												+ '</td><td style="color:green;">'
												+ value.commonRecieptNo
												+ '</td><td style="color:green;">'
												+ value.lFno
												+ '</td><td style="color:green;">'
												+ value.paidAmount
												+ '</td><td style="color:green;">'
												+value.feePaidStatus
												+'</td><td style="color:green;">'
												+ value.feePaidDate
												+ '</td><td style="color:green;"><a href="generatePDF.html?slipNo='
												+ value.recieptNo
												+ '&studentAdmissionNo='
												+ value.studentAdmissionNo
												+ '" target="_blank"><span class="label label-success">View Pdf</span></td></tr>';
											}
										if(value.feePaidStatus=='cancel')
										{
									content += ' <tr><td style="color:red;"><a href="show-student-details?id='
											+ value.studentAdmissionNo
											+ '"><img src=../img/wrong.PNG>&nbsp;&nbsp;'
											+ value.studentName
											+ '</a></td><td style="color:red;">'
											+ value.month
											+ '</td><td style="color:red;">'
											+ value.className
											+ '</td><td style="color:red;">'
											+ value.sectionName
											+ '</td><td style="color:red;">'
											+ value.recieptNo
											+ '</td><td style="color:red;">'
											+ value.lFno
											+ '</td><td style="color:red;">'
											+ value.paidAmount
											+ '</td><td style="color:red;">'
											+value.feePaidStatus
											+'</td><td style="color:red;">'
											+ value.feePaidDate
											+ '</td><td style="color:red;"><a href="generatePDF.html?slipNo='
											+ value.recieptNo
											+ '&studentAdmissionNo='
											+ value.studentAdmissionNo
											+ '" target="_blank"><span class="label label-success">View Pdf</span></td></tr>';
										}
										if(value.feePaidStatus=='inprogress')
										{
									content += ' <tr><td><a href="show-student-details?id='
											+ value.studentAdmissionNo
											+ '"><img src=../img/progress.gif>&nbsp;&nbsp;'
											+ value.studentName
											+ '</a></td><td>'
											+ value.month
											+ '</td><td>'
											+ value.className
											+ '</td><td>'
											+ value.sectionName
											+ '</td><td>'
											+ value.recieptNo
											+ '</td><td>'
											+ value.lFno
											+ '</td><td>'
											+ value.paidAmount
											+ '</td><td>'
											+value.feePaidStatus
											+'</td><td>'
											+ value.feePaidDate
											+ '</td><td><a href="generatePDF.html?slipNo='
											+ value.recieptNo
											+ '&studentAdmissionNo='
											+ value.studentAdmissionNo
											+ '" target="_blank"><span class="label label-success">View Pdf</span></td></tr>';
										}
										});
						content += '</tbody></table>';
						if (obj.length > 0) {
							$("#appenddata").append(content);
						} else {
							$("#appenddata")
									.append(
											'<font color="red">No Data Found For your Search </font>');
						}
					},
					error : function(e) {
						
					}
				});
			}
	}
	function getClear() {
		$("#classById").val('');
		$("#name").val('');
	
	}
	function getnameclear() {
	
		$("#name").val('');
	
	}
</script>

<div class="content">
	<div class="page-header">
		<div id="content-header" style="height: 112px; width: 1056px;">
			<img alt="Show_settings" src="${img_url}/sfees.jpg"
				style="width: 50px;">
			<h2>Search by Name</h2>
			<h3>Search by Name</h3>
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
		<!-- <div style="float: right; margin-top: 11px; margin-right: 30px;">
			<a href="search-by-admission.html" class="btn btn-success"
				style="margin-right: 5px;">Search by Admission No</a> <a
				href="search-by-slip-no.html" class="btn btn-success"
				style="margin-right: 5px;">Search By Slip No</a> <a
				href="search-by-date.html" class="btn btn-success"
				style="margin-right: 5px;">Search By Date</a>
		</div> -->
	</div>
	<div class="row-fluid">
		<div class="span6">
			<div class="block">
				<div class="data-fluid">
				<div class="row-form">
						<div class="span3">Session</div>
						<div class="span9">
							<select id="sessionId" class="validate[required]"
						onchange="getClear();" style="width: 250px;" name="sessionId"
						class="select">
							<option value="${current.sessionId}">${current.sessionDuration}</option>
							<c:forEach var="list" items="${sessionList}">
								<option value="${list.sessionId}">${list.sessionDuration}</option>
							</c:forEach>
					</select>
						</div>
					</div>
					<div class="row-form">
						<div class="span3">Class:</div>
						<div class="span9">
							<select id="classById" onchange="getnameclear();"
								style="width: 250px;" name="className">
								<option value="">Select a class</option>
								<c:forEach var="list" items="${classList}">
									<option value="${list.classId}">${list.className}</option>
								</c:forEach>
							</select>
						</div>
					</div>
				
					<div class="row-form">
						<div class="span3">Enter Name:</div>
						<div class="span9">
							<input type="text" id="name"  onkeyup="javascript:searchbyslipno();" style="width: 250px;">
						</div>
					</div>
					<div class="row-form">
						<div class="span3"></div>
						<div class="span9">
							
<div id="err" class="form-inline">
		<p id="v1"></p>

	</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="row-fluid">
		<div class="span12">
			<div class="block">
				<div class="head blue">
					<div class="icon">
						<span class="ico-pen-2"></span>
					</div>
					<h2>Detail List</h2>
					<ul class="buttons">
						<li><a onclick="source('table_default'); return false;"
							href="#"><div class="icon">
									<span class="ico-info"></span>
								</div></a></li>
					</ul>
				</div>
				<div class="data-fluid" id="appenddata"></div>
			</div>
		</div>

	</div>


</div>