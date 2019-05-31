<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<spring:url value="/" var="baseurl"></spring:url>
<spring:url value="/style/datepicks" var="datepicks" />
<spring:url value="/img" var="img_url" />
<spring:url value="/style" var="style_url" />
<spring:url value="/css" var="css_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/setting.css">
<link href="${datepicks}/jquery.datepick.css" rel="stylesheet">
<script src="${datepicks}/jquery.plugin.js"></script>
<script src="${datepicks}/jquery.datepick.js"></script>

<script>
	$(function() {
		$('#dateOfWithdrawl').datepick({
			dateFormat : "yyyy-mm-dd"
		});
	});
	function goBackAndRefresh() {
		createCookie('auto-refresh', 'YES');
		history.go(-1);
	}
	window.onload = function() {
		if (readCookie('auto-refresh') === 'YES') {
			deleteCookie('auto-refresh');
			window.location = window.location;
		}
	};
	function getSubmission()
	{
		$("#formsId").submit();
		document.location.href="student-details";
	}
	
</script>
<div id="content_wrapper">
	<div id="side_bar">

		<div id="sidebar_news_area"></div>
	</div>
	<div id="content">
		<div id="content-header">
			<img alt="Show_settings" src="${img_url}/tc.jpg"
				style="width: 74px; height: 74px;">
			<h1>Generate TC</h1>
			<h3>Details for Issuing TC</h3>
			<div id="app-back-button">
				<a href="home"><img alt="Back" border="0"
					src="${img_url}/home.png"
					style="margin-top: -6px; height: 40px; width: 40px;"></a> <a
					href="#" onclick="javascript:location.reload(true);"><img
					alt="Back" border="0" src="${img_url}/refresh.png"
					style="margin-top: -6px; height: 40px; width: 40px;"></a> <a
					href="#" onclick="history.back(); return false;"><img
					alt="Back" border="0" src="${img_url}/back.png"
					style="margin-top: -6px; height: 40px; width: 40px;"></a>
			</div>
		</div>

		<div id="page-yield">
	<b><center>Fill the Details for generating TC</center></b>
            <div>
			<f:form action="issue-tc" method="POST" commandName="StudentTransferDTO" id="formsId" target="_blank">
				<br>
				<table style="width: 577px; height: 392px; margin-left: 238px;">
					<tr>
						<td>S. Register No.:</td>
						<td>${Student.studentId}</td>
					</tr>

					<tr>
						<td>Name of the pupil:</td>
						<td>
							${Student.firstName}&nbsp;${Student.middleName}&nbsp;${Student.lastName}</td>
					</tr>
					<tr>
						<td>Name of father:</td>
						<td>${Student.fatherName}</td>
					</tr>
					<tr>
						<td>Name of mother:</td>
						<td>${Student.motherName}</td>
					</tr>
					<tr>
						<td>Current Session:</td>
						<td>${Student.sessionDuration}</td>
					</tr>
					<tr>
						<td>Religion & Caste:</td>
						<td><input type="text" name="religionCaste" id="religionCaste"
							style="width: 245px;"></td>
					</tr>
						<tr>
						<td>Date of Birth:</td><td>${Student.dateOfBirth}</td>
						
					</tr>
					<tr>
					<td>Date of Birth(in words):</td>
					<td><input type="text" name="inWordDob" id="inWordDob"
							style="width: 245px;"></td>
					</tr>
					<tr>
					<td>Date of Admission</td>
					<td>${Student.admissionDate}</td>
					</tr>
					<tr>
						<td>Class.</td>
						<td>${Student.className}</td>
					</tr>
					<tr>
						<td>Class(in words):</td>
						<td><input type="text" name="classInWord"
							id="classInWord" style="width: 136px;" 
							></td>
					</tr>
					<tr>
						<td>Date of Withdrawl:</td>
						<td><input type="text" name="dateOfWithdrawl"
							id="dateOfWithdrawl" style="width: 136px;" value="${today}"
							readonly="readonly"></td>
					</tr>
					<tr>
						<td>Class:</td>
						<td><input type="text" name="newClass" id="newClass"
							style="width: 245px;"></td>
					</tr>
					<tr>
						<td>Class(in words):</td>
						<td><input type="text" name="newClassInWord" id="newClassInWord"
							style="width: 245px;"></td>
					</tr>
					<tr>
						<td>Conduct:</td>
						<td><input type="text" name="conduct" id="conduct"
							style="width: 245px;"></td>
					</tr>
						<tr>
						<td>Result:</td>
						<td><input type="text" name="result" id="result"
							style="width: 245px;"></td>
					</tr>
					<tr>
						<td></td>
						<td><button class="btn" onclick="getSubmission();">Issue</button></td>
					</tr>
				</table>
				<input type="hidden" name="studentId" value="${Student.admissionNo}"/>
				</f:form>
			</div>
			<br>
		</div>
	</div>


</div>


<div class="extender"></div>


