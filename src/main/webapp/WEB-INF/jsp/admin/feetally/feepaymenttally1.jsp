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

#payment {
	width: 730px;
	margin: 25px auto 0px;
	float: right;
	z-index: 1;
	top: 200px;
	background-color: white;
	width: 744px;
}
</style>
<script>
	function getSectionList(id) {
		$("#totalData").hide();
		$("#monthwithfeedetail").empty();
		$("#studentDetails").empty();
		$("#payment").empty();
		$("#studentAddmissionNoDiv").empty();
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
	function getStudentDatabyId(studentId) {

		$.ajax({
			type : 'post',
			url : 'get-studentdatabyId',
			data : {

				'studentId' : studentId,
			},
			success : function(data, status) {
				var j = JSON.parse(data);
				if (j.length == 0) {

				} else {
					$("#classId").val(j.classId);
					$("#sectionId").val(j.sectionId);
					getStudentFeeDetails(j.admissionNo);

				}

			},

			error : function(data, status) {

			}
		});

	}

	function getStudentList() {
		$("#totalData").hide();
		$("#monthwithfeedetail").empty();
		$("#studentDetails").empty();
		$("#payment").empty();
		$("#studentAddmissionNoDiv").empty();
		var sessionId = $('#sessionId').val();
		var classId = $('#classId').val();
		var sectionId = $('#sectionId').val();
		if (sessionId == '' || classId == '' || sectionId == '') {
			alert("Fill Above Data First. Please!!");
		} else {
			$
					.ajax({
						type : "post",
						url : 'get-student-list',
						data : {
							'classId' : classId,
							'sectionId' : sectionId,
							'sessionId' : sessionId,
						},
						success : function(data, status) {
							$("#appendStudentName").empty();
							var obj = JSON.parse(data);

							var appendStudentName = '<div class="span12"><div class="head green"><div class="icon"><span class="ico-pen-2"></span></div><h2>Students Details</h2></div>';
							appendStudentName += '<div class="data-fluid"><table width="100%" cellspacing="0" cellpadding="0" class="table"><thead><tr>';
							appendStudentName += '<th style="background-color:#FFCC99">Student Name</th><th style="background-color:#FFCC99">Father Name</th><th style="background-color:#FFCC99">Details</th></tr></thead><tbody>';
							$
									.each(
											obj,
											function(key, value) {
												
												if(value.transfer=="NO"){
												appendStudentName += '<tr><td width="40%" style="padding: 7px 0px 0px;"><a href="show-student-details?id='
														+ value.admissionNo
														+ '">'
														+ value.fullName
														+ '</a></td><td width="40%" style="padding: 7px 0px 0px;">'
														+ value.fatherName
														+ '</td><td width="20%" style="padding: 7px 0px 0px;"><a href=javascript:getStudentFeeDetails("'
														+ value.admissionNo
														+ '");>View Fees</a></td></tr>';
												}
											});
							appendStudentName += '</tbody></table></div></div>';

							$("#appendStudentName").append(appendStudentName);
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

							alert($('#fineAmount').val());
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
		if (isNaN(value) || value == '' || value < 0) {
			alert('Enter Valid Amount');
			var totalAmount = $('#totalAmount').val();
			var fine = $('#fineAmount').val();
			var due = $('#due').val();
			var discountAt = parseInt(totalAmount) + parseInt(fine);
			$('#discountAmount').val(discountAt);
			$('#disAmount').val(0);
			converttowords($("#recentPaidAmount").val());
		} else if (disType == 'per') {
			if (value > 100 || value < 0) {
				var amnt = parseInt($('#totalAmount').val())
						+ parseInt($('#fineAmount').val());
				$('#discountAmount').val(amnt);
				$('#disAmount').val(0);
				$('#due')
						.val(
								parseInt(amnt)
										- parseInt($('#recentPaidAmount').val()));
				alert('Enter Valid Discount');
			} else {
				var discount = Math.round(parseInt(totalAmount)
						* parseInt(value) / 100);
				var discountAmount = Math.round(totalAmount - discount
						+ parseInt(fine));
				$('#discountAmount').val(discountAmount);
				$('#discounts').val(discount);
				converttowords($("#recentPaidAmount").val());
			}
		} else if (disType == 'rs') {
			if (value > parseInt(totalAmount)
					+ parseInt($('#fineAmount').val())
					|| value < 0) {
				alert('Enter Valid Amount');
				var amnt = parseInt($('#totalAmount').val())
						+ parseInt($('#fineAmount').val());
				$('#discountAmount').val(amnt);
				$('#due')
						.val(
								parseInt(amnt)
										- parseInt($('#recentPaidAmount').val()));
				$('#disAmount').val(0);
			} else {
				var discount = Math.round(parseInt(value));
				var discountAmount = Math.round(parseInt(totalAmount)
						- parseInt(value) + parseInt(fine));
				$('#discountAmount').val(discountAmount);
				$('#discounts').val(discount);
				converttowords($("#recentPaidAmount").val());
			}
		}
	}
	function disAmountType() {
		$('#disAmount').val(0);
		$('#discountAmount').val(
				parseInt($('#totalAmount').val())
						+ parseInt($('#fineAmount').val()));
	}

	function converttowords(num) {

		if (num == '') {
			num = 0;
		}
		if (parseInt($("#discountAmount").val()) >= parseInt(num)) {
			if ($('#recentPaidAmount').val() == ''
					|| $('#recentPaidAmount').val() == null) {
				num = 0;
			}
			$("#due").val(parseInt($("#discountAmount").val()) - parseInt(num));
			/* 	$("#submitfee").show(); */
			$("#addfee").show();
			$("#v1").innerHTML = "";
		} else {
			$("#recentPaidAmount").val('');
			num = '0';
			$("#v1").innerHTML = "Paid Amount should be less than or equal to Net Payable Amount";
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
		var str=id;
		var str1=str.split("/");
		
		var thismonth = '${thismonth}';
		var sessionId = $('#sessionId').val();
		var classId = $('#classId').val();
		var sectionId = $('#sectionId').val();
		$("#studentAdmissionNo").val(id);
		if ($("#studentAddMoreData" + str[0] + "").html() != undefined) {
			
			remavetotalData(id);
		}
		if (classId == '' || sectionId == '') {
			alert("Fill Above Data First. Please!!");
		} else {
			$
					.ajax({
						type : "get",
						url : 'get-student-fee-payment-details',
						data : {
							'studentAdmissionNo' : id,
							'sessionId' : sessionId
						},
						success : function(data, status) {
							var obj = JSON.parse(data);
							$("#monthwithfeedetail").empty();
							$("#studentDetails").empty();
							$("#payment").empty();
							var studentDetails = '<div style="text-align: center; height: 33px; background-color: rgb(238, 238, 238); color: rgb(0, 136, 204); border: 1px solid lightgray; border-top-left-radius: 10px; border-top-right-radius: 10px; margin-top: 3px; width: 710px;">'
									+ obj.StudentDTO.fullName
									+ '<input type="hidden" id="fullName" value="'+obj.StudentDTO.fullName+'"></div><div class="row-fluid"  style="border: 1px solid lightgray; height: 113px; border-bottom-left-radius: 10px; border-bottom-right-radius: 10px;"><div class="span6">';
							studentDetails += '<div class="block"><div class="data-fluid"><div class="row-form"><div class="span5">Mobile No :</div>';
							studentDetails += '<div class="span7">'
									+ obj.StudentDTO.mobile
									+ '</div></div></div><div class="data-fluid"><div class="row-form">';
							studentDetails += '<div class="span5">Roll No :</div><div class="span7">'
									+ obj.StudentDTO.rollno
									+ '</div></div></div></div></div>';
							studentDetails += '<div class="span6"><div class="block"><div class="data-fluid"><div class="row-form" style="padding-top: 0px;">';
							studentDetails += '<div class="span3" style="width: 138px; height: 113px;float:right">'
									+ '<img src="${img}/studentImages/'+obj.StudentDTO.imageName+'"'
									+'style="width: 127px; height: 113px;">'
									+ '</div></div></div></div>';
							$("#studentDetails").append(studentDetails);

							var monthwithfeedetail = '<div class="head green"><div class="icon"><span class="ico-brush"></span></div>';
							monthwithfeedetail += '<h2>Fee Submission details</h2><ul class="buttons"><li><a href="#"><div class="icon">';
							monthwithfeedetail += '<span class="ico-info"></span></div></a></li></ul></div>';
							monthwithfeedetail += '<div class="data-fluid"><div class="classshowheader"><table width="100%" cellspacing="0" cellpadding="0" class="table table-hover">';
							monthwithfeedetail += '<thead><tr><th style="background-color: #FFCC99"></th>';//<input onclick="enableanddisable(this.checked);" type="checkbox"/>
							monthwithfeedetail += '<th style="background-color: #FFCC99" width="9%">Month Name</th>';
							monthwithfeedetail += '<th style="background-color: #FFCC99" width="9%">Opening Balance</th>';
							monthwithfeedetail += '<th style="background-color: #FFCC99" width="9%">Gross Amount</th>';
							monthwithfeedetail += '<th style="background-color: #FFCC99" width="9%">Fine Amount</th>';
							monthwithfeedetail += '<th style="background-color: #FFCC99" width="9%">Net Amount</th>';
							monthwithfeedetail += '<th style="background-color: #FFCC99" width="9%">Paid Amount</th>';
							monthwithfeedetail += '<th style="background-color: #FFCC99" width="9%">Discount Amount</th>';
							monthwithfeedetail += '<th style="background-color: #FFCC99" width="9%">Closing Balance</th>';
							monthwithfeedetail += '<th style="background-color: #FFCC99" width="9%">Status</th>';
							monthwithfeedetail += '<th style="background-color: #FFCC99" width="9%">Paid By</th>';
							monthwithfeedetail += '<th style="background-color: #FFCC99" width="9%">Reciept</th></tr></thead></table></div>';
							monthwithfeedetail += '<div class="classshowheader" width="100%">';
							var neededMonthId = 3;
							var inprogressMonthId = 0;
							var totalGrossAmount = 0;
							var totalFineAmount = 0;
							var totalNetAmount = 0;
							var totalPaidAmount = 0;
							var totalBalanceAmount = 0;
							var openingBalance = 0;
							var totalOpeningBalance = 0;
							var totalClosingBalance = 0;
							var discountAmount = 0;
							var totalDiscountAmount = 0;
							$
									.each(
											obj.StudentFeeSubmissionDetailsDTOs,
											function(key, value) {

												if (value.discountAmount == null) {
													discountAmount = 0;
												} else {
													discountAmount = value.discountAmount;
												}
												var netAmount = parseInt(openingBalance)
														+ parseInt(value.grossAmount)
														+ parseInt(value.fineAmount);
												totalGrossAmount += parseInt(value.grossAmount);
												totalFineAmount += parseInt(value.fineAmount);
												totalNetAmount += netAmount
														- parseInt(openingBalance);

												totalDiscountAmount += parseInt(discountAmount);
												if (value.paidAmount == '-') {
													value.paidAmount = 0;
													var balanceAmount = parseInt(netAmount)
															- parseInt(value.paidAmount)
															- parseInt(discountAmount);
													totalPaidAmount += parseInt(value.paidAmount);
												} else {
													var balanceAmount = parseInt(netAmount)
															- parseInt(value.paidAmount)
															- parseInt(discountAmount);
													totalPaidAmount += parseInt(value.paidAmount);
												}
												var payAmount = parseInt(openingBalance)
														+ parseInt(value.grossAmount);
												monthwithfeedetail += '<div class="childone" width="100%"><table width="100%" cellspacing="0" cellpadding="0" class="table table-hover">';
												monthwithfeedetail += ' <tbody><tr>';
												if (value.status == 'YES') {
													monthwithfeedetail += '<td style="background-color: #FFFFCC"><input disabled="disabled" checked="checked" onclick="showChild(this.value,this.checked,'
															+ payAmount
															+ ','
															+ value.fineAmount
															+ ','
															+ openingBalance
															+ ');" type="checkbox" name="feeSubmissionDetailsDTOs[0].monthsId" id="month'
															+ value.monthId
															+ '"  value="'
															+ value.monthId
															+ '" /></td>';
													if (value.feePaidStatus == 'completed') {
														neededMonthId = value.monthId;
													}
													if (value.feePaidStatus == 'inprogress') {
														inprogressMonthId = value.monthId;
													}

												} else {
													monthwithfeedetail += '<td style="background-color: #FFFFCC"><input onclick="showChild(this.value,this.checked,'
															+ payAmount
															+ ','
															+ value.fineAmount
															+ ','
															+ openingBalance
															+ ');" type="checkbox"  name="feeSubmissionDetailsDTOs[0].monthsId"  id="month'
															+ value.monthId
															+ '" value="'
															+ value.monthId
															+ '" /></td>';
												}
												monthwithfeedetail += '<td width="9%" style="background-color: #FFFFCC"><a href=javascript:monthStatus('
														+ totalGrossAmount
														+ ','
														+ totalFineAmount
														+ ','
														+ totalNetAmount
														+ ','
														+ totalDiscountAmount
														+ ','
														+ totalPaidAmount
														+ ');>'
														+ value.month
														+ '</a></td>';
												monthwithfeedetail += '<td width="9%" style="background-color: #FFFFCC">'
														+ openingBalance
														+ '</td><td width="9%" id="grossAmount'
														+ value.monthId
														+ '" style="background-color: #FFFFCC">'
														+ value.grossAmount
														+ '</a></td><td width="9%" style="background-color: #FFFFCC">'
														+ value.fineAmount
														+ '</td><td width="9%" style="background-color: #FFFFCC"><a href="javascript:viewcategories('
														+ value.monthId
														+ ');">'
														+ netAmount
														+ '</td>';
												if (value.commonString == null) {
													monthwithfeedetail += '<td width="9%" id="paidAmount'
															+ value.monthId
															+ '" style="background-color: #FFFFCC">'
															+ value.paidAmount
															+ '</td>';
												} else {
													monthwithfeedetail += '<td width="9%" id="paidAmount'
															+ value.monthId
															+ '" style="background-color: #FFFFCC">'
															+ value.paidAmount
															+ '('
															+ value.commonString
															+ ')</td>';
												}
												monthwithfeedetail += '<td width="9%" style="background-color: #FFFFCC">'
														+ discountAmount
														+ '</td><td width="9%" style="background-color: #FFFFCC">'
														+ balanceAmount
														+ '</td><td width="9%" id="feePaidStatus'
														+ value.monthId
														+ '" style="background-color: #FFFFCC"><a href=javascript:paymentStatus("'
														+ value.recieptNo
														+ '","'
														+ id
														+ '","'
														+ balanceAmount
														+ '");><span class="label label-warning">'
														+ value.feePaidStatus
														+ '</a></td>';

												if (value.paidBy == 'cheque') {
													monthwithfeedetail += '<td width="9%" style="background-color: #FFFFCC"><a href=javascript:showChequeDetails("'
															+ value.month
															+ '","'
															+ value.bankName
															+ '","'
															+ value.chequeNo
															+ '","'
															+ value.feePaidStatus
															+ '","'
															+ value.paidAmount
															+ '");><span class="label label-info">'
															+ value.paidBy
															+ '</span></a></td>';
												} else if (value.paidBy == 'cash') {
													monthwithfeedetail += '<td width="9%" style="background-color: #FFFFCC"><span class="label label-info">'
															+ value.paidBy
															+ '</span></td>';
												} else {
													monthwithfeedetail += '<td width="9%" style="background-color: #FFFFCC">'
															+ value.paidBy
															+ '</td>';
												}
												if (value.recieptNo == 0) {
													monthwithfeedetail += '<td width="9%" style="background-color: #FFFFCC">-</td>';
												} else {
													monthwithfeedetail += '<td width="9%" style="background-color: #FFFFCC"><a href="generatePDF.html?slipNo='
															+ value.recieptNo
															+ '&studentAdmissionNo='
															+ id
															+ '" target="_blank"><span class="label label-warning">View</span></a></td>';
												}
												monthwithfeedetail += '</tr></tbody></table>';
												monthwithfeedetail += '<div id="'+value.monthId+'" class="childtwo" style="width: 470px; margin-left: 25px;display: none;">';
												monthwithfeedetail += '<table width="50%" cellspacing="0" cellpadding="0" class="table">';
												monthwithfeedetail += '<thead><tr><th width="50%" class="head blue" style="color: white">Category Name</th>';
												monthwithfeedetail += '<th width="50%" class="head blue" style="color: white">Payable Amount<ul class="buttons">';
												monthwithfeedetail += '<li><a href="javascript:hidecategories('
														+ value.monthId
														+ ');"><div class="icon">';
												monthwithfeedetail += '<span class="ico-cancel"></span></div></a></li></ul></th>';
												monthwithfeedetail += '</tr></thead><tbody>';
												$
														.each(
																value.feesCategoriesDTOs,
																function(key,
																		value1) {
																	monthwithfeedetail += '<tr>';
																	monthwithfeedetail += '<td>'
																	if (value1.feeCategoryId == 14
																			|| value1.feeCategoryId == 15) {
																		monthwithfeedetail += '<a href=javascript:booksUniformDetails("'
																				+ id
																				+ '","'
																				+ value1.feeCategoryId
																				+ '","'
																				+ value.monthId
																				+ '")>'
																		monthwithfeedetail += value1.feeCategoryName
																		monthwithfeedetail += '</a>'
																				+ '</td>';
																		monthwithfeedetail += '<td width="10%"><a href=javascript:booksUniformDetails("'
																				+ id
																				+ '","'
																				+ value1.feeCategoryId
																				+ '","'
																				+ value.monthId
																				+ '")>'
																				+ value1.amounts
																		monthwithfeedetail += '</a>'
																	} else {
																		monthwithfeedetail += value1.feeCategoryName
																				+ '</td>';
																		monthwithfeedetail += '<td width="10%">'
																				+ value1.amounts
																	}
																	monthwithfeedetail += '</td></tr>';
																});
												monthwithfeedetail += '</tbody></table></div></div>';
												totalOpeningBalance = parseInt(openingBalance);
												totalClosingBalance = balanceAmount;
												openingBalance = balanceAmount;
											});
							//monthwithfeedetail += '<div width="100%" class="childone"><table width="100%" cellspacing="0" cellpadding="0" class="table table-hover"> <tbody><tr><td style="background-color: #FFFFCC"></td><td width="10%" style="background-color: #FFFFCC"></td><td width="15%" style="background-color: #FFFFCC"></td><td width="15%" style="background-color: #FFFFCC"></td><td width="15%" style="background-color: #FFFFCC"></td><td width="15%" style="background-color: #FFFFCC"></td><td width="15%" style="background-color: #FFFFCC"><a id="showfeepaynemtbutton" href="javascript:showfeepaynemtform();" style="display:none;"><span class="label label-warning">Pay Fees</span></a></td></tr></tbody></table></div>';
							monthwithfeedetail += '<table width="100%" cellspacing="0" cellpadding="0" class="table table-hover"><tr><td width="14%" style="background-color: #F3F383">Total'
									+ '</td><td width="9%" style="background-color: #F3F383">'
									+ totalOpeningBalance
									+ '</td><td width="9%" style="background-color: #F3F383">'
									+ totalGrossAmount
									+ '</td><td width="9%" style="background-color: #F3F383">'
									+ totalFineAmount
									+ '</td><td width="9%" style="background-color: #F3F383">'
									+ totalNetAmount
									+ '</td><td width="9%" style="background-color: #F3F383">'
									+ totalPaidAmount
									+ '</td><td width="9%" style="background-color: #F3F383">'
									+ totalDiscountAmount
									+ '</td><td width="9%" style="background-color: #F3F383">'
									+ totalClosingBalance
									+ '</td><td width="9%" style="background-color: #F3F383">'
									+ '</td><td width="20%" style="background-color: #F3F383">'
									+ '<div style="width: 104px; background-color: yellow; border: 1px solid gold; height: 24px; font: 145%/1.1 Lucida Console;" onclick="paymentDetails('
									+ id
									+ ');">PayDetails</div></td></tr></table></div></div>';

							var payment = '<div class="block"><div class="head green"><div class="icon"><span class="ico-pen-2"></span></div>';
							payment += '<h2>Fee Payment</h2></div><div class="data-fluid">';
							payment += '<table style="width: 744px; border: 1px solid lightgray; font: 80%/1.2 Lucida califunia; height: 129px;">';
							payment += '<tbody><tr><td style="width: 30px;">Gross Amount:</td><td style="width: 50px;">';
							payment += '<input type="text" readonly="readonly" style="height: 23px;" value="0" name="feeSubmissionDetailsDTOs[0].paidAmount" id="totalAmount"></td>';
							payment += '<td style="width: 30px;">Fine:</td> <td style="width: 50px;">';
							payment += '<input type="text" readonly="readonly" style="height: 23px;" id="fineAmount" value="0" name="feeSubmissionDetailsDTOs[0].fineAmount"></td>';
							payment += '<td style="width: 70px;">Discount in % <input type="radio" id="per" value="per" name="feeSubmissionDetailsDTOs[0].dis" onclick="disAmountType();">';
							payment += '/ Rs <input type="radio" value="rs" id="rs" name="feeSubmissionDetailsDTOs[0].dis" onclick="disAmountType();">: </td><td style="width: 50px;">';
							payment += ' <input type="text" name="feeSubmissionDetailsDTOs[0].discount" style="height: 23px;" value="0" onclick="getzeroremoved();" onkeyup="getDiscount(this.value)" id="disAmount">';
							payment += ' </td></tr><tr><td style="width: 30px;">Net Payable Amt</td><td style="width: 50px;">';
							payment += ' <input type="text" style="height: 23px;" readonly="readonly" id="discountAmount" name="feeSubmissionDetailsDTOs[0].netPayableAmount"></td>';
							payment += '<td>Paid Amt.</td><td><input type="text" style="height: 23px;" id="recentPaidAmount" value="0" name="feeSubmissionDetailsDTOs[0].recentPaidAmount" onclick="removezero();" oninput="converttowords(this.value);"></td>';
							payment += '<td style="width: 30px;"><font color="red">Due </font>:</td><td style="width: 50px;"><input type="text" style="height: 23px;" readonly="readonly" name="feeSubmissionDetailsDTOs[0].dueAmount" id="due"></td>';
							payment += '</tr><tr><td style="width: 30px;">Payment Type:</td>';
							payment += '<td style="width: 50px;"><select style="height: 23px;" class="validate[required]" onchange="getPaymentType(this.value)" name="feeSubmissionDetailsDTOs[0].paidBy" id="paymentType">';
							payment += '<option value="cash">Cash</option><option value="cheque">Cheque</option></select></td><td style="width: 30px;">Cheque Number:</td>';
							payment += '<td style="width: 50px;"><input type="text" style="height: 23px;" readonly="readonly" maxlength="6" name="feeSubmissionDetailsDTOs[0].chequeNo" id="checkNo"></td>';
							payment += '<td style="width: 30px;">Bank Name:</td><td style="width: 50px;"><input type="text" style="height: 23px;" readonly="readonly" name="feeSubmissionDetailsDTOs[0].bankName" id="bankName"></td>';
							payment += '</tr><tr><td>Amount in words</td><td colspan="3"><input type="text" readonly="readonly" style="height: 23px;" id="paidAmountInWord" value="" name="feeSubmissionDetailsDTOs[0].paidAmountInWord"></td>';
							payment += '<td>/-Only</td><td><div id="addfee" style="display: none;">&nbsp;&nbsp; <a id="addmorebutton" class="btn" href="javascript:addmore();">Add More</a></div></div></td></tr></tbody></table></div></div>';
							$("#payment").append(payment);
							$("#monthwithfeedetail").append(monthwithfeedetail);

							if (inprogressMonthId == 0) {
								enableFirstCheckBox(neededMonthId + 1);
								$("#neededMonthId").val(neededMonthId + 1);
							}
						},
						error : function(e) {

						}
					});
		}
	}
	function monthStatus(totalGrossAmount, totalFineAmount, totalNetAmount,
			totalDiscountAmount, totalPaidAmount) {
		var totalBalance = parseInt(totalNetAmount) - parseInt(totalPaidAmount)
				- parseInt(totalDiscountAmount);
		var payDetails = '<div class="block" style="background-color: #FFFFCC; opacity: 0.9; box-shadow: 0px 14px 21px 3px gray;"><div class="head" style="background-color:green;padding-left:10px;">';
		payDetails += '<h2 style="color: #fff">Payment Deatils '
				+ '</h2><ul class="buttons"><li><a href="javascript:hideChequeDetails();">';
		payDetails += '<div class="icon"><span class="ico-cancel"></span></div></a></li></ul></div>';
		payDetails += '<div class="data-fluid"><div class="row-form"><div class="span1" style="margin-left: 0px;width:180px;">Gross Amount :</div>';
		payDetails += '<div class="span1" style="margin-left: 0px;">'
				+ totalGrossAmount
				+ '</div></div></div><div class="data-fluid">';
		payDetails += '<div class="row-form"><div class="span1" style="margin-left: 0px;width:180px;">Fine Amount :</div>';
		payDetails += '<div class="span1" style="margin-left: 0px;">'
				+ totalFineAmount
				+ '</div></div></div><div class="data-fluid">';
		payDetails += '<div class="row-form"><div class="span1" style="margin-left: 0px;width:180px;">Net Amount :</div>';
		payDetails += '<div class="span1" style="margin-left: 0px;">'
				+ totalNetAmount + '</div></div></div><div class="data-fluid">';
		payDetails += '<div class="row-form"><div class="span1" style="margin-left: 0px;width:180px;">Discount Amount :</div>';
		payDetails += '<div class="span1" style="margin-left: 0px;">'
				+ totalDiscountAmount
				+ '</div></div></div><div class="data-fluid">';
		payDetails += '<div class="row-form"><div class="span1" style="margin-left: 0px;width:180px;">Paid Amount :</div>';
		payDetails += '<div class="span1" style="margin-left: 0px;">'
				+ totalPaidAmount
				+ '</div></div></div><div class="data-fluid">';
		payDetails += '<div class="row-form"><div class="span1" style="margin-left: 0px;width:180px;"><b>Balance :</b></div>';
		payDetails += '<div class="span1" style="margin-left: 0px;"><b>'
				+ totalBalance + '</b></div></div></div></div>';
		$("#chequeDetails").css("z-index", "1");
		$("#chequeDetails").append(payDetails);
	}
	function booksUniformDetails(studentId, categoryId, monthId) {
		$
				.ajax({
					type : "get",
					url : 'books-uniform-details',
					data : {
						'studentId' : studentId,
						'categoryId' : categoryId,
						'monthId' : monthId,
					},
					success : function(data, status) {
						$("#chequeDetails").empty();
						var obj = JSON.parse(data);
						var UniformDetails = '<div class="block" style="background-color: #FFFFCC; opacity: 0.9; box-shadow: 0px 14px 21px 3px gray;"><div class="head" style="background-color:green;padding-left:10px;">';
						UniformDetails += '<h2 style="color: #fff">Uniform Details'
								+ '</h2><ul class="buttons"><li><a href="javascript:hideChequeDetails();">';
						UniformDetails += '<div class="icon"><span class="ico-cancel"></span></div></a></li></ul></div>';
						UniformDetails += '<table class="table table-bordered table-primary"><thead><tr><th>Uniform Type</th><th>Category</th><th>Size</th><th>Price</th><th>Quantity</th><th>Amount</th><th>Net Amount</th></tr></thead>'

						var BooksDetails = '<div class="block" style="background-color: #FFFFCC; opacity: 0.9; box-shadow: 0px 14px 21px 3px gray;"><div class="head" style="background-color:green;padding-left:10px;">';
						BooksDetails += '<h2 style="color: #fff">Books Details'
								+ '</h2><ul class="buttons"><li><a href="javascript:hideChequeDetails();">';
						BooksDetails += '<div class="icon"><span class="ico-cancel"></span></div></a></li></ul></div>';
						BooksDetails += '<table class="table table-bordered table-primary"><thead><tr><th>SL. NO.</th><th>Book Name</th><th>Price</th></tr></thead>'
						if (obj.BooksDetails != '') {
							$.each(obj.BooksDetails, function(key, value) {
								BooksDetails += '<tbody><tr><td>'
										+ (key + parseInt(1)) + '</td><td>'
										+ value.bookTitle + '</td><td>'
										+ value.price + '</td></tr>';

							});
							BooksDetails += '</tbody></table>';
							$("#chequeDetails").append(BooksDetails);
						}
						if (obj.UniformDetails != '') {
							$.each(obj.UniformDetails, function(key, value) {
								UniformDetails += '<tbody><tr><td>'
										+ value.dressName + '</td><td>'
										+ value.category + '</td><td>'
										+ value.size + '</td><td>'
										+ value.price + '</td><td>'
										+ value.quantity + '</td><td>'
										+ value.price + '</td><td>'
										+ value.amount + '</td></tr>';
							});

							UniformDetails += '</tbody></table>';
							$("#chequeDetails").append(UniformDetails);
						}

						$("#chequeDetails").css("z-index", "1");

					},
					error : function(e) {

					}
				});
	}

	function paymentStatus(slipNo, studentId, balanceAmount) {
		$
				.ajax({
					type : "get",
					url : 'get-payment-status-details',
					data : {
						'studentId' : studentId,
						'slipNo' : slipNo,
					},
					success : function(data, status) {
						$("#chequeDetails").empty();
						var obj = JSON.parse(data);
						var totalGrossAmount = parseInt(obj.paidAmount)
								+ parseInt(obj.discount)
								+ parseInt(balanceAmount)
								- parseInt(obj.fineAmount);
						var totalNetAmount = parseInt(totalGrossAmount)
								+ parseInt(obj.fineAmount);
						var totalBalance = parseInt(totalNetAmount)
								- parseInt(obj.paidAmount)
								- parseInt(obj.discount);
						var payDetails = '<div class="block" style="background-color: #FFFFCC; padding: 8px; opacity: 0.9; box-shadow: 0px 14px 21px 3px gray;"><div class="head" style="background-color:green;padding-left:10px;">';
						payDetails += '<h2 style="color: #fff">Payment Details'
								+ '</h2><ul class="buttons"><li><a href="javascript:hideChequeDetails();">';
						payDetails += '<div class="icon"><span class="ico-cancel"></span></div></a></li></ul></div>';
						payDetails += '<div class="data-fluid"><div class="row-form"><div class="span1" style="margin-left: 0px;width:150px;">Paid Date :</div>';
						payDetails += '<div class="span1" style="margin-left: 0px;">'
								+ obj.feePaidDate
								+ '</div></div></div><div class="data-fluid">';
						payDetails += '<div class="data-fluid"><div class="row-form"><div class="span1" style="margin-left: 0px;width:150px;">Gross Amount :</div>';
						payDetails += '<div class="span1" style="margin-left: 0px;">'
								+ totalGrossAmount
								+ '</div></div></div><div class="data-fluid">';
						payDetails += '<div class="row-form"><div class="span1" style="margin-left: 0px;width:150px;">Fine Amount :</div>';
						payDetails += '<div class="span1" style="margin-left: 0px;">'
								+ obj.fineAmount
								+ '</div></div></div><div class="data-fluid">';
						payDetails += '<div class="row-form"><div class="span1" style="margin-left: 0px;width:150px;">Net Amount :</div>';
						payDetails += '<div class="span1" style="margin-left: 0px;">'
								+ totalNetAmount
								+ '</div></div></div><div class="data-fluid">';
						payDetails += '<div class="row-form"><div class="span1" style="margin-left: 0px;width:150px;">Paid Amount :</div>';
						payDetails += '<div class="span1" style="margin-left: 0px;">'
								+ obj.paidAmount
								+ '</div></div></div><div class="data-fluid">';
						payDetails += '<div class="row-form"><div class="span1" style="margin-left: 0px;width:150px;">Discount :</div>';
						payDetails += '<div class="span1" style="margin-left: 0px;">'
								+ obj.discount + '</div></div></div></div>';
						payDetails += '<div class="row-form"><div class="span1" style="margin-left: 0px;width:150px;"><b>Balance :</b></div>';
						payDetails += '<div class="span1" style="margin-left: 0px;"><b>'
								+ totalBalance + '</b></div></div></div></div>';
						$("#chequeDetails").css("z-index", "1");
						$("#chequeDetails").append(payDetails);
					},
					error : function(e) {

					}
				});
	}

	function paymentDetails(studentId) {
		$
				.ajax({
					type : "get",
					url : 'get-payment-details',
					data : {
						'studentAdmissionNo' : studentId,
					},
					success : function(data, status) {
						var obj = JSON.parse(data);
						$("#chequeDetails").empty();
						var totalGrossAmount = 0;
						var totalFineAmount = 0;
						var totalNetAmount = 0;
						var totalPaidAmount = 0;
						var totalBalance = 0;
						var discountAmount = 0;
						var totalDiscountAmount = 0;
						$.each(obj, function(key, value) {
							totalGrossAmount += parseInt(value.grossAmount);
							totalFineAmount += parseInt(value.fineAmount);
							if (value.paidAmount == '-') {
								var paidAmoutnt = 0;
								totalPaidAmount += parseInt(paidAmoutnt);
							} else {
								totalPaidAmount += parseInt(value.paidAmount);
							}
							if (value.discountAmount == null) {
								discountAmount = 0;
							} else {
								discountAmount = value.discountAmount;
							}
							totalDiscountAmount += parseInt(discountAmount);
						});
						totalNetAmount = parseInt(totalGrossAmount)
								+ parseInt(totalFineAmount);
						totalBalance = parseInt(totalNetAmount)
								- parseInt(totalPaidAmount)
								- parseInt(totalDiscountAmount);
						var payDetails = '<div class="block" style="background-color: #FFFFCC; opacity: 0.9; box-shadow: 0px 14px 21px 3px gray;"><div class="head" style="background-color:green;padding-left:10px;">';
						payDetails += '<h2 style="color: #fff">Payment Deatils '
								+ '</h2><ul class="buttons"><li><a href="javascript:hideChequeDetails();">';
						payDetails += '<div class="icon"><span class="ico-cancel"></span></div></a></li></ul></div>';
						payDetails += '<div class="data-fluid"><div class="row-form"><div class="span1" style="margin-left: 0px;width:180px;">Gross Amount :</div>';
						payDetails += '<div class="span1" style="margin-left: 0px;">'
								+ totalGrossAmount
								+ '</div></div></div><div class="data-fluid">';
						payDetails += '<div class="row-form"><div class="span1" style="margin-left: 0px;width:180px;">Fine Amount :</div>';
						payDetails += '<div class="span1" style="margin-left: 0px;">'
								+ totalFineAmount
								+ '</div></div></div><div class="data-fluid">';
						payDetails += '<div class="row-form"><div class="span1" style="margin-left: 0px;width:180px;">Net Amount :</div>';
						payDetails += '<div class="span1" style="margin-left: 0px;">'
								+ totalNetAmount
								+ '</div></div></div><div class="data-fluid">';
						payDetails += '<div class="row-form"><div class="span1" style="margin-left: 0px;width:180px;">Paid Amount :</div>';
						payDetails += '<div class="span1" style="margin-left: 0px;">'
								+ totalPaidAmount
								+ '</div></div></div><div class="data-fluid">';
						payDetails += '<div class="row-form"><div class="span1" style="margin-left: 0px;width:180px;">Discount :</div>';
						payDetails += '<div class="span1" style="margin-left: 0px;">'
								+ totalDiscountAmount + '</div></div></div>';
						payDetails += '<div class="row-form"><div class="span1" style="margin-left: 0px;width:180px;"><b>Balance :</b></div>';
						payDetails += '<div class="span1" style="margin-left: 0px;"><b>'
								+ totalBalance + '</b></div></div></div></div>';
						$("#chequeDetails").css("z-index", "1");
						$("#chequeDetails").append(payDetails);
					},
					error : function(e) {

					}
				});
	}
	function enableanddisable(flag) {
		var monthsId = document
				.getElementsByName("feeSubmissionDetailsDTOs[0].monthsId");
		$.each(monthsId, function(key, value) {
			if (flag && !this.checked) {
				$(value).prop("disabled", false);
				value.checked = true;

			}
			if (!flag && this.checked) {
				value.click();
			}
		});
	}
	function getClear() {
		$("#classId").val('');
		$("#sectionId").val('');
		$("#studentId").val('');
	}
	function validate() {
		$("#addmorediv").empty();
		$("#studentAddmissionNoDiv").empty();
		flage = true;
		if ($("#paymentType").val() == 'cheque' && $("#bankName").val() == '') {
			flage = false;
			alert("Enter Bank Name Please");
		}
		if ($("#paymentType").val() == 'cheque'
				&& ($("#checkNo").val() == '' || $("#checkNo").val().length < 6)) {
			flage = false;
			alert("Please Enter 6 digit valid Cheque No.");

		} else if ($("#paymentType").val() == 'cheque'
				&& $("#checkNo").val() == '') {
			flage = false;
			alert("Please Enter 6 digit valid Cheque No.");
		} else if ($("#paymentType").val() == 'cheque'
				&& !$.isNumeric($("#checkNo").val())) {
			flage = false;
			alert("Cheque No. in numbers only.");
		} else if ($("#recentPaidAmount").val() == ''
				|| $("#recentPaidAmount").val() <= 0) {
			flage = false;
			alert("Please Enter Amount");
		}
		if ($("#month12").is(":checked")) {
			if ($("#due").val() != 0) {
				flage = false;
				alert("no due remain at the end of this session");
			}
		}
		$("#studentAddmissionNoDiv")
				.append(
						"<input type='hidden' name='feeSubmissionDetailsDTOs[0].studentAdmissionNo' value="
								+ $('#studentAdmissionNo').val() + ">");
		var inWords = toWords($("#recentPaidAmount").val());
		$("#paidAmountInWords").val(inWords);
		converttowords($("#recentPaidAmount").val());
		if (flage) {
			$("#validateform").submit();
			location.reload(true);

		}

	}
	function removezero() {
		var paid = $("#recentPaidAmount").val();
		if (paid == 0)
			$("#recentPaidAmount").val('');
	}
	function getzeroremoved() {
		var discounts = $("#disAmount").val();
		if (discounts == 0)
			$("#disAmount").val('');
		if ($("#per").is(":checked")) {
			disType = 'per';
		} else if ($("#rs").is(":checked")) {
			disType = 'rs';
		} else {
			alert('Select Discount Type');
		}
	}
	//
	function enableFirstCheckBox(value) {
		$("#month" + value).prop("disabled", false);
	}
	function viewcategories(value) {
		$("#" + value).fadeIn(1000);
	}
	function hidecategories(value) {
		$("#" + value).fadeOut(1000);
	}
	var fineZ = 0;
	function showChild(value, checked, grossAmount, fineAmount, dueAmount) {
		
		fineZ += parseInt(fineAmount);
		
		if (dueAmount == 0) {
			dueAmount = fineAmount;
		}
		disAmount = 0;
		if ($("#disAmount").val() != '') {
			disAmount = $("#disAmount").val();
		}
		if (checked) {
			$("#totalAmount").val(parseInt(grossAmount));
			$("#fineAmount").val(parseInt(fineZ));
			$("#discountAmount").val(
					parseInt(grossAmount + fineAmount) - parseInt(disAmount));
			if ($("#recentPaidAmount").val() == '') {
				$("#due").val($("#discountAmount").val());
			} else {
				$("#due").val(
						$("#discountAmount").val()
								- $("#recentPaidAmount").val());
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
					/* $("#month" + i).prop("disabled", true); */
				} else {
					/* $("#month" + i).prop("disabled", true); */
				}
			}
			$("#totalAmount").val(parseInt(dueAmount) - parseInt(fineAmount));
			$("#fineAmount").val(parseInt(fineAmount));
			$("#discountAmount").val(parseInt(dueAmount) - parseInt(disAmount));
			$("#recentPaidAmount").val('');
			$("#due").val(parseInt(dueAmount) - parseInt(disAmount));
			/* if ($("#discountAmount").val() == 0) {
				$("#disAmount").val('');
				$("#recentPaidAmount").val('');
				$("#due").val('');
				$("#submitfee").hide();
			} */

		}
	}

	function hideChequeDetails() {
		$("#chequeDetails").empty();
		$("#chequeDetails").css("z-index", "-1");
	}
	function showChequeDetails(monthName, bankName, chequeNo, status,
			paidAmount) {
		$("#chequeDetails").empty();
		var chequeDetails = '<div class="block" style="background-color: lightblue; opacity: 0.9; box-shadow: 0px 14px 21px 3px gray;"><div class="head" style="background-color:#009ad7;padding-left:10px;">';
		chequeDetails += '<h2>Cheque Deatils for '
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
	var monthIdArray = [];
	function addmore() {

		var rowCount = $("#addmoreid").val();
		var flage = true;
		if ($("#month12").is(":checked")) {
			if ($("#due").val() != 0) {
				flage = false;
				alert("no due remain at the end of this session");
			}
		}
		if (rowCount == 0) {
			$("#paymenttypeaddmore").val($("#paymentType").val());
		}
		if ($("#paymenttypeaddmore").val() != $("#paymentType").val()) {
			flage = false;
			alert("payement type not same as for previous Student");
		}
		var monthsId = document
				.getElementsByName("feeSubmissionDetailsDTOs[0].monthsId");

		var existanceFlage = false;
		var countAddMore = 0;
		if (!$.isEmptyObject(monthIdArray)) {
			$.each(monthsId, function(key, value) {
				if (this.checked && !this.disabled) {
					countAddMore = (parseInt(countAddMore) + 1);
					if ($.inArray(key, monthIdArray) == -1) {
						flage = false;
						existanceFlage = true;
					}
				}
			});
		}
		if (countAddMore != monthIdArray.length) {
			flage = false;
			existanceFlage = true;
		}
		if (existanceFlage) {
			alert("Select Month are not same for Students");
		}

		if (flage) {
			var studentAdmissionNo = $("#studentAdmissionNo").val();
			var content = '<div class="block" id="studentAddMoreData'+studentAdmissionNo+'"><div class="head green"><div class="icon"><span class="ico-pen-2"></span></div><h2>'
					+ $("#fullName").val()
					+ '</h2><ul class="buttons"><li><a href="javascript:remavetotalData('
					+ studentAdmissionNo
					+ ');"><div class="icon"><span class="ico-cancel"></span></div></a></li> </ul></div><div class="data-fluid">';
			content += '<table style="width: 744px; border: 1px solid lightgray; font: 80%/1.2 Lucida califunia; height: 129px;"><tbody><tr><td style="width: 30px;">Gross Amount:</td><td style="width: 50px;">';
			content += '<input id="paidAmount' + studentAdmissionNo
					+ '" type="hidden" name="feeSubmissionDetailsDTOs['
					+ rowCount + '].paidAmount" value="'
					+ $("#totalAmount").val() + '">' + $("#totalAmount").val()
					+ '</td>';
			content += '<td style="width: 30px;">Fine:</td> <td style="width: 50px;">';
			content += '<input type="hidden" name="feeSubmissionDetailsDTOs['
				+ rowCount + '].studentAdmissionNo" value="'
				+ studentAdmissionNo
				+ '"><input type="hidden" id="fineAmount'
					+ studentAdmissionNo
					+ '" name="feeSubmissionDetailsDTOs['
					+ rowCount
					+ '].fineAmount" value="'
					+ $("#fineAmount").val() + '">';

			var i = 0;
			$
					.each(
							monthsId,
							function(key, value) {
								if (this.checked && !this.disabled) {
									monthIdArray.push(key);
									content += '<input type="hidden" name="feeSubmissionDetailsDTOs['
											+ rowCount
											+ '].monthsId['
											+ (i)
											+ ']" value="' + this.value + '">';
									i = parseInt(i) + 1;
								}
							});
			content += '' + $("#fineAmount").val()
					+ '</td><td style="width: 70px;">Discount in';
			var discountAmountAddMore = '';
			if ($("#per").is(":checked")) {
				discountAmountAddMore = ((parseInt($("#totalAmount").val()) * parseInt($(
						"#disAmount").val())) / 100);
				content += ' % <input type="hidden"  name="feeSubmissionDetailsDTOs['+rowCount+'].dis" value="per">percentage';

			} else if ($("#rs").is(":checked")) {
				discountAmountAddMore = $("#disAmount").val();
				content += '&nbsp;Rs <input type="hidden" name="feeSubmissionDetailsDTOs['+rowCount+'].dis" value="rs">: </td>';

			}
			content += '<td style="width: 50px;">';
			content += '<input type="hidden" id="disAmount'
					+ studentAdmissionNo + '" value="' + discountAmountAddMore
					+ '"  name="feeSubmissionDetailsDTOs[' + rowCount
					+ '].discount">'
					+ discountAmountAddMore + '</td>';
			content += '</tr><tr><td style="width: 30px;">Net Payable Amt</td><td style="width: 50px;"> <input id="netPayableAmount'
					+ studentAdmissionNo
					+ '" type="hidden" value="'
					+ $("#discountAmount").val()
					+ '" name="feeSubmissionDetailsDTOs['
					+ rowCount
					+ '].netPayableAmount">'
					+ $("#discountAmount").val()
					+ '</td>';
			content += '<td>Paid Amt.</td><td><input type="hidden" id="recentPaidAmount'
					+ studentAdmissionNo
					+ '" name="feeSubmissionDetailsDTOs['
					+ rowCount
					+ '].recentPaidAmount" value="'
					+ $("#recentPaidAmount").val()
					+ '">'
					+ $("#recentPaidAmount").val() + '</td>';
			content += '<td style="width: 30px;"><font color="red">Due </font>:</td><td style="width: 50px;"><input type="hidden" id="dueAmount'
					+ studentAdmissionNo
					+ '" name="feeSubmissionDetailsDTOs['
					+ rowCount
					+ '].dueAmount" value="'
					+ $("#due").val()
					+ '">' + $("#due").val() + '</td>';
			content += '</tr><tr><td style="width: 30px;">Payment Type:</td><td style="width: 50px;">';
			content += '<input type="hidden" name="feeSubmissionDetailsDTOs['
					+ rowCount + '].paidBy" value="' + $("#paymentType").val()
					+ '">' + $("#paymentType").val() + '';
			content += '</td><td style="width: 30px;">Cheque Number:</td><td style="width: 50px;">';
			content += '<input type="hidden" name="feeSubmissionDetailsDTOs['
					+ rowCount + '].chequeNo" value="' + $("#checkNo").val()
					+ '">' + $("#checkNo").val() + '</td>';
			content += '<td style="width: 30px;">Bank Name:</td><td style="width: 50px;">';
			content += '<input type="hidden" name="feeSubmissionDetailsDTOs['
					+ rowCount + '].bankName" value="' + $("#bankName").val()
					+ '">' + $("#bankName").val() + '</td></tr>';
			content += '<tr><td>Amount in words</td><td colspan="3"><input type="text" name="feeSubmissionDetailsDTOs['
					+ rowCount
					+ '].paidAmountInWord" value="'
					+ $("#paidAmountInWord").val()
					+ '" style="height: 23px;" readonly="readonly"></td>';
			content += '<td>/-Only</td><td></td></tr></tbody></table></div></div>';
			$("#addmorediv").append(content);
			$("#addmoreid").val(parseInt(rowCount) + 1);
			$("#totalGrossAmount").val(
					parseInt($("#totalGrossAmount").val())
							+ parseInt($("#totalAmount").val()));
			$("#totalFineAmount").val(
					parseInt($("#totalFineAmount").val())
							+ parseInt($("#fineAmount").val()));
			if (discountAmountAddMore == '') {
				$("#totalDisAmount").val(parseInt($("#totalDisAmount").val()));
			} else {
				$("#totalDisAmount").val(
						parseInt($("#totalDisAmount").val())
								+ parseInt(discountAmountAddMore));
			}

			$("#totalDiscountAmount").val(
					parseInt($("#totalDiscountAmount").val())
							+ parseInt($("#discountAmount").val()));
			$("#totalRecentPaidAmount").val(
					parseInt($("#totalRecentPaidAmount").val())
							+ parseInt($("#recentPaidAmount").val()));
			$("#totalDue").val(
					parseInt($("#totalDue").val()) + parseInt($("#due").val()));
			$("#totalData").show();
			getClear();
			$("#monthwithfeedetail").empty();
			$("#studentDetails").empty();
			$("#payment").empty();
			$("#appendStudentName").empty();
		}
	}
	function remavetotalData(studentAddmissionNo) {
		$("#totalGrossAmount").val(
				parseInt($("#totalGrossAmount").val())
						- parseInt($("#paidAmount" + studentAddmissionNo + "")
								.val()));
		$("#totalFineAmount").val(
				parseInt($("#totalFineAmount").val())
						- parseInt($("#fineAmount" + studentAddmissionNo + "")
								.val()));
		$("#totalDisAmount").val(
				parseInt($("#totalDisAmount").val())
						- parseInt($("#disAmount" + studentAddmissionNo + "")
								.val()));
		$("#totalDiscountAmount").val(
				parseInt($("#totalDiscountAmount").val())
						- parseInt($(
								"#netPayableAmount" + studentAddmissionNo + "")
								.val()));
		$("#totalRecentPaidAmount").val(
				parseInt($("#totalRecentPaidAmount").val())
						- parseInt($(
								"#recentPaidAmount" + studentAddmissionNo + "")
								.val()));
		$("#totalDue").val(
				parseInt($("#totalDue").val())
						- parseInt($("#dueAmount" + studentAddmissionNo + "")
								.val()));
		$("#studentAddMoreData" + studentAddmissionNo + "").remove();
		if ($("#totalGrossAmount").val() == 0) {
			$("#totalData").hide();
		}
	}
	function submitForm() {
		var inWords = toWords($("#totalRecentPaidAmount").val());
		$("#paidAmountInWords").val(inWords);
		$("#validateform").submit();
		location.reload(true);

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
	<br> <input type="hidden" id="addmoreid" value="0"><input
		type="hidden" id="paymenttypeaddmore">

	<!-- action="fee-payment" -->
	<f:form commandName="studentFeeSubmissionDetailsDTO" method="POST"
		id="validateform" target="_blank" action="fee-payment">
		<div id="studentAddmissionNoDiv"></div>
		<div class="row-fluid">
			<!--  <div class="span4">
				<div class="block" style="width: 299px;">
					<div id="searches2"
						style="height: auto; width: 297px; border: 1px solid lightgray; background-color: rgb(238, 238, 238); border-radius: 5px;">
						<div class="data-fluid">
							<div class="row-form">
								<div class="span4">Student Id :</div>
								<div class="span8">
									<input type="text" name="studentId"
										oninput="getStudentDatabyId(this.value);">
								</div>
							</div>

						</div>
						<div class="separator"></div>
					</div>
				</div>
			</div>  -->
			<div class="span4">
				<div class="block" style="width: 299px;">
					<div id="searches1"
						style="height: auto; width: 297px; border: 1px solid lightgray; background-color: rgb(238, 238, 238); border-radius: 5px;">
						<div class="data-fluid">
							<div class="row-form">
								<div class="span4">Student Id :</div>
								<div class="span8">
									<input type="text" name="studentId"
										oninput="getStudentDatabyId(this.value);">
								</div>
							</div>
							<div class="row-form">
								<div class="span4">Session :</div>
								<div class="span8">
									<select id="sessionId" class="validate[required]"
										onchange="getClear();" name="sessionId" class="select">
										<option value="${current.sessionId}">${current.sessionDuration}</option>
										<c:forEach var="list" items="${sessionList}">
											<option value="${list.sessionId}">${list.sessionDuration}</option>
										</c:forEach>
									</select>
								</div>
							</div>
							<div class="row-form">
								<div class="span4">Class :</div>
								<div class="span8">
									<select id="classId" class="validate[required]"
										onchange="getSectionList(this.value);" name="classId"
										class="select">
										<option value="">Select a Class</option>
										<c:forEach var="list" items="${classesList}">
											<option value="${list.classId}">${list.className}</option>
										</c:forEach>
									</select>
								</div>
							</div>
							<div class="row-form">
								<div class="span4">Section :</div>
								<div class="span8">
									<select id="sectionId" class="validate[required]"
										onchange="getStudentList();" name="sectionId" class="select">
										<option value="">Select a Section</option>
									</select>
								</div>
							</div>
						</div>
						<input type="hidden" name="studentAdmissionNo"
							id="studentAdmissionNo"> <input type="hidden"
							id="neededMonthId"> <input type="hidden"
							name="paidAmountInWord" id="paidAmountInWords">
						<div class="separator"></div>
					</div>
				</div>
			</div>
			<div class="span8">
				<div id="addmorediv"
					style="float: right; z-index: -1; height: auto; right: 296px;"></div>
				<div id="totalData"
					style="float: right; z-index: -1; height: 180px; right: 296px; display: none;">
					<div class="block">
						<div class="head green">
							<div class="icon">
								<span class="ico-pen-2"></span>
							</div>
							<h2>Fee Payment Summary</h2>

						</div>
						<div class="data-fluid">
							<table
								style="width: 744px; border: 1px solid lightgray; font: 80%/1.2 Lucida califunia; height: 129px;">
								<tbody>
									<tr>
										<td style="width: 30px;">Gross Amount:</td>
										<td style="width: 50px;"><input type="text" value="0"
											id="totalGrossAmount"
											name="studentFeeSubmissionDetailsDTO.paidAmount"
											style="height: 23px;" readonly="readonly"></td>
										<td style="width: 30px;">Fine:</td>
										<td style="width: 50px;"><input type="text"
											name="studentFeeSubmissionDetailsDTO.fineAmount" value="0"
											id="totalFineAmount" style="height: 23px;"
											readonly="readonly"></td>
										<td style="width: 70px;">Discount</td>
										<td style="width: 50px;"><input type="text"
											id="totalDisAmount" readonly="readonly" value="0"
											style="height: 23px;"
											name="studentFeeSubmissionDetailsDTO.discount"></td>
									</tr>
									<tr>
										<td style="width: 30px;">Net Payable Amt</td>
										<td style="width: 50px;"><input type="text" value="0"
											name="studentFeeSubmissionDetailsDTO.netPayableAmount"
											id="totalDiscountAmount" readonly="readonly"
											style="height: 23px;"></td>
										<td>Paid Amt.</td>
										<td><input type="text"
											name="studentFeeSubmissionDetailsDTO.recentPaidAmount"
											readonly="readonly" value="0" id="totalRecentPaidAmount"
											style="height: 23px;"></td>
										<td style="width: 30px;"><font color="red">Due </font>:</td>
										<td style="width: 50px;"><input type="text" id="totalDue"
											value="0" name="studentFeeSubmissionDetailsDTO.dueAmount"
											readonly="readonly" style="height: 23px;"></td>
									</tr>
									<tr>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td><a href="javascript:submitForm();" class="btn">Submit</a></td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>




				</div>
				<div class="span8" id="studentDetails"
					style="width: 710px; height: auto; margin-bottom: 0px; margin-left: -28px;"></div>
			</div>
		</div>
		<hr>
		<div id="chequeDetails"
			style="float: right; z-index: -1; height: 220px; position: fixed; top: 225px; right: 296px;">

		</div>
		<div class="row-fluid" style="width: 1079px;">
			<div class="span4" style="width: 300px;">
				<div class="block" id="appendStudentName"></div>
			</div>
			<div class="span8" style="width: 765px; margin-left: 14px;">
				<div class="block" style="float: right;" id="monthwithfeedetail">
				</div>
			</div>
		</div>
		<div id="feeAllotment"
			style="width: 654px; margin: 25px auto 0px; float: left;"></div>
		<div id="payment">
			<div id="err" class="form-inline" style="float: left;">
				<p id="v1"></p>
			</div>
		</div>

		<div id="subButton" style="width: 654px; float: left;"></div>

	</f:form>


</div>










<%--  <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url value="/style/theme/images" var="imageurl" />
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/img" var="img" />
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

#payment {
	width: 730px;
	margin: 25px auto 0px;
	float: right;
	z-index: 1;
	top: 200px;
	background-color: white;
	width: 744px;
}
</style>
<script>
$(document).ready(function(e) {
	 if ($("#refresh").val() == 'yes') { location.reload; } else { $('#refresh').val('yes'); }
	});
	function getSectionList(id) {
		$("#totalData").hide();
		$("#monthwithfeedetail").empty();
		$("#studentDetails").empty();
		$("#payment").empty();
		$("#studentAddmissionNoDiv").empty();
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
	function getStudentDatabyId(studentId) {

		$.ajax({
			type : 'post',
			url : 'get-studentdatabyId',
			data : {

				'studentId' : studentId,
			},
			success : function(data, status) {
				var j = JSON.parse(data);
				if (j.length == 0) {

				} else {
					$("#classId").val(j.classId);
					$("#sectionId").val(j.sectionId);
					getStudentFeeDetails(j.admissionNo);

				}

			},

			error : function(data, status) {

			}
		});

	}

	function getStudentList() {
		$("#totalData").hide();
		$("#monthwithfeedetail").empty();
		$("#studentDetails").empty();
		$("#payment").empty();
		$("#studentAddmissionNoDiv").empty();
		var sessionId = $('#sessionId').val();
		var classId = $('#classId').val();
		var sectionId = $('#sectionId').val();
		if (sessionId == '' || classId == '' || sectionId == '') {
			alert("Fill Above Data First. Please!!");
		} else {
			$
					.ajax({
						type : "post",
						url : 'get-student-list',
						data : {
							'classId' : classId,
							'sectionId' : sectionId,
							'sessionId' : sessionId,
						},
						success : function(data, status) {
							$("#appendStudentName").empty();
							var obj = JSON.parse(data);

							var appendStudentName = '<div class="span12"><div class="head green"><div class="icon"><span class="ico-pen-2"></span></div><h2>Students Details</h2></div>';
							appendStudentName += '<div class="data-fluid"><table width="100%" cellspacing="0" cellpadding="0" class="table"><thead><tr>';
							appendStudentName += '<th style="background-color:#FFCC99">Student Name</th><th style="background-color:#FFCC99">Father Name</th><th style="background-color:#FFCC99">Details</th></tr></thead><tbody>';
							$
									.each(
											obj,
											function(key, value) {
												appendStudentName += '<tr><td width="40%" style="padding: 7px 0px 0px;"><a href="show-student-details?id='
														+ value.admissionNo
														+ '">'
														+ value.fullName
														+ '</a></td><td width="40%" style="padding: 7px 0px 0px;">'
														+ value.fatherName
														+ '</td><td width="20%" style="padding: 7px 0px 0px;"><a href="javascript:getStudentFeeDetails('
														+ value.admissionNo
														+ ');">View Fees</a></td></tr>';
											});
							appendStudentName += '</tbody></table></div></div>';

							$("#appendStudentName").append(appendStudentName);
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

							alert($('#fineAmount').val());
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
		if (isNaN(value) || value == '' || value < 0) {
			alert('Enter Valid Amount');
			var totalAmount = $('#totalAmount').val();
			var fine = $('#fineAmount').val();
			var due = $('#due').val();
			var discountAt = parseInt(totalAmount) + parseInt(fine);
			$('#discountAmount').val(discountAt);
			$('#disAmount').val(0);
			converttowords($("#recentPaidAmount").val());
		} else if (disType == 'per') {
			if (value > 100 || value < 0) {
				var amnt = parseInt($('#totalAmount').val())
						+ parseInt($('#fineAmount').val());
				$('#discountAmount').val(amnt);
				$('#disAmount').val(0);
				$('#due')
						.val(
								parseInt(amnt)
										- parseInt($('#recentPaidAmount').val()));
				alert('Enter Valid Discount');
			} else {
				var discount = Math.round(parseInt(totalAmount)
						* parseInt(value) / 100);
				var discountAmount = Math.round(totalAmount - discount
						+ parseInt(fine));
				$('#discountAmount').val(discountAmount);
				$('#discounts').val(discount);
				converttowords($("#recentPaidAmount").val());
			}
		} else if (disType == 'rs') {
			if (value > parseInt(totalAmount)
					+ parseInt($('#fineAmount').val())
					|| value < 0) {
				alert('Enter Valid Amount');
				var amnt = parseInt($('#totalAmount').val())
						+ parseInt($('#fineAmount').val());
				$('#discountAmount').val(amnt);
				$('#due')
						.val(
								parseInt(amnt)
										- parseInt($('#recentPaidAmount').val()));
				$('#disAmount').val(0);
			} else {
				var discount = Math.round(parseInt(value));
				var discountAmount = Math.round(parseInt(totalAmount)
						- parseInt(value) + parseInt(fine));
				$('#discountAmount').val(discountAmount);
				$('#discounts').val(discount);
				converttowords($("#recentPaidAmount").val());
			}
		}
	}
	function disAmountType() {
		$('#disAmount').val(0);
		$('#discountAmount').val(
				parseInt($('#totalAmount').val())
						+ parseInt($('#fineAmount').val()));
	}

	function converttowords(num) {

		if (num == '') {
			num = 0;
		}
		if (parseInt($("#discountAmount").val()) >= parseInt(num)) {
			if ($('#recentPaidAmount').val() == ''
					|| $('#recentPaidAmount').val() == null) {
				num = 0;
			}
			$("#due").val(parseInt($("#discountAmount").val()) - parseInt(num));
			/* 	$("#submitfee").show(); */
			$("#addfee").show();
			$("#v1").innerHTML = "";
		} else {
			$("#recentPaidAmount").val('');
			num = '0';
			$("#v1").innerHTML = "Paid Amount should be less than or equal to Net Payable Amount";
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
		$("#studentAdmissionNo").val(id);
		if ($("#studentAddMoreData" + id + "").html() != undefined) {
			remavetotalData(id);
		}
		if (classId == '' || sectionId == '') {
			alert("Fill Above Data First. Please!!");
		} else {
			$
					.ajax({
						type : "get",
						url : 'get-student-fee-payment-details',
						data : {
							'studentAdmissionNo' : id,
							'sessionId' : sessionId
						},
						success : function(data, status) {
							var obj = JSON.parse(data);
							$("#monthwithfeedetail").empty();
							$("#studentDetails").empty();
							$("#payment").empty();
							var studentDetails = '<div style="text-align: center; height: 33px; background-color: rgb(238, 238, 238); color: rgb(0, 136, 204); border: 1px solid lightgray; border-top-left-radius: 10px; border-top-right-radius: 10px; margin-top: 3px; width: 710px;">'
									+ obj.StudentDTO.fullName
									+ '<input type="hidden" id="fullName" value="'+obj.StudentDTO.fullName+'"></div><div class="row-fluid"  style="border: 1px solid lightgray; height: 113px; border-bottom-left-radius: 10px; border-bottom-right-radius: 10px;"><div class="span6">';
							studentDetails += '<div class="block"><div class="data-fluid"><div class="row-form"><div class="span5">Mobile No :</div>';
							studentDetails += '<div class="span7">'
									+ obj.StudentDTO.mobile
									+ '</div></div></div><div class="data-fluid"><div class="row-form">';
							studentDetails += '<div class="span5">Roll No :</div><div class="span7">'
									+ obj.StudentDTO.rollno
									+ '</div></div></div></div></div>';
							studentDetails += '<div class="span6"><div class="block"><div class="data-fluid"><div class="row-form" style="padding-top: 0px;">';
							studentDetails += '<div class="span3" style="width: 138px; height: 113px;float:right">'
									+ '<img src="${img}/studentImages/'+obj.StudentDTO.imageName+'"'
									+'style="width: 127px; height: 113px;">'
									+ '</div></div></div></div>';
							$("#studentDetails").append(studentDetails);

							var monthwithfeedetail = '<div class="head green"><div class="icon"><span class="ico-brush"></span></div>';
							monthwithfeedetail += '<h2>Fee Submission details</h2><ul class="buttons"><li><a href="#"><div class="icon">';
							monthwithfeedetail += '<span class="ico-info"></span></div></a></li></ul></div>';
							monthwithfeedetail += '<div class="data-fluid"><div class="classshowheader"><table width="100%" cellspacing="0" cellpadding="0" class="table table-hover">';
							monthwithfeedetail += '<thead><tr><th style="background-color: #FFCC99"></th>';//<input onclick="enableanddisable(this.checked);" type="checkbox"/>
							monthwithfeedetail += '<th style="background-color: #FFCC99" width="9%">Month Name</th>';
							monthwithfeedetail += '<th style="background-color: #FFCC99" width="9%">Opening Balance</th>';
							monthwithfeedetail += '<th style="background-color: #FFCC99" width="9%">Gross Amount</th>';
							monthwithfeedetail += '<th style="background-color: #FFCC99" width="9%">Fine Amount</th>';
							monthwithfeedetail += '<th style="background-color: #FFCC99" width="9%">Net Amount</th>';
							monthwithfeedetail += '<th style="background-color: #FFCC99" width="9%">Paid Amount</th>';
							monthwithfeedetail += '<th style="background-color: #FFCC99" width="9%">Discount Amount</th>';
							monthwithfeedetail += '<th style="background-color: #FFCC99" width="9%">Closing Balance</th>';
							monthwithfeedetail += '<th style="background-color: #FFCC99" width="9%">Status</th>';
							monthwithfeedetail += '<th style="background-color: #FFCC99" width="9%">Paid By</th>';
							monthwithfeedetail += '<th style="background-color: #FFCC99" width="9%">Reciept</th></tr></thead></table></div>';
							monthwithfeedetail += '<div class="classshowheader" width="100%">';
							var neededMonthId = 0;
							var inprogressMonthId = 0;
							var totalGrossAmount = 0;
							var totalFineAmount = 0;
							var totalNetAmount = 0;
							var totalPaidAmount = 0;
							var totalBalanceAmount = 0;
							var openingBalance = 0;
							var totalOpeningBalance = 0;
							var totalClosingBalance = 0;
							var discountAmount = 0;
							var totalDiscountAmount = 0;
							$
									.each(
											obj.StudentFeeSubmissionDetailsDTOs,
											function(key, value) {

												if (value.discountAmount == null) {
													discountAmount = 0;
												} else {
													discountAmount = value.discountAmount;
												}
												var netAmount = parseInt(openingBalance)
														+ parseInt(value.grossAmount)
														+ parseInt(value.fineAmount);
												totalGrossAmount += parseInt(value.grossAmount);
												totalFineAmount += parseInt(value.fineAmount);
												totalNetAmount += netAmount
														- parseInt(openingBalance);

												totalDiscountAmount += parseInt(discountAmount);
												if (value.paidAmount == '-') {
													value.paidAmount = 0;
													var balanceAmount = parseInt(netAmount)
															- parseInt(value.paidAmount)
															- parseInt(discountAmount);
													totalPaidAmount += parseInt(value.paidAmount);
												} else {
													var balanceAmount = parseInt(netAmount)
															- parseInt(value.paidAmount)
															- parseInt(discountAmount);
													totalPaidAmount += parseInt(value.paidAmount);
												}
												var payAmount = parseInt(openingBalance)
														+ parseInt(value.grossAmount);
												monthwithfeedetail += '<div class="childone" width="100%"><table width="100%" cellspacing="0" cellpadding="0" class="table table-hover">';
												monthwithfeedetail += ' <tbody><tr>';
												if (value.status == 'YES') {
													monthwithfeedetail += '<td style="background-color: #FFFFCC"><input  disabled="disabled" checked="checked" onclick="showChild(this.value,this.checked,'
															+ payAmount
															+ ','
															+ value.fineAmount
															+ ','
															+ openingBalance
															+ ');" type="checkbox" name="feeSubmissionDetailsDTOs[0].monthsId" id="month'
															+ value.monthId
															+ '"  value="'
															+ value.monthId
															+ '" /></td>';
													if (value.feePaidStatus == 'completed') {
														neededMonthId = value.monthId;
													}
													if (value.feePaidStatus == 'inprogress') {
														inprogressMonthId = value.monthId;
													}

												} else {
													monthwithfeedetail += '<td style="background-color: #FFFFCC"><input onclick="showChild(this.value,this.checked,'
															+ payAmount
															+ ','
															+ value.fineAmount
															+ ','
															+ openingBalance
															+ ');" type="checkbox" disabled="disabled" name="feeSubmissionDetailsDTOs[0].monthsId"  id="month'
															+ value.monthId
															+ '" value="'
															+ value.monthId
															+ '" /></td>';
												}
												monthwithfeedetail += '<td width="9%" style="background-color: #FFFFCC"><a href=javascript:monthStatus('
														+ totalGrossAmount
														+ ','
														+ totalFineAmount
														+ ','
														+ totalNetAmount
														+ ','
														+ totalDiscountAmount
														+ ','
														+ totalPaidAmount
														+ ');>'
														+ value.month
														+ '</a></td>';
												monthwithfeedetail += '<td width="9%" style="background-color: #FFFFCC">'
														+ openingBalance
														+ '</td><td width="9%" id="grossAmount'
														+ value.monthId
														+ '" style="background-color: #FFFFCC">'
														+ value.grossAmount
														+ '</a></td><td width="9%" style="background-color: #FFFFCC">'
														+ value.fineAmount
														+ '</td><td width="9%" style="background-color: #FFFFCC"><a href="javascript:viewcategories('
														+ value.monthId
														+ ');">'
														+ netAmount
														+ '</td>';
												if (value.commonString == null) {
													monthwithfeedetail += '<td width="9%" id="paidAmount'
															+ value.monthId
															+ '" style="background-color: #FFFFCC">'
															+ value.paidAmount
															+ '</td>';
												} else {
													monthwithfeedetail += '<td width="9%" id="paidAmount'
															+ value.monthId
															+ '" style="background-color: #FFFFCC">'
															+ value.paidAmount
															+ '('
															+ value.commonString
															+ ')</td>';
												}
												monthwithfeedetail += '<td width="9%" style="background-color: #FFFFCC">'
														+ discountAmount
														+ '</td><td width="9%" style="background-color: #FFFFCC">'
														+ balanceAmount
														+ '</td><td width="9%" id="feePaidStatus'
														+ value.monthId
														+ '" style="background-color: #FFFFCC"><a href=javascript:paymentStatus("'
														+ value.recieptNo
														+ '","'
														+ id
														+ '","'
														+ balanceAmount
														+ '");><span class="label label-warning">'
														+ value.feePaidStatus
														+ '</a></td>';

												if (value.paidBy == 'cheque') {
													monthwithfeedetail += '<td width="9%" style="background-color: #FFFFCC"><a href=javascript:showChequeDetails("'
															+ value.month
															+ '","'
															+ value.bankName
															+ '","'
															+ value.chequeNo
															+ '","'
															+ value.feePaidStatus
															+ '","'
															+ value.paidAmount
															+ '");><span class="label label-info">'
															+ value.paidBy
															+ '</span></a></td>';
												} else if (value.paidBy == 'cash') {
													monthwithfeedetail += '<td width="9%" style="background-color: #FFFFCC"><span class="label label-info">'
															+ value.paidBy
															+ '</span></td>';
												} else {
													monthwithfeedetail += '<td width="9%" style="background-color: #FFFFCC">'
															+ value.paidBy
															+ '</td>';
												}
												if (value.recieptNo == 0) {
													monthwithfeedetail += '<td width="9%" style="background-color: #FFFFCC">-</td>';
												} else {
													monthwithfeedetail += '<td width="9%" style="background-color: #FFFFCC"><a href="generatePDF.html?slipNo='
															+ value.recieptNo
															+ '&studentAdmissionNo='
															+ id
															+ '" target="_blank"><span class="label label-warning">View</span></a></td>';
												}
												monthwithfeedetail += '</tr></tbody></table>';
												monthwithfeedetail += '<div id="'+value.monthId+'" class="childtwo" style="width: 470px; margin-left: 25px;display: none;">';
												monthwithfeedetail += '<table width="50%" cellspacing="0" cellpadding="0" class="table">';
												monthwithfeedetail += '<thead><tr><th width="50%" class="head blue" style="color: white">Category Name</th>';
												monthwithfeedetail += '<th width="50%" class="head blue" style="color: white">Payable Amount<ul class="buttons">';
												monthwithfeedetail += '<li><a href="javascript:hidecategories('
														+ value.monthId
														+ ');"><div class="icon">';
												monthwithfeedetail += '<span class="ico-cancel"></span></div></a></li></ul></th>';
												monthwithfeedetail += '</tr></thead><tbody>';
												$
														.each(
																value.feesCategoriesDTOs,
																function(key,
																		value1) {
																	monthwithfeedetail += '<tr>';
																	monthwithfeedetail += '<td>'
																	if (value1.feeCategoryId == 14
																			|| value1.feeCategoryId == 15) {
																		monthwithfeedetail += '<a href=javascript:booksUniformDetails("'
																				+ id
																				+ '","'
																				+ value1.feeCategoryId
																				+ '","'
																				+ value.monthId
																				+ '")>'
																		monthwithfeedetail += value1.feeCategoryName
																		monthwithfeedetail += '</a>'
																				+ '</td>';
																		monthwithfeedetail += '<td width="10%"><a href=javascript:booksUniformDetails("'
																				+ id
																				+ '","'
																				+ value1.feeCategoryId
																				+ '","'
																				+ value.monthId
																				+ '")>'
																				+ value1.amounts
																		monthwithfeedetail += '</a>'
																	} else {
																		monthwithfeedetail += value1.feeCategoryName
																				+ '</td>';
																		monthwithfeedetail += '<td width="10%">'
																				+ value1.amounts
																	}
																	monthwithfeedetail += '</td></tr>';
																});
												monthwithfeedetail += '</tbody></table></div></div>';
												totalOpeningBalance = parseInt(openingBalance);
												totalClosingBalance = balanceAmount;
												openingBalance = balanceAmount;
											});
							//monthwithfeedetail += '<div width="100%" class="childone"><table width="100%" cellspacing="0" cellpadding="0" class="table table-hover"> <tbody><tr><td style="background-color: #FFFFCC"></td><td width="10%" style="background-color: #FFFFCC"></td><td width="15%" style="background-color: #FFFFCC"></td><td width="15%" style="background-color: #FFFFCC"></td><td width="15%" style="background-color: #FFFFCC"></td><td width="15%" style="background-color: #FFFFCC"></td><td width="15%" style="background-color: #FFFFCC"><a id="showfeepaynemtbutton" href="javascript:showfeepaynemtform();" style="display:none;"><span class="label label-warning">Pay Fees</span></a></td></tr></tbody></table></div>';
							monthwithfeedetail += '<table width="100%" cellspacing="0" cellpadding="0" class="table table-hover"><tr><td width="14%" style="background-color: #F3F383">Total'
									+ '</td><td width="9%" style="background-color: #F3F383">'
									+ totalOpeningBalance
									+ '</td><td width="9%" style="background-color: #F3F383">'
									+ totalGrossAmount
									+ '</td><td width="9%" style="background-color: #F3F383">'
									+ totalFineAmount
									+ '</td><td width="9%" style="background-color: #F3F383">'
									+ totalNetAmount
									+ '</td><td width="9%" style="background-color: #F3F383">'
									+ totalPaidAmount
									+ '</td><td width="9%" style="background-color: #F3F383">'
									+ totalDiscountAmount
									+ '</td><td width="9%" style="background-color: #F3F383">'
									+ totalClosingBalance
									+ '</td><td width="9%" style="background-color: #F3F383">'
									+ '</td><td width="20%" style="background-color: #F3F383">'
									+ '<div style="width: 104px; background-color: yellow; border: 1px solid gold; height: 24px; font: 145%/1.1 Lucida Console;" onclick="paymentDetails('
									+ id
									+ ');">PayDetails</div></td></tr></table></div></div>';

							var payment = '<div class="block"><div class="head green"><div class="icon"><span class="ico-pen-2"></span></div>';
							payment += '<h2>Fee Payment</h2></div><div class="data-fluid">';
							payment += '<table style="width: 744px; border: 1px solid lightgray; font: 80%/1.2 Lucida califunia; height: 129px;">';
							payment += '<tbody><tr><td style="width: 30px;">Gross Amount:</td><td style="width: 50px;">';
							payment += '<input type="text" readonly="readonly" style="height: 23px;" value="0" name="feeSubmissionDetailsDTOs[0].paidAmount" id="totalAmount"></td>';
							payment += '<td style="width: 30px;">Fine:</td> <td style="width: 50px;">';
							payment += '<input type="text" readonly="readonly" style="height: 23px;" id="fineAmount" value="0" name="feeSubmissionDetailsDTOs[0].fineAmount"></td>';
							payment += '<td style="width: 70px;">Discount in % <input type="radio" id="per" value="per" name="feeSubmissionDetailsDTOs[0].dis" onclick="disAmountType();">';
							payment += '/ Rs <input type="radio" value="rs" id="rs" name="feeSubmissionDetailsDTOs[0].dis" onclick="disAmountType();">: </td><td style="width: 50px;">';
							payment += ' <input type="text" name="feeSubmissionDetailsDTOs[0].discount" style="height: 23px;" value="0" onclick="getzeroremoved();" onkeyup="getDiscount(this.value)" id="disAmount">';
							payment += ' </td></tr><tr><td style="width: 30px;">Net Payable Amt</td><td style="width: 50px;">';
							payment += ' <input type="text" style="height: 23px;" readonly="readonly" id="discountAmount" name="feeSubmissionDetailsDTOs[0].netPayableAmount"></td>';
							payment += '<td>Paid Amt.</td><td><input type="text" style="height: 23px;" id="recentPaidAmount" value="0" name="feeSubmissionDetailsDTOs[0].recentPaidAmount" onclick="removezero();" oninput="converttowords(this.value);"></td>';
							payment += '<td style="width: 30px;"><font color="red">Due </font>:</td><td style="width: 50px;"><input type="text" style="height: 23px;" readonly="readonly" name="feeSubmissionDetailsDTOs[0].dueAmount" id="due"></td>';
							payment += '</tr><tr><td style="width: 30px;">Payment Type:</td>';
							payment += '<td style="width: 50px;"><select style="height: 23px;" class="validate[required]" onchange="getPaymentType(this.value)" name="feeSubmissionDetailsDTOs[0].paidBy" id="paymentType">';
							payment += '<option value="cash">Cash</option><option value="cheque">Cheque</option></select></td><td style="width: 30px;">Cheque Number:</td>';
							payment += '<td style="width: 50px;"><input type="text" style="height: 23px;" readonly="readonly" maxlength="6" name="feeSubmissionDetailsDTOs[0].chequeNo" id="checkNo"></td>';
							payment += '<td style="width: 30px;">Bank Name:</td><td style="width: 50px;"><input type="text" style="height: 23px;" readonly="readonly" name="feeSubmissionDetailsDTOs[0].bankName" id="bankName"></td>';
							payment += '</tr><tr><td>Amount in words</td><td colspan="3"><input type="text" readonly="readonly" style="height: 23px;" id="paidAmountInWord" value="" name="feeSubmissionDetailsDTOs[0].paidAmountInWord"></td>';
							payment += '<td>/-Only</td><td><div id="submitfee" style="display: none;"><a class="btn" href="javascript:validate();" >SubmitFee</a></div><div id="addfee" style="display: none;">&nbsp;&nbsp; <a id="addmorebutton" class="btn" href="javascript:addmore();">Add More</a></div></div></td></tr></tbody></table></div></div>';
							$("#payment").append(payment);
							$("#monthwithfeedetail").append(monthwithfeedetail);

							if (inprogressMonthId == 0) {
								enableFirstCheckBox(neededMonthId + 1);
								$("#neededMonthId").val(neededMonthId + 1);
							}
						},
						error : function(e) {

						}
					});
		}
	}
	function monthStatus(totalGrossAmount, totalFineAmount, totalNetAmount,
			totalDiscountAmount, totalPaidAmount) {
		var totalBalance = parseInt(totalNetAmount) - parseInt(totalPaidAmount)
				- parseInt(totalDiscountAmount);
		var payDetails = '<div class="block" style="background-color: #FFFFCC; opacity: 0.9; box-shadow: 0px 14px 21px 3px gray;"><div class="head" style="background-color:green;padding-left:10px;">';
		payDetails += '<h2 style="color: #fff">Payment Deatils '
				+ '</h2><ul class="buttons"><li><a href="javascript:hideChequeDetails();">';
		payDetails += '<div class="icon"><span class="ico-cancel"></span></div></a></li></ul></div>';
		payDetails += '<div class="data-fluid"><div class="row-form"><div class="span1" style="margin-left: 0px;width:180px;">Gross Amount :</div>';
		payDetails += '<div class="span1" style="margin-left: 0px;">'
				+ totalGrossAmount
				+ '</div></div></div><div class="data-fluid">';
		payDetails += '<div class="row-form"><div class="span1" style="margin-left: 0px;width:180px;">Fine Amount :</div>';
		payDetails += '<div class="span1" style="margin-left: 0px;">'
				+ totalFineAmount
				+ '</div></div></div><div class="data-fluid">';
		payDetails += '<div class="row-form"><div class="span1" style="margin-left: 0px;width:180px;">Net Amount :</div>';
		payDetails += '<div class="span1" style="margin-left: 0px;">'
				+ totalNetAmount + '</div></div></div><div class="data-fluid">';
		payDetails += '<div class="row-form"><div class="span1" style="margin-left: 0px;width:180px;">Discount Amount :</div>';
		payDetails += '<div class="span1" style="margin-left: 0px;">'
				+ totalDiscountAmount
				+ '</div></div></div><div class="data-fluid">';
		payDetails += '<div class="row-form"><div class="span1" style="margin-left: 0px;width:180px;">Paid Amount :</div>';
		payDetails += '<div class="span1" style="margin-left: 0px;">'
				+ totalPaidAmount
				+ '</div></div></div><div class="data-fluid">';
		payDetails += '<div class="row-form"><div class="span1" style="margin-left: 0px;width:180px;"><b>Balance :</b></div>';
		payDetails += '<div class="span1" style="margin-left: 0px;"><b>'
				+ totalBalance + '</b></div></div></div></div>';
		$("#chequeDetails").css("z-index", "1");
		$("#chequeDetails").append(payDetails);
	}
	function booksUniformDetails(studentId, categoryId, monthId) {
		$
				.ajax({
					type : "get",
					url : 'books-uniform-details',
					data : {
						'studentId' : studentId,
						'categoryId' : categoryId,
						'monthId' : monthId,
					},
					success : function(data, status) {
						$("#chequeDetails").empty();
						var obj = JSON.parse(data);
						var UniformDetails = '<div class="block" style="background-color: #FFFFCC; opacity: 0.9; box-shadow: 0px 14px 21px 3px gray;"><div class="head" style="background-color:green;padding-left:10px;">';
						UniformDetails += '<h2 style="color: #fff">Uniform Details'
								+ '</h2><ul class="buttons"><li><a href="javascript:hideChequeDetails();">';
						UniformDetails += '<div class="icon"><span class="ico-cancel"></span></div></a></li></ul></div>';
						UniformDetails += '<table class="table table-bordered table-primary"><thead><tr><th>Uniform Type</th><th>Category</th><th>Size</th><th>Price</th><th>Quantity</th><th>Amount</th><th>Net Amount</th></tr></thead>'

						var BooksDetails = '<div class="block" style="background-color: #FFFFCC; opacity: 0.9; box-shadow: 0px 14px 21px 3px gray;"><div class="head" style="background-color:green;padding-left:10px;">';
						BooksDetails += '<h2 style="color: #fff">Books Details'
								+ '</h2><ul class="buttons"><li><a href="javascript:hideChequeDetails();">';
						BooksDetails += '<div class="icon"><span class="ico-cancel"></span></div></a></li></ul></div>';
						BooksDetails += '<table class="table table-bordered table-primary"><thead><tr><th>SL. NO.</th><th>Book Name</th><th>Price</th></tr></thead>'
						if (obj.BooksDetails != '') {
							$.each(obj.BooksDetails, function(key, value) {
								BooksDetails += '<tbody><tr><td>'
										+ (key + parseInt(1)) + '</td><td>'
										+ value.bookTitle + '</td><td>'
										+ value.price + '</td></tr>';

							});
							BooksDetails += '</tbody></table>';
							$("#chequeDetails").append(BooksDetails);
						}
						if (obj.UniformDetails != '') {
							$.each(obj.UniformDetails, function(key, value) {
								UniformDetails += '<tbody><tr><td>'
										+ value.dressName + '</td><td>'
										+ value.category + '</td><td>'
										+ value.size + '</td><td>'
										+ value.price + '</td><td>'
										+ value.quantity + '</td><td>'
										+ value.price + '</td><td>'
										+ value.amount + '</td></tr>';
							});

							UniformDetails += '</tbody></table>';
							$("#chequeDetails").append(UniformDetails);
						}

						$("#chequeDetails").css("z-index", "1");

					},
					error : function(e) {

					}
				});
	}

	function paymentStatus(slipNo, studentId, balanceAmount) {
		$
				.ajax({
					type : "get",
					url : 'get-payment-status-details',
					data : {
						'studentId' : studentId,
						'slipNo' : slipNo,
					},
					success : function(data, status) {
						$("#chequeDetails").empty();
						var obj = JSON.parse(data);
						var totalGrossAmount = parseInt(obj.paidAmount)
								+ parseInt(obj.discount)
								+ parseInt(balanceAmount)
								- parseInt(obj.fineAmount);
						var totalNetAmount = parseInt(totalGrossAmount)
								+ parseInt(obj.fineAmount);
						var totalBalance = parseInt(totalNetAmount)
								- parseInt(obj.paidAmount)
								- parseInt(obj.discount);
						var payDetails = '<div class="block" style="background-color: #FFFFCC; padding: 8px; opacity: 0.9; box-shadow: 0px 14px 21px 3px gray;"><div class="head" style="background-color:green;padding-left:10px;">';
						payDetails += '<h2 style="color: #fff">Payment Details'
								+ '</h2><ul class="buttons"><li><a href="javascript:hideChequeDetails();">';
						payDetails += '<div class="icon"><span class="ico-cancel"></span></div></a></li></ul></div>';
						payDetails += '<div class="data-fluid"><div class="row-form"><div class="span1" style="margin-left: 0px;width:150px;">Paid Date :</div>';
						payDetails += '<div class="span1" style="margin-left: 0px;">'
								+ obj.feePaidDate
								+ '</div></div></div><div class="data-fluid">';
						payDetails += '<div class="data-fluid"><div class="row-form"><div class="span1" style="margin-left: 0px;width:150px;">Gross Amount :</div>';
						payDetails += '<div class="span1" style="margin-left: 0px;">'
								+ totalGrossAmount
								+ '</div></div></div><div class="data-fluid">';
						payDetails += '<div class="row-form"><div class="span1" style="margin-left: 0px;width:150px;">Fine Amount :</div>';
						payDetails += '<div class="span1" style="margin-left: 0px;">'
								+ obj.fineAmount
								+ '</div></div></div><div class="data-fluid">';
						payDetails += '<div class="row-form"><div class="span1" style="margin-left: 0px;width:150px;">Net Amount :</div>';
						payDetails += '<div class="span1" style="margin-left: 0px;">'
								+ totalNetAmount
								+ '</div></div></div><div class="data-fluid">';
						payDetails += '<div class="row-form"><div class="span1" style="margin-left: 0px;width:150px;">Paid Amount :</div>';
						payDetails += '<div class="span1" style="margin-left: 0px;">'
								+ obj.paidAmount
								+ '</div></div></div><div class="data-fluid">';
						payDetails += '<div class="row-form"><div class="span1" style="margin-left: 0px;width:150px;">Discount :</div>';
						payDetails += '<div class="span1" style="margin-left: 0px;">'
								+ obj.discount + '</div></div></div></div>';
						payDetails += '<div class="row-form"><div class="span1" style="margin-left: 0px;width:150px;"><b>Balance :</b></div>';
						payDetails += '<div class="span1" style="margin-left: 0px;"><b>'
								+ totalBalance + '</b></div></div></div></div>';
						$("#chequeDetails").css("z-index", "1");
						$("#chequeDetails").append(payDetails);
					},
					error : function(e) {

					}
				});
	}

	function paymentDetails(studentId) {
		$
				.ajax({
					type : "get",
					url : 'get-payment-details',
					data : {
						'studentAdmissionNo' : studentId,
					},
					success : function(data, status) {
						var obj = JSON.parse(data);
						$("#chequeDetails").empty();
						var totalGrossAmount = 0;
						var totalFineAmount = 0;
						var totalNetAmount = 0;
						var totalPaidAmount = 0;
						var totalBalance = 0;
						var discountAmount = 0;
						var totalDiscountAmount = 0;
						$.each(obj, function(key, value) {
							totalGrossAmount += parseInt(value.grossAmount);
							totalFineAmount += parseInt(value.fineAmount);
							if (value.paidAmount == '-') {
								var paidAmoutnt = 0;
								totalPaidAmount += parseInt(paidAmoutnt);
							} else {
								totalPaidAmount += parseInt(value.paidAmount);
							}
							if (value.discountAmount == null) {
								discountAmount = 0;
							} else {
								discountAmount = value.discountAmount;
							}
							totalDiscountAmount += parseInt(discountAmount);
						});
						totalNetAmount = parseInt(totalGrossAmount)
								+ parseInt(totalFineAmount);
						totalBalance = parseInt(totalNetAmount)
								- parseInt(totalPaidAmount)
								- parseInt(totalDiscountAmount);
						var payDetails = '<div class="block" style="background-color: #FFFFCC; opacity: 0.9; box-shadow: 0px 14px 21px 3px gray;"><div class="head" style="background-color:green;padding-left:10px;">';
						payDetails += '<h2 style="color: #fff">Payment Deatils '
								+ '</h2><ul class="buttons"><li><a href="javascript:hideChequeDetails();">';
						payDetails += '<div class="icon"><span class="ico-cancel"></span></div></a></li></ul></div>';
						payDetails += '<div class="data-fluid"><div class="row-form"><div class="span1" style="margin-left: 0px;width:180px;">Gross Amount :</div>';
						payDetails += '<div class="span1" style="margin-left: 0px;">'
								+ totalGrossAmount
								+ '</div></div></div><div class="data-fluid">';
						payDetails += '<div class="row-form"><div class="span1" style="margin-left: 0px;width:180px;">Fine Amount :</div>';
						payDetails += '<div class="span1" style="margin-left: 0px;">'
								+ totalFineAmount
								+ '</div></div></div><div class="data-fluid">';
						payDetails += '<div class="row-form"><div class="span1" style="margin-left: 0px;width:180px;">Net Amount :</div>';
						payDetails += '<div class="span1" style="margin-left: 0px;">'
								+ totalNetAmount
								+ '</div></div></div><div class="data-fluid">';
						payDetails += '<div class="row-form"><div class="span1" style="margin-left: 0px;width:180px;">Paid Amount :</div>';
						payDetails += '<div class="span1" style="margin-left: 0px;">'
								+ totalPaidAmount
								+ '</div></div></div><div class="data-fluid">';
						payDetails += '<div class="row-form"><div class="span1" style="margin-left: 0px;width:180px;">Discount :</div>';
						payDetails += '<div class="span1" style="margin-left: 0px;">'
								+ totalDiscountAmount + '</div></div></div>';
						payDetails += '<div class="row-form"><div class="span1" style="margin-left: 0px;width:180px;"><b>Balance :</b></div>';
						payDetails += '<div class="span1" style="margin-left: 0px;"><b>'
								+ totalBalance + '</b></div></div></div></div>';
						$("#chequeDetails").css("z-index", "1");
						$("#chequeDetails").append(payDetails);
					},
					error : function(e) {

					}
				});
	}
	function enableanddisable(flag) {
		var monthsId = document
				.getElementsByName("feeSubmissionDetailsDTOs[0].monthsId");
		$.each(monthsId, function(key, value) {
			if (flag && !this.checked) {
				$(value).prop("disabled", false);
				value.checked = true;

			}
			if (!flag && this.checked) {
				value.click();
			}
		});
	}
	function getClear() {
		$("#classId").val('');
		$("#sectionId").val('');
		$("#studentId").val('');
	}
	function validate() {
		$("#addmorediv").empty();
		$("#studentAddmissionNoDiv").empty();
		flage = true;
		if ($("#paymentType").val() == 'cheque' && $("#bankName").val() == '') {
			flage = false;
			alert("Enter Bank Name Please");
		}
		if ($("#paymentType").val() == 'cheque'
				&& ($("#checkNo").val() == '' || $("#checkNo").val().length < 6)) {
			flage = false;
			alert("Please Enter 6 digit valid Cheque No.");

		} else if ($("#paymentType").val() == 'cheque'
				&& $("#checkNo").val() == '') {
			flage = false;
			alert("Please Enter 6 digit valid Cheque No.");
		} else if ($("#paymentType").val() == 'cheque'
				&& !$.isNumeric($("#checkNo").val())) {
			flage = false;
			alert("Cheque No. in numbers only.");
		} else if ($("#recentPaidAmount").val() == ''
				|| $("#recentPaidAmount").val() <= 0) {
			flage = false;
			alert("Please Enter Amount");
		}
		if ($("#month12").is(":checked")) {
			if ($("#due").val() != 0) {
				flage = false;
				alert("no due remain at the end of this session");
			}
		}
		$("#studentAddmissionNoDiv")
				.append(
						"<input type='hidden' name='feeSubmissionDetailsDTOs[0].studentAdmissionNo' value="
								+ $('#studentAdmissionNo').val() + ">");
		var inWords = toWords($("#recentPaidAmount").val());
		$("#paidAmountInWords").val(inWords);
		converttowords($("#recentPaidAmount").val());
		if (flage) {
			$("#validateform").submit();
			
		}

	}
	function removezero() {
		var paid = $("#recentPaidAmount").val();
		if (paid == 0)
			$("#recentPaidAmount").val('');
	}
	function getzeroremoved() {
		var discounts = $("#disAmount").val();
		if (discounts == 0)
			$("#disAmount").val('');
		if ($("#per").is(":checked")) {
			disType = 'per';
		} else if ($("#rs").is(":checked")) {
			disType = 'rs';
		} else {
			alert('Select Discount Type');
		}
	}
	//
	function enableFirstCheckBox(value) {
		$("#month" + value).prop("disabled", false);
	}
	function viewcategories(value) {
		$("#" + value).fadeIn(1000);
	}
	function hidecategories(value) {
		$("#" + value).fadeOut(1000);
	}
	function showChild(value, checked, grossAmount, fineAmount, dueAmount) {
		if (dueAmount == 0) {
			dueAmount = fineAmount;
		}
		disAmount = 0;
		if ($("#disAmount").val() != '') {
			disAmount = $("#disAmount").val();
		}
		if (checked) {
			$("#totalAmount").val(parseInt(grossAmount));
			$("#fineAmount").val(parseInt(fineAmount));
			$("#discountAmount").val(
					parseInt(grossAmount + fineAmount) - parseInt(disAmount));
			if ($("#recentPaidAmount").val() == '') {
				$("#due").val($("#discountAmount").val());
			} else {
				$("#due").val(
						$("#discountAmount").val()
								- $("#recentPaidAmount").val());
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
			$("#totalAmount").val(parseInt(dueAmount) - parseInt(fineAmount));
			$("#fineAmount").val(parseInt(fineAmount));
			$("#discountAmount").val(parseInt(dueAmount) - parseInt(disAmount));
			$("#recentPaidAmount").val('');
			$("#due").val(parseInt(dueAmount) - parseInt(disAmount));
			/* if ($("#discountAmount").val() == 0) {
				$("#disAmount").val('');
				$("#recentPaidAmount").val('');
				$("#due").val('');
				$("#submitfee").hide();
			} */

		}
	}

	function hideChequeDetails() {
		$("#chequeDetails").empty();
		$("#chequeDetails").css("z-index", "-1");
	}
	function showChequeDetails(monthName, bankName, chequeNo, status,
			paidAmount) {
		$("#chequeDetails").empty();
		var chequeDetails = '<div class="block" style="background-color: lightblue; opacity: 0.9; box-shadow: 0px 14px 21px 3px gray;"><div class="head" style="background-color:#009ad7;padding-left:10px;">';
		chequeDetails += '<h2>Cheque Deatils for '
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
	var monthIdArray = [];
	function addmore() {

		var rowCount = $("#addmoreid").val();
		var flage = true;
		if ($("#month12").is(":checked")) {
			if ($("#due").val() != 0) {
				flage = false;
				alert("no due remain at the end of this session");
			}
		}
		if (rowCount == 0) {
			$("#paymenttypeaddmore").val($("#paymentType").val());
		}
		if ($("#paymenttypeaddmore").val() != $("#paymentType").val()) {
			flage = false;
			alert("payement type not same as for previous Student");
		}
		var monthsId = document
				.getElementsByName("feeSubmissionDetailsDTOs[0].monthsId");

		var existanceFlage = false;
		var countAddMore = 0;
		if (!$.isEmptyObject(monthIdArray)) {
			$.each(monthsId, function(key, value) {
				if (this.checked && !this.disabled) {
					countAddMore = (parseInt(countAddMore) + 1);
					if ($.inArray(key, monthIdArray) == -1) {
						flage = false;
						existanceFlage = true;
					}
				}
			});
		}
		if (countAddMore != monthIdArray.length) {
			flage = true;
			existanceFlage = true;
		}
		if (existanceFlage) {
			//alert("Select Month are not same for Students");
		}

		if (flage) {
			var studentAdmissionNo = $("#studentAdmissionNo").val();
			var content = '<div class="block" id="studentAddMoreData'+studentAdmissionNo+'"><div class="head green"><div class="icon"><span class="ico-pen-2"></span></div><h2>'
					+ $("#fullName").val()
					+ '</h2><ul class="buttons"><li><a href="javascript:remavetotalData('
					+ studentAdmissionNo
					+ ');"><div class="icon"><span class="ico-cancel"></span></div></a></li> </ul></div><div class="data-fluid">';
			content += '<table style="width: 744px; border: 1px solid lightgray; font: 80%/1.2 Lucida califunia; height: 129px;"><tbody><tr><td style="width: 30px;">Gross Amount:</td><td style="width: 50px;">';
			content += '<input id="paidAmount' + studentAdmissionNo
					+ '" type="hidden" name="feeSubmissionDetailsDTOs['
					+ rowCount + '].paidAmount" value="'
					+ $("#totalAmount").val() + '">' + $("#totalAmount").val()
					+ '</td>';
			content += '<td style="width: 30px;">Fine:</td> <td style="width: 50px;">';
			content += '<input type="hidden" name="feeSubmissionDetailsDTOs['
				+ rowCount + '].studentAdmissionNo" value="'
				+ studentAdmissionNo
				+ '"><input type="hidden" id="fineAmount'
					+ studentAdmissionNo
					+ '" name="feeSubmissionDetailsDTOs['
					+ rowCount
					+ '].fineAmount" value="'
					+ $("#fineAmount").val() + '">';

			var i = 0;
			$
					.each(
							monthsId,
							function(key, value) {
								if (this.checked && !this.disabled) {
									monthIdArray.push(key);
									content += '<input type="hidden" name="feeSubmissionDetailsDTOs['
											+ rowCount
											+ '].monthsId['
											+ (i)
											+ ']" value="' + this.value + '">';
									i = parseInt(i) + 1;
								}
							});
			content += '' + $("#fineAmount").val()
					+ '</td><td style="width: 70px;">Discount in';
			var discountAmountAddMore = '';
			if ($("#per").is(":checked")) {
				discountAmountAddMore = ((parseInt($("#totalAmount").val()) * parseInt($(
						"#disAmount").val())) / 100);
				content += ' % <input type="hidden"  name="feeSubmissionDetailsDTOs['+rowCount+'].dis" value="per">percentage';

			} else if ($("#rs").is(":checked")) {
				discountAmountAddMore = $("#disAmount").val();
				content += '&nbsp;Rs <input type="hidden" name="feeSubmissionDetailsDTOs['+rowCount+'].dis" value="rs">: </td>';

			}
			content += '<td style="width: 50px;">';
			content += '<input type="hidden" id="disAmount'
					+ studentAdmissionNo + '" value="' + discountAmountAddMore
					+ '"  name="feeSubmissionDetailsDTOs[' + rowCount
					+ '].discount">'
					+ discountAmountAddMore + '</td>';
			content += '</tr><tr><td style="width: 30px;">Net Payable Amt</td><td style="width: 50px;"> <input id="netPayableAmount'
					+ studentAdmissionNo
					+ '" type="hidden" value="'
					+ $("#discountAmount").val()
					+ '" name="feeSubmissionDetailsDTOs['
					+ rowCount
					+ '].netPayableAmount">'
					+ $("#discountAmount").val()
					+ '</td>';
			content += '<td>Paid Amt.</td><td><input type="hidden" id="recentPaidAmount'
					+ studentAdmissionNo
					+ '" name="feeSubmissionDetailsDTOs['
					+ rowCount
					+ '].recentPaidAmount" value="'
					+ $("#recentPaidAmount").val()
					+ '">'
					+ $("#recentPaidAmount").val() + '</td>';
			content += '<td style="width: 30px;"><font color="red">Due </font>:</td><td style="width: 50px;"><input type="hidden" id="dueAmount'
					+ studentAdmissionNo
					+ '" name="feeSubmissionDetailsDTOs['
					+ rowCount
					+ '].dueAmount" value="'
					+ $("#due").val()
					+ '">' + $("#due").val() + '</td>';
			content += '</tr><tr><td style="width: 30px;">Payment Type:</td><td style="width: 50px;">';
			content += '<input type="hidden" name="feeSubmissionDetailsDTOs['
					+ rowCount + '].paidBy" value="' + $("#paymentType").val()
					+ '">' + $("#paymentType").val() + '';
			content += '</td><td style="width: 30px;">Cheque Number:</td><td style="width: 50px;">';
			content += '<input type="hidden" name="feeSubmissionDetailsDTOs['
					+ rowCount + '].chequeNo" value="' + $("#checkNo").val()
					+ '">' + $("#checkNo").val() + '</td>';
			content += '<td style="width: 30px;">Bank Name:</td><td style="width: 50px;">';
			content += '<input type="hidden" name="feeSubmissionDetailsDTOs['
					+ rowCount + '].bankName" value="' + $("#bankName").val()
					+ '">' + $("#bankName").val() + '</td></tr>';
			content += '<tr><td>Amount in words</td><td colspan="3"><input type="text" name="feeSubmissionDetailsDTOs['
					+ rowCount
					+ '].paidAmountInWord" value="'
					+ $("#paidAmountInWord").val()
					+ '" style="height: 23px;" readonly="readonly"></td>';
			content += '<td>/-Only</td><td></td></tr></tbody></table></div></div>';
			$("#addmorediv").append(content);
			$("#addmoreid").val(parseInt(rowCount) + 1);
			$("#totalGrossAmount").val(
					parseInt($("#totalGrossAmount").val())
							+ parseInt($("#totalAmount").val()));
			$("#totalFineAmount").val(
					parseInt($("#totalFineAmount").val())
							+ parseInt($("#fineAmount").val()));
			if (discountAmountAddMore == '') {
				$("#totalDisAmount").val(parseInt($("#totalDisAmount").val()));
			} else {
				$("#totalDisAmount").val(
						parseInt($("#totalDisAmount").val())
								+ parseInt(discountAmountAddMore));
			}

			$("#totalDiscountAmount").val(
					parseInt($("#totalDiscountAmount").val())
							+ parseInt($("#discountAmount").val()));
			$("#totalRecentPaidAmount").val(
					parseInt($("#totalRecentPaidAmount").val())
							+ parseInt($("#recentPaidAmount").val()));
			$("#totalDue").val(
					parseInt($("#totalDue").val()) + parseInt($("#due").val()));
			$("#totalData").show();
			getClear();
			$("#monthwithfeedetail").empty();
			$("#studentDetails").empty();
			$("#payment").empty();
			$("#appendStudentName").empty();
		}
	}
	function remavetotalData(studentAddmissionNo) {
		$("#totalGrossAmount").val(
				parseInt($("#totalGrossAmount").val())
						- parseInt($("#paidAmount" + studentAddmissionNo + "")
								.val()));
		$("#totalFineAmount").val(
				parseInt($("#totalFineAmount").val())
						- parseInt($("#fineAmount" + studentAddmissionNo + "")
								.val()));
		$("#totalDisAmount").val(
				parseInt($("#totalDisAmount").val())
						- parseInt($("#disAmount" + studentAddmissionNo + "")
								.val()));
		$("#totalDiscountAmount").val(
				parseInt($("#totalDiscountAmount").val())
						- parseInt($(
								"#netPayableAmount" + studentAddmissionNo + "")
								.val()));
		$("#totalRecentPaidAmount").val(
				parseInt($("#totalRecentPaidAmount").val())
						- parseInt($(
								"#recentPaidAmount" + studentAddmissionNo + "")
								.val()));
		$("#totalDue").val(
				parseInt($("#totalDue").val())
						- parseInt($("#dueAmount" + studentAddmissionNo + "")
								.val()));
		$("#studentAddMoreData" + studentAddmissionNo + "").remove();
		if ($("#totalGrossAmount").val() == 0) {
			$("#totalData").hide();
		}
	}
	function submitForm() {
		var inWords = toWords($("#totalRecentPaidAmount").val());
		$("#paidAmountInWords").val(inWords);
		$("#validateform").submit();
		
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
	<br> <input type="hidden" id="addmoreid" value="0"><input
		type="hidden" id="paymenttypeaddmore">

	<!-- action="fee-payment" -->
	<f:form commandName="studentFeeSubmissionDetailsDTO" method="POST"
		id="validateform" action="fee-payment">
		<div id="studentAddmissionNoDiv"></div>
		<div class="row-fluid">
			<!--  <div class="span4">
				<div class="block" style="width: 299px;">
					<div id="searches2"
						style="height: auto; width: 297px; border: 1px solid lightgray; background-color: rgb(238, 238, 238); border-radius: 5px;">
						<div class="data-fluid">
							<div class="row-form">
								<div class="span4">Student Id :</div>
								<div class="span8">
									<input type="text" name="studentId"
										oninput="getStudentDatabyId(this.value);">
								</div>
							</div>

						</div>
						<div class="separator"></div>
					</div>
				</div>
			</div>  -->
			<div class="span4">
				<div class="block" style="width: 299px;">
					<div id="searches1"
						style="height: auto; width: 297px; border: 1px solid lightgray; background-color: rgb(238, 238, 238); border-radius: 5px;">
						<div class="data-fluid">
						<div class="row-form">
								<div class="span4">Student Id:</div>
								<div class="span8">
									<input type="text" name="studentId"
										oninput="getStudentDatabyId(this.value);">
								</div>
							</div>
							<div class="row-form">
								<div class="span4">Session :</div>
								<div class="span8">
									<select id="sessionId" class="validate[required]"
										onchange="getClear();" name="sessionId" class="select">
										<option value="${current.sessionId}">${current.sessionDuration}</option>
										<c:forEach var="list" items="${sessionList}">
											<option value="${list.sessionId}">${list.sessionDuration}</option>
										</c:forEach>
									</select>
								</div>
							</div>
							<div class="row-form">
								<div class="span4">Class :</div>
								<div class="span8">
									<select id="classId" class="validate[required]"
										onchange="getSectionList(this.value);" name="classId"
										class="select">
										<option value="">Select a Class</option>
										<c:forEach var="list" items="${classesList}">
											<option value="${list.classId}">${list.className}</option>
										</c:forEach>
									</select>
								</div>
							</div>
							<div class="row-form">
								<div class="span4">Section :</div>
								<div class="span8">
									<select id="sectionId" class="validate[required]"
										onchange="getStudentList();" name="sectionId" class="select">
										<option value="">Select a Section</option>
									</select>
								</div>
							</div>
						</div>
						<input type="hidden" name="studentAdmissionNo"
							id="studentAdmissionNo"> <input type="hidden"
							id="neededMonthId"> <input type="hidden"
							name="paidAmountInWord" id="paidAmountInWords">
						<div class="separator"></div>
					</div>
				</div>
			</div>
			<div class="span8">
				<div id="addmorediv"
					style="float: right; z-index: -1; height: auto; right: 296px;"></div>
				<div id="totalData"
					style="float: right; z-index: -1; height: 180px; right: 296px; display: none;">
					<div class="block">
						<div class="head green">
							<div class="icon">
								<span class="ico-pen-2"></span>
							</div>
							<h2>Fee Payment Summary</h2>

						</div>
						<div class="data-fluid">
							<table
								style="width: 744px; border: 1px solid lightgray; font: 80%/1.2 Lucida califunia; height: 129px;">
								<tbody>
									<tr>
										<td style="width: 30px;">Gross Amount:</td>
										<td style="width: 50px;"><input type="text" value="0"
											id="totalGrossAmount"
											name="studentFeeSubmissionDetailsDTO.paidAmount"
											style="height: 23px;" readonly="readonly"></td>
										<td style="width: 30px;">Fine:</td>
										<td style="width: 50px;"><input type="text"
											name="studentFeeSubmissionDetailsDTO.fineAmount" value="0"
											id="totalFineAmount" style="height: 23px;"
											readonly="readonly"></td>
										<td style="width: 70px;">Discount</td>
										<td style="width: 50px;"><input type="text"
											id="totalDisAmount" readonly="readonly" value="0"
											style="height: 23px;"
											name="studentFeeSubmissionDetailsDTO.discount"></td>
									</tr>
									<tr>
										<td style="width: 30px;">Net Payable Amt</td>
										<td style="width: 50px;"><input type="text" value="0"
											name="studentFeeSubmissionDetailsDTO.netPayableAmount"
											id="totalDiscountAmount" readonly="readonly"
											style="height: 23px;"></td>
										<td>Paid Amt.</td>
										<td><input type="text"
											name="studentFeeSubmissionDetailsDTO.recentPaidAmount"
											readonly="readonly" value="0" id="totalRecentPaidAmount"
											style="height: 23px;"></td>
										<td style="width: 30px;"><font color="red">Due </font>:</td>
										<td style="width: 50px;"><input type="text" id="totalDue"
											value="0" name="studentFeeSubmissionDetailsDTO.dueAmount"
											readonly="readonly" style="height: 23px;"></td>
									</tr>
									<tr>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td><a href="javascript:submitForm();" class="btn">Submit</a></td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>




				</div>
				<div class="span8" id="studentDetails"
					style="width: 710px; height: auto; margin-bottom: 0px; margin-left: -28px;"></div>
			</div>
		</div>
		<hr>
		<div id="chequeDetails"
			style="float: right; z-index: -1; height: 220px; position: fixed; top: 225px; right: 296px;">

		</div>
		<div class="row-fluid" style="width: 1079px;">
			<div class="span4" style="width: 300px;">
				<div class="block" id="appendStudentName"></div>
			</div>
			<div class="span8" style="width: 765px; margin-left: 14px;">
				<div class="block" style="float: right;" id="monthwithfeedetail">
				</div>
			</div>
		</div>
		<div id="feeAllotment"
			style="width: 654px; margin: 25px auto 0px; float: left;"></div>
		<div id="payment">
			<div id="err" class="form-inline" style="float: left;">
				<p id="v1"></p>
			</div>
		</div>

		<div id="subButton" style="width: 654px; float: left;"></div>

	</f:form>
<input type="hidden" id="refresh" value="no">

</div>  --%>