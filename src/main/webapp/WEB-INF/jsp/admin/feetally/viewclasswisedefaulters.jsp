<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url value="/style/theme/images" var="imageurl" />
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/img" var="img_url" />
<spring:url value="/css" var="css_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/setting.css">
<spring:url value="/img" var="img" />
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
	function getclassdefaulters(classId) {
		$("#DefaulterList").empty();
		$("#DefaulterList")
				.append(
						'<center><img src="${img}/loads.gif" alt="Loading" style="width=200px;height=200px;"></center>');
		var url = 'getclassdefaulters/' + classId;
		$
				.ajax({
					url : url,

					type : 'POST',
					success : function(data, status) {
						$("#DefaulterList").empty();
						var j = JSON.parse(data);
						var st = "";
						var length = j.length;
						if (length == 0) {
							st = '<div class="failedmsg"><h5 align="center"><font color="red"><b>There are no defaulter students</b></font></h5></div>';
						} else {

							st = st
									+ '<div><div class="widget-body"  style="padding: 10px 0px 0px; margin-top: -50px;"><div class="separator"></div><div class="btn-group" style="width: 400px;">'
									+ '</div><div class="block"><a style="float-right;"href="showclasswisedefaulterpdfreport?id='
									+ classId
									+ '" target="_blank"><img src="${img}/pdf.png"style="margin-left: 915px;"></a><div class="head blue"><h4 style="text-align:center">Students With Fee Dues</h4></div>'
									+ '<table class="table table-bordered table-primary"><thead><tr><th>S.no</th><th>Student Name</th><th>Father Name</th><th>Balance Amount</th><th>Mobile</th><th>Address</th><th>Fee UnPaid Month</th></tr></thead><tbody>';
							for ( var i = 0; i < length; i++) {
								st += '<tr><td>'
										+ (i + 1)
										+ '. </td><td>'
										+ j[i].firstName
										+ " "
										+ j[i].middleName
										+ " "
										+ j[i].lastName
										+ '</td><td>'
										+ j[i].fatherName
										+ '</td><td>'
										+ j[i].balanceAmount
										+ '</td><td>'
										+ j[i].mobile
										+ '</td><td>'
										+ j[i].addressLine1
										+ '</td><td><a class="btn" href="javascript:getFeeUnpaidMonths('
										+ j[i].admissionNo
										+ ')">View</a></td></tr>';
							}
							st += '</table>';
						}
						$("#DefaulterList").append(st);
					},
					error : function(error, status) {
					}
				});
	}

	function getFeeUnpaidMonths(studentAdmissionNo) {
		$
				.ajax({
					url : 'get-fee-unpaid-month',
					type : 'GET',
					data : {
						'studentAdmissionNo' : studentAdmissionNo
					},
					success : function(data, status) {
						$("#feeunpaidmonths").empty();
						$("#feeunpaidmonthscategory").empty();
						var obj = JSON.parse(data);
						var monthwithfeedetail = '<div class="span12"><div class="block" style="background-color: white;"><div class="head green"><div class="icon"></div>';
						monthwithfeedetail += '<h2>Fee Unpaid Months</h2><ul class="buttons"><li><a href="javascript:hidemonths();"><div class="icon">';
						monthwithfeedetail += '<span class="ico-cancel"></span></div></a></li></ul></div>';
						monthwithfeedetail += '<div class="data-fluid"><div class="classshowheader"><table width="100%" cellspacing="0" cellpadding="0" class="table table-hover">';
						monthwithfeedetail += '<th style="background-color: #FFCC99" width="15%">Month Name</th>';
						monthwithfeedetail += '<th style="background-color: #FFCC99" width="15%">Gross Amount</th>';
						monthwithfeedetail += '<th style="background-color: #FFCC99" width="15%">Paid Amount</th>';
						monthwithfeedetail += '<th style="background-color: #FFCC99" width="15%">Status</th>';
						monthwithfeedetail += '<th style="background-color: #FFCC99" width="15%">Fee Categories</th>';
						monthwithfeedetail += '<th style="background-color: #FFCC99" width="15%">Paid By</th>';
						monthwithfeedetail += '<th style="background-color: #FFCC99" width="15%">Reciept</th></tr></thead></table></div>';
						monthwithfeedetail += '<div class="classshowheader" width="100%">';
						var neededMonthId = 0;
						$
								.each(
										obj.StudentFeeSubmissionDetailsDTOs,
										function(key, value) {

											monthwithfeedetail += '<div class="childone" width="100%"><table width="100%" cellspacing="0" cellpadding="0" class="table table-hover">';
											monthwithfeedetail += ' <tbody><tr>';
											monthwithfeedetail += '<td width="15%" style="background-color: #FFFFCC">'
													+ value.month + '</td>';
											monthwithfeedetail += '<td width="15%" id="grossAmount'
													+ value.monthId
													+ '" style="background-color: #FFFFCC">'
													+ value.grossAmount
													+ '</td>';
											if (value.commonString == null) {
												monthwithfeedetail += '<td width="15%" id="paidAmount'
														+ value.monthId
														+ '" style="background-color: #FFFFCC">'
														+ value.paidAmount
														+ '</td>';
											} else {
												monthwithfeedetail += '<td width="15%" id="paidAmount'
														+ value.monthId
														+ '" style="background-color: #FFFFCC">'
														+ value.paidAmount
														+ '('
														+ value.commonString
														+ ')</td>';
											}
											monthwithfeedetail += '<td width="15%" id="feePaidStatus'
													+ value.monthId
													+ '" style="background-color: #FFFFCC">'
													+ value.feePaidStatus
													+ '</td>';
											monthwithfeedetail += '<td width="15%" style="background-color: #FFFFCC"><a href="javascript:viewcategories('
													+ value.monthId
													+ ');"><span class="label label-info">View</span></a></td>';

											if (value.paidBy == 'cheque') {
												monthwithfeedetail += '<td width="15%" style="background-color: #FFFFCC"><a href=javascript:showChequeDetails("'
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
												monthwithfeedetail += '<td width="15%" style="background-color: #FFFFCC"><span class="label label-info">'
														+ value.paidBy
														+ '</span></td>';
											} else {
												monthwithfeedetail += '<td width="15%" style="background-color: #FFFFCC">'
														+ value.paidBy
														+ '</td>';
											}

											if (value.recieptNo == 0) {
												monthwithfeedetail += '<td width="15%" style="background-color: #FFFFCC">-</td>';
											} else {
												monthwithfeedetail += '<td width="15%" style="background-color: #FFFFCC"><a href="generatePDF.html?slipNo='
														+ value.recieptNo
														+ '&studentAdmissionNo='
														+ studentAdmissionNo
														+ '" target="_blank"><span class="label label-warning">View</span></a></td>';
											}
											monthwithfeedetail += '</tr></tbody></table>';
											var feeunpaidmonthscategory = '<div id="'+value.monthId+'" class="childtwo" style="margin-left: 25px;display: none;background-color: white;">';
											feeunpaidmonthscategory += '<table width="50%" cellspacing="0" cellpadding="0" class="table">';
											feeunpaidmonthscategory += '<thead><tr><th width="50%" class="head blue" style="color: white">Category Name('
													+ value.month + ')</th>';
											feeunpaidmonthscategory += '<th width="50%" class="head blue" style="color: white">Payable Amount<ul class="buttons">';
											feeunpaidmonthscategory += '<li><a href="javascript:hidecategories('
													+ value.monthId
													+ ');"><div class="icon">';
											feeunpaidmonthscategory += '<span class="ico-cancel"></span></div></a></li></ul></th>';
											feeunpaidmonthscategory += '</tr></thead><tbody>';
											$
													.each(
															value.feesCategoriesDTOs,
															function(key,
																	value1) {

																feeunpaidmonthscategory += '<tr>';
																feeunpaidmonthscategory += '<td>'
																		+ value1.feeCategoryName
																		+ '</td>';
																feeunpaidmonthscategory += '<td width="15%">'
																		+ value1.amounts
																		+ '</td></tr>';

															});
											feeunpaidmonthscategory += '</tbody></table></div></div>';
											$("#feeunpaidmonthscategory")
													.append(
															feeunpaidmonthscategory);
										});
						monthwithfeedetail += '<div width="100%" class="childone"><table width="100%" cellspacing="0" cellpadding="0" class="table table-hover"> <tbody><tr><td style="background-color: #FFFFCC"></td><td width="15%" style="background-color: #FFFFCC"></td><td width="15%" style="background-color: #FFFFCC"></td><td width="15%" style="background-color: #FFFFCC"></td><td width="15%" style="background-color: #FFFFCC"></td><td width="15%" style="background-color: #FFFFCC"></td><td width="15%" style="background-color: #FFFFCC"><a id="showfeepaynemtbutton" href="javascript:showfeepaynemtform();" style="display:none;"><span class="label label-warning">Pay Fees</span></a></td></tr></tbody></table></div>';
						monthwithfeedetail += '</div></div></div></div>';
						$("#feeunpaidmonths").append(monthwithfeedetail);

					},
					error : function(error, status) {
					}
				});
	}
	function viewcategories(value) {
		var monthId = $("#showmonthid").val();
		$("#" + monthId).hide();
		$("#" + value).show();
		$("#showmonthid").val(value);
	}
	function hidecategories(value) {
		$("#" + value).hide();
	}
	function hidemonths() {
		$("#feeunpaidmonths").empty();
	}
	function validate() {
		var classId = $("#classId").val();
		if (classId == "" || classId == null) {
			document.getElementById("v1").innerHTML = "All fields are required";
			return false;

		} else {
			document.getElementById("v1").innerHTML = "";
			return true;
		}

	}
	function hideChequeDetails() {
		$("#chequeDetails").empty();
	}
	function showChequeDetails(monthName, bankName, chequeNo, paidAmount,
			status) {
		$("#chequeDetails").empty();
		var chequeDetails = '<div class="block" style="background-color: white;"><div class="head blue">';
		chequeDetails += '<h2>Cheque Deatils '
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
		$("#chequeDetails").append(chequeDetails);
	}
