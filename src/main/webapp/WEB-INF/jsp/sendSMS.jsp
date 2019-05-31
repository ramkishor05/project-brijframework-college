<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:url value="/style/theme/images/back.png" var="backurl" />
<c:url value="/style/theme/images/admission_page_logo.jpg"
	var="StudentAddLogo" />
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/style/datepicks" var="datepicks" />
<link rel="stylesheet" type="text/css" media="all"
	href="${datepicks}/jsDatePick_ltr.min.css" />
<script type="text/javascript" src="${datepicks}/jsDatePick.min.1.3.js"></script>

<script type="text/javascript">
	function sendSMS() {
		var toMobile = $("#toMobile").val();
		var message = $("#message").val();
		$("#msg").append("SMS Send Successfully");
		var a = 'https://rest.nexmo.com/sms/json?api_key=c79bb263&api_secret=0031cc7b&from=NEXMO&to=91';
		var url = a + toMobile + '&text=' + message;
		$.support.cors = true;
		$.ajax({
			url : url,
			type : 'GET',
			success : function(data, status) {
				$("#state").empty();

				var j = JSON.parse(data);
				alert(j);
				if (j.messages.status == 0) {
					$("#msg").append("SMS Send Successfully");
				} else {
					$("#state").append("SMS Could Not Be Send..");
				}

			},
			error : function(error, status) {

			}
		});

	}
</script>


<div class="content">
	<div class="page-header">
		<div class="icon">
			<span class="ico-user"></span>
		</div>
		<h1>
			SMS <small>Send SMS</small>
		</h1>
	</div>
	<div class="row-fluid" style="width: 969px; margin-top: -30px;">
		<div class="span6"
			style="margin-top: 84px; height: 141px; margin-left: 0px; width: 383px;">

			<div id="msg"></div>
			<table>
				<tr>
					<td>Mobile Number</td>
					<td><input type="text" name="toMobile" id="toMobile"></td>
				</tr>
				<tr>
					<td>Message</td>
					<td><textarea name="message" id="message"></textarea></td>
				</tr>
				<tr>
					<td colspan="2" style="text-align: center;"><input
						type="button" onclick="sendSMS()" value="Send"></td>
				</tr>
			</table>
		</div>
	</div>
</div>
