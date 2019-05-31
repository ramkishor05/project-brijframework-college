<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:url value="/style/theme/images/back.png" var="backurl" />
<c:url value="/style/theme/images/admission_page_logo.jpg"
	var="StudentAddLogo" />
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/style/datepicks" var="datepicks" />
<spring:url value="/img" var="img_url" />
<spring:url value="/css" var="css_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/admission.css">
<spring:url value="/img" var="img" />
<link href="${datepicks}/jquery.datepick.css" rel="stylesheet">
<script src="${datepicks}/jquery.plugin.js"></script>
<script src="${datepicks}/jquery.datepick.js"></script>

<script>
	$(function() {
		/* $('#dateOfBirth').datepick(); */
		$('#admissionDate').datepick({
			dateFormat : "yyyy-mm-dd"
		});
		$("#dateOfBirth").datepick({
			dateFormat : "yyyy-M-dd"
		});
	});
</script>

<script type="text/javascript">
	function getstateList(id) {
		var url = 'getstate/' + id;
		$
				.ajax({
					url : url,

					type : 'POST',
					success : function(data, status) {
						$("#state").empty();

						var st = '<select name="stateId" onchange=getcityList(this.value,'
								+ id
								+ ') class="validate[required]" style="width: 100%;">'
								+ '<option value="">-- Select State --</option>';
						var j = JSON.parse(data);
						var length = j.length;

						for ( var i = 0; i < length; i++) {

							st = st + '<option value=' + j[i].id + '>'
									+ j[i].stateName + '</option>';

						}
						st = st + '</select>';

						$("#state").append(st);

					},
					error : function(error, status) {

					}
				});

	}
	function getcityList(id, countryId) {
		var url = 'getcityList/' + id + '/' + countryId;
		$
				.ajax({
					url : url,

					type : 'POST',
					success : function(data, status) {
						$("#city").empty();

						var st = '<select name="cityId" class="validate[required]" style="width: 100%;" id="cityId">'
								+ '<option value="">-- Select City --</option>';
						var j = JSON.parse(data);
						var length = j.length;

						for ( var i = 0; i < length; i++) {

							st = st + '<option value=' + j[i].id + '>'
									+ j[i].cityName + '</option>';

						}
						st = st + '</select>';

						$("#city").append(st);

					},
					error : function(error, status) {

					}
				});

	}
	function getSectionList(id) {
		$("#sectionId").empty();
		$.ajax({
			type : "post",
			url : 'getsectionlist/' + id,
			success : function(data, status) {

				var j = JSON.parse(data);
				var content = '<option value="">Select Section</option>';
				for ( var i = 0; i < j.length; i++) {
					content += '<option value='+j[i].sectionId+'>'
							+ j[i].sectionName + '</option>';
				}
				$("#sectionId").append(content);
			},
			error : function(e) {

			}
		});
	}
</script>


