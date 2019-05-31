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
<style>
.detailbox {
	display: none;
	background-color:lightyellow;
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
#dueTable {
background-color:white;
	width: 800px;
	margin-top: 160px;
	display: none;
	left: 10px;
	z-index: 1;
	position: absolute;
	border: 1px solid grey;
	border-radius: 6px;
	
}
</style>
<script>
function hideduebox() {
	$("#dueTable").hide();
	
}
	function gettoclear() {

		$("#toDate").val('');
	}
	function getSoldBookDetails() {

		var f = $("#fromDate").val();
		var t = $("#toDate").val();
var totalPaid=0;
var totalDues=0;
		if (f == "" || f == null) {

			document.getElementById("err").innerHTML = "Fill all above fields first";

		} else {
			document.getElementById("err").innerHTML = "";
			var url = 'viewsoldbook/' + f + '/' + t;
			$
					.ajax({
						url : url,

						type : 'POST',
						success : function(data, status) {
							$("#appenddata").empty();
							var j = JSON.parse(data);
							var content = "";
							var length = j.length;
						if(length==0)
							{
							$("#appenddata")
							.append(
									'<font color="red">No Data Found For your Search </font>');
							}
						else
							{
							for ( var i = 0; i < length; i++) {
								totalPaid+=parseInt(j[i].paidAmount);
								totalDues+=parseInt(j[i].dues)
							}
							content='<div><B b style="border-width: 5px 1px 1px; border-style: solid; border-color: rgb(0, 154, 215); -moz-border-top-colors: none; -moz-border-right-colors: none; -moz-border-bottom-colors: none; -moz-border-left-colors: none; border-image: none; font-family: Times Roman; border-radius: 5px; float: right; margin-top: -113px; margin-bottom: 0px;">Total Paid Amount (in INR.) = '+totalPaid+'/-</B></div>'
							+'<div><B style="border-right: 1px solid rgb(0, 154, 215); border-width: 5px 1px 1px; border-style: solid; border-color: rgb(0, 154, 215); -moz-border-top-colors: none; -moz-border-right-colors: none; -moz-border-bottom-colors: none; -moz-border-left-colors: none; border-image: none; font-family: Times Roman; border-radius: 5px; float: right; margin-top: -80px; margin-bottom: 0px;">Total Dues (in INR.) = '+totalDues+'/-</B></div>'
							+'<table cellpadding="0" cellspacing="0" width="100%" class="table"><thead><tr><th>Date</th><th>Student Name</th><th>Father Name</th><th>Class</th>'
									+ '<th>Section</th><th>Payment Mode</th><th>Total Amount</th><th>Discount</th><th>Paid Amount</th><th>Dues</th><th>Mobile no.</th><th>Book details</th><th>View Receipt</th></tr></thead><tbody>';
							for ( var i = 0; i < length; i++) {
								if (j[i].paidStatus == 'InHand') {

									content += '<tr><td style="background-color: lightgray;">'
											+ j[i].payDate
											+ '</td><td style="background-color: lightgray;"><img src=../img/progress.gif>&nbsp;&nbsp;'
											+ j[i].fullname
											+ '</td><td style="background-color: lightgray;">'
											+ j[i].fatherName
											+ '</td><td style="background-color: lightgray;">'
											+ j[i].className
											+ '</td><td style="background-color: lightgray;">'
											+ j[i].sectionName
											+ '</td><td style="background-color: lightgray;">'
											+ j[i].paymentMode + '</td>';
									content += '<td style="background-color: lightgray;">'
											+ j[i].totalAmount
											+ '</td><td style="background-color: lightgray;">'
											+ j[i].discount
											+ '</td><td style="background-color: lightgray;">'
											+ j[i].paidAmount
											+ '</td><td style="background-color: lightgray;">'
											+ j[i].dues
											+ '</td><td style="background-color: lightgray;">'
											+ j[i].mobile + '</td>';
									content += '<td style="background-color: lightgray;"><a href="javascript:viewmore('
											+ j[i].receiptno
											+ ');"><span class="label label-primary">Show</span></a>'
											+ '</td><td style="background-color: lightgray;"><a href="getBookReceipt?id='
											+ j[i].receiptno
											+ '" target="_blank"><span class="label label-success">Receipt</span></a></td></tr>';
								}
								if (j[i].paidStatus == 'Cancel') {

									content += '<tr><td style="background-color: pink;">'
											+ j[i].payDate
											+ '</td><td style="background-color: pink;"><img src=../img/wrong.PNG>&nbsp;&nbsp;'
											+ j[i].fullname
											+ '</td><td style="background-color: pink;">'
											+ j[i].fatherName
											+ '</td><td style="background-color: pink;">'
											+ j[i].className
											+ '</td><td style="background-color: pink;">'
											+ j[i].sectionName
											+ '</td><td style="background-color: pink;">'
											+ j[i].paymentMode + '</td>';
									content += '<td style="background-color: pink;">'
											+ j[i].totalAmount
											+ '</td><td style="background-color: pink;">'
											+ j[i].discount
											+ '</td><td style="background-color: pink;">'
											+ j[i].paidAmount
											+ '</td><td style="background-color: pink;">'
											+ j[i].dues
											+ '</td><td style="background-color: pink;">'
											+ j[i].mobile + '</td><td style="background-color: pink;"><a href="javascript:viewmore('
											+ j[i].receiptno
											+ ');"><span class="label label-primary">Show</span></a>'
											+ '</td><td style="background-color: pink;"><a href="getBookReceipt?id='
											+ j[i].receiptno
											+ '" target="_blank"><span class="label label-success">Receipt</span></a></td></tr>';
								
								}
								if (j[i].paidStatus == 'Completed') {

									content += '<tr><td style="color:green;">'
											+ j[i].payDate
											+ '</td><td style="color:green;"><img src=../img/right.PNG>&nbsp;&nbsp;'
											+ j[i].fullname
											+ '</td><td style="color:green;">'
											+ j[i].fatherName
											+ '</td><td style="color:green;">'
											+ j[i].className
											+ '</td><td style="color:green;">'
											+ j[i].sectionName
											+ '</td><td style="color:green;">'
											+ j[i].paymentMode + '</td>';
									content += '<td style="color:green;">'
											+ j[i].totalAmount
											+ '</td><td style="color:green;">'
											+ j[i].discount
											+ '</td><td style="color:green;">'
											+ j[i].paidAmount
											+ '</td><td style="color:green;">'
											+ j[i].dues
											+ '</td><td style="color:green;">'
											+ j[i].mobile + '</td><td><a href="javascript:viewmore('
											+ j[i].receiptno
											+ ');"><span class="label label-primary">Show</span></a>'
											+ '</td><td><a href="getBookReceipt?id='
											+ j[i].receiptno
											+ '" target="_blank"><span class="label label-success">Receipt</span></a></td></tr>';
								
								}
							}
							content += '</tbody></table>';
						
								$("#appenddata").append(content);
							} 

						},
						error : function(e) {

						}
					});
		}
	}
	function getClear() {
		$("#classById").val('');
		$("#name").val('');

	}
	function changePaidStatus(paidStatus, receiptno) {
		$.ajax({
			type : "post",
			url : 'changeBookpaidstatus',
			data : {
				'paidstaus' : paidStatus,
				'receiptno' : receiptno
			},
			success : function(data, status) {
				getSoldBookDetails();
			},
			error : function(e) {
				
			}
		});
	}
	function changePaidDueStatus(paidStatus,slip,receiptno) {
		$.ajax({
			type : "post",
			url : 'changeBookpaidstatus',
			data : {
				'paidstaus' : paidStatus,
				'receiptno' : receiptno
			},
			success : function(data, status) {
				duedetails(slip);
				getSoldBookDetails();
				
			},
			error : function(e) {
				
			}
		});
	}
	function viewmore(receiptno)
	{
		$.ajax({
			type : "post",
			url : 'viewsoldbookdetails',
			data : {
				
				'receiptno' : receiptno
			},
			success : function(data, status) {
				$("#bookdetails").empty();
				var j = JSON.parse(data);
				var st = "";
		      var length = j.length;
				if (length == 0) {
					st = '<div class="failedmsg"><h5 align="center"><font color="red"><b>No Data available</b></font></h5></div>';
				} else {
					$("#myModalLabel").text(j[0].fullname);
					if(j[0].paymentMode=='Cheque')
						{
						st=st+'<div><table  style="margin-bottom: 23px; margin-left: 43px;"><tr><td style="width: 112px;"><b>Cheque No.</b></td><td>'+j[0].chequeno+'</td></tr>'
						+'<tr><td><b>Bank Name</b></td><td>'+j[0].bankName+'</td></tr>'
						+'<tr><td><b>Amount</b></td><td>'+j[0].paidAmount+'</td></tr></table><div>';
						}
	                   st = st
							+ '<div><div class="widget-body"  style="padding: 10px 0px 0px; margin-top: -50px;"><div class="separator"></div><div class="btn-group" style="width: 400px;">'
							+ '</div><div class="block" style="margin-left: 21px; margin-right: 15px; margin-top: 39px;"><div class="head green"><h4 style="text-align: center; height: 31px; padding-top: 5px;">Book Details</h4></div>'
							+ '<table class="table table-bordered table-primary"><thead><tr><th>S No</th><th>Title</th><th>Price</th></tr></thead><tbody>';
					for ( var i = 0; i < length; i++) {
						st += '<tr><td>' + (i + 1)
								+ '</td><td>'+ j[i].bookTitle
								+ '</td><td>'+ j[i].price
								+ '</td></tr>';
					}
					st += '</table>';
				}
				$("#bookdetails").append(st);
				$(".detailbox").show();
			},
			error : function(e) {
				
			}
		});
		
	}
	function hidedetailbox() {
		$(".detailbox").hide();
		
	}
	function duedetails(receiptno)
	{
		$.ajax({
			type : "post",
			url : 'viewbookduedetails',
			data : {
				
				'receiptno' : receiptno
			},
			success : function(data, status) {
				
				$("#DueDetails").empty();
				var j = JSON.parse(data);
				var content = "";
				var length = j.length;
			if(length==0)
				{
				alert("No data found for your search");
				}
			else
				{
				$("#name").text(j[0].firstName);
				content=''
				+''
				+'<table cellpadding="0" cellspacing="0" width="100%" class="table"><thead><tr><th>Date</th>'
						+ '<th>Payment Mode</th><th>Total Amount</th><th>Discount</th><th>Paid Amount</th><th>Dues</th><th>Payment Status</th><th>View More</th></tr></thead><tbody>';
				for ( var i = 0; i < length; i++) {
					if (j[i].paidStatus == 'Inprogress') {

						content += '<tr><td style="background-color: lightgray;">'
								+ j[i].payDate
								+ '</td><td style="background-color: lightgray;">'
								+ j[i].paymentMode + '</td>';
						content += '<td style="background-color: lightgray;">'
								+ j[i].totalAmount
								+ '</td><td style="background-color: lightgray;">'
								+ j[i].discount
								+ '</td><td style="background-color: lightgray;">'
								+ j[i].paidAmount
								+ '</td><td style="background-color: lightgray;">'
								+ j[i].dues
								+ '</td>';
						content += '<td style="background-color: lightgray;"><select onchange="changePaidDueStatus(this.value,'+receiptno+','
								+ j[i].receiptno
								+ ')"style="width: 94px;"><option value="Inprogress">'
								+ j[i].paidStatus
								+ '</option><option value="Completed">Completed</option><option value="Cancel"><span style="color:red">Cancel</span></option></select></td><td><a href="geBooktDuesReceipt?id='
								+ j[i].receiptno
								+ '" target="_blank"><span class="label label-success">Receipt</span></a></td></tr>';
					}
					if (j[i].paidStatus == 'Cancel') {

						content += '<tr><td style="background-color: pink;">'
								+ j[i].payDate
								+ '</td><td style="background-color: pink;">'
								+ j[i].paymentMode + '</td>';
						content += '<td style="background-color: pink;">'
								+ j[i].totalAmount
								+ '</td><td style="background-color: pink;">'
								+ j[i].discount
								+ '</td><td style="background-color: pink;">'
								+ j[i].paidAmount
								+ '</td><td style="background-color: pink;">'
								+ j[i].dues
								+ '</td><td style="background-color: pink;">'
								+ j[i].paidStatus + '</td><td><a href="geBooktDuesReceipt?id='
								+ j[i].receiptno
								+ '" target="_blank"><span class="label label-success">Receipt</span></a></td></tr>';
					
					}
					if (j[i].paidStatus == 'Completed') {

						content += '<tr><td style="color:green;">'
								+ j[i].payDate
								+ '</td><td style="color:green;">'
								+ j[i].paymentMode + '</td>';
						content += '<td style="color:green;">'
								+ j[i].totalAmount
								+ '</td><td style="color:green;">'
								+ j[i].discount
								+ '</td><td style="color:green;">'
								+ j[i].paidAmount
								+ '</td><td style="color:green;">'
								+ j[i].dues
								+ '</td><td style="color:green;">'
								+ j[i].paidStatus + '</td><td><a href="geBooktDuesReceipt?id='
								+ j[i].receiptno
								+ '" target="_blank"><span class="label label-success">Receipt</span></a></td></tr>';
					
					}
				}
				content += '</tbody></table>';
			
					$("#DueDetails").append(content);
					$("#dueTable").show();
				} 

			},
			error : function(e) {
				
			}
		});
		
	}
