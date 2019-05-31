<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url value="/style/theme/images" var="imageurl" />
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/img" var="img" />
<spring:url value="/img" var="img_url" />
<spring:url value="/css" var="css_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/setting.css">
<spring:url value="/style" var="style_url" />
<spring:url value="/style/js" var="words" />
<script type="text/javascript" src="${words}/towards.js">
	
</script>

<script>
	function viewcategories(value) {
		$("#" + value).fadeIn(1000);
	}
	function hidecategories(value) {
		$("#" + value).fadeOut(1000);
	}
	$(document).ready(function() {
		$("#flip").click(function() {
			$("#panel").slideToggle("slow");
		});
		
	});
	function getEmployeeSalaryDetails(id) {
		$("#panel").slideToggle("slow");
		$("#employeeId").val(id);
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
						$("#employeeDetails").empty();
						$("#payment").empty();
						var employeeDetail = '<div style="text-align: center; height: 33px; background-color: rgb(238, 238, 238); color: rgb(0, 136, 204); border: 1px solid lightgray; border-top-left-radius: 10px; border-top-right-radius: 10px; margin-top: 3px; width: 743px;">'
								+ '<a href="show-employee-details?id='
								+ obj.employeeDTO.id
								+ '">'
								+ obj.employeeDTO.firstName
								+ '&nbsp;'
								+ obj.employeeDTO.lastName
								+ '</a></div><div class="row-fluid"  style="border: 1px solid lightgray; height: 113px; border-bottom-left-radius: 10px; border-bottom-right-radius: 10px;"><div class="span6">';
						employeeDetail += '<div class="block"><div class="data-fluid"><div class="row-form"><div class="span5">Mobile No :</div>';
						employeeDetail += '<div class="span7">'
								+ obj.employeeDTO.mobile
								+ '</div></div></div><div class="data-fluid"><div class="row-form">';
						employeeDetail += '<div class="span5">Id :</div><div class="span7">'
								+ obj.employeeDTO.id
								+ '</div></div></div></div></div>';
						employeeDetail += '<div class="span6"><div class="block"><div class="data-fluid"><div class="row-form" style="padding-top: 0px;">';
						employeeDetail += '<div class="span3" style="width: 138px; height: 113px;float:right">'
								+ '<img src="${style_url}/employeeImages/'+obj.employeeDTO.imagename+'"'
					+'style="width: 127px; height: 113px;">'
								+ '</div></div></div></div>';
						$("#employeeDetails").append(employeeDetail);

						var monthwithfeedetail = '<div class="head green"><div class="icon"><span class="ico-brush"></span></div>';
						monthwithfeedetail += '<h2>Salary payment details</h2><ul class="buttons"><li><a href="#"><div class="icon">';
						monthwithfeedetail += '<span class="ico-info"></span></div></a></li></ul></div>';
						monthwithfeedetail += '<div class="data-fluid"><div class="classshowheader"><table width="100%" cellspacing="0" cellpadding="0" class="table table-hover" >';
						monthwithfeedetail += '<thead><tr><th style="background-color: #FFCC99" width="2%"></th>';//<input onclick="enableanddisable(this.checked);" type="checkbox"/>
						monthwithfeedetail += '<th style="background-color: #FFCC99" width="6%" >Month Name</th>';
						monthwithfeedetail += '<th style="background-color: #FFCC99"width="6%" >Opening Balance</th>';
						monthwithfeedetail += '<th style="background-color: #FFCC99" width="7%">Gross Amount</th>';
						monthwithfeedetail += '<th style="background-color: #FFCC99" width="8%">Attendance</th>';
						monthwithfeedetail += '<th style="background-color: #FFCC99" width="8%">Advance</th>';
						monthwithfeedetail += '<th style="background-color: #FFCC99" width="6%">Fine</th>';
						monthwithfeedetail += '<th style="background-color: #FFCC99" width="7%">Incentive</th>';
						monthwithfeedetail += '<th style="background-color: #FFCC99" width="8%" >Net Amount</th>';
						monthwithfeedetail += '<th style="background-color: #FFCC99"  width="9%">Paid Amount</th>';
						monthwithfeedetail += '<th style="background-color: #FFCC99" width="7%">Closing Balance</th>';
						monthwithfeedetail += '<th style="background-color: #FFCC99" width="6%" >Status</th>';
						monthwithfeedetail += '<th style="background-color: #FFCC99" width="8%">Type</th>';
						monthwithfeedetail += '<th style="background-color: #FFCC99" width="8%">Date</th>';
						monthwithfeedetail += '<th style="background-color: #FFCC99" width="6%">Paid By</th>';
						monthwithfeedetail += '<th style="background-color: #FFCC99" width="6%" >Slip</th></tr></thead></table></div>';
						monthwithfeedetail += '<div class="classshowheader" width="100%">';
						var neededMonthId = 0;
						var totalGrossAmount = 0;
						var totalFineAmount = 0;
						var totalNetAmount = 0;
						var totalPaidAmount = 0;
						var totalBalanceAmount = 0;
						var openingBalance = 0;
						var totalOpeningBalance = 0;
						var totalClosingBalance = 0;
						var advanceAmount = 0;
						var fineAmount = 0;
						var totalDiscountAmount = 0;
						var k = obj.EmployeeSalaryDTOs;
						neededMonthId = k[0].monthId - 1;

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
											monthwithfeedetail += '<div class="childone" width="100%"><table width="100%" cellspacing="0" cellpadding="0" class="table table-hover">';
											monthwithfeedetail += ' <tbody><tr>';

											if (value.status == 'YES') {
												monthwithfeedetail += '<td  width="2%" style="background-color: #FFFFCC;"><input  disabled="disabled" checked="checked" '
														+' type="checkbox" name="monthsId" id="month'
														+ value.monthId
														+ '"  value="'
														+ value.monthId
														+ '" /></td>';
												neededMonthId = value.monthId;
											} else {
												monthwithfeedetail += '<td  width="2%" style="background-color: #FFFFCC;"><input onclick="showChild(this.value,this.checked,'
														+ payAmount
														+ ','
														+ openingBalance
														+ ','
														+ value.advanceAmount
														+ ');" type="checkbox" disabled="disabled" name="monthsId"  id="month'
														+ value.monthId
														+ '" value="'
														+ value.monthId
														+ '" /></td>';
											}
											monthwithfeedetail += '<td  width="6%" style="background-color: #FFFFCC; ">'
													+ value.month + '</td>';
											monthwithfeedetail += '<td  width="6%" style="background-color: #FFFFCC;">'
													+ openingBalance
													+ '</td><td  width="7%" id="grossAmount'
													+ value.monthId
													+ '" style="background-color: #FFFFCC">'
													+ value.salaryAmount
													+ '</td><td  width="8%" style="background-color: #FFFFCC"><a href="javascript:viewcategories('
													+ value.monthId
													+ ');">'
													+ value.present
													+ '/'
													+ value.totalDays
													+ '</td><td width="7%" style="background-color: #FFFFCC"><a href="javascript:viewadvances('
													+ value.monthId
													+ ','
													+ id
													+ ','
													+ sessionId
													+ ');">'
													+ value.advanceAmount
													+ '</td><td  width="6%" style="background-color: #FFFFCC">'
													+ value.fineAmount
													+ '</td><td  width="7%" style="background-color: #FFFFCC">'
													+ value.incentive
													+ '</td><td  width="8%" style="background-color: #FFFFCC">'
													+ netAmount + '</td>';
											if (value.commonString == null) {
												monthwithfeedetail += '<td  width="9%" id="paidAmount'
														+ value.monthId
														+ '" style="background-color: #FFFFCC">'
														+ value.paidAmount
														+ '</td>';
											} else {
												monthwithfeedetail += '<td  width="9%" id="paidAmount'
														+ value.monthId
														+ '" style="background-color: #FFFFCC">'
														+ value.paidAmount
														+ '('
														+ value.commonString
														+ ')</td>';
											}
											monthwithfeedetail += '<td width="7%" style="background-color: #FFFFCC">'
													+ balanceAmount + '</td>';
											if (value.salaryPaidStatus == 'Completed') {
												monthwithfeedetail += '<td   width="6%" style="background-color: #FFFFCC"><img src=../img/right.PNG>'
														+ '</td>';
											} else if (value.salaryPaidStatus == 'InHand') {
												neededMonthId = 13;
												monthwithfeedetail += '<td  width="6%" style="background-color: #FFFFCC"><img src=../img/progress.gif>'
														+ '</td>';
											} else if (value.salaryPaidStatus == 'Cancel') {
												monthwithfeedetail += '<td  width="6%" style="background-color: #FFFFCC"><img src=../img/wrong.PNG>'
														+ '</td>';
											} else

												monthwithfeedetail += ' <td  width="6%" style="background-color: #FFFFCC"><span class="label label-warning">'
														+ value.salaryPaidStatus
														+ '</td>';
											monthwithfeedetail += ' <td  width="8%" style="background-color: #FFFFCC"><span class="label label-warning">'
													+ value.advance + '</td>';
											monthwithfeedetail += '<td  width="8%" style="background-color: #FFFFCC">'
													+ value.dateOfPayment
													+ '</td>';
											if (value.paidBy == 'cheque') {
												monthwithfeedetail += '<td  width="6%" style="background-color: #FFFFCC"><a href=javascript:showChequeDetails("'
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
												monthwithfeedetail += '<td  width="6%" style="background-color: #FFFFCC"><span class="label label-info">'
														+ value.paidBy
														+ '</span></td>';
											} else {
												monthwithfeedetail += '<td  width="6%" style="background-color: #FFFFCC">'
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
											monthwithfeedetail += '</tr></tbody></table>';
											monthwithfeedetail += '<div id="'+value.monthId+'" class="childtwo" style="width: 470px; margin-left: 25px;display: none;">';
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
											monthwithfeedetail += '</tbody></table></div></div>';
											totalOpeningBalance = parseInt(openingBalance);
											totalClosingBalance = balanceAmount;
											openingBalance = balanceAmount;
										});
						//monthwithfeedetail += '<div width="100%" class="childone"><table width="100%" cellspacing="0" cellpadding="0" class="table table-hover"> <tbody><tr><td style="background-color: #FFFFCC"></td><td width="10%" style="background-color: #FFFFCC"></td><td width="15%" style="background-color: #FFFFCC"></td><td width="15%" style="background-color: #FFFFCC"></td><td width="15%" style="background-color: #FFFFCC"></td><td width="15%" style="background-color: #FFFFCC"></td><td width="15%" style="background-color: #FFFFCC"><a id="showfeepaynemtbutton" href="javascript:showfeepaynemtform();" style="display:none;"><span class="label label-warning">Pay Fees</span></a></td></tr></tbody></table></div>';
						monthwithfeedetail += '<table width="100%" cellspacing="0" cellpadding="0" class="table table-hover"><tr><td width="8%" style="background-color: #F3F383">Total'
								+ '</td><td width="7%" style="background-color: #F3F383">'
								+ totalOpeningBalance
								+ '</td><td width="7%" style="background-color: #F3F383">'
								+ totalGrossAmount
								+ '</td><td width="7%" style="background-color: #F3F383">'

								+ '</td><td width="10%" style="background-color: #F3F383"></td><td width="7%" style="background-color: #F3F383">'
								+ totalNetAmount
								+ '</td><td width="8%" style="background-color: #F3F383">'
								+ totalPaidAmount
								+ '</td><td width=8%" style="background-color: #F3F383">'
								+ totalClosingBalance
								+ '</td><td width="9%" style="background-color: #F3F383">'
								+ '</td><td width="20%" style="background-color: #F3F383">'
								+ '</td></tr></table></div></div>';

						var payment = '<div class="block"style="width: 752px; left: 136px;"><div class="head green"style="width: 732px;"><div class="icon"><span class="ico-pen-2"></span></div>';
						payment += '<h2>Salary Payment</h2></div><div class="data-fluid">';
						payment += '<table style="width: 744px; border: 1px solid lightgray; font: 80%/1.2 Lucida califunia; height: 129px;">';
						payment += '<tbody><tr><td style="width: 30px;padding-left: 18px;">Gross Amount:</td><td style="width: 50px;">';
						payment += '<input type="text" readonly="readonly" style="height: 23px;" value="0" name="salaryAmount" id="totalAmount"></td>';
						payment += '<td style="width: 30px;padding-left: 18px;">Advance:</td> <td style="width: 50px;"><input type="text" readonly="readonly" style="height: 23px;" id="advanceAmount" value="0" name="advanceAmount"></td><td style="width: 30px;padding-left: 18px;">Fine:</td> <td style="width: 50px;">';
						payment += '<input type="text" style="height: 23px;" id="fineAmount" value="0" name="fineAmount" oninput="removeFine(this.value);" onclick="removeFineZero();"></td>';
						payment += '<td style="width: 70px;padding-left: 18px;"">Incentive ';
						payment += '  </td><td style="width: 50px;">';
						payment += ' <input type="text" name="incentive" style="height: 23px;" value="0" onclick="removeIncentiveZero();"oninput="addIncentive(this.value);" id="incentive">';
						payment += ' </td></tr><tr><td style="width: 30px;padding-left: 18px;" colspan="2">Net Payable Amt</td><td style="width: 50px;">';
						payment += ' <input type="text" style="height: 23px;" readonly="readonly" id="netPayableAmount" name="netPayableAmount"></td>';
						payment += '<td style="padding-left: 18px;">Paid Amt.</td><td><input type="text" style="height: 23px;" id="paidAmount" value="0" name="paidAmount" onclick="removezero();" oninput="converttowords(this.value);"></td>';
						payment += '<td style="width: 30px;padding-left: 18px;"><font color="red">Due </font>:</td><td style="width: 50px;"><input type="text" style="height: 23px;" readonly="readonly" name="dueAmount" id="dueAmount"></td>';
						payment += '</tr><tr><td style="width: 30px;padding-left: 18px;"colspan="2">Payment Type:</td>';
						payment += '<td style="width: 50px;"><select style="height: 23px;" class="validate[required]" onchange="getPaymentType(this.value)" name="paidBy" id="paymentType">';
						payment += '<option value="cash">Cash</option><option value="cheque">Cheque</option></select></td><td style="width: 30px;padding-left: 18px;">Cheque Number:</td>';
						payment += '<td style="width: 50px;"><input type="text" style="height: 23px;" readonly="readonly" maxlength="6" name="chequeNo" id="checkNo"></td>';
						payment += '<td style="width: 30px;padding-left: 18px;">Bank Name:</td><td style="width: 50px;"><input type="text" style="height: 23px;" readonly="readonly" name="bankName" id="bankName"></td>';
						payment += '</tr><tr><td colspan="2">Amount in words</td><td colspan="3"><input type="text" readonly="readonly" style="height: 23px;" id="paidAmountInWord" value="" name="paidAmountInWord"></td>';
						payment += '<td>/-Only</td><td><a id="submitfee" class="btn" href="javascript:validate();" style="display: none;">Submit</a></td></tr></tbody></table></div></div>';
						$("#payment").append(payment);
						$("#monthwithfeedetail").append(monthwithfeedetail);

						enableFirstCheckBox(neededMonthId + 1);
						$("#neededMonthId").val(neededMonthId + 1);
					},
					error : function(e) {

					}
				});
	}
	function hideChequeDetails() {
		$("#chequeDetails").empty();
		$("#chequeDetails").css("z-index", "-1");
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
						var classAssignDetails = '<div class="block" style="background-color: white; opacity: 0.9; box-shadow: 0px 14px 21px 3px gray;"><div class="head" style="background-color:lightblue;padding-left:10px;">';
						classAssignDetails += '<h2>Advance Details'

								+ '</h2><ul class="buttons"><li><a href="javascript:hideAdvanceDetails();">';
						classAssignDetails += '<div class="icon"><span class="ico-cancel"></span></div></a></li></ul></div>';
						if (value.length == 0) {
							var classAssignDetails = 'No advance taken in this session';
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
	function removeFine(fine) {
		$("#errormsg").empty();
		if (isNaN(fine) || fine == '') {
			$("#errormsg")
					.append(
							'<span><font color="red" size="2">Enter valid fine amount</font></span>');

			fine = 0;
		}
		$("#fineAmount").val(fine);
		var grossAmount = $("#totalAmount").val();
		var incentive = $("#incentive").val();
		var advance=$("#advanceAmount").val();
		var net = parseInt(grossAmount) + parseInt(incentive) - parseInt(fine)-parseInt(advance);
		$("#netPayableAmount").val(net);
	     $("#paidAmount").val(0);
			

	}
	function removeFineZero() {
		var fine = $("#fineAmount").val();
		if (fine == 0)
			$("#fineAmount").val('');
	}

	function addIncentive(incentive) {
		$("#errormsg").empty();
		if (isNaN(incentive) || incentive == '') {
			$("#errormsg")
					.append(
							'<span><font color="red" size="2">Enter valid incentive amount</font></span>');

			incentive = 0;
		}
		$("#incentive").val(incentive);
		var advance=$("#advanceAmount").val();
		var grossAmount = $("#totalAmount").val();
		var fine = $("#fineAmount").val();
		var net = parseInt(grossAmount) + parseInt(incentive) - parseInt(fine)-parseInt(advance);
		$("#netPayableAmount").val(net);
		 $("#paidAmount").val(0);

	}
	function removeIncentiveZero() {
		var incentive = $("#incentive").val();
		if (incentive == 0)
			$("#incentive").val('');
	}

	function removezero() {
		var paid = $("#paidAmount").val();
		if (paid == 0)
			$("#paidAmount").val('');
	}
	function converttowords(num) {
		$("#errormsg").empty();
		$("#submitfee").hide();
		if (isNaN($("#netPayableAmount").val()) || $("#netPayableAmount").val() == '') {
			
			num=0;
			alert("Select the month and net amount has to be greater than zero");
		}
		if (isNaN(num) || num == '') {
			$("#errormsg")
					.append(
							'<span><font color="red" size="2">Enter valid paid amount</font></span>');

			num = 0;
		}
		if (parseInt($("#netPayableAmount").val()) < parseInt(num)) {
			$("#errormsg")
					.append(
							'<span><font color="red" size="2">Paid Amount should be less than or equal to Net Payable Amount</font></span>');

			num = 0;
		}
		$("#paidAmount").val(num);

		$("#dueAmount").val(
				parseInt($("#netPayableAmount").val()) - parseInt(num));
		if (num > 0) {
			$("#submitfee").show();
			var word = toWords(num);
			$("#paidAmountInWord").val(word);
		}
	}
	function getPaymentType(type) {
		$('#checkNo').val('');
		$('#bankName').val('');
		if (type == 'cheque') {
			$('#bankName').attr("readonly", false);
			$('#checkNo').attr("readonly", false);
		}
		if (type == 'cash') {
			$('#bankName').attr("readonly", true);
			$('#checkNo').attr("readonly", true);
		}
	}
	function validate() {
		flage = true;
		var incentive = $("#incentive").val();
		var fine = $("fineAmount").val();
		if (incentive == '') {
			$("#incentive").val(0);
		}
		if (fine == '') {
			$("fineAmount").val(0);
		}
		$("#errormsg").empty();
		if ($("#paymentType").val() == 'cheque' && $("#bankName").val() == '') {
			flage = false;
			$("#errormsg")
					.append(
							'<span><font color="red" size="2">Enter Bank Name</font></span>');
		}
		if ($("#paymentType").val() == 'cheque'
				&& ($("#checkNo").val() == '' || $("#checkNo").val().length < 6)) {
			flage = false;
			$("#errormsg")
					.append(
							'<span><font color="red" size="2">Enter 6 digit valid Cheque No.</font></span>');

		} else if ($("#paymentType").val() == 'cheque'
				&& $("#checkNo").val() == '') {
			flage = false;
			$("#errormsg")
					.append(
							'<span><font color="red" size="2">Enter 6 digit valid Cheque No.</font></span>');

		} else if ($("#paidAmount").val() == '' || $("#paidAmount").val() <= 0) {
			flage = false;
			$("#errormsg")
					.append(
							'<span><font color="red" size="2">Enter Amount to be paid</font></span>');
		}
		if (flage) {
			$("#validateform").submit();
			location.reload(true);
		}

	}
	function showChild(value, checked, grossAmount, openingBalance, advances) {

		var fine = $("#fineAmount").val();
		var incentive = $("#incentive").val();
		var advance = parseInt($("#advanceAmount").val()) + parseInt(advances);
		if (checked) {
			var net = parseInt(grossAmount) + parseInt(incentive)
					- parseInt(fine) - parseInt(advance);
			$("#totalAmount").val(parseInt(grossAmount));
			$("#fineAmount").val(parseInt(fine));
			$("#advanceAmount").val(parseInt(advance));
			$("#netPayableAmount").val(net);
			if ($("#paidAmount").val() == '') {
				$("#due").val($("#netPayableAmount").val());
			} else {
				$("#due").val(
						$("#netPayableAmount").val() - $("#paidAmount").val());
			}
			//$("#showfeepaynemtbutton").show();
			$("#month" + (parseInt(value) + 1)).prop("disabled", false);
		} else {
			if (value == $("#neededMonthId").val()) {
				$("#showfeepaynemtbutton").hide();
				//$("#payment").hide();
			}
			for (i = 12; i > value; i--) {
				if ($("#month" + i).is(':checked')
						&& !$("#month" + i).is(':disabled')) {
					$("#month" + i).click();
					$("#month" + i).prop("disabled", true);
				} else {
					$("#month" + i).prop("disabled", true);
				}
			}

			var net = parseInt(openingBalance) + parseInt(incentive)
					- parseInt(fine) - parseInt(advances);
			var advance = parseInt($("#advanceAmount").val())
					- parseInt(advances);
			$("#totalAmount").val(openingBalance);
			$("#fineAmount").val(parseInt(fine));
			$("#advanceAmount").val(advance);
			$("#netPayableAmount").val(net);
			$("#paidAmount").val('');
			$("#due").val(parseInt(net));
			/* if ($("#discountAmount").val() == 0) {
				$("#disAmount").val('');
				$("#recentPaidAmount").val('');
				$("#due").val('');
				$("#submitfee").hide();
			} */

		}
	}

	function enableFirstCheckBox(value) {
		$("#month" + value).prop("disabled", false);
	}
	function getNewEmployees() {
		$("#monthwithfeedetail").empty();
		$("#employeeDetails").empty();
		$("#payment").empty();
	}
</script>






<div class="content">
	<div id="content-header" style="height: 150px;">
		<img alt="Show_settings" src="${img_url}/salary.jpg"
			style="width: 50px; margin-top: -12px;">
		<h1>Collect Fees</h1>
		<h3>collect fees</h3>
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
	<!-- action="fee-payment" -->
	<f:form commandName="EmployeeSalaryDTO" method="POST" id="validateform"
		target="_blank" action="salary-payment">

		<div class="row-fluid">
			<div class="span4" style="margin-left: 348px;">
				<div class="block" style="width: 299px;">
					<div id="searches"
						style="height: auto; width: 297px; background-color: rgb(238, 238, 238); border-radius: 5px;">
						<div class="data-fluid">
							<div class="row-form">
								<div class="span4">Session :</div>
								<div class="span8">
									<select id="sessionId" class="validate[required]"
										onchange="getNewEmployees();" name="sessionId" class="select">

										<c:forEach var="list" items="${sessionList}">
											<c:choose>
												<c:when test="${current.sessionId==list.sessionId}">
													<option selected="selected" value="${list.sessionId}">${list.sessionDuration}</option>
												</c:when>
												<c:otherwise>
													<option value="${list.sessionId}">${list.sessionDuration}</option>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</select>
								</div>
							</div>
						</div>
						<input type="hidden" name="employeeId" id="employeeId"> <input
							type="hidden" id="neededMonthId">
						<div class="separator"></div>
					</div>
				</div>
			</div>
			<div class="span8" id="employeeDetails"
				style="width: 718px; margin-left: -42px; height: 164px; float: right;"></div>
		</div>

		<div id="chequeDetails"
			style="float: right; z-index: -1; height: 220px; position: fixed; top: 225px; right: 296px;">

		</div>
		<div id="ShowDetails"
			style="float: right; z-index: 1; height: 220px; position: fixed; top: 225px; right: 296px; width: 309px; left: 792px;">

		</div>
		<div class="row-fluid" style="width: 1079px;">
			<div class="span4" style="width: 300px;">
				<div class="block" id="appendStudentName" class="block"
					style="top: -160px; margin-bottom: 0px; width: 199px;">
					<div class="span12">
						<div class="head green" id="flip">
							<div class="icon">
								<span class="ico-pen-2"></span>
							</div>
							<h2>Employee Details</h2>
						</div>
						<div class="data-fluid" id="panel" style="z-index:2;position:absolute;">
							<table width="100%" cellspacing="0" cellpadding="0" class="table" style="width: 199px;">
								<thead>
									<tr>

										<th style="background-color: #FFCC99">Employee Name</th>

									</tr>
								</thead>
								<tbody>
									<c:forEach var="list" items="${allemployees}" varStatus="loop"
										begin="0">
										<tr>

											<td width="40%" style="padding: 7px 0px 0px;"><a
												href="javascript:getEmployeeSalaryDetails(
														'${list.id} ');">
													${list.firstName}&nbsp;${list.lastName}</a></td>
											<%-- <td width="40%" style="padding: 7px 0px 0px;"><a
												href="javascript:getEmployeeSalaryDetails(
														'${list.id} ');">View
													Salary</a></td> --%>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
			<div class="span8" style="width: 765px; margin-left: 14px;">
				<div class="block"
					style="float: right; width: 1052px; margin-right: 18px;z-index:0;"
					id="monthwithfeedetail"></div>
			</div>
		</div>
		<div id="errormsg"
			style="width: 654px; margin: 25px auto 0px; float: left;"></div>
		<div id="payment">
			<div id="err" class="form-inline" style="float: left;">
				<p id="v1"></p>
			</div>
		</div>

		<div id="subButton" style="width: 654px; float: left;"></div>
	</f:form>


</div>