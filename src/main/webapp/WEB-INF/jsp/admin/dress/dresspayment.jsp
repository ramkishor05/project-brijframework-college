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
	function getCategory(id, num) {
		$.ajax({
			type : "post",
			url : 'getdressCategory/' + id,
			success : function(data, status) {

				$("#category" + num).empty();
				var j = JSON.parse(data);
				var content = '<option value="">Select Category</option>';
				for ( var i = 0; i < j.length; i++) {
					content += '<option value='+j[i].dressId+'>'
							+ j[i].category + '</option>';
				}
				$("#category" + num).append(content);
			},
			error : function(e) {

			}
		});
	}
	function getSectionList(id) {
		 $("#classmsg").empty();
		$.ajax({
			type : "post",
			url : 'getsectionlist/' + id,
			success : function(data, status) {
				$("#sectionId").empty();
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
				var st = '';
				for ( var i = 0; i < j.length; i++) {
					content += '<option value='+j[i].admissionNo+'>'
							+ j[i].fullName + '</option>';

				}
				$("#firstName").append(content);

			},
			error : function(e) {

			}
		});
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
								+ j.mobile + '</font></span></td></tr></table></div>';
						var a = j.admissionNo;

						$("#studentId").val(a);
						$("#Student").append(st);
					},
					error : function(e) {

					}
				});
	}
	function getPrice(size, count) {
		var status = $("#status" + count).val();
		$("#quantity" + count).val('0');
		$("#amount" + count).val('');
		if (status == '1') {
			$("#msg" + count)
					.append(
							'<span><font color="red" size="2">Select category first</font></span>');
			$("#size" + count).val('');
		} else {
			$("#msg" + count).empty();
			var id = $("#dressId" + count).val();
			$.ajax({
				type : "post",
				url : 'getdressPriceforsize/' + id + '/' + size,
				success : function(data, status) {
					$("#price" + count).val('');
					var j = JSON.parse(data);
					$("#price" + count).val(j.price);
					$("#dressId" + count).val(j.dressId);
				},
				error : function(e) {

				}
			});
		}
	}
	function getdressIds(count, category, name) {
		$("#quantity" + count).val('0');
		$("#amount" + count).val('');
		$("#price" + count).val('');
		$("#size" + count).val('');
		$("#status" + count).val('2');
		$("#msg" + count).empty();
		$.ajax({
			type : "post",
			url : 'getIdforcategory/' + category + '/' + name,
			success : function(data, status) {
				$("#dressId" + count).val('')
				var j = JSON.parse(data);
				$("#dressId" + count).val(j);
			},
			error : function(e) {

			}
		});

		//alert($("#dressId"+count).val());

	}
	function getamount(quantity, count) {
		$("#msg" + count).empty();

		var flage = true;
		if (quantity == '') {
			/*   if(price!='')
				{
				$("#quantity"+count).val('0');
				flage = false;
				}
			 */
		} else {
			var price = $("#price" + count).val();
			if (price == '') {
				$("#msg" + count)
						.append(
								'<span><font color="red" size="2">*Select above fields first</font></span>');
				$("#quantity" + count).val('0');
				flage = false;
			} else {
				var regex1 = /^[0-9]*$/;
				if (!regex1.test($("#quantity" + count).val())) {
					$("#msg" + count)
							.append(
									'<span><font color="red" size="2">*Enter only numeric value in quantity</font></span>');
					flage = false;
				}
			}
			if (flage == true) {
				$("#msg" + count)
						.append(
								'<span><font color="green" size="2">*Dress Alloted</font></span>');

				var amount = price * $("#quantity" + count).val();
				$("#amount" + count).val(amount);
			}
		}
	}

	function addmore() {
		var id = $("#moreId").val();

		if (id == '13') {
			$("#morelink").hide();
		}
		$("#removelink").show();
		$
				.ajax({
					type : "post",
					url : 'getdressnames',
					success : function(data, status) {

						st = '<fieldset style="float: left; width: 300px;">'
								+ '<legend style="color: gray;">More</legend><table><tr><td style="width: 72px;"><span style="padding-left: 6px;"><font size="2">Dress Name</font></span></td>'
								+ '<td><select id="dressName+'
								+ id
								+ '" onchange="getCategory(this.value,'
								+ id
								+ ');" style="width: 250px;" name="dressName"><option value="">Select Dress</option>';
						var j = JSON.parse(data);

						for ( var i = 0; i < j.length; i++) {
							st += '<option value='+j[i].dressId+'>'
									+ j[i].dressName + '</option>';
						}
						st += '</select></td><td></td></tr>'
								+ '<tr><td style="width: 72px;"><span style="padding-left: 6px;"><font size="2">Category</font></span></td><td><select id="category'
								+ id
								+ '" onchange="getSize(this.value,'
								+ id
								+ ');" style="width: 250px;"name="category">'
								+ '<option value="">Select a category</option></select></td><td></td></tr>'
								+ '<tr><td style="width: 72px;"><span style="padding-left: 6px;"><font size="2">Size</font></span></td><td><select id="size'
								+ id
								+ '" onchange="getPrices(this.value,'
								+ id
								+ ');" style="width: 250px;"name="size"><option value="">Select a size</option>'
								+ '</select></td><td></td></tr><tr><td style="width: 72px;"><span style="padding-left: 6px;"><font size="2">Price:</font></span></td><td><input name="price" required="required" readonly="readonly" id="price'+id+'"'
					+'style="width: 250px;"><div id="exist"></div></td><td><input type="hidden"  value="0" name="allotedList['+id+'].dressId" id="dressId'+id+'"/></td></tr>'
								+ '<tr><td style="width: 72px;"><span style="padding-left: 6px;"><font size="2">Quantity:</font></span></td><td><input name="allotedList['
								+ id
								+ '].quantity" id="quantity'
								+ id
								+ '" placeholder="Enter Quantity" oninput="getmoreamount(this.value,'
								+ id
								+ ')" onclick="getquantityclear('
								+ id
								+ ')"'
								+ 'style="width: 250px;"value="0"/><div id="exist"></div></td><td></td></tr><tr><td style="width: 72px;"><span style="padding-left: 6px;"><font size="2">Amount:</font></span></td><td><input name="amount" readonly="readonly"id="amount'+id+'" placeholder="Amount"/>'
								+ '<div id="exist"></div></td><td></td></tr><tr><td colspan="3"><div id="msg'+id+'"></div></td></tr></table></fieldset>';
						$("#moredress").append(st);
						$("#moredress" + id).append(st);
						id++;
						$("#moreId").val(id);
					},
					error : function(e) {

					}
				});

	}

	function getSize(id, num) {
		$.ajax({
			type : "post",
			url : 'getdressSize/' + id,
			success : function(data, status) {
				$("#size" + num).empty();
				var j = JSON.parse(data);
				var content = '<option value="">Select Size</option>';
				for ( var i = 0; i < j.length; i++) {
					content += '<option value='+j[i].dressId+'>' + j[i].size
							+ '</option>';
				}
				$("#size" + num).append(content);
			},
			error : function(e) {

			}
		});
	}
	function getPrices(id, num) {
		$.ajax({
			type : "post",
			url : 'getdressPrice/' + id,
			success : function(data, status) {
				$("#price" + num).val('');
				var j = JSON.parse(data);
				$("#price" + num).val(j.price);
				$("#dressId" + num).val(j.dressId);
			},
			error : function(e) {

			}
		});

	}
	function getmoreamount(quantity, num) {
		$("#msg" + num).empty();

		if (quantity == '') {

		} else {
			var price = $("#price" + num).val();
			if (price == '') {
				$("#msg" + num)
						.append(
								'<span><font color="red" size="2">*Select above fields first</font></span>');
				$("#quantity" + num).val('');
				flage = false;
			} else {
				var regex1 = /^[0-9]*$/;
				if (!regex1.test($("#quantity" + num).val())) {
					$("#msg" + num)
							.append(
									'<span><font color="red" size="2">*Enter only numeric value in quantity</font></span>');
					flage = false;
				}
			}
			var amount = price * $("#quantity" + num).val();
			$("#amount" + num).val(amount);
		}
	}
	function removealloted(id) {
		$("#finals").empty();
		var total = '0';
		var url = 'removealloted/' + id;
		$
				.ajax({
					url : url,

					type : 'POST',
					success : function(data, status) {

						$("#dressDetails").empty();
						var j = JSON.parse(data);
						var st = "";
						var length = j.length;
						if (length == 0) {

						} else {
							st = '<table cellpadding="0" cellspacing="0" width="100%" class="table"><thead><tr><th width="25%">Dress Name</th><th width="25%">Category</th><th width="25%">Size</th>'
									+ '<th width="25%">Price</th><th width="25%">Quantity</th><th width="25%">Amount</th><th width="25%">Operation</th></tr></thead><tbody>';
							for ( var i = 0; i < length; i++) {
								st += '<tr><td>'
										+ j[i].dressName
										+ '</td><td>'
										+ j[i].category
										+ '</td><td>'
										+ j[i].size
										+ '</td><td>'
										+ j[i].price
										+ '</td><td>'
										+ j[i].quantity
										+ '</td><td>'
										+ j[i].amount
										+ '</td><td><a href="javascript:removealloted('
										+ j[i].allotDressId
										+ ')"><span  class="label label-important">Remove</span></a></td></tr>';
								total = j[i].totalamount;
							}
							st += '<input type="hidden" value="'+total+'" id="newtotal"></table>';

							st += '<button class="btn btn-success" id="paybutton"style="margin-left: 415px; margin-top: 22px;" type="button"onclick="payment();">Proceed to Payment</button>';

							$("#dressDetails").append(st);
						}

					},
					error : function(error, status) {
					}
				});
	}
	function payment(total) {
		$('#paybutton').hide();
		var total = $("#newtotal").val();
		var st = '<div id="finals"><div id="box" style="border: 1px solid; border-radius: 10px; width: 1060px; height: 150px;"><table style="width: 1006px; margin-top: 24px;"><tr><td>Total amount:</td><td> <input type="text" name="totalAmount" id="totalAmount" readonly="readonly" value='+total+'></td><td></td>'
				+ '<td>Discount in % <input type="radio" onclick="disAmountType();" name="dis" value="per" id="per">/ Rs <input type="radio" onclick="disAmountType();" name="dis" id="rs" value="rs"></td><td>'
				+ '<input type="text" id="disAmount" onkeyup="getDiscount(this.value)"onclick="getzeroremoved();"style="width: 79px;"></td><td</tr> '
				+ '<tr><td><span>Net Payable Amount</span></td><td><input type="text" name="netPayableAmount" id="discountAmount" readonly="readonly" value='+total+'></td><td></td>'
				+ '<td><span>In Words-</span></td><td style=" width: 308px;" ><input type="text" name="paidAmountInWord" value="0" id="paidAmountInWord" style="height: 32px; width: 311px;"  readonly="readonly"></td><td>/-Only</td></tr>'
				+ '<tr><td colspan="6"></td></tr><tr><td></td><td></td><td></td><td><a href="" onclick="generatepdf();"><span class="label label-success">Submit</span></a></td><td></td<td></td></tr></table></div></div>';
		$("#pays").append(st);
		converttowords(total);
	}
	function disAmountType() {
		$('#disAmount').val(0);
		var totalAmount = $('#totalAmount').val();
		var discountAt = parseInt(totalAmount);
		$('#discountAmount').val(discountAt);
		converttowords($("#discountAmount").val());
	}
	function getDiscount(value) {

		var totalAmount = $('#totalAmount').val();

		var disType;
		if ($("#per").is(":checked")) {
			disType = 'per';
		} else if ($("#rs").is(":checked")) {
			disType = 'rs';
		}
		if (isNaN(value) || value == '') {
			alert('Enter Valid Amount');
			var totalAmount = $('#totalAmount').val();
			var discountAt = parseInt(totalAmount);
			$('#discountAmount').val(discountAt);
			$('#discounts').val(0);
			converttowords($("#discountAmount").val());
		} else if (disType == 'per') {
			var discount = Math.round(parseInt(totalAmount) * parseInt(value)
					/ 100);
			var discountAmount = Math.round(totalAmount - discount);
			$('#discountAmount').val(discountAmount);
			$('#discounts').val(discount);
			converttowords($("#discountAmount").val());
		} else if (disType == 'rs') {
			var discount = Math.round(parseInt(value));
			var discountAmount = Math.round(parseInt(totalAmount)
					- parseInt(value));
			$('#discountAmount').val(discountAmount);
			$('#discounts').val(discount);
			converttowords($("#discountAmount").val());
		}
	}
	function converttowords(num) {

		var word = toWords(num);

		$("#paidAmountInWord").val(word);

	}
	function generatepdf() {
		var studentId = $('#newstudent').val();
		var paid = $("#discountAmount").val();
		var paidwords = $("#paidAmountInWord").val();
		var total = $('#totalAmount').val();
		window.open('submitdressdata?id=' + paid + '&id2='
				+ paidwords + '&id3=' + studentId + '&total=' + total,'_blank');
		
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
	function getquantityclear(count) {
		var q = $("#quantity" + count).val();
		if (q == 0) {
			$("#quantity" + count).val('');
		}
	}
	function removemore() {
		var id = $("#moreId").val() - 1;
		$("#moredress" + id).empty();
		$("#moreId").val(id);
		if (id == '13') {
			$("#morelink").show();
		}
		if (id == '12') {
			$("#removelink").hide();
		}
	}
	function validateform() {
		 $("#feeCategoryNamemsg").empty();
		 $("#classmsg").empty();
		 $("#sectionmsg").empty();
		 $("#namemsg").empty();
		var flag = false;
		
		var studentId = $('#newstudent').val();
     
		if (studentId == '' || studentId == null) {
			var classId=$('#class').val();
			var sectionId=$('#sectionId').val();
			var student = $("#studentId").val();

			if(classId=='' || classId==null)
				{
				$("#classmsg").append(
				'<font color="red" size="2">*This field is required</font>');
				window.scrollBy(0,-500);
		return false;
				}
			if(sectionId=='' || sectionId==null)
				{
				$("#sectionmsg").append(
				'<font color="red" size="2">*This field is required</font>');
				window.scrollBy(0,-500);
		return false;
				}
			
			if (student == '' || student == null) {
				$("#namemsg").append(
						'<font color="red" size="2">*This field is required</font>');
				window.scrollBy(0,-500);
				return false;
			} else {
				$("#feeCategoryNamemsg").empty();

			}
		} else {
			$("#studentId").val(studentId);
		} 

		for ( var i = 1; i <= 13; i++) {
			if ($("#quantity" + i).val() > 0) {
				flag = true;
				break;
			}

		}
		for ( var i = 1; i <= 13; i++) {
			if ($("#quantity" + i).val() == '') {
				$("#quantity" + i).val('0');
			}

		}
		if (flag == false) {
			$("#feeCategoryNamemsg").append(
					'<center><font color="red">*Select atleast one dress</font></center>');
			window.scrollBy(0,-500);
		}
		return flag;
	}
	$(document).ready(function() {
		$("#removelink").hide();
		 $('#class').val('');
		$('#sectionId').val('');
		$("#studentId").val(''); 

	});
</script>
<div class="content">
	<div id="content-header" style="height: 150px;">
		<img alt="Show_settings" src="${img_url}/uniform.jpg"
			style="width: 50px; margin-top: -12px;">
		<h1>Allot Dresses</h1>
		<h3>Allot Dress to Students</h3>
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
	<div class="row-fluid">
		<div class="span2" style="width: 605px;" >
			<c:choose>
				<c:when test="${studentdata==null}">
					<div class="block" style="left: -188px;">
						<table
							style="width: 604px; height: 0px; margin-left: 231px; margin-top: 0px;">
							<tr>
								<td style="width: 200px;"><span id="s">Class<font color="red">*</font></span></td>
								<td><select id="class" class="validate[required]"
									required="required" onchange="getSectionList(this.value);"
									style="width: 250px;" name="classId" class="select">
										<option value="">Select a class</option>
										<c:forEach var="list" items="${classList}">
											<option value="${list.classId}">${list.className}</option>
										</c:forEach>
								</select></td><td><div id="classmsg"></div></td>
							</tr>
							<tr>
								<td style="width: 200px;">Section<font color="red">*</font></td>
								<td><select id="sectionId" class="validate[required]"
									style="width: 250px;" onchange="getStudentsList();"
									name="sectionId" class="select" required="required">
										<option value="">Select a Section</option>
								</select></td><td><div id="sectionmsg"></div></td>
							</tr>
							<tr>
								<td style="width: 72px;"><span id="n">Name:<font color="red">*</font></span></td>
								<td><select id="firstName" class="validate[required]"
									style="width: 250px;" name="firsName" class="select"
									onchange=getStudentdetails(this.value); required="required">
										<option value="">Select a Student</option>
								</select>
									<div id="exist"></div></td>
								<td><div id="namemsg"></div></td>
							</tr>
						</table>

					</div>
				</c:when>
				<c:otherwise>
					<div id="box"
						style="border: 1px solid; border-radius: 10px; height: 196px; width: 541px; margin-left: 214px; background-color: lightyellow;">
						<table style="width: 501px; margin-left: 40px; margin-top: 35px;">
							<tr>
								<td style="width: 148px;"><span><font size="2"><b>Name :</b></font></span></td>
								<td style="width: 365px;"><span><font size="2">
									${studentdata.firstName}&nbsp${studentdata.middleName}&nbsp${studentdata.lastName}
								</font></span></td>
							</tr>
							<tr>
								<td><span><font size="2"><b>Father Name:</b></font></span></td>
								<td style="width: 365px;"><span><font size="2">${studentdata.fatherName}</font></span></td>
							<tr>
								<td><span><font size="2"><b>Roll No.:</b></font></span></td>
								<td style="width: 365px;"><span><font size="2">${studentdata.rollno}</font></span></td>
							</tr>
							<tr>
								<td><span><font size="2"><b>Class:</b></font></span></td>
								<td style="width: 365px;"><span><font size="2">${studentdata.className}</font></span></td>
							<tr>
								 <td style="width: 79px;"><span><font size="2"><b>Section:</b></font></span></td>
								<td style="width: 365px;"><span><font size="2">${studentdata.sectionName}</font></span></td>
							</tr>
							<tr>
								<td><span><font size="2"><b>Mobile No:</b></font></span></td>
								<td style="width: 365px;"><span><font size="2">${studentdata.mobile}</font></span></td>
							</tr>
						</table>
					</div>

				</c:otherwise>
			</c:choose>

		</div>
	
		<div class="span5">
			<div class="block" style="margin-left: 192px;">
				<div id="Student"></div>
			</div>
		</div>
		<hr>
	</div>
	<hr>
	<div id="up">
		<div class="row-fluid">
			<div class="span12">
				<div class="block">
					<c:if test="${details!=null}">
						<div class="head blue" style="margin-top: 18px;">
							<div class="icon">
								<span class="ico-pen-2"></span>
							</div>
							<h2>Selected Dress Details</h2>
						</div>
						<div class="data-fluid" id="dressDetails">

							<table width="100%" class="table">
								<thead>
									<tr>
										<th width="25%">Dress Name</th>
										<th width="25%">Category</th>
										<th width="25%">Size</th>
										<th width="25%">Price</th>
										<th width="25%">Quantity</th>
										<th width="25%">Amount</th>
										<th width="25%">Operation</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="val" items="${details}">
										<tr>
											<td>${val.dressName}</td>
											<td>${val.category}</td>
											<td>${val.size}</td>
											<td>${val.price}</td>
											<td>${val.quantity}</td>
											<td>${val.amount}</td>
											<td><a
												href="javascript:removealloted('${val.allotDressId}')"><span
													class="label label-important">Remove</span></a></td>
										</tr>
										<c:set var="total" value="${val.totalamount}"></c:set>
										<c:set var="newstudentId" value="${val.studentId}"></c:set>
									</c:forEach>
									<input type="hidden" value="${total}" id="newtotal">
							</table>
							<button class="btn btn-success" id="paybutton"
								style="margin-left: 415px; margin-top: 22px;" type="button"
								onclick="payment();">Proceed to Payment</button>


						</div>
						<input type="hidden" value="${newstudentId}" id="newstudent">
					</c:if>
				</div>

			</div>

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
	<div id="feeCategoryNamemsg" ></div>
	<div style="width: 1050px;">
	
		<f:form action="save-dress" commandName="DressDTO" method="POST"
			onsubmit="return validateform();">
			<c:forEach var="list" items="${dresses}" varStatus="loop">
				<fieldset
					style="float: left; width: 300px; height: 200px; margin: 15px;">
					<legend style="color: gray;">${list.dressName}</legend>
					<table>
						<c:choose>
							<c:when test="${list.status==0}">
								<tr>
									<td></td>
									<td></td>
									<td></td>
								</tr>
							</c:when>

							<c:otherwise>
								<tr>
									<td><span style="padding-left: 6px;"><font size="2">Category</font></span></td>
									<td><select id="category${loop.count}"
										onchange="getdressIds('${loop.count}',this.value,'${list.dressName}');"
										name="category">
											<option value="">Select a category</option>
											<c:forEach var="value" items="${list.categoryList}">
												<option value="${value}">${value}</option>
											</c:forEach>
									</select></td>
									<td><input type="hidden" style="width: 27px;"
										id="status${loop.count}" value="${list.status}" /></td>
								</tr>
							</c:otherwise>
						</c:choose>
						<tr>
							<td style="width: 72px;"><span style="padding-left: 6px;"><font size="2">Size</font></span></td>
							<td><select id="size${loop.count}"
								onchange="getPrice(this.value,'${loop.count}');" name="size">
									<option value="">Select a size</option>
									<option value="1">1</option>
									<option value="2">2</option>
									<option value="3">3</option>
									<option value="4">4</option>
									<option value="5">5</option>
							</select></td>
							<td></td>

						</tr>
						<tr>
							<td style="width: 72px;"><span style="padding-left: 6px;"><font size="2">Price:</font></span></td>
							<td><input name="price" readonly="readonly"
								id="price${loop.count}">
								<div id="exist"></div></td>
							<td></td>
						</tr>
						<tr>
							<td style="width: 72px;"><span style="padding-left: 6px;"><font size="2">Quantity:</font></span></td>
							<td><f:input path="allotedList[${loop.count}].quantity"
									onclick="getquantityclear('${loop.count}');"
									oninput="getamount(this.value,'${loop.count}');"
									id="quantity${loop.count}" placeholder="Enter Quantity" />
								<div id="exist"></div></td>
							<td><f:hidden path="allotedList[${loop.count}].dressId"
									style="width: 27px;" id="dressId${loop.count}"
									value="${list.dressId}" /></td>
						</tr>
						<tr>
							<td style="width: 72px;"><span style="padding-left: 6px;"><font size="2">Amount:</font></span></td>
							<td><input name="amount" readonly="readonly"
								id="amount${loop.count}" placeholder="Amount" />
								<div id="exist"></div></td>
							<td></td>
						</tr>
						<tr>
							<td colspan="3"><div id="msg${loop.count}"></div></td>
						</tr>
					</table>
				</fieldset>
			</c:forEach>

			<div id="moredress12"></div>

			<div id="moredress13"></div>

			<div
				style="float: left; width: 800px; height: 0px; text-align: center; margin-top: 10px;">
				<button type="submit" class="btn"
					style="margin-top: -2px; width: 100px;">
					<b>Save</b>
				</button>
				<input type="hidden" id="moreId" value="12"> <input
					name="studentId" type="hidden" id="studentId"><a
					id="morelink" href="javascript:addmore();"
					style="margin-top: 10px;">+Add More</a> <a id="removelink"
					href="javascript:removemore();" style="margin-top: 10px;"><span
					style="width: 100px; text-align: center;"
					class="label label-important">Remove</span></a>

			</div>
		</f:form>
	</div>
</div>


