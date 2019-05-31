<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/style/datepicks" var="datepicks" />
<spring:url value="/img" var="img_url" />
<spring:url value="/css" var="css_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/admission.css">
<link href="${datepicks}/jquery.datepick.css" rel="stylesheet">
<script src="${datepicks}/jquery.plugin.js"></script>
<script src="${datepicks}/jquery.datepick.js"></script>
<spring:url value="/" var="base_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/setting.css">

<style>
#markstable
{
border-left: 1px solid transparent;
    border-top: none;
    border-bottom: none;
    border-right: 1px solid transparent;
background-color :gray;

}
</style>

<div class="content">
	<div id="content-header" style="height: 150px;">
		<img alt="Show_settings"
			src="${img_url}/employeeImages/viewmonthlyreportcard.png"
			style="width: 50px; margin-top: -12px;">
		<h1>View Monthly Exam Report</h1>
		<h3>View Monthly Exam Report for all months</h3>
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
	<div class="row-fluid">
		<div class="span12">
			<div class="block" style="top: 38px;" id="markstable">
				<div class="head blue">
					<div class="icon">
						<span class="ico-pen-2"></span>
					</div>
					<h2>View Monthly Report</h2>
				</div>
				<div class="data-fluid">
					<table width="100%" cellspacing="0" cellpadding="0" class="table table-bordered table-primary">
						<thead>
							<tr>
								<th>Subject Name</th>
								<c:forEach var="value" items="${map.MonthDTO}" varStatus="loop">
									<th><center>${value.monthName}</center>
										<div style="width: 100%; float: left;">
											<div style="width: 50%; float: left;">
												<center>Gain</center>
											</div>
											<div style="width: 49%; float: left;">
												<center>Max</center>
											</div>
										</div></th>
								</c:forEach>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="value" items="${map.SubjectDTO}" varStatus="loop">
								<tr>
									<td>${value.subjectName}</td>
									<c:forEach var="value1" items="${value.commonDTOs}"
										varStatus="loop">
										<td><div style="width: 100%; float: left;">
												<div style="width: 50%; float: left;">
												<c:if test="${value1.gainMarks==''}">
												<center>${value1.gainMarks}</center>
												</c:if>
													<c:if test="${value1.gainMarks!=''}">
												<center>${value1.gainMarks}</center>
												</c:if>
												
												</div>
												<div style="width: 49%; float: left;">
													<center>${value1.maxMarks}</center>
												</div>
											</div></td>
									</c:forEach>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>