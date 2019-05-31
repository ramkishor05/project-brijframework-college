<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
		<img alt="Show_settings" src="${img_url}/fee_manage.jpg"
			style="width: 57px;">
		<h1>Home</h1>
		<h3>School Management Dashboard</h3>
		<div id="app-back-button">
			<a href="home"><img alt="Back" border="0"
				src="${img_url}/home.png" title="Home"
				style="margin-top: -6px; height: 40px; width: 40px;"></a> <a
				href="#" onclick="javascript:location.reload(true);"><img
				alt="Back" border="0" src="${img_url}/refresh.png" title="Refresh"
				style="margin-top: -6px; height: 40px; width: 40px;"></a> <a
				href="#" onclick="history.back(); return false;"><img alt="Back"
				border="0" src="${img_url}/back.png" title="Back"
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
	
	<marquee><font color="green"><b>Current Session is ${current.sessionDuration}</b></font></marquee>
	<div id="user_options">
		<div class="button-box left-button" style="width: 190px;">
			<a href="students-manage" class="option_buttons"
				id="admission_button"
				nicetitle="Enter students admission details into the school records."><div
					class="button-label">
					<img alt="" src="${img_url}/admission3.jpg"
						style="margin-left: 40px; margin-top: -100px; height: 100px;">
					<p style="margin-left: 30px; margin-top: 10px;">STUDENTS</p>
				</div></a>
		</div>

	<div class="button-box">
			<a href="employee" class="option_buttons" id="student_details_button"
				nicetitle="Search for existing and former students."><div
					class="button-label">
					<img alt="" src="${img_url}/employeeImages/EmployeeIcon.png"
						style="margin-left: -20px; margin-top: -100px; height: 100px;">
					<p style="border-top-width: 0px; margin-top: 10px;">STAFF</p>
				</div></a>
		</div>

		<div class="button-box">
			<a href="fees-menu" class="option_buttons"
				id="student_details_button"
				nicetitle="Search for existing and former students."><div
					class="button-label">
					<img alt="" src="${img_url}/sfees.jpg"
						style="margin-left: -20px; margin-top: -100px; height: 100px;">
					<p style="border-top-width: 0px; margin-top: 10px;">FEES</p>
				</div></a>
		</div>


		<div class="button-box left-button">
			<a href="fee-slip-search.html" class="option_buttons"
				id="manage_news_button"
				nicetitle="View or publish latest school news and announcements"><div
					class="button-label">
					<img alt="" src="${img_url}/fee_slip.jpg"
						style="margin-left: -20px; margin-top: -100px; height: 100px;">
					<p style="border-top-width: 0px; margin-top: 10px;">SEARCH</p>
				</div></a>
		</div>



		<div class="button-box">
			<a href="uniform-menu" class="option_buttons" id="examinations_button"
				nicetitle="Manage Dress"><div class="button-label">
					<img alt="" src="${img_url}/unif.jpg"
						style="margin-left: -20px; margin-top: -100px; height: 100px;">
					<p style="border-top-width: 0px; margin-top: 10px;">UNIFORM</p>
				</div></a>
		</div>


		<div class="button-box">
			<a href="manage-notice.html" class="option_buttons"
				id="examinations_button" nicetitle="Manage Dress"><div
					class="button-label">
					<img alt="" src="${img_url}/notice1.jpg"
						style="margin-left: -20px; margin-top: -100px; height: 100px;">
					<p style="border-top-width: 0px; margin-top: 10px;">NOTICE</p>
				</div></a>
		</div>


		 <div class="button-box">
			<a href="book-menu" class="option_buttons" id="examinations_button"
				nicetitle="Manage Examinations"><div class="button-label">
					<img alt="" src="${img_url}/book3.jpg"
						style="margin-left: -20px; margin-top: -100px; height: 100px;">
					<p style="border-top-width: 0px; margin-top: 10px;">BOOK</p>
				</div></a>
		</div>  
		 <div class="button-box">
			<a href="create-holidays.html" class="option_buttons"
				id="examinations_button" nicetitle="Manage Examinations"><div
					class="button-label">
					<img alt="" src="${img_url}/createweekdays.png"
						style="margin-left: -20px; margin-top: -100px; height: 100px;width: 83px;">
					<p style="border-top-width: 0px; margin-top: 10px;">Create Holidays</p>
				</div></a>
		</div> 
		<div class="button-box">
			<a href="visitor.html" class="option_buttons"
				id="examinations_button" nicetitle="Manage Examinations"><div
					class="button-label">
					<img alt="" src="${img_url}/visitors.png"
						style="margin-left: -20px; margin-top: -100px; height: 100px;width: 83px;">
					<!-- <p style="border-top-width: 0px; margin-top: 10px;">Create Holidays</p> -->
				</div></a>
		</div> 
	</div>	
