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
<script>
	function getCategory(id) {
		$.ajax({
			type : "post",
			url : 'getdressCategory/' + id,
			success : function(data, status) {
				$("#category").empty();
				var j = JSON.parse(data);
				var content = '<option value="">Select Category</option>';
				for ( var i = 0; i < j.length; i++) {
					content += '<option value='+j[i].dressId+'>'
							+ j[i].category + '</option>';
				}
				$("#category").append(content);
			},
			error : function(e) {

			}
		});
	}
	function getSize(id) {
		$.ajax({
			type : "post",
			url : 'getdressSize/' + id,
			success : function(data, status) {
				$("#size").empty();
				var j = JSON.parse(data);
				var content = '<option value="">Select Size</option>';
				for ( var i = 0; i < j.length; i++) {
					content += '<option value='+j[i].dressId+'>' + j[i].size
							+ '</option>';
				}
				$("#size").append(content);
			},
			error : function(e) {

			}
		});
	}
	function getPrice(id) {
		$.ajax({
			type : "post",
			url : 'getdressPrice/' + id,
			success : function(data, status) {
				$("#price").val('');
				var j = JSON.parse(data);
				$("#price").val(j.price);
				$("#dressId").val(j.dressId);
			},
			error : function(e) {

			}
		});

	}
	function getNamesList(id) {
		$("#firstId").val('');
		$("#Student").empty();
		$
				.ajax({
					type : "post",
					url : 'getNamesList/' + id,
					success : function(data, status) {
						$("#firstname").empty();
						var j = JSON.parse(data);
						var content = '';
						var st = '';
						for ( var i = 0; i < j.length; i++) {
							content += '<option value='+j[i].firstName+' id='+j[i].admissionNo+'>';

						}
						$("#firstname").append(content);

					},
					error : function(e) {

					}
				});
	}

	function getstudentsdata(name) {
		var c_id = 0;
		var CompanyName = $("#firstId").val();

		c_id = $('#firstname').find('option[value="' + CompanyName + '"]')
				.attr('id');
		$('#studentId').val(c_id);

		$
				.ajax({
					type : "post",
					url : 'getstudentsdata/' + c_id,
					success : function(data, status) {
						$("#Student").empty();
						var j = JSON.parse(data);
						var st = '';
						st = '<div id="box" style="border: 1px solid; border-radius: 10px; height: 206px; width: 541px; margin-left: -139px; background-color:lightyellow;">';
						st += '<table style="width: 501px; margin-left: 40px; margin-top: 35px;"><tr><td><b>Name :</b></td><td style="width: 365px;">'
								+ j.firstName
								+ '\t'
								+ j.middleName
								+ '\t'
								+ j.lastName
								+ '</td></tr><tr><td><b>Father Name:</b></td><td style="width: 365px;">'
								+ j.fatherName
								+ '</td><tr><td><b>Roll No.:</b></td><td style="width: 365px;">'
								+ j.rollno
								+ '</td></tr><tr><td><b>Class:</b></td><td style="width: 365px;">'
								+ j.className
								+ '</td><tr><td><b>Section:</b></td><td style="width: 365px;">'
								+ j.sectionName
								+ '</td></tr><tr><td><b>Mobile No:</b></td><td style="width: 365px;">'
								+ j.mobile + '</td></tr></div>';

						$("#Student").append(st);
					},
					error : function(e) {

					}
				});
	}
	function savedata() {
		$("#finals").empty();
		$("#feeCategoryNamemsg").empty();
		var classId = $("#class").val();
		var firstname = $("#studentId").val();
		var dressName = $("#dressName").val();
		var category = $("#category").val();
		var size = $("#size").val();
		var quantity = $("#quantity").val();
		var dressId = $("#dressId").val();
		var flage = true;

		var regex1 = /^[0-9]*$/;
		if ($("#quantity").val() == '') {
			$("#feeCategoryNamemsg").append(
					'<font color="red">All values are required</font>');
			flage = false;
		} else if (!regex1.test($("#quantity").val())) {
			$("#feeCategoryNamemsg")
					.append(
							'<font color="red">Enter only numeric value in quantity</font>');
			flage = false;
		}
		if ($("#firstname").val() == '') {
			$("#feeCategoryNamemsg").append(
					'<font color="red">Enter Firstname and </font>');
			flage = false;
		}
		if ((classId == '') || (firstname == '') || (dressName == '')
				|| (category == '') || (size == '')) {
			$("#feeCategoryNamemsg").empty();
			flage = false;
			$("#feeCategoryNamemsg").append(
					'<font color="red">All values are required</font>');
		}
		if (flage == true) {
			$("#class").hide();
			$("#firstId").hide();
			$("#s").hide();
			$("#n").hide();
			$("#dressName").val('');
			$("#category").val('');
			$("#size").val('');
			$("#price").val('');
			$("#quantity").val('');
			$("#firstId").val('');

			var total = '0';
			var url = 'savealloteddress/' + dressId + '/' + quantity;
			$
					.ajax({
						url : url,

						type : 'POST',
						success : function(data, status) {

							$("#dressDetails").empty();
							var j = JSON.parse(data);
							var st = "";
							var length = j.length;
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
							st += '</table><button class="btn btn-success" id="paybutton"style="margin-left: 415px; margin-top: 22px;" type="button"onclick="payment('
									+ total + ');">Proceed to Payment</button>';
							$("#dressDetails").append(st);

						},
						error : function(error, status) {
						}
					});
		}
	}
	function payment(total) {
		$('#paybutton').hide();

		var st = '<div id="finals"><div id="box" style="border: 1px solid; border-radius: 10px; width: 1060px; height: 150px;"><table style="width: 1006px; margin-top: 24px;"><tr><td>Total amount:</td><td> <input type="text" name="totalAmount" id="totalAmount" readonly="readonly" value='+total+'></td><td></td>'
				+ '<td>Discount in % <input type="radio" onclick="disAmountType();" name="dis" value="per" id="per">/ Rs <input type="radio" onclick="disAmountType();" name="dis" id="rs" value="rs"></td><td>'
				+ '<input type="text" id="disAmount" onkeyup="getDiscount(this.value)"style="width: 79px;"></td><td</tr> '
				+ '<tr><td><span>Net Payable Amount</span></td><td><input type="text" name="netPayableAmount" id="discountAmount" readonly="readonly" value='+total+'></td><td></td>'
				+ '<td><span>In Words-</span></td><td style=" width: 308px;" ><input type="text" name="paidAmountInWord" value="0" id="paidAmountInWord" style="height: 32px; width: 311px;"  readonly="readonly"></td><td>/-Only</td></tr>'
				+ '<tr><td colspan="6"></td></tr><tr><td></td><td></td><td></td><td><button class="btn btn-success" type="button"onclick="generatepdf();">Submit</button></td><td></td<td></td></tr></table></div></div>';
		$("#pays").append(st);
		converttowords(total);
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
							$("#Student").empty();
							$("#class").show();
							$("#firstId").show();
							$("#s").show();
							$("#n").show();
							$('#studentId').val('');
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

							st += '</table>';

							st += '<button class="btn btn-success" id="paybutton"style="margin-left: 415px; margin-top: 22px;" type="button"onclick="payment('
									+ total + ');">Proceed to Payment</button>';

							$("#dressDetails").append(st);
						}

					},
					error : function(error, status) {
					}
				});
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
		} else {
			alert('Select Discount Type');
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
		var studentId = $('#studentId').val();
		var paid = $("#discountAmount").val();
		var paidwords = $("#paidAmountInWord").val();
		var total = $('#totalAmount').val();
		document.location.href = 'submitdressdata?id=' + paid + '&id2='
				+ paidwords + '&id3=' + studentId + '&total=' + total;

	}
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
		<div class="span5">
			<div class="block" style="left: -188px;">
				<table
					style="width: 700px; height: 0px; margin-left: 231px; margin-top: 0px;">
					<tr>
						<td style="width: 200px;"><span id="s">Class</span></td>
						<td><select id="class" class="validate[required]"
							onchange="getNamesList(this.value);" style="width: 250px;"
							name="classId" class="select">
								<option value="">Select a class</option>
								<c:forEach var="list" items="${classList}">
									<option value="${list.classId}">${list.className}</option>
								</c:forEach>
						</select></td>
					</tr>
					<tr>
						<td style="width: 72px;"><span id="n">Name:</span></td>
						<td><input name="firstname" required="required"
							title="Enter firstName" id="firstId" list="firstname"
							placeholder="Enter Name" maxlength="15" style="width: 245px;"
							onblur="getstudentsdata(this.value);"> <datalist
								id="firstname" class="select">
								<option value="">
							</datalist>
							<div id="exist"></div></td>
						<td></td>
					</tr>
					<tr>
						<td style="width: 72px;">Dress Name</td>
						<td><select id="dressName" required="required"
							onchange="getCategory(this.value);" style="width: 250px;"
							name="dressName">
								<option value="">Select Dress</option>
								<c:forEach var="list" items="${dresslists}">
									<option value="${list.dressId}">${list.dressName}</option>
								</c:forEach>
						</select></td>
						<td></td>
					</tr>
					<tr>
						<td style="width: 72px;">Category</td>
						<td><select id="category" onchange="getSize(this.value);"
							style="width: 250px;" name="category">
								<option value="">Select a category</option>
						</select></td>
						<td></td>

					</tr>
					<tr>
						<td style="width: 72px;">Size</td>
						<td><select id="size" onchange="getPrice(this.value);"
							style="width: 250px;" name="size">
								<option value="">Select a size</option>
						</select></td>
						<td></td>

					</tr>
					<tr>
						<td style="width: 72px;">Price:</td>
						<td><input name="price" required="required"
							readonly="readonly" id="price" style="width: 250px;">
							<div id="exist"></div></td>
						<td><input type="hidden" name="dressId" id="dressId"></td>
					</tr>
					<tr>
						<td style="width: 72px;">Quantity:</td>
						<td><input name="quantity" required="required" id="quantity"
							placeholder="Enter Quantity" style="width: 250px;">
							<div id="exist"></div></td>
						<td></td>
					</tr>
					<tr>
						<td style="width: 72px;"></td>
						<td><button class="btn btn-primary" type="button"
								onclick="javascript:savedata();"
								style="width: 78px; margin-top: 10px; margin-left: 175px;">Save</button>
							<div id="exist"></div></td>
						<td><input type="hidden" id="studentId" /></td>
					</tr>
				</table>

			</div>
		</div>
		<div class="span5">
			<div class="block" style="margin-left: 192px;">
				<div id="Student"></div>
			</div>
		</div>
	</div>
	<div class="separator"></div>
	<div id="feeCategoryNamemsg"></div>

	<div id="up">
		<div class="row-fluid">
			<div class="span12">
				<div class="block">
					<div class="head blue" style="margin-top: 18px;">
						<div class="icon">
							<span class="ico-pen-2"></span>
						</div>
						<h2>Selected Dress Details</h2>
					</div>
					<div class="data-fluid" id="dressDetails"></div>
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
</div>
