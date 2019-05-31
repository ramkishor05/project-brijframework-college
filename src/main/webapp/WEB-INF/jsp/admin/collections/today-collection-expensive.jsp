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
			dateFormat : "yyyy-mm-dd"
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
	/* function datewiseData() {
		document.location.href = 'today-collection-expence-PDF?date='
				+ $("#dateOfBirth").val();
	} */
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





	<div>
		<div style="width: 45%; float: left;">
			<form action="today-collection-expence-PDF" target="_blank">
				<div class="row-form">
					<div class="span2">
						Date<font color="red">*</font>:
					</div>
					<div class="span2">
						<input type="text" name="date" id="dateOfBirth"
							class="datepicker validate[required]">
					</div>
				</div>
				<div class="row-form">
					<div class="span2"></div>
					<div class="span2">
						<input type="submit" class="btn" value="Search">
					</div>
				</div>
			</form>
		</div>

	</div>
</div>