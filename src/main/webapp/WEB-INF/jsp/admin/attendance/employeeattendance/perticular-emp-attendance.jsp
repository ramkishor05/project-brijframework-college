<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<spring:url value="/" var="baseurl"></spring:url>
<spring:url value="/img" var="img_url" />
<spring:url value="/style" var="style_url" />
<spring:url value="/css" var="css_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/home.css">
<link rel="stylesheet" type="text/css" href="${css_url}/setting.css">
<script type="text/javascript">
	function getSectionList(value) {
		var sessionDuration = $("#sessionId").val();
		var splite = sessionDuration.split("-");
		var year = splite[0];
		if (parseInt(value) == 11) {
			value = 1;
			year = splite[1];
		} else if (parseInt(value) == 12) {
			value = 2;
			year = splite[1];
		} else {
			value = parseInt(value) + 2;
		}
		document.location.href = 'perticular-emp-attendance.html?id=${EMPID}&monthId='
				+ value + '&year=' + year;
	}
	/* function createholiday(date) {
		$("#appendFeeCategoryId").empty();
		$("#holidayDate").val(date);
		$("#stateId").empty();
		$
				.ajax({
					type : "post",
					url : 'check-holidays.html',
					data : {
						"holidayDate" : date
					},
					success : function(data) {
						var obj = JSON.parse(data);
						if (obj.description == null) {
							$("#submitform").attr('action',
									'create-holidays.html')
						} else {

							var input = '<input type="hidden" value="'+obj.holidayId+'" name="holidayId">';
							$("#appendFeeCategoryId").append(input);
							$("#description").val(obj.description);
							$("#submitform")
									.attr('action', 'edit-holiday.html');

						}
					},
					error : function(e) {
						$('#loading').hide();
					}
				});
		$(".feecategorycreateedit").show();
	}
	function hidefeecategorycreateedit() {
		$("#description").val('');
		$("#holidayDate").val('');
		$(".feecategorycreateedit").hide();
	} */
</script>
<style>
.feecategorycreateedit {
	display: none;
	background-color: white;
	border: 1px solid grey;
	width: 450px;
	height: 266px;
	border-radius: 6px;
	margin-top: 60px;
	left: 220px;
	z-index: 1;
	position: absolute;
	background-color: white;
}

