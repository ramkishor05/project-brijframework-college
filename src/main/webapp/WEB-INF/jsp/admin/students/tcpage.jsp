<%-- <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%> --%>
	<%@ page language="java" contentType="application/pdf;" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<spring:url value="/" var="baseurl"></spring:url>
<spring:url value="/img/" var="img_url" />
<spring:url value="/style/datepicks" var="datepicks" />
<spring:url value="/css" var="css_url" />
<% response.setContentType("application/pdf"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<link rel="stylesheet" type="text/css" href="${css_url}/admission.css">
<link href="${datepicks}/jquery.datepick.css" rel="stylesheet">
<script src="${datepicks}/jquery.plugin.js"></script>
<script src="${datepicks}/jquery.datepick.js"></script>
<script>
	$(function() {
		$('.admissionDate').datepick({
			dateFormat : "yyyy-mm-dd"
		});
		$("#dateOfBirth").datepick({
			dateFormat : "yyyy-M-dd"
		});
	});
</script>
<style>
#text-class {
	margin-top: -14px;
	border-top-width: 0px;
	border-right-width: 0px;
	border-left-width: 0px;
	text-align: center;
	height: 20px;
}
</style>
<div class="content">
	<div class="page-header">
		<div class="icon">
			<span class="ico-ok"></span>
		</div>
		<h1>
			Validation <small>METRO STYLE ADMIN PANEL</small>
		</h1>
	</div>
	<div class="row-fluid">
		<div class="span12">
			<div class="block">
				<div class="data invoice">
					<div class="row-fluid">
						<div class="span2"></div>
						<div class="span8"
							style="border-left: 1px solid lightgray; border-right: 1px solid lightgray; border-top: 1px solid lightgray;">
							<div style="width: 100%; height: 90px;">
								<br> <img style="width: 90px; height: 90px; float: left;"
									src="${img_url}gargi logo.jpg">
								<div style="width: 73%; float: left; margin-top: 18px;">
									<label><center>
											<font size="5"><b><span>Gargi Public School</span></b></font><br>
											<font size="3">( Gargi Public School New Delhi )</font>
										</center> </label>
								</div>
								<img style="width: 90px; height: 90px; float: right;"
									src="${img_url}gargi logo.jpg">
							</div>
						</div>
						<div class="span2"></div>
					</div>
					<div class="row-fluid">
						<div class="span2"></div>
						<div class="span8"
							style="border-left: 1px solid lightgray; border-right: 1px solid lightgray;">
							<hr>
						</div>
						<div class="span2"></div>
					</div>
					<div class="row-fluid">
						<div class="span2"></div>
						<div class="span8"
							style="border-left: 1px solid lightgray; border-right: 1px solid lightgray;">
							<div style="width: 100%; float: left; margin-bottom: 18px;">
								<label><center>
										<font size="4"><b><span>Transfer Certificate
													Application</span></b></font><br> <font size="3">( Please Use
											Capital Letters )</font>
									</center> </label>
							</div>
							<div class="span8">
								<address>
									<strong>The Principal.</strong><br>Gargi Public School <br>
									Gaziabad Uttar Pardesh <br> <abbr title="Phone">P:</abbr>
									+38 (123) 456-7890
								</address>
							</div>
							<div class="span2">
								<address>
									<strong>Date:-${StudentDTO.currentDate}</strong>
								</address>
							</div>
						</div>
						<div class="span2"></div>
					</div>

					<div class="row-fluid">
						<div class="span2"></div>
						<div class="span8"
							style="border-left: 1px solid lightgray; border-right: 1px solid lightgray; border-bottom: 1px solid lightgray;">
							<div style="width: 95%; float: left; margin-bottom: 18px;">
								<strong style="margin-left: 18px;">Sir/Madam ,</strong>
							</div>
							<br>
							<div style="width: 95%; margin-left: 18px; float: left;">
								<p>
									I ,<input type="text" id="text-class"
										value="${StudentDTO.fatherName}" style="width: 243px;">Parent
									Of ,<input type="text" id="text-class"
										value="${StudentDTO.fullName}" style="width: 243px;">
									<br> (Student Name As in the Passport) Studying in Gargi
									public School in Year/class <input type="text" id="text-class"
										value="${StudentDTO.sessionDuration}/${StudentDTO.className}"
										style="width: 200px;"> div <input type="text"
										value="${StudentDTO.sectionName}" id="text-class"
										style="width: 243px;"> C R No. <input
										value="${StudentDTO.rollno}" type="text" id="text-class"
										style="width: 300px;"> request you to issue a Transfer
									Certificate with effect from<input type="text"
										style="width: 243px;" id="text-class"> to join another
									School(Name of School) <input type="text" id="text-class"
										style="width: 243px;"><!-- .<br> TC same emirates <input
										type="checkbox"> TC to Other Emirates <input
										type="checkbox">TC to Outside Emirates <input
										type="checkbox"> <br> --> Contact No:- Residence <input
										type="text" id="text-class" style="width: 200px;">
									Mobile <input type="text" id="text-class" style="width: 200px;">.
									<br> Note :- All the due as on today must be cleared and
									passport copy of student must be attached. <br> <br>Date:-
									<input value="${StudentDTO.currentDate}" type="text"
										id="text-class" style="width: 200px;"> Signature of
									Parent <input type="text" id="text-class" style="width: 200px;">.
									<br> <br> Teacher's Signature:- <input type="text"
										id="text-class" style="width: 200px;"> Last Date Of
									Attendance <input value="${StudentDTO.currentDate}" type="text"
										id="text-class" style="width: 200px;">.
								</p>
							</div>
							<br> <br>
							<div style="width: 95%; margin-left: 18px; float: left;">
								<div class="data-fluid">
									<table width="100%">
										<thead>
											<tr>
												<th style="border: 1px solid;">Dept.</th>
												<th style="border: 1px solid;">Principal</th>
												<th style="border: 1px solid;">Accounts</th>
												<th style="border: 1px solid;">Library</th>
												<th style="border: 1px solid;">Nurse</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td style="border: 1px solid; text-align: center;">Sign.</td>
												<td style="border: 1px solid;"></td>
												<td style="border: 1px solid;"></td>
												<td style="border: 1px solid;"></td>
												<td style="border: 1px solid;"></td>
											</tr>
										</tbody>
									</table>
								</div>
								<br> TC No:- <input type="text" id="text-class"
									style="width: 200px;">Date <input type="text" class="admissionDate"
									value="${StudentDTO.currentDate}" id="text-class"
									style="width: 200px;">. <br> <br> Receipt By
								: Name:- <input type="text" id="text-class"
									style="width: 200px;"> Signature &nbsp; <input
									type="text" id="text-class" style="width: 200px;">. <br>
								<br>
							</div>
						</div>
						<div class="span2"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<a href="getpdftc?studentId=1">PDF</a>
</div>
</html>