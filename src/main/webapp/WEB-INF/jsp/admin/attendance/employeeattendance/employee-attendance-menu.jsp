<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<spring:url value="/css" var="css_url" />
<spring:url value="/img" var="img_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/setting.css">
<c:url value="/style/theme/images" var="imageurl" />
<div class="content">
	<div id="content-header" style="height: 150px;">
		<img alt="Show_settings" src="${img_url}/empatt.jpg"
			style="width: 57px;">
		<h1>Employee Attendance</h1>
		<h3>Employee Attendance Menu</h3>
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
	<br>
	<div class="content">
		<div class="row-fluid">
			<div class="span4">
				<a href="employee-attendance-register">
					<div class="block">
						<div class="head dblue">
							<div class="icon" style="margin-left: 77px;">
								<i class="ico-grid"></i>
							</div>
							<h2>Attendance Register</h2>
						</div>
						<div class="data dark">Attendance Register For Employee</div>
					</div>
				</a>
			</div>
			<div class="span4">
				<a href="employee-attendance-report">
					<div class="block" style="margin-left: 182px;">
						<div class="head dblue">
							<div class="icon" style="margin-left: 77px;">
								<i class="ico-grid"></i>
							</div>
							<h2>Attendance Report</h2>
						</div>
						<div class="data dark">Attendance Report For Employee</div>
					</div>
				</a>
			</div>
		</div>
	</div>
</div>



