<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url value="/style/theme/images" var="imageurl" />
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/img" var="img_url" />
<spring:url value="/css" var="css_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/setting.css">
<style>
.stockbox {
	display: none;
	background-color:lightyellow;
	border: 1px solid grey;
	width: 625px;
	
	border-radius: 6px;
	margin-top: 160px;
	left: 220px;
	z-index: 1;
	position: absolute;
	
}

.stockbox-header {
	width: 625px;
	margin-top: -10px;
	border-bottom: 1px solid gray;
	height: 50px;
}
</style>

<script>
	function viewcategories(value) {
		var i=$("#totdress").val();
		for(var k=1;k<=i;k++)
			{
			$("." + k).fadeOut(1000);
			}
		
		$("#" + value).fadeIn(1000);
	}
	function hidecategories(value) {
		$("#s" + value).fadeOut(1000);
	}
	function hidename(value) {
		$("#" + value).fadeOut(1000);
	}
	function getSizeforCategory(count, category, name) {
		$("#s" + count).empty();
		$
				.ajax({
					type : "post",
					url : 'getCategoryWiseSize',
					data : {
						'category' : category,
						'name' : name,
					},
					success : function(data, status) {

						var j = JSON.parse(data);
						var content = '<div class="widget-body" style="padding: 10px 0px 0px; width: 267px; float: left; margin-left: 40px;"><div class="block" style="width: 352px;">'
								+ '<div class="head red" style="margin-left: 0px; width: 146px;"><div class="icon"><span class="ico-pen-2"></span></div><h2>Sizes</h2><ul class="buttons">'
								+ '<li><a href="javascript:hidecategories('
								+ count
								+ ');"><div class="icon"><span class="ico-cancel"></span></div></a></li></ul></div><div class="data-fluid" style="width: 173px;"><table class="table fTable lcnp">'
								+ '<thead></thead><tbody><tr><td><ul>';
						for ( var i = 0; i < j.length; i++) {
							content += '<li><a href=javascript:showdress("'
									+ name + '","' + category + '",' + j[i]
									+ '); >' + j[i] + '</a>&nbsp;&nbsp;<a href=javascript:showdresssold("'
									+ name + '","' + category + '",' + j[i]
									+ '); ><span class="label label-success" style="margin-left: 31px;">View details</span></a></li>'
						}
						content += '</ul></td></tr></tbody></table></div></div>';
						$("#s" + count).append(content);
						$("#s" + count).fadeIn(1000);
					},
					error : function(e) {

					}
				});

		//alert($("#dressId"+count).val());

	}

	function showdresssold(name, category, size) {
		$("#dresspurchased").empty();
		
		$
				.ajax({
					type : "post",
					url : 'showdresspurchased',
					data : {
						'name' : name,
						'category' : category,
						'size' : size,
					},
					success : function(data, status) {
						
						var j = JSON.parse(data);
						var st = "";
						var length = j.length;
						if (length == 0) {
							st = '<div class="failedmsg"><h5 align="center"><font color="red"><b>No Purchases in this session</b></font></h5></div>';
						} else {

							st = st
									+ '<div><div class="widget-body"  style="padding: 10px 0px 0px; margin-top: -50px;"><div class="separator"></div><div class="btn-group" style="width: 400px;">'
									+ '</div><div class="block"><div class="head blue"><h4 style="text-align:center">'+name+'&nbsp;'+category+'&nbsp;'+size+'</h4></div>'
									+ '<table class="table table-bordered table-primary"><thead><tr><th>S.no</th><th>Date</th><th>Supplier Name</th><th>Quantity</th><th>Amount</th><th>Net Amount</th></tr></thead><tbody>';
							for (var i = 0; i < length; i++) {
								st += '<tr><td>' + (i + 1) + '</td><td>'
										+ j[i].dateOfPurchase + '</td><td>'
										+ j[i].shopName + '</td><td>'
										+ j[i].boughtQuantity + '</td><td>'
										+ j[i].amount + '</td><td>'
										+ j[i].netAmount + '</td></tr>';
							}
							st += '</table>';
						}
						$("#dresspurchased").append(st);
						$(".stockbox").show();
					},
					error : function(error, status) {
					}
				});
	}
	function removedress(id,cl) {
		
		$("#" + id).empty();
		$("#"+cl).remove();
		$("#removedone").append(
				'<input id="quantity'+id+'" value="-" type="hidden">');
		var id = $("#getremove").val();
		if (id == 1) {
			$("#sbmt").hide();
		}
		$("#getremove").val(id - 1);
	}

	function addnewdress() {
		$("#newdress").empty();
		var st = 'Name <input type="text" name="newuniform" id="newuniform" maxlength="20"  value="" onblur="saveNewName(this.value);"/><div id="namemsg"></div>'
				+ 'Category <input type="text" name="newcategory" id="newcategory" maxlength="20"  value="" onblur="saveNewName(this.value);"/><div id="catgmsg"></div>'
				+ 'Size <input type="text" name="newsize" id="newsize" maxlength="20"  value=""/><div id="sizemsg"></div><a href="javascript:saveNewDress();"><span class="label label-success" style="width: 37px; margin-top: 16px; padding-left: 16px;">Add</span></a> ';
		$("#newdress").append(st);
	}
	function saveNewDress() {
		$("#namemsg").empty();
		$("#catgmsg").empty();
		$("#sizemsg").empty();
		var size=$("#newsize").val();
		var name = $("#newuniform").val();
		var category = $("#newcategory").val();
		var flag = true;
		var regex1 = /^[a-zA-Z ]+$/;
		if (!regex1.test(name)) {
			$("#namemsg").append(
					'<font color="red" siz="2">Enter only Letters</font>');
			$("#newsize").val('');
			flag = false;
		}
		if (!regex1.test(category)) {
			$("#catgmsg").append(
					'<font color="red" size="2">Enter only Letters</font>');
			$("#newsize").val('');
			flag = false;
		}

		if (flag == true) {
			$("#newdress").empty();
			showdress(name, category, size);
		}
	}

	function showdress(name, category, size) {
	var cl=name+category+size;
	var flag='';
		var unq = document.getElementById(cl);
		if(unq==null)
			flag=true;
		else
			{
			flag=false;
			alert("This uniform is already selected");
			}
		if(flag==true)
			{
				var cont='<input type="hidden" value="1" id="'+cl+'">';
				$("#uniquedress").append(cont);
			
		var id = $("#getnumber").val();
		var ids = $("#getremove").val();
		$
		.ajax({
			type : "post",
			url : 'getStockforDress',
			data : {
				'name' : name,
				'category' : category,
				'size' : size,
				
			},
			success : function(data, status) {
				var j=JSON.parse(data);
		   var st = '<div id="'+id+'" style="float:left;"><div class="widget-body" style="padding: 10px 0px 0px; width: 267px; float: left; margin-left: 40px;"><div class="block" style="width: 352px; height: 393px;">'
				+ '<div class="head dblue" style="margin-left: 0px; width: 281px;"><div class="icon"><span class="ico-pen-2"></span></div><h2>'
				+ category
				+ ' '
				+ name
				+ ' '
				+ size
				+ '</h2><ul class="buttons">'
				+ '<li><a href=javascript:removedress('
				+ id
				+ ',"'+cl+'");><div class="icon"><span class="ico-cancel"></span></div></a></li></ul></div><div class="data-fluid" style="width: 294px; height: 231px;"><table class="table fTable lcnp">'
				+ '<thead></thead><tbody>';

		st += '<tr><td colspan="2" style="color:green">Remaining Stock is:'+j+'</tr> <td style="width: 72px;"><span style="padding-left: 6px;"><font size="2">Quantity:</font></span></td><td><input name="allotedList['
				+ id
				+ '].quantity"onclick="getquantityclear('
				+ id
				+ ');"'
				+ 'oninput="getamount(this.value,'
				+ id
				+ ');" id="quantity'
				+ id
				+ '" placeholder="Enter Quantity" /></tr>'
				+ '<tr><td style="width: 72px;"><span style="padding-left: 6px;"><font size="2"> Gross Amount:</font></span></td><td><input name="allotedList['
				+ id
				+ '].amount"  value="0" id="amount'
				+ id
				+ '" oninput="getAmountCheck(this.value,'
				+ id
				+ ');" onclick="removeamountzero('
				+ id
				+ ');" placeholder="Amount"  />'
				+ '<div id="exist"></div></td></tr>'
				+ '<tr><td style="width: 72px;"><span style="padding-left: 6px;"><font size="2">Net Amount:</font></span></td><td><input name="allotedList['
				+ id
				+ '].netamount"  value="0" id="netamount'
				+ id
				+ '" oninput="getNetCheck(this.value,'
				+ id
				+ ');" onclick="removetotalzero('
				+ id
				+ ');" placeholder="Net Amount"  />'
				+ '<div id="exist"></div></td></tr>'
				+ '<tr><td style="width: 72px;"><span style="padding-left: 6px;"><font size="2"> Student Price</font></span></td><td><input name="allotedList['
				+ id
				+ '].price" value="0" id="price'
				+ id
				+ '" oninput="getTotalPrice(this.value,'
				+ id
				+ ');" onclick="removezero('
				+ id
				+ ');" placeholder="Price per uniform"  />'
				+ '<div id="exist"></div></td></tr>';
		st += '<tr><td style="width: 72px;"><span style="padding-left: 6px;"><font size="2">Total Price:</font></span></td><td><input name="allotedList['+id+'].totalamount"'
		+' id="totalPrice'+id+'" readonly="readonly" style="border: 1px solid lightgray;" placeholder="Total Price" value="0" /></tr>'
		+ '<tr><td><input type="hidden" name="allotedList['+id+'].dressName" value="'+name+'"></td><td><input type="hidden" name="allotedList['+id+'].category" value="'+category+'"></td></tr><tr><td><input type="hidden" name="allotedList['+id+'].size" value="'+size+'"></td><td><div id="errorsmsg'+id+'"></div></td></tr></table></div></div></div>';
		$("#dress").append(st);
		$("#getnumber").val(parseInt(id) + 1);
		$("#getremove").val(parseInt(ids) + 1);
		$("#sbmt").show();
			
			},
			error : function(e) {

			}
		});
			}
	}
	function getamount(quantity, id) {
		$("#errorsmsg" + id).empty();
		var flage = true;
		var regex1 = /^[1-9][0-9]*$/;
		if (!regex1.test(quantity)) {
			$("#errorsmsg" + id)
					.append(
							'<span><font color="red" size="2">*Quantity should be greater than zero and Enter only numeric value in quantity</font></span>');
			flage = false;
		}
		if (flage == true) {
			var price = $("#price" + id).val();
			if (price > 0) {
				$("#totalPrice" + id).val(quantity * price);
			}
		}
	}
	function getAmountCheck(amount, id) {
		$("#errorsmsg" + id).empty();
		var regex1 = /^[1-9][0-9]*$/;
		if (!regex1.test(amount))
			$("#errorsmsg" + id)
					.append(
							'<span><font color="red" size="2">*Amount should be greater than zero and Enter only numeric value in amount</font></span>');
	}
	function getNetCheck(net, id) {
		$("#errorsmsg" + id).empty();
		var regex1 = /^[1-9][0-9]*$/;
		if (!regex1.test(net))
			$("#errorsmsg" + id)
					.append(
							'<span><font color="red" size="2">*Net Amount should be greater than zero and Enter only numeric value in Net Amount</font></span>');
	}
	function getquantityclear(count) {
		var q = $("#quantity" + count).val();
		if (q == 0) {
			$("#quantity" + count).val('');
		}
	}
	function getTotalPrice(price, id) {
		$("#errorsmsg" + id).empty();
		var flage = true;
		var regex1 = /^[1-9][0-9]*$/;
		if (!regex1.test($("#price" + id).val())) {
			$("#errorsmsg" + id)
					.append(
							'<span><font color="red" size="2">*Price Should be greater than zero and Enter only numeric value in price</font></span>');
			flage = false;
		}
		if (flage == true) {
			var q = $("#quantity" + id).val();
			$("#totalPrice" + id).val(q * price);
		}

	}
	function removezero(id) {
		var price = $("#price" + id).val();
		if (price == 0)
			$("#price" + id).val('');

	}
	function removeamountzero(id) {
		var amount = $("#amount" + id).val();
		if (amount == 0)
			$("#amount" + id).val('');

	}
	function removetotalzero(id) {
		var netamount = $("#netamount" + id).val();
		if (netamount == 0)
			$("#netamount" + id).val('');

	}
	function validate() {
		var id = $("#getnumber").val();
	
		flag = true;
		var regex1 = /^[1-9][0-9]*$/;
		for ( var i = 0; i <= id - 1; i++) {
			$("#errorsmsg" + i).empty();
		}
		for ( var i = 0; i <= id - 1; i++) {
			if ($("#quantity" + i).val() == '-') {

			} else {
				
				if (!regex1.test($("#quantity" + i).val())) {

					$("#errorsmsg" + i)
							.append(
									'<span><font color="red" size="2">*Quantity should be greater than zero and Enter only numeric value in quantity</font></span>');
					flag = false;
					return false;
				}
				if (!regex1.test($("#price" + i).val())) {
					$("#errorsmsg" + i)
							.append(
									'<span><font color="red" size="2">*Price Should be greater than zero and Enter only numeric value in price</font></span>');
					flag = false;
					return false;
				}
				if (!regex1.test($("#amount" + i).val())) {
					$("#errorsmsg" + i)
							.append(
									'<span><font color="red" size="2">*Amount should be greater than zero and Enter only numeric value in amount</font></span>');
					flag = false;
					return false;
				}
				if (!regex1.test($("#netamount" + i).val())) {
					$("#errorsmsg" + i)
							.append(
									'<span><font color="red" size="2">*Net Amount should be greater than zero and Enter only numeric value in Net Amount</font></span>');
					flag = false;
					return false;
				}
			}
		}
		return flag;
	}
	function hidestockbox() {
		$(".stockbox").hide();
		$("#dresspurchased").empty();
	
	}
