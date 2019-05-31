<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<spring:url value="/" var="baseurl"></spring:url>
<spring:url value="/img" var="img_url" />
<spring:url value="/style" var="style_url" />
<spring:url value="/css" var="css_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/setting.css">
<div id="content_wrapper">
	<div id="side_bar">

		<div id="sidebar_news_area"></div>
	</div>
	<div id="content">

		<div id="content-header">
			<img alt="Show_settings" src="${img_url}/class.jpg"
				style="width: 74px;">
			<h1>Students Section</h1>
			<h3>Student Admission and Profile</h3>
			<div id="app-back-button">
				<a href="home"><img alt="Back" border="0"
					src="${img_url}/home.png"
					style="margin-top: -6px; height: 40px; width: 40px;"></a> <a
					href="#" onclick="javascript:location.reload(true);"><img
					alt="Back" border="0" src="${img_url}/refresh.png"
					style="margin-top: -6px; height: 40px; width: 40px;"></a> <a
					href="#" onclick="history.back(); return false;"><img
					alt="Back" border="0" src="${img_url}/back.png"
					style="margin-top: -6px; height: 40px; width: 40px;"></a>
			</div>
		</div>

		<div id="page-yield">
			<div id="box">
				<div class="link-box">
					<div class="link-heading">
						<a href="studentsadmission">Students Admission</a>
					</div>
					<div class="link-descr">Register Student's Details for
						Admission</div>
				</div>
				<div class="link-box">
					<div class="link-heading">
						<a href="student-attendance-menu">Students Attendance</a>
					</div>
					<div class="link-descr">Students Attendance Register And
						Report</div>
				</div>
				<div class="link-box">
					<div class="link-heading">
						<a href="student-details">Search Students and Manage Profiles</a>
					</div>
					<div class="link-descr">Search Students,edit details and
						cancel admission.</div>
				</div>

				<div class="link-box">
					<div class="link-heading">
						<a href="exam-report-menu.html">Students Exam Report</a>
					</div>
					<div class="link-descr">Create,View,Generate Exam Report</div>
				</div>
				<div class="link-box">
					<div class="link-heading">
						<a href="cancelled-students">View Cancelled Students</a>
					</div>
					<div class="link-descr">View List of students whose admission
						is cancelled.</div>
				</div>
				<div class="link-box">
					<div class="link-heading">
						<a href="student-login-details">View Login Details</a>
					</div>
					<div class="link-descr">View Students Username and Password</div>
				</div>
				<div class="link-box">
					<div class="link-heading">
						<a href="gatepass-menu">Gate Pass</a>
					</div>
					<div class="link-descr">Gate Pass Details</div>
				</div>
				<div class="link-box">
					<div class="link-heading">
						<a href="batch-promote.html">Batch Promotion</a>
					</div>
					<div class="link-descr">Promote Student To Higher Class</div>
				</div>
			 <div class="link-box">
					<div class="link-heading">
						<a href="application-form.html">Application Form</a>
					</div>
					<div class="link-descr">Fill Application form for admission</div>
				</div>
				<div class="link-box">
					<div class="link-heading">
						<a href="application-details.html">Application Details</a>
					</div>
					<div class="link-descr">Application Details</div>
				</div> 
				<div class="link-box">
					<div class="link-heading">
						<a href="characterCertificate.html">Character Certificate</a>
					</div>
					<div class="link-descr">Student Character Certificate</div>
				</div>
			</div>


		</div>
	</div>

	<div class="extender"></div>
</div>