.feecategorycreateedit-header {
	width: 450px;
	margin-top: -10px;
	border-bottom: 1px solid gray;
	height: 50px;
}
</style>
<div class="content">
	<div id="content-header" style="height: 150px;">
		<img alt="Show_settings" src="${img_url}/createweekdays.png"
			style="width: 57px;">
		<h1>Employee Attendance</h1>
		<h3>Employee Attendance</h3>
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


	<div class="row-fluid">
		<div class="span4">
			<div class="block">
				<div
					style="height: auto; width: auto; border: 1px solid lightgray; background-color: rgb(238, 238, 238); border-radius: 5px;"
					id="searches">
					<div class="data-fluid">
						<div class="row-form">
							<div class="span4">Session :</div>
							<div class="span8">
								<select name="sessionId" id="sessionId">
									<c:forEach items="${Sessions}" var="Session">
										<c:choose>
											<c:when test="${CurrentSession.sessionId==Session.sessionId}">
												<option value="${Session.sessionDuration}"
													selected="selected">${Session.sessionDuration}</option>
											</c:when>
											<c:otherwise>
												<option value="${Session.sessionDuration}">${Session.sessionDuration}</option>
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</select>
							</div>
						</div>
						<div class="row-form">
							<div class="span4">Month :</div>
							<div class="span8">
								<select name="classId" onchange="getSectionList(this.value);">
									<option value="">Select a Month</option>
									<c:forEach items="${Months}" var="Month">
										<c:if test="${Month.monthId!=13}">
											<option value="${Month.monthId}">${Month.monthName}</option>
										</c:if>
									</c:forEach>
								</select>
							</div>
						</div>
					</div>
					<input type="hidden" id="studentAdmissionNo"
						name="studentAdmissionNo"> <input type="hidden"
						id="neededMonthId">
					<div class="separator"></div>
				</div>
			</div>
		</div>
		<div class="span8">
			<div class="block">
				<div
					style="border: 1px solid; border-radius: 10px; height: auto; width: 615px; margin-top: -4px;"
					id="box">
					<table style="width: 600px; margin-left: 10px; margin-top: 7px;">
						<tbody>
							<tr>
								<td width="25%"><span><font size="2"><b>Emp
												Name :</b></font></span></td>
								<td width="25%"><span><font size="2">${EMPLOYEESDTO.firstName}
											${EMPLOYEESDTO.lastName}</font></span></td>
							</tr>
							<tr>
								<td width="25%"><span><font size="2"><b>Father
												Name:</b></font></span></td>
								<td width="25%"><span><font size="2">${EMPLOYEESDTO.fatherName}</font></span></td>
								<td width="25%"><span><font size="2"><b>Mobile
												No:</b></font></span></td>
								<td width="25%"><span><font size="2">${EMPLOYEESDTO.mobile}</font></span></td>
							</tr>
							<tr></tr>
							<tr>
								<td width="25%"><span><font size="2"><b>Total
												working Days:</b></font></span></td>
								<td width="25%"><span><font size="2">${MAP.TOTALWORKINGDAYS}</font></span></td>
								<td width="25%"><span><font size="2"><b>Total
												present:</b></font></span></td>
								<td width="25%"><span><font size="2">${MAP.TOTALPRESENT}</font></span></td>
							</tr>
							<tr>
								<td width="25%"><span><font size="2"><b>Total
												Absent:</b></font></span></td>
								<td width="25%"><span><font size="2">${MAP.TOTALABSENT}</font></span></td>
								<td width="25%"><span><font size="2"><b>Total
												Late:</b></font></span></td>
								<td width="25%"><span><font size="2">${MAP.TOTALLATE}</font></span></td>
							</tr>
							<tr>
								<td width="25%"><span><font size="2"><b>Total
												Leave:</b></font></span></td>
								<td width="25%"><span><font size="2">${MAP.TOTALLEAVE}</font></span></td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>








	<div class="row-fluid">
		<div class="span12">
			<div class="block">
				<div class="head blue">
					<center>
						<h2>
							<a
								href="perticular-emp-attendance.html?id=${EMPID}&monthId=${MAP.MONTHID-1}&year=${MAP.YEAR}">Previous
								Month</a>
						</h2>
						&nbsp;&nbsp;&nbsp;&nbsp;
						<h2 style="text-align: center;">${MAP.MONTHOfYEAR}</h2>
						&nbsp;&nbsp;&nbsp;&nbsp;
						<h2>
							<a
								href="perticular-emp-attendance.html?id=${EMPID}&monthId=${MAP.MONTHID+1}&year=${MAP.YEAR}">Next
								Month</a>
						</h2>
					</center>
				</div>
				<div class="data-fluid">
					<table cellspacing="0" cellpadding="0" width="100%" class="table">
						<thead>
							<tr>
								<th width="14%" style="border: 1px solid red;">Sunday</th>
								<th width="14%" style="border: 1px solid red;">Monday</th>
								<th width="14%" style="border: 1px solid red;">Tuesday</th>
								<th width="14%" style="border: 1px solid red;">Wednesday</th>
								<th width="14%" style="border: 1px solid red;">Thursday</th>
								<th width="14%" style="border: 1px solid red;">Friday</th>
								<th width="14%" style="border: 1px solid red;">Saturday</th>
							</tr>
						</thead>
						<tbody>

							<c:forEach items="${MAP.HOLIDAYSLIST}" var="Holiday"
								varStatus="count">
								<c:choose>
									<c:when test="${Holiday.description=='Sunday'}">
										<tr>
											<td style="border: 1px solid red;"><font color="green"><b>${Holiday.description} &nbsp;${Holiday.des}</b>
													<c:if test="${Holiday.holidayCount!=0}">${Holiday.holidayCount}</c:if></font></td>
									</c:when>
									<c:otherwise>
										<c:choose>
											<c:when test="${Holiday.holidayCount=='0'}">
												<td style="border: 1px solid red;"></td>
											</c:when>
											<c:otherwise>
												<td style="border: 1px solid red;">
													<div style="width: 100%">
														<div style="width: 30%; float: left;">
															<a href="javascript:void(0);" class="btn">${Holiday.holidayCount}</a>
														</div>
														<div style="width: 65%; float: left;">${Holiday.description}</div>
													</div>
												</td>
											</c:otherwise>
										</c:choose>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>

	</div>
</div>