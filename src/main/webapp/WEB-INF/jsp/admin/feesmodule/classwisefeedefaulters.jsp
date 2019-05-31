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
	function getclassdefaulters(classId) {
		$("#DefaulterList").empty();
		$("#DefaulterList")
				.append('<center><img src="${img}/loads.gif" alt="Loading" style="width=200px;height=200px;"></center>');
		var url = 'getclassdefaulters/' + classId;
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
							st = '<div class="failedmsg">There are no Dues</div>';
						} else {

							if(j[0].categoryName=='Nothing')
								st='<div class="failedmsg">Due Date is not assigned for all months.Go to Settings-> Manage Due Date->and Create Due Date.</div>';
								else
									{
								st = st
									+ '<div><div class="widget-body"  style="padding: 10px 0px 0px; margin-top: -50px;"><div class="separator"></div><div class="btn-group" style="width: 400px;">'
									+ '</div><div class="block"><a href="showclasswisedefaulterpdfreport?id='
									+ classId
									+ '" target="_blank"><img src="${img}/pdf.png"style="float: right; margin-top: -58px; margin-left: -10px; margin-right: 76px;"></a><a href="showclasswisedefaulterexcelreport?id='
									+ classId
									+ '" target="_blank"><img src="${img}/excels.jpg" style="float: right; margin-top: -85px;"></a><div class="head blue"><h4 style="text-align:center">Fee Dues</h4></div>'
									+ '<table class="table table-bordered table-primary"><thead><tr><th>S.no</th><th>Student Name</th><th>Father Name</th><th>Balance Amount</th><th>Mobile</th><th>Address</th></tr></thead><tbody>';
							for ( var i = 0; i < length; i++) {
								st += '<tr><td>' + (i + 1) + '. </td><td>'
										+ j[i].firstName + " "
										+ j[i].middleName + " " + j[i].lastName
										+ '</td><td>' + j[i].fatherName
										+ '</td><td>' + j[i].balanceAmount
										+ '</td><td>' + j[i].mobile
										+ '</td><td>' + j[i].addressLine1
										+ '</td></tr>';
							}
							st += '</table>';
									}
						}
						$("#DefaulterList").append(st);
					},
					error : function(error, status) {
					}
				});
	}
	

	function validate() {
		var classId = $("#classId").val();
		if (classId == "" || classId == null) {
			document.getElementById("v1").innerHTML = "All fields are required";
			return false;

		} else {
			document.getElementById("v1").innerHTML = "";
			return true;
		}

	}
</script>
<div class="content">
	<div id="content-header" style="height: 150px;">
		<img alt="Show_settings" src="${img_url}/sfees.jpg"
			style="width: 50px; margin-top: -12px;">
		<h1>Fee Dues List</h1>
		<h3>Check ClassWise Fee Dues list</h3>
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
		style="width: 700px; height: 200px; margin-left: 231px; margin-top: -50px;">

		<tr>
			<td style="width: 200px;">Class</td>
			<td><select id="classId"
				onchange="getclassdefaulters(this.value);" style="width: 250px;"
				name="classId">
					<option value="">Select a class</option>
					<c:forEach var="list" items="${classList}">
						<option value="${list.classId}">${list.className}</option>
					</c:forEach>
			</select></td>

		</tr>




	</table>

	<div class="separator"></div>
	<hr>
	<div id="DefaulterList"></div>
	<div class="separator"></div>

	<div id="err" class="form-inline">
		<p id="v1"></p>

	</div>


</div>
