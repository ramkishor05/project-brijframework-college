<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/style/datepicks" var="datepicks" />
<spring:url value="/img" var="img_url" />
<spring:url value="/css" var="css_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/admission.css">
<spring:url value="/" var="base_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/setting.css">
<style>
.feecategorycreateedit {
	display: none;
	background-color: #FFFFCC;
	border: 1px solid grey;
	width: 1060px;
	left: 21px;
	top: 141px;
	/* 	height: 780px; */
	border-radius: 6px;
	margin-top: 60px;
	z-index: 1;
	position: absolute;
}

.feecategorycreateedit-header {
	width: 1052px;
	margin-top: -10px;
	border-bottom: 1px solid gray;
	height: 50px;
	background-color: #FFFFCC;
}
</style>
<script>
	function validatedata() {
		var flag = true;
		var num = '${number}';

		var k = 0;
		for (var i = 0; i < num; i++) {
			$("#err" + i).empty();
		}
		for (var i = 0; i < num; i++) {
			k = $("#sal" + i).val();
			if (isNaN(k) || k == '') {
				$("#err" + i)
						.append(
								'<span><font color="red" size="2">Enter valid amount</font></span>');
				flag = false;
			}
		}
		if (flag == true) {

			$("#submitform").submit();
		}
	}

	function removezero(id) {

		var s = $("#sal" + id).val();
		if (s == 0)
			$("#sal" + id).val('');
	}
	function getEmployeeSalaryDetails(id) {

		var sessionId = $("#sessionId").val();

		$
				.ajax({
					type : "post",
					url : 'get-employee-salary-payment-details',
					
					data : {
						'employeeId' : id,
						'sessionId' : sessionId,
					},
					success : function(data, status) {
						var obj = JSON.parse(data);
						$("#monthwithfeedetail").empty();

						$("#myModalLabel").text(
								obj.employeeDTO.firstName+ '  '
										+ obj.employeeDTO.lastName);
						var monthwithfeedetail = '<div class="head green"style="width: 1019px;"><div class="icon"><span class="ico-brush"></span></div>';
						monthwithfeedetail += '<h2>Salary payment details</h2><ul class="buttons"><li><a href="#"><div class="icon">';
						monthwithfeedetail += '<span class="ico-info"></span></div></a></li></ul></div>';
						monthwithfeedetail += '<div class="data-fluid"><div class="classshowheader"><table width="100%" class="table table-primary">';
						monthwithfeedetail += '<thead><tr>';//<input onclick="enableanddisable(this.checked);" type="checkbox"/>
						monthwithfeedetail += '<th style="background-color: #FFCC99">Month Name</th>';
						monthwithfeedetail += '<th style="background-color: #FFCC99" >Opening Balance</th>';
						monthwithfeedetail += '<th style="background-color: #FFCC99" >Salary</th>';
						monthwithfeedetail += '<th style="background-color: #FFCC99">Attendance</th>';
						monthwithfeedetail += '<th style="background-color: #FFCC99" >Advance</th>';
						monthwithfeedetail += '<th style="background-color: #FFCC99">Fine</th>';
						monthwithfeedetail += '<th style="background-color: #FFCC99">Incentive</th>';
						monthwithfeedetail += '<th style="background-color: #FFCC99">Net Amount</th>';
						monthwithfeedetail += '<th style="background-color: #FFCC99">Paid Amount</th>';
						monthwithfeedetail += '<th style="background-color: #FFCC99">Closing Balance</th>';
						monthwithfeedetail += '<th style="background-color: #FFCC99" >Status</th>';
						monthwithfeedetail += '<th style="background-color: #FFCC99">Type</th>';
						monthwithfeedetail += '<th style="background-color: #FFCC99">Date</th>';
						monthwithfeedetail += '<th style="background-color: #FFCC99">Paid By</th>';
						monthwithfeedetail += '<th style="background-color: #FFCC99" >Slip</th></tr></thead><tbody>';
						monthwithfeedetail += '';
						var neededMonthId = 0;
						var totalGrossAmount = 0;
						var totalFineAmount = 0;
						var totalNetAmount = 0;
						var totalPaidAmount = 0;
						var totalBalanceAmount = 0;
						var openingBalance = 0;
						var totalOpeningBalance = 0;
						var totalClosingBalance = 0;
						var fineAmount = 0;
						var totalDiscountAmount = 0;
						$
								.each(
										obj.EmployeeSalaryDTOs,
										function(key, value) {

											if (value.fineAmount == null) {
												fineAmount = 0;
											} else {
												fineAmount = value.fineAmount;
											}
											var netAmount = parseInt(openingBalance)
													+ parseInt(value.salaryAmount)
													+ parseInt(value.incentive)
													- parseInt(fineAmount)
													- parseInt(value.advanceAmount);
											totalGrossAmount += parseInt(value.salaryAmount);
											totalFineAmount += parseInt(value.fineAmount);
											totalNetAmount += netAmount
													- parseInt(openingBalance);

											totalDiscountAmount += parseInt(fineAmount);
											if (value.paidAmount == '-') {
												value.paidAmount = 0;
												var balanceAmount = parseInt(netAmount)
														- parseInt(value.paidAmount);
												totalPaidAmount += parseInt(value.paidAmount);
											} else {
												var balanceAmount = parseInt(netAmount)
														- parseInt(value.paidAmount);
												totalPaidAmount += parseInt(value.paidAmount);
											}
											var payAmount = parseInt(openingBalance)
													+ parseInt(value.salaryAmount);
											monthwithfeedetail += '';
											monthwithfeedetail += ' <tr>';

											monthwithfeedetail += '<td  width="7%"style="background-color: #FFFFCC; ">'
													+ value.month
													+ '</td>';
											if (openingBalance == 0) {
												monthwithfeedetail += '<td  width="7%" style="background-color: #FFFFCC;">00</td>';

											} else {
												monthwithfeedetail += '<td  width="7%" style="background-color: #FFFFCC;">'
														+ openingBalance
														+ '</td>';
											}

											monthwithfeedetail += '<td  width="7%" id="grossAmount'
													+ value.monthId
													+ '" style="background-color: #FFFFCC">'
													+ value.salaryAmount
													+ '</td><td  width="7%" style="background-color: #FFFFCC"><a href="javascript:viewcategories('
													+ value.monthId
													+ ');">'
													+ value.present
													+ '/'
													+ value.totalDays
													+ '</td><td  width="7%" style="background-color: #FFFFCC"><a href="javascript:viewadvances('
													+ value.monthId
													+ ','
													+ id
													+ ','
													+ sessionId
													+ ');">'
													+ value.advanceAmount
													+ '</td><td  width="7%" style="background-color: #FFFFCC">'
													+ value.fineAmount
													+ '</td><td   width="7%" style="background-color: #FFFFCC">'
													+ value.incentive
													+ '</td><td  width="7%" style="background-color: #FFFFCC">'
													+ netAmount + '</td>';
											if (value.commonString == null) {
												monthwithfeedetail += '<td  width="7%" id="paidAmount'
														+ value.monthId
														+ '" style="background-color: #FFFFCC">'
														+ value.paidAmount
														+ '</td>';
											} else {
												monthwithfeedetail += '<td  width="7%" id="paidAmount'
														+ value.monthId
														+ '" style="background-color: #FFFFCC">'
														+ value.paidAmount
														+ '('
														+ value.commonString
														+ ')</td>';
											}
											monthwithfeedetail += '<td  width="7%" style="background-color: #FFFFCC">'
													+ balanceAmount + '</td>';
											if (value.salaryPaidStatus == 'Completed') {
												monthwithfeedetail += '<td   width="7%"  style="background-color: #FFFFCC"><img src=../img/right.PNG>'
														+ '</td>';
											} else if (value.salaryPaidStatus == 'Inhand') {

												monthwithfeedetail += '<td   width="7%"  style="background-color: #FFFFCC"><img src=../img/progress.gif>'
														+ '</td>';
											} else if (value.salaryPaidStatus == 'Cancel') {
												monthwithfeedetail += '<td   width="7%" style="background-color: #FFFFCC"><img src=../img/wrong.PNG>'
														+ '</td>';
											} else

												monthwithfeedetail += ' <td  width="7%"  style="background-color: #FFFFCC"><span class="label label-warning">'
														+ value.salaryPaidStatus
														+ '</td>';
											monthwithfeedetail += ' <td   width="7%" style="background-color: #FFFFCC"><span class="label label-warning">'
													+ value.advance + '</td>';
											monthwithfeedetail += '<td  width="7%" style="background-color: #FFFFCC">'
													+ value.dateOfPayment
													+ '</td>';
											if (value.paidBy == 'cheque') {
												monthwithfeedetail += '<td   width="7%" style="background-color: #FFFFCC"><a href=javascript:showChequeDetails("'
														+ value.month
														+ '","'
														+ value.bankName
														+ '","'
														+ value.chequeNo
														+ '","'
														+ value.salaryPaidStatus
														+ '","'
														+ value.paidAmount
														+ '");><span class="label label-info">'
														+ value.paidBy
														+ '</span></a></td>';
											} else if (value.paidBy == 'cash') {
												monthwithfeedetail += '<td   width="7%" style="background-color: #FFFFCC"><span class="label label-info">'
														+ value.paidBy
														+ '</span></td>';
											} else {
												monthwithfeedetail += '<td  width="7%"  style="background-color: #FFFFCC">'
														+ value.paidBy
														+ '</td>';
											}

											if (value.slipNo == 0) {
												monthwithfeedetail += '<td  width="7%"  style="background-color: #FFFFCC">-</td>';
											} else {
												monthwithfeedetail += '<td   width="7%"style="background-color: #FFFFCC"><a href="generatePDFslip.html?slipNo='
														+ value.slipNo
														+ '" target="_blank"><span class="label label-warning">View</span></a></td>';
											}
											monthwithfeedetail += '</tr>';
											monthwithfeedetail += '<tr><td colspan="14"style="background-color: #FFFFCC"><div id="'+value.monthId+'" class="childtwo" style="width: 470px; margin-left: 25px;display: none;">';
											monthwithfeedetail += '<table width="50%" cellspacing="0" cellpadding="0" class="table">';
											monthwithfeedetail += '<thead><tr><th width="50%" class="head blue" style="color: white"><h6>Attendance Details</h6></th>';
											monthwithfeedetail += '<th width="50%" class="head blue" style="color: white"><ul class="buttons">';
											monthwithfeedetail += '<li><a href="javascript:hidecategories('
													+ value.monthId
													+ ');"><div class="icon">';
											monthwithfeedetail += '<span class="ico-cancel"></span></div></a></li></ul></th>';
											monthwithfeedetail += '</tr></thead><tbody>';
											monthwithfeedetail += '<tr><td>Total Working Days</td><td>'
													+ value.totalDays
													+ '</td></tr>';
											monthwithfeedetail += '<tr><td>No. of days Present</td><td>'
													+ value.totalPresent
													+ '</td></tr>';
											monthwithfeedetail += '<tr><td>No. of days Absent</td><td>'
													+ value.totalAbsent
													+ '</td></tr>';
											monthwithfeedetail += '<tr><td>No. of days Late</td><td>'
													+ value.totallate
													+ '</td></tr>';
											monthwithfeedetail += '<tr><td>No. of days on Leave</td><td>'
													+ value.totalLeave
													+ '</td></tr>';
											monthwithfeedetail += '<tr><td>Attendance Percent</td><td>'
													+ value.percentAttendance
													+ '%</td></tr>';
											monthwithfeedetail += '</tbody></table></div></td></tr>';
											totalOpeningBalance = parseInt(openingBalance);
											totalClosingBalance = balanceAmount;
											openingBalance = balanceAmount;
										});
						//monthwithfeedetail += '<div width="100%" class="childone"><table width="100%" cellspacing="0" cellpadding="0" class="table table-hover"> <tbody><tr><td style="background-color: #FFFFCC"></td><td width="10%" style="background-color: #FFFFCC"></td><td width="15%" style="background-color: #FFFFCC"></td><td width="15%" style="background-color: #FFFFCC"></td><td width="15%" style="background-color: #FFFFCC"></td><td width="15%" style="background-color: #FFFFCC"></td><td width="15%" style="background-color: #FFFFCC"><a id="showfeepaynemtbutton" href="javascript:showfeepaynemtform();" style="display:none;"><span class="label label-warning">Pay Fees</span></a></td></tr></tbody></table></div>';
						monthwithfeedetail += '<tr><td style="background-color: #F3F383">Total'
								+ '</td><td  style="background-color: #F3F383">'
								+ totalOpeningBalance
								+ '</td><td colspan="3" style="background-color: #F3F383">'
								+ totalGrossAmount
								+ '</td><td  style="background-color: #F3F383">'

								+ '</td><td  style="background-color: #F3F383"></td><td width="7%" style="background-color: #F3F383">'
								+ totalNetAmount
								+ '</td><td  style="background-color: #F3F383">'
								+ totalPaidAmount
								+ '</td><td  style="background-color: #F3F383">'
								+ totalClosingBalance
								+ '</td><td style="background-color: #F3F383">'
								+ '</td><td colspan="5" style="background-color: #F3F383">'
								+ '</td></tr></tbody></table></div>';
						$("#monthwithfeedetail").append(monthwithfeedetail);
						$(".feecategorycreateedit").show();
					},
					error : function(e) {

					}
				});
	}
	function hideAdvanceDetails() {
		$("#ShowDetails").empty();
		$("#ShowDetails").css("z-index", "-1");
	}
	function viewadvances(monthId, employeeId, sessionId) {
		$
				.ajax({
					type : 'post',
					url : 'getadvancebymonth',
					data : {
						'employeeId' : employeeId,
						'monthId' : monthId,
						'sessionId' : sessionId,
					},
					success : function(data) {
						$('#ShowDetails').empty();
						$('#msg').empty();
						var value = JSON.parse(data);
						var classAssignDetails = '<div class="block" style="background-color: white; opacity: 0.9; box-shadow: 0px 14px 21px 3px gray;"><div class="head" style="background-color:lightblue;padding-left:10px;width: 177px;">';
						classAssignDetails += '<h2>Advance Details'

								+ '</h2><ul class="buttons"><li><a href="javascript:hideAdvanceDetails();">';
						classAssignDetails += '<div class="icon"><span class="ico-cancel"></span></div></a></li></ul></div>';
						if (value.length == 0) {
							classAssignDetails += 'No advance taken in this session';
						} else {
							classAssignDetails += '<table class="table table-bordered table-primary"style="width: 1059px;">'
									+ '<thead><tr><th>SL No.</th><th>Date</th><th>Paid Amount</th></tr></thead>';
							for (var i = 0; i < value.length; i++) {
								classAssignDetails += '<tbody><tr><td>'
										+ (i + 1) + '</td><td>'
										+ value[i].dateOfPayment + '</td><td>'
										+ value[i].paidAmount + '</tr>'

							}
							classAssignDetails += '</tbody></table>';

						}
						$("#ShowDetails").css("z-index", "1");
						$('#ShowDetails').append(classAssignDetails);
					},
					error : function(e) {

					}
				});
	}
	function hidefeecategorycreateedit() {
		$(".feecategorycreateedit").hide();
	}
	function viewcategories(value) {
		$("#" + value).fadeIn(1000);
	}
	function hidecategories(value) {
		$("#" + value).fadeOut(1000);
	}
	function hideChequeDetails() {
		$("#chequeDetails").empty();
		$("#chequeDetails").css("z-index", "-1");
	}
	function showChequeDetails(monthName, bankName, chequeNo, status,
			paidAmount) {
		$("#chequeDetails").empty();
		var chequeDetails = '<div class="block" style="background-color: white; opacity: 0.9; box-shadow: 0px 14px 21px 3px gray;"><div class="head" style="background-color:lightblue;padding-left:10px;">';
		chequeDetails += '<h2>Cheque Details for '
				+ monthName
				+ '</h2><ul class="buttons"><li><a href="javascript:hideChequeDetails();">';
		chequeDetails += '<div class="icon"><span class="ico-cancel"></span></div></a></li></ul></div>';
		chequeDetails += '<div class="data-fluid"><div class="row-form"><div class="span2"  style="margin-left: 0px;width:108px;">Bank Name :</div>';
		chequeDetails += '<div class="span2" style="margin-left: 0px;">'
				+ bankName + '</div></div></div><div class="data-fluid">';
		chequeDetails += '<div class="row-form"><div class="span2" style="margin-left: 0px;width:108px;">Cheque No :</div>';
		chequeDetails += '<div class="span2" style="margin-left: 0px;">'
				+ chequeNo + '</div></div></div><div class="data-fluid">';
		chequeDetails += '<div class="row-form"><div class="span2" style="margin-left: 0px;width:108px;">Paid Amount :</div>';
		chequeDetails += '<div class="span2" style="margin-left: 0px;">'
				+ paidAmount + '</div></div></div><div class="data-fluid">';
		chequeDetails += '<div class="row-form"><div class="span2" style="margin-left: 0px;width:108px;">Status :</div>';
		chequeDetails += '<div class="span2" style="margin-left: 0px;">'
				+ status + '</div></div></div></div>';
		$("#chequeDetails").css("z-index", "1");
		$("#chequeDetails").append(chequeDetails);
	}
