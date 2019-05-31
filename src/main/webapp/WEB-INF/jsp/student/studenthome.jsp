<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<spring:url value="/" var="baseurl"></spring:url>
<spring:url value="/img" var="img_url" />
<spring:url value="/style" var="style_url" />
<spring:url value="/css" var="css_url" />
<spring:url value="/admin/" var="adminurl" />
<link rel="stylesheet" type="text/css" href="${css_url}/home.css">
<link rel="stylesheet" type="text/css" href="${css_url}/setting.css">

<div class="content">
	<div id="content-header" style="height: 150px;">
		<img alt="Show_settings" src="${img_url}/student.jpg"
			style="width: 57px;">
		<h1>Home</h1>
		<h3>Student Dashboard</h3>
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

	<div id="user_options">
		<div class="button-box">
			<a href="student-profile" class="option_buttons"
				id="student_details_button" nicetitle="See your profile"><div
					class="button-label">
					<img alt="" src="${img_url}/student_profile.jpg"
						style="margin-left: -20px; margin-top: -100px; height: 100px;">
					<p style="border-top-width: 0px; margin-top: 10px;">Profile</p>
				</div></a>
		</div>

		<div class="button-box">
			<a href="attendancestu-report.html" class="option_buttons"
				id="manage_news_button" nicetitle="Attendance Report"><div
					class="button-label">
					<img alt="" src="${img_url}/attendance1.jpg"
						style="margin-left: -20px; margin-top: -100px; height: 100px;">
					<p style="border-top-width: 0px; margin-top: 10px;">Attendance Report
						</p>
				</div></a>

		</div>
	<div class="button-box">
			<a href="my-monthly-exam-report.html" class="option_buttons"
				id="student_details_button"
				nicetitle="Search for existing and former students."><div
					class="button-label">
					<img alt="" src="${img_url}/employeeImages/viewmonthlyreportcard.png"
						style="margin-left: -20px; margin-top: -100px; height: 100px;">
					<p style="border-top-width: 0px; margin-top: 10px;">Monthly Test Report</p>
				</div></a>
		</div>
		
	<div class="button-box">
			<a href="view-my-report-cards.html" class="option_buttons"
				nicetitle="Search for existing and former students."><div
					class="button-label">
					<img alt="" src="${img_url}/employeeImages/viewreportcard.png"
						style="margin-left: -20px; margin-top: -100px; height: 100px;">
					<p style="border-top-width: 0px; margin-top: 10px;">View Report
						Card</p>
				</div></a>
		</div>

	</div>