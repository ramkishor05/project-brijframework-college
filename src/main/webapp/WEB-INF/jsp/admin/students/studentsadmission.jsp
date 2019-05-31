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
		$('#admissionDate').datepick({
			dateFormat : "yyyy-mm-dd"
		});
		$("#dateOfBirth").datepick({
			dateFormat : "yyyy-M-dd"
		});
	});
</script>


<style>
#err {
	color: red;
	font-weight: normal;
	font-size: 15px;
	padding: 2px 8px 0px;
	margin-top: 2px;
	margin-bottom: -2px;
}
</style>


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
	function getRollNo(sectionId) {

		$.ajax({
			type : "post",
			url : 'get-rollno',
			data : {
				'classId' : $('#classId').val(),
				'sectionId' : sectionId,
			},
			success : function(data, status) {
				$('#rollno').val('');
				var j = JSON.parse(data);
				$('#rollno').val(j);
			},
			error : function(e) {

			}
		});
	}

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

	function getsd() {
		var vals = $('#im').val();
		if (vals == "") {
			return true;
		}

		$('#as').empty();
		var a = vals.split(".");
		if ((a[1] == 'jpg') || (a[1] == 'png') || (a[1] == 'JPEG')
				|| (a[1] == 'jpeg')) {

		} else {

			document.getElementById("err").innerHTML = "Only jpg  and png formats are allowed";
			return false;
		}
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
	<div id="content-header">
		<img alt="Show_settings" src="${img_url}/admission_form.jpg"
			style="width: 74px;">
		<h1>Admission Form</h1>
		<h3>Students Admission</h3>
		<div id="app-back-button">
			<a href="home"><img alt="Back" border="0"
				src="${img_url}/home.png" title="Home"
				style="margin-top: -6px; height: 40px; width: 40px;"></a> <a
				href="#" onclick="javascript:location.reload(true);"><img
				alt="Back" border="0" src="${img_url}/refresh.png" title="Refresh"
				style="margin-top: -6px; height: 40px; width: 40px;"></a> <a
				href="#" onclick="history.back(); return false;"><img alt="Back"
				border="0" src="${img_url}/back.png" title="Back"
				style="margin-top: -6px; height: 40px; width: 40px;"></a>
		</div>
	</div>
	<f:form id="validate" method="POST" name="myForm"
		onsubmit="return getsd();" enctype="multipart/form-data"
		action="ragistration" modelAttribute="StudentDetails">
		<div class="row-fluid">

			<div class="span6">

				<div class="block">
					<div class="head"></div>
					<div class="data-fluid">
						<div class="row-form">
							<div class="span3">
								Admission No:<font color="red"></font>
							</div>
							<div class="span9">
								<input type="text" name="admissionNo"
									placeholder="Enter Admission No.(Compulsary)"
									value="${studentAdmissionNum}">
							</div>
						</div>
						<div class="row-form">
							<div class="span3">
								L.F No. <font color="red"></font>:
							</div>
							<div class="span9">
								<input type="text" name="lfno" id="lfno" value="${lfNO}">
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
									required="required">
							</div>
						</div>
						<div class="row-form">
							<div class="span3">
								Middle Name:<font color="red"></font>
							</div>
							<div class="span9">
								<input type="text" placeholder="(Optional)" name="middleName"
									id="secondName">
							</div>
						</div>
						<div class="row-form">
							<div class="span3">
								Last Name:<font color="red"></font>
							</div>
							<div class="span9">
								<input type="text" name="lastName" id="lastName"
									placeholder="(Optional)">
							</div>
						</div>
						<div class="row-form">
							<div class="span3">
								Father Name:<font color="red">*</font>
							</div>
							<div class="span9">
								<input type="text" name="fatherName" id="lastName">
							</div>
						</div>
						<div class="row-form">
							<div class="span3">
								Mother Name:<font color="red">*</font>
							</div>
							<div class="span9">
								<input type="text" name="motherName" id="lastName">
							</div>
						</div>
						<div class="row-form">
							<div class="span3">
								Guardian's Name:
								<%-- <font color="red">*</font> --%>
							</div>
							<div class="span9">
								<input type="text" name="guardianName" id="guardianName">
							</div>
						</div>
						<div class="row-form">
							<div class="span3">
								Date Of Birth<font color="red">*</font>:
							</div>
							<div class="span9">
								<input type="text" name="dateOfBirth" id="dateOfBirth"
									readonly="readonly" class="validate[required]">
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
						<div class="row-form">
							<div class="span4">
								Admission Date<font color="red">*</font>:
							</div>
							<div class="span8">
								<input type="text" name="admissionDate" id="admissionDate"
									readonly="readonly" class="validate[required]">
							</div>
						</div>
						<div class="row-form">
							<div class="span3">
								Student Id <font color="red"></font>:
							</div>
							<div class="span9">
								<input type="text" name="studentId" id="studentId"
									readonly="readonly" value="${studentId}"
									style="width: 319px; margin-left: 41px;">
							</div>
						</div>
						<div id="wizard_validate-titles" class="stepy-titles"></div>

						<!-- <fieldset title="Step 1" class="step" id="wizard_validate-step-0"> -->
						<legend>Institutional Info</legend>

						<div class="row-form">
							<div class="span3">
								S R No. <font color="red"></font>:
							</div>
							<div class="span9">
								<input type="text" placeholder="(Optional)" name="srno"
									id="srno">
							</div>
						</div>
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
											<c:when test="${current.sessionId==list.sessionId}">
												<option selected="selected" value="${list.sessionId}">${list.sessionDuration}</option>
											</c:when>
											<c:otherwise>
												<option value="${list.sessionId}">${list.sessionDuration}</option>
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
									title="Specify the class of the student"
									onchange="getSectionList(this.value);"
									data-original-title="Specifyclass">

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
							<div class="span9">
								<select id="sectionId" class="validate[required]"
									name="sectionId" class="select"
									onchange="getRollNo(this.value);">
									<option value="">Select a Section</option>
								</select>
							</div>
						</div>
						<div class="row-form">
							<div class="span3">
								Roll No.
								<%-- <font color="red">*</font> --%>
								:
							</div>
							<div class="span9">
								<input type="text" name="rollno" id="rollno"
									class="validate[custom[integer],minSize[1],maxSize[10]]">
							</div>
						</div>
						<div class="row-form">
							<div class="span3">
								Category <font color="red"></font>:
							</div>
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
							<div class="span3">
								Religion<font color="red"></font>:
							</div>
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
					<div class="head">
						<legend>Contact Info</legend>
						<div class="row-form">
							<div class="span3">
								Address <font color="red">*</font>:
							</div>
							<div class="span9">
								<f:textarea placeholder="Enter Address" path="addressLine1" />
							</div>
						</div>

						<div class="row-form">
							<div class="span3">
								Country <font color="red">*</font>:
							</div>
							<div class="span9" id="country">
								<f:select path="countryId"
									class="validate[required] form-control input-sm" id="countryId"
									x-data-toggle-x="tooltip" title="Specify the country"
									onchange="getstateList(this.value)"
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
								<f:select path="stateId"
									class="validate[required] form-control input-sm"
									onchange="getcityList(this.value)" id="state"
									x-data-toggle-x="tooltip" title="Specify the state"
									data-original-title="Specify your state">
									<option value="">Select State</option>
								</f:select>
							</div>
						</div>
						<div id="otherdata"></div>
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
							<div class="span3">
								Pincode <font color="red"></font>:
							</div>
							<div class="span9">
								<input type="text" placeholder="(Optional)" name="pinCode"
									id="pinCode">
							</div>
						</div>

						<div class="row-form">
							<div class="span3">Phone:</div>
							<div class="span9">
								<input type="text" name="phone" id="Phone"
									class="validate[custom[integer]]" placeholder="(Optional)">
							</div>
						</div>

						<div class="row-form">
							<div class="span3">
								Mobile <font color="red">*</font>:
							</div>
							<div class="span2">
								<input type="text" readonly="readonly" value="+91">
							</div>
							<div class="span7">
								<input type="text" name="mobile" id="mobile" maxlength="10"
									class="validate[custom[integer]]"
									placeholder="Enter 10 Digit Number">
							</div>
						</div>


						<div class="row-form">
							<div class="span3">
								E-mail <font color="red"></font>:
							</div>
							<div class="span9">
								<input type="text" name="email" id="email"
									class="validate[custom[email]]" placeholder="(Optional)">
								<span class="bottom"></span>
							</div>
						</div>
						<div id="wizard_validate-titles" class="stepy-titles"></div>
						<legend>Previous School Details</legend>
						<div class="row-form">
							<div class="span3">School Name:</div>
							<div class="span9">
								<input type="text" name="schoolName" id="schoolName">
							</div>
						</div>
						<div class="row-form">
							<div class="span3">Address:</div>
							<div class="span9">
								<input type="text" name="schoolAddress" id="schoolAddress">
							</div>
						</div>
						<div class="row-form">
							<div class="span3">Phone:</div>
							<div class="span9">
								<input type="text" name="schoolPhone" id="schoolPhone"
									class="validate[custom[integer]]">
							</div>
						</div>

						<div class="toolbar bottom tar" id="hide">
							<div class="btn-group">
								<button type="submit" class="btn">Create</button>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="span6">
				<div class="block">
					<div class="head">
						<legend>Upload Family Photographs</legend>
						<div class="row-form">
							<div class="span5">
								<label>Student's Photo:</label>
							</div>
							<div class="span2">
								<div class="" style="width: 549px;">
									<input type="file" name="photo" accept="image/*" id="im"
										style="width: 284px;"> <span id="err"
										style="margin-top: 11px; margin-bottom: -24px; margin-left: -99px;"></span>
								</div>
							</div>
						</div>
						<div class="row-form">
							<div class="span5">
								<label>Father's Photo:</label>
							</div>
							<div class="span2">
								<div class="" style="width: 549px;">
									<input type="file" name="parentphoto1" accept="image/*"
										id="im1" style="width: 284px;"> <span id="err"></span>
								</div>
							</div>
						</div>
						<div class="row-form">
							<div class="span5">
								<label>Mother's Photo:</label>
							</div>
							<div class="span2">
								<div class="" style="width: 549px;">
									<input type="file" name="parentphoto2" accept="image/*" id="im"
										style="width: 284px;"> <span id="err"></span>
								</div>
							</div>
						</div>
						<div class="row-form">
							<div class="span5">
								<label>Guardian's Photo:</label>
							</div>
							<div class="span2">
								<div class="" style="width: 549px;">
									<input type="file" name="parentphoto3" accept="image/*" id="im"
										style="width: 284px;"> <span id="err"></span>
								</div>
							</div>
						</div>

					</div>
				</div>
			</div>
			<div class="span6">
				<div class="block">
					<div class="head">
						<legend>Upload Documents</legend>
						<c:forEach var="list" items="${documentList}" varStatus="loop">
							<div class="row-form">
								<div class="span5">
									<input type="checkbox" id="${loop.index}"
										onclick="getDoc(this.checked,${loop.index})">
									${list.documentName}
								</div>
								<div class="span2" id="div${loop.index}" style="display: none;">
									<div class="" style="width: 549px;">
										<input type="file"
											name="documentList[${loop.index}].documentFile"
											style="width: 284px;" id="files${loop.index}"><input
											type="hidden"
											name="documentList[${loop.index}].documentCategoryId"
											value="${list.documentCategoryId}"><input
											type="hidden" name="documentList[${loop.index}].documentName"
											value="${list.documentName}">
									</div>
								</div>
							</div>
						</c:forEach>

					</div>
				</div>
			</div>
	</f:form>
</div>
