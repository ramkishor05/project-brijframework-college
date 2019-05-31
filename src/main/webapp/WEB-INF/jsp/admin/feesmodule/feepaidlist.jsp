<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url value="/style/theme/images" var="imageurl" />
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/img" var="img_url" />
<spring:url value="/css" var="css_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/setting.css">
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
<script>
	function PaidView() {

		var sessionId = $("#sessionId").val();
		var classId = $("#classId").val();
		var sectionId = $("#sectionId").val();
		var monthId = $("#monthId").val();
		if ((sessionId == "" || sessionId == null)
				|| (classId == "" || classId == null)
				|| (sectionId == "" || sectionId == null)
				|| (monthId == "" || monthId == null))

		{
			$("#DefaulterList").empty();
			document.getElementById("v1").innerHTML = "All fields are required";

		} else {
			document.getElementById("v1").innerHTML = "";
			getPaidList(sessionId, classId, sectionId,
					monthId);


		}

	}
	

	function getPaidList(sessionId, classId, sectionId, monthId) {

		var url = 'getPaidList/' + sessionId + '/' + classId + '/'
				+ sectionId + '/' + monthId;
		$
				.ajax({
					url : url,

					type : 'POST',
					success : function(data, status) {

						$("#DefaulterList").empty();

						var j = JSON.parse(data);
						var st = "";
						var length = j.length;
					if (length == 0) {
						st = '<div class="alert alert-success"><h5 align="center"><font color="red"><b>No Payments received for this month</b></font></h5></div>';
					} else {
						st = st
						+ '<div><div class="widget-body" style="padding: 10px 0 0;"><div class="separator"></div><div class="btn-group" style="width: 400px;">'
						+ '</div><div class="block"><div class="head blue"><h4 style="text-align:center">Fee Paid List</h4></div>'
						+ '<table class="table table-bordered table-primary"><thead><tr><th>S.no</th><th>Student Name</th><th>Paid Amount</th><th>Mobile</th><th>Address</th></tr></thead><tbody>';
						for ( var i = 0; i < length; i++) {
							st+='<tr><td>'+(i+1)+'. </td><td>'+j[i].firstName+ " "+j[i].middleName+ " "+j[i].lastName+'</td><td>'+j[i].balanceAmount+'</td><td>'+j[i].mobile+'</td><td>'+j[i].addressLine1+'  '+j[i].cityName+'</td></tr>';


						}
						st+='</table>';						}

						$("#DefaulterList").append(st);

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
	
	function validate(){
		$("#classIds").val($("#classId").val());
		$("#sectionIds").val($("#sectionId").val());
		return true;
	}
</script>
<div class="content">
	<div id="content-header" style="height: 150px;">
		<img alt="Show_settings" src="${img_url}/sfees.jpg"
			style="width: 50px; margin-top: -12px;">
		<h1>List of Students who have Paid Fees</h1>
		<h3>Check MonthWise Fee Paid list</h3>
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

	<table
		style="width: 700px; height: 200px; margin-left: 231px; margin-top: 25px;">
	<f:form method="post" target="_blank" action="show-paid-pdf-report"
			commandName="studentDTO" onsubmit="return validate();">
			<f:input type="hidden" path="classId" id="classIds"/>
			<f:input type="hidden" path="sectionId" id="sectionIds"/>
		<tr>
			<td style="width: 200px;">Session</td>
			<td><select id="sessionId" style="width: 250px;"
				name="sessionId">
					<option value="${current.sessionId}">${current.sessionDuration}</option>
					<c:forEach var="list" items="${sessionList}">
						<option value="${list.sessionId}">${list.sessionDuration}</option>
					</c:forEach>
			</select></td>
			<td></td>
		</tr>

		<tr>
			<td style="width: 200px;">Class</td>
			<td><select id="classId" onchange="getSectionList(this.value);"
				style="width: 250px;" name="classId">
					<option value="">Select a class</option>
					<c:forEach var="list" items="${classList}">
						<option value="${list.classId}">${list.className}</option>
					</c:forEach>
			</select></td>
			<td></td>
		</tr>
		<tr>
			<td style="width: 200px;">Section</td>
			<td><select id="sectionId" style="width: 250px;"
				name="sectionId">
					<option value="">Select a Section</option>

			</select></td>
			<td></td>
		</tr>

		<tr>
			<td style="width: 200px;">Select Month</td>
			<td style="width: 300px;"><select id="monthId" name="monthId"
				style="width: 250px;">
					<option value="">Select Month</option>
					<option value="1">JAN</option>
					<option value="2">FEB</option>
					<option value="3">MAR</option>
					<option value="4">APR</option>
					<option value="5">MAY</option>
					<option value="6">JUN</option>
					<option value="7">JULY</option>
					<option value="8">AUG</option>
					<option value="9">SEP</option>
					<option value="10">OCT</option>
					<option value="11">NOV</option>
					<option value="12">DEC</option>
			</select></td>
			<td style="margin-right: 100px;"><a
				href="javascript:PaidView();">
					<h4 style="font-family: Times Roman;">View</h4>
			</a></td>
				<td style="margin-right: 100px;"><button type="submit" target="_blank"> View as PDF</button></h4>
			</a></td>
		</tr>

</f:form>

	</table>

	<div class="separator"></div>

	<div id="DefaulterList"></div>
	<div class="separator"></div>

	<div id="err" class="form-inline">
		<p id="v1"></p>

	</div>


</div>
