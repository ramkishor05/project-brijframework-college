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
		$('#dateOfEntryInVI').datepick({
			dateFormat : "yyyy-M-dd"
		});
		$("#dateOfPromotionInVI").datepick({
			dateFormat : "yyyy-M-dd"
		});
		$("#dateOfTransferInVI").datepick({
			dateFormat : "yyyy-M-dd"
		});
		
		
		$('#dateOfEntryInVII').datepick({
			dateFormat : "yyyy-M-dd"
		});
		$("#dateOfPromotionInVII").datepick({
			dateFormat : "yyyy-M-dd"
		});
		$("#dateOfTransferInVII").datepick({
			dateFormat : "yyyy-M-dd"
		});
		
		
		$('#dateOfEntryInVIII').datepick({
			dateFormat : "yyyy-M-dd"
		});
		$("#dateOfPromotionInVIII").datepick({
			dateFormat : "yyyy-M-dd"
		});
		$("#dateOfTransferInVIII").datepick({
			dateFormat : "yyyy-M-dd"
		});
		
		

		$('#dateOfEntryInIX').datepick({
			dateFormat : "yyyy-M-dd"
		});
		$("#dateOfPromotionInIX").datepick({
			dateFormat : "yyyy-M-dd"
		});
		$("#dateOfTransferInIX").datepick({
			dateFormat : "yyyy-M-dd"
		});
		
		
		$('#dateOfEntryInX').datepick({
			dateFormat : "yyyy-M-dd"
		});
		$("#dateOfPromotionInX").datepick({
			dateFormat : "yyyy-M-dd"
		});
		$("#dateOfTransferInX").datepick({
			dateFormat : "yyyy-M-dd"
		});
		
		
		$('#dateOfEntryInXI').datepick({
			dateFormat : "yyyy-M-dd"
		});
		$("#dateOfPromotionInXI").datepick({
			dateFormat : "yyyy-M-dd"
		});
		$("#dateOfTransferInXI").datepick({
			dateFormat : "yyyy-M-dd"
		});
		
		
		
		$('#dateOfEntryInXII').datepick({
			dateFormat : "yyyy-M-dd"
		});
		$("#dateOfPromotionInXII").datepick({
			dateFormat : "yyyy-M-dd"
		});
		$("#dateOfTransferInXII").datepick({
			dateFormat : "yyyy-M-dd"
		});
		
		
		
	});
	
