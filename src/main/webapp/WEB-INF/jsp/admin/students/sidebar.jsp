<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<c:url value="/" var="base_url"></c:url>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/" var="baseurl" />
<div class="sidebar">

	<div class="top">
		<!-- <a class="logo" href="#"></a> -->
		<font size="4"><font color="sky blue"><b>School
					Management System</b></font></font>

	</div>
	<div class="nContainer">
		<ul class="navigation bordered">
			<sec:authorize access="isAuthenticated()">
				<li><a class="blgreen"><font size="5"><b>Setting</b></font></a></li>
				<li class="active"><a class="blblue" href="home">Dashboard</a></li>

				<li><a class="blgreen" href="managecourseandbatch">Manage
						Course/Batch</a></li>
				<li><a class="blgreen" href="studentcategories">Manage
						Student Category</a></li>
				<li><a class="blgreen" href="managesubject">Manage Subject</a></li>
				<li><a class="blgreen" href="configurationupdate">General
						Settings</a></li>
				<li><a class="blgreen" href="addadditionaldetails">Add
						Admission Additional Detail</a></li>
				<li><a class="blgreen" href="sms">SMS Module</a></li>



				<li><a class="blgreen" id="logout" href="${baseurl}logout">LOGOUT</a></li>

			</sec:authorize>

		</ul>
		<a class="close"> <span class="ico-remove"></span>
		</a>
	</div>
	<div class="widget">
		<div class="datepicker"></div>
	</div>

</div>
