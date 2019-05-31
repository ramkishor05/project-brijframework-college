<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url value="/style/theme/images" var="imageurl" />
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/img" var="img_url" />
<spring:url value="/css" var="css_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/setting.css">
<script type="text/javascript">
	function checkStateName(stateName) {
		$.ajax({
			type : "post",
			url : 'check_state_name',
			data : {
				'stateName' : stateName,
				'countryId' : $("#countryId").val()
			},
			success : function(data) {
				var obj = JSON.parse(data);
				if (obj == 'YES') {
					$("#successmsg").show();
					$("#submitbutton").hide()
				} else {
					$("#successmsg").hide();
					$("#submitbutton").show()
				}
			},
			error : function(e) {
				
			}
		});
	}
</script>
<div class="content">
	<div id="content-header" style="height: 150px;">
		<img alt="Show_settings" src="${img_url}/state.jpg"
			style="width: 50px; margin-top: -12px;">
		<h1>Create State</h1>
		<h3>Manage States</h3>
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
	<div id="content">
		<f:form action="add-state" method="post" commandName="stateDTO"
			id="validate">
			<br>
			<table style="width: 800px;">
				<tr>
					<td style="width: 200px;"></td>
					<td><font color="red">${msg}</font></td>
				</tr>
				<tr>
					<td style="width: 200px;">Select a Country:</td>
					<td><f:select path="countryId" style="width: 300px;"
							required="required" id="countryId">
							<option value="">Select a country</option>
							<c:forEach var="list" items="${countrylist}">
								<f:option value="${list.id}"> ${list.countryName} </f:option>
							</c:forEach>
						</f:select></td>
				</tr>
				<tr>
					<td style="width: 200px;">State Name:</td>
					<td><f:input path="stateName" id="stateName"
							onkeyup="checkStateName(this.value);"
							class="validate[required,minSize[3],maxSize[20],custom[onlyLetterSp]]"
							maxlength="20" placeholder="Enter State Name"
							style="width: 300px;" />
						<div id="exist"></div></td>
				</tr>
				<%-- <tr>
					<td style="width: 200px;">State Code:</td>
					<td><f:input path="stateCode" maxlength="4"
							class="validate[required,minSize[2],maxSize[6]]"
							placeholder="Enter State Code" style="width: 300px;" />
						<div id="exist"></div></td>
				</tr> --%>
			</table>
			<div class="separator"></div>
			<div class="toolbar bottom tar" id="hide" style="width: 460px;"
				id="hide">
				<div class="btn-group">
					<button class="btn btn-success" id="submitbutton" type="submit">Create</button>
				</div>
			</div>
			<div id="successmsg" style="display: none;">
				<font color="red">This State Exist</font>
			</div>
		</f:form>
	</div>

</div>
