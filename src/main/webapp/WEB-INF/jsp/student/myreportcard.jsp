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
border : 1px solid gray;
background-color :red;
margin-top: 36px;
}
</style>
<div class="content">
	<div id="content-header" style="height: 150px;">
		<img alt="Show_settings"
			src="${img_url}/employeeImages/viewreportcard.png"
			style="width: 50px; margin-top: -12px;">
		<h1>View Final Exam Result</h1>
		<h3>View Final Exam Report Card</h3>
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
		<div class="span12" id="markstable">
	<div style="width: 100%; height: 50px; padding-top: 15px;">
		<div style="width: 50%; float: left; text-align: center;">Half
			Yearly Exam</div>
		<div style="width: 50%; float: right; text-align: center">&nbsp&nbsp&nbsp&nbsp
			Annual Yearly Exam</div>
		<div class="block" style="width: 90%; margin-left: 50px">
			<div class="data-fluid">
				<table width="100%" cellspacing="0" cellpadding="0" class="table table-bordered table-primary">
					<thead>
						<tr>
							<th>S.No</th>
							<th>Subject</th>
							<th>U.T+ORAL+Project</th>
							<th>Exam</th>
							<th>Total</th>
							<th>U.T+ORAL+Project</th>
							<th>Exam</th>
							<th>Total</th>
							<th>Grand Total</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="value" items="${map.SubjectDTOs}" varStatus="loop">
							<tr>
								<td>${loop.count}</td>
								<td>${value.subjectName}</td>
								<td>${value.halfYearlyTU}</td>
								<td>${value.halfYearlyExam}</td>
								<td>${value.halfYearlyTotal}</td>
								<td>${value.annualYearlyTU}</td>
								<td>${value.annualYearlyExam}</td>
								<td>${value.annualYearlyTotal}</td>
								<td>${value.grandTotal}</td>
							</tr>
						</c:forEach>
						<tr>
							<td style="border-top: 1px solid; border-bottom: 1px solid">=></td>
							<td style="border-top: 1px solid; border-bottom: 1px solid">Total</td>
							<td style="border-top: 1px solid; border-bottom: 1px solid"></td>
							<td style="border-top: 1px solid; border-bottom: 1px solid"></td>
							<td style="border-top: 1px solid; border-bottom: 1px solid">${map.halfYearlyTotal}
							</td>
							<td style="border-top: 1px solid; border-bottom: 1px solid"></td>
							<td style="border-top: 1px solid; border-bottom: 1px solid"></td>
							<td style="border-top: 1px solid; border-bottom: 1px solid">
								${map.annuallyTotal}</td>
							<td style="border-top: 1px solid; border-bottom: 1px solid">'
								${map.grandTotal}</td>
						</tr>
						<tr>
							<td>*</td>
							<td>% of marks obtained</td>
							<td></td>
							<td></td>
							<td>${map.halfYearGainPercenatge}</td>
							<td></td>
							<td></td>
							<td>${map.annuallyGainPercentage}</td>
							<td>${map.grandGainPercentage}</td>
						</tr>
						<tr>
							<td>*</td>
							<td>Highest % in Class</td>
							<td></td>
							<td></td>
							<td>${map.halfYearlyMaxGainPercentage}</td>
							<td></td>
							<td></td>
							<td>${map.annuallyMaxGainPercentage}</td>
							<td>${map.grandMaxGainPercentage}</td>
						</tr>
						<tr>
							<td>*</td>
							<td>Rank</td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td>*</td>
							<td>Attendance in %</td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td>*</td>
							<td>Uniform & Performance</td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td>*</td>
							<td>Sign. of class teacher</td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td>*</td>
							<td>Sign. of principal</td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td>*</td>
							<td>Sign. of parents</td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
					</tbody>
				</table>
			</div>
</div>
</div>
</div>
</div>

		</div>