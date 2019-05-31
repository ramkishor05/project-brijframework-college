<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url value="/style/theme/images" var="imageurl" />
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/img" var="img_url" />
<spring:url value="/css" var="css_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/setting.css">
<script type="text/javascript">
	function matchformat() {
		$("#info").empty();
		var regex1 = /^[a-zA-Z]*[a-zA-Z ]+$/;
		if (!regex1.test($("#state").val())) {
			$("#info").append('<font color="red">Enter only Letters</font>');
			$("#hidebuttn").hide();
		} else {
			$("#info").empty();
			$("#hidebuttn").show();
		}
	}
	function checkStateName(stateName) {
		if ($("#hiddenstateName").val() != stateName) {
			$.ajax({
				type : "post",
				url : 'check_state_name',
				data : {
					'stateName' : stateName,
					'countryId' : '${countryId}'
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
	}
</script>
<div class="content">
	<div id="content-header" style="height: 150px;">
		<img alt="Show_settings" src="${img_url}/state.jpg"
			style="width: 50px; margin-top: -12px;">
		<h1>Update States</h1>
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
	<f:form action="updatestate" method="post" commandName="stateDTO">
		<br>
		<table style="width: 800px;">
			<tr>
				<td style="width: 200px;">State Name:</td>
				<td><input type="hidden" id="hiddenstateName"
					value="${stateName}"> <f:input path="stateName"
						value="${stateName}" id="state" required="required"
						onkeyup="matchformat(),checkStateName(this.value);"
						placeholder="Enter State Name" maxlength="20"
						style="width: 300px;" />
					<div id="exist"></div></td>
			</tr>
			<%-- <tr>
				<td style="width: 200px;">State Code:</td>
				<td><f:input path="stateCode" maxlength="4" required="required"
						placeholder="Enter State Code" style="width: 300px;"
						value="${stateCode}" /></td>
			</tr> --%>
		</table>
		<div class="separator"></div>
		<f:hidden path="id" value="${id}" />
		<div id="hidebuttn">
			<button type="submit" id="hide"
				class="btn btn-icon btn-primary glyphicons no-js play"
				style="position: relative; left: 428px; width: 75px; top: 0px; margin-top: 20px;">
				<i></i>Update
			</button>
		</div>
	</f:form>
	<div id="info"></div>
</div>