<div class="content">
	<div id="content-header">
		<img alt="Show_settings" src="${img_url}/student_profile.jpg"
			style="width: 74px;">
		<h1>Edit Student Information</h1>
		<h3>Update Details</h3>
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
	<f:form id="validate" method="POST" name="myForm"
		onsubmit="return checkFirstname();" enctype="multipart/form-data"
		action="edit-student-details" commandName="studentDTO">
		<div class="row-fluid">

			<div class="span6">

				<div class="block">
					<div class="head"></div>
					<div class="data-fluid">
						<%-- 	<div class="row-form">
							<div class="span3">
								Admission No:<font color="red"></font>
							</div>
							<div class="span9">
								<f:input type="text" path="admissionNo" readonly="readonly"/>
							</div>
						</div>  --%>

						<div class="row-form">
							<div class="span3">
								L.F No. <font color="red">*</font>:
							</div>
							<div class="span9">
								<f:input type="text" name="lfno" path="lfno" id="lfno"
									maxlength="10" title="Enter LF Number"
									class="validate[required],custom[integer],maxSize[10]" />
							</div>
						</div>

						<div id="wizard_validate-titles" class="stepy-titles"></div>
						<legend>Personal Info</legend>
						<div class="row-form">
							<div class="span3">
								First Name:<font color="red">*</font>
							</div>
							<div class="span9">
								<f:input type="text" path="firstName" id="firstName"
									maxlength="50"
									class="validate[required,minSize[4],maxSize[50]]" />
							</div>
						</div>
						<div class="row-form">
							<div class="span3">Middle Name:</div>
							<div class="span9">
								<f:input type="text" path="middleName" maxlength="50"
									placeholder="(Optional)" id="secondName"
									class="validate[minSize[1],maxSize[50]]" />
							</div>
						</div>
						<div class="row-form">
							<div class="span3">
								Last Name:<font color="red"></font>
							</div>
							<div class="span9">
								<f:input type="text" path="lastName" id="lastName"
									maxlength="50" placeholder="(Optional)"
									class="validate[minSize[3],maxSize[50]]" />
							</div>
						</div>
						<div class="row-form">
							<div class="span3">
								Father Name:<font color="red">*</font>
							</div>
							<div class="span9">
								<f:input type="text" path="fatherName" id="lastName"
									maxlength="50"
									class="validate[required,minSize[2],maxSize[50]]" />
							</div>
						</div>
						<div class="row-form">
							<div class="span3">
								Mother Name:<font color="red">*</font>
							</div>
							<div class="span9">
								<f:input type="text" path="motherName" id="lastName"
									maxlength="20"
									class="validate[required,minSize[2],maxSize[50]]" />
							</div>
						</div>
							<div class="row-form">
							<div class="span3">
								Guardian Name:<font color="red"></font>
							</div>
							<div class="span9">
								<f:input type="text" path="guardianName" id="guardianName"
									maxlength="20"
									class="validate[minSize[4],maxSize[50]]" />
							</div>
						</div>
						<div class="row-form">
							<div class="span3">
								Date Of Birth<font color="red">*</font>:
							</div>
							<div class="span9">
								<f:input type="text" path="dateOfBirth" id="dateOfBirth"
									readonly="readonly" class="validate[required]" />
							</div>
						</div>


						<div class="row-form">
							<div class="span3">
								Gender<font color="red">*</font>:
							</div>
							<div class="span9">
								<f:select path="gender" class="form-control input-sm"
									id="currentbrachId" x-data-toggle-x="tooltip"
									required="required" title="Specify the gnder"
									data-original-title="Specify the gender">

									<f:option value="">Select Gender</f:option>
									<f:option value="Male">Male</f:option>
									<f:option value="Female">Female</f:option>
								</f:select>
							</div>
						</div>
						<div class="row-form">
							<div class="span3">
								Physically Challenged<font color="red">*</font>:
							</div>
							<div class="span9">
								<f:select path="physicallyChallenged"
									class="form-control input-sm" id="currentbrachId"
									x-data-toggle-x="tooltip" required="required"
									title="Specify the Physically Challenged"
									data-original-title="Specify the Physically Challenged">

									<f:option value="">Select Physically Challenged </f:option>
									<f:option value="Yes">Yes</f:option>
									<f:option value="No">No</f:option>
								</f:select>
							</div>
						</div>

					</div>
				</div>
			</div>


			<div class="span6">
				<div class="block">
					<div class="head"></div>
					<div class="data-fluid">
						<div class="row-form" style="width: 494px;">
							<div class="span3" style="width: 135px;">
								Admission Date<font color="red">*</font>:
							</div>
							<div class="span9" style="margin-left: -11px;">
								<f:input id="admissionDate"
									class="validate[required]" type="text"
									readonly="readonly" path="admissionDate"
									style="margin-left: 8px; width: 351px;" />
							</div>
						</div>
						<div id="wizard_validate-titles" class="stepy-titles"></div>
						<!-- <fieldset title="Step 1" class="step" id="wizard_validate-step-0"> -->
						<legend>Institutional Info</legend>
							<%-- <div class="row-form">
							<div class="span3">
								S R No. <font color="red"></font>:
							</div>
							<div class="span9">
								<f:input  placeholder="(Optional)"
									path="srno" id="srno"/>
							</div>
						</div> --%>
						<div class="row-form">
							<div class="span3">
								Session<font color="red">*</font>:
							</div>
							<div class="span9">
								<f:select path="sessionId" class="form-control input-sm"
									id="sessionId" x-data-toggle-x="tooltip" required="required"
									title="Specify the session of the student"
									data-original-title="Specify session">
									<c:forEach var="list" items="${sessionList}">
										<c:choose>
											<c:when test="${studentDTO.sessionId==list.sessionId}">
												<f:option selected="selected" value="${list.sessionId}">${list.sessionDuration}</f:option>
											</c:when>
											<c:otherwise>
												<f:option value="${list.sessionId}">${list.sessionDuration}</f:option>
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</f:select>
							</div>
						</div>
						<div class="row-form">
							<div class="span3">
								Class<font color="red">*</font>:
							</div>
							<div class="span9">
								<f:select path="classId" class="form-control input-sm"
									id="classId" x-data-toggle-x="tooltip" required="required"
									data-original-title="Specify class"
									title="Specify the class of the student"
									onchange="getSectionList(this.value);">

									<option value="">Select a class</option>
									<c:forEach var="list" items="${classList}">
										<f:option value="${list.classId}">${list.className}</f:option>
									</c:forEach>
								</f:select>
							</div>
						</div>


						<div class="row-form">
							<div class="span3">
								Section<font color="red">*</font>:
							</div>
							<div class="span9" id="branchList">
								<f:select path="sectionId" class="form-control input-sm"
									id="sectionId" x-data-toggle-x="tooltip" required="required"
									title="Specify the section of the student"
									data-original-title="Specify the section of the student"
									onchange="getBatchList(this.value);">
									<option value="${studentDTO.sectionId}">${studentDTO.sectionName}</option>
								</f:select>
							</div>
						</div>

						<div class="row-form">
							<div class="span3">
								Roll No. <font color="red"></font>:
							</div>
							<div class="span9">
								<f:input type="text" name="rollno" path="rollno" id="rollno"
									maxlength="10" title="Enter Roll Number"
									class="validate[custom[integer],maxSize[10]]" />
							</div>
						</div>

						<div class="row-form">
							<div class="span3">Category :</div>
							<div class="span9">
								<f:select path="studentCategoryId" class="form-control input-sm"
									id="categoryId" x-data-toggle-x="tooltip"
									title="Specify your Category"
									data-original-title="Specify the category">
									<option value="0">Select Category</option>
									<c:forEach var="list" items="${studentcategoryList}">
										<f:option value="${list.studentCategoriesId}">${list.studentCategoriesName}</f:option>
									</c:forEach>
								</f:select>
							</div>
						</div>


						<div class="row-form">
							<div class="span3">Religion:</div>
							<div class="span9">
								<f:select path="religionName" class="form-control input-sm"
									id="religion" x-data-toggle-x="tooltip"
									title="Specify your religion"
									data-original-title="Specify your religion">
									<option value="">Select a religion</option>
									<f:option value="Hindu">Hindu</f:option>
									<f:option value="Muslim">Muslim</f:option>
									<f:option value="Sikh">Sikh</f:option>
									<f:option value="Christian">Christian</f:option>
									<f:option value="Buddh">Buddh</f:option>
									<f:option value="jain">jain</f:option>
								</f:select>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="row-fluid">
			<div class="span6">
				<div class="block">
					<div class="head">
						<legend>Contact Info</legend>
						<div class="row-form">
							<div class="span3">
								Address <font color="red">*</font>:
							</div>
							<div class="span9">
								<f:textarea placeholder="Enter Address" path="addressLine1"
									maxlength="300"
									class="validate[required],minSize[10],maxSize[300]" />
							</div>
						</div>

						<div class="row-form">
							<div class="span3">
								Country <font color="red">*</font>:
							</div>
							<div class="span9" id="country">
								<f:select path="countryId" class="form-control input-sm"
									id="countryId" x-data-toggle-x="tooltip" required="required"
									title="Specify the country" onchange="getstateList(this.value)"
									data-original-title="Specify your country">
									<option value="">--Select Country--</option>
									<c:forEach var="list" items="${countryList}">
										<f:option value="${list.id}">${list.countryName}</f:option>
									</c:forEach>
								</f:select>
							</div>
						</div>


						<div class="row-form">
							<div class="span3">
								State<font color="red">*</font>:
							</div>
							<div class="span9" id="state">
								<f:select path="stateId" class="form-control input-sm"
									onchange="getcityList(this.value)" id="state"
									x-data-toggle-x="tooltip" required="required"
									title="Specify the state"
									data-original-title="Specify your state">
									<option value="">Select State</option>
									<c:forEach var="list" items="${stateList}">
										<f:option value="${list.stateId}">${list.stateName}</f:option>
									</c:forEach>
								</f:select>
							</div>
						</div>
						<div class="row-form">
							<div class="span3">
								City <font color="red">*</font>:
							</div>
							<div class="span9" id="city">
								<f:select path="cityId" class="form-control input-sm"
									id="cityId" x-data-toggle-x="tooltip" required="required"
									title="Specify the city"
									data-original-title="Specify your city">

									<option value="">Select City</option>
									<c:forEach var="list" items="${cityList}">
										<f:option value="${list.cityId}">${list.cityName}</f:option>
									</c:forEach>
								</f:select>
							</div>
						</div>

						<div class="row-form">
							<div class="span3">Pincode :</div>
							<div class="span9">
								<f:input type="text" path="pinCode" id="pinCode" maxlength="6"
									placeholder="(Optional)"
									class="validate[custom[integer],minSize[6],maxSize[6]]" />
							</div>
						</div>

						<div class="row-form">
							<div class="span3">Phone:</div>
							<div class="span9">
								<f:input type="text" path="phone" id="Phone" maxlength="10"
									placeholder="(Optional)"
									class="validate[custom[integer],minSize[6],maxSize[10]]" />
							</div>
						</div>

						<div class="row-form">
							<div class="span3">
								Mobile <font color="red">*</font>:
							</div>
							<div class="span9">
								<f:input type="text" path="mobile" id="mobile" maxlength="10"
									class="validate[required,custom[integer],minSize[10],maxSize[10]]" />
							</div>
						</div>

						<div class="row-form">
							<div class="span3"></div>
							<div class="span9">
								<div id="exist"></div>
							</div>
						</div>
						<div class="row-form">
							<div class="span3">E-mail :</div>
							<div class="span9">
								<f:input type="text" path="email" id="email" maxlength="50"
									placeholder="(Optional)" class="validate[custom[email]]" />
								<span class="bottom"></span>
							</div>
						</div>
