<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
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
<spring:url value="/style/datepicks" var="datepicks" />
<link rel="stylesheet" type="text/css" href="${css_url}/admission.css">

<link href="${datepicks}/jquery.datepick.css" rel="stylesheet">
<script src="${datepicks}/jquery.plugin.js"></script>
<script src="${datepicks}/jquery.datepick.js"></script>

<script>
	$(function() {
		$('#joiningDate').datepick({
			dateFormat : "yyyy-M-dd"
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
	function getDoc(value,id)
	{
		if (value) {
			$("#div"+id).show();
		}
		else
			{
			$("#files"+id).val('');
		     $("#div"+id).hide();
	}
	}
</script>
<div class="content">
	<div id="content-header" style="height: 150px;">
		<img alt="Show_settings"
			src="${img_url}/employeeImages/EmployeeAdd.png" style="width: 57px;">
		<h1>Add Employee</h1>
		<h3>Employee Registration Form</h3>
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

	${msg}
	<form id="validate" method="POST" name="myForm"
		enctype="multipart/form-data" action="registration-submit"
		modelAttribute="employeesDTO">
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
								<input id="joiningDate" class="validate[required]" type="text"
									name="joiningDate">
							</div>
						</div>
						<div id="wizard_validate-titles" class="stepy-titles"></div>
						<legend>Personal Info</legend>
						<div class="row-form">
							<div class="span3">
								First Name:<font color="red">*</font>
							</div>
							<div class="span9">
								<input type="text" name="firstName" id="firstName"
									class="validate[required]" >
							</div>
						</div>

						<div class="row-form">
							<div class="span3">
								Last Name:<font color="red">*</font>
							</div>
							<div class="span9">
								<input type="text" name="lastName" id="lastName" class="validate[required]" >
							</div>
						</div>

						<div class="row-form">
							<div class="span3">
								Mother's Name:<font color="red">*</font>
							</div>
							<div class="span9">
								<input type="text" name="motherName" id="motherName"
									class="validate[required]" >
							</div>
						</div>

						<div class="row-form">
							<div class="span3">
								Father's Name:<font color="red">*</font>
							</div>
							<div class="span9">
								<input type="text" name="fatherName" id="fatherName"
									class="validate[required]" >
							</div>
						</div>

						<div class="row-form">
							<div class="span3">
								Date Of Birth<font color="red">*</font>:
							</div>
							<div class="span9">
								<input type="text" name="dob" id="dateofbirth"
									class="validate[required]">
							</div>
						</div>


						<div class="row-form">
							<div class="span3">
								Gender<font color="red">*</font>:
							</div>
							<div class="span9">
								<select style="width: 100%;" name="gender" required="required"
									class="validate[required]">
									<option value="">Select Gender</option>
									<option value="Male">Male</option>
									<option value="Female">Female</option>

								</select>
							</div>
						</div>
						<div class="row-form">
							<div class="span3">
								Highest Qualification:<font color="red">*</font>
							</div>
							<div class="span9">
								<select style="width: 100%;" name="highestQualification"
									class="validate[required]">
									<option value="">
										<b>Select Highest Qualification</b>
									</option>
									<option value="BA">BA</option>
									<option value="BSC">BSc</option>
									<option value="BCOM">BCom</option>
									<option value="MA">MA</option>
									<option value="MSC">MSc</option>
									<option value="MCOM">MCom</option>
									<option value="MPHILL">Mphill</option>
									<option value="PHD">PHD</option>
								</select>
							</div>
						</div>
						<div class="row-form">
							<div class="span3">
								Passout Month:<font color="red">*</font>
							</div>
							<div class="span9">
								<select style="width: 100%;" name="passoutMonth"
									id="passoutMonth" class="validate[required]">
									<option value="">
										<b>Select Passout Month</b>
									</option>
									<option value="JAN">Jan</option>
									<option value="FEB">Feb</option>
									<option value="MAR">March</option>
									<option value="APR">April</option>
									<option value="MAY">May</option>
									<option value="JUN">June</option>
									<option value="JUL">July</option>
									<option value="AUG">Aug</option>
									<option value="SEPT">Sept</option>
									<option value="AUG">Oct</option>
									<option value="NOV">Nov</option>
									<option value="DEC">Dec</option>
								</select>
							</div>
						</div>

						<div class="row-form">
							<div class="span3">
								Passout Year:<font color="red">*</font>
							</div>
							<div class="span9">
								<input type="text" name="passoutYear" id="passoutYear"
									maxlength="4" placeholder="Ex: 2000"
									class="validate[[required],custom[integer],minSize[4],maxSize[4]]">
							</div>
						</div>

						<div class="row-form">
							<div class="span3">
								Occupation:<font color="red">*</font>
							</div>
							<div class="span9">
								<input type="text" name="occupation" id="occupation"
									class="validate[required]" >
							</div>
						</div>
						<div class="row-form">
							<div class="span3">Blood Group:</div>
							<div class="span9">
								<select style="width: 100%; display: none;" name="bloodGroup"
									class="select">
									<option value="">Select blood Group</option>
									<option value="A+">A+</option>
									<option value="A-">A-</option>
									<option value="B+">B+</option>
									<option value="B-">B-</option>
									<option value="O+">O+</option>
									<option value="O-">O-</option>
									<option value="AB+">AB+</option>
									<option value="AB-">AB-</option>
								</select>
							</div>
						</div>

						<div class="row-form">
							<div class="span3">Birth's Place :</div>
							<div class="span9">
								<input type="text"
									class="validate[required]" 
									 name="birthPlace" id="birthPlace">
							</div>
						</div>


						<div class="row-form">
							<div class="span3">Mother Tongue:</div>
							<div class="span9">
								<input type="text"
									class="validate[required]"
									 name="motherTongue" id="motherTongue">
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



						<legend>Contact Info</legend>

						<div class="row-form">
							<div class="span3">
								Address <font color="red">*</font>:
							</div>
							<div class="span9">
								<textarea placeholder="Enter Full Adress" name="address"
									maxlength="300"
									class="validate[required],minSize[10],maxSize[300]"></textarea>
							</div>
						</div>



						<div class="row-form">
							<div class="span3">
								Country <font color="red">*</font>:
							</div>
							<div class="span9" id="country">
								<select style="width: 100%;" name="countryId" id="countryId"
									required="required" onchange="getstateList(this.value);">
									<option value="">--Select Country--</option>
									<c:forEach var="list" items="${countryList}">
										<option value="${list.id}">${list.countryName}</option>
									</c:forEach>
								</select>
							</div>
						</div>


						<div class="row-form">
							<div class="span3">
								State<font color="red">*</font>:
							</div>
							<div class="span9" id="state">
								<select id="state" onchange="getcityList(this.value)"
									required="required" class="validate[required]"
									style="width: 100%;" name="stateId" class="select">
									<option value="">Select State</option>
								</select>
							</div>
						</div>
						<div id="otherdata"></div>
						<div class="row-form">
							<div class="span3">
								City <font color="red">*</font>:
							</div>
							<div class="span9" id="city">
								<select name="cityId" id="cityId" class="validate[required]"
									required="required" style="width: 100%;">
									<option value="">Select City</option>
								</select>
							</div>
						</div>

						<div class="row-form">
							<div class="span3">
								Pincode <font color="red">*</font>:
							</div>
							<div class="span9">
								<input type="text" name="pinCode" id="pinCode" maxlength="6"
									class="validate[required,custom[integer],minSize[6]]">

							</div>
						</div>
						<div class="row-form">
							<div class="span3">
								Mobile <font color="red">*</font>:
							</div>
							<div class="span9">
								<input type="text" name="mobile" id="mobile" maxlength="10"
									class="validate[required,custom[integer],minSize[10]]">
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
								<input type="text" class="validate[custom[email]]" name="email"
									id="email">
							</div>
						</div>
						<div class="row-form">
							<div class="span3">Image :</div>
							<div class="span9">
								<div class="">
									<input type="file" name="imamgeName" accept="image/*"
										style="width: 284px;">
								</div>
							</div>
						</div>
						<div class="span6">
				<div class="block">
					<div class="head">
						<legend>Upload Documents</legend>
						<c:forEach var="list" items="${documentList}" varStatus="loop">
						<div class="row-form">
							<div class="span5" style="width: 113px;">
								<input type="checkbox" id="${loop.index}"
										onclick="getDoc(this.checked,${loop.index})">${list.documentName}
							</div>
							<div class="span2" id="div${loop.index}" style="display: none;">
								<div class="" style="width: 549px;">
									<input type="file" name="documentList[${loop.index}].documentFile"
										style="width: 284px;" id="files${loop.index}"><input type="hidden" name="documentList[${loop.index}].documentCategoryId" value="${list.documentCategoryId}">
								<input type="hidden" name="documentList[${loop.index}].documentName" value="${list.documentName}">
								</div>
							</div>
						</div>
						</c:forEach>

					</div>
				</div>
			</div>
						<div class="row-fluid">
							<div class="span6">
								<div class="block">
									<div class="head"></div>
									<div class="data-fluid">
										<div class="toolbar bottom tar" id="hide">
											<div class="btn-group">
												<button type="submit" class="btn">Create</button>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</form>
</div>
