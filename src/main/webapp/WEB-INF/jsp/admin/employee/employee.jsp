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
		<img alt="Show_settings"
			src="${img_url}//employeeImages/EmployeeIcon.png"
			style="width: 57px;">
		<h1>Staff Section</h1>
		<h3>Staff Menu</h3>
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
	<div id="page-yield">
		<div id="box">
			<div class="link-box">
				<div class="link-heading">
					<a href="employee-registration">Staff Registration</a>
				</div>
				<div class="link-descr">Register Staff's Details</div>
			</div>
		</div>
		<div id="box">
			<div class="link-box">
				<div class="link-heading">
					<a href="employee-attendance-menu">Staff Attendance</a>
				</div>
				<div class="link-descr">Staff Attendance Register And Report</div>
			</div>
		</div>
		<div id="box">
			<div class="link-box">
				<div class="link-heading">
					<a href="employee-details">Staff Details</a>
				</div>
				<div class="link-descr">Staff Edit,Update & Password Change</div>
			</div>
		</div>
		<div id="box">
			<div class="link-box">
				<div class="link-heading">
					<a href="classes-assign">Class Assign</a>
				</div>
				<div class="link-descr">Assign Classes To Teacher</div>
			</div>
		</div>
		<div id="box">
			<div class="link-box">
				<div class="link-heading">
					<a href="salary-menu">Employee Salary</a>
				</div>
				<div class="link-descr">Employee Salary</div>
			</div>
		</div>
			
	</div>
</div>