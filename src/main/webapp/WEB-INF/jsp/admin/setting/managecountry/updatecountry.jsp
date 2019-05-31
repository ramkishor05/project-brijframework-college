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
		if (!regex1.test($("#country").val())) {
			$("#info").append('<font color="red">Enter only Letters</font>');
			$("#hidebuttn").hide();
		} else {
			$("#info").empty();
			$("#hidebuttn").show();
		}
	}
	function checkCountryName(countryName) {
		$.ajax({
			type : "post",
			url : 'check_country_name',
			data : {
				'countryName' : countryName
			},
			success : function(data) {
				var obj = JSON.parse(data);
				if (obj == 'YES') {
					if ($("#hiddencountryname").val() != countryName) {
						$("#successmsg").show();
						$("#hide").hide()
					}
				} else {
					$("#successmsg").hide();
					$("#hide").show()
				}
			},
			error : function(e) {
				
			}
		});
	}
</script>

<div class="content">
	<div id="content-header" style="height: 150px;">
		<img alt="Show_settings" src="${img_url}/country.jpg"
			style="width: 50px; margin-top: -12px;">
		<h1>Update Country</h1>
		<h3>Manage Countries</h3>
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

	<f:form action="update-country" method="post" commandName="countryDTO">
		<br>

		<table style="width: 800px;">

			<tr>
				<td style="width: 200px;">Country Name:</td>
				<td><input type="hidden" name="hiddencountryname"
					value="${countryName}"> <f:input path="countryName" 
						value="${countryName}" required="required" maxlength="20"
						onkeyup="matchformat(),checkCountryName(this.value);" placeholder="Enter Country Name"
						id="country" style="width: 300px;" />
					<div id="exist"></div></td>
			</tr>
		<%-- 	<tr>
				<td style="width: 200px;">Country Code:</td>
				<td><f:input path="countryCode" required="required"
						maxlength="20" placeholder="Enter Country Code"
						style="width: 300px;" value="${countryCode}" /></td>
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
		<div id="successmsg" style="display: none;">
			<font color="red">This Country Exist</font>
		</div>
	</f:form>
	<div id="info"></div>
</div>
