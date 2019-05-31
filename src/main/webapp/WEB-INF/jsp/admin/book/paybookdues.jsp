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
#paytable {
background-color:white;
	width: 780px;
	margin-top: 160px;
	display: none;
	left: 220px;
	z-index: 1;
	position: absolute;
	border: 1px solid grey;
	border-radius: 6px;
	
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

.detailbox-header {
	width: 550px;
	margin-top: -10px;
	border-bottom: 1px solid gray;
	height: 30px;
}
.paytable-header {
	background-color:lightblue;
	margin-top: -10px;
	border-bottom: 1px solid gray;
	height: 30px;
}
</style>
<script>
function getunpaiddues() {
	var classId=$("#classId").val();
     var sessionId=$("#sessionId").val();
	var totalPaid=0;
	var totalDues=0;
		var url = 'getunpaidbookdues/' +classId+'/'+sessionId;
		$
				.ajax({
					url : url,

					type : 'POST',
					success : function(data, status) {
						
						$("#UnpaidDues").empty();
						var j = JSON.parse(data);
						var content = "";
						var length = j.length;
					if(length==0)
						{
						$("#UnpaidDues")
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
						+'<table cellpadding="0" cellspacing="0" width="100%" class="table"><thead><tr><th>Date</th><th>Student Name</th><th>Father Name</th>'
								+ '<th>Section</th><th>Payment Mode</th><th>Total Amount</th><th>Discount</th><th>Paid Amount</th><th>Dues</th><th>Mobile no.</th><th>Payment Status</th><th>Book details</th><th>Pay Dues</th><th>Due Payment Details</th></tr></thead><tbody>';
						for ( var i = 0; i < length; i++) {
							if (j[i].paidStatus == 'InHand') {

								content += '<tr><td style="background-color: lightgray;">'
										+ j[i].payDate
										+ '</td><td style="background-color: lightgray;"><img src=../img/progress.gif>&nbsp;&nbsp;'
										+ j[i].fullname
										+ '</td><td style="background-color: lightgray;">'
										+ j[i].fatherName
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
								content += '<td style="background-color: lightgray;"><select onchange="changePaidStatus(this.value,'
										+ j[i].receiptno
										+ ')"style="width: 94px;"><option value="Inhand">'
										+ j[i].paidStatus
										+ '</option><option value="Completed">Completed</option><option value="Cancel"><span style="color:red">Cancel</span></option></select></td><td style="background-color: lightgray;"><a href="javascript:viewmore('
										+ j[i].receiptno
										+ ');"><span class="label label-primary">Show</span></a>'
										+ '</td><td style="background-color: lightgray;"><a href="javascript:paydues('+j[i].receiptno+','+j[i].dues+');"><span class="label label-success">Pay Dues</span></a></td>'
										+'<td style="background-color: lightgray;"><a href="javascript:duedetails('+j[i].receiptno+');"><span class="label label-success">Show</span></a></td></tr>';
							}
							if (j[i].paidStatus == 'Cancel') {

								content += '<tr><td style="background-color: pink;">'
										+ j[i].payDate
										+ '</td><td style="background-color: pink;"><img src=../img/wrong.PNG>&nbsp;&nbsp;'
										+ j[i].fullname
										+ '</td><td style="background-color: pink;">'
										+ j[i].fatherName
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
										+ j[i].mobile + '</td><td style="background-color: pink;">'
										+ j[i].paidStatus + '</td><td style="background-color: pink;"><a href="javascript:viewmore('
										+ j[i].receiptno
										+ ');"><span class="label label-primary">Show</span></a>'
										+ '</td><td style="background-color: pink;"><a href="javascript:paydues('+j[i].receiptno+','+j[i].dues+');"><span class="label label-success">Pay Dues</span></a></td><td style="background-color: pink;"><a href="javascript:duedetails('+j[i].receiptno+');"><span class="label label-success">Show</span></a></td></tr>';
							
							}
							if (j[i].paidStatus == 'Completed') {

								content += '<tr><td style="color:green;">'
										+ j[i].payDate
										+ '</td><td style="color:green;"><img src=../img/right.PNG>&nbsp;&nbsp;'
										+ j[i].fullname
										+ '</td><td style="color:green;">'
										+ j[i].fatherName
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
										+ j[i].mobile + '</td><td style="color:green;">'
										+ j[i].paidStatus + '</td><td><a href="javascript:viewmore('
										+ j[i].receiptno
										+ ');"><span class="label label-primary">Show</span></a>'
										+ '</td><td><a href="javascript:paydues('+j[i].receiptno+','+j[i].dues+');"><span class="label label-success">Pay Dues</span></a><td><a href="javascript:duedetails('+j[i].receiptno+');"><span class="label label-success">Show</span></a></td></td></tr>';
							
							}
						}
						content += '</tbody></table>';
					
							$("#UnpaidDues").append(content);
						} 

					},
					error : function(e) {

					}
				});
	
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
			getunpaiddues();
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
			getunpaiddues();
			
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
				
				if (j[i].paidStatus == 'InHand') {

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
function disAmountType() {
	var total=$("#totalAmount").val();
	$('#disAmount').val(0);
	$("#due").val(0);
	$("#recentPaidAmount").val('');
	$("#discountAmount").val(total)
}
function getPaymentType(type) {
	$('#checkNo').val('');
	$('#bankName').val('');
	if (type == 'Cheque') {
		$('#bankName').attr("readonly", false);
		$('#checkNo').attr("readonly", false);
	}
	if (type == 'Cash') {
		$('#bankName').attr("readonly", true);
		$('#checkNo').attr("readonly", true);
	}
}
function getDiscount(value) {
	$("#due").val(0);
	$("#recentPaidAmount").val(0);
	var totalAmount = $('#totalAmount').val();

	var disType;
	if ($("#per").is(":checked")) {
		disType = 'per';
	} else if ($("#rs").is(":checked")) {
		disType = 'rs';
	} 
	if (isNaN(value) || value == '') {
		alert('Enter Valid Amount');
		var discountAt = parseInt(totalAmount);
		$('#discountAmount').val(discountAt);
		$('#discounts').val(0);
		
	} else if (disType == 'per') {
		if(parseInt(value)>100)
			{
			alert("More than 100% discount is invalid");
			$('#discountAmount').val(totalAmount);
			$('#disAmount').val(0);
			}
		else
			{
		var discount = Math.round(parseInt(totalAmount) * parseInt(value)
				/ 100);
		var discountAmount = Math.round(totalAmount - discount);
		$('#discountAmount').val(discountAmount);
		$('#discounts').val(discount);
			}
		
	} else if (disType == 'rs') {
		if(parseInt(value)>parseInt(totalAmount))
			{
			alert("Discount cannot be more than total amount");
			$('#discountAmount').val(totalAmount);
			$('#disAmount').val(0);
			}
		else
			{
		var discount = Math.round(parseInt(value));
		var discountAmount = Math.round(parseInt(totalAmount)
				- parseInt(value));
		$('#discountAmount').val(discountAmount);
		$('#discounts').val(discount);
	
			}
	}
}
function converttowords(num) {
	if (isNaN(num) || num == '') {
		alert('Enter Valid Amount');
		$("#recentPaidAmount").val('');
	}
	else
{	
	if (parseInt($("#discountAmount").val()) >= parseInt(num)) {
		if (num == '' || num == '0') {
			$("#due").val($("#discountAmount").val());
		} else {
			$("#due").val(
					parseInt($("#discountAmount").val()) - parseInt(num));
		}
		$("#feeCategoryNamemsg").empty();
	} else {
		
	$("#recentPaidAmount").val('');
	num='0';
	$("#feeCategoryNamemsg")
	.append('<span><font color="red" size="2">Paid Amount should be less than or equal to Net Payable Amount</font></span>');
		
	}
	
	var word = toWords(num);
$("#paidAmountInWord").val(word);
var	label='Amount In words :'+word+' only';
	$("#labelwords").text(label);
}
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
function removezero()
{
	var paid=$("#recentPaidAmount").val();
	if(paid==0)
	$("#recentPaidAmount").val('');
}
function paydues(receiptno,dues)
{
	$("#pays").empty();
			var st = '<div id="finals"><div class="block"><div class="head blue" style="height:30px;padding:0.5px 0 0 20px;margin-top: 0px;"><h4>Student Due Details</h4><a href="javascript:hidepaybox();" class="close" data-dismiss="modal"'
				+'style="margin-right: 10px; margin-top: -37px;" aria-hidden="true"><span class="ico-remove"></span></a></div><form action="bookdues-payment" method="POST" commandName="BookSellDTO" target="_blank" id="validateform"><table style="width: 1006px; padding-left: 54px; margin-left: 28px; margin-top: 11px;"><tr><td style="width: 136px;">Total amount:</td><td style="width: 90px;"> <input type="text" name="totalAmount" id="totalAmount" readonly="readonly" value='+dues+'></td><td style="width: 28px;"></td>'
			+ '<td style="width: 224px;">Discount in % <input type="radio" onclick="disAmountType();" name="dis" value="per" id="per">/ Rs <input type="radio" onclick="disAmountType();" name="dis" id="rs" value="rs"></td><td>'
			+ '<input type="text" id="disAmount" onkeyup="getDiscount(this.value)"onclick="getzeroremoved();"style="width: 79px;"></td></tr> '
			+'<tr><td style="width: 30px;">Payment Type:</td><td style="width: 50px;"><select id="paymentType" name="paymentMode" onchange="getPaymentType(this.value)" class="validate[required]"  style="height: 23px;">'
			+ '<option value="Cash">Cash</option><option value="Cheque">Cheque</option></select></td><td></td>'
			+ '<td><span>Net Payable Amount</span></td><td><input type="text" name="netPayableAmount" id="discountAmount" readonly="readonly" value='+dues+'></td><td></td></tr>'
			+'<tr><td><span>Paid Amount</span></td><td><input type="text"  oninput="converttowords(this.value);" onclick="removezero();" name="paidAmount" value="" id="recentPaidAmount" style="height: 23px;"></td><td></td>'
			+ '<td><span>Dues</span></td><td><input type="text" id="due" name="dues" readonly="readonly" value="0"></td></tr>'
			+'<tr><td style="width: 30px;">Cheque Number:</td><td style="width: 50px;"><input type="text" id="checkNo" name="chequeno" maxlength="6" readonly="readonly" style="height: 23px;"></td>'
			+ '<td></td><td style="width: 30px;">Bank Name:</td><td style="width: 50px;"><input type="text" id="bankName" name="bankName" readonly="readonly" style="height: 23px; width: 219px;"></td></tr>'
		    +'<tr><td colspan="4"><h5 id="labelwords"></h5></td>'
			+ '<td><input type="hidden" name="inwords" value="0" id="paidAmountInWord"><a href="javascript:validate();"><span class="label label-success" style="width: 53px; padding-left: 12px; height: 22px; margin-top: 4px;">Submit</span></a></td></tr></table>'
			+'<input type="hidden" value="'+receiptno+'" name="receiptno"></form></div></div>';
	
			$("#pays").append(st);
	$("#paytable").show();
	
		
		}
			

function hidedetailbox() {
	$(".detailbox").hide();
	
}
function hideduebox() {
	$("#dueTable").hide();
	
}
function hidepaybox() {
	$("#paytable").hide();
	
}
function validate() {
	$("#feeCategoryNamemsg").empty();
	flage = true;
	var paid = $("#recentPaidAmount").val();
	var regex2 = /^[a-zA-Z ]+$/;
	   if(paid=='')
    	{
    	$("#feeCategoryNamemsg")
		.append('<span><font color="red" size="2">Enter amount to be paid</font></span>');
    	flage = false;
    	}
	if ($("#paymentType").val() == 'Cheque' && $("#bankName").val() == '') {
		flage = false;
		$("#feeCategoryNamemsg")
		.append(
				'<center><font color="red">*Enter Bank Name</font></center>');
		
	}
	if ($("#paymentType").val() == 'Cheque' && !regex2.test($("#bankName").val())) {
		$("#feeCategoryNamemsg")
				.append(
						'<center><font color="red" size="2">*Enter only letters in Bank Name</font><center>');
		flage = false;
	}
	if ($("#paymentType").val() == 'Cheque' &&( $("#checkNo").val() == '' ||$("#checkNo").val().length<6)){
		flage = false;
		$("#feeCategoryNamemsg")
		.append(
				'<center><font color="red">*Please Enter 6 digit valid Cheque No.</font></center>');
		
		
	} 
	else if ($("#paymentType").val() == 'Cheque' && $("#CheckNo").val() == '') {
		flage = false;
		$("#feeCategoryNamemsg")
		.append(
				'<center><font color="red">*Please Enter 6 digit valid Cheque No.</font></center>');
		
		
	} 
	else if ($("#paymentType").val() == 'Cheque'
			&& !$.isNumeric($("#checkNo").val())) {
		flage = false;
		$("#feeCategoryNamemsg")
		.append(
				'<center><font color="red">*Cheque No. in numbers only.</font></center>');
		
	}
	if (flage) {
		$("#feeCategoryNamemsg").empty();
		$("#validateform").submit();
		document.location.href = 'pay-book-dues';
	}

}
</script>
<div class="detailbox">
	<div class="detailbox-header">
		<a href="javascript:hidedetailbox();" class="close" data-dismiss="modal"
			style="margin-right: 10px; margin-top: 10px;" aria-hidden="true"><span class="ico-remove-sign"></span></a>
		<center><h5 id="myModalLabel">Sold Uniform Detais</h5></center>
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
<div id="paytable">
<div id="pays"  style="height: 205px;"></div>
<div id="feeCategoryNamemsg"></div>
</div>
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
<div class="content">
	<div id="content-header" style="height: 150px;">
		<img alt="Show_settings" src="${img_url}/book1.jpg"
			style="width: 50px; margin-top: -12px;">
		<h1>Pay Dues of Book</h1>
		<h3>Clear dues of sold books</h3>
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

	<table
		style="width: 466px; height: 82px; margin-left: 231px; margin-top: 1px;">

<tr style="height: 62px;">
			<td style="width: 200px;">Session</td>
			<td><select name="sessionId" class="form-control input-sm"
				 id="sessionId" x-data-toggle-x="tooltip" onchange="getClear();"
				title="Specify the session of the student" required="required" 
				data-original-title="Specify session">
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
		<tr style="height: 0px;">
			<td style="width: 36px;">Class</td>
			<td><select id="classId"
				onchange="getunpaiddues();"  style="width: 260px;"
				name="classId">
					<option value="">Select a class</option>
					<c:forEach var="list" items="${classList}">
						<option value="${list.classId}">${list.className}</option>
					</c:forEach>
			</select></td>

		</tr>




	</table>

	<div class="separator"></div>
	<hr>
		<div class="row-fluid">
		<div class="span12">
			<div class="block">
				<div class="head blue">
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
				<div class="data-fluid" id="UnpaidDues"></div>
			</div>
		</div>

	</div>
	
	<div class="separator"></div>

	<div id="err" class="form-inline">
		<p id="v1"></p>

	</div>


</div>
