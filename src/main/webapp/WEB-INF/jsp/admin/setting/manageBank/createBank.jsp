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
		<h1>Create Bank</h1>
		<h3>Manage Banks</h3>
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
		<form action="add_bank" method="get" commandName="bankDTO"
			id="validate">
			<br>
			<table style="width: 350px;margin-left: 247px;">
				<tr>
					<td style="width: 70px;"></td>
					<td><font color="red">${msg}</font></td>
				</tr>
				<tr>
					<td style="width: 70px;">Enter Bank Name:</td>
					<td  style="width: 100px;"><input type="text" name="bankName"></td>
				</tr>
				<tr>
					<td style="width: 50px;">Enter Account NO :</td>
					<td  style="width: 100px;"><input type="text" name="accountNumber"></td>
					

				</tr>

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
		</form>
	</div>

</div>