</script>



<div class="content">
	<div id="content-header" style="height: 150px;">
		<img alt="Show_settings" src="${img_url}/employeeImages/salary.jpg"
			style="width: 50px; margin-top: -12px;">
		<h1>Allot Salary</h1>
		<h3>Allot Monthly Salary</h3>
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
	<c:if test="${msg!=null}">
		<div class="successmsg">${msg}</div>
	</c:if>
	<f:form action="save-salary" method="POST" commandName="employeeDTO"
		id="submitform">
		<div style="margin-top: 50px;">
			<table class="table table-bordered table-primary">
				<thead>
					<tr>
						<th>Employee Id</th>
						<th>Name</th>
						<th>Joining Date</th>
						<th>Assigned Class</th>
						<th>Qualification</th>
						<th>Salary</th>
						<th>View Details</th>

					</tr>
				</thead>
				<c:forEach var="list" items="${allemployees}" varStatus="loop"
					begin="0">
					<tr>
						<td>${list.id}</td>
						<td>${list.firstName}&nbsp;${list.lastName}</td>
						<td>${list.joiningDate}</td>
						<td>${list.className}&nbsp;${list.sectionName}</td>
						<td>${list.highestQualification}</td>
						<td><f:input path="employeeslist[${loop.index}].salary"
								onclick="removezero('${loop.index}');" value="${list.salary}"
								id="sal${loop.index}" /> <f:hidden
								path="employeeslist[${loop.index}].id" value="${list.id}" />
							<div id="err${loop.index}"></div></td>
						<td><a
							href="javascript:getEmployeeSalaryDetails(
														${list.id});"><span
								class="label label-primary">View Details</span></a></td>
				</c:forEach>


			</table>
			<a href="javascript:validatedata();" class="btn"
				style="margin-top: 35px; margin-left: 426px;">Save</a>
		</div>
	</f:form>
	<div class="feecategorycreateedit">
		<div class="feecategorycreateedit-header">
			<a href="javascript:hidefeecategorycreateedit();" class="close"
				data-dismiss="modal" style="margin-right: 10px; margin-top: 10px;"
				aria-hidden="true">×</a>
			<center>
				<h4 id="myModalLabel" style="padding-top: 5px;">Salary Payment
					Details</h4>
			</center>
		</div>

		<div class="row-fluid" style="margin-top: 20px;">
			<div class="block-fluid">

				<div class="row-form">
					<div class="span12">
						<div class="block" id="monthwithfeedetail"></div>
					</div>
				</div>

			</div>
		</div>
		<div class="feecategorycreateedit-footer"
			style="float: right; margin-top: -37px;">

			<a class="btn btn-warning" data-dismiss="modal"
				href="javascript:hidefeecategorycreateedit();"
				style="margin-right: 15px" aria-hidden="true">Close</a>
		</div>

	</div>
	<input type="hidden" value="${current.sessionId}" id="sessionId">
	<div id="chequeDetails"
		style="float: right; z-index: 3; height: 220px; position: fixed; top: 225px; right: 296px;">

	</div>
	<div id="ShowDetails"
		style="float: right; z-index: 1; height: 220px; position: fixed; top: 225px; right: 296px; left: 522px;width: 0px;">

	</div>
</div>
