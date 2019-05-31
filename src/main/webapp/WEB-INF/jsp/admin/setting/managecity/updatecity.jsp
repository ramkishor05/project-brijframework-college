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
		if (!regex1.test($("#city").val())) {
			$("#info").append('<font color="red">Enter only Letters</font>');
			$("#hidebuttn").hide();
		} else {
			$("#info").empty();
			$("#hidebuttn").show();
		}
	}
	function checkname(cityname) {
		$('#exist').empty();
		$('#loading').show();
		if($('#hiddencityName').val()!=cityname){
		$
				.ajax({
					type : "post",
					url : 'check_city_name',
					data:{
						'cityName':cityname,
						'countryId':'${COUNTRYID}',
						'stateId':'${STATEID}'
					},		
					success : function(data) {
						$('#loading').hide();
						
						var j = JSON.parse(data);
						if (j != null) {
							$('#hide').hide();
							$("#exist")
									.append(
											'City Name with this city  Already Exist, Choose Another City')
									.css('color', 'red');
						}
						 else {
							$('#hide').show();
						}
					},
					error : function(e) {
						$('#loading').hide();
					}
				});
		}
	}
</script>
<div class="content">
	<div id="content-header" style="height: 150px;">
		<img alt="Show_settings" src="${img_url}/city.jpg"
			style="width: 50px; margin-top: -12px;">
		<h1>Update Cities</h1>
		<h3>Update Cities</h3>
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


	<f:form action="update-city" method="post" commandName="cityDTO">
		<br>

		<table style="width: 800px;">

			<tr>
				<td style="width: 200px;">City Name:</td>
				<td><input type="hidden" id="hiddencityName"
					value="${cityName}"> <f:input path="cityName"
						value="${cityName}" required="required" onkeyup="matchformat(),checkname(this.value);"
						placeholder="Enter City Name" id="city" style="width: 300px;" />
					<div id="exist"></div></td>
			</tr>
		<%-- 	<tr>
				<td style="width: 200px;">City Code:</td>
				<td><f:input path="cityCode" required="required"
						placeholder="Enter City Code" style="width: 300px;"
						value="${cityCode}" /></td>
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
