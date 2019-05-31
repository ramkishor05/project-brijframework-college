<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:url value="/style/theme/images/back.png" var="backurl" />
<c:url value="/style/theme/images/admission_page_logo.jpg"
	var="StudentAddLogo" />
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/" var="baseurl"></spring:url>
<spring:url value="/img" var="img_url" />
<spring:url value="/style" var="style_url" />
<spring:url value="/css" var="css_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/home.css">
<link rel="stylesheet" type="text/css" href="${css_url}/setting.css">
<link href="${datepicks}/jquery.datepick.css" rel="stylesheet">
<script src="${datepicks}/jquery.plugin.js"></script>
<script src="${datepicks}/jquery.datepick.js"></script>
<spring:url value="/img" var="img" />
<script>
	$(function() {
		$('#joiningDate').datepick({
			dateFormat : "yyyy-mm-dd"
		});
		$("#dateofbirth").datepick({
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
</script>



<div class="content">
	<div id="content-header" style="height: 150px;">
		<img alt="Show_settings"
			src="${img_url}//employeeImages/EmployeeIcon.png"
			style="width: 57px;">
		<h1>Edit Employee Details</h1>
		<h3>Update Employee</h3>
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
	<c:if test="${not empty msg}">
		<div class="successmsg">${msg}</div>
	</c:if>
	<f:form id="validate" method="POST" name="myForm"
		onsubmit="return checkFirstname();" enctype="multipart/form-data"
		action="edit-employee-details" commandName="employeeDTO">
		<div class="row-fluid">

			<div class="span6">

				<div class="block">
					<div class="head"></div>
					<div class="data-fluid">
						<div class="row-form">
							<div class="span3">
								Joining Date<font color="red">*</font>:
							</div>
							<div class="span9">
								<f:input id="joiningDate" class="datepicker validate[required]"
									type="text" path="joiningDate" />
							</div>
						</div>
						<div id="wizard_validate-titles" class="stepy-titles"></div>
						<legend>Personal Info</legend>
						<hr>
						<div class="row-form">
							<div class="span3">
								First Name:<font color="red">*</font>
							</div>
							<div class="span9">
								<f:input type="text" path="firstName" id="firstName"
									
									class="validate[required,minSize[2],custom[onlyLetterSp]]" />
							</div>
						</div>

						<div class="row-form">
							<div class="span3">
								Last Name:<font color="red">*</font>
							</div>
							<div class="span9">
								<f:input type="text" path="lastName" id="lastName"
									
									class="validate[required]" />
							</div>
						</div>
						<div class="row-form">
							<div class="span3">
								Father Name:<font color="red">*</font>
							</div>
							<div class="span9">
								<f:input type="text" path="fatherName" id="fatherName"
									class="validate[required]" 
									 />
							</div>
						</div>
						<div class="row-form">
							<div class="span3">
								Mother Name:<font color="red">*</font>
							</div>
							<div class="span9">
								<f:input type="text" path="motherName" id="lastName"
									class="validate[required]"  />
							</div>
						</div>
						<div class="row-form">
							<div class="span3">
								Date Of Birth<font color="red">*</font>:
							</div>
							<div class="span9">
								<f:input type="text" path="dob" id="dateOfBirth"
									class="datepicker validate[required]" />
							</div>
						</div>


						<div class="row-form">
							<div class="span3">
								Gender<font color="red">*</font>:
							</div>
							<div class="span9">
								<f:select path="gender" class="form-control input-sm"
									id="currentbrachId" x-data-toggle-x="tooltip"
									required="required" title="Specify the gender"
									data-original-title="Specify the gender">

									<option value="">Select Gender</option>
									<f:option value="Male">Male</f:option>
									<f:option value="Female">Female</f:option>
								</f:select>
							</div>
						</div>
						<div class="row-form">
							<div class="span3">Blood Group:</div>
							<div class="span9">
								<f:select path="bloodGroup" class="form-control input-sm"
									id="bloodGroup" x-data-toggle-x="tooltip"
									title="Specify the blood Group"
									data-original-title="Specify the blood group">
									<option value="">Select Blood Group</option>
									<f:option value="A+">A+</f:option>
									<f:option value="A-">A-</f:option>
									<f:option value="B+">B+</f:option>
									<f:option value="B-">B-</f:option>
									<f:option value="O+">O+</f:option>
									<f:option value="O-">O-</f:option>
									<f:option value="AB+">AB+</f:option>
									<f:option value="AB-">AB-</f:option>
								</f:select>
							</div>
						</div>
						<div class="row-form">
							<div class="span3">Birth's Place :</div>
							<div class="span9">
								<f:input type="text"
									class="validate[minSize[3],custom[onlyLetterSp]]"
									maxlength="20" path="birthPlace" id="birthPlace" />
							</div>
						</div>


						<div class="row-form">
							<div class="span3">Mother Tongue:</div>
							<div class="span9">
								<f:input type="text"
									class="validate[required]" 
									 path="motherTongue" id="Language" />
							</div>
						</div>
					</div>
				</div>
			</div>


			<div class="span6">
				<div class="block">
					<div class="head"></div>
					<div class="data-fluid">
						<div class="row-form">
							<div class="span3"></div>
							<div class="span9"></div>
						</div>
						<div id="wizard_validate-titles" class="stepy-titles"></div>

						<!-- <fieldset title="Step 1" class="step" id="wizard_validate-step-0"> -->
						<legend>Qualification Info</legend>
						<hr>
						<div class="row-form">
							<div class="span3">
								Highest Qualification<font color="red">*</font>:
							</div>
							<div class="span9">
								<f:select style="width: 100%;" path="highestQualification"
									id="highestQualification" class="validate[required]">
									<option value="">Select Highest Qualification</option>
									<f:option value="BA">BA</f:option>
									<f:option value="BSC">BSc</f:option>
									<f:option value="BCOM">BCom</f:option>
									<f:option value="MA">MA</f:option>
									<f:option value="MSC">MSc</f:option>
									<f:option value="MCOM">MCom</f:option>
									<f:option value="MPHILL">Mphill</f:option>
									<f:option value="PHD">PHD</f:option>
								</f:select>
							</div>
						</div>

						<div class="row-form">
							<div class="span3">
								Passout Month<font color="red">*</font>:
							</div>
							<div class="span9" id="batch">
								<f:select style="width: 100%;" path="passoutMonth"
									id="passoutMonth" class="validate[required]">
									<option value="">Select Passout Month</option>
									<f:option value="JAN">Jan</f:option>
									<f:option value="FEB">Feb</f:option>
									<f:option value="MAR">March</f:option>
									<f:option value="APR">April</f:option>
									<f:option value="MAY">May</f:option>
									<f:option value="JUN">June</f:option>
									<f:option value="JUL">July</f:option>
									<f:option value="AUG">Aug</f:option>
									<f:option value="SEPT">Sept</f:option>
									<f:option value="AUG">Oct</f:option>
									<f:option value="NOV">Nov</f:option>
									<f:option value="DEC">Dec</f:option>
								</f:select>
							</div>
						</div>

						<div class="row-form">
							<div class="span3">
								Passout year<font color="red">*</font>:
							</div>
							<div class="span9" id="passoutYear">
								<f:input type="text" path="passoutYear" id="passoutYear"
									class="validate[required]"  />
							</div>
						</div>

						<div class="row-form">
							<div class="span3">
								Occupation <font color="red">*</font>:
							</div>
							<div class="span9">
								<f:input type="text" path="occupation" id="pinCode"
									class="validate[required]" />
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="span6">
			<div class="block" style="left: 529px; width: 265px; top: -180px;">
				<div class="head">
					<legend>Upload Photo:</legend>
					<hr>
					<table>
						<tr>
							<td>
								<fieldset
									style="float: left; width: 230px; height: 180px; margin: 15px;">
									<legend style="color: gray;">
										<font size="4">Photo:</font>
									</legend>
									<table style="margin-top: -13px;">
										<tr>
											<td><div
													style="width: 100px; height: 100px; float: left;">
													<img
														src="${style_url}/employeeImages/${employeeDTO.imagename}"
														style="width: 100px; height: 100px; margin-left: 55px; margin-top: 20px;">
												</div></td>
										</tr>
										<tr>
											<td>
												<div class=""
													style="width: 80px; float: left; margin-top: 35px;">

													<f:input type="file" path="imamgeName" accept="image/*"
														id="im" style="width: 182px;" />
													<span id="err"></span>
												</div>
											</td>
										</tr>
									</table>
								</fieldset>
							</td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
						</tr>
					</table>

				</div>
			</div>
		</div>
		<div class="row-fluid" style="margin-top: -283px;">
			<div class="span6">
				<div class="block">
					<div class="head">
						<legend>Contact Info</legend>
						<hr>
						<div class="row-form">
							<div class="span3">
								Address <font color="red">*</font>:
							</div>
							<div class="span9">
								<f:textarea placeholder="Enter Address" maxlength="300"
									class="validate[required],minSize[10],maxSize[300]"
									path="address" />
							</div>
						</div>

						<div class="row-form">
							<div class="span3">
								Country <font color="red">*</font>:
							</div>
							<div class="span9" id="country">
								<f:select path="countryId" class="form-control input-sm"
									onchange="getstateList(this.value);" id="countryId"
									x-data-toggle-x="tooltip" required="required"
									title="Specify the country"
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
									title="Specify the country"
									data-original-title="Specify your state">
									<option value="">Select State</option>
									<c:forEach var="list" items="${stateList}">
										<f:option value="${list.stateId}">${list.stateName}</f:option>
									</c:forEach>
								</f:select>
							</div>
						</div>
						<div id="otherdata"></div>
						<div class="row-form">
							<div class="span3">
								City <font color="red">*</font>:
							</div>
							<div class="span9" id="city">
								<f:select path="cityId" class="form-control input-sm"
									id="cityId" x-data-toggle-x="tooltip" required="required"
									title="Specify the branch for the selected course"
									data-original-title="Specify your city">

									<option value="">Select City</option>
									<c:forEach var="list" items="${cityList}">
										<f:option value="${list.cityId}">${list.cityName}</f:option>
									</c:forEach>
								</f:select>
							</div>
						</div>

						<div class="row-form">
							<div class="span3">
								Pincode <font color="red">*</font>:
							</div>
							<div class="span9">
								<f:input type="text" path="pinCode" id="pinCode" maxlength="6"
									class="validate[required,custom[integer],min[6]]" />
							</div>
						</div>

						<div class="row-form">
							<div class="span3">
								Mobile <font color="red">*</font>:
							</div>
							<div class="span9">
								<f:input type="text" path="mobile" id="mobile" maxlength="10"
									class="validate[required,custom[integer],min[10]]" />
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
								<f:input type="text" class="validate[custom[email]]"
									path="email" id="email" onkeyup="checkExistEmail();" />
								<span class="bottom"></span>
							</div>
						</div>
						<f:hidden path="id" />
						<f:hidden path="active" />
						<div class="toolbar bottom tar" id="hide">
							<div class="btn-group">
								<button type="submit" class="btn">Update</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

	</f:form>
</div>