</script>
<div class="stockbox">
	<div class="stockbox-header">
		<a href="javascript:hidestockbox();" class="close" data-dismiss="modal"
			style="margin-right: 10px; margin-top: 10px;" aria-hidden="true"><span class="ico-remove-sign"></span></a>
		<h3 id="myModalLabel">Purchase Details</h3>
	</div>
		<div class="row-fluid" style="margin-top: 20px;">
			<div class="block-fluid">
			
				<div id="dresspurchased"></div>
			</div>

		</div>

		<div class="editbox-footer"
			style="float: right;">
			<a class="btn btn-warning" data-dismiss="modal"
				href="javascript:hidestockbox();"style="margin-right: 16px;"
				aria-hidden="true">Close</a>
		</div>

</div>
<div class="content">
	<div id="content-header" style="height: 140px;">
		<img alt="Show_settings" src="${img_url}/uniform.jpg"
			style="width: 50px;">
		<h1>Purchase Uniform</h1>
		<h3>Manage Purchased Uniform Details</h3>
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
	<div class="span12" style="margin-left: 0px; width: 601px;"></div>
	<div id="datas" style="width: 682px; float: left;">

		<f:form method="POST" action="save-temp-purchase"
			commandName="UniformPurchaseDTO" onsubmit="return validate();">
			<div id="dress" style="width: 735px;"></div>
			<div id="sbmt" style="width: 100px; margin-top: -6px; margin-left: 52px; display: none;">
				<button type="submit" class="btn"
					style="width: 100px; margin-top: 50px; margin-left: 52px;">
					<b>Save</b>
				</button>
			</div>
			<div id="feeCategoryNamemsg"></div>
		</f:form>
	</div>
	<div class="widget-body"
		style="padding: 10px 0px 0px; width: 318px; float: left; margin-left: 40px;">
		<div class="block" style="width: 352px;">
			<div class="head blue" class="head blue"
				style="margin-left: 0px; width: 325px;">
				<div class="icon">
					<span class="ico-pen-2"></span>
				</div>
				<h2>Purchase Uniform</h2>
				<ul class="buttons">
					<li><a return false; href="#"><div class="icon">
								<span class="ico-info"></span>
							</div></a></li>
				</ul>
			</div>
			<div class="data-fluid" style="width: 336px;">

				<table class="table fTable lcnp" style="width: 1059px;">
					<thead>
						<tr>
							<th>Uniform Details</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="names" items="${uniform}" varStatus="loop">

							<tr>
								<td>

									<ul>
										<li><a
											href="javascript:viewcategories('${names.uniformName}');">${names.uniformName}</a></li>
										<div id="${names.uniformName}" class="${loop.count}"
											style="width: 270px; margin-left: 25px; display: none;">
											<div class="widget-body"
												style="padding: 10px 0px 0px; width: 251px; float: left; margin-left: 40px;">
												<div class="block" style="width: 352px;">
													<div class="head purple"
														style="margin-left: 0px; width: 234px;">
														<div class="icon">
															<span class="ico-pen-2"></span>
														</div>
														<h2>Categories</h2>
														<ul class="buttons">
															<li><a
																href="javascript:hidename('${names.uniformName}');">
																	<div class="icon">
																		<span class="ico-cancel"></span>
																	</div>
															</a></li>
														</ul>
													</div>
													<div class="data-fluid">
														<table class="table fTable lcnp" style="width: 241px;">

															<tbody>
																<tr>
																	<td><c:forEach var="value"
																			items="${names.categoryList}">
																			<li><a
																				href="javascript:getSizeforCategory('${loop.count}','${value}','${names.uniformName}');">${value}</a>
																				<div id="s${loop.count}" 
																					style="width: 225px; margin-left: 25px;"></div></li>
																		</c:forEach></td>
																</tr>
															</tbody>
														</table>
													</div>
												</div>
											</div>
										</div>

									</ul>

								</td>

							</tr>
							<c:set var="tdress" value="${loop.count}"></c:set>
						</c:forEach>

					</tbody>
				</table>
				<input type="hidden" value="${tdress}" id="totdress">
				<input type="hidden" value="0" id="getnumber"> <input
					type="hidden" value="0" id="getremove">
			</div>
			<a href="javascript:addnewdress();"><span
				class="label label-primary">+Add new</span></a>
			<div id="newdress" style="margin-top: 25px;"></div>
			<div id="removedone"></div>
			<div id="uniquedress"></div>
		</div>

	</div>
</div>