<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url value="/style/theme/images" var="imageurl" />
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/img" var="img" />
<spring:url value="/img" var="img_url" />
<spring:url value="/css" var="css_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/setting.css">
<spring:url value="/style" var="style_url" />
<script type="text/javascript">

function getDocument(id)

{
	$("#documents").empty();
	$
			.ajax({
				type : "post",
				url : 'getDocumentforEmployees',
				data : {
					'id' : id,
				},

				success : function(data, status) {

					var obj = JSON.parse(data);
                    var j=obj.documentList;
					if (j.length == 0) {
						var duedates = '<span><font color="red">No record found</font></color>';
					} else {
						$("#lengths").val(j.length);
						$("#employeeDetails").empty();
						var employeeDetail = '<div style="text-align: center; height: 33px; background-color: rgb(238, 238, 238); color: rgb(0, 136, 204); border: 1px solid lightgray; border-top-left-radius: 10px; border-top-right-radius: 10px; margin-top: 3px; width: 570px;">'
								+ '<a href="show-employee-details?id='
								+ obj.employeeDTO.id
								+ '">'
								+ obj.employeeDTO.firstName
								+ '&nbsp;'
								+ obj.employeeDTO.lastName
								+ '</a></div><div class="row-fluid"  style="border: 1px solid lightgray; height: 113px; border-bottom-left-radius: 10px; border-bottom-right-radius: 10px;"><div class="span6">';
						employeeDetail += '<div class="block"><div class="data-fluid"><div class="row-form"><div class="span5">Mobile No :</div>';
						employeeDetail += '<div class="span7">'
								+ obj.employeeDTO.mobile
								+ '</div></div></div><div class="data-fluid"><div class="row-form">';
						employeeDetail += '<div class="span5">Id :</div><div class="span7">'
								+ obj.employeeDTO.id
								+ '</div></div></div></div></div>';
						employeeDetail += '<div class="span6"><div class="block"><div class="data-fluid"><div class="row-form" style="padding-top: 0px;">';
						employeeDetail += '<div class="span3" style="width: 138px; height: 113px;float:right">'
								+ '<img src="${style_url}/employeeImages/'+obj.employeeDTO.imagename+'"'
					+'style="width: 127px; height: 113px;">'
								+ '</div></div></div></div>';
						$("#employeeDetails").append(employeeDetail);

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
											if (value.employeeDocumentId == 0) {
												duedates += '<td>-</td></tr>';
											} else {
												duedates += '<td><a href="empdocument-download?id='
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
	<f:form commandName="employeeDocumentDTO" id="submitform"
					action="upload-employeeDocuments" method="post"
					enctype="multipart/form-data" onsubmit="return validate();">
	<div id="searches" style="height: auto; width: auto;">
		<br> <br> <br>
		
		<table>
			<tr>
				<td style="width: 200px;">Select Teacher</td>
				<td><select id="employeeId" class="validate[required]"
					style="width: 250px;" onchange="getDocument(this.value);"
					name="employeeId" class="select">
						<option value="">Select a Teacher</option>
						<c:forEach var="list" items="${TeacherList}">
							<option value="${list.id}">${list.fullName}</option>
						</c:forEach>
				</select></td>
			</tr>
		</table>
	</div>
		<div class="span8" id="employeeDetails"
				style="width: 569px; margin-left: -42px; height: 164px; float: right; margin-top: -67px;"></div>
		<hr>
	<br>
	<span><font color="green">${msg}</font></span>
	<div class="row-fluid">
		<div class="span12">
			<div class="block">
				<div class="head blue"
					style="border-top-width: 10px; margin-top: 79px;">
					<div class="icon">
						<span class="ico-pen-2"></span>
					</div>
					<h2>Document Details</h2>
				</div>
					<div class="data-fluid" id="documents"></div>
				
			</div>
		</div>
	</div>
	</f:form>
</div>