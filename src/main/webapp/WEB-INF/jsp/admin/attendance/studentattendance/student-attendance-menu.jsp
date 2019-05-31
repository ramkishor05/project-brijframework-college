<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<spring:url value="/style/datepicks" var="datepicks" />
<spring:url value="/js" var="js_url" />
<spring:url value="/" var="baseurl"></spring:url>
<spring:url value="/img" var="img_url" />
<spring:url value="/style" var="style_url" />
<spring:url value="/css" var="css_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/home.css">
<link rel="stylesheet" type="text/css" href="${css_url}/setting.css">
<link rel="stylesheet" type="text/css" href="${css_url}/admission.css">
<link href="${datepicks}/jquery.datepick.css" rel="stylesheet">
<script src="${datepicks}/jquery.plugin.js"></script>
<script src="${datepicks}/jquery.datepick.js"></script>
<link rel="stylesheet"
	href="${js_url}/fullcalendar/jquery-ui-1.10.4.custom.min.css">
<c:url value="/style/theme/images" var="imageurl" />
<div class="content">
	<div id="content-header" style="height: 150px;">
		<img alt="Show_settings"
			src="${img_url}/stuatt.png"
			style="width: 57px;">
		<h1>Student Attendance</h1>
		<h3>Register Student Attendance</h3>
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
	<br> <br>


	<div class="content">
		<div class="row-fluid" student-attendance-register>
			<div class="span4">
				<a href="take-attendance-home.html">
					<div class="block">
						<div class="head dblue">
							<div class="icon" style="margin-left: 77px;">
								<i class="ico-grid"></i>
							</div>
							<h2>Attendance Register</h2>
						</div>
						<div class="data dark">Attendance Register For Students</div>
					</div>
				</a>
			</div>
			<div class="span4">
				<a href="student-attendance-report">
					<div class="block" style="margin-left: 182px;">
						<div class="head dblue">
							<div class="icon" style="margin-left: 77px;">
								<i class="ico-grid"></i>
							</div>
							<h2>Attendance Report</h2>
						</div>
						<div class="data dark">Attendance Report For Students</div>
					</div>
				</a>
			</div>
		</div>
	</div>
</div>



