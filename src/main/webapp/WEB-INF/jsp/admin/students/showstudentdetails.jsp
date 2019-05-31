<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/style" var="styleurl" />
<spring:url value="/css" var="css_url" />
<c:url value="/style/theme/images/back.png" var="backurl" />
<spring:url value="/img" var="img" />
<spring:url value="/img" var="img_url" />
<c:url value="/style/theme/images/" var="StudentDetailLogo" />
<link rel="stylesheet" type="text/css" href="${css_url}/admission.css">
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>


<div class="content">
	<div id="content-header" style="height: 150px;">
		<img alt="Show_settings" src="${img_url}/student_profile.jpg"
			style="width: 74px; margin-top: -15px;">
		<h1>Student Profile</h1>
		<h3>View Student Profile Details</h3>
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
</div>

<%-- <div id="attend"
				style="margin-top: 27px; margin-left: -4px; margin-right: 87px; float: right;">
				<a
					href="generate-tc.html?id=${StudentDetailsBean.admissionNo}"><span
					class="label label-primary"><font size="2"><b>Generate TC</b></font></span></a>
			</div> --%>
<div class="row-fluid" style="width: 969px;">
	<div class="span12">
		<a href="student-profile.html?id=${StudentDetailsBean.admissionNo}"
			target="_blank"><img src="${img}/pdf.png"
			style="float: right; margin-top: 23px; margin-left: -10px; margin-right: 76px;"></a>
		<%-- <a class="btn"
			href="registrationPDF?studentId=${StudentDetailsBean.studentId}"
			target="_blank" style="float: right;">Rgistration PDF</a> --%>
	</div>
	<div class="span6"
		style="margin-top: 84px; height: 141px; margin-left: 0px; width: 383px;">

		<div class="block">

			<div class="data-fluid">
				<div class="row-form" style="float: right;">
					<div class="span3"></div>
					<div class="span9" style="float: right;">

						<div class="span3" style="width: 138px; height: 137px;">
							<img src="${img}/studentImages/${StudentDetailsBean.imageName}"
								style="width: 127px; height: 124px;">
						</div>
					</div>
				</div>

			</div>

		</div>

	</div>

	<div class="span6" style="margin-top: 80px; height: 137px;">

		<div class="block">

			<div class="data-fluid">
				<div class="row-form" style="height: 23px;">
					<div class="span3">
						<h5>Name :</h5>
					</div>
					<div class="span9">
						<div class="span3" style="width: 151px; height: 35px;">
							<h5>${StudentDetailsBean.firstName}
								${StudentDetailsBean.middleName} ${StudentDetailsBean.lastName}</h5>
						</div>
					</div>
				</div>

				<div class="row-form" style="height: 23px;">
					<div class="span3">
						<h5>Class :</h5>
					</div>
					<div class="span9">
						<div class="span3" style="width: 151px; height: 35px;">
							<h5>${StudentDetailsBean.className}</h5>
						</div>
					</div>
				</div>
				<div class="row-form" style="height: 23px;">
					<div class="span3">
						<h5>Section :</h5>
					</div>
					<div class="span9">
						<div class="span3" style="width: 151px; height: 35px;">
							<h5>${StudentDetailsBean.sectionName}</h5>
						</div>
					</div>
				</div>

			</div>

		</div>

	</div>

