<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/style" var="styleurl" />
<spring:url value="/css" var="css_url" />
<c:url value="/style/theme/images/back.png" var="backurl" />
<spring:url value="/img" var="img" />
<spring:url value="/img" var="img_url" />
<spring:url value="/js" var="js_url" />
<c:url value="/style/theme/images/" var="StudentDetailLogo" />
<link rel="stylesheet" type="text/css" href="${css_url}/admission.css">
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet" href="${js_url}/bootstrap/bootstrap.css">
<script src="${js_url}/bootstrap/jquery.js"></script>
<script src="${js_url}/bootstrap/bootstrap.js"></script>


<div class="content">
	<div class="panel panel-primary" style="width: 500px; float: left;">
		<div class="panel-heading">
			<h3 class="panel-title">Student Information</h3>
		</div>
		<div class="panel-body" style="margin-left: -20px;">
			<ul class="list-group">
				<li class="list-group-item">Roll No
					:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${studentDTO.rollno }</li>
				<li class="list-group-item">Class :
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${studentDTO.className }</li>
				<li class="list-group-item">Section :
					&nbsp;&nbsp;&nbsp;${studentDTO.sectionName }</li>
				<li class="list-group-item">Student :
					&nbsp;&nbsp;&nbsp;${studentDTO.firstName }</li>
				<li class="list-group-item">Father :
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${studentDTO.fatherName }</li>
			</ul>
		</div>

	</div>
	<div class="panel panel-success" style="width: 500px; float: right;">
		<div class="panel-heading">
			<h3 class="panel-title">Fee Submission Information</h3>
		</div>
		<div class="panel-body">
			<table class="table table-bordered">
				<thead>
					<tr>
						<th>Date</th>
						<th>Amount</th>
						<th>Month</th>
						<th>Operation</th>
					</tr>
				</thead>
				<tbody>

					<c:forEach var="list" items="${studentFeeDetails}" varStatus="loop">
						<tr>
							<fmt:parseDate var="date" value="${list.fromDate}"
								pattern="yyyy-MM-dd"></fmt:parseDate>
							<td><fmt:formatDate type="date" value="${date}"
									pattern="MMM dd, yyyy" /></td>

							<td>${list.paidAmount}</td>
							<td>${ list.month}</td>
							<td><a
								href="generatePDF.html?slipNo=${list.commonRecieptNo}&studentAdmissionNo=${list.studentAdmissionNo}&toDate='${list.toDate}&fromDate=${list.fromDate}&feeSubDetailId=${list.studentFeeSubmissionDetailsId}"><span
									class="label label-success">Receipt</span></a></td>
						</tr>
					</c:forEach>

				</tbody>
			</table>
		</div>
	</div>
	<div class="panel panel-info" style="width: 500px; float: right;">
		<div class="panel-heading">
			<h3 class="panel-title">Due Fees Information</h3>
		</div>
		<div class="panel-body">
			<table class="table table-bordered">
				<thead>
					<tr>
						<th>Admission No</th>
						<th>Balance Amount</th>
						<th>Mobile No</th>
					</tr>
				</thead>
				<tbody>


					<tr>
						<td>${admissionNo}</td>
						<td>${amount}</td>
						<td>${mobile}</td>
					</tr>


				</tbody>
			</table>
		</div>
	</div>
	<div class="panel panel-danger" style="width: 500px; float: right;">
		<div class="panel-heading">
			<h3 class="panel-title">Attendance Information</h3>
		</div>
		<div class="panel-body">
			<table class="table table-bordered">
				<thead>
					<tr>
						<th>Date</th>
						<th>Status</th>
					</tr>
				</thead>
				<tbody>

					<c:forEach var="list" items="${attendance}">
						<tr>
							<fmt:parseDate var="date" value="${list.attendanceDate}"
								pattern="yyyy-MM-dd"></fmt:parseDate>
							<td><fmt:formatDate type="date" value="${date}"
									pattern="MMM dd, yyyy" /></td>
							<td>${list.attendanceStatus}</td>

						</tr>
					</c:forEach>
				</tbody>
			</table>
			<ul class="nav nav-pills nav-stacked">
				<li class="active"><a href="#"> <span
						class="badge pull-right">${p}</span> Total Persent
				</a> <a href="#"> <span class="badge pull-right">${a}</span> Total
						Absent
				</a> <a href="#"> <span class="badge pull-right">${l}</span> Total
						Late
				</a></li>
			</ul>
		</div>
	</div>
</div>

