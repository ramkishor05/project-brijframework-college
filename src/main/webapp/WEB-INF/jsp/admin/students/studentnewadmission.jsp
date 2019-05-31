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
<link href="${datepicks}/jquery.datepick.css" rel="stylesheet">
<script src="${datepicks}/jquery.plugin.js"></script>
<script src="${datepicks}/jquery.datepick.js"></script>

<script>
	$(function() {
		$('#feeReceiptDate').datepick({
			dateFormat : "yyyy-mm-dd"
		});
		$('#admission_date').datepick({
			dateFormat : "yyyy-mm-dd"
		});
		$('#writtenOrIntervieDate').datepick({
			dateFormat : "yyyy-mm-dd"
		});
		$("#dateOfBirth").datepick({
			dateFormat : "yyyy-mm-dd"
		});
	});
	
	/* function getSubmission()
	{
		$("#validate").submit();
		location.reload(true);
		location.reload(true);
	} */
	function getSectionList(id) {

		$.ajax({
			type : "post",
			url : 'getsectionlist/' + id,
			success : function(data, status) {
				$("#sectionId").empty();
				var j = JSON.parse(data);
				var content = '<option value="">Select Section</option>';
				for (var i = 0; i < j.length; i++) {
					content += '<option value='+j[i].sectionId+'>'
							+ j[i].sectionName + '</option>';
				}
				$("#sectionId").append(content);
			},
			error : function(e) {

			}
		});
	}
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
								+ ') class="select validate[required]" style="width: 100%;">'
								+ '<option value="">-- Select State --</option>';
						var j = JSON.parse(data);
						var length = j.length;

						for (var i = 0; i < length; i++) {

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

						var st = '<select name="cityId" class=" select validate[required]" style="width: 100%;" id="cityId">'
								+ '<option value="">-- Select City --</option>';
						var j = JSON.parse(data);
						var length = j.length;

						for (var i = 0; i < length; i++) {

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
	<div id="content-header">
		<img alt="Show_settings" src="${img_url}/admission_form.jpg"
			style="width: 74px;">
		<h1>Enquiry Form</h1>
		<h3>Enquiry Form</h3>
		<div id="app-back-button">
			<a href="home"><img alt="Back" border="0"
				src="${img_url}/home.png" title="Home"
				style="margin-top: -6px; heiht: 40px; width: 40px;"></a> <a
				href="#" onclick="javascript:location.reload(true);"><img
				alt="Back" border="0" src="${img_url}/refresh.png" title="Refresh"
				style="margin-top: -6px; height: 40px; width: 40px;"></a> <a
				href="#" onclick="history.back(); return false;"><img alt="Back"
				border="0" src="${img_url}/back.png" title="Back"
				style="margin-top: -6px; height: 40px; width: 40px;"></a>
		</div>
	</div>
	<f:form id="validate" method="POST" enctype="multipart/form-data"
		action="StudentAdmission" commandName="studentAdmissionDTO" target="_blank">
		<div class="row-fluid">

			<div class="span6">

				<div class="block">
					<div class="head"></div>
					<div class="data-fluid">
						<div class="row-form">
							<div class="span3">S.No:</div>
							<div class="span9">
								<input type="text" name="sNo" value="${SNo}" >
							</div>
						</div>

						<div id="wizard_validate-titles" class="stepy-titles"></div>
						<legend>Personal Info</legend>
						<div class="row-form">
							<div class="span3">Name:<font color="red">*</font></div>
							<div class="span9">
								<input type="text" name="studentName"  required="required">
							</div>
						</div>
						<div class="row-form">
							<div class="span3">
								Class:<font color="red">*</font>
							</div>
							<div class="span9">
								<f:select path="classId" class="form-control input-sm"
									id="classId" x-data-toggle-x="tooltip" required="required"
									title="Specify the class of the student"
									onchange="getSectionList(this.value);"
									data-original-title="Specifyclass">

									<f:option value="0">Select a class</f:option>
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
							<div class="span9">
								<select id="sectionId" class="validate[required]"
									name="sectionId" class="select" required="required"
									onchange="getRollNo(this.value);">
									<option value="">Select a Section</option>
								</select>
							</div>
						</div>
						<div class="row-form">
							<div class="span3">Date Of Birth:<font color="red">*</font></div>
							<div class="span9">
								<f:input path="dateOfBirth" id="dateOfBirth" readonly="readonly" lass="validate[required]"/>
								<!-- <input type="text" name="dateOfBirth" id="dateOfBirth"
									readonly="readonly"> -->
							</div>
						</div>
						<div class="row-form">
							<div class="span3">Gender:<font color="red">*</font></div>
							<div class="span9">
								<select name="gender" class="form-control input-sm"
									id="currentbrachId" x-data-toggle-x="tooltip"
									title="Specify the gnder" required="required"
									data-original-title="Specify the gender">

									<option value="">Select Gender</option>
									<option value="Male">Male</option>
									<option value="Female">Female</option>
								</select>
							</div>
						</div>
						<div class="row-form">
							<div class="span3">Mother Tounge:</div>
							<div class="span9">
								<select name="motherTounge" class="form-control input-sm"
									id="currentbrachId" x-data-toggle-x="tooltip"
									title="Specify the gnder"
									data-original-title="Specify the gender">

									<option value="">Select Tounge</option>
									<option value="Hindi">Hindi</option>
									<option value="English">English</option>

								</select>
							</div>
						</div>
						<div class="row-form">
							<div class="span3">Physically Challenged:<font color="red">*</font></div>
							<div class="span9">
								<select name="physicalDisability" class="form-control input-sm"
									id="currentbrachId" x-data-toggle-x="tooltip"
									title="Specify the Physically Challenged" required="required"
									data-original-title="Specify the Physically Challenged">

									<option value="">Select Physically Challenged</option>
									<option value="Yes">Yes</option>
									<option value="No">No</option>
								</select>
							</div>
						</div>
						<div class="row-form">
							<div class="span3">Res. Address:<font color="red">*</font></div>
							<div class="span9">
								<textarea placeholder="Enter Address" 
								
									name="resAddress"></textarea>
							</div>
						</div>
						<div class="row-form">
							<div class="span3">
								Country:<font color="red">*</font>
							</div>
							<div class="span9" id="country">
								<f:select path="countryId" id="countryId" required="required"
									x-data-toggle-x="tooltip" title="Specify the country"
									onchange="getstateList(this.value)"
									data-original-title="Specify your country">

									<f:option value="0">--Select Country--</f:option>
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
								<f:select path="stateId"
									class="validate[required] form-control input-sm"
									onchange="getcityList(this.value)" id="state"
									x-data-toggle-x="tooltip" title="Specify the state"
									data-original-title="Specify your state">
									<option value="">Select State</option>
								</f:select>
							</div>
						</div>
						
					<div class="row-form">
							<div class="span3">
								City <font color="red">*</font>:
							</div>
							<div class="span9" id="city">
								<f:select path="cityId"
									class="validate[required] form-control input-sm" id="cityId"
									x-data-toggle-x="tooltip" title="Specify the city"
									data-original-title="Specify your city">
									<option value="">Select City</option>
								</f:select>
							</div>
						</div>
						<div class="row-form">
							<div class="span3">Mobile:<font color="red">*</font></div>
							<div class="span2">
								<input type="text" readonly="readonly" value="+91">
							</div>
							<div class="span7">
								<input type="text" name="phoneNo" id="mobile" maxlength="10"
						
									placeholder="Enter 10 Digit Number">
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
							<div class="span4">Regn.No:</div>
							<div class="span8">
								<input type="text" name="regNo">
							</div>
						</div>
						<div class="row-form">
							<div class="span3"></div>
							<div class="span9"></div>
						</div>
						<div id="wizard_validate-titles" class="stepy-titles"></div>

						<!-- <fieldset title="Step 1" class="step" id="wizard_validate-step-0"> -->
						<legend>Father Info</legend>

						<div class="row-form">
							<div class="span3">Name:<font color="red">*</font></div>
							<div class="span9">
								<input type="text" name="fatherName" id="firstName"
								 required="required">
							</div>
						</div>
						<div class="row-form">
							<div class="span3">Education:</div>
							<div class="span9">
								<input type="text" name="fatherEducation" id="firstName"
									>
							</div>
						</div>
						<div class="row-form">
							<div class="span3">Occupation:</div>
							<div class="span9">
								<input type="text" name="fatherOccupation" id="firstName"
								>
							</div>
						</div>
						<div class="row-form">
							<div class="span3">Annual Income:</div>
							<div class="span9">
								<input type="text" name="fatherAnnualIncome" id="firstName"
									>
							</div>
						</div>
						<div class="row-form">
							<div class="span3">Mobile :</div>
							<div class="span2">
								<input type="text" readonly="readonly" value="+91">
							</div>
							<div class="span7">
								<input type="text" name="fatherPhoneNo" id="mobile" class="validate[custom[integer]]"
									 placeholder="Enter 10 Digit Number">
							</div>
						</div>
						<div class="row-form">
							<div class="span3">Office Address:</div>
							<div class="span9">
								<textarea placeholder="Enter Address" 
									name="fatherOfficeAddress"></textarea>
							</div>
						</div>
						<div class="row-form">
							<div class="span5">
								<label>Student's Photo:</label>
							</div>
							<div class="span2">
								<div class="" style="width: 549px;">
									<input type="file" name="photo" accept="image/*" id="im"
										style="width: 284px;"> <span id="err"></span>
								</div>
							</div>
						</div>
					</div>
					<div class="row-form">
						<div class="span3">Written Test Date:</div>
						<div class="span9">
							<f:input path="writtenOrIntervieDate" id="writtenOrIntervieDate"
								readonly="readonly" />
						</div>
					</div>
					<legend>
						<font color="green">${msg}</font>
					</legend>
				</div>
			</div>
		</div>
		<div class="row-fluid">
			<div class="span6">
				<div class="block">
					<div class="head">
						<div id="wizard_validate-titles" class="stepy-titles"></div>
						<legend>Mother Info</legend>

						<div class="row-form">
							<div class="span3">Name:<font color="red">*</font></div>
							<div class="span9">
								<input type="text" name="motherName" id="firstName"
									
									required="required">
							</div>
						</div>
						<div class="row-form">
							<div class="span3">Education:</div>
							<div class="span9">
								<input type="text" name="motherEducation" id="firstName"
									>
							</div>
						</div>
						<div class="row-form">
							<div class="span3">Occupation:</div>
							<div class="span9">
								<input type="text" name="motherOccupation" id="firstName"
									>
							</div>
						</div>
						<div class="row-form">
							<div class="span3">Annual Income:</div>
							<div class="span9">
								<input type="text" name="motherAnnualIncome" id="firstName"
									>
							</div>
						</div>
						<div class="row-form">
							<div class="span3">Mobile :</div>
							<div class="span2">
								<input type="text" readonly="readonly" value="+91">
							</div>
							<div class="span7">
								<input type="text" name="motherPhoneNo" id="mobile" class="validate[custom[integer]]"
									 placeholder="Enter 10 Digit Number">
							</div>
						</div>
						<div class="row-form">
							<div class="span3">Office Address:</div>
							<div class="span9">
								<textarea placeholder="Enter Address"
									name="motherOfficeAddress"></textarea>
							</div>
						</div>



					</div>
				</div>
			</div>
			<div class="span6">
				<div class="block">
					<div class="head"></div>
					<div class="data-fluid" style="margin-top: -59px;">
						<div class="row-form">
							<div class="span3"></div>
							<div class="span9"></div>
						</div>
						

						<!-- <fieldset title="Step 1" class="step" id="wizard_validate-step-0"> -->
							<div id="wizard_validate-titles" class="stepy-titles"></div>
						<legend>Previous School Details</legend>
						<div class="row-form">
							<div class="span3">School Name:</div>
							<div class="span9">
								<input type="text" name="schoolName" id="schoolName"
									
									>
							</div>
						</div>
						<div class="row-form">
							<div class="span3">Address:</div>
							<div class="span9">
								<input type="text" name="schoolAddress" id="schoolAddress"
									>
							</div>
						</div>
						<div class="row-form">
							<div class="span3">Phone:</div>
							<div class="span9">
								<input type="text" name="schoolPhone" id="schoolPhone"
							
									class="validate[custom[integer]]">
							</div>
						</div>
						<legend>
							<font color="green">${msg}</font>
						</legend>
					</div>
				</div>
			</div>
		</div>
		<div class="row-fluid">

			<div class="span6">

				<div class="block">
					<div class="head"></div>
					<div class="data-fluid">

						<div id="wizard_validate-titles" class="stepy-titles"></div>
						<legend>Brothers & Sisters</legend>
						<div class="row-form">
							<div class="span3">Name:</div>
							<div class="span9">
								<input type="text" name="brotherOrSisterName1" >
							</div>
						</div>
						<div class="row-form">
							<div class="span3">Age:</div>
							<div class="span9">
								<input type="text" name="brotherOrSisterAge1" >
							</div>
						</div>
						<div class="row-form">
							<div class="span3">Class :</div>
							<div class="span9">
								<input type="text" name="brotherOrSisterClass1" >
							</div>
						</div>
						<div class="row-form">
							<div class="span3">School/College:</div>
							<div class="span9">
								<input type="text" name="brotherOrSisterSchoolOrCollege1"
									id="dateOfBirth">
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
							<div class="span3">Name:</div>
							<div class="span9">
								<input type="text" name="brotherOrSisterName2">
							</div>
						</div>
						<div class="row-form">
							<div class="span3">Age:</div>
							<div class="span9">
								<input type="text" name="brotherOrSisterAge2" >
							</div>
						</div>
						<div class="row-form">
							<div class="span3">Class :</div>
							<div class="span9">
								<input type="text" name="brotherOrSisterClass2" >
							</div>
						</div>
						<div class="row-form">
							<div class="span3">School/College:</div>
							<div class="span9">
								<input type="text" name="brotherOrSisterSchoolOrCollege2"
									id="dateOfBirth">
							</div>
						</div>
						<div class="toolbar bottom tar" id="hide">
							<div class="btn-group">
								<input type="submit"  class="btn" value="Create">
							</div>
						</div>
						<legend>
							<font color="green">${msg}</font>
						</legend>
					</div>
				</div>
			</div>
		</div>
	</f:form>
</div>