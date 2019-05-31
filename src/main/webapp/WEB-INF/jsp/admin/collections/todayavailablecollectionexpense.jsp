<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<spring:url value="/" var="baseurl"></spring:url>
<spring:url value="/img" var="img_url" />
<spring:url value="/style" var="style_url" />
<spring:url value="/css" var="css_url" />
<spring:url value="/style/datepicks" var="datepicks" />
<link rel="stylesheet" type="text/css" href="${css_url}/home.css">
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
		<h1>Date wise Collection/Expense</h1>
		<h3>Date wise Collection/Expense</h3>
		<div id="app-back-button">
			<a href="home"><img alt="Back" border="0"
				src="${img_url}/home.png"
				style="margin-top: -6px; height: 40px; width: 40px;"></a> <a
				href="#" onclick="javascript:location.reload(true);"><img
				alt="Back" border="0" src="${img_url}/refresh.png"
				style="margin-top: -6px; height: 40px; width: 40px;"></a> <a
				href="javascript:back();"><img alt="Back" border="0"
				src="${img_url}/back.png"
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




	<input type="hidden" id="pageNo" value="${PAGENO}"> <br>
	<div>
		<div style="width: 45%; float: left;">
			<div class="row-form">
				<div class="span2">
					Date<font color="red">*</font>:
				</div>
				<div class="span2">
					<input type="text" name="dateOfBirth" id="dateOfBirth"
						readonly="readonly" class="datepicker validate[required]">
				</div>
			</div>
			<div class="row-form">
				<div class="span2"></div>
				<div class="span2">
					<a href="javascript:datewiseData();" class="btn">Search</a>
				</div>
			</div>
		</div>
		<div style="width: 50%; float: left;">
			<div style="width: 104%; height: 30px; float: right;">
				<b
					style="border: 1px solid #009ad7; float: right; font-family: Times Roman; border-radius: 5px; border-top-width: 5px;">Total
					Collections (in INR.) = ${TOTALCOLLECTION}/-</b>
			</div>
			<div style="width: 100%; height: 30px; float: right;">
				<b
					style="border: 1px solid #009ad7; float: right; font-family: Times Roman; border-radius: 5px; border-top-width: 5px;">Total
					Expense (in INR.) = ${TOTALEXPENCE}/-</b>
			</div>
			<div style="width: 95%; height: 30px; float: right;">
				<b
					style="border: 1px solid #009ad7; float: right; font-family: Times Roman; border-radius: 5px; border-top-width: 5px;">Total
					Rest (in INR.) = ${RESTAMOUNT}/-</b>
			</div>
		</div>
	</div>
	<div class="row-fluid">
		<div class="span12">
			<div class="block">
				<div class="head blue">
					<center>
						<%--<h2>
							<a
								href="perticular-emp-attendance.html?id=${EMPID}&monthId=${MAP.MONTHID-1}&year=${MAP.YEAR}">Preveous
								Month</a>
						</h2>
						&nbsp;&nbsp;&nbsp;&nbsp; --%>
						<h2>${DATE}&nbsp;&nbsp;CollectionDetails</h2>
						<%-- &nbsp;&nbsp;&nbsp;&nbsp;
						<h2>
							<a
								href="perticular-emp-attendance.html?id=${EMPID}&monthId=${MAP.MONTHID+1}&year=${MAP.YEAR}">Next
								Month</a>
						</h2> --%>
					</center>
				</div>
				<div class="data-fluid">
					<table cellspacing="0" cellpadding="0" width="100%" class="table">
						<thead>
							<tr>
								<th>Fee Collection</th>
								<th>${TOTALCOLLECTION}</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td colspan="2">
									<div class="block" style="width: 800px;">
										<table style="width: 1059px;"
											class="table table-bordered table-primary">
											<thead>
												<tr>
													<th>Student Admission No</th>
													<th>L.F. No.</th>
													<th>Receipt No.</th>
													<th>Name</th>
													<th>Amount Paid</th>
													<th>Fine Amount</th>
													<th>Discount Amount</th>
													<th>Paid Date</th>
													<th>View Details</th>
												</tr>
											</thead>
											<tbody>
												<c:forEach items="${StudentFeeSubmissionDetailsDTOs}"
													var="list">
													<tr>
														<td class="center"><font size="2">${list.studentId}</font></td>
														<td class="center"><font size="2">${list.lFno}</font></td>
														<td class="center"><font size="2">${list.recieptNo}</font></td>
														<td class="center"><font size="2">${list.studentName}</font></td>
														<td class="center"><font size="2">${list.paidAmount}</font></td>
														<td class="center"><font size="2">${list.fineAmount}</font></td>
														<td class="center"><font size="2">${list.discountAmount}</font></td>
														<td class="center"><font size="2">${list.feePaidDate}</font></td>
														<td style="color: green;"><a target="_blank"
															href="generatePDF.html?slipNo=${list.recieptNo}&studentAdmissionNo=${list.studentAdmissionNo}">
																<span class="label label-success">View</span>
														</a></td>
													</tr>
												</c:forEach>
												<tr>
													<td></td>
													<td></td>
													<td></td>
													<td></td>

												</tr>
											</tbody>
										</table>
									</div>
								</td>
							</tr>
						</tbody>
						<thead>
							<tr>
								<th>Uniform Collection</th>
								<th></th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td colspan="2">
									<div class="block" style="width: 800px;">
										<table style="width: 1059px;"
											class="table table-bordered table-primary">
											<thead>
												<tr>
													<th>Date</th>
													<th>Student Name.</th>
													<th>Student Id</th>
													<th>Class</th>
													<th>Section</th>
													<th>Payment Mode</th>
													<th>Paid Amount</th>

												</tr>
											</thead>
											<tbody>
												<c:forEach items="${uniformList}"
													var="list">
													<tr>
														<td class="center"><font size="2">${list.payDate}</font></td>
														<td class="center"><font size="2">${list.fullname}</font></td>
														<td class="center"><font size="2">${list.studentId}</font></td>
														<td class="center"><font size="2">${list.className}</font></td>
														<td class="center"><font size="2">${list.sectionName}</font></td>
														<td class="center"><font size="2">${list.paymentMode}</font></td>
														<td class="center"><font size="2">${list.paidAmount}</font></td>

													</tr>
												</c:forEach>
												<tr>
													<td></td>
													<td></td>
													<td></td>
													<td></td>

												</tr>
											</tbody>
										</table>
									</div>
								</td>
							</tr>
						</tbody>
						<thead>
							<tr>
								<th>Books Collection</th>
								<th></th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td colspan="2">
									<div class="block" style="width: 800px;">
										<table style="width: 1059px;"
											class="table table-bordered table-primary">
											<thead>
												<tr>
													<th>Date</th>
													<th>Student Name.</th>
													<th>Student Id</th>
													<th>Class</th>
													<th>Section</th>
													<th>Payment Mode</th>
													<th>Paid Amount</th>

												</tr>
											</thead>
											<tbody>
												<c:forEach items="${list}"
													var="list">
													<tr>
														<td class="center"><font size="2">${list.payDate}</font></td>
														<td class="center"><font size="2">${list.fullname}</font></td>
														<td class="center"><font size="2">${list.studentId}</font></td>
														<td class="center"><font size="2">${list.className}</font></td>
														<td class="center"><font size="2">${list.sectionName}</font></td>
														<td class="center"><font size="2">${list.paymentMode}</font></td>
														<td class="center"><font size="2">${list.paidAmount}</font></td>

													</tr>
												</c:forEach>
												<tr>
													<td></td>
													<td></td>
													<td></td>
													<td></td>

												</tr>
											</tbody>
										</table>
									</div>
								</td>
							</tr>
						</tbody>
						<thead>
							<tr>
								<th>Expense</th>
								<th>${TOTALEXPENCE}</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td colspan="2">
									<div class="block" style="width: 800px;">
										<table class="table table-bordered table-primary"
											style="width: 1059px;">
											<thead>
												<tr>
													<th style="background-color: #FFCC99">Simple
														Collection</th>
													<th style="background-color: #FFCC99"></th>
													<th style="background-color: #FFCC99"></th>
													<th style="background-color: #FFCC99"></th>

												</tr>
												<tr>
													<th>Employee Name</th>
													<th>Designation</th>
													<th>Purpose Details</th>
													<th>Amount</th>
												</tr>
											</thead>
											<tbody>
												<c:forEach var="list" items="${ExpenseDTOs}"
													varStatus="loop">
													<tr>
														<td class="center"><font size="2">${list.employeeName}</font></td>
														<td class="center"><font size="2">${list.roleName}</font></td>
														<td class="center"><font size="2">${list.purposeDetails}</font></td>
														<td class="center"><font size="2">${list.expenseAmount}</font></td>
													</tr>
												</c:forEach>
											</tbody>
										</table>
									</div>
								</td>
							</tr>
							<tr>
								<td colspan="2">

									<div class="block" style="width: 800px">
										<div class="data-fluid">
											<table class="table fTable lcnp" style="width: 1059px;">

												<thead>
													<tr style="background-color: #FFCC99">
														<th colspan="2" style="background-color: #FFCC99">Uniform
															Expense</th>
														<th style="background-color: #FFCC99"></th>
														<th style="background-color: #FFCC99"></th>
														<th style="background-color: #FFCC99"></th>
														<th style="background-color: #FFCC99"></th>
														<th style="background-color: #FFCC99"></th>
														<th style="background-color: #FFCC99"></th>
														<th style="background-color: #FFCC99"></th>
														<th style="background-color: #FFCC99"></th>
														<th style="background-color: #FFCC99"></th>

													</tr>
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
													<c:forEach var="list" items="${UniformSupplierDTOs}"
														varStatus="loop">
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
																href="javascript:viewdetails(${list.stockPurchaseId});"><span
																	class="label label-important">View</span></a></td>
															<td><a
																href="viewpurchased-receipt?id=${list.receiptNo}"><span
																	style="margin-top: 6px;" class="label label-primary">Show</span></a></td>
														</tr>
													</c:forEach>

												</tbody>
											</table>
										</div>

									</div>

								</td>
							</tr>
							<tr>
								<td colspan="2">


									<div class="block" style="width: 800px">
										<div class="data-fluid">
											<table class="table fTable lcnp" style="width: 1059px;">
												<thead>
													<tr>
														<th style="background-color: #FFCC99" colspan="12">Book
															Expense</th>
													</tr>
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
													<c:forEach var="list" items="${BookSupplierDTOs}"
														varStatus="loop">
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
										</div>

									</div>


								</td>
							</tr>
							<tr>
								<td colspan="2">


									<div class="block" style="width: 800px">
										<div class="data-fluid">
											<table class="table fTable lcnp" style="width: 1059px;">
												<thead>
													<tr>
														<th style="background-color: #FFCC99" colspan="16">Salary
															Expense</th>
													</tr>

													<tr>
														<th>Employee Id</th>
														<th>Name</th>
														<th>Date</th>
														<th>Months</th>
														<th>Salary Amount</th>
														<th>Fine</th>
														<th>Incentive</th>
														<th>Net Amount</th>
														<th>Paid Amount</th>
														<th>Dues</th>
														<th>Payment Mode</th>
														<th>Cheque No</th>
														<th>Bank Name</th>
														<th>Type</th>
														<th>Slip No.</th>
														<th>Status</th>
													</tr>
												</thead>
												<tbody>
													<c:forEach var="list" items="${SalaryDTOs}"
														varStatus="loop">
														<tr>
															<td>${list.employeeId}</td>
															<td>${list.firstName}&nbsp;${list.lastName}</td>
															<td>${list.dateOfPayment}</td>
															<td>${list.month}</td>
															<td>${list.salaryAmount}</td>
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
										</div>

									</div>


								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>

	</div>
</div>