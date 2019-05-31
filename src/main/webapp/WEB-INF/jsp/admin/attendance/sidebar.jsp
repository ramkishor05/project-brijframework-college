<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<c:url value="/" var="base_url"></c:url>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/" var="baseurl" />
<div class="sidebar">

	<div class="top">


		<font size="4"><font color="sky blue"><b>School
					Management System</b></font></font>

	</div>
	<div class="nContainer">
		<sec:authorize access="isAuthenticated()">
			<ul class="navigation bordered">
				<li><a class="blgreen"><font size="5"><b>Attendance</b></font></a></li>
				<li class="active"><a class="blblue" href="home">Dashboard</a></li>





				<!--  <li class="active">
			<a class="blgreen" href="attendancemenu">Attendance</a>
			 <div class="open"></div>
                    <ul> -->
				<li><a class="bldblue" href="attendanceregister">Attendance
						Register</a></li>

				<li><a class="bldblue" href="attendancereport">Attendance
						Report</a></li>
				<!--  </ul>
                </li> -->

				<li><a class="blgreen" id="logout" href="${baseurl}logout">LOGOUT</a></li>


			</ul>
		</sec:authorize>
		<a class="close"> <span class="ico-remove"></span>
		</a>
	</div>
	<div class="widget">
		<div class="datepicker"></div>
	</div>

</div>
