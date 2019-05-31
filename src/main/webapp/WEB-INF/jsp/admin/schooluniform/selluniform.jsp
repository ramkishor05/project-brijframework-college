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
	function getCategory(name, id) {
		$("#msg" + id).empty();
		$.ajax({
			type : "post",
			url : 'getUniformWiseCategory',
			data : {
				'name' : name,
			},
			success : function(data, status) {
				$("#category" + id).empty();
				var j = JSON.parse(data);
				var content = '<option value="">Select a Category</option>';
				for ( var i = 0; i < j.length; i++) {
					content += '<option value='+j[i]+'>' + j[i] + '</option>';
				}
				$("#category" + id).append(content);
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
								+ j.mobile
								+ '</font></span></td></tr></table></div>';
						var a = j.admissionNo;

						$("#studentId").val(a);
						$("#Student").append(st);
					},
					error : function(e) {

					}
				});
	}
	function getPrice(size, count, name) {
	
		$("#msg" + count).empty();
		$("#quantity" + count).val('0');
		$("#amount" + count).val('0');
		var id = $("#moreId").val(); 
		var ids=id-1;
	   var category = $("#category" + count).val();
		$
				.ajax({
					type : "post",
					url : 'getPriceandIdforUniform',
					data : {
						'category' : category,
						'name' : name,
						'size' : size,
					},
					success : function(data, status) {
						
						var j = JSON.parse(data);
						
						if (j.remainingQuantity > 0) {
               if((j.productPurchaseId==$("#productPurchaseId"+id).val())||(j.productPurchaseId==$("#productPurchaseId"+ids).val()))
									{
								$("#msg" + count)
								.append(
										'<span><font color="red" size="2">*This uniform is already selected</font></span>');
								$("#category" + count).val('');
								$("#size" + count).empty();
									}
						}
							
							
								if (j.remainingQuantity > 0) {
							$("#price" + count).val(j.uniformPrice);
							$("#productPurchaseId" + count).val(
									j.productPurchaseId);
							$("#remainingQuantity" + count).val(
									j.remainingQuantity);
						} 
							else {
							$("#msg" + count)
									.append(
											'<span><font color="red" size="2">*Out of Stock</font></span>');
							$("#price" + count).val(j.uniformPrice);
						}
					

					},
					error : function(e) {

					}
				});

	}

	function getSizeforCategory(count, category, name) {
		$("#quantity" + count).val('0');
		$("#amount" + count).val('0');
		$("#price" + count).val('0');
		$("#size" + count).empty();
		$("#msg" + count).empty();
		$.ajax({
			type : "post",
			url : 'getCategoryWiseSize',
			data : {
				'category' : category,
				'name' : name,
			},
			success : function(data, status) {

				var j = JSON.parse(data);
				var content = '<option value="">Select a Size</option>';
				for ( var i = 0; i < j.length; i++) {
					content += '<option value='+j[i]+'>' + j[i] + '</option>';
				}
				$("#size" + count).append(content);
			},
			error : function(e) {

			}
		});

		//alert($("#dressId"+count).val());

	}
	function checknew(count,name)
	{
		$("#msg" + count).empty();
		var category=$("#category"+count).val();
		var size=$("#size"+count).val();
		var id=$("#productPurchaseId"+count).val();
		$("#newstock"+count).hide();
		$.ajax({
			type : "post",
			url : 'checknewstock',
			data : {
				'category' : category,
				'name' : name,
				'size':size,
				  id:id,
			},
			success : function(data, status) {
				/* $("#price" + count).val(''); */
				var j = JSON.parse(data);
				if (j.remainingQuantity > 0) {
					$("#price" + count).val(j.uniformPrice);
					$("#productPurchaseId" + count).val(
							j.productPurchaseId);
					$("#remainingQuantity" + count).val(
							j.remainingQuantity);
				} else {
					$("#msg" + count)
							.append(
									'<span><font color="red" size="2">*Not available</font></span>');
					
				}

			},
			error : function(e) {

			}
		});
	}
	function checknewformore(count)
	{
		$("#msg" + count).empty();
		var category=$("#category"+count).val();
		var size=$("#size"+count).val();
		var id=$("#productPurchaseId"+count).val();
		var name=$("#dressName"+count).val();
		$("#newstock"+count).hide();
		$.ajax({
			type : "post",
			url : 'checknewstock',
			data : {
				'category' : category,
				'name' : name,
				'size':size,
				  id:id,
			},
			success : function(data, status) {
				$("#price" + count).val('');
				var j = JSON.parse(data);
				if (j.remainingQuantity > 0) {
					$("#price" + count).val(j.uniformPrice);
					$("#productPurchaseId" + count).val(
							j.productPurchaseId);
					$("#remainingQuantity" + count).val(
							j.remainingQuantity);
				} else {
					$("#msg" + count)
							.append(
									'<span><font color="red" size="2">*Not available</font></span>');
					
				}

			},
			error : function(e) {

			}
		});
	}
	function getamount(quantity, count) {
		var r = $("#remainingQuantity" + count).val();
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
			if (price == '0') {
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
				
				if (parseInt(quantity) > parseInt(r)) {
				
					$("#msg" + count).append(
							'<span><font color="red" size="2">*Only ' + r
									+ ' pieces left in old stock</font></span>');
					$("#quantity" + count).val('0');
					$("#amount" + count).val('0');
					$("#newstock"+count).show();
				} else {
					$("#msg" + count)
							.append(
									'<span><font color="green" size="2">*Dress Alloted</font></span>');

					var amount = price * $("#quantity" + count).val();
					$("#amount" + count).val(amount);
					$("#newstock"+count).hide();
				}
			}
		}
	}

	function addmore() {
		var id = $("#moreId").val(); 
		var ids = $("#moreIds").val(); 
	
		if(ids=='2')
			{
			$("#morelink").hide();
			$("#moreIds").val('3');
			}
		else
			{
			$("#moreIds").val('2');
			}
		
		$("#removelink").show();
		$
				.ajax({
					type : "post",
					url : 'getUniformNames',
					success : function(data, status) {

						st = '<fieldset style="float: left; width: 300px;height:260px">'
								+ '<legend style="color: gray;">More</legend><table><tr><td style="width: 72px;"><span style="padding-left: 6px;"><font size="2">Uniform Name</font></span></td>'
								+ '<td><select id="dressName'
								+ id
								+ '" onchange="getCategory(this.value,'
								+ id
								+ ');" style="width: 250px;" name="uniformName"><option value="">Select Uniform Type</option>';
						var j = JSON.parse(data);

						for ( var i = 0; i < j.length; i++) {
							st += '<option value='+j[i]+'>' + j[i]
									+ '</option>';
						}
						st += '</select></td><td></td></tr>'
								+ '<tr><td style="width: 72px;"><span style="padding-left: 6px;"><font size="2">Category</font></span></td><td><select id="category'
								+ id
								+ '" onchange="getSize(this.value,'
								+ id
								+ ');" style="width: 250px;"name="uniformCategory">'
								+ '<option value="">Select a category</option></select></td><td></td></tr>'
								+ '<tr><td style="width: 72px;"><span style="padding-left: 6px;"><font size="2">Size</font></span></td><td><select id="size'
								+ id
								+ '" onchange="getPrices(this.value,'
								+ id
								+ ');" style="width: 250px;"name="uniformSize"><option value="">Select a size</option>'
								+ '</select></td><td><input type="hidden" id="remainingQuantity'+id+'" name="remainingQuantity"></td></tr><tr><td style="width: 72px;"><span style="padding-left: 6px;"><font size="2">Price:</font></span></td><td><input name="uniformPrice" required="required" readonly="readonly" id="price'+id+'"'
					+'style="width: 245px;border: 1px solid lightgray;"><div id="exist"></div></td><td><input type="hidden"  value="0" name="allotedList['+id+'].productPurchaseId" id="productPurchaseId'+id+'"/></td></tr>'
								+ '<tr><td style="width: 72px;"><span style="padding-left: 6px;"><font size="2">Quantity:</font></span></td><td><input name="allotedList['
								+ id
								+ '].quantity" id="quantity'
								+ id
								+ '" placeholder="Enter Quantity" oninput="getmoreamount(this.value,'
								+ id
								+ ')" onclick="getquantityclear('
								+ id
								+ ')"'
								+ 'style="width: 245px;"value="0"/><div id="exist"></div></td><td></td></tr><tr><td style="width: 72px;"><span style="padding-left: 6px;"><font size="2">Amount:</font></span></td><td><input name="amount" readonly="readonly"id="amount'+id+'" style="width: 245px;border: 1px solid lightgray;" placeholder="Amount" value="0"/>'
								+ '<div id="exist"></div></td><td></td></tr><tr><td colspan="3"><div id="msg'+id+'"></div><div id="newstock'+id+'" style="display:none;">'
								+'<a href="javascript:checknewformore('+id+');"><span><font size="2">Check new Stock</font></span></a></div></td></tr></table></fieldset>';
						$("#moredress" + id).append(st);
						id++;
						$("#moreId").val(id);
						
					},
					error : function(e) {

					}
				});

	}

	function getSize(category, num) {
		$("#msg" + num).empty();
		var name = $("#dressName" + num).val();
		$.ajax({
			type : "post",
			url : 'getCategoryWiseSize',
			data : {
				'category' : category,
				'name' : name,
			},
			success : function(data, status) {
				$("#size" + num).empty();
				var j = JSON.parse(data);
				var content = '<option value="">Select a Size</option>';
				for ( var i = 0; i < j.length; i++) {
					content += '<option value='+j[i]+'>' + j[i] + '</option>';
				}
				$("#size" + num).append(content);
			},
			error : function(e) {

			}
		});
	}
	function getPrices(size, num) {
		var flage=true;
		var name = $("#dressName" + num).val();
		var category = $("#category" + num).val();
		$("#msg" + num).empty();
		var id = $("#moreId").val(); 
		
		$
				.ajax({
					type : "post",
					url : 'getPriceandIdforUniform',
					data : {
						'category' : category,
						'name' : name,
						'size' : size,
					},
					success : function(data, status) {
						
						$("#price" + num).val('0');
						var j = JSON.parse(data);
						if (j.remainingQuantity > 0) {
						for ( var i = 1; i <= id-1; i++) {
							
							if(j.productPurchaseId==$("#productPurchaseId"+i).val())
								{
								$("#dressName" + num).val('');
								$("#size" + num).empty();
								$("#category" + num).empty();
								flage=false;
								$("#msg" + num)
								.append(
										'<span><font color="red" size="2">*This uniform is already selected</font></span>');
								break;
							}
						}
						}
							if(flage==true)
								{
						if (j.remainingQuantity > 0) {
							
							$("#price" + num).val(j.uniformPrice);
							$("#productPurchaseId" + num).val(
									j.productPurchaseId);
							$("#remainingQuantity" + num).val(
									j.remainingQuantity);
						} else {
							$("#msg" + num)
									.append(
											'<span><font color="red" size="2">*Out of Stock</font></span>');
							$("#remainingQuantity" + num).val(
									j.remainingQuantity);
						}
								}
					},
					error : function(e) {

					}
				});
		

	}
	function getmoreamount(quantity, num) {
	
		$("#msg" + num).empty();
		var r = $("#remainingQuantity" + num).val();
		var flage = true;
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
			if (flage == true) {
				if (parseInt(quantity) > parseInt(r))
					{
					$("#msg" + num).append(
							'<span><font color="red" size="2">*Only ' + r
									+ ' pieces left in old stock</font></span>');
					$("#quantity" + num).val('');
					$("#amount" + num).val('0');
					$("#newstock"+num).show();
				} else {
					$("#msg" + num)
							.append(
									'<span><font color="green" size="2">*Dress Alloted</font></span>');

					var amount = price * $("#quantity" + num).val();
					$("#amount" + num).val(amount);
					$("#newstock"+num).hide();
				}
			}

		}
	}
	function removealloted(id) {
		$("#finals").empty();
		var total = '0';
		var url = 'cancelalloted/' + id;
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

							st += '<button class="btn btn-success" id="paybutton"style="margin-left: 415px; margin-top: 22px;" type="button"onclick="payment();">Save</button>';

							$("#dressDetails").append(st);
						}

					},
					error : function(error, status) {
					}
				});
	}
	function payment() {
		$('#paybutton').hide();
		$("#uniformstosell").hide();
		$('#blues').hide();
		var total = $("#newtotal").val();
	var net=0;
		var studentId = $('#newstudent').val();
		
		 var st = '<div id="finals"><div id="box" style="border: 1px solid; border-radius: 10px; width: 717px; height: 161px; padding-left: 22px; margin-top: 0px; padding-top: 5px;"><form action="uniform-payment" method="POST" commandName="DressPaymentDTO" target="_blank" id="validateform"><table style="width: 1006px; padding-left: 54px;"><tr><td style="width: 136px;">Total amount:</td><td style="width: 90px;"> <input type="text" name="totalAmount" id="totalAmount" readonly="readonly" value='+total+'></td><td style="width: 28px;"></td>'
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
				+ '<td><input type="hidden" name="inwords" value="0" id="paidAmountInWord"><a href="javascript:validate();"><span class="label label-success"style="width: 53px; padding-left: 12px; height: 22px;">Submit</span></a></td></tr></table></form></div></div>'; 
				$("#dressDetails").empty();
				$("#pays").append(st);

		
	}
	function addtofee() {
		$('#paybutton').hide();
		$("#uniformstosell").hide();
		$('#blues').hide();
		var total = $("#newtotal").val();
	var net=0;
		var studentId = $('#newstudent').val();
		var url = 'getlastfeemonthcategories/' + studentId+ '/'+total;
		var st='';
		$
				.ajax({
					url : url,

					type : 'POST',
					success : function(data, status) {
					
						var j=JSON.parse(data);
						if(j[0].feeCategoryName=='no')
							{
							st = '<div class="failedmsg">Dress cannot be alloted because fees is paid for the whole session</div>';
					} else {
						
						st = st
						+ '<div><div class="widget-body"  style="padding: 10px 0px 0px; margin-top: -50px;"><div class="separator"></div><div class="btn-group" style="width: 400px;">'
						+ '</div><div class="block"><div class="head blue" style="margin-top: 36px;"><h4 style="text-align:center">Fee Allotments for '+j[0].monthName+'</h4></div>'
						+ '<table class="table table-bordered table-primary"><thead><tr><th>S.no</th><th>Fee Category</th><th>Amount</th></tr></thead><tbody>';
				for ( var i = 0; i < j.length; i++) {
					net=parseInt(net)+ parseInt(j[i].total);
					st += '<tr><td>' + (i + 1) + '. </td><td>' + j[i].feeCategoryName
							+ '</td><td>' + j[i].amounts
							+ '</td></tr>';
				}
				st += '<tr><td><b>Total</td><td><b>'+net+'</b></td></tr></table>';
					}		
				
		/* var st = '<div id="finals"><div id="box" style="border: 1px solid; border-radius: 10px; width: 717px; height: 161px; padding-left: 22px; margin-top: 0px; padding-top: 5px;"><form action="uniform-payment" method="POST" commandName="DressPaymentDTO" target="_blank" id="validateform"><table style="width: 1006px; padding-left: 54px;"><tr><td style="width: 136px;">Total amount:</td><td style="width: 90px;"> <input type="text" name="totalAmount" id="totalAmount" readonly="readonly" value='+total+'></td><td style="width: 28px;"></td>'
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
				+ '<td><input type="hidden" name="inwords" value="0" id="paidAmountInWord"><a href="javascript:validate();"><span class="label label-success"style="width: 53px; padding-left: 12px; height: 22px;">Submit</span></a></td></tr></table></form></div></div>'; */
				$("#dressDetails").empty();
				$("#pays").append(st);

					},
					error : function(error, status) {
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
	function generatepdf() {
		var studentId = $('#newstudent').val();
		var paid = $("#recentPaidAmount").val();
		var paidwords = $("#paidAmountInWord").val();
		var total = $('#totalAmount').val();
	    var netpayable=$("#discountAmount").val();
	    if(paid=='')
	    	{
	    	$("#feeCategoryNamemsg")
			.append('<span><font color="red" size="2">Enter amount to be paid</font></span>');
	    	}
	    else
	    	{
	    	$("#feeCategoryNamemsg").empty();
	    	  window.open('submitsolduniform?id=' + paid + '&id2='
	  				+ paidwords + '&id3=' + studentId + '&total=' + total+ '&net=' + netpayable,'_blank'); 
	    		document.location.href = 'sell-uniform';
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
	function getquantityclear(count) {
		var r = $("#remainingQuantity" + count).val();
		var size =$("#size" + count).val();
		if ((r == 0)&&(size!='')) {
			alert("Out of Stock");
		}
		else
			{
				var q = $("#quantity" + count).val();
			if (q == 0) {
				$("#quantity" + count).val('');
			}
		}
			
	}
	function removemore() {
		var id = $("#moreId").val() - 1;
		$("#moredress" + id).empty();
		$("#moreId").val(id);
		ids=$("#moreIds").val();
		
		$("#moreIds").val(ids-1);
		if (ids-1=='2') {
			$("#morelink").show();
		}
		if (ids-1=='1') {
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
			var classId = $('#class').val();
			var sectionId = $('#sectionId').val();
			var student = $("#studentId").val();

			if (classId == '' || classId == null) {
				$("#classmsg")
						.append(
								'<font color="red" size="2">*This field is required</font>');
				window.scrollBy(0, -500);
				return false;
			}
			if (sectionId == '' || sectionId == null) {
				$("#sectionmsg")
						.append(
								'<font color="red" size="2">*This field is required</font>');
				window.scrollBy(0, -500);
				return false;
			}

			if (student == '' || student == null) {
				$("#namemsg")
						.append(
								'<font color="red" size="2">*This field is required</font>');
				window.scrollBy(0, -500);
				return false;
			} else {
				$("#feeCategoryNamemsg").empty();

			}
		} else {
			$("#studentId").val(studentId);
		}
		var id = $("#moreId").val(); 
	 	for ( var i = 1; i <= id+1; i++) {
			if ($("#quantity" + i).val() > 0) {
				flag = true;
				break;
			}

		}
		for ( var i = 1; i <= id+1; i++) {
			if ($("#quantity" + i).val() == '') {
				$("#quantity" + i).val('0');
			}

		} 
		if (flag == false) {
			$("#feeCategoryNamemsg")
					.append(
							'<center><font color="red">*Select atleast one dress</font></center>');
			window.scrollBy(0, -500);
		}
		return flag;
	}
	$(document).ready(function() {
		$("#removelink").hide();
		$('#class').val('');
		$('#sectionId').val('');
		$("#studentId").val('');
	

	});
	function validate() {
		$("#feeCategoryNamemsg").empty();
		flage = true;
		var regex2 = /^[a-zA-Z ]+$/;
		var paid = $("#recentPaidAmount").val();
		   if(paid=='')
	    	{
	    	$("#feeCategoryNamemsg")
			.append('<center><span><font color="red" size="2">Enter amount to be paid</font></span></center>');
	    	flage = false;
	    	}
		if ($("#paymentType").val() == 'Cheque' && $("#bankName").val() == '') {
			flage = false;
			$("#feeCategoryNamemsg")
			.append(
					'<center><font color="red">*Enter Bank Name</font></center>');
			
		}
		if ($("#paymentType").val() == 'Cheque' &&( $("#checkNo").val() == '' ||$("#checkNo").val().length<6)){
			flage = false;
			$("#feeCategoryNamemsg")
			.append(
					'<center><font color="red">*Please Enter 6 digit valid Cheque No.</font></center>');
			
			
		} 
		if ($("#paymentType").val() == 'Cheque' && !regex2.test($("#bankName").val())) {
			$("#feeCategoryNamemsg")
					.append(
							'<center><font color="red" size="2">*Enter only letters in Bank Name</font><center>');
			flage = false;
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
			document.location.href = 'sell-uniform';
		}

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
		<div class="span2" style="width: 605px;">
			<c:choose>
				<c:when test="${studentdata==null}">
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
								<td style="width: 148px;"><span><font size="2"><b>Name
												:</b></font></span></td>
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
						<div class="head blue" id="blues" style="margin-top: 18px;">
							<div class="icon">
								<span class="ico-pen-2"></span>
							</div>
							<h2>Selected Dress Details</h2>
						</div>
						<div class="data-fluid" id="dressDetails">

							<table width="100%" class="table">
								<thead>
									<tr>
										<th width="25%">Uniform Name</th>
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
	<button  id="paybutton" class="btn btn-success" onclick="addtofee();" type="button" style="margin-left: 57px; margin-top: 22px;">Add to fee</button>

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
	
	<div id="feeCategoryNamemsg"></div>
	<div id="uniformstosell" style="width: 1050px;">

		<f:form action="save-uniformSold" commandName="UniformPurchaseDTO"
			method="POST" onsubmit="return validateform();">
			<c:forEach var="names" items="${uniform}" varStatus="loop">
				<fieldset
					style="float: left; width: 300px;height:240px; margin: 15px;">
					<legend style="color: gray;">${names.uniformName}</legend>
					<table>
						<tr>
							<td><span style="padding-left: 6px;"><font size="2">Category</font></span></td>
							<td><select id="category${loop.count}"
								onchange="getSizeforCategory('${loop.count}',this.value,'${names.uniformName}');"
								name="uniformCategory">
									<option value="">Select a category</option>
									<c:forEach var="value" items="${names.categoryList}">
										<option value="${value}">${value}</option>
									</c:forEach>
							</select></td>
							<td></td>
						</tr>

						<tr>
							<td style="width: 72px;"><span style="padding-left: 6px;"><font
									size="2">Size</font></span></td>
							<td><select id="size${loop.count}"
								onchange="getPrice(this.value,'${loop.count}','${names.uniformName}');"
								name="uniformSize">
								<option value="">Select a Size</option>
							</select></td>
							<td></td>

						</tr>
						<tr>
							<td style="width: 72px;"><span style="padding-left: 6px;"><font
									size="2">Price:</font></span></td>
							<td><input name="uniformPrice" readonly="readonly"
								id="price${loop.count}" value="0" style="border: 1px solid lightgray;">
								<div id="exist"></div></td>
							<td><input type="hidden" id="remainingQuantity${loop.count}"
								name="remainingQuantity" value="0"></td>
						</tr>

						<tr>
							<td style="width: 72px;"><span style="padding-left: 6px;"><font
									size="2">Quantity:</font></span></td>
							<td><f:input path="allotedList[${loop.count}].quantity"
									onclick="getquantityclear('${loop.count}');"
									oninput="getamount(this.value,'${loop.count}');"
									id="quantity${loop.count}" placeholder="Enter Quantity" />
								<div id="exist"></div></td>
							<td><f:hidden
									path="allotedList[${loop.count}].productPurchaseId"
									style="width: 27px;" id="productPurchaseId${loop.count}"
									value="0" /></td>
						</tr>
						<tr>
							<td style="width: 72px;"><span style="padding-left: 6px;"><font
									size="2">Amount:</font></span></td>
							<td><input name="amount" readonly="readonly" value="0"
								id="amount${loop.count}" placeholder="Amount" style="border: 1px solid lightgray;" />
								<div id="exist"></div></td>
							<td></td>
						</tr>

						<tr>
							<td colspan="3"><div id="msg${loop.count}"></div><div id="newstock${loop.count}" style="display:none;">
							<a href="javascript:checknew('${loop.count}','${names.uniformName}');"><span><font size="2">Check new Stock</font></span></a></div></td>
							
						</tr>
						
					</table>
				</fieldset>
					<c:set var="noOfuniforms" value="${loop.count}"></c:set>
			</c:forEach>

			<div id="moredress${noOfuniforms+1}"></div>

			<div id="moredress${noOfuniforms+2}"></div>

			<div
				style="float: left; width: 800px; height: 0px; text-align: center; margin-top: 10px;">
				<button type="submit" class="btn"
					style="margin-top: -2px; width: 100px;">
					<b>Save</b>
				</button>
				<input type="hidden" id="moreId" value="${noOfuniforms+1}"> <input type="hidden" id="moreIds" value="1"><input
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