</div>
<div class="row-fluid"
	style="height: 623px; margin-left: 220px; width: 635px;">
	<div class="span12">
		<div class="accordion ui-accordion ui-widget ui-helper-reset"
			role="tablist">
			<h3
				class="ui-accordion-header ui-helper-reset ui-state-default ui-accordion-icons ui-corner-all"
				role="tab" id="ui-accordion-1-header-0"
				aria-controls="ui-accordion-1-panel-0" aria-selected="false"
				tabindex="-1">
				<span class="ui-accordion-header-icon ui-icon ui-icon-triangle-1-e"></span>Institutional
				Info
			</h3>
			<div
				class="ui-accordion-content ui-helper-reset ui-widget-content ui-corner-bottom"
				style="display: none;" id="ui-accordion-1-panel-0"
				aria-labelledby="ui-accordion-1-header-0" role="tabpanel"
				aria-expanded="false" aria-hidden="true">
				<div class="data-fluid">

					<div class="row-form">
						<div class="span5">Admission No:</div>
						<div class="span1">:</div>
						<div class="span2">
							<div class="span3">${StudentDetailsBean.admissionNo}</div>
						</div>
					</div>
					<div class="row-form">
						<div class="span5">Student Id:</div>
						<div class="span1">:</div>
						<div class="span2">
							<div class="span3">${StudentDetailsBean.studentId}</div>
						</div>
					</div>
					<div class="row-form" style="margin-bottom: -20px;">
						<div class="span5">Admission Date</div>
						<div class="span1">:</div>
						<div class="span2">
							<div class="span3">${StudentDetailsBean.admissionDate}</div>
						</div>
					</div>
					<div class="row-form" style="margin-bottom: -20px;">
						<div class="span5">Session</div>
						<div class="span1">:</div>
						<div class="span2">
							<div class="span3">${StudentDetailsBean.sessionDuration}</div>
						</div>
					</div>
						<div class="row-form">
						<div class="span5">SR No:</div>
						<div class="span1">:</div>
						<div class="span2">
							<div class="span3">${StudentDetailsBean.srno}</div>
						</div>
					</div>
					<div class="row-form">
						<div class="span5">Roll No:</div>
						<div class="span1">:</div>
						<div class="span2">
							<div class="span3">${StudentDetailsBean.rollno}</div>
						</div>
					</div>
					<div class="row-form" style="margin-bottom: -20px;">
						<div class="span5">LF No</div>
						<div class="span1">:</div>
						<div class="span2">
							<div class="span3">${StudentDetailsBean.lfno}</div>
						</div>
					</div>



				</div>
			</div>

			<h3
				class="ui-accordion-header ui-helper-reset ui-state-default ui-accordion-icons ui-corner-all"
				role="tab" id="ui-accordion-1-header-1"
				aria-controls="ui-accordion-1-panel-1" aria-selected="false"
				tabindex="-1">
				<span class="ui-accordion-header-icon ui-icon ui-icon-triangle-1-e"></span>Personal
				Info
			</h3>
			<div
				class="ui-accordion-content ui-helper-reset ui-widget-content ui-corner-bottom"
				style="display: none;" id="ui-accordion-1-panel-1"
				aria-labelledby="ui-accordion-1-header-1" role="tabpanel"
				aria-expanded="false" aria-hidden="true">
				<div class="head"></div>
				<div class="data-fluid">
					<div class="row-form" style="margin-bottom: -20px;">
						<div class="span5">Father Name</div>
						<div class="span1">:</div>
						<div class="span2">
							<div class="span9" style="width: 246px;">${StudentDetailsBean.fatherName}</div>
						</div>
					</div>
					<div class="row-form" style="margin-bottom: -20px;">
						<div class="span5">Mother Name</div>
						<div class="span1">:</div>
						<div class="span2">
							<div class="span9" style="width: 246px;">${StudentDetailsBean.motherName}</div>
						</div>
					</div>
					<div class="row-form" style="margin-bottom: -20px;">
						<div class="span5">Guardian Name</div>
						<div class="span1">:</div>
						<div class="span2">
							<div class="span9" style="width: 246px;">${StudentDetailsBean.guardianName}</div>
						</div>
					</div>
					<div class="row-form" style="margin-bottom: -20px;">
						<div class="span5">Date Of Birth</div>
						<div class="span1">:</div>
						<div class="span2">
							<div class="span9">${StudentDetailsBean.dateOfBirth}</div>
						</div>
					</div>

					<div class="row-form" style="margin-bottom: -20px;">
						<div class="span5">Gender</div>
						<div class="span1">:</div>
						<div class="span2">
							<div class="span9">${StudentDetailsBean.gender}</div>
						</div>
					</div>


					<div class="row-form" style="margin-bottom: -20px;">
						<div class="span5">Physically Challenged:</div>
						<div class="span1">:</div>
						<div class="span2">
							<div class="span9">${StudentDetailsBean.physicallyChallenged}</div>
						</div>
					</div>
				</div>
			</div>

			<h3
				class="ui-accordion-header ui-helper-reset ui-state-default ui-accordion-icons ui-corner-all"
				role="tab" id="ui-accordion-1-header-2"
				aria-controls="ui-accordion-1-panel-2" aria-selected="false"
				tabindex="-1">
				<span class="ui-accordion-header-icon ui-icon ui-icon-triangle-1-e"></span>Contact
				Details
			</h3>
			<div
				class="ui-accordion-content ui-helper-reset ui-widget-content ui-corner-bottom"
				style="display: none;" id="ui-accordion-1-panel-2"
				aria-labelledby="ui-accordion-1-header-2" role="tabpanel"
				aria-expanded="false" aria-hidden="true">




				<div class="row-form" style="margin-bottom: -20px;">
					<div class="span3">Address</div>
					<div class="span1">:</div>
					<div class="span2">
						<div class="span9" style="width: 246px;">${StudentDetailsBean.addressLine1}</div>

					</div>
				</div>
				<div class="row-form" style="margin-bottom: -20px;">
					<div class="span3">City</div>
					<div class="span1">:</div>
					<div class="span2">
						<div class="span9">${StudentDetailsBean.city}</div>
					</div>
				</div>
				<div class="row-form" style="margin-bottom: -20px;">
					<div class="span3">State</div>
					<div class="span1">:</div>
					<div class="span2">
						<div class="span9" style="width: 273px;">${StudentDetailsBean.state}</div>
					</div>
				</div>
				<div class="row-form">
					<div class="span3">Pincode:</div>
					<div class="span1">:</div>
					<div class="span2">
						<div class="span3">${StudentDetailsBean.pinCode}</div>
					</div>
				</div>

				<div class="row-form">
					<div class="span3">Country</div>
					<div class="span1">:</div>
					<div class="span2">
						<div class="span9">${StudentDetailsBean.country}</div>
					</div>
				</div>
				<div class="row-form">
					<div class="span3">Phone</div>
					<div class="span1">:</div>
					<div class="span2">
						<div class="span9">${StudentDetailsBean.phone}</div>
					</div>
				</div>
				<div class="row-form" style="margin-bottom: -20px;">
					<div class="span3">Mobile</div>
					<div class="span1">:</div>
					<div class="span2">
						<div class="span9">${StudentDetailsBean.mobile}</div>
					</div>
				</div>

				<div class="row-form" style="margin-bottom: -20px;">
					<div class="span3">E-Mail</div>
					<div class="span1">:</div>
					<div class="span2">
						<div class="span9" style="width: 246px;">${StudentDetailsBean.email}</div>
					</div>
				</div>
			</div>
			<h3
				class="ui-accordion-header ui-helper-reset ui-state-default ui-accordion-icons ui-corner-all"
				role="tab" id="ui-accordion-1-header-0"
				aria-controls="ui-accordion-1-panel-0" aria-selected="false"
				tabindex="-1">
				<span class="ui-accordion-header-icon ui-icon ui-icon-triangle-1-e"></span>Previous
				School Info
			</h3>
			<div
				class="ui-accordion-content ui-helper-reset ui-widget-content ui-corner-bottom"
				style="display: none;" id="ui-accordion-1-panel-0"
				aria-labelledby="ui-accordion-1-header-0" role="tabpanel"
				aria-expanded="false" aria-hidden="true">
				<div class="data-fluid">


					<div class="row-form">
						<div class="span5">School Name:</div>
						<div class="span1">:</div>
						<div class="span2">
							<div class="span3">${StudentDetailsBean.schoolName}</div>
						</div>
					</div>
					<div class="row-form" style="margin-bottom: -20px;">
						<div class="span5">Address</div>
						<div class="span1">:</div>
						<div class="span2">
							<div class="span3">${StudentDetailsBean.schoolAddress}</div>
						</div>
					</div>
					<div class="row-form" style="margin-bottom: -20px;">
						<div class="span5">Phone</div>
						<div class="span1">:</div>
						<div class="span2">
							<div class="span3">${StudentDetailsBean.schoolPhone}</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<div 
	class="row-fluid" style="width: 600px; margin-top: -146px; margin-left: 198px;">
	<div class="span12"
		style="margin-top: 84px; height: 141px; margin-left: 0px; width: 200px;">

		<div class="block">

			<div class="data-fluid">
				<div class="row-form" style="float: right;">
					<div class="span3"></div>
					<div class="span9" style="float: right;">

						<div class="span3" style="width: 138px; height: 137px;">
							<img style="width: 143px; height: 124px;"
								src="${img}/parentImages/${StudentDetailsBean.photo1name}">Father
						</div>
					</div>
				</div>

			</div>

		</div>

	</div>

	<div class="span12"
		style="margin-top: 84px; height: 141px; margin-left: 0px; width: 200px;">

		<div class="block">

			<div class="data-fluid" style="width: 184px; margin-left: 25px;">
				<div class="row-form" style="float: right;">
					<div class="span3"></div>
					<div class="span9" style="float: right;">

						<div class="span3" style="width: 138px; height: 137px;">
							<img src="${img}/parentImages/${StudentDetailsBean.photo2name}"
								style="width: 143px; height: 124px;">Mother
						</div>
					</div>
				</div>

			</div>

		</div>

	</div>
	<div class="span12"
		style="margin-top: 84px; height: 141px; margin-left: 0px; width: 200px;">

		<div class="block">

			<div class="data-fluid">
				<div class="row-form" style="float: right;">
					<div class="span3"></div>
					<div class="span9" style="float: right;">

						<div class="span3" style="width: 138px; height: 137px;">
							<img src="${img}/parentImages/${StudentDetailsBean.photo3name}"
								style="width: 143px; height: 124px;">Guardian
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="row-fluid" style="margin-top: 31px;">
		<div>
			<table style="width: 897px;">

				<c:forEach var="list" items="${documentList}" varStatus="loop">
					<tr>
						<c:if test="${list.studentDocumentId!=0}">
							<td>
								<div class="data-fluid">
									<div class="row-form">
										<div class="span3"></div>
										<div class="span9">

											<div class="span3" style="width: 138px; height: 137px;">
												<img src="${img}/document.jpg"
													style="width: 143px; height: 124px;">
											</div>
										</div>
									</div>
								</div>

							</td>
							<td>${list.documentName}</td>
							<td><a href="document-download?id=${list.fileName}"><span
									class="label label-success">Download</span></a></td>

						</c:if>
					</tr>

				</c:forEach>




			</table>
		</div>
	</div>
</div>