</script>
<div id="dueTable">
<div class="row-fluid">
		<div class="span12">
			<div class="block" class="block" style="margin-top: -10px;">
				<div class="head purple" style="height: 45px;">
					<!-- <div class="icon">
						<span class="ico-pen-2"></span>
					</div> -->
					<center><h3 id="name">Detail List</h3></center>
						<a href="javascript:hideduebox();" class="close" data-dismiss="modal"
			style="margin-right: 10px; margin-top: -39px;" aria-hidden="true"><span class="ico-remove-sign"></span></a>
				</div>
				<div class="data-fluid" id="DueDetails"></div>
			</div>
		</div>

	</div>
	</div>
<div class="detailbox">
	<div class="detailbox-header">
		<a href="javascript:hidedetailbox();" class="close" data-dismiss="modal"
			style="margin-right: 10px; margin-top: 10px;" aria-hidden="true"><span class="ico-remove-sign"></span></a>
		<center><h5 id="myModalLabel">Sold Book Detais</h5></center>
	</div>
		<div class="row-fluid" style="margin-top: 20px;">
			<div class="block-fluid">
				<div id="bookdetails"></div>
				
			</div>

		</div>

		<div class="detailbox-footer"
			style="float: right;">
			<a class="btn btn-warning" data-dismiss="modal"
				href="javascript:hidedetailbox();"style="margin-right: 16px;"
				aria-hidden="true">Close</a>
		</div>

</div>
<div class="content">
	<div id="content-header" style="height: 150px;">
		<img alt="Show_settings" src="${img_url}/book1.jpg"
			style="width: 50px; margin-top: -12px;">
		<h1>Sold Book Details</h1>
		<h3>View Date Wise Sold Book Details</h3>
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
				onchange="getSoldBookDetails();">
		</div>
	</div>
	<div class="row-form">
		<div class="span3"></div>
		<div class="span9">

			<div id="err" class="form-inline">
				<p id="v1"></p>

			</div>
		</div>
	</div>
	<div class="row-fluid">
		<div class="span12">
			<div class="block" style="left: 2px;">
				<div class="head blue" style="width: 1048px;">
					<div class="icon">
						<span class="ico-pen-2"></span>
					</div>
					<h2>Detail List</h2>
					<ul class="buttons">
						<li><a onclick="source('table_default'); return false;"
							href="#"><div class="icon">
									<span class="ico-info"></span>
								</div></a></li>
					</ul>
				</div>
				<div class="data-fluid" id="appenddata"></div>
			</div>
		</div>

	</div>
</div>