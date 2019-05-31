<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url value="/style/theme/images" var="imageurl" />
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/img" var="img_url" />
<spring:url value="/css" var="css_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/setting.css">
<script>
	$(function() {
		$("#startDate").datepicker();
	});

	$(function() {
		$("#endDate").datepicker();
	});
	function hidemsg(){
		$(".successmsg").remove();
	}
	function getstate(countryId) {
		hidemsg();
		$("#stateId").empty();
		$.ajax({
			type : "post",
			url : 'getstate',
			data : {
				"countryId" : countryId
			},
			success : function(data) {
				var obj = JSON.parse(data);
				var content = '<option value="">Select a state</option>';
				$.each(obj, function(key, value) {
					content += '<option value="'+value.id+'">'
							+ value.stateName + '</option>';
				});
				$("#stateId").append(content);
			},
			error : function(e) {
				$('#loading').hide();
			}
		});
	}
	function checkname(cityname) {
		hidemsg();
		$('#exist').empty();
		$('#loading').show();
		$
				.ajax({
					type : "post",
					url : 'check_city_name',
					data:{
						'cityName':cityname,
						'countryId':$("#courseId").val(),
						'stateId':$("#stateId").val()
					},		
					success : function(data) {
						$('#loading').hide();
						$('#exist').empty();
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
	function matchformat() {
		hidemsg();
		$("#info").empty();
		var regex1 = /^[a-zA-Z]*[a-zA-Z ]+$/;
		if (!regex1.test($("#cityid").val())) {
			$("#info").append('<font color="red">Enter only Letters</font>');
			$("#hidebuttn").hide();
		} else {
			$("#info").empty();
			$("#hidebuttn").show();
		}
	}
</script>
<div class="content">
	<div id="content-header" style="height: 150px;">
		<img alt="Show_settings" src="${img_url}/city.jpg"
			style="width: 50px; margin-top: -12px;">
		<h1>Create City</h1>
		<h3>Manage Cities</h3>
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
	<c:if test="${! empty msg}">
	<div class="successmsg">${msg}</div>
	</c:if>
	<br>
	<f:form action="add-city" method="post" commandName="cityDTO">
		<br>
		<table style="width: 800px;">
			<tr>
				<td style="width: 200px;">Select a Country:</td>
				<td><f:select path="countryId" style="width: 300px;"
						required="required" id="courseId" onchange="getstate(this.value);">
						<option value="">Select a country</option>
						<c:forEach var="list" items="${countrylist}">
							<f:option value="${list.id}"> ${list.countryName} </f:option>
						</c:forEach>
					</f:select></td>
			</tr>
			<tr>
				<td style="width: 200px;">Select a State:</td>
				<td><f:select path="stateId" style="width: 300px;" id="stateId"
						required="required">
						<option value="">Select a state</option>
					</f:select></td>
			</tr>
			<tr>
				<td style="width: 200px;">City Name:</td>

				<td><f:input path="cityName" id="cityid"
						onkeyup="matchformat(),checkname(this.value);" maxlength="20" required="required"
						placeholder="Enter City Name" style="width: 300px;" />
			</tr>
		<%-- 	<tr>
				<td style="width: 200px;">City Code:</td>

				<td><f:input path="cityCode" id="id" maxlength="4"
						required="required" placeholder="Enter city Code"
						style="width: 300px;" />
					<div id="exist"></div></td>

			</tr> --%>
		</table>
		<div class="separator"></div>
		<div class="toolbar bottom tar" id="hide" style="width: 484px;"
			id="hide">
			<div id="hidebuttn">
				<div class="btn-group">
					<button class="btn btn-success" style="float: right;" type="submit">Create</button>
				</div>
			</div>
		</div>
	</f:form>
	<div id="info"></div>
</div>