</script>
<div class="content">
	<div id="content-header" style="height: 150px;">
		<img alt="Show_settings" src="${img_url}/sfees.jpg"
			style="width: 50px; margin-top: -12px;">
		<h1>Fee Dues</h1>
		<h3>Check ClassWise Fee Dues</h3>
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
	<div id="chequeDetails"
		style="width: 328px; right: 250px; top: 390px; float: right; z-index: 10; height: 220px; position: absolute;">

	</div>
	<div class="row-fluid">
		<div class="span6" align="center"
			style="z-index: 1; position: absolute; float: left;">
			<div class="block">
				<div class="row-fluid" id="feeunpaidmonths"></div>
			</div>
		</div>
		<div class="span4"
			style="z-index: 1; position: absolute; float: right; left: 540px; top: 230px; right: 0px; margin-left: 0px;">
			<div class="block">
				<div class="row-fluid">
					<div class="span12">
						<div class="block" id="feeunpaidmonthscategory"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<table
		style="width: 700px; height: 200px; margin-left: 231px; margin-top: -50px;">
		<tr>
			<td style="width: 200px;">Class</td>
			<td><select id="classId"
				onchange="getclassdefaulters(this.value);" style="width: 250px;"
				name="classId">
					<option value="">Select a class</option>
					<c:forEach var="list" items="${classList}">
						<option value="${list.classId}">${list.className}</option>
					</c:forEach>
			</select></td>
		</tr>
	</table>
	<div id="DefaulterList"></div>
	<input type="hidden" id="showmonthid">

</div>
