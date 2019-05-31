<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<spring:url value="/js" var="js_url" />
<spring:url value="/img" var="img_url" />
<spring:url value="/css" var="css_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/setting.css">


<c:url value="style/theme/images" var="backurl" />

<link rel="stylesheet"
	href="${js_url}/fullcalendar/jquery-ui-1.10.4.custom.min.css">

<div class="content">
	<div id="content-header" style="height: 150px;">
		<img alt="Show_settings" src="${img_url}/sfees.jpg"
			style="width: 50px; margin-top: -12px;">
		<h1>Check Fee Payment Status</h1>
		<h3>Search datewise payment status</h3>
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

	<script type="text/javascript">
		function getSections(id) {
			$.ajax({
				type : "post",
				url : 'getsectionlist/' + id,
				success : function(data, status) {
					$("#sectionId").empty();
					var j = JSON.parse(data);
					var content = '<option value="">Select Section</option>';
					for ( var i = 0; i < j.length; i++) {
						content += '<option value='+j[i].sectionId+'>'
								+ j[i].sectionName + '</option>';
					}
					$("#sectionId").append(content);
				},
				error : function(e) {
					alert('Error: ' + e);
				}
			});
		}
		function getStudentFeeDetails() {

			var sessionId = $('#sessionId').val();
			var classId = $('#classId').val();
			var sectionId = $('#sectionId').val();
			var fromDate = $('#fromDate').val();
			var toDate = $('#toDate').val();

			if (classId == '' || sectionId == '' || fromDate == '') {
				alert("Fill Above Data First !!!");
			} else {
				$
						.ajax({
							type : "post",
							url : 'get-student-fee-details',
							data : {
								'classId' : classId,
								'sectionId' : sectionId,
								'fromDate' : fromDate,
								'toDate' : toDate,
								'sessionId' : sessionId
							},
							success : function(data, status) {
								$("#feeDetails").empty();
								$("#information").empty();
								var j = JSON.parse(data);
								if (j != '') {
									var content = '<div><div class="widget-body" style="padding: 10px 0 0;"><div class="separator"></div><div class="btn-group" style="width: 1059px;">'
											+ '</div><div class="block" style="margin-left: -140px;"><div class="head blue"><div class="icon"><span class="ico-pen-2"></span></div><h2>Student Fee Details</h2></div>'
											+ '<table class="table table-bordered table-primary"><th>Name</th><th>Paid Amount</th><th>Paid By</th><th>Paid Status</th><th>Paid Date</th><th>Month</th><th>Contact No.</th><th>Address</th>';
									/* var information = '<div style="height: 163px; width: 203px; overflow: scroll; float: right; margin-top: -192px; margin-right: 160px; padding: 10px; border: 1px solid lightgray; margin-bottom: 14px;"><center><b>Class: '
											+ j[0].className
											+ '<br> Section: '
											+ j[0].sectionName
											+ '</b></center><br>'; */

									$
											.each(
													j,
													function(key, value) {
														/* if (feeDetails == '') {
															information += '<img src=../img/wrong.PNG>&nbsp;&nbsp;'
																	+ value.fullName
																	+ '<br>';
														} else if (value.feeSubmissionDetailsDTOs[i].feePaidStatus == 'completed') {
															information += '<img src=../img/right.PNG>&nbsp;&nbsp;'
																	+ value.fullName
																	+ '<br>';
														} else if (value.feeSubmissionDetailsDTOs[i].feePaidStatus == 'inprogress') {
															information += '<img src=../img/progress.gif>&nbsp;&nbsp;'
																	+ value.fullName
																	+ '<br>';
														} else if (value.feeSubmissionDetailsDTOs[i].feePaidStatus == 'cancel') {
															information += '<img src=../img/wrong.PNG>&nbsp;&nbsp;'
																	+ value.fullName
																	+ '<br>';
														} */
														$
																.each(
																		value.feeSubmissionDetailsDTOs,
																		function(
																				key,
																				value1) {
																			if (value1.feePaidStatus == 'inprogress') {

																				content += '<tr><td style="background-color: yellow;"><img src=../img/progress.gif>&nbsp;&nbsp;'
																						+ value.fullName
																						+ '</td><td style="background-color: yellow;">'
																						+ value1.paidAmount
																						+ '</td><td style="background-color: yellow;">'
																						+ value1.paidBy
																						+ '</td>';

																				content += '<td style="background-color: yellow;"><select onchange="changePaidStatus(this.value,'
																						+ value1.recieptNo
																						+ ')"><option value="inprogress">'
																						+ value1.feePaidStatus
																						+ '</option><option value="completed">Completed</option><option value="cancel"><span style="color:red">cancel</span></option></select></td>';

																				content += '<td style="background-color: yellow;">'
																						+ value1.feePaidDate
																						+ '</td><td style="background-color: yellow;">'
																						+ value1.month
																						+ '</td><td style="background-color: yellow;">'
																						+ value.mobile
																						+ '</td><td style="background-color: yellow;">'
																						+ value.addressLine1
																						+ ' '
																						+ value.city
																						+ '</td></tr>';
																			}
																			if (value1.feePaidStatus == 'cancel')

																			{
																				content += '<tr><td style="background-color: red;"><img src=../img/wrong.PNG>&nbsp;&nbsp;'
																						+ value.fullName
																						+ '</td><td style="background-color: red;">'
																						+ value1.paidAmount
																						+ '</td><td style="background-color: red;">'
																						+ value1.paidBy
																						+ '</td>';

																				content += '<td style="background-color: red;">'
																						+ value1.feePaidStatus
																						+ '</td>';

																				content += '<td style="background-color: red;">'
																						+ value1.feePaidDate
																						+ '</td><td style="background-color: red;">'
																						+ value1.month
																						+ '</td><td style="background-color: red;">'
																						+ value.mobile
																						+ '</td><td style="background-color: red;">'
																						+ value.addressLine1
																						+ '  '
																						+ value.city
																						+ '</td></tr>';
																			}
																			if (value1.feePaidStatus == 'completed')

																			{
																				content += '<tr><td style="color:green;"><img src=../img/right.PNG>&nbsp;&nbsp;'
																						+ value.fullName
																						+ '</td><td style="color:green;">'
																						+ value1.paidAmount
																						+ '</td><td style="color:green;">'
																						+ value1.paidBy
																						+ '</td>';

																				content += '<td style="color:green;">'
																						+ value1.feePaidStatus
																						+ '</td>';

																				content += '<td style="color:green;">'
																						+ value1.feePaidDate
																						+ '</td><td style="color:green;">'
																						+ value1.month
																						+ '</td><td style="color:green;">'
																						+ value.mobile
																						+ '</td><td style="color:green;">'
																						+ value.addressLine1
																						+ ' '
																						+ value.city
																						+ '</td></tr>';
																			}
																		});
													});
									content += '</div>';
									content += '</table>';
									$("#feeDetails").append(content);
									$("#information").append(information);
								} else {
									$("#feeDetails")
											.append(
													'<div style="border: 2px solid rgb(236, 65, 65); background: none repeat scroll 0% 0% rgb(225, 114, 114); color: white; height: 30px; font: 135%/1.5 cursive;"><center>Data Not Found</center></div>');
								}
							},
							error : function(e) {
								alert('Error: ' + e);
							}
						});
			}
		}
		function changePaidStatus(paidStatus, receiptno) {
			$.ajax({
				type : "post",
				url : 'changepaidstatus',
				data : {
					'paidstaus' : paidStatus,
					'receiptno' : receiptno
				},
				success : function(data, status) {
					getStudentFeeDetails();
				},
				error : function(e) {
					alert('Error: ' + e);
				}
			});
		}
		function getClear() {
			$("#classId").val('');
			$("#sectionId").val('');
			$("#fromDate").val('');
			$("#toDate").val('');
		}
		function getdateclear() {
			$("#fromDate").val('');
			$("#toDate").val('');
		}
		function gettoclear() {

			$("#toDate").val('');
		}
	</script>

	<f:form method="post" modelAttribute="studentFeeDetailsDTO"
		style="margin-left: 199px; margin-top: 43px;">
		<div
			class="widget widget-2 widget-tabs widget-tabs-2 tabs-right border-bottom-none"></div>
		<div class="row-form" style="margin-top: -160px;">
			<div class="span2">
				Select Session :<font color="red">*</font>
			</div>
			<div class="span4">
				<f:select path="sessionId" class="form-control input-sm"
					id="sessionId" x-data-toggle-x="tooltip" required="required"
					title="Specify the session of the student" onchange="getClear();"
					data-original-title="Specify session">
					<c:forEach var="list" items="${sessionList}">
						<c:choose>
							<c:when test="${current.sessionId==list.sessionId}">
								<f:option selected="selected" value="${list.sessionId}">${list.sessionDuration}</f:option>
							</c:when>
							<c:otherwise>
								<f:option value="${list.sessionId}">${list.sessionDuration}</f:option>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</f:select>
			</div>
		</div>
		<div class="row-form">
			<div class="span2">
				Select Class :<font color="red">*</font>
			</div>
			<div class="span2">
				<f:select path="classId" id="classId"
					onchange="getSections(this.value)" style="width: 370px;"
					class="validate[required,maxSize[]]">
					<f:option value="">Select Class</f:option>
					<c:forEach var="studentClass" items="${studentClasses}">
						<f:option value="${studentClass.classId}">${studentClass.className}</f:option>
					</c:forEach>
				</f:select>
			</div>
		</div>
		<div class="row-form">
			<div class="span2">
				Select Section :<font color="red">*</font>
			</div>
			<div class="span4">
				<f:select path="sectionId" id="sectionId" onchange="getdateclear();"
					class="validate[required,maxSize[]]">
					<f:option value="">Select Section</f:option>
				</f:select>
			</div>
		</div>

		<div class="row-form">
			<div class="span2">
				Select From Date :<font color="red">*</font>
			</div>
			<div class="span4">
				<input type="text" class="datepicker validate[required]"
					onchange="gettoclear();" placeholder="Select From Date"
					id="fromDate">
			</div>
		</div>

		<div class="row-form">
			<div class="span2">
				Select To Date :<font color="red">*</font>
			</div>
			<div class="span4">
				<input type="text" class="datepicker validate[required]"
					placeholder="Select To Date" id="toDate"
					onchange="getStudentFeeDetails();">
			</div>
		</div>

		<div id="information"></div>
		<div id="feeDetails" style="width: 900px; margin: 0 auto;"></div>
	</f:form>
</div>