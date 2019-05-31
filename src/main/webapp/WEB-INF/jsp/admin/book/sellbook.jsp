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
<script>
function getSectionList(id) {
	$("#classmsg").empty();
	$("#sectionId").empty();
	$("#BookList").empty();
	$("#Student").empty();
	$.ajax({
		type : "post",
		url : 'getsectionlist/' + id,
		success : function(data, status) {
			
			var j = JSON.parse(data);
			var content = '<option value="">Select Section</option>';
			for ( var i = 0; i < j.length; i++) {
				content += '<option value='+j[i].sectionId+'>'
						+ j[i].sectionName + '</option>';
			}
			$("#sectionId").append(content);
		
		},
		error : function(e) {

		}
	});
	
	
}
function getBookList(classId,sectionId) {
	
	var total=0;
		var url = 'getBookList/' + classId+'/'+sectionId;
		$
		.ajax({
			url : url,
			type : 'POST',
		success : function(data, status) {
			$("#BookList").empty();
			var obj = JSON.parse(data);
			var content = '';
			if (obj.length==0)
				{
			content='<div class="failedmsg"><b>There are no books for this Class</b></div>';	
				}
			else
				{
			content='<div  class="head blue" style="width: 883px; margin-left: 104px;"><div class="icon"><i class="ico-layout-9"></i></div><h2>Books List</h2></div><div class="data-fluid">'
			+ '<table width="80%"  class="table table-bordered table-primary" class="table table-bordered table-primary" width="80%" style="width: 896px; margin-left: 103px;">'
		 + '<thead> <tr> <th style="width:20%">'
		 + '<div style="margin-top: -25px;"><span><input type="checkbox" onclick="selectcheckbox(this.checked);" id="allbox"></span></div></th><th style="width:40%">Title</th>'
			 + '<th style="width:20%">Price</th><th style="width:20%">Remark</th></thead>'
		 +'<tbody>';
			$
			.each(
					obj,
					function(key, value) {
						if(value.remainingQuantity>0)
							{
						content += '<tr><td><span><input type="checkbox" value="'+value.bookPurchaseId+'" name="bookPurchaseId" class="bookId" onClick="getTotalamount('+value.bookPrice+',this.checked);"></span></td>';
						content += '<td>'
								+ value.bookTitle 
								+ '</td>';
						content += '<td>'
								+ value.bookPrice
								+ '</td><td></td></tr>';
								total+=value.bookPrice;
							}
						else
							{
							content += '<tr><td><span><input type="checkbox" value="'+value.bookPurchaseId+'" name="bookPurchaseId" disabled="disabled"></span></td>';
							content += '<td>'
									+ value.bookTitle 
									+ '</td>';
							content += '<td>'
									+ value.bookPrice
									+ '</td><td><div class="failedmsg" style="height: 8px; padding-top: 0px; margin-top: -1px; margin-bottom: 5px;">*Out of Stock</div></td></tr>';
							
							}
					});
	content += '<tbody></table>'
	          +'<input type="hidden" value="'+total+'" id="total" name="total"><div style="margin-left: 105px;"><h4 id="newtotals">Total amount = 0</h4></div><div style="width: 124px; padding-left: 12px; height: 22px; margin-left: 429px;"><a href="javascript:validate();" id="paybutton"><span class="label label-success" style="width: 124px; padding-left: 12px; height: 22px; margin-top: 6px;">Proceed to payment</span></div><div style="width: 124px; padding-left: 12px; height: 22px; margin-left: 220px;"><a href="javascript:validates();" id="paybuttons"><span class="label label-success" style="width: 62px; padding-left: 12px; height: 22px; margin-top: -29px; margin-left: 77px;">Add to fee</span></div><div id="feeCategoryNamemsg" style="width: 383px; margin-top: -21px;"></div><input type="hidden" value="0" id="newtotal" name="newtotal">';
				}
	          $("#BookList").append(content);
				
	},
		error : function(e) {

		}
	});
	
	
}
function selectcheckbox(flage) {
	var total=$("#total").val();
	var bookIds = document.getElementsByClassName("bookId");
	$.each(bookIds, function(key, value) {
		if (flage) {
			value.checked = true;
		} else {
			value.checked = false;
		}
	});
	if(flage)
		{
		$("#newtotal").val(total);
		$("#newtotals").text('Total amount ='+total);
		}
	else
		{
		$("#newtotal").val('0');
		$("#newtotals").text('Total amount =0');
		$("#pays").empty();
		}
}
function getTotalamount(price,flage)
{
	$("#pays").empty();
	$('#paybutton').show();
	$("#allbox").prop("checked", false);
	var total=$("#newtotal").val();
	if (flage) {
		total=parseInt(total)+parseInt(price);
		
	} else {
		total=parseInt(total)-parseInt(price);
	}
	$("#newtotal").val(total);
	$("#newtotals").text('Total amount ='+total);
	}
	
