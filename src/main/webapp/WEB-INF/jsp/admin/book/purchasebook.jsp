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

.editbox {
	display: none;
	background-color: white;
	border: 1px solid grey;
	width: 550px;
	height: 500px;
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
</style>

<script>
	function getTotalPrice(price) {
		var q = $("#boughtQuantity").val();
		$("#totalPrice").val(q * price);

	}

	function editpurchases(id) {
		$("#appendBookPurchaseId").empty();
		$("#validationmsg").empty();

		$
				.ajax({
					type : "post",
					url : 'getBookPurchasebyId',
					data : {
						'bookPurchaseId' : +id
					},
					success : function(data) {
						var obj = JSON.parse(data);

						$("#appendBookPurchaseId")
								.append(
										'<input type="hidden" name="bookPurchaseId" value="'+id+'"/>');
						$("#newdateOfPurchase").val(obj.dateOfPurchase);
						$("#editbookTitle").val(obj.bookTitle);
						$("#editclassId").val(obj.classId);
						$("#editamount").val(obj.amount);
						$("#editPrice").val(obj.bookPrice);
						$("#edittotalPrice").val(
								obj.bookPrice * obj.boughtQuantity);
						$("#editsupplierName").val(obj.supplierName);
						$("#editquantity").val(obj.boughtQuantity);
						$("#editessionId").val(obj.sessionId);
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
	function removezero() {
		var quantity = $("#boughtQuantity").val();
		if (quantity == 0)
			$("#boughtQuantity").val('');
		var price = $("#bookPrice").val();
		if (price == 0)
			$("#bookPrice").val('');
		var amount = $("#amount").val();
		if (amount == 0)
			$("#amount").val('');
	}
	function validateData() {
		var flage = true;
		var regex1 = /^[1-9][0-9]*$/;
		var regex2 = /^[a-zA-Z ]+$/;
		$("#quantitymsg").empty();
		$("#titlemsg").empty();
		$("#shopmsg").empty();
		$("#amountmsg").empty();
		$("#pricemsg").empty();
		if (!regex2.test($("#bookTitle").val())) {
			$("#titlemsg")
					.append(
							'<span><font color="red" size="2">*Enter only letters</font></span>');
			flage = false;
		}

		else if (!regex1.test($("#boughtQuantity").val())) {
			$("#quantitymsg")
					.append(
							'<span><font color="red" size="2">* Quantity should be greater than zero and Enter only numeric value in quantity</font></span>');
			flage = false;
		} else if (!regex1.test($("#amount").val())) {
			$("#amountmsg")
					.append(
							'<span><font color="red" size="2">* Amount should be greater than zero and Enter only numeric value in amount</font></span>');
			flage = false;
		} else if (!regex1.test($("#bookPrice").val())) {
			$("#pricemsg")
					.append(
							'<span><font color="red" size="2">* Price Should be greater than zero and Enter only numeric value in price</font></span>');
			flage = false;
		} else if (!regex2.test($("#supplierName").val())) {
			$("#shopmsg")
					.append(
							'<span><font color="red" size="2">*Enter only letters</font></span>');
			flage = false;
		}
		return flage;
	}

	function editedvalidate() {
		var regex1 = /^[1-9][0-9]*$/;
		var regex2 = /^[a-zA-Z ]+$/;
		var flage = true;
		$("#editbookTitlemsg").val('');
		$("#editamountmsg").empty();
		$("#editpricemsg").empty();
		$("#editquantitymsg").empty();
		$("#editshopmsg").empty();
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
		} else if (!regex2.test($("#editsupplierName").val())) {
			$("#editshopmsg")
					.append(
							'<span><font color="red" size="2">*Enter only letters</font></span>');
			flage = false;
		} else if (!regex1.test($("#editPrice").val())) {
			$("#editpricemsg")
					.append(
							'<span><font color="red" size="2">*Price Should be greater than zero and Enter only numeric value in price</font></span>');
			flage = false;
		}
		return flage;
	}
	function changetotal(price) {
		var q = $("#editquantity").val();
		$("#edittotalPrice").val(q * price);
	}
	function getAmountupdate(quantity)
	{
		var price=$("#bookPrice").val();
		if(price>0)
			{
			$("#totalPrice").val(quantity * price);
			}
	}
	function getEditAmountupdate(editQuantity)
	{
		var price=$("#editPrice").val();
		if(price>0)
			{
			$("#edittotalPrice").val(editQuantity * price);
			}
	}
	
</script>
<div class="editbox">
	<div class="editbox-header">
		<a href="javascript:hideeditbox();" class="close" data-dismiss="modal"
			style="margin-right: 10px; margin-top: 10px;" aria-hidden="true">×</a>
		<h3 id="myModalLabel">Edit Purchased Book Details</h3>
	</div>
	<f:form commandName="BookPurchaseDTO" action="edit-book-purchase.html"
		id="submitform" onsubmit="return editedvalidate();">
		<div class="row-fluid" style="margin-top: 20px;">
			<div class="block-fluid">
				<div id="appendBookPurchaseId"></div>
				<table>
					<tr>
						<td style="padding-left: 20px; padding-right: 21px;">Date of
							Purchase<font color="red">*</font>
						</td>
						<td><input id="newdateOfPurchase"
							class="datepicker validate[required]" required="required"
							name="dateOfPurchase"
							style="width: 195px; border: 1px solid lightgray;" /></td>
						<td></td>
					</tr>
					<tr>
						<td style="padding-left: 20px; padding-right: 21px;"><span>Session
								<font color="red">*</font> :
						</span></td>
						<td><f:select path="sessionId" class="form-control input-sm"
								style="width: 200px;" id="editsessionId"
								x-data-toggle-x="tooltip"
								title="Specify the session of the student" required="required"
								data-original-title="Specify session">
								<c:forEach var="list" items="${sessionList}">
									<f:option value="${list.sessionId}">${list.sessionDuration}</f:option>
								</c:forEach>
							</f:select></td>
						<td><div id="sessionmsg"></div></td>
					</tr>

					<tr>
						<td style="padding-left: 20px; padding-right: 21px;"><span>Class
								<font color="red">*</font> :
						</span></td>
						<td><f:select path="classId" class="form-control input-sm"
								id="editclassId" x-data-toggle-x="tooltip" required="required"
								title="Specify the class of the student" style="width:200px;"
								data-original-title="Specifyclass">
								<option value="">Select a class</option>
								<c:forEach var="list" items="${classList}">
									<f:option value="${list.classId}">${list.className}</f:option>
								</c:forEach>
							</f:select></td>
						<td><div id="classmsg"></div></td>
					</tr>


					<tr>
						<td style="padding-left: 20px; padding-right: 21px;"><span>Book
								Title<font color="red">*</font> :
						</span></td>
						<td><f:input id="editbookTitle" maxlength="35"
								required="required" path="bookTitle" style="width:200px;" /></td>
						<td><div id="editbookTitlemsg"></div></td>
					</tr>

					<tr>
						<td style="padding-left: 20px; padding-right: 21px;"><span>Quantity<font
								color="red">*</font> :
						</span></td>
						<td><f:input id="editquantity" maxlength="6" oninput="getEditAmountupdate(this.value);"
								required="required" path="boughtQuantity" style="width:200px;" /></td>
						<td><div id="editquantitymsg"></div></td>
					</tr>
					<tr>
						<td><span style="padding-left: 20px; padding-right: 21px;">Total
								Cost Amount <font color="red">*</font> :
						</span></td>
						<td><f:input id="editamount" maxlength="7" path="amount"
								required="required" style="width:200px;" /></td>
						<td><div id="editamountmsg"></div></td>
					</tr>
					<tr>
						<td style="padding-left: 20px; padding-right: 21px;"><span>
								Selling Price per book<font color="red">*</font> :
						</span></td>
						<td><f:input id="editPrice" maxlength="4" required="required"
								class="validate[required,custom[integer]]"
								oninput="changetotal(this.value);" path="bookPrice"
								style="width:200px;" /></td>
						<td><div id="editpricemsg"></div></td>
					</tr>

					<tr>
						<td style="padding-left: 20px; padding-right: 21px;"><span>Total
								Selling Amount<font color="red">*</font> :
						</span></td>
						<td><input id="edittotalPrice" maxlength="35"
							name="totalPrice" readonly="readonly"
							style="width: 195px; border: 1px solid lightgray;"></td>
						<td></td>
					</tr>
					<tr>
						<td style="padding-left: 20px; padding-right: 21px;"><span>Supplier
								name:<font color="red">*</font>
						</span></td>
						<td><f:input id="editsupplierName" maxlength="35"
								path="supplierName" required="required" style="width:200px;" /></td>
						<td><div id="editshopmsg"></div></td>
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
		<img alt="Show_settings" src="${img_url}/book1.jpg"
			style="width: 50px; margin-top: -12px;">
		<h1>Purchased Book Details</h1>
		<h3>Manage Books</h3>
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
	<table style="width: 1059px; height: 200px;">
		<f:form action="save-BookPurchases" id="submitform"
			onsubmit="return validateData();" commandName="BookPurchaseDTO"
			method="POST">
			<tr>
				<td style="width: 200px;">Product Number</td>
				<td><input id="productNo" maxlength="35" name="productNo"
					readonly="readonly"
					style="width: 245px; border: 1px solid lightgray;"
					value="${productNo}"></td>
				<td></td>
			</tr>
			<tr>
				<td style="width: 200px;">Date</td>
				<td style="width: 272px;"><input id="dateOfPurchase"
					maxlength="35" name="dateOfPurchase" readonly="readonly"
					style="width: 245px; border: 1px solid lightgray;"
					class="datepicker validate[required]" value="${currentDate}"></td>
				<td style="width: 79px;"></td>
				<td></td>
			</tr>
			<tr>
				<td style="width: 200px;">Session</td>
				<td><f:select path="sessionId" class="form-control input-sm"
						id="sessionId" x-data-toggle-x="tooltip"
						title="Specify the session of the student" required="required"
						style="width: 250px;" data-original-title="Specify session">
						<c:forEach var="list" items="${sessionList}">
							<c:choose>
								<c:when test="${current.sessionId==list.sessionId}">
									<f:option selected="selected" value="${list.sessionId}">${list.sessionDuration}</f:option>
								</c:when>
								<c:otherwise>
									<f:option value="${list.sessionId}">${list.sessionDuration}</f:option>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</f:select></td>
				<td><div id="sessionmsg"></div></td>
			</tr>
			<tr>
				<td style="width: 200px;">Class</td>
				<td><f:select path="classId" class="form-control input-sm"
						id="classId" x-data-toggle-x="tooltip" required="required"
						title="Specify the class of the student" style="width: 250px;"
						data-original-title="Specifyclass">
						<option value="">Select a class</option>
						<c:forEach var="list" items="${classList}">
							<f:option value="${list.classId}">${list.className}</f:option>
						</c:forEach>
					</f:select></td>
				<td><div id="classmsg"></div></td>
			</tr>

			<tr>
				<td style="width: 200px;">Book Title</td>
				<td><f:input id="bookTitle" maxlength="35" path="bookTitle"
						style="width: 250px;" required="required" /></td>
				<td colspan="2"><div id="titlemsg"></div></td>
			</tr>
			<tr>
				<td style="width: 200px;">Quantity</td>
				<td><f:input id="boughtQuantity" maxlength="35"
						onclick="removezero();" path="boughtQuantity" oninput="getAmountupdate(this.value);"
						style="width: 250px;" required="required" /></td>
				<td colspan="2"><div id="quantitymsg"></div></td>

			</tr>
			<tr>
				<td style="width: 200px;">Amount</td>
				<td><f:input id="amount" maxlength="35" path="amount"
						onclick="removezero();" required="required" style="width: 250px;" /></td>
				<td colspan="2"><div id="amountmsg"></div></td>

			</tr>
			<tr>
				<td style="width: 200px;">Selling Price per book</td>
				<td><f:input id="bookPrice" maxlength="35"
						onclick="removezero();" required="required" path="bookPrice"
						oninput="getTotalPrice(this.value);" style="width: 250px;" /></td>
				<td colspan="2"><div id="pricemsg"></div></td>

			</tr>
			<tr>
				<td style="width: 200px;">Total Price</td>
				<td><input id="totalPrice" maxlength="35" name="totalPrice"
					value="0" readonly="readonly"
					style="width: 245px; border: 1px solid lightgray;"></td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td style="width: 200px;">Supplier Name</td>
				<td><input id="supplierName" maxlength="35" name="supplierName"
					required="required" style="width: 243px;"></td>
				<td><div id="shopmsg"></div></td>
				<td></td>
			</tr>
			<tr>

				<td></td>
				<td><input type="submit" id="Allot" name="submit" value="Save"
					class="btn btn-primary" style="margin-top: 10px;"></td>
			</tr>
		</f:form>
	</table>
	<c:if test="${msg!=null}">
		<div class="failedmsg">${msg}</div>
	</c:if>

	<div class="separator"></div>

	<div id="showcategories">
		<c:if test="${!purchaseList.isEmpty()}">

			<div class="span12" style="margin-left: 0px; width: 1059px;"></div>
			<div style="padding: 10px 0 0;" class="widget-body">
				<div class="block">
					<div class="head blue">
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

					<div id="purchases">
						<table class="table fTable lcnp" style="width: 1059px;">
							<thead>
								<tr>
									<th>S No</th>
									<th>Date</th>
									<th>Product No.</th>
									<th>Title</th>
									<th>Class</th>
									<th>Quantity</th>
									<th>Amount</th>
									<th>Price</th>
									<th>Supplier Name</th>
									<th>Operations</th>
									<th>Operations</th>

								</tr>
							</thead>
							<tbody>
								<c:forEach var="list" items="${purchaseList}" varStatus="loop">
									<tr>
										<td class="center"><font size="2">${loop.count}</font></td>
										<td class="center"><font size="2">${list.dateOfPurchase}</font></td>
										<td class="center"><font size="2">${list.productNo}</font></td>
										<td class="center"><font size="2">${list.bookTitle}</font></td>
										<td class="center"><font size="2">${list.className}</font></td>
										<td class="center"><font size="2">${list.boughtQuantity}</font></td>
										<td class="center"><font size="2">${list.amount}</font></td>
										<td class="center"><font size="2">${list.bookPrice}</font></td>
										<td class="center"><font size="2">${list.supplierName}</font></td>
										<td class="center"><font size="2"><a
												href="javascript:editpurchases('${list.bookPurchaseId}')"><span
													class="label label-success">Edit</span></a></font></td>
										<td class="center"><font size="2"><a
												href="deletebookpurchases?id=${list.bookPurchaseId}"><span
													class="label label-important">Delete</span></a></font></td>

									</tr>
								</c:forEach>

							</tbody>
						</table>
					</div>
				</div>
			</div>
		</c:if>
	</div>
	<div class="separator"></div>
</div>