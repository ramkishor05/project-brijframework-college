<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url value="/style/theme/images" var="imageurl" />
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/img" var="img_url" />
<spring:url value="/css" var="css_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/setting.css">
<script type="text/javascript">
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
		<img alt="Show_settings" src="${img_url}/country.jpg"
			style="width: 50px; margin-top: -12px;">
		<h1>Create Country</h1>
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
	<div id="content">


		<f:form action="add-country" method="post" commandName="countryDTO"
			id="validate">
			<br>

			<table style="width: 800px;">

				<tr>
					<td style="width: 200px;"></td>
					<td><font color="green"><b>${msg}</b></font></td>
				</tr>

				<tr>
					<td style="width: 200px;">Country Name:</td>
					<td><f:input path="countryName" id="id"
							onkeyup="checkCountryName(this.value);" maxlength="20"
							class="validate[required,minSize[2],maxSize[25],custom[onlyLetterSp]]"
							placeholder="Enter Country Name" style="width: 300px;" />
						<div id="exist"></div></td>
				</tr>

				<%-- <tr>
					<td style="width: 200px;">Country Code:</td>
					<td><f:input path="countryCode" maxlength="4"
							class="validate[required,minSize[1],maxSize[4]]"
							placeholder="Enter Country Code" style="width: 300px;" />
						<div id="exist"></div></td>
				</tr>
 --%>
			</table>
			<div class="separator"></div>
			<div class="toolbar bottom tar" id="hide" style="width: 460px;"
				id="hide">
				<div class="btn-group">
					<button class="btn btn-success" id="submitbutton" type="submit">Create</button>
				</div>
			</div>
			<div id="successmsg" style="display: none;">
				<font color="red">This Country Exist</font>
			</div>
		</f:form>
	</div>

</div>
