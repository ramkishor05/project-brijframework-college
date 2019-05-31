<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
 <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 <%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:url value="/style/theme/images" var="imageurl" />
<spring:url value="/img" var="img_url" />
<spring:url value="/css" var="css_url" />
<spring:url value="/js" var="js_url" />
<script type="text/javascript" src="${js_url }/menu.js"></script>
<link rel="stylesheet" type="text/css" href="${css_url}/setting.css"/>  
<script>
function addButton()
{
	$('#btn-group1').append('<input type="submit" class="btn btn-success" id="submitbutton" value="Update">');
}
</script>
<div class="content">
	<div id="content-header" style="height: 150px;">
		<img alt="Show_settings" src="${img_url}/library.jpg"
			style="width: 50px; margin-top: -12px;">
		<h1>Register School</h1>
		<h3>School Registration</h3>
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
	<c:choose>
	<c:when test="${empty schoolRegistration.schoolRegistrationId }">
	<div id="content">

		<f:form method="POST" commandName="schoolRegistration" action="register-school"
			id="FormID" enctype="multipart/form-data">
			<br>
			<table style="width: 800px;">
				<tr>
					<td style="width: 200px;"></td>
					<td><font color="red">${msg}</font></td>
				</tr>
				
				<tr>
					<td style="width: 200px;">School Name</td>
					<td><f:input path="schoolName" id="schoolName"
							class="validate[required]"
							maxlength="20" placeholder="Enter School Name"
							style="width: 300px;" />
						<div id="exist"></div></td>
				</tr>
				<tr>
					<td style="width: 200px;">School Address</td>
					<td><f:textarea path="schoolAddress" id="schoolAddress"
							class="validate[required]"
							placeholder="Enter School Address" style="width: 300px;" ></f:textarea>
						<div id="exist"></div></td>
				</tr>
			<tr>
					<td style="width: 200px;">School Logo:</td>
					<td><f:input type="file" path="schoolLogo" id="schoolLogo"
							 style="width: 300px;" accept="image/*" />
						<div id="exist"></div></td>
				</tr>
				<tr>
					<td style="width: 200px;">Contact No:</td>
					<td><f:input path="contactNo" id="contactNo" 
							class="validate[required,custom[number],max[10],min[10]]"
							placeholder="Enter Contact No" style="width: 300px;" />
						<div id="exist"></div></td>
				</tr>
			</table>
			<div class="separator"></div>
			<div class="toolbar bottom tar" id="hide" style="width: 460px;"
				id="hide">
				<div class="btn-group">
					<input class="btn btn-success" id="submitbutton" type="submit" value="Create">
				</div>
			</div>
			<div style="float: right; margin-top: -230px; margin-right: 200px;">
			<img src="${img_url}/no-image.png" style="height:150px;width:200px;border:2px solid black;">
			</div>
			<div id="successmsg">
				<font color="red">${message}</font>
			</div>
		</f:form>
	</div>
	</c:when>
	<c:otherwise>
	<div id="content1">
		<f:form method="POST" commandName="schoolRegistration" action="update-registered-school"
			id="FormID" enctype="multipart/form-data">
			<br>
			<table style="width: 800px;">
				<tr>
					<td style="width: 200px;"></td>
					<td><font color="red">${msg}</font></td>
				</tr>
				<tr>
					<td style="width: 200px;"></td>
					<td><f:hidden path="schoolRegistrationId"/></td>
				</tr>
				<tr>
					<td style="width: 200px;">School Name</td>
					<td><f:input path="schoolName" id="schoolName"
							class="validate[required]"
							maxlength="20" placeholder="Enter School Name"
							style="width: 300px;" readonly="readonly"/>
						<div id="exist"></div></td>
				</tr>
				<tr>
					<td style="width: 200px;">School Address</td>
					<td><f:textarea path="schoolAddress" id="schoolAddress"
							class="validate[required]"
							placeholder="Enter School Address" style="width: 300px;" readonly="readonly"></f:textarea>
						<div id="exist"></div></td>
				</tr>
			<tr>
					<td style="width: 200px;">School Logo:</td>
					<td><f:input type="file" path="schoolLogo" id="schoolLogo"
							 style="width: 300px;" accept="image/*" readonly="readonly"/>
						<div id="exist"></div></td>
				</tr>
				<tr>
					<td style="width: 200px;">Contact No:</td>
					<td><f:input path="contactNo" id="contactNo" 
							class="validate[required,custom[number],max[10],min[10]]"
							placeholder="Enter Contact No" style="width: 300px;" readonly="readonly" />
						<div id="exist"></div></td>
				</tr>
			</table>
			<div class="separator"></div>
			<div class="toolbar bottom tar" id="hide" style="width: 460px;">
				<div class="btn-group" id="btn-group1">
				</div>
			</div>
			<div id="successmsg">
				<font color="red">${message}</font>
			</div>
		</f:form>
		<div style="float: right; margin-top: -230px; margin-right: 300px;">
		<c:choose>
		<c:when test="${empty schoolRegistration.schoolLogoName }">
			<img src="${img_url}/no-image.png" style="height:150px;width:200px;border:2px solid black;">
			</c:when>
			<c:otherwise>
			<img src="${img_url}/${schoolRegistration.schoolLogoName}" style="height:150px;width:200px;border:2px solid black;">
			</c:otherwise>
			</c:choose>
			</div >
		<div class="separator"></div>
			<div class="toolbar bottom tar" id="hide" style="width: 460px;">
				<div class="btn-group">
				<a href="delete-registered-school?id=${ schoolRegistration.schoolRegistrationId}">
					Delete<img class="btn btn-success" id="submitbutton" alt="Delete" />
					</a>
				</div>
				<div class="btn-group">
					<input class="btn btn-success" id="submitbutton" type="button" value="Edit" onclick="addButton();">
				</div>
			</div>
			
	</div>
	</c:otherwise>
	</c:choose>

</div>
