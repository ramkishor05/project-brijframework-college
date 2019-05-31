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
	function getUniformWiseCategory(name) {
		$("#pricemsg").empty();
		$("#uniformCategory").empty();

		$.ajax({
			type : "post",
			url : 'getUniformWiseCategory',
			data : {
				'name' : name
			},
			success : function(data, status) {

				var j = JSON.parse(data);
				var content = '<option value="">Select a Category</option>';
				for ( var i = 0; i < j.length; i++) {
					content += '<option value='+j[i]+'>' + j[i] + '</option>';
				}
				$("#uniformCategory").append(content);
			},
			error : function(e) {

			}
		});
	}
	function getCategoryWiseSize(category) {
 var name=$("#uniformName").val();
	$("#pricemsg").empty();
		$("#uniformSize").empty();
		$.ajax({
			type : "post",
			url : 'getCategoryWiseSize',
			data : {
				'category' : category,
				'name':name,
			},
			success : function(data, status) {

				var j = JSON.parse(data);
				var content = '<option value="">Select a Size</option>';
				for ( var i = 0; i < j.length; i++) {
					content += '<option value='+j[i]+'>' + j[i] + '</option>';
				}
				$("#uniformSize").append(content);
			},
			error : function(e) {

			}
		});
	}
	function getTotalPrice(price) {
		var q = $("#boughtQuantity").val();
		$("#totalPrice").val(q * price);

	}
	function addnewName() {
		$("#uniformCategory").empty();
		$("#uniformSize").empty();
		$("#pricemsg").empty();
		$("#newname").empty();
		$("#newname")
				.append(
						'<input type="text" name="newuniform" id="newuniform" maxlength="20" oninput="validateName(this.value);" value="" onblur="saveNewName(this.value);"/>');
	}
	function saveNewName(name) {
		if (name != '') {
			$("#uniformName").append(
					'<option selected="selected" value="'+name+'">' + name
							+ '</option>');
			$("#newname").empty();
		}
	}
	function addnewcategory() {
		$("#uniformSize").empty();
		$("#pricemsg").empty();
		$("#newcategory").empty();
		$("#newcategory")
				.append(
						'<input type="text" name="newcategory" id="newcategory" maxlength="15"value="" onblur="saveNewCategory(this.value);"/>');
	}
	function saveNewCategory(category) {
		if (category != '') {

			$("#uniformCategory").append(
					'<option selected="selected" value="'+category+'">'
							+ category + '</option>');
			$("#newcategory").empty();
		}
	}
	function addnewsize() {
		$("#pricemsg").empty();
		$("#newsize").empty();
		$("#newsize")
				.append(
						'<input type="text" name="newsize" id="newsize" maxlength="15" value="" onblur="saveNewSize(this.value);"/>');
	}
	function saveNewSize(size) {
		if (size != '') {
			$("#uniformSize").append(
					'<option selected="selected" value="'+size+'">' + size
							+ '</option>');
			$("#newsize").empty();
		}
	}
	function addnewshop() {
		$("#newshop").empty();
		$("#newshop")
				.append(
						'<input type="text" name="newshop" id="newshop" value="" onblur="saveNewShop(this.value);"/>');
	}
	function saveNewShop(shop) {

		$("#shopName").append(
				'<option selected="selected" value="'+shop+'">' + shop
						+ '</option>');
		$("#newshop").empty();
	}
	function editpurchases(id) {
		$("#appendDressPurchaseId").empty();
		$("#validationmsg").empty();

		$
				.ajax({
					type : "post",
					url : 'getUniformPurchasebyId',
					data : {
						'productPurchaseId' : +id
					},
					success : function(data) {
						var obj = JSON.parse(data);

						$("#appendDressPurchaseId")
								.append(
										'<input type="hidden" name="productPurchaseId" value="'+id+'"/>');
						$("#newdateOfPurchase").val(obj.dateOfPurchase);
						$("#edituniformName").val(obj.uniformName);
						$("#edituniformCategory").val(obj.uniformCategory);
						$("#edituniformSize").val(obj.uniformSize);
						$("#editamount").val(obj.amount);
						$("#editPrice").val(obj.uniformPrice);
						$("#edittotalPrice").val(
								obj.uniformPrice * obj.boughtQuantity);
						$("#editshopName").val(obj.shopName);
						$("#editquantity").val(obj.boughtQuantity);

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
		var price = $("#uniformPrice").val();
		if (price == 0)
			$("#uniformPrice").val('');
		var amount = $("#amount").val();
		if (amount == 0)
			$("#amount").val('');
	}
	function validateData() {
		var flage = true;
		var regex1 = /^[0-9]*$/;
		$("#quantitymsg").empty();
		$("#amountmsg").empty();
		$("#pricemsg").empty();
		if (!regex1.test($("#boughtQuantity").val())) {
			$("#quantitymsg")
					.append(
							'<span><font color="red" size="2">*Quantity should be greater than zero and Enter only numeric value in quantity</font></span>');
			flage = false;
		} else if (!regex1.test($("#amount").val())) {
			$("#amountmsg")
					.append(
							'<span><font color="red" size="2">*Amount should be greater than zero and Enter only numeric value in amount</font></span>');
			flage = false;
		} else if (!regex1.test($("#uniformPrice").val())) {
			$("#pricemsg")
					.append(
							'<span><font color="red" size="2">*Price Should be greater than zero and Enter only numeric value in price</font></span>');
			flage = false;
		}

		return flage;
	}
	function validateName(name) {
		$("#namemsg").empty();
		var regex1 = /^[a-zA-Z ]+$/;
		if (!regex1.test(name)) {
			$("#namemsg").append('<font color="red">Enter only Letters</font>');
			$("#newuniform").val('');
		}

	}
	function editedvalidate() {
		var regex1 = /^[1-9][0-9]*$/;
		var regex2 = /^[a-zA-Z ]+$/;
		var flage = true;
		$("#editname").empty();
		$("#editamountmsg").empty();
		$("#editpricemsg").empty();
		$("#editquantitymsg").empty();
		$("#editshopmsg").empty();
		if (!regex2.test($("#edituniformName").val())) {
			$("#editname")
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
		} 
		else if (!regex2.test($("#editshopName").val())) {
			$("#editshopmsg")
					.append(
							'<span><font color="red" size="2">*Enter only letters</font></span>');
			flage = false;
		}
		else if (!regex1.test($("#editPrice").val())) {
			$("#editpricemsg")
					.append(
							'<span><font color="red" size="2">*Price Should be greater than zero and Enter only numeric value in price</font></span>');
			flage = false;
		}
return flage;
	}
	function changetotal(price)
	{
		var q = $("#editquantity").val();
		$("#edittotalPrice").val(q * price);
	}
	function getPrice(size) {
	var content='';
		var category = $("#uniformCategory").val();
		var name = $("#uniformName").val();
		$
				.ajax({
					type : "post",
					url : 'getPriceforUniform',
					data : {
						'category' : category,
						'name' : name,
						'size' : size,
					},
					success : function(data, status) {
						
						var j = JSON.parse(data);
						if(j.uniformPrice==0)
							{
							content='';
							}
						else
							{
							content='Current price is Rs '+j.uniformPrice;
							}
						$("#pricemsg").append(content);
					},
					error : function(e) {

					}
				});

	}
	function getAmountupdate(quantity)
	{
		var price=$("#uniformPrice").val();
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
		<h3 id="myModalLabel">Edit Purchased Uniform Details</h3>
	</div>
	<f:form commandName="UniformPurchaseDTO"
		action="edit-uniform-purchase.html" id="submitform"
		onsubmit="return editedvalidate();">
		<div class="row-fluid" style="margin-top: 20px;">
			<div class="block-fluid">
				<div id="appendDressPurchaseId"></div>
				<table>
					<tr>
						<td style="padding-left: 20px; padding-right: 21px;">Date of
							Purchase<font color="red">*</font>
						</td>
						<td><input id="newdateOfPurchase"
							class="datepicker validate[required]" required="required"
							name="dateOfPurchase" style="width: 195px;border: 1px solid lightgray;" /></td>
						<td></td>
					</tr>
					<tr>
						<td style="padding-left: 20px; padding-right: 21px;"><span>Uniform
								name<font color="red">*</font> :
						</span></td>
						<td><f:input id="edituniformName" maxlength="20"
								required="required" path="uniformName" style="width:200px;" /></td>
						<td><div id="editname"></div></td>
					</tr>

					<tr>
						<td style="padding-left: 20px; padding-right: 21px;"><span>Uniform
								Category<font color="red">*</font> :
						</span></td>
						<td><f:input id="edituniformCategory" maxlength="15"
								required="required" path="uniformCategory" style="width:200px;" /></td><td></td>
					</tr>
					<tr>
						<td style="padding-left: 20px; padding-right: 21px;"><span
							class="top title">Uniform size<font color="red">*</font> :
						</span></td>
						<td><f:input id="edituniformSize" maxlength="10"
								required="required" path="uniformSize" style="width:200px;" /></td><td></td>
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
						<td><span style="padding-left: 20px; padding-right: 21px;">Total Cost Amount <font
								color="red">*</font> :
						</span></td>
						<td><f:input id="editamount" maxlength="7" path="amount"
								required="required" style="width:200px;" /></td>
						<td><div id="editamountmsg"></div></td>
					</tr>
					<tr>
						<td style="padding-left: 20px; padding-right: 21px;"><span> Selling Price
								per uniform<font color="red">*</font> :
						</span></td>
						<td><f:input id="editPrice" maxlength="4" required="required" class="validate[required,custom[integer]]"
							oninput="changetotal(this.value);" path="uniformPrice" style="width:200px;" /></td>
						<td><div id="editpricemsg"></div></td>
					</tr>

					<tr>
						<td style="padding-left: 20px; padding-right: 21px;"><span>Total
							Selling	Amount<font color="red">*</font> :
						</span></td>
						<td><input id="edittotalPrice" maxlength="35"
							name="totalPrice" readonly="readonly" style="width: 195px; border: 1px solid lightgray;"></td><td></td>
					</tr>
					<tr>
						<td style="padding-left: 20px; padding-right: 21px;"><span>Shop
								name:<font color="red">*</font>
						</span></td>
						<td><f:input id="editshopName" maxlength="35" path="shopName"
								required="required" style="width:200px;" /></td>
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
		<img alt="Show_settings" src="${img_url}/uniform.jpg"
			style="width: 50px; margin-top: -12px;">
		<h1>Purchased Uniform Details</h1>
		<h3>Manage Uniforms</h3>
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
		<f:form action="save-UniformPurchases" id="submitform"
			onsubmit="return validateData();" commandName="UniformPurchaseDTO">
			<tr>
				<td style="width: 200px;">Product Number</td>
				<td><input id="productNo" maxlength="35" name="productNo"
					readonly="readonly" style="width: 245px; border: 1px solid lightgray;" value="${productNo}"></td>
				<td></td>
			</tr>
			<tr>
				<td style="width: 200px;">Date</td>
				<td style="width: 272px;"><input id="dateOfPurchase"
					maxlength="35" name="dateOfPurchase" readonly="readonly"
					style="width: 245px; border: 1px solid lightgray;" class="datepicker validate[required]"
					value="${currentDate}"></td>
				<td style="width: 79px;"></td>
				<td></td>
			</tr>
			<tr>
				<td style="width: 200px;">Uniform Name</td>
				<td><f:select id="uniformName" required="required"
						onchange="getUniformWiseCategory(this.value);"
						style="width: 250px;" path="uniformName">
						<option value="">Select a Uniform</option>
						<c:forEach var="value" items="${uniformNames}">
							<f:option value="${value}">${value}</f:option>
						</c:forEach>
					</f:select></td>
				<td style="width: 79px;"><a href="javascript:addnewName()"><span
						class="label label-primary">+Add new</span></a></td>
				<td><div id="newname" style="width: 226px;"></div></td>
				<td><div id="namemsg"></div></td>
			</tr>

			<tr>
				<td style="width: 200px;">Uniform Category</td>
				<td><f:select id="uniformCategory" required="required"
						onchange="getCategoryWiseSize(this.value);" style="width: 250px;"
						path="uniformCategory">
						<option value="">Select a Category</option>
					</f:select></td>
				<td><a href="javascript:addnewcategory()"><span
						class="label label-primary">+Add new</span></a></td>
				<td><div id="newcategory" style="width: 226px;"></div></td>
				<td><div id="categorymsg"></div></td>
			</tr>
			<tr>
				<td style="width: 200px;">Uniform Size</td>
				<td><f:select id="uniformSize" required="required" onchange="getPrice(this.value);" 
						style="width: 250px;" path="uniformSize">
						<option value="">Select a Size</option>
					</f:select></td>
				<td><a href="javascript:addnewsize()"><span
						class="label label-primary">+Add new</span></a></td>
				<td><div id="newsize" style="width: 226px;"></div></td>
				<td><div id="sizemsg"></div></td>
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
				<td style="width: 200px;">Selling Price per uniform</td>
				<td><f:input id="uniformPrice" maxlength="35"
						onclick="removezero();" required="required" path="uniformPrice"
						oninput="getTotalPrice(this.value);" style="width: 250px;" /></td>
				<td colspan="2"><div id="pricemsg"></div></td>

			</tr>
			<tr>
				<td style="width: 200px;">Total Price</td>
				<td><input id="totalPrice" maxlength="35" name="totalPrice"
					value="0" readonly="readonly" style="width: 245px; border: 1px solid lightgray;"></td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td style="width: 200px;">Shop Name</td>
				<td><f:select id="shopName" required="required"
						style="width: 250px;" path="shopName">
						<option value="">Select a Shop</option>
						<c:forEach var="content" items="${shopNames}">
							<f:option value="${content}">${content}</f:option>
						</c:forEach>
					</f:select></td>
				<td><a href="javascript:addnewshop()"><span
						class="label label-primary">+Add new</span></a></td>
				<td><div id="newshop" style="width: 226px;"></div></td>
				<td><div id="shopmsg"></div></td>
			</tr>
			<tr>
			
				<td></td>
				<td><input type="submit" id="Allot" name="submit" value="Save" class="btn btn-success" style="margin-top:10px;"></td>
			</tr>
		</f:form>
	</table>
	<c:if test="${msg!=null}">
	<div class="successmsg">${msg}</div>
	</c:if>

	<div class="separator"></div>
	<div id="err" class="form-inline">
		<p id="v1"></p>
	</div>
	<div id="showcategories">
		<c:if test="${!purchaseList.isEmpty()}">

			<div class="span12" style="margin-left: 0px; width: 1059px;"></div>
			<div style="padding: 10px 0 0;" class="widget-body">
				<div class="block">
					<div class="head blue">
						<div class="icon">
							<span class="ico-pen-2"></span>
						</div>
						<h2>Uniform Purchase Details</h2>
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
									<th>Name</th>
									<th>Category</th>
									<th>Size</th>
									<th>Quantity</th>
									<th>Amount</th>
									<th>Price</th>
									<th>Shop Name</th>
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
										<td class="center"><font size="2">${list.uniformName}</font></td>
										<td class="center"><font size="2">${list.uniformCategory}</font></td>
										<td class="center"><font size="2">${list.uniformSize}</font></td>
										<td class="center"><font size="2">${list.boughtQuantity}</font></td>
										<td class="center"><font size="2">${list.amount}</font></td>
										<td class="center"><font size="2">${list.uniformPrice}</font></td>
										<td class="center"><font size="2">${list.shopName}</font></td>
										<td class="center"><font size="2"><a
												href="javascript:editpurchases('${list.productPurchaseId}')"><span
													class="label label-success">Edit</span></a></font></td>
										<td class="center"><font size="2"><a
												href="deletepurchases?id=${list.productPurchaseId}"><span
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