<div id="wizard_validate-titles" class="stepy-titles"></div>
						<legend>Previous School Details</legend>
						<div class="row-form">
							<div class="span3">
								School Name:
							</div>
							<div class="span9">
								<f:input path="schoolName" id="schoolName"
									maxlength="50"
									class="validate[minSize[2],maxSize[50],custom[onlyLetterSp]]"/>
							</div>
						</div>
						<div class="row-form">
							<div class="span3">
								Address:
							</div>
							<div class="span9">
								<f:input path="schoolAddress" id="schoolAddress"
									maxlength="100"
									class="validate[minSize[2],maxSize[100]]"/>
							</div>
						</div>
						<div class="row-form">
							<div class="span3">
								Phone:
							</div>
							<div class="span9">
								<f:input path="schoolPhone" id="schoolPhone"
									maxlength="10"
									class="validate[minSize[10],maxSize[10],custom[integer]]"/>
							</div>
						</div>


						<f:hidden path="active" />
						<div class="toolbar bottom tar" id="hide">
							<div class="btn-group">
								<button type="submit" class="btn">Update</button>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="span6">
				<div class="block">
					<div class="head">
						<legend>Upload Family Photographs</legend>
						<table>
							<tr>
								<td>
									<fieldset
										style="float: left; width: 230px; height: 180px; margin: 15px;">
										<legend style="color: gray;">
											<font size="4">Student's Photo:</font>
										</legend>
										<table style="margin-top: -13px;">
											<tr>
												<td><div
														style="width: 100px; height: 100px; float: left;">
														<img src="${img}/studentImages/${studentDTO.imageName}"
															style="width: 100px; height: 100px; margin-left: 55px; margin-top: 20px;">
													</div></td>
											</tr>
											<tr>
												<td>
													<div class=""
														style="width: 80px; float: left; margin-top: 35px;">

														<f:input type="file" path="photo" accept="image/*" id="im"
															style="width: 229px;" />
														<span id="err"></span>
													</div>
												</td>
											</tr>
										</table>
									</fieldset>
								</td>
								<td>
									<fieldset
										style="float: left; width: 230px; height: 180px; margin: 15px;">
										<legend style="color: gray;">
											<font size="4">Father's Photo:</font>
										</legend>
										<table style="margin-top: -13px;">
											<tr>
												<td><div
														style="width: 100px; height: 100px; float: left;">
														<img src="${img}/parentImages/${studentDTO.photo1name}"
															style="width: 100px; height: 100px; margin-left: 55px; margin-top: 20px;">
													</div></td>
											</tr>
											<tr>
												<td>
													<div class=""
														style="width: 80px; float: left; margin-top: 35px;">
														<f:input type="file" path="parentphoto1" accept="image/*"
															id="im1" style="width: 229px;" />
														<span id="err"></span>
													</div>
												</td>
											</tr>
										</table>
									</fieldset>
								</td>
							</tr>
							<tr>
								<td>
									<fieldset
										style="float: left; width: 230px; height: 180px; margin: 15px;">
										<legend style="color: gray;">
											<font size="4">Mother's Photo:</font>
										</legend>
										<table style="margin-top: -13px;">
											<tr>
												<td><div
														style="width: 100px; height: 100px; float: left;">
														<img src="${img}/parentImages/${studentDTO.photo2name}"
															style="width: 100px; height: 100px; margin-left: 55px; margin-top: 20px;">
													</div></td>
											</tr>
											<tr>
												<td>
													<div class=""
														style="width: 80px; float: left; margin-top: 35px;">
														<f:input type="file" path="parentphoto2" accept="image/*"
															id="im" style="width: 229px;" />
														<span id="err"></span>
													</div>
												</td>
											</tr>
										</table>
									</fieldset>
								</td>
								<td>
									<fieldset
										style="float: left; width: 230px; height: 180px; margin: 15px;">
										<legend style="color: gray;">
											<font size="4">Guardian's Photo:</font>
										</legend>
										<table style="margin-top: -13px;">
											<tr>
												<td><div
														style="width: 100px; height: 100px; float: left;">
														<img src="${img}/parentImages/${studentDTO.photo3name}"
															style="width: 100px; height: 100px; margin-left: 55px; margin-top: 20px;">
													</div></td>
											</tr>
											<tr>
												<td>
													<div class=""
														style="width: 80px; float: left; margin-top: 35px;">
														<f:input type="file" path="parentphoto3" accept="image/*"
															id="im" style="width: 229px;" />
														<span id="err"></span>
													</div>
												</td>
											</tr>
										</table>
									</fieldset>
								</td>
							</tr>
						</table>
				
					</div>
				</div>
			</div>
			<f:hidden path="photo1name" />
			<f:hidden path="photo2name" />
			<f:hidden path="photo3name" />
			<f:hidden path="userId" />
			<f:hidden path="admissionNo" />
	</f:form>
</div>