</script>
<script>
	
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
	function getSubmission() {
		$("#formsId").submit();
		document.location.href = "student-details";
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
				<f:form action="new_issue-tc" method="GET"
					commandName="newStudentTransferDTO" id="formsId" target="_blank">
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
							<td>Father Occuption:</td>
							<td><input type="text" name="fatherOccuption"
								id="religionCaste" style="width: 245px;"></td>
						</tr>
						
						<tr>
							<td>UP Default Duration Of Stay :</td>
							<td><input type="text" name="UPDefaultDurationOfStay"
								id="religionCaste" style="width: 245px;"></td>
						</tr>
						 <tr>
							<td>Name of Last School :</td>
							<td><input type="text" name="lastSchoolName"
								id="religionCaste" style="width: 245px;" value="${Student.schoolName}"></td>
						</tr> 
						<tr>
							<td>Current Session:</td>
							<td>${Student.sessionDuration}</td>
						</tr>
						<tr>
							<td>Caste:</td>
							<td><input type="text" name="religion"
								id="religionCaste" style="width: 245px;"></td>
						</tr>
						<tr>
							<td>Religion:</td>
							<td><input type="text" name="religionCaste"
								id="religionCaste" style="width: 245px;" value="${Student.religionName}"></td>
						</tr>
						
						<tr>
							<td>Date of Birth:</td>
							<td>${Student.dateOfBirth}</td>

						</tr>
						<tr>
							<td>Date of Birth(in words):</td>
							<td><input type="text" name="inWordDob" id="inWordDob"
								style="width: 245px;"></td>
						</tr>
						<%-- <tr>
							<td>Date of Admission</td>
							<td>${Student.admissionDate}</td>
						</tr> --%>
						<%-- <tr>
							<td>Class.</td>
							<td>${Student.className}</td>
						</tr>
						<tr>
							<td>Class(in words):</td>
							<td><input type="text" name="classInWord" id="classInWord"
								style="width: 136px;"></td>
						</tr> --%>
						<%-- <tr>
							<td>Date of Withdrawl:</td>
							<td><input type="text" name="dateOfWithdrawl"
								id="dateOfWithdrawl" style="width: 136px;" value="${today}"
								readonly="readonly"></td>
						</tr> --%>
					
						<!-- <tr>
							<td>Conduct:</td>
							<td><input type="text" name="conduct" id="conduct"
								style="width: 245px;"></td>
						</tr> -->
						<!-- <tr>
							<td>Result:</td>
							<td><input type="text" name="result" id="result"
								style="width: 245px;"></td>
						</tr> -->

					</table>
					<div style="height: 58px; padding: 0.5px 0 0 0px;"
						class="head blue">
						<table class="table table-bordered table-primary">
							<tbody>
								<tr>
									<th>Class</th>
									<th>Date Of Entry</th>
									<th>Date of Promotion</th>
									<th>Date Of Transfer</th>
									<th>Reason For Transfer</th>
									<th>Session</th>
									<th>Result</th>
									<th>Conduct</th>
									
								</tr>
								<tr>
									<td><input type="text" name="classVI" value="VI" readonly="readonly"></td>
									<td><input type="text" name="dateOfEntryInVI" readonly="readonly" id="dateOfEntryInVI"></td>
									<td><input type="text" name="dateOfPromotionInVI" readonly="readonly" id="dateOfPromotionInVI"></td>
									<td><input type="text" name="dateOfTransferInVI"  readonly="readonly" id="dateOfTransferInVI"></td>
									<td><input type="text" name="reasonForTransferInVI"></td>
									<td><input type="text" name="sessionInVI"></td>
									<td><input type="text" name="resultInVI"></td>
									<td><input type="text" name="behaviourInVI"></td>
									
								</tr>

								<tr>
									<td><input type="text" name="classVI" value="VII" readonly="readonly"></td>
									<td><input type="text" name="dateOfEntryInVII"  readonly="readonly" id="dateOfEntryInVII"></td>
									<td><input type="text" name="dateOfPromotionInVII" readonly="readonly" id="dateOfPromotionInVII"></td>
									<td><input type="text" name="dateOfTransferInVII" readonly="readonly" id="dateOfTransferInVII"></td>
									<td><input type="text" name="reasonForTransferInVII"></td>
									<td><input type="text" name="sessionInVII"></td>
									<td><input type="text" name="resultInVII"></td>
									<td><input type="text" name="behaviourInVII"></td>
									
								</tr>

								<tr>
									<td><input type="text" name="classVI" value="VIII" readonly="readonly"></td>
									<td><input type="text" name="dateOfEntryInVIII" readonly="readonly" id="dateOfEntryInVIII"></td>
									<td><input type="text" name="dateOfPromotionInVIII" readonly="readonly" id="dateOfPromotionInVIII"></td>
									<td><input type="text" name="dateOfTransferInVIII" readonly="readonly" id="dateOfTransferInVIII"></td>
									<td><input type="text" name="reasonForTransferInVIII"></td>
									<td><input type="text" name="sessionInVIII"></td>
									<td><input type="text" name="resultInVIII"></td>
									<td><input type="text" name="behaviourInVIII"></td>
									
								</tr>

								<tr>
									<td><input type="text" name="classVI" value="IX" readonly="readonly"></td>
									<td><input type="text" name="dateOfEntryInIX" readonly="readonly" id="dateOfEntryInIX"></td>
									<td><input type="text" name="dateOfPromotionInIX" readonly="readonly" id="dateOfPromotionInIX"></td>
									<td><input type="text" name="dateOfTransferInIX" readonly="readonly" id="dateOfTransferInIX"></td>
									<td><input type="text" name="reasonForTransferInIX"></td>
									<td><input type="text" name="sessionInIX"></td>
									<td><input type="text" name="resultInIX"></td>
									<td><input type="text" name="behaviourInIX"></td>
									
								</tr>

								<tr>
									<td><input type="text" name="classVI" value="X" readonly="readonly"></td>
									<td><input type="text" name="dateOfEntryInX" readonly="readonly" id="dateOfEntryInX"></td>
									<td><input type="text" name="dateOfPromotionInX" readonly="readonly" id="dateOfPromotionInX"></td>
									<td><input type="text" name="dateOfTransferInX" readonly="readonly" id="dateOfTransferInX"></td>
									<td><input type="text" name="reasonForTransferInX"></td>
									<td><input type="text" name="sessionInX"></td>
									<td><input type="text" name="resultInX"></td>
									<td><input type="text" name="behaviourInX"></td>
									
								</tr>

								<tr>
									<td><input type="text"  name="classVI" value="XI" readonly="readonly"></td>
									<td><input type="text" name="dateOfEntryInXI" readonly="readonly" id="dateOfEntryInXI"></td>
									<td><input type="text" name="dateOfPromotionInXI" readonly="readonly" id="dateOfPromotionInXI"></td>
									<td><input type="text" name="dateOfTransferInXI" readonly="readonly" id="dateOfTransferInXI"></td>
									<td><input type="text" name="reasonForTransferInXI"></td>
									<td><input type="text" name="sessionInXI"></td>
									<td><input type="text" name="resultInXI"></td>
									<td><input type="text" name="behaviourInXI"></td>
									
								</tr>

								<tr>
									<td><input type="text" name="classVI" value="XII" readonly="readonly"></td>
									<td><input type="text" name="dateOfEntryInXII" readonly="readonly"  id="dateOfEntryInXII"></td>
									<td><input type="text" name="dateOfPromotionInXII" readonly="readonly" id="dateOfPromotionInXII"></td>
									<td><input type="text" name="dateOfTransferInXII" readonly="readonly" id="dateOfTransferInXII"></td>
									<td><input type="text" name="reasonForTransferInXII"></td>
									<td><input type="text" name="sessionInXII"></td>
									<td><input type="text" name="resultInXII"></td>
									<td><input type="text" name="behaviourInXII"></td>
									
								</tr>

							</tbody>
						</table>
						<table>
							<tr>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td><button class="btn" onclick="getSubmission();">Issue</button></td>
							</tr>
						</table>
						<span
							style="color: white; float: right; margin-top: -35px; margin-right: 27px;">
						</span>
					</div>
					<f:hidden path="studentId" value="${Student.admissionNo}" />
				</f:form>
			</div>
			<br>
		</div>
	</div>


</div>


<div class="extender"></div>


