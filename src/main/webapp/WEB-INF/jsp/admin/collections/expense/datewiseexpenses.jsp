<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url value="/style/theme/images" var="imageurl" />
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/img" var="img_url" />
<spring:url value="/css" var="css_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/setting.css">

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

<script type="text/javascript">
	function getDateWiseExpense() {

		var from = $("#fromDate").val();
		var to = $("#toDate").val();

		if ((from == "" || from == null) || (to == "" || to == null))

		{
			$("#ExpenseList").empty();
			document.getElementById("v1").innerHTML = "All fields are required";

		} else {
			document.getElementById("v1").innerHTML = "";

			var url = 'show-datewise-expenses/' + from + '/' + to;
			$
					.ajax({
						url : url,

						type : 'POST',
						success : function(data, status) {
							$("#ExpenseList").empty();
							var j = JSON.parse(data);
							var st = "";
							var length = j.length;

							if (length == 0) {
								st = '<div class="failedmsg">There are no expense between these dates</div>';
							} else {
								st = '<div><div class="widget-body" style="padding: 10px 0 0;"><div class="separator"></div><div class="btn-group" style="width: 1059px;">'
										+ '</div>';
								for (var i = length - 1; i < length; i++) {
									st += '<div><B style="border: 1px solid #009ad7; font-family:Times Roman; border-top-width: 5px; border-radius: 5px; float: right; margin-top: -10px; margin-bottom: 10px;">Date Wise '
											+ 'Expenses (in INR.) = '
											+ j[i].total + '/-</B></div>';
								}
								/************* Uniform Expenses *********************/
								st += '<hr><div class="block"><div class="head blue"><div class="icon"><span class="ico-pen-2"></span></div><h2>Date-Wise Uniform Expense</h2></div>'
										+ '<table class="table table-bordered table-primary"><thead><tr><th>S No.</th><th>Date of Purchase</th><th>Receipt No.</th><th>Supplier Name</th><th>Total Amount</th><th>Discount</th><th>Paid Amount</th><th>Payment Mode</th><th>Payment Status</th><th>View Details</th><th>View Receipt</th></tr>';

								$
										.each(
												j.uniformExpensesDTOs,
												function(key, value) {
													st = st
															+ '<tr><td>'
															+ key
															+ '</td><td>'
															+ value.dateOfPurchase
															+ '</td><td>'
															+ value.receiptNo
															+ '</td><td>'
															+ value.supplierName
															+ '</td><td>'
															+ value.grossAmount
															+ '</td><td>'
															+ value.discount
															+ '</td><td>'
															+ value.paidAmount
															+ '</td><td>'
															+ value.paymentMode
															+ '</td><td>'
															+value.paidStatus
															'</td>';
															st = st + '<td>'
															+ value.paidStatus
															+ '</td>';

													st = st
															+ '<td><a href="javascript:viewdetails('
															+ value.stockPurchaseId
															+ ');"><span  class="label label-important">View</span></a></td>'
															+ '<td><a href="viewpurchased-receipt?id='
															+ value.receiptNo
															+ '"><span style="margin-top: 6px;" class="label label-primary">Show</span></a></td>'
															+ '</tr>';

												});
								st = st
										+ '</table> <div style="float: right; border: 1px solid lightgray; background: none repeat scroll 0% 0% rgb(238, 238, 238); color: gray; margin-right: 437px; width: 209px; height: 27px;">Total Amount(Rs): '
										+ j.UNIFORMEXPENCE + '</div><br><hr>';
								/************* Books Expenses *********************/
								st += '<div class="block"><div class="head blue"><div class="icon"><span class="ico-pen-2"></span></div><h2>Date-Wise Books Expense</h2></div>'
										+ '<table class="table table-bordered table-primary"><thead><tr>';
								st = st
										+ '<th>S No.</th><th>Date of Purchase</th><th>Receipt No.</th><th>Supplier Name</th>';
								st = st
										+ '<th>Total Amount</th><th>Discount</th><th>Paid Amount</th><th>Dues</th>';
								st = st
										+ '<th>Payment Mode</th><th>Payment Status</th><th>View Details</th><th>View Receipt</th></tr>';

								$
										.each(
												j.bookExpensesDTOs,
												function(key, value) {
													st = st
															+ '<tr><td>'
															+ key
															+ '</td><td>'
															+ value.dateOfPurchase
															+ '</td><td>'
															+ value.receiptNo
															+ '</td><td>'
															+ value.supplierName
															+ '</td><td>'
															+ value.grossAmount
															+ '</td><td>'
															+ value.discount
															+ '</td><td>'
															+ value.paidAmount
															+ '</td><td>'
															+ value.balanceAmount
															+ '</td><td>'
															+ value.paymentMode
															+ '</td>';

													st = st + '<td>'
															+ value.paidStatus
															+ '</td>';

													st = st
															+ '<td><a href="javascript:viewbookdetails('
															+ value.stockPurchaseId
															+ ');"><span class="label label-important">View</span></a></td>'
															+ '<td><a href="viewpurchasedbook-receipt?id='
															+ value.receiptNo
															+ '" target="_blank"><span class="label label-primary" style="margin-top: 6px;">Show</span></a></td>'
															+ '</tr>';
												});
								st = st
										+ '</table><div style="float: right; border: 1px solid lightgray; background: none repeat scroll 0% 0% rgb(238, 238, 238); color: gray; margin-right: 437px; width: 209px; height: 27px;">';
								st = st + 'Total Amount(Rs): ' + j.BOOKEXPENCE
										+ '</div><br><hr>';
								/* Salary Expenses*/
								st += '<div class="block"><div class="head blue" style="width:1063px;"><div class="icon"><span class="ico-pen-2"></span></div><h2>Date-Wise Salary Expense</h2></div>'
										+ '<table class="table table-bordered table-primary"><thead><tr>';
								st = st
										+ '<th>S No.</th><th>Id</th><th>Name</th><th>Date</th><th>Months</th>';
								st = st
										+ '<th>Salary Amount</th><th>Advance</th><th>Fine</th><th>Incentive</th><th>Net Amount</th>';
								st = st
										+ '<th>Paid Amount</th><th>Dues</th><th>Payment Mode</th><th>Cheque No.</th><th>Bank Name</th>';

								st = st
										+ '<th>Type</th><th>Slip No.</th><th>Status</th></tr>';

								$.each(j.salaryExpenseDTOs,
										function(key, value) {
											st = st + '<tr><td>' + key
													+ '</td><td>'
													+ value.employeeId
													+ '</td><td>'
													+ value.firstName + ' '
													+ value.lastName
													+ '</td><td>'
													+ value.dateOfPayment
													+ '</td><td>' + value.month
													+ '</td><td>'
													+ value.salaryAmount
													+ '</td><td>'
													+value.advanceAmount
													+'</td><td>'
													+ value.fineAmount
													+ '</td><td>'
													+ value.incentive
													+ '</td><td>'
													+ value.netPayableAmount
													+ '</td><td>'
													+ value.paidAmount
													+ '</td><td>'
													+ value.dueAmount
													+ '</td><td>'

													+ value.paidBy
													+ '</td><td>'
													+ value.chequeNo
													+ '</td><td>'
													+ value.bankName
													+ '</td><td>'
													+ value.advance
													+ '</td><td>'
													+ value.slipNo + '</td>';

											st = st + '<td>'
													+ value.salaryPaidStatus
													+ '</td></tr>';

										});
								st = st
										+ '</table><div style="float: right; border: 1px solid lightgray; background: none repeat scroll 0% 0% rgb(238, 238, 238); color: gray; margin-right: 437px; width: 209px; height: 27px;">';
								st = st + 'Total Amount(Rs): '
										+ j.SALARYEXPENCE + '</div><br><hr>';
								/************* Extra Expenses *********************/
								st += '<div class="block"><div class="head blue"><div class="icon"><span class="ico-pen-2"></span></div><h2>Date-Wise Extra Expense</h2></div>'
										+ '<table class="table table-bordered table-primary"><thead><tr><th>Date</th><th>Employee Name</th><th>Designation</th><th>Purpose Details</th><th>Amount</th></tr>';

								$.each(j.extraExpenseDTOs,
										function(key, value) {
											st = st + '<tr><td>'
													+ value.dateofexpense
													+ '</td><td>'
													+ value.employeeName
													+ '</td><td>'
													+ value.roleName
													+ '</td><td>'
													+ value.purposeDetails
													+ '</td><td>'
													+ value.expenseAmount
													+ '</td></tr>';

										});
								st = st
										+ '</table><div style="float: right; border: 1px solid lightgray; background: none repeat scroll 0% 0% rgb(238, 238, 238); color: gray; margin-right: 207px; width: 209px; height: 27px;">';
								st = st + 'Total Amount(Rs): ' + j.EXTRAEXPENCE
										+ '</div><br><hr>';
								/**************Advance Expence******************/

								st += '<div class="block"><div class="head blue"><div class="icon"><span class="ico-pen-2"></span></div><h2>Date-Wise Advance Expense</h2></div>'
										+ '<table class="table table-bordered table-primary"><thead><tr><th>Employee Name</th><th>Date</th><th>Amount</th></tr>';
								$.each(j.AdvanceExpenses, function(key, value) {
									st = st + '<tr><td>' + value.employeeName
											+ '</td><td>' + value.dateOfPayment
											+ '</td><td>' + value.paidAmount
											+ '</td></tr>';

								});
								st = st
										+ '</table><div style="float: right; border: 1px solid lightgray; background: none repeat scroll 0% 0% rgb(238, 238, 238); color: gray; margin-right: 207px; width: 209px; height: 27px;">';
								st = st + 'Total Amount(Rs): '
										+ j.ADVANCEEXPENCE + '</div><br><hr>';

							}
							$("#ExpenseList").append(st);
						},
						error : function(error, status) {
						}
					});
		}
	}
</script>
<style>
.detailbox {
	display: none;
	background-color: lightyellow;
	border: 1px solid grey;
	width: 550px;
	border-radius: 6px;
	margin-top: 160px;
	left: 220px;
	z-index: 1;
	position: absolute;
}

.detailboxbook {
	display: none;
	background-color: lightyellow;
	border: 1px solid grey;
	width: 550px;
	border-radius: 6px;
	margin-top: 160px;
	left: 220px;
	z-index: 1;
	position: absolute;
}

.detailbox-header {
	width: 550px;
	margin-top: -10px;
	border-bottom: 1px solid gray;
	height: 30px;
}
</style>
<script type="text/javascript">
	$(function() {
		$("#dateOfBirth").datepick({
			dateFormat : "yyyy-M-dd"
		});
	});

	function viewbookdetails(id) {

		$
				.ajax({
					type : "post",
					url : 'getBoughtBookDetails',
					data : {

						'stockPurchaseId' : id
					},
					success : function(data, status) {
						$("#bookdetails").empty();
						var j = JSON.parse(data);
						var st = "";
						var length = j.length;
						if (length == 0) {
							st = '<div class="failedmsg"><h5 align="center"><font color="red"><b>No Data available</b></font></h5></div>';
						} else {
							$("#myModalLabelbook").text(j[0].shopName);

							if (j[0].paymentMode == 'Cheque') {
								st = st
										+ '<div><table  style="margin-bottom: 23px; margin-left: 43px;"><tr><td style="width: 112px;"><b>Cheque No.</b></td><td>'
										+ j[0].chequeno + '</td></tr>'
										+ '<tr><td><b>Bank Name</b></td><td>'
										+ j[0].bankName + '</td></tr>'
										+ '</table><div>';
							}
							st = st
									+ '<div><div class="widget-body"  style="padding: 10px 0px 0px; margin-top: -50px;"><div class="separator"></div><div class="btn-group" style="width: 400px;">'
									+ '</div><div class="block" style="margin-left: 21px; margin-right: 15px; margin-top: 39px; width: 506px;"><div class="head green"><h4 style="text-align: center; height: 31px; padding-top: 5px;">Uniform Details</h4></div>'
									+ '<table class="table table-bordered table-primary"><thead><tr><th>S No</th><th>Class</th><th>Subject</th><th>Title</th><th>Price</th><th>Quantity</th><th>Amount</th><th>Net Amount</th></tr></thead><tbody>';
							for (var i = 0; i < length; i++) {
								st += '<tr><td>' + (i + 1) + '</td><td>'
										+ j[i].className + '</td><td>'
										+ j[i].subjectName + '</td><td>'
										+ j[i].bookTitle + '</td><td>'
										+ j[i].bookPrice + '</td><td>'
										+ j[i].boughtQuantity + '</td><td>'
										+ j[i].amount + '</td><td>'
										+ j[i].netAmount + '</td></tr>';
							}
							st += '</table>';
						}
						$("#bookdetails").append(st);
						$(".detailboxbook").show();
					},
					error : function(e) {

					}
				});

	}

	function hidedetailboxbook() {
		$(".detailboxbook").hide();

	}

	function hidefeecategorycreateedit() {
		$("#description").val('');
		$("#holidayDate").val('');
		$(".feecategorycreateedit").hide();
	}

	function viewdetails(id) {
		$
				.ajax({
					type : "post",
					url : 'getBoughtDetails',
					data : {

						'stockPurchaseId' : id
					},
					success : function(data, status) {
						$("#uniformdetails").empty();
						var j = JSON.parse(data);
						var st = "";
						var length = j.length;
						if (length == 0) {
							st = '<div class="failedmsg"><h5 align="center"><font color="red"><b>No Data available</b></font></h5></div>';
						} else {
							$("#myModalLabel").text(j[0].shopName);
							if (j[0].paymentMode == 'Cheque') {
								st = st
										+ '<div><table  style="margin-bottom: 23px; margin-left: 43px;"><tr><td style="width: 112px;"><b>Cheque No.</b></td><td>'
										+ j[0].chequeno + '</td></tr>'
										+ '<tr><td><b>Bank Name</b></td><td>'
										+ j[0].bankName + '</td></tr>'
										+ '<tr><td><b>Amount</b></td><td>'
										+ j[0].paidAmount
										+ '</td></tr></table><div>';
							}
							st = st
									+ '<div><div class="widget-body"  style="padding: 10px 0px 0px; margin-top: -50px;"><div class="separator"></div><div class="btn-group" style="width: 400px;">'
									+ '</div><div class="block" style="margin-left: 21px; margin-right: 15px; margin-top: 39px; width: 504px;"><div class="head green"><h4 style="text-align: center; height: 31px; padding-top: 5px;">Uniform Details</h4></div>'
									+ '<table class="table table-bordered table-primary"><thead><tr><th>S No</th><th>Uniform Type</th><th>Category</th><th>Size</th><th>Price</th><th>Quantity</th><th>Amount</th></tr></thead><tbody>';
							for (var i = 0; i < length; i++) {
								st += '<tr><td>' + (i + 1) + '</td><td>'
										+ j[i].uniformName + '</td><td>'
										+ j[i].uniformCategory + '</td><td>'
										+ j[i].uniformSize + '</td><td>'
										+ j[i].uniformPrice + '</td><td>'
										+ j[i].boughtQuantity + '</td><td>'
										+ j[i].amount + '</td></tr>';
							}
							st += '</table>';
						}
						$("#uniformdetails").append(st);
						$(".detailbox").show();
					},
					error : function(e) {

					}
				});

	}
	function changeinprogressstatus(value, slipNo) {

		document.location.href = "change-cheque-inHand.html?slipNo=" + slipNo
				+ "&Status=" + value + "";

	}
	function hidedetailbox() {
		$(".detailbox").hide();

	}
	function changePaidStatus(receiptno, status) {
		document.location.href = 'change-paid-status?id=' + receiptno
				+ '&status=' + status + '&page=';
	}
	function datewiseData() {
		document.location.href = 'today-collections-expense-report?date='
				+ $("#dateOfBirth").val() + '&pageNo=' + $("#pageNo").val();
	}
	function back() {
		
		history.back(-$("#pageNo").val());
	}
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
	<div id="content-header" style="height: 140px;">
		<img alt="Show_settings" src="${img_url}/expense_report.jpg"
			style="width: 50px;">
		<h1>Date-Wise Expenses</h1>
		<h3>date-wise expenses report</h3>
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

	<div class="detailbox">
		<div class="detailbox-header">
			<a href="javascript:hidedetailbox();" class="close"
				data-dismiss="modal" style="margin-right: 10px; margin-top: 10px;"
				aria-hidden="true"><span class="ico-remove-sign"></span></a>
			<center>
				<h5 id="myModalLabel">Sold Uniform Details</h5>
			</center>
		</div>
		<div class="row-fluid" style="margin-top: 20px;">
			<div class="block-fluid">
				<div id="uniformdetails"></div>
			</div>

		</div>

		<div class="detailbox-footer" style="float: right;">
			<a class="btn btn-warning" data-dismiss="modal"
				href="javascript:hidedetailbox();" style="margin-right: 16px;"
				aria-hidden="true">Close</a>
		</div>

	</div>


	<div class="detailboxbook">
		<div class="detailbox-header">
			<a href="javascript:hidedetailboxbook();" class="close"
				data-dismiss="modal" style="margin-right: 10px; margin-top: 10px;"
				aria-hidden="true"><span class="ico-remove-sign"></span></a>
			<center>
				<h5 id="myModalLabelbook">Purchase Book Details</h5>
			</center>
		</div>
		<div class="row-fluid" style="margin-top: 20px;">
			<div class="block-fluid">
				<div id="bookdetails"></div>
			</div>

		</div>

		<div class="detailbox-footer" style="float: right;">
			<a class="btn btn-warning" data-dismiss="modal"
				href="javascript:hidedetailboxbook();" style="margin-right: 16px;"
				aria-hidden="true">Close</a>
		</div>

	</div>
	<br>

	<div class="row-fluid">
		<div class="span4">
			<div style="margin-left: 300px;" class="block">
				<div id="searches"
					style="height: auto; width: auto; border: 1px solid lightgray; background-color: rgb(238, 238, 238); border-radius: 5px;">
					<div class="data-fluid">
						<div class="row-form">
							<div class="span4">From Date :</div>
							<div class="span8">
								<input id="fromDate" class="datepicker validate[required]"
									style="width: 150px;" type="text" placeholder="From Date">
							</div>
						</div>

						<div class="row-form">
							<div class="span4">To Date :</div>
							<div class="span8">
								<input id="toDate" class="datepicker validate[required]"
									onchange="getDateWiseExpense();" style="width: 150px;"
									type="text" placeholder="To Date">
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div id="ExpenseList"></div>

	<div id="err" class="form-inline">
		<p id="v1"></p>
	</div>

</div>