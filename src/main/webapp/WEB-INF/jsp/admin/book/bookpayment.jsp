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
.editbox {
	display: none;
	background-color: white;
	border: 1px solid grey;
	width: 550px;
	height: 345px;
	border-radius: 6px;
	margin-top: 160px;
	left: 220px;
	z-index: 1;
	position: absolute;
	background-color: white;
}

.editbox-header {
	width: 550px;
	margin-top: -10px;
	border-bottom: 1px solid gray;
	height: 50px;
}

.paybox {
	display: none;
	background-color: white;
	border: 1px solid grey;
	width: 384px;
	/* height: 240px; */
	border-radius: 6px;
	margin-top: 160px;
	z-index: 1;
	position: absolute;
	background-color: lightyellow;
	box-shadow: 10px 10px 5px #888888;
	top: 244px;
	left: 331px;
	"
}

.paybox-header {
	width: 384px;
	margin-top: -10px;
	border-bottom: 1px solid gray;
	background-color: #FFCC99;
	height: 50px;
}
</style>
<script>
	function showpayment(value, paymentMode, chequeno, bankName, paidStatus,date,amount) {
		$("#paymentshow").empty();
		var detail = '<table cellspacing="0" cellpadding="0" class="table" cellspacing="0" cellpadding="0" style="width: 350px; padding-top: 26px; margin-top: 23px; margin-left: 27px;">'
				+ '<tr><td>Payment Mode</td><td class="center">'
				+ paymentMode
				+ '</td></tr>';
		if (paymentMode == 'Cheque') {
			detail += '<tr><td>Payment Status</td><td class="center">'
					+ paidStatus + '</td></tr>'
					+ '<tr><td>Cheque No.</td><td class="center">' + chequeno
					+ '</td></tr>'
					+ '<tr><td>Bank Name</td><td class="center">' + bankName
					+ '</td></tr>'
					+ '<tr><td>Amount.</td><td class="center">' + amount
					+ '</td></tr>'
					+ '<tr><td>Date</td><td class="center">' + date
					+ '</td></tr>'
					
		}

		detail += '</table>';
		$("#paymentshow").append(detail);
		$(".paybox").show();
	}
	function hidepayment(value) {
		$("#pays" + value).fadeOut(1000);
	}
	function addnewshop() {
		$("#supplierDetails").empty();
		$("#newshop").empty();
		$("#newshop")
				.append(
						'Supplier No.<input type="text" name="newno" id="newno" value=""/>Name<input type="text" name="newshop" id="newshops" value=""/><a href="javascript:saveNewShop();" class="btn">Add</a>');
	}
	function saveNewShop() {
		var shop=$("#newshops").val();
		var net = $("#totals").val();
		var flag = true;
		var net = '${total}';
		$("#supplierDetails").empty();
		$("#shopmsg").empty();
		$("#prev").text('');
		$("#net").text('');
		$("#newtotal").val('0');
		$("#pays").empty();
		$("#previous").val('0');
		var no = $("#newno").val();
		var regex1 = /^[a-zA-Z ]+$/;
		if (no == '' || no == null) {
			$("#shopmsg").append(
					'<font color="red" size="2">Enter Supplier No.</font>');
			flag = false;
		}
		if (!regex1.test(shop)) {
			$("#shopmsg").append(
					'<font color="red" size="2">Enter only Letters</font>');
			flag = false;
		}
		if (flag == true) {
			$("#shopName").append(
					'<option selected="selected" value="'+shop+'">' + shop
							+ '</option>');
			$("#newshop").empty();
			$("#supplierNo").val(no);
		
			$("#newtotal").val(net);
			$('#tbox').show();
			if(net>0)
				$("#paybutton").show();
		}

	}
	function getSupplierDetails(supplierName) {
		$('#tbox').show();
		var i = 0;
		var net = 0;
		var total = $("#totals").val();
		var gross = 0;
		var p = 0;
		$("#supplierDetails").empty();
		$("#prev").text('');
		$("#net").text('');
		$("#newtotal").val('0');
		$("#pays").empty();

		$
				.ajax({
					type : "post",
					url : 'getBookSupplier',
					data : {
						'supplierName' : supplierName,

					},
					success : function(data, status) {
                        var content='';
						var j = JSON.parse(data);
						$("#supplierNo").val(j[0].supplierNo);
						var detail = '<div style="padding: 10px 0 0;" class="widget-body"><div class="block" class="block" style="width: 487px;"><div class="head green" style="height: 15px;">'
								+ '<h5 style="margin-top: -4px;"><center>Supplier Payment Details</center></h5>'
								+ '</div>'
								+ '<div class="data-fluid"><div class="classshowheader"><table width="100%" cellspacing="0" cellpadding="0" class="table table-hover">'
								+ '<thead><tr><th style="background-color: #FFCC99"></th>'
								+ '<th style="background-color: #FFCC99">S no.</th>'
								+ '<th style="background-color: #FFCC99">Date</th>'
								+ '<th style="background-color: #FFCC99">Gross Amount</th>'
								+ '<th style="background-color: #FFCC99">Discount</th>'
								+ '<th style="background-color: #FFCC99">Paid Amount</th>'
								+ '<th style="background-color: #FFCC99">Balance</th>'
								+ '<th style="background-color: #FFCC99">Book Details</th>'
								+ '<th style="background-color: #FFCC99">Payment Details</th>'
								+ '<div class="classshowheader" width="100%">'
								+ '<div class="childone" width="100%"><table width="100%" cellspacing="0" cellpadding="0" class="table table-hover">'
								+ ' <tbody>';
						for (i = 0; i < j.length; i++) {

							detail += '<tr><td style="background-color: #FFFFCC">'
									+ (i + 1)
									+ '</td>'
									+ '<td style="background-color: #FFFFCC">'
									+ j[i].dateOfPurchase
									+ '</td>'
									+ '<td style="background-color: #FFFFCC">'
									+ j[i].grossAmount
									+ '</td>'
									+ '<td style="background-color: #FFFFCC">'
									+ j[i].discount
									+ '</td>'
									+ '<td style="background-color: #FFFFCC">'
									+ j[i].paidAmount
									+ '</td>'
									+ '<td style="background-color: #FFFFCC">'
									+ j[i].balanceAmount
									+ '</td>'
									
									detail+= '<td style="background-color: #FFFFCC"><a href="javascript:showdetails('
										+ j[i].stockPurchaseId
										+ ');"><span class="label label-primary">View</span></a></td>';
									if(j[i].paymentMode=='Cheque')
										{
								
									detail+= '<td style="background-color: #FFFFCC"><a href=javascript:showpayment('
									+ j[i].stockPurchaseId
									+ ',"'
									+ j[i].paymentMode
									+ '","'
									+ j[i].chequeno
									+ '","'
									+ j[i].bankName
									+ '","'+j[i].paidStatus+'","'+j[i].dateOfPurchase+'","'+j[i].paidAmount+'");>Cheque</a></td>';
										}
									else
										{
										detail+='<td style="background-color: #FFFFCC">'
										+j[i].paymentMode+'</td>';
										}
									detail+='</tr>'
									+ '<tr><td style="background-color: #FFFFCC" colspan="8"><div id="'+j[i].stockPurchaseId+'" style="width: 270px; margin-left: 25px;display: none;"></div></td></tr>'

							net = j[i].balanceAmount;
							
							p += j[i].paidAmount;
						}
						gross=parseInt(net)+parseInt(p);
						content+='<div><B b style="border-width: 5px 1px 1px; border-style: solid; border-color: rgb(0, 154, 215); -moz-border-top-colors: none; -moz-border-right-colors: none; -moz-border-bottom-colors: none; -moz-border-left-colors: none; border-image: none; font-family: Times Roman; border-radius: 5px; float: right; margin-top: -113px; margin-bottom: 0px;">Overall Gross Amount (in INR.) = '+gross+'/-</B></div>'
						+'<div><B style="border-right: 1px solid rgb(0, 154, 215); border-width: 5px 1px 1px; border-style: solid; border-color: rgb(0, 154, 215); -moz-border-top-colors: none; -moz-border-right-colors: none; -moz-border-bottom-colors: none; -moz-border-left-colors: none; border-image: none; font-family: Times Roman; border-radius: 5px; float: right; margin-top: -80px; margin-bottom: 0px;">Overall Paid Amount (in INR.) = '+p+'/-</B></div>'
						content+='<div><B b style="border-width: 5px 1px 1px; border-style: solid; border-color: rgb(0, 154, 215); -moz-border-top-colors: none; -moz-border-right-colors: none; -moz-border-bottom-colors: none; -moz-border-left-colors: none; border-image: none; font-family: Times Roman; border-radius: 5px; float: right; margin-top: -45px; margin-bottom: 0px;">Balance (in INR.) = '+net+'/-</B></div>'
						
						$("#supplierDetails").append(content);
						$("#supplierDetails").append(detail);
						$("#prev").text('Previous Balance: Rs ' + net + '');
						$("#previous").val(net);
						net = parseInt(net) + parseInt(total);
						$("#net").text('Net Amount: Rs ' + net + '');
						$("#newtotal").val(net);
						$("#paybutton").show();
					},
					error : function(e) {

					}
				});
	}
	function showdetails(id) {
		$("#" + id).empty()
		$
				.ajax({
					type : "post",
					url : 'getBoughtBookDetails',
					data : {
						'stockPurchaseId' : id,

					},
					success : function(data, status) {

						var j = JSON.parse(data);
						var content = '<table width="50%" cellspacing="0" cellpadding="0" class="table"style="width: 174px; border:1px solid gray;"><thead><tr><th colspan="6" class="head red" class="head blue"  style="color: white; padding-left: 17px;">Book Details'
								+ '<ul class="buttons"><li><a href="javascript:hideuniform('
								+ id
								+ ');"><div class="icon"><span class="ico-cancel"></span></div></a></li></ul></th> </tr></thead><tbody><tr><td style="background-color: #FFFFFF" class="center">Class</td><td class="center" style="background-color: #FFFFFF">Subject</td><td class="center" style="background-color: #FFFFFF">Book Title</td><td class="center" style="background-color: #FFFFFF">Quantity</td><td class="center" style="background-color: #FFFFFF">Amount</td><td class="center" style="background-color: #FFFFFF">Net Amount</td></tr>'
						for (var i = 0; i < j.length; i++) {
							content += '<tr><td style="background-color: #FFFFFF" class="center">'
									+ j[i].className
									+ '</td>'
									+ '<td style="background-color: #FFFFFF" class="center">'
									+ j[i].subjectName
									+ '</td>'
									+ '<td style="background-color: #FFFFFF" class="center">'
									+ j[i].bookTitle
									+ '</td>'
									+ '<td style="background-color: #FFFFFF" class="center">'
									+ j[i].boughtQuantity
									+ '</td>'
									+ '<td style="background-color: #FFFFFF" class="center">'
									+ j[i].amount
									+ '</td>'
									+ '<td  style="background-color: #FFFFFF" class="center">'
									+ j[i].netAmount + '</td><tr>';
						}
						content += '</tbody></table>';
						$("#" + id).append(content);
						$("#" + id).fadeIn(1000);
					},
					error : function(e) {

					}
				});

	}
	function payment() {
		$('#paybutton').hide();
		$('#tbox').hide();
		$("#pays").empty();
		var total = $("#newtotal").val();
		var st = '<div id="finals"><div id="box" style="border: 1px solid; border-radius: 10px; width: 717px; height: 161px; padding-left: 22px; margin-top: 0px; padding-top: 5px;"><table style="width: 1006px; padding-left: 54px;"><tr><td style="width: 136px;">Gross amount:</td><td style="width: 90px;"> <input type="text" name="grossAmount" id="totalAmount" readonly="readonly" value='+total+'></td><td style="width: 28px;"></td>'
				+ '<td style="width: 224px;">Discount in % <input type="radio" onclick="disAmountType();" name="dis" value="per" id="per">/ Rs <input type="radio" onclick="disAmountType();" name="dis" id="rs" value="rs"></td><td>'
				+ '<input type="text" id="disAmount" onkeyup="getDiscount(this.value)"onclick="getzeroremoved();"style="width: 79px;"></td></tr> '
				+ '<tr><td style="width: 30px;">Payment Type:</td><td style="width: 50px;"><select id="paymentType" name="paymentMode" onchange="getPaymentType(this.value)" class="validate[required]"  style="height: 23px;">'
				+ '<option value="Cash">Cash</option><option value="Cheque">Cheque</option></select></td><td></td>'
				+ '<td><span>Net Payable Amount</span></td><td><input type="text" name="netPayableAmount" id="discountAmount" readonly="readonly" value='+total+'></td><td></td></tr>'
				+ '<tr><td><span>Paid Amount</span></td><td><input type="text"  oninput="converttowords(this.value);" onclick="removezero();" name="paidAmount" value="" id="recentPaidAmount" style="height: 23px;"></td><td></td>'
				+ '<td><span>Dues</span></td><td><input type="text" id="due" name="dues" readonly="readonly" value="0"></td></tr>'
				+ '<tr><td style="width: 30px;">Cheque Number:</td><td style="width: 50px;"><input type="text" id="checkNo" name="chequeno" maxlength="6" readonly="readonly" style="height: 23px;"></td>'
				+ '<td></td><td style="width: 30px;">Bank Name:</td><td style="width: 50px;"><input type="text" id="bankName" name="bankName" readonly="readonly" style="height: 23px; width: 219px;"></td></tr>'
				+ '<tr><td colspan="4"><h5 id="labelwords"></h5></td>'
				+ '<td><input type="hidden" name="inwords" value="0" id="paidAmountInWord"><a href="javascript:validate();"><span class="label label-success" style="width: 53px; padding-left: 12px; height: 22px; margin-top: 4px;">Submit</span></a></td></tr></table></div><div id="feeCategoryNamemsg"></div></div>';
		$("#pays").append(st);

	}
	function disAmountType() {
		var total = $("#totalAmount").val();
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
			if (parseInt(value) > 100) {
				alert("More than 100% discount is invalid");
				$('#discountAmount').val(totalAmount);
				$('#disAmount').val(0);
			} else {
				var discount = Math.round(parseInt(totalAmount)
						* parseInt(value) / 100);
				var discountAmount = Math.round(totalAmount - discount);
				$('#discountAmount').val(discountAmount);
				$('#discounts').val(discount);
			}

		} else if (disType == 'rs') {
			if (parseInt(value) > parseInt(totalAmount)) {
				alert("Discount cannot be more than total amount");
				$('#discountAmount').val(totalAmount);
				$('#disAmount').val(0);
			} else {
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
		} else {
			if (parseInt($("#discountAmount").val()) >= parseInt(num)) {
				if (num == '' || num == '0') {
					$("#due").val($("#discountAmount").val());
				} else {
					$("#due").val(
							parseInt($("#discountAmount").val())
									- parseInt(num));
				}
				$("#feeCategoryNamemsg").empty();
			} else {

				$("#recentPaidAmount").val('');
				num = '0';
				$("#feeCategoryNamemsg")
						.append(
								'<center><span><font color="red" size="2">Paid Amount should be less than or equal to Net Payable Amount</font></span></center>');

			}

			var word = toWords(num);
			$("#paidAmountInWord").val(word);
			var label = 'Amount In words :' + word + ' only';
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
	function removezero() {
		var paid = $("#recentPaidAmount").val();
		if (paid == 0)
			$("#recentPaidAmount").val('');
	}

	function validate() {
		$("#feeCategoryNamemsg").empty();
		flage = true;
		var regex2 = /^[a-zA-Z ]+$/;
		var paid = $("#recentPaidAmount").val();
		if (paid == '') {
			$("#feeCategoryNamemsg")
					.append(
							'<center><span><font color="red" size="2">Enter amount to be paid</font></span></center>');
			flage = false;
		}
		if ($("#paymentType").val() == 'Cheque' && $("#bankName").val() == '') {
			flage = false;
			$("#feeCategoryNamemsg")
					.append(
							'<center><font color="red">*Enter Bank Name</font></center>');

		}
		if ($("#paymentType").val() == 'Cheque'
				&& ($("#checkNo").val() == '' || $("#checkNo").val().length < 6)) {
			flage = false;
			$("#feeCategoryNamemsg")
					.append(
							'<center><font color="red">*Please Enter 6 digit valid Cheque No.</font></center>');

		}
		if ($("#paymentType").val() == 'Cheque'
				&& !regex2.test($("#bankName").val())) {
			$("#feeCategoryNamemsg")
					.append(
							'<center><font color="red" size="2">*Enter only letters in Bank Name</font><center>');
			flage = false;
		} else if ($("#paymentType").val() == 'Cheque'
				&& $("#CheckNo").val() == '') {
			flage = false;
			$("#feeCategoryNamemsg")
					.append(
							'<center><font color="red">*Please Enter 6 digit valid Cheque No.</font></center>');

		} else if ($("#paymentType").val() == 'Cheque'
				&& !$.isNumeric($("#checkNo").val())) {
			flage = false;
			$("#feeCategoryNamemsg")
					.append(
							'<center><font color="red">*Cheque No. in numbers only.</font></center>');

		}
		if (flage) {
			$("#feeCategoryNamemsg").empty();
			$("#validateform").submit();
			//document.location.href = 'book-purchase';

		}

	}
	function hideuniform(value) {
		$("#" + value).fadeOut(1000);
	}

	function editpurchases(id) {

		$("#appendallotBookId").empty();
		$("#appendsupplier").empty();
		$("#validationmsg").empty();
		var shop = $("#shopName").val();

		$
				.ajax({
					type : "post",
					url : 'getAllotBookPurchasebyId',
					data : {
						'allotDressId' : +id
					},
					success : function(data) {
						var obj = JSON.parse(data);

						$("#appendallotBookId")
								.append(
										'<input type="hidden" name="allotDressId" value="'+id+'"/>');
						$("#appendsupplier")
								.append(
										'<input type="hidden" name="supplierName" value="'+shop+'"/>');
						$("#editbookTitle").val(obj.bookTitle);

						$("#editquantity").val(obj.quantity);
						$("#editamount").val(obj.amount);
						$("#editNetAmount").val(obj.netamount);
						$("#editbookPrice").val(obj.price);
						$("#edittotalPrice").val(obj.quantity * obj.price);

						$(".editbox").show();
					},
					error : function(e) {

					}
				});
	}
	function hideeditbox() {
		$("#validationmsg").empty();
		$(".editbox").hide();
	}
	function hidepaybox() {

		$(".paybox").hide();
	}
	function changetotal(price) {
		var q = $("#editquantity").val();
		$("#edittotalPrice").val(q * price);
	}
	function getEditAmountupdate(editQuantity) {
		var price = $("#editbookPrice").val();
		if (price > 0) {
			$("#edittotalPrice").val(editQuantity * price);
		}
	}
	function editedvalidate() {
		var regex1 = /^[1-9][0-9]*$/;
		var regex2 = /^[a-zA-Z ]+$/;
		var flage = true;
		$("#editbookTitlemsg").val('');
		$("#editamountmsg").empty();
		$("#editpricemsg").empty();
		$("#editquantitymsg").empty();
		$("#netmsg").empty();
		if (!regex2.test($("#editbookTitle").val())) {
			$("#editbookTitlemsg")
					.append(
							'<span><font color="red" size="2">*Enter only letters</font></span>');
			flage = false;
		}
		if (!regex1.test($("#editquantity").val())) {
			$("#editquantitymsg")
					.append(
							'<span><font color="red" size="2">*Quantity should be greater than zero and Enter only numeric value in quantity</font></span>');
			flage = false;
		} else if (!regex1.test($("#editamount").val())) {
			$("#editamountmsg")
					.append(
							'<span><font color="red" size="2">*Amount should be greater than zero and Enter only numeric value in amount</font></span>');
			flage = false;
		} else if (!regex1.test($("#editNetAmount").val())) {
			$("#netmsg")
					.append(
							'<span><font color="red" size="2">*Amount should be greater than zero and Enter only numeric value in amount</font></span>');
			flage = false;
		} else if (!regex1.test($("#editbookPrice").val())) {
			$("#editpricemsg")
					.append(
							'<span><font color="red" size="2">*Price Should be greater than zero and Enter only numeric value in price</font></span>');
			flage = false;
		}

		if (flag == true) {
			$("#validateform").submit();

		}
	}
	window.onload = function() {

		var supplier = '${SupplierName}';

		if (supplier == '' || supplier == null) {

		} else {
			getSupplierDetails(supplier);
			$("#shopName").val(supplier)
		}

	}
	function deletealloted(id) {
		var sup = $("#shopName").val();

		var net = $("#previous").val();
		$("#detailofdress").empty();
		$
				.ajax({
					type : "post",
					url : 'deleteallotedbook',
					data : {
						'allotDressId' : +id,
					},
					success : function(data) {
					
						var j = JSON.parse(data);
						var k = j.length;
						
						if (k == 0) {
							var t = 0;
						} else
							var t = j[k - 1].totalamount;
						$("#totals").val(t);
						var st = '<div id="tbox" style="border: 1px solid lightgray; width: 189px; padding-left: 14px; margin-bottom: 18px;height:auto; float: left; background-color: lightyellow; margin-top: 63px;"><h5>Gross amount:Rs '
								+ t
								+ '</h5><h5 id="prev"></h5><h5 id="net"></h5></div>'
								+ '<button class="btn btn-success" id="paybutton" style="margin-top: 27px; margin-left: 4px; width: 134px; display:none;" type="button" onclick="payment();">Proceed to Payment</button>'
								+ '<div class="span12" style="margin-left: 0px; width: 560px;"></div><div style="padding: 10px 0px 0px; width: 502px;" class="widget-body">'
								+ '<div class="block"><div class="head blue" style="width: 547px;"><div class="icon"><span class="ico-pen-2"></span></div>'
								+ '<h2>Book Purchase Details</h2><ul class="buttons"><li><a return false; href="#"><div class="icon"><span class="ico-info"></span></div></a></li>'
								+ '</ul></div><div id="purchases" style="width: 561px;"><table class="table fTable lcnp" style="width: 1059px;"><thead><tr><th>S No</th><th>Class</th><th>Subject</th>'
								+ '<th>Title</th><th>Quantity</th><th>Price</th><th>Amount</th><th>Net Amount</th><th>Edit</th><th>Delete</th></tr></thead><tbody>';
						for (var i = 0; i < j.length; i++) {
							st += '<tr><td class="center"><font size="2">'
									+ (i + 1)
									+ '</font></td>'
									+ '<td class="center"><font size="2">'
									+ j[i].className
									+ '</font></td>'
									+ '<td class="center"><font size="2">'
									+ j[i].subjectName
									+ '</font></td>'
									+ '<td class="center"><font size="2">'
									+ j[i].bookTitle
									+ '</font></td>'
									+ '<td class="center"><font size="2">'
									+ j[i].price
									+ '</font></td>'
									+ '<td class="center"><font size="2">'
									+ j[i].amount
									+ '</font></td>'
									+ '<td class="center"><font size="2">'
									+ j[i].netamount
									+ '</font></td>'
									+ '<td class="center"><font size="2"><a href="javascript:editpurchases('
									+ j[i].allotDressId
									+ ');"><span'
					+'	class="label label-success">Edit</span></a></font></td><td class="center"><font size="2">'
									+ '<a href="javascript:deletealloted('
									+ j[i].allotDressId
									+ ');"><span class="label label-important" style="margin-top: 6px;">Delete</span></a></font></td></tr>';
						}
						$("#detailofdress").append(st);
						$("#totals").val(t);
						 if (sup == '' || sup == null) {
							$("#newtotal").val(t);
						} else { 
							$("#prev").text('Previous Balance: Rs ' + net + '');
							net = parseInt(net) + parseInt(t);
							$("#net").text('Net Amount: Rs ' + net + '');
							$("#newtotal").val(net);
						}
							if (parseInt(net) > 0){
								
								$("#paybutton").show();
							}
							
						
					},
					error : function(e) {

					}
				});
	}
</script>
<div class="paybox">
	<div class="paybox-header">
		<a href="javascript:hidepaybox();" class="close" data-dismiss="modal"
			style="margin-right: 10px; margin-top: 10px;" aria-hidden="true">×</a>
		<h4 id="myModalLabel" style="padding-top: 15px;">
			<center>Payment details</center>
		</h4>
	</div>
	<div id="paymentshow"></div>
</div>
<div class="editbox">
	<div class="editbox-header">
		<a href="javascript:hideeditbox();" class="close" data-dismiss="modal"
			style="margin-right: 10px; margin-top: 10px;" aria-hidden="true">×</a>
		<h3 id="myModalLabel">Edit Purchased Book Details</h3>
	</div>
	<f:form commandName="AllotDressDTO" action="edit-book-allot.html"
		id="submitform" onsubmit="return editedvalidate();">
		<div class="row-fluid" style="margin-top: 20px;">
			<div class="block-fluid">
				<div id="appendallotBookId"></div>
				<div id="appendsupplier"></div>
				<table>
					<tr>
						<td style="width: 200px; padding-left: 20px; padding-right: 21px;">Book
							Title</td>
						<td><f:input id="editbookTitle" maxlength="35"
								path="bookTitle" style="width:200px;" required="required" /></td>
						<td colspan="2"><div id="editbookTitlemsg"></div></td>
					</tr>
					<tr>
						<td style="width: 200px; padding-left: 20px; padding-right: 21px;">Quantity</td>
						<td><f:input id="editquantity" maxlength="35"
								onclick="removezero();" path="quantity"
								oninput="getEditAmountupdate(this.value);" style="width:200px;"
								required="required" /></td>
						<td colspan="2"><div id="editquantitymsg"></div></td>

					</tr>
					<tr>
						<td style="width: 200px; padding-left: 20px; padding-right: 21px;">Amount</td>
						<td><f:input id="editamount" maxlength="35" path="amount"
								onclick="removezero();" required="required" style="width:200px;" /></td>
						<td colspan="2"><div id="editamountmsg"></div></td>

					</tr>
					<tr>
						<td style="padding-left: 20px; padding-right: 21px;"><span>Net
								Amount<font color="red">*</font>
						</span></td>
						<td><f:input id="editNetAmount" maxlength="35"
								path="netamount" required="required" style="width:200px;" /></td>
						<td><div id="netmsg"></div></td>
					</tr>
					<tr>
						<td style="width: 200px; padding-left: 20px; padding-right: 21px;">Selling
							Price per book</td>
						<td><f:input id="editbookPrice" maxlength="35"
								onclick="removezero();" required="required" path="price"
								oninput="changetotal(this.value);" style="width:200px;" /></td>
						<td colspan="2"><div id="editpricemsg"></div></td>

					</tr>
					<tr>
						<td style="width: 200px; padding-left: 20px; padding-right: 21px;">Total
							Price</td>
						<td><input id="edittotalPrice" maxlength="35"
							name="totalamount" value="0" readonly="readonly"
							style="width: 200px; border: 1px solid lightgray;"></td>
						<td></td>
						<td></td>
					</tr>

				</table>

				<div id="validationmsg"></div>
			</div>

		</div>

		<div class="editbox-footer"
			style="float: right; margin-top: 17px; margin-left: 36px; margin-right: 165px;">
			<button class="btn btn-primary" data-dismiss="modal" type="submit"
				id="sbmt" aria-hidden="true">Save updates</button>
			<a class="btn btn-warning" data-dismiss="modal"
				href="javascript:hideeditbox();" style="margin-right: 15px"
				aria-hidden="true">Close</a>
		</div>
	</f:form>
</div>

<div class="content">
	<div id="content-header" style="height: 150px;">
		<img alt="Show_settings" src="${img_url}/uniform.jpg"
			style="width: 50px; margin-top: -12px;">
		<h1>Purchased Book Details</h1>
		<h3>Payment of purchased Books</h3>
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
	<f:form action="pay-bookpurchases" id="validateform"
		commandName="BookSupplierDTO" target="_blank">

		<table style="width: 937px; height: 96px;">

			<tr>
				<td style="width: 200px;">Date</td>
				<td style="width: 272px;"><input id="dateOfPurchase"
					maxlength="35" name="dateOfPurchase" readonly="readonly"
					style="width: 245px; border: 1px solid lightgray;"
					class="datepicker validate[required]" value="${currentDate}"></td>
				<td style="width: 79px;"></td>
				<td><f:hidden value="" path="supplierNo" id="supplierNo" /></td>
			</tr>

			<tr>
				<td style="width: 200px;">Supplier Name</td>
				<td><f:select id="shopName" required="required"
						onchange="getSupplierDetails(this.value);" style="width: 250px;"
						path="supplierName">
						<option value="">Select a Supplier</option>
						<c:forEach var="content" items="${shopNames}">
							<f:option value="${content}">${content}</f:option>
						</c:forEach>
					</f:select></td>
				<td><a href="javascript:addnewshop()"><span
						class="label label-primary">+Add new</span></a></td>
				<td><div id="newshop" style="width: 226px;"></div></td>
				<td><div id="shopmsg"></div></td>
			</tr>



		</table>

		<br>
		<div id="pays" style="margin-top: 29px; margin-bottom: -101px; width: 740px;"></div>
	</f:form>
	<c:if test="${msg!=null}">
		<div class="successmsg">${msg}</div>
	</c:if>

	<br>
	<div class="separator"></div>

	<div id="whole">
		<div>
			<input type="hidden" value="0" id="newtotal"> <input
				type="hidden" value="0" id="previous"> <input type="hidden"
				value="${total}" id="totals">
			<div id="showcategories" style="float: right;"></div>
			<div id="supplierDetails" style="float: right; margin-top: 80px; width: 487px; margin-left: 0px; margin-right: -15px;"></div>
			<div id="detailofdress" style="float: left;">
				<c:if test="${!purchaseList.isEmpty()}">
					<div id="tbox"
						style="border: 1px solid lightgray; width: 189px; padding-left: 14px; margin-bottom: 18px; float: left; background-color: lightyellow; margin-top: 63px; ">
						<h5>Gross amount:Rs.${total}</h5>
						<h5 id="prev"></h5>
						<h5 id="net"></h5>
					</div>
					<br>
					<button class="btn btn-success" id="paybutton"
						style="margin-top: 163px; margin-left: -169px; display: none;"
						type="button" onclick="payment();">Proceed to Payment</button>
					<br>
					<hr>
					<div class="span12" style="margin-left: 0px; width: 560px;"></div>
					<div style="padding: 10px 0px 0px; width: 502px;"
						class="widget-body">
						<div class="block">
							<div class="head blue" style="width: 547px;">
								<div class="icon">
									<span class="ico-pen-2"></span>
								</div>
								<h2>Purchased Book Details</h2>
								<ul class="buttons">
									<li><a return false; href="#"><div class="icon">
												<span class="ico-info"></span>
											</div></a></li>
								</ul>
							</div>

							<div id="purchases" style="width: 561px;">
								<table class="table fTable lcnp" style="width: 1059px;">
									<thead>
										<tr>
											<th>S No</th>
											<th>Class</th>
											<th>Subject</th>
											<th>Title</th>
											<th>Quantity</th>
											<th>Price</th>
											<th>Amount</th>
											<th>Net Amount</th>
											<th>Edit</th>
											<th>Delete</th>



										</tr>
									</thead>
									<tbody>
										<c:forEach var="list" items="${purchaseList}" varStatus="loop">
											<tr>
												<td class="center"><font size="2">${loop.count}</font></td>
												<td class="center"><font size="2">${list.className}</font></td>
												<td class="center"><font size="2">${list.subjectName}</font></td>
												<td class="center"><font size="2">${list.bookTitle}</font></td>
												<td class="center"><font size="2">${list.quantity}</font></td>
												<td class="center"><font size="2">${list.price}</font></td>
												<td class="center"><font size="2">${list.amount}</font></td>
												<td class="center"><font size="2">${list.netamount}</font></td>

												<td class="center"><font size="2"><a
														href="javascript:editpurchases('${list.allotDressId}');"><span
															class="label label-success">Edit</span></a></font></td>
												<td class="center"><font size="2"><a
														href="javascript:deletealloted('${list.allotDressId}');"><span
															class="label label-important" style="margin-top: 6px;">Delete</span></a></font></td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</c:if>
			</div>
		</div>
	</div>
	<div class="separator"></div>

</div>