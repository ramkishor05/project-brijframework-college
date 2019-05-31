<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url value="/style/theme/images" var="imageurl" />
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/img" var="img_url" />
<spring:url value="/css" var="css_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/setting.css">
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

	function hidedetailbox() {
		$(".detailbox").hide();

	}
	function changePaidStatus(receiptno, status) {
		document.location.href = 'change-paid-status?id=' + receiptno
				+ '&status=' + status;
	}
	function datewiseData() {
		document.location.href = 'today-collections-expense-report?date='
				+ $("#dateOfBirth").val() + '&pageNo=' + $("#pageNo").val();
	}
	function back() {
		alert($("#pageNo").val());
		history.back(-$("#pageNo").val());
	}
	function changeinprogressstatus(value, slipNo) {

		document.location.href = "change-cheque-inHand.html?slipNo=" + slipNo
				+ "&Status=" + value + "";

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
		<h1>Today's Expenses</h1>
		<h3>today expenses report</h3>
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

	<c:if test="${expensedto.isEmpty()}">
		<div>
			<B
				style="border: 1px solid #009ad7; font-family: Times Roman; border-top-width: 5px; border-radius: 5px; float: right; margin-top: 12px; margin-bottom: 10px;">Today
				Expenses (in INR.) = 0.0/-</B>
		</div>
		<br>
		<br>
		<div class="failedmsg">There are no expenses today</div>

	</c:if>
	<c:if test="${!expensedto.isEmpty()}">
		<div>
			<B
				style="border: 1px solid #009ad7; font-family: Times Roman; border-top-width: 5px; border-radius: 5px; float: right; margin-bottom: 10px;">Today
				Expenses (in INR.) = ${TOTALEXPENCE}/- </B>
		</div>
		<div class="span12" style="margin-left: 0px; width: 1059px;"></div>
		<div style="padding: 10px 0 0;" class="widget-body">
			<div class="block">

				<div class="head blue">
					<div class="icon">
						<span class="ico-pen-2"></span>
					</div>
					<h2>Today's Uniform Expenses</h2>
					<ul class="buttons">
						<li></li>
					</ul>
				</div>

				<table class="table table-bordered table-primary"
					style="width: 1059px;">
					<thead>
						<tr>
							<th>S No.</th>
							<th>Date of Purchase</th>
							<th>Receipt No.</th>
							<th>Supplier Name</th>
							<th>Total Amount</th>
							<th>Discount</th>
							<th>Paid Amount</th>
							<th>Payment Mode</th>
							<th>Payment Status</th>
							<th>View Details</th>
							<th>View Receipt</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="list" items="${UniformExpenses}" varStatus="loop">
							<tr>
								<td>${loop.count}</td>
								<td>${list.dateOfPurchase}</td>
								<td>${list.receiptNo}</td>
								<td>${list.supplierName}</td>
								<td>${list.grossAmount}</td>
								<td>${list.discount}</td>
								<td>${list.paidAmount}</td>
								<td>${list.paymentMode}</td>

								<td>${list.paidStatus}</td>

								<td><a
									href="javascript:viewdetails('${list.stockPurchaseId}');"><span
										class="label label-important">View</span></a></td>
								<td><a href="viewpurchased-receipt?id=${list.receiptNo}"><span
										style="margin-top: 6px;" class="label label-primary">Show</span></a></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<div
					style="float: right; border: 1px solid lightgray; background: none repeat scroll 0% 0% rgb(238, 238, 238); color: gray; margin-right: 437px; width: 209px; height: 27px;">
					Total Amount(Rs): ${UNIFORMEXPENCE}</div>
				<hr>
				<div class="head blue">
					<div class="icon">
						<span class="ico-pen-2"></span>
					</div>
					<h2>Today's Book Expenses</h2>
					<ul class="buttons">
						<li></li>
					</ul>
				</div>

				<table class="table table-bordered table-primary"
					style="width: 1059px;">
					<thead>
						<tr>
							<th>S No.</th>
							<th>Date of Purchase</th>
							<th>Receipt No.</th>
							<th>Supplier Name</th>
							<th>Total Amount</th>
							<th>Discount</th>
							<th>Paid Amount</th>
							<th>Dues</th>
							<th>Payment Mode</th>
							<th>Payment Status</th>
							<th>View Details</th>
							<th>View Receipt</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="list" items="${BooksExpenses}" varStatus="loop">
							<tr>
								<td>${loop.count}</td>
								<td>${list.dateOfPurchase}</td>
								<td>${list.receiptNo}</td>
								<td>${list.supplierName}</td>
								<td>${list.grossAmount}</td>
								<td>${list.discount}</td>
								<td>${list.paidAmount}</td>
								<td>${list.balanceAmount}</td>
								<td>${list.paymentMode}</td>

								<td>${list.paidStatus}</td>

								<td><a
									href="javascript:viewbookdetails(${list.stockPurchaseId});"><span
										class="label label-important">View</span></a></td>
								<td><a
									href="viewpurchasedbook-receipt?id=${list.receiptNo}"
									target="_blank"><span class="label label-primary"
										style="margin-top: 6px;">Show</span></a></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<div
					style="float: right; border: 1px solid lightgray; margin-right: 437px; width: 209px; height: 27px; background: none repeat scroll 0% 0% rgb(238, 238, 238); color: gray;">
					Total Amount(Rs): ${BOOKEXPENCE}</div>
				<hr>
				<div class="head blue" style="width: 1063px;">
					<div class="icon">
						<span class="ico-pen-2"></span>
					</div>
					<h2>Overall Salary Expenses</h2>
					<ul class="buttons">
						<li><a return false; href="#"><div class="icon">
									<span class="ico-info"></span>
								</div></a></li>
					</ul>
				</div>
				<table class="table table-bordered table-primary"
					style="width: 1059px;">
					<thead>
						<tr>
							<th>Id</th>
							<th>Name</th>
							<th>Date</th>
							<th>Months</th>
							<th>Salary Amount</th>
								<th>Advance</th>
							<th>Fine</th>
							<th>Incentive</th>
							<th>Net Amount</th>
							<th>Paid Amount</th>
							<th>Dues</th>
							<th>Paid by</th>
							<th>Cheque No</th>
							<th>Bank Name</th>
							<th>Type</th>
							<th>Slip No.</th>
							<th>Status</th>
						</tr>
					</thead>
					<c:set var="SalaryExpense" value="0" scope="page" />
					<tbody>
						<c:forEach var="list" items="${SalaryExpenses}" varStatus="loop">

							<tr>
								<td>${list.employeeId}</td>
								<td>${list.firstName}&nbsp;${list.lastName}</td>
								<td>${list.dateOfPayment}</td>
								<td>${list.month}</td>
								<td>${list.salaryAmount}</td>
								<td>${list.advanceAmount}</td>
								<td>${list.fineAmount}</td>
								<td>${list.incentive}</td>
								<td>${list.netPayableAmount}</td>
								<td>${list.paidAmount}</td>
								<td>${list.dueAmount}</td>
								<td>${list.paidBy}</td>
								<td>${list.chequeNo}</td>
								<td>${list.bankName}</td>
								<td>${list.advance}</td>
								<td>${list.slipNo}</td>

								<td>${list.salaryPaidStatus}</td>


							</tr>
						</c:forEach>
					</tbody>
				</table>
				<div
					style="background: none repeat scroll 0% 0% rgb(238, 238, 238); color: gray; margin-right: 212px; width: 209px; border: 1px solid lightgray; float: right; height: 27px;">
					<c:out value="Total Amount(Rs): ${SALARYEXPENCE}"></c:out>
				</div>
				<br>
				<hr>
				<div class="head blue">
					<div class="icon">
						<span class="ico-pen-2"></span>
					</div>
					<h2>Today's Extra Expenses</h2>
					<ul class="buttons">
						<li><a return false; href="#"><div class="icon">
									<span class="ico-info"></span>
								</div></a></li>
					</ul>
				</div>

				<table class="table table-bordered table-primary"
					style="width: 1059px;">
					<thead>
						<tr>
							<th width="25%">Employee Name</th>
							<th width="25%">Designation</th>
							<th width="25%">Purpose Details</th>
							<th width="25%">Amount</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="list" items="${ExtraExpense}" varStatus="loop">
							<tr>
								<td width="25%" class="center"><font size="2">${list.employeeName}</font></td>
								<td width="25%" class="center"><font size="2">${list.roleName}</font></td>
								<td width="25%" class="center"><font size="2">${list.purposeDetails}</font></td>
								<td width="25%" class="center"><font size="2">${list.expenseAmount}</font></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<div
					style="float: right; border: 1px solid lightgray; background: none repeat scroll 0% 0% rgb(238, 238, 238); color: gray; margin-right: 207px; width: 209px; height: 27px;">
					Total Amount(Rs): ${EXTRAEXPENCE}</div>
				<hr>



				<div class="head blue">
					<div class="icon">
						<span class="ico-pen-2"></span>
					</div>
					<h2>Advance Expenses</h2>
					<ul class="buttons">
						<li><a return false; href="#"><div class="icon">
									<span class="ico-info"></span>
								</div></a></li>
					</ul>
				</div>

				<table class="table table-bordered table-primary"
					style="width: 1059px;">
					<thead>
						<tr>
							<th width="25%">S.No .</th>
							<th width="25%">Employee Name</th>
							<th width="25%">Date</th>
							<th width="25%">Amount</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="list" items="${AdvanceExpenses}" varStatus="count">
							<tr>
								<td width="25%" class="center"><font size="2">${count.count}</font></td>
								<td width="25%" class="center"><font size="2">${list.employeeName}</font></td>
								<td width="25%" class="center"><font size="2">${list.dateOfPayment}</font></td>
								<td width="25%" class="center"><font size="2">${list.paidAmount}</font></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<div
					style="float: right; border: 1px solid lightgray; background: none repeat scroll 0% 0% rgb(238, 238, 238); color: gray; margin-right: 207px; width: 209px; height: 27px;">
					Total Amount(Rs): ${ADVANCEEXPENCE}</div>
				<hr>





			</div>
		</div>
	</c:if>
</div>

