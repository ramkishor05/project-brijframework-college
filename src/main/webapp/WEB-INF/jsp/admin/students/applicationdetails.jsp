<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url value="/style/theme/images" var="imageurl" />
<spring:url value="/img" var="img_url" />
<spring:url value="/" var="base_url" />
<spring:url value="/css" var="css_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/admission.css">
<div class="content">
	<div id="content-header" style="height: 150px;">
		<img alt="Show_settings" src="${img_url}/student_profile.jpg"
			style="width: 74px; margin-top: -15px;">
		<h1>Student Profile</h1>
		<h3>Search Students and Manage Profile</h3>
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
</div>
<div style="padding: 10px 0 0;" class="widget-body">
	<div class="separator"></div>
	<div style="width: 1059px;" class="btn-group"></div>
	<div class="block">
		<div style="height: 30px; padding: 0.5px 0 0 20px;" class="head blue">
			<h4>Students List</h4>
		</div>
		<table class="table table-bordered table-primary">
			<thead>
				<tr>
					<th>Reg.No</th>
					<th>Student Name</th>
					<th>Father Name</th>
					<th>Mother Name</th>
					<th>Class</th>
					<th>DOB</th>
					<th>Phone No</th>
					<th>View Form</th>
					<th>Transfer</th>
					<th>Cancel Registration</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${applicationDetails}" var="list">
					<tr>
						<td style="width: 200px;"><a
							href="show-application?id=${list.studentId}">${list.regNo}
						</a></td>
						<td>${list.studentName}</td>
						<td>${list.fatherName}</td>
						<td>${list.motherName}</td>
						<td>${list.className}</td>
						<td>${list.dateOfBirth}</td>
						<td>${list.phoneNo}</td>
						<td><a href="show-application?id=${list.studentId}" target="_blank">View</a></td>
						<td><a href="transfer-student?id=${list.studentId}">Transfer</a></td>
						<td><a href="cancel-registration?id=${list.studentId}">Cancel</a></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</div>