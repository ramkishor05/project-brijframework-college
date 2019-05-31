<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url value="/style/theme/images" var="imageurl" />
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/img" var="img_url" />
<spring:url value="/css" var="css_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/setting.css">

<script type="text/javascript">
	function getSectionList(id) {
		$("#classmsg").empty();
		$("#firstName").empty();
		$("#sectionId").empty();
		$("#studentId").val('');
		$.ajax({
			type : "post",
			url : 'getsectionlist/' + id,
			success : function(data, status) {

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
	function getStudentsList() {
		var classId = $("#class").val();
		var sectionId = $("#sectionId").val();
		$("#firstName").empty();
		$("#studentId").val('');
		$.ajax({
			type : "post",
			url : 'getStudentsbyclasssection/' + classId + '/' + sectionId,
			success : function(data, status) {

				var j = JSON.parse(data);
				var content = '<option value="">Select Student</option>';
				for (var i = 0; i < j.length; i++) {
					content += '<option value='+j[i].admissionNo+'>'
							+ j[i].fullName + '</option>';

				}
				$("#firstName").append(content);

			},
			error : function(e) {

			}
		});
	}
	function getStudentdetails(id) {
		$
				.ajax({
					type : "post",
					url : 'getstudentsdata/' + id,
					success : function(data, status) {
						$("#Student").empty();
						var j = JSON.parse(data);
						var st = '';
						st = '<div   id="box" style="border: 1px solid; border-radius: 10px; height: 124px; width: 541px; margin-left: -310px; margin-top: -4px;">'
						st += '<table style="width: 530px; margin-left: 10px; margin-top: 7px;"><tr><td><span><font size="2"><b>Name :</b></td><td colspan="3" ><span><font size="2">'
								+ j.firstName
								+ '\t'
								+ j.middleName
								+ '\t'
								+ j.lastName
								+ '</font></span></td></tr><tr><td><span><font size="2"><b>Father Name:</font></span></b></td><td style="width: 369px;"colspan="3"><span><font size="2">'
								+ j.fatherName
								+ '</font></span></td></tr><tr><td><span><font size="2"><b>Mother Name:</font></span></b></td><td style="width: 369px;"colspan="3"><span><font size="2">'
								+ j.motherName
								+ '</font></span></td></tr><tr><td><span><font size="2"><b>Class:</font></span></b></td><td ><span><font size="2">'
								+ j.className
								+ '</font></span></td><td style="width: 79px;"><span><font size="2"><b>Section:</font></span></b></td><td style="width: 140px;"><span><font size="2">'
								+ j.sectionName
								+ '</font></span></td></tr><tr><td><span><font size="2"><b>Mobile No:</font></span></b></td><td colspan="3"><span><font size="2">'
								+ j.mobile
								+ '</font></span></td></tr></table></div>';

						$("#Student").append(st);
						$("#studentId").val(j.studentId);
						$("#stu").val(j.studentId);
						getDocumentDetails(j.studentId);

					},
					error : function(e) {

					}
				});

	}
	function getDocumentDetails(id)

	{
		$("#documents").empty();
		$
				.ajax({
					type : "post",
					url : 'getDocumentforStudent',
					data : {
						'id' : id,
					},

					success : function(data, status) {

						var j = JSON.parse(data);

						if (j.length == 0) {
							var duedates = '<span><font color="red">No record found</font></color>';
						} else {
							$("#lengths").val(j.length);
							var duedates = '<table cellpadding="0" cellspacing="0" width="100%" class="table"><thead>'
									+ '<tr><th>Document</th><th>Upload</th><th>Name</th><th>Uploaded on</th><th>Download</th></tr></thead><tbody>'
							$
									.each(
											j,
											function(key, value) {

												duedates += '<tr><td>'
														+ value.documentName
														+ '<input type="hidden" name="documentList['+key+'].documentName" value="'+value.documentName+'"></td><td>'
														+ '<input type="file" name="documentList['+key+'].documentFile" id="documentFile'+[key]+'"><input type="hidden" name="documentList['+key+'].documentCategoryId" value="'+value.documentCategoryId+'">'
														+ '</td><td>'
														+ value.fileName
														+ '</td><td>'
														+ value.uploadedOn
														+ '</td>';
												if (value.studentDocumentId == 0) {
													duedates += '<td>-</td></tr>';
												} else {
													duedates += '<td><a href="document-download?id='
															+ value.fileName
															+ '"><span'
							+' class="label label-important">Download</span></a></td></tr>';
												}

											});

							duedates += '</tbody></table><div class="btn-group"><button type="submit" class="btn"style="left: 459px; top: 20px;">Save</button></div>';

						}
						$("#documents").append(duedates);

					},
					error : function(e) {

					}
				});

	}

	function getStudentDatabyId(studentId) {

		$.ajax({
			type : 'post',
			url : 'get-studentdatabyId',
			data : {

				'studentId' : studentId,
			},
			success : function(data, status) {
				var j = JSON.parse(data);
				if (j.length == 0) {

				} else {

					getStudentdetails(j.admissionNo);

				}

			},

			error : function(data, status) {

			}
		});

	}
	function validate() {
		var i = $("#lengths").val();
		var flag = false;
		for (var j = 0; j < i; j++) {
			if ($("#documentFile" + j).val() == '') {
			} else {
				flag = true;
				break;
			}

		}
		if (flag == false) {
			alert("Upload document before saving");
			return false;
		} else
			return true;

	}
</script>

<div class="content">
	<div id="content-header" style="height: 150px;">
		<img alt="Show_settings" src="${img_url}/document.jpg"
			style="width: 50px; margin-top: -12px;">
		<h1>Manage Student Documents</h1>
		<h3>Upload/Download Student Documents</h3>
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


	<br>

	<div class="row-fluid">
		<div class="span2" style="width: 605px;">

			<div class="block" style="left: -188px;">
				<table
					style="width: 604px; height: 0px; margin-left: 231px; margin-top: 0px;">
					<tr>
						<td style="width: 200px;"><span id="s">Student Id<font
								color="red">*</font></span></td>
						<td><input type="text" name="studentIds" id="studentId"
							class="validate[required]"
							oninput="getStudentDatabyId(this.value);" style="width: 252px;"></td>
						<td></td>
					</tr>
					<tr>
						<td style="width: 200px;"><span id="s">Class<font
								color="red">*</font></span></td>
						<td><select id="class" onchange="getSectionList(this.value);"
							style="width: 250px;" name="classId" class="select">
								<option value="">Select a class</option>
								<c:forEach var="list" items="${classList}">
									<option value="${list.classId}">${list.className}</option>
								</c:forEach>
						</select></td>
						<td><div id="classmsg"></div></td>
					</tr>
					<tr>
						<td style="width: 200px;">Section<font color="red">*</font></td>
						<td><select id="sectionId" style="width: 250px;"
							onchange="getStudentsList();" name="sectionId" class="select"
							required="required">
								<option value="">Select a Section</option>
						</select></td>
						<td><div id="sectionmsg"></div></td>
					</tr>
					<tr>
						<td style="width: 72px;"><span id="n">Name:<font
								color="red">*</font></span></td>
						<td><select id="firstName" style="width: 250px;"
							name="firstName" class="select"
							onchange=getStudentdetails(this.value); required="required">
								<option value="">Select a Student</option>
						</select> <input type="hidden" id="lengths">
							<div id="exist"></div></td>
						<td><div id="namemsg"></div></td>
					</tr>
				</table>

			</div>



		</div>
		<div class="span5">
			<div class="block" style="margin-left: 192px;">
				<div id="Student"></div>
			</div>

		</div>
		<hr>
		<div class="span8" id="employeeDetails"
			style="width: 718px; margin-left: -42px; height: 164px; float: right;"></div>
	</div>
	<span><font color="green">${msg}</font></span>
	<div class="row-fluid" style="margin-top: -173px;">
		<div class="span12">
			<div class="block">
				<div class="head blue"
					style="border-top-width: 10px; margin-top: 79px;">
					<div class="icon">
						<span class="ico-pen-2"></span>
					</div>
					<h2>Document Details</h2>
				</div>
				<f:form commandName="studentDocumentDTO" id="submitform"
					action="upload-studentDocuments" method="post"
					enctype="multipart/form-data" onsubmit="return validate();">
					<input type="hidden" name="studentId" id="stu" value="">

					<div class="data-fluid" id="documents"></div>
				</f:form>
			</div>
		</div>
	</div>

</div>