function validate() {
	var flage = true;
	var flag=false;
	$("#feeCategoryNamemsg").empty();
	$("#sectionmsg").empty();
	$("#namemsg").empty();
	var sectionId = $('#sectionId').val();
	var student = $("#firstName").val();
	if (sectionId == '' || sectionId == null) {
		$("#sectionmsg")
				.append(
						'<font color="red" size="2">*This field is required</font>');
		window.scrollBy(0, -500);
		flage=false;
	}

	if (student == '' || student == null) {
		$("#namemsg")
				.append(
						'<font color="red" size="2">*This field is required</font>');
		window.scrollBy(0, -500);
		flage=false;
	} 
	var bookIds = document.getElementsByClassName("bookId");
	$.each(bookIds, function(key, value) {
		if (value.checked) {
			flag = true;
		}
	});
	if (!flag) {
		$("#feeCategoryNamemsg")
		.append(
				'<center><font color="red">*Select atleast one book</font></center>');
	}
	if((flag) && (flage))
		{
		var total = $("#newtotal").val();
		$("#totalAmount").val(total);
		$("#validateform").attr('action', 'sell-books');
		payment(total);
		}
}
function validates() {
	var flage = true;
	var flag=false;
	$("#feeCategoryNamemsg").empty();
	$("#sectionmsg").empty();
	$("#namemsg").empty();
	var sectionId = $('#sectionId').val();
	var student = $("#firstName").val();
	if (sectionId == '' || sectionId == null) {
		$("#sectionmsg")
				.append(
						'<font color="red" size="2">*This field is required</font>');
		window.scrollBy(0, -500);
		flage=false;
	}

	if (student == '' || student == null) {
		$("#namemsg")
				.append(
						'<font color="red" size="2">*This field is required</font>');
		window.scrollBy(0, -500);
		flage=false;
	} 
	var bookIds = document.getElementsByClassName("bookId");
	$.each(bookIds, function(key, value) {
		if (value.checked) {
			flag = true;
		}
	});
	if (!flag) {
		$("#feeCategoryNamemsg")
		.append(
				'<center><font color="red">*Select atleast one book</font></center>');
	}
	if((flag) && (flage))
		{
		var total = $("#newtotal").val();
		$("#totalAmount").val(total);
		$("#validateform").submit();
		//payment(total);
		}
}
function payment(total) {
	$('#paybutton').hide();
	var total = $("#newtotal").val();
	var st = '<div id="finals"><div id="box" style="border: 1px solid; border-radius: 10px; width: 717px; height: 161px; padding-left: 22px; margin-top: 0px; padding-top: 5px;"><table style="width: 1006px; padding-left: 54px;"><tr><td style="width: 136px;">Total amount:</td><td style="width: 90px;"> <input type="text" name="totalAmount" id="totalAmount" readonly="readonly" value='+total+'></td><td style="width: 28px;"></td>'
			+ '<td style="width: 224px;">Discount in % <input type="radio" onclick="disAmountType();" name="dis" value="per" id="per">/ Rs <input type="radio" onclick="disAmountType();" name="dis" id="rs" value="rs"></td><td>'
			+ '<input type="text" id="disAmount" onkeyup="getDiscount(this.value)"onclick="getzeroremoved();"style="width: 79px;"></td></tr> '
			+'<tr><td style="width: 30px;">Payment Type:</td><td style="width: 50px;"><select id="paymentType" name="paymentMode" onchange="getPaymentType(this.value)" class="validate[required]"  style="height: 23px;">'
			+ '<option value="Cash">Cash</option><option value="Cheque">Cheque</option></select></td><td></td>'
			+ '<td><span>Net Payable Amount</span></td><td><input type="text" name="netPayableAmount" id="discountAmount" readonly="readonly" value='+total+'></td><td></td></tr>'
			+'<tr><td><span>Paid Amount</span></td><td><input type="text"  oninput="converttowords(this.value);" onclick="removezero();" name="paidAmount" value="" id="recentPaidAmount" style="height: 23px;"></td><td></td>'
			+ '<td><span>Dues</span></td><td><input type="text" id="due" name="dues" readonly="readonly" value="0"></td></tr>'
			+'<tr><td style="width: 30px;">Cheque Number:</td><td style="width: 50px;"><input type="text" id="checkNo" name="chequeno" maxlength="6" readonly="readonly" style="height: 23px;"></td>'
			+ '<td></td><td style="width: 30px;">Bank Name:</td><td style="width: 50px;"><input type="text" id="bankName" name="bankName" readonly="readonly" style="height: 23px; width: 219px;"></td></tr>'
		    +'<tr><td colspan="4"><h5 id="labelwords"></h5></td>'
			+ '<td><input type="hidden" name="inwords" value="0" id="paidAmountInWord"><a href="javascript:validateform();"><span class="label label-success"style="width: 53px; padding-left: 12px; height: 22px;">Submit</span></a></td></tr></table></div></div>';
	$("#pays").append(st);
	

	
}
function getStudentsList() {
	var classId = $("#class").val();
	var sectionId = $("#sectionId").val();
	
	$.ajax({
		type : "post",
		url : 'getStudentsbyclasssection/' + classId + '/' + sectionId,
		success : function(data, status) {
			$("#firstName").empty();
			var j = JSON.parse(data);
			
			var content = '<option value="">Select Student</option>';
		for ( var i = 0; i < j.length; i++) {
				content += '<option value='+j[i].admissionNo+'>'
						+ j[i].fullName + '</option>';

			}
			$("#firstName").append(content);

		},
		error : function(e) {

		}
	});
	getBookList(classId,sectionId);
}
function getStudentdetails(id) {
	$("#sectionmsg").empty();
	$("#namemsg").empty();
	$
			.ajax({
				type : "post",
				url : 'getstudentsdata/' + id,
				success : function(data, status) {
					$("#Student").empty();
					var j = JSON.parse(data);
					var st = '';
					st = '<div  id="box" style="border: 1px solid; border-radius: 10px; height: 110px; width: 541px; margin-left: -310px; margin-top: -4px;">';
					st += '<table style="width: 530px; margin-left: 10px; margin-top: 7px;"><tr><td><span><font size="2"><b>Name :</b></td><td colspan="3" ><span><font size="2">'
							+ j.firstName
							+ '\t'
							+ j.middleName
							+ '\t'
							+ j.lastName
							+ '</font></span></td></tr><tr><td><span><font size="2"><b>Father Name:</font></span></b></td><td style="width: 369px;"colspan="3"><span><font size="2">'
							+ j.fatherName
							+ '</font></span></td><tr><tr><td><span><font size="2"><b>Class:</font></span></b></td><td ><span><font size="2">'
							+ j.className
							+ '</font></span></td><td style="width: 79px;"><span><font size="2"><b>Section:</font></span></b></td><td style="width: 140px;"><span><font size="2">'
							+ j.sectionName
							+ '</font></span></td></tr><tr><td><span><font size="2"><b>Mobile No:</font></span></b></td><td colspan="3"><span><font size="2">'
							+ j.mobile
							+ '</font></span></td></tr></table></div>';
					$("#Student").append(st);
				},
				error : function(e) {

				}
			});
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
function disAmountType() {
	var total = $('#totalAmount').val();
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
		$('#discounts').val(0);
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
		$('#discounts').val(0);
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
function validateform() {
	flage = true;
	$("#feeCategoryNamemsg").empty();
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
		
	}

}
</script>
<div class="content">
	<div id="content-header" style="height: 150px;">
		<img alt="Show_settings" src="${img_url}/book1.jpg"
			style="width: 50px; margin-top: -12px;">
		<h1>Sell Books</h1>
		<h3>Sell Books to Students</h3>
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
		<f:form commandName="BookSellDTO" method="POST"
		id="validateform"  action="sell-book">
	<div class="row-fluid">
		<div class="span2" style="width: 605px;">
					<div class="block" style="left: -188px;">
				
						<table
							style="width: 604px; height: 0px; margin-left: 231px; margin-top: 0px;">
							<tr>
								<td style="width: 200px;"><span id="s">Class<font
										color="red">*</font></span></td>
								<td><select id="class" class="validate[required]"
									required="required" onchange="getSectionList(this.value);"
									style="width: 250px;" name="classId" class="select">
										<option value="">Select a class</option>
										<c:forEach var="list" items="${classList}">
											<option value="${list.classId}">${list.className}</option>
										</c:forEach>
								</select></td>
								<td><div id="classmsg"></div></td>
							</tr>
							<tr>
								<td style="width: 200px;">Section<font color="red">*</font></td>
								<td><select id="sectionId" class="validate[required]"
									style="width: 250px;" onchange="getStudentsList();"
									name="sectionId" class="select" required="required">
										<option value="">Select a Section</option>
								</select></td>
								<td><div id="sectionmsg"></div></td>
							</tr>
							<tr>
								<td style="width: 72px;"><span id="n">Name:<font
										color="red">*</font></span></td>
								<td><select id="firstName" class="validate[required]"
									style="width: 250px;" name="studentId" class="select"
									onchange=getStudentdetails(this.value); required="required">
										<option value="">Select a Student</option>
								</select>
									<div id="exist"></div></td>
								<td><div id="namemsg"></div></td>
							</tr>
						</table>

					</div>
				
		</div>

		<div class="span5">
			<div class="block" style="margin-left: 192px;">
				<div id="Student"></div>
			</div>
		</div>
		<hr>
	</div>
		<div class="row-fluid">
			<div class="span12">
				<div class="block" id="BookList"></div>
			</div>
		</div>
		<div id="up">
		<div class="row-fluid">
			<div class="span12">
				<div class="block">
					<div class="data-fluid" id="pays"></div>
				</div>
			</div>

		</div>
	</div>
	 <input type="hidden" name="totalAmount" id="totalAmount" readonly="readonly" value='0'>
	</f:form>
	
	</div>
	