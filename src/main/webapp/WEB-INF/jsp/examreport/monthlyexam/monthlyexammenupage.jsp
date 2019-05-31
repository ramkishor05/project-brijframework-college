<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<spring:url value="/" var="baseurl"></spring:url>
<spring:url value="/img" var="img_url" />
<spring:url value="/style" var="style_url" />
<spring:url value="/css" var="css_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/home.css">
<link rel="stylesheet" type="text/css" href="${css_url}/setting.css">

<div class="content">
	<div id="content-header" style="height: 150px;">
		<img alt="Show_settings" src="${img_url}/employeeImages/viewmonthlyreportcard.png"
			style="width: 57px;">
		<h1>Exam Report Home</h1>
		<h3>Exam Report Home</h3>
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
	<c:if test="${! empty msg && msg!='0'}">
		<div class="alert alert-success"
			style="height: 30px; padding-top: 0px; padding-bottom: 0px;">
			<h5 align="center">
				<font color="red"><b>${msg}</b></font>
			</h5>
		</div>
	</c:if>
	<div id="user_options">


		<div class="button-box left-button" style="width: 190px;">
			<a href="assign-marks-to-student.html" class="option_buttons"
				id="admission_button"
				nicetitle="Enter students admission details into the school records."><div
					class="button-label">
					<img alt="" src="${img_url}/employeeImages/createmonthlyexamreport.png"
						style="margin-left: 40px; margin-top: -100px; height: 100px;">
					<p style="margin-left: 30px; margin-top: 10px;">Assign Marks</p>
				</div></a>
		</div>
		<div class="button-box">
			<a href="view-monthly-exam-report.html" class="option_buttons"
				id="student_details_button"
				nicetitle="Search for existing and former students."><div
					class="button-label">
					<img alt="" src="${img_url}/employeeImages/viewmonthlyreportcard.png"
						style="margin-left: -20px; margin-top: -100px; height: 100px;">
					<p style="border-top-width: 0px; margin-top: 10px;">View Report</p>
				</div></a>
		</div>
		<div class="button-box">
			<a href="viewmonthlysubjectmarks.html" class="option_buttons"
				id="student_details_button"
				nicetitle="Search for existing and former students."><div
					class="button-label">
					<img alt="" src="${img_url}/employeeImages/editmonthlyexammarks.png"
						style="margin-left: -20px; margin-top: -100px; height: 100px;">
					<p style="border-top-width: 0px; margin-top: 10px;">Edit Subject Marks </p>
				</div></a>
		</div>
		
	</div>
</div>
