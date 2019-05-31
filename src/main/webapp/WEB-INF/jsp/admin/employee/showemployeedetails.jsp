<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/" var="baseurl"></spring:url>
<spring:url value="/img" var="img_url" />
<spring:url value="/style" var="style_url" />
<spring:url value="/css" var="css_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/home.css">
<link rel="stylesheet" type="text/css" href="${css_url}/setting.css">


<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<script type="text/javascript">
	function show(wardId) {
		document.location.href = "guardians?WardId=" + wardId;
	}
</script>
<body id="body">
	<div class="content">
		<div id="content-header" style="height: 150px;">
			<img alt="Show_settings"
				src="${img_url}/employeeImages/EmployeeDetails.png"
				style="width: 57px;">
			<h1>Employee Details</h1>
			<h3>View Employee Details</h3>
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
			<div id="attend"
				style="margin-top: 27px; margin-left: -4px; margin-right: 87px; float: right;">
				<a
					href="perticular-emp-attendance.html?id=${EmployeeDetailsBean.id}"><span
					class="label label-primary"><font size="2"><b>Attendance</b></font></span></a>
				<a href="change-emp-password-page?id=${EmployeeDetailsBean.id}"><span
					class="label label-primary"><font size="2"><b>Change
								Password</b></font></span></a> <a
					href="edit-employee-details?id=${EmployeeDetailsBean.id}"><span
					class="label label-primary"><font size="2"><b>Edit</b></font></span></a>
			</div>
		</div>
		<div class="row-fluid"
			style="unicode-bidi: 803px; margin-top: 0px; margin-left: 0px;">

			<div class="span6"
				style="margin-top: 84px; height: 141px; margin-left: 0px; width: 383px;">

				<div class="block">

					<div class="data-fluid">
						<div class="row-form" style="float: right;">
							<div class="span3"></div>
							<div class="span9" style="float: right;">

								<div class="span3" style="width: 138px; height: 137px;">
									<img
										src="${style_url}/employeeImages/${EmployeeDetailsBean.imagename}"
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
									<h5>${EmployeeDetailsBean.firstName}
										${EmployeeDetailsBean.lastName}</h5>
								</div>
							</div>
						</div>
						<!-- 	<div class="row-form" style="height: 23px;">
							<div class="span3">
								<h5>Department :</h5>
							</div>
						
						</div> -->
						<div class="row-form" style="height: 23px;">
							<div class="span3">
								<h5>Joining Date :</h5>
							</div>
							<div class="span9">
								<div class="span3" style="width: 151px; height: 35px;">
									<h5>${EmployeeDetailsBean.joiningDate}</h5>
								</div>
							</div>
						</div>

						<c:choose>
							<c:when test="${assigned==null}">

								<div class="row-form" style="height: 23px;">
									<div class="span3" style="width: 119px;">
										<h5>Assigned Class :</h5>
									</div>
									<div class="span9">
										<div class="span3" style="width: 151px; height: 35px;">
											<h5
												style="margin-top: -30px; margin-left: 112px; width: 154px;">None</h5>
											<div style="margin-top: -33px; margin-left: 208px;">
												<a href="classes-assign"><span
													class="label label-success">Assign</span></a>
											</div>
										</div>
									</div>
								</div>

							</c:when>
							<c:otherwise>

								<div class="row-form" style="height: 23px;">
									<div class="span3" style="width: 119px;">
										<h5>Assigned Class :</h5>
									</div>
									<div class="span9">
										<div class="span3" style="width: 151px; height: 35px;">
											<h5
												style="margin-top: -30px; margin-left: 112px; width: 154px;">${assigned.className}
												&nbsp;${assigned.sectionName}</h5>
											<div style="margin-top: -33px; margin-left: 208px;">
												<a href="classes-assign"><span
													class="label label-success">Change</span></a>
											</div>
										</div>
									</div>
								</div>

							</c:otherwise>
						</c:choose>


					</div>

				</div>

			</div>

		</div>


		<div class="row-fluid" style="margin-left: 248px; height: 623px;">

			<div class="span6">



				<form:form id="validate" modelAttribute="EmployeesDetailsBean"
					action="" method="POST">
					<div class="accordion ui-accordion ui-widget ui-helper-reset"
						role="tablist">

						<h3
							class="ui-accordion-header ui-helper-reset ui-state-default ui-accordion-icons ui-corner-all"
							role="tab" id="ui-accordion-1-header-0"
							aria-controls="ui-accordion-1-panel-0" aria-selected="false"
							tabindex="-1">
							<span
								class="ui-accordion-header-icon ui-icon ui-icon-triangle-1-e"></span>Qualification
							Info
						</h3>
						<div
							class="ui-accordion-content ui-helper-reset ui-widget-content ui-corner-bottom"
							style="display: none;" id="ui-accordion-1-panel-0"
							aria-labelledby="ui-accordion-1-header-0" role="tabpanel"
							aria-expanded="false" aria-hidden="true">
							<div class="data-fluid">


								<div class="row-form">
									<div class="span3">Highest Qualification:</div>
									<div class="span9">
										<div class="span9">${EmployeeDetailsBean.highestQualification}</div>
									</div>
								</div>
								<div class="row-form">
									<div class="span3">Passout Year:</div>
									<div class="span9">
										<div class="span9">${EmployeeDetailsBean.passoutYear}</div>
									</div>
								</div>
								<div class="row-form">
									<div class="span3">Passout Month:</div>
									<div class="span9">
										<div class="span9">${EmployeeDetailsBean.passoutMonth}</div>
									</div>
								</div>
								<div class="row-form">
									<div class="span3">Occupation</div>
									<div class="span9">
										<div class="span9">${EmployeeDetailsBean.occupation}</div>
									</div>
								</div>




							</div>
						</div>

						<h3
							class="ui-accordion-header ui-helper-reset ui-state-default ui-accordion-icons ui-corner-all"
							role="tab" id="ui-accordion-1-header-1"
							aria-controls="ui-accordion-1-panel-1" aria-selected="false"
							tabindex="-1">
							<span
								class="ui-accordion-header-icon ui-icon ui-icon-triangle-1-e"></span>Personal
							Info
						</h3>
						<div
							class="ui-accordion-content ui-helper-reset ui-widget-content ui-corner-bottom"
							style="display: none;" id="ui-accordion-1-panel-1"
							aria-labelledby="ui-accordion-1-header-1" role="tabpanel"
							aria-expanded="false" aria-hidden="true">
							<div class="head"></div>
							<div class="data-fluid">
								<div class="row-form">
									<div class="span3">Father Name:</div>
									<div class="span9">
										<div class="span9">${EmployeeDetailsBean.fatherName}</div>
									</div>
								</div>
								<div class="row-form">
									<div class="span3">Mother Name:</div>
									<div class="span9">
										<div class="span9">${EmployeeDetailsBean.motherName}</div>
									</div>
								</div>

								<div class="row-form">
									<div class="span3">DateOfBirth:</div>
									<div class="span9">
										<div class="span9">${EmployeeDetailsBean.dob}</div>
									</div>
								</div>
								<div class="row-form">
									<div class="span3">Birth Place:</div>
									<div class="span9">
										<div class="span9">${EmployeeDetailsBean.birthPlace}</div>
									</div>
								</div>
								<div class="row-form">
									<div class="span3">Blood Group:</div>
									<div class="span9">
										<div class="span9">${EmployeeDetailsBean.bloodGroup}</div>
									</div>
								</div>
								<div class="row-form">
									<div class="span3">Gender:</div>
									<div class="span9">
										<div class="span9">${EmployeeDetailsBean.gender}</div>
									</div>
								</div>

								<div class="row-form">
									<div class="span3">Mother Tongue:</div>
									<div class="span9">
										<div class="span9">${EmployeeDetailsBean.motherTongue}</div>
									</div>
								</div>

							</div>
						</div>

						<h3
							class="ui-accordion-header ui-helper-reset ui-state-default ui-accordion-icons ui-corner-all"
							role="tab" id="ui-accordion-1-header-2"
							aria-controls="ui-accordion-1-panel-2" aria-selected="false"
							tabindex="-1">
							<span
								class="ui-accordion-header-icon ui-icon ui-icon-triangle-1-e"></span>Contact
							Details
						</h3>
						<div
							class="ui-accordion-content ui-helper-reset ui-widget-content ui-corner-bottom"
							style="display: none;" id="ui-accordion-1-panel-2"
							aria-labelledby="ui-accordion-1-header-2" role="tabpanel"
							aria-expanded="false" aria-hidden="true">




							<div class="row-form">
								<div class="span3">Address:</div>
								<div class="span9">
									<div class="span9">${EmployeeDetailsBean.address}</div>

								</div>
							</div>
							<div class="row-form">
								<div class="span3">City:</div>
								<div class="span9">
									<div class="span9">${EmployeeDetailsBean.city}</div>
								</div>
							</div>
							<div class="row-form">
								<div class="span3">State:</div>
								<div class="span9">
									<div class="span9">${EmployeeDetailsBean.stateName}</div>
								</div>
							</div>
							<div class="row-form">
								<div class="span3">Country:</div>
								<div class="span9">
									<div class="span9">${EmployeeDetailsBean.countryName}</div>
								</div>
							</div>
							<div class="row-form">
								<div class="span3">Pincode:</div>
								<div class="span9">
									<div class="span9">${EmployeeDetailsBean.pinCode}</div>
								</div>
							</div>
							<div class="row-form">
								<div class="span3">Mobile:</div>
								<div class="span9">
									<div class="span9">${EmployeeDetailsBean.mobile}</div>
								</div>
							</div>

							<div class="row-form">
								<div class="span3">E-Mail:</div>
								<div class="span9">
									<div class="span9">${EmployeeDetailsBean.email}</div>
								</div>
							</div>
						</div>

					</div>

				</form:form>
			</div>

		</div>

	</div>
	</div>

	</div>
<div class="row-fluid" style="margin-top: -61px; width: 900px; margin-left: 291px;">
		<div>
			<table style="width: 897px;">

				<c:forEach var="list" items="${documentList}" varStatus="loop">
					<tr>
						<c:if test="${list.employeeDocumentId!=0}">
							<td>
								<div class="data-fluid">
									<div class="row-form">
										<div class="span3"></div>
										<div class="span9">

											<div class="span3" style="width: 138px; height: 137px;">
												<img src="${img_url}/document.jpg"
													style="width: 143px; height: 124px;">
											</div>
										</div>
									</div>
								</div>

							</td>
							<td>${list.documentName}</td>
							<td><a href="empdocument-download?id=${list.fileName}"><span
									class="label label-success">Download</span></a></td>

						</c:if>
					</tr>

				</c:forEach>




			</table>
		</div>
	</div>
</body>

