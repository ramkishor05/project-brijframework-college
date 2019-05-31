<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url value="/style/theme/images" var="imageurl" />
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/img" var="img_url" />
<spring:url value="/css" var="css_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/setting.css">
<spring:url value="/style/js" var="words" />
<script type="text/javascript" src="${words}/towards.js">
	
</script>
<style>
#err {
	color: red;
	font-weight: normal;
	font-size: 20px;
	padding: 2px 8px 0px;
	margin-top: 2px;
	margin-bottom: -2px;
}
</style>
<script>
	function getSectionList(id) {
		$.ajax({
			type : "post",
			url : 'getsectionlist/' + id,
			success : function(data, status) {
				$("#sectionId").empty();
				var j = JSON.parse(data);
				var content = '<option value="">Select Section</option>';
				for (var i = 0; i < j.length; i++) {
					content += '<option value='+j[i].sectionId+'>'
							+ j[i].sectionName + '</option>';
				}
				$("#sectionId").append(content);
			},
			error : function(e) {
				
			}
		});
	}

	function getStudentList() {
		var sessionId = $('#sessionId').val();
		var classId = $('#classId').val();
		var sectionId = $('#sectionId').val();
		if (sessionId == '' || classId == '' || sectionId == '') {
			alert("Fill Above Data First. Please!!");
		} else {
			$.ajax({
				type : "post",
				url : 'get-student-list',
				data : {
					'classId' : classId,
					'sectionId' : sectionId,
					'sessionId' : sessionId,
				},
				success : function(data, status) {
					$("#studentId").empty();
					var j = JSON.parse(data);
					var students = '<option value="">Select Student</option>';
					for (var i = 0; i < j.length; i++) {
						students += '<option value='+j[i].admissionNo+'>'
								+ j[i].fullName + '</option>';
					}
					$("#studentId").append(students);
				},
				error : function(e) {
					
				}
			});
		}
	}
	function getMonth(monthId) {

		var month = new Array(12);
		month[0] = "Janury";
		month[1] = "Feb";
		month[2] = "March";
		month[3] = "April";
		month[4] = "May";
		month[5] = "June";
		month[6] = "July";
		month[7] = "Aug";
		month[8] = "Sept";
		month[9] = "Oct";
		month[10] = "Nov";
		month[11] = "Dec";

		return month[monthId - 1];
	}

	function onclickablecheckbox(monthId, flage) {
		var sessionId = $('#sessionId').val();
		var classId = $('#classId').val();
		var sectionId = $('#sectionId').val();
		var studentId = $('#studentId').val();
		var monthName = getMonth(monthId);
		$
				.ajax({
					type : "post",
					url : 'get-student-fee-allotment',
					data : {
						'sessionId' : sessionId,
						'classId' : classId,
						'sectionId' : sectionId,
						'studentId' : studentId,
						'monthId' : monthId
					},
					success : function(data, status) {
						if (!flage) {
							$("#" + monthId).remove();
						}
						$('#subButton').empty();
						var j = JSON.parse(data);
						var feeAllotment = '<div class="widget-body" id="'
								+ monthId
								+ '" style="padding: 10px 0 0;font:80%/1.2 Lucida Califunia;"><div class="separator"></div><div class="btn-group" style="width: 1059px;">'
								+ '</div><div class="block"><div class="head blue"><div class="icon"><span class="ico-pen-2"></div>Student Fee Details('
								+ monthName
								+ ')</span></div>'
								+ '<table class="table table-bordered table-primary"><th>Name</th><th>Paid Amount</th>';
						var classFee = j.classWiseFeeDTOs;
						var sectionFee = j.sectionWiseFeeDTOs;
						var studentFee = j.studentWiseFeeDTOs;
						var lateFine = j.fineAmount;
						var totalFee = 0;
						for (var k = 0; k < classFee.length; k++) {
							totalFee += parseInt(classFee[k].feeAmount);
							feeAllotment += '<tr><td>'
									+ classFee[k].feesCategoriesName
									+ '</td><td>' + classFee[k].feeAmount
									+ '</td></tr>';
						}
						for (var k = 0; k < sectionFee.length; k++) {
							totalFee += parseInt(sectionFee[k].feeAmount);
							feeAllotment += '<tr><td>'
									+ sectionFee[k].feesCategoriesName
									+ '</td><td>' + sectionFee[k].feeAmount
									+ '</td></tr>';
						}
						for (var k = 0; k < studentFee.length; k++) {
							totalFee += parseInt(studentFee[k].feeAmount);
							feeAllotment += '<tr><td>'
									+ studentFee[k].feesCategoriesName
									+ '</td><td>' + studentFee[k].feeAmount
									+ '</td></tr>';
						}
						if (j.fineAmount != '') {
							feeAllotment += '<tr><td>Late Fine</td><td>'
									+ j.fineAmount + '</td></tr>';
						}
						feeAllotment += '</table></div>';
						var val = $('#totalAmount').val();
						var dis = $('#discountAmount').val();
						var fine = $('#fineAmount').val();
						var due = $('#due').val();
						if (flage) {
							$('#totalAmount').val(
									parseInt(val) + parseInt(totalFee));
							if (dis != '') {
								$('#discountAmount').val(
										parseInt(totalFee) + parseInt(lateFine)
												+ parseInt(dis));
							} else {
								$('#discountAmount')
										.val(
												parseInt(totalFee)
														+ parseInt(lateFine));
							}
							$('#fineAmount').val(
									parseInt(fine) + parseInt(lateFine));
							//converttowords($("#recentPaidAmount").val());
						} else {
							$('#totalAmount').val(
									parseInt(val) - parseInt(totalFee));
							var n = parseInt(totalFee) + parseInt(lateFine);
							$('#discountAmount').val(
									parseInt(dis) - parseInt(n));
							$('#fineAmount').val(
									parseInt(fine) - parseInt(lateFine));
							//converttowords($("#recentPaidAmount").val());
						}
						if (flage) {
							$("#feeAllotment").append(feeAllotment);
						}
					 	$('#subButton')
								.append(
										'<a href="javascript:validate();" class="btn" id="submitfee">Submit Fee</a>'); 
										$("#submitfee").hide();
						$('#discounts').val(0);
					},
					error : function(e) {
						
					}
				});
	}
	function getDiscount(value) {

		var totalAmount = $('#totalAmount').val();
		var fine = $('#fineAmount').val();
		var disType;
		if ($("#per").is(":checked")) {
			disType = 'per';
		} else if ($("#rs").is(":checked")) {
			disType = 'rs';
		} else {
			alert('Select Discount Type');
		}
		if (isNaN(value) || value == '') {
			alert('Enter Valid Amount');
			var totalAmount = $('#totalAmount').val();
			var fine = $('#fineAmount').val();
			var due = $('#due').val();
			var discountAt = parseInt(totalAmount) + parseInt(fine);
			$('#discountAmount').val(discountAt);
			$('#discounts').val(0);
			converttowords($("#recentPaidAmount").val());
		} else if (disType == 'per') {
			var discount = Math.round(parseInt(totalAmount) * parseInt(value)
					/ 100);
			var discountAmount = Math.round(totalAmount - discount
					+ parseInt(fine));
			$('#discountAmount').val(discountAmount);
			$('#discounts').val(discount);
			converttowords($("#recentPaidAmount").val());
		} else if (disType == 'rs') {
			var discount = Math.round(parseInt(value));
			var discountAmount = Math.round(parseInt(totalAmount)
					- parseInt(value) + parseInt(fine));
			$('#discountAmount').val(discountAmount);
			$('#discounts').val(discount);
			converttowords($("#recentPaidAmount").val());
		}
	}
	function disAmountType() {
		$('#disAmount').val(0);
	}
	function converttowords(num) {
		
		if (parseInt($("#discountAmount").val()) >= parseInt(num)) {
			if (num == '' || num == '0') {
				$("#due").val($("#discountAmount").val());
			} else {
				$("#due").val(
						parseInt($("#discountAmount").val()) - parseInt(num));
			}
		
			$("#submitfee").show();
			document.getElementById("v1").innerHTML = "";
		} else {
			//alert("Paid Amount should be lessthan or equal to net payable amount");
		//	num=$("#discountAmount").val();
		$("#recentPaidAmount").val('');
		num='0';
		document.getElementById("v1").innerHTML = "Paid Amount should be less than or equal to Net Payable Amount";
			$("#submitfee").hide();
		}
		var word = toWords(num);
		$("#paidAmountInWord").val(word);

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
	function getStudentFeeDetails(id) {
		var thismonth = '${thismonth}';
		var sessionId = $('#sessionId').val();
		var classId = $('#classId').val();
		var sectionId = $('#sectionId').val();
		$("#prevYearFeeDetails").append(prevYearFeeDetails);
		if (classId == '' || sectionId == '') {
			alert("Fill Above Data First. Please!!");
		} else {
			$
					.ajax({
						type : "get",
						url : 'get-student-fee-payment',
						data : {
							'id' : id,
							'sessionId' : sessionId
						},
						success : function(data, status) {
							$("#feeDetails").empty();
							$("#month").empty();
							$("#payment").empty();
							$("#feeAllotment").empty();
							$("#prevYearFeeDetails").empty();
							var j = JSON.parse(data);
							var prvList = j.prvList;
							var feeDetails = '<div class="widget-body" style="padding: 10px 0 0;font:80%/1.2 Lucida Califunia;width:320px;"><div class="separator"></div><div class="btn-group"">'
									+ '</div><div class="block" style="width: 435px;"><div class="head blue"><div class="icon"><span class="ico-pen-2"></span></div><h2>Fee Details(Current Year)</h2></div><div class="data-fluid">'
									+ '<table class="table table-bordered table-primary"><th>Date</th><th>Month</th><th>Amount</th><th>Fine</th><th>Paid Status</th><th>PDF</th>';
							var prevYearFeeDetails = '<div class="widget-body" style="padding: 10px 0 0;font:80%/1.2 Lucida Califunia;width:320px;"><div class="separator"></div><div class="btn-group">'
									+ '</div><div class="block"><div class="head blue"><div class="icon"><span class="ico-pen-2"></span></div><h2>Fee Details(PrevYear)</h2></div><div class="data-fluid">'
									+ '<table class="table table-bordered table-primary"><th>Month</th><th>Amount</th><th>Fine</th><th>Paid Status</th>';
							var month = '<div style="padding: 10px;height:40px; width:630px;border:1px solid lightgray;font:80%/1.2 Lucida Califunia;float:left"><b>Select Month</b><br><br>';
							var payment = '<div class="block"><div class="head blue"><div class="icon"><span class="ico-pen-2"></span></div><h2>Fee Categories</h2></div><div class="data-fluid">'
									+ '<table style="width: 694px; border: 1px solid lightgray; font: 80%/1.2 Lucida califunia; height: 129px;"><tr><td style="width: 30px;">Gross Amount:</td><td style="width: 50px;"><input type="text" id="totalAmount" name="paidAmount" value="0" style="height: 23px;" readonly="readonly"></td>'
									+ '</td><td style="width: 30px;">Fine:</td><td style="width: 50px;"><input type="text" name="fineAmount" value="0" id="fineAmount" style="height: 23px;" readonly="readonly"></td><td style="width: 70px;">Discount in % <input type="radio" onclick="disAmountType();" name="dis" value="per" id="per"> / Rs <input type="radio" onclick="disAmountType();" name="dis" id="rs" value="rs">:</td>'
									+ '<td style="width: 50px;"><input type="text" id="disAmount" onkeyup="getDiscount(this.value)" onclick="getzeroremoved();" value="0" style="height: 23px;">'
									+ '</tr><tr><td style="width: 30px;">Net Payable Amt</td><td style="width: 50px;"><input type="text" name="netPayableAmount" id="discountAmount" readonly="readonly" style="height: 23px;"></td>'
									+ '<td>Paid Amt.</td><td><input type="text"  oninput="converttowords(this.value);" onclick="removezero();" name="recentPaidAmount" value="0" id="recentPaidAmount" style="height: 23px;"></td><td style="width: 30px;"><font color="red">Due </font>:</td><td style="width: 50px;"><input type="text" id="due" name="dueAmount" readonly="readonly" style="height: 23px;"></td></tr>'
									+ '<tr><td style="width: 30px;">Payment Type:</td><td style="width: 50px;"><select id="paymentType" name="paidBy" onchange="getPaymentType(this.value)" class="validate[required]"  style="height: 23px;">'
									+ '<option value="cash">Cash</option><option value="cheque">Cheque</option></select></td><td style="width: 30px;">Cheque Number:</td><td style="width: 50px;"><input type="text" id="checkNo" name="chequeNo" maxlength="6" readonly="readonly" style="height: 23px;"></td>'
									+ '<td style="width: 30px;">Bank Name:</td><td style="width: 50px;"><input type="text" id="bankName" name="bankName" readonly="readonly" style="height: 23px;"></td></tr><tr><td>Amount in words</td><td colspan="4"><input type="text" name="paidAmountInWord" value="" id="paidAmountInWord" style="height: 23px;" readonly="readonly"></td><td>/-Only</td></tr></table>';

							var neededMonthId = '';
							var inprogressMonthId = '';
							$
									.each(
											j.monthDTOs,
											function(key, value) {
												if (value.monthId != 13) {
													if (thismonth > 3) {
														if (value.monthId > 3) {
															if (value.monthId < thismonth) {
																if (value.feePaymentStatus == '') {
																	month += '<input type="checkbox" id="month'
																			+ value.monthId
																			+ '" name="monthsId" style="margin-top: -3px;" disabled="disabled" value="'
																			+ value.monthId
																			+ '" onClick="getFeeAllotment(this.value,this.checked);"><font color="red">'
																			+ value.monthName
																			+ '</font>&nbsp;&nbsp;&nbsp;&nbsp;';
																} else if (value.feePaymentStatus == "INPROGRESS") {
																	month += '<input type="checkbox" id="month'+value.monthId+'" style="margin-top: -3px;" checked="checked" disabled="disabled"><font color="blue">'
																			+ value.monthName
																			+ '</font>&nbsp;&nbsp;&nbsp;&nbsp;';
																	inprogressMonthId = value.monthId;
																} else {
																	month += '<input type="checkbox" id="month'+value.monthId+'" style="margin-top: -3px;" checked="checked" disabled="disabled"><font color="green">'
																			+ value.monthName
																			+ '</font>&nbsp;&nbsp;&nbsp;&nbsp;';

																	neededMonthId = value.monthId;
																}
															} else {
																if (value.feePaymentStatus == '') {
																	month += '<input type="checkbox" id="month'
																			+ value.monthId
																			+ '" name="monthsId" style="margin-top: -3px;" disabled="disabled" value="'
																			+ value.monthId
																			+ '" onClick="getFeeAllotment(this.value,this.checked);">'
																			+ value.monthName
																			+ '&nbsp;&nbsp;&nbsp;&nbsp;';
																} else if (value.feePaymentStatus == "INPROGRESS") {
																	month += '<input type="checkbox" id="month'+value.monthId+'" style="margin-top: -3px;" checked="checked" disabled="disabled"><font color="blue">'
																			+ value.monthName
																			+ '</font>&nbsp;&nbsp;&nbsp;&nbsp;';
																	inprogressMonthId = value.monthId;
																} else {
																	month += '<input type="checkbox" id="month'+value.monthId+'" style="margin-top: -3px;" checked="checked" disabled="disabled"><font color="green">'
																			+ value.monthName
																			+ '</font>&nbsp;&nbsp;&nbsp;&nbsp;';

																	neededMonthId = value.monthId;
																}
															}

														} else {
															if (value.feePaymentStatus == '') {
																month += '<input type="checkbox" id="month'
																		+ value.monthId
																		+ '" name="monthsId" style="margin-top: -3px;" disabled="disabled" value="'
																		+ value.monthId
																		+ '" onClick="getFeeAllotment(this.value,this.checked);">'
																		+ value.monthName
																		+ '&nbsp;&nbsp;&nbsp;&nbsp;';
															} else if (value.feePaymentStatus == "INPROGRESS") {
																month += '<input type="checkbox" id="month'+value.monthId+'" style="margin-top: -3px;" checked="checked" disabled="disabled"><font color="blue">'
																		+ value.monthName
																		+ '</font>&nbsp;&nbsp;&nbsp;&nbsp;';
																inprogressMonthId = value.monthId;
															} else {
																month += '<input type="checkbox" id="month'+value.monthId+'" style="margin-top: -3px;" checked="checked" disabled="disabled"><font color="green">'
																		+ value.monthName
																		+ '</font>&nbsp;&nbsp;&nbsp;&nbsp;';
																neededMonthId = value.monthId;
															}
														}
													} else {
														if (value.monthId > 3) {
															if (value.feePaymentStatus == '') {
																month += '<input type="checkbox" id="month'
																		+ value.monthId
																		+ '" name="monthsId" style="margin-top: -3px;" disabled="disabled" value="'
																		+ value.monthId
																		+ '" onClick="getFeeAllotment(this.value,this.checked);"><font color="red">'
																		+ value.monthName
																		+ '</font>&nbsp;&nbsp;&nbsp;&nbsp;';
															} else if (value.feePaymentStatus == "INPROGRESS") {
																month += '<input type="checkbox" id="month'+value.monthId+'" style="margin-top: -3px;" checked="checked" disabled="disabled"><font color="blue">'
																		+ value.monthName
																		+ '</font>&nbsp;&nbsp;&nbsp;&nbsp;';
																inprogressMonthId = value.monthId;
															} else {
																month += '<input type="checkbox" id="month'+value.monthId+'" style="margin-top: -3px;" checked="checked" disabled="disabled"><font color="green">'
																		+ value.monthName
																		+ '</font>&nbsp;&nbsp;&nbsp;&nbsp;';
																neededMonthId = value.monthId;
															}
														} else {
															if (value.monthId < thismonth) {
																if (value.feePaymentStatus == '') {
																	month += '<input type="checkbox" id="month'
																			+ value.monthId
																			+ '" name="monthsId" style="margin-top: -3px;" disabled="disabled" value="'
																			+ value.monthId
																			+ '" onClick="getFeeAllotment(this.value,this.checked);"><font color="red">'
																			+ value.monthName
																			+ '</font>&nbsp;&nbsp;&nbsp;&nbsp;';
																} else if (value.feePaymentStatus == "INPROGRESS") {
																	month += '<input type="checkbox" id="month'+value.monthId+'" style="margin-top: -3px;" checked="checked" disabled="disabled"><font color="blue">'
																			+ value.monthName
																			+ '</font>&nbsp;&nbsp;&nbsp;&nbsp;';
																	inprogressMonthId = value.monthId;
																} else {
																	month += '<input type="checkbox" id="month'+value.monthId+'" style="margin-top: -3px;" checked="checked" disabled="disabled"><font color="green">'
																			+ value.monthName
																			+ '</font>&nbsp;&nbsp;&nbsp;&nbsp;';

																	neededMonthId = value.monthId;
																}
															} else {
																if (value.feePaymentStatus == '') {
																	month += '<input type="checkbox" id="month'
																			+ value.monthId
																			+ '" name="monthsId" style="margin-top: -3px;" disabled="disabled" value="'
																			+ value.monthId
																			+ '" onClick="getFeeAllotment(this.value,this.checked);">'
																			+ value.monthName
																			+ '&nbsp;&nbsp;&nbsp;&nbsp;';
																} else if (value.feePaymentStatus == "INPROGRESS") {
																	month += '<input type="checkbox" id="month'+value.monthId+'" style="margin-top: -3px;" checked="checked" disabled="disabled">'
																			+ value.monthName
																			+ '&nbsp;&nbsp;&nbsp;&nbsp;';
																	inprogressMonthId = value.monthId;
																} else {
																	month += '<input type="checkbox" id="month'+value.monthId+'" style="margin-top: -3px;" checked="checked" disabled="disabled">'
																			+ value.monthName
																			+ '&nbsp;&nbsp;&nbsp;&nbsp;';

																	neededMonthId = value.monthId;
																}
															}

														}
													}

												}

											});
							$
									.each(
											prvList,
											function(key, value) {
												if (prvList[0] != '') {
													prevYearFeeDetails += '<tr><td style="color:red">'
															+ getMonth(value[2])
															+ '</td><td style="color:red">'
															+ value[0]
															+ '</td><td style="color:red">'
															+ value[1]
															+ '</td><td style="color:red">'
															+ value[3]
															+ '</td>';
												}
											});
							$
									.each(
											j.feecategoryAmountDTOs,
											function(key, value) {
												if (value.sessionId == sessionId) {
													if (value.feePaidStatus == 'inprogress') {
														feeDetails += '<tr><td style="background-color: blue;">'
																+ value.feePaidDate
																+ '</td><td style="background-color: blue;">'
																+ value.month
																+ '</td><td style="background-color: blue;">'
																+ value.paidAmount
																+ '</td><td style="background-color: blue;">'
																+ value.fineAmount
																+ '</td><td style="background-color: blue;">'
																+ value.feePaidStatus
																+ '</td><td style="background-color: blue;"><a href="generatePDF.html?slipNo='
																+ value.slipNo
																+ '&studentAdmissionNo='
																+ value.studentAdmissionNo
																+ '" target="_blank">View</a></td></tr>';
													}
													if (value.feePaidStatus == 'cancel') {
														feeDetails += '<tr><td style="background-color: red;">'
																+ value.feePaidDate
																+ '</td><td style="background-color: red;">'
																+ value.month
																+ '</td><td style="background-color: red;">'
																+ value.paidAmount
																+ '</td><td style="background-color: red;">'
																+ value.fineAmount
																+ '</td><td style="background-color: red;">'
																+ value.feePaidStatus
																+ '</td><td style="background-color: red;"><a href="generatePDF.html?slipNo='
																+ value.slipNo
																+ '&studentAdmissionNo='
																+ value.studentAdmissionNo
																+ '" target="_blank">View</a></td></tr>';
													}
													if (value.feePaidStatus == 'completed') {
														feeDetails += '<tr><td>'
																+ value.feePaidDate
																+ '</td><td>'
																+ value.month
																+ '</td><td>'
																+ value.paidAmount
																+ '</td><td>'
																+ value.fineAmount
																+ '</td><td>'
																+ value.feePaidStatus
																+ '</td><td><a href="generatePDF.html?slipNo='
																+ value.slipNo
																+ '&studentAdmissionNo='
																+ value.studentAdmissionNo
																+ '" target="_blank">View</a></td></tr>';
													}
												}
											});
							month += '</div>';
							feeDetails += '</tr></table></div>';
							prevYearFeeDetails += '</tr></table></div>';
							payment += '</div>';
							$("#prevYearFeeDetails").append(prevYearFeeDetails);
							$("#feeDetails").append(feeDetails);
							$("#month").append(month);
							$("#payment").append(payment);
							$("#neededMonthId").val(neededMonthId);
							//disable allmonth checkbox if any month id in inprogress state
							if (inprogressMonthId != '') {
								disableAllIfInprogess(inprogressMonthId);
							} else {
								ablecheckbox(neededMonthId);
							}
						},
						error : function(e) {
							
						}
					});
		}
	}
	function disableAllIfInprogess(inprogressMonthId) {
		for (i = 12; i > checkboxId; i--) {
			$("#month" + i).attr("disabled", true);
		}
	}
	function getClear() {
		$("#classId").val('');
		$("#sectionId").val('');
		$("#studentId").val('');
	}
	function ablecheckbox(checkboxId) {
		if (checkboxId != '') {
			if (checkboxId == 12) {
				$("#month1").prop("disabled", false);
			} else {
				var id = parseInt(checkboxId) + 1;
				$("#month" + id).prop("disabled", false);
			}
		} else {
			$("#month4").prop("disabled", false);
		}
	}
	function getFeeAllotment(checkboxId, flage) {
		onclickablecheckbox(checkboxId, flage);
		if (flage == true) {
			if (checkboxId == 12) {
				$("#month1").prop("disabled", false);
			} else {
				var id = parseInt(checkboxId) + 1;
				if ($("#month" + id).is(':disabled')
						&& !$("#month" + id).is(':checked')) {
					$("#month" + id).prop("disabled", false);
				}
			}
		} else {
			if (checkboxId > 3) {
				for (i = 12; i > checkboxId; i--) {
					if ($("#month" + i).is(':checked')
							&& !$("#month" + i).is(':disabled')) {
						$("#month" + i).prop("checked", false);
						$("#month" + i).attr("disabled", true);
						onclickablecheckbox(i, $("#month" + i).is(':checked'));
					} else if (!$("#month" + i).is(':checked')
							&& !$("#month" + i).is(':disabled')) {
						$("#month" + i).attr("disabled", true);
					}
				}
				for (i = 3; i >= 1; i--) {
					if ($("#month" + i).is(':checked')
							&& !$("#month" + i).is(':disabled')) {
						$("#month" + i).prop("checked", false);
						$("#month" + i).attr("disabled", true);
						onclickablecheckbox(i, $("#month" + i).is(':checked'));
					} else if (!$("#month" + i).is(':checked')
							&& !$("#month" + i).is(':disabled')) {
						$("#month" + i).attr("disabled", true);
					}
				}
			} else {
				for (i = 3; i > checkboxId; i--) {
					if ($("#month" + i).is(':checked')
							&& !$("#month" + i).is(':disabled')) {
						$("#month" + i).prop("checked", false);
						$("#month" + i).attr("disabled", true);
						onclickablecheckbox(i, $("#month" + i).is(':checked'));
					} else if (!$("#month" + i).is(':checked')
							&& !$("#month" + i).is(':disabled')) {
						$("#month" + i).attr("disabled", true);
					}
				}

			}
		}
	}
	function validate() {
		flage = true;
		if ($("#paymentType").val() == 'cheque' && $("#bankName").val() == '') {
			flage = false;
			alert("Enter Bank Name Please");
		}
		if ($("#paymentType").val() == 'cheque' &&( $("#checkNo").val() == '' ||$("#checkNo").val().length<6)){
			flage = false;
			alert("Please Enter 6 digit valid Cheque No.");
			
		} 
		else if ($("#paymentType").val() == 'cheque' && $("#checkNo").val() == '') {
			flage = false;
			alert("Please Enter 6 digit valid Cheque No.");
		} 
		else if ($("#paymentType").val() == 'cheque'
				&& !$.isNumeric($("#checkNo").val())) {
			flage = false;
			alert("Cheque No. in numbers only.");
		}
		if (flage) {
			$("#validateform").submit();
			location.reload(true);
		}

	}
	function removezero()
	{
		var paid=$("#recentPaidAmount").val();
		if(paid==0)
		$("#recentPaidAmount").val('');
	}
	function getzeroremoved()
	{
		var discounts=$("#disAmount").val();
		if(discounts==0)
		$("#disAmount").val('');
	}
	
</script>


<div class="content">
	<div id="content-header" style="height: 150px;">
		<img alt="Show_settings" src="${img_url}/sfees.jpg"
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
	<f:form commandName="studentFeeSubmissionDetailsDTO" method="POST"
		id="validateform" target="_blank" action="fee-payment">
		<div id="searches" style="height: auto; width: auto;">
			<br> <br> <br>
			<table>
				<tr>
					<td style="width: 200px;">Session</td>
					<td><select id="sessionId" class="validate[required]"
						onchange="getClear();" style="width: 250px;" name="sessionId"
						class="select">
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
					</select></td>
				</tr>
				<tr>
					<td style="width: 200px;">Class</td>
					<td><select id="classId" class="validate[required]"
						style="width: 250px;" onchange="getSectionList(this.value);"
						name="classId" class="select">
							<option value="">Select a Class</option>
							<c:forEach var="list" items="${classesList}">
								<option value="${list.classId}">${list.className}</option>
							</c:forEach>
					</select></td>
				</tr>

				<tr>
					<td style="width: 200px;">Section</td>
					<td><select id="sectionId" class="validate[required]"
						onchange="getStudentList();" style="width: 250px;"
						name="sectionId" class="select">
							<option value="">Select a Section</option>
					</select></td>
				</tr>

				<tr>
					<td style="width: 200px;">Students</td>
					<td><select id="studentId" class="validate[required]"
						onchange="getStudentFeeDetails(this.value);" style="width: 250px;"
						name="studentAdmissionNo" class="select">
							<option value="">Select Student</option>
					</select></td>
				</tr>
				<tr>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td><div id="prevYearFeeDetails"
							style="width: 324px; float: right; margin: -190px 0px 0px 264px;"></div></td>
				</tr>
			</table>
			<f:hidden path="discount" id="discounts" />
			<input type="hidden" id="neededMonthId">
			<div class="separator"></div>
		</div>
		<hr>
		<div id="feeDetails"
			style="width: 328px; margin: 0px 0px 0px 0px; float: right;"></div>
		<div id="month" style="float: left;"></div>
		<div id="feeAllotment"
			style="width: 654px; margin: 25px auto 0px; float: left;"></div>
		<div id="payment"
			style="width: 694px; margin: 25px auto 0px; float: left;"></div>

		<div id="subButton" style="width: 654px; float: left;"></div>

	</f:form>
<div id="err" class="form-inline" style="float: left;">
		<p id="v1"></p>
	</div>

</div>