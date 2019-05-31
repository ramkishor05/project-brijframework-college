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

<script>
	function getSectionList(id) {
		$("#getnumber").val('0');
		$("#getremove").val('0');
		$("#book").empty();
		$("#newsubjectId").empty();
		$("#Subject").empty();
		$("#sbmt").hide();
		$("#selectsubject").hide();
		$("#newsubjectId").empty();
		$.ajax({
			type : "post",
			url : 'getsectionlist/' + id,
			success : function(data, status) {
				$("#sectionId").empty();
				var j = JSON.parse(data);
				var content = '<option value="">Select Section</option>';
				for (var i = 0; i < j.length; i++) {
					content += '<option value='+j[i].sectionId+'>'
							+ j[i].sectionName + '</option>';
				}
				$("#sectionId").append(content);
			},
			error : function(e) {

			}
		});
	}

	function subjectofnewbook() {
		$("#selectsubject").show();
	}
	function removebook(id) {
		$("#" + id).empty();
		$("#removedone").append(
				'<input id="quantity'+id+'" value="-" type="hidden">');
		var id = $("#getremove").val();
		if (id == 1) {
			$("#sbmt").hide();
		}
		$("#getremove").val(id - 1);
	}
	function removebookselected(id, cl) {
		$("#" + cl).remove();
		$("#" + id).empty();
		$("#removedone").append(
				'<input id="quantity'+id+'" value="-" type="hidden">');
		var id = $("#getremove").val();
		if (id == 1) {
			$("#sbmt").hide();
		}
		$("#getremove").val(id - 1);

	}
	function addnewbook(subjectId) {
		$("#newbook").empty();
		var st = '<div id="adds">Title <input type="text" name="newbook" id="newbooks" maxlength="20"  value=""/><div id="namemsg"></div><a href="javascript:saveNewName('
				+ subjectId
				+ ');"><span class="label label-success" style="width: 37px; margin-top: 16px; padding-left: 16px;">Add</span></a></div>'

		$("#newbook").append(st);
	}
	function saveNewName(subjectId) {
		$("#namemsg").empty();
		var title = $("#newbooks").val();

		var flag = true;
		var regex1 = /^[a-zA-Z ]+$/;
		if (!regex1.test(title)) {
			$("#namemsg").append(
					'<font color="red" siz="2">Enter only Letters</font>');
			$("#newbooks").val('');
			flag = false;
		}

		if (flag == true) {

			$("#selectsubject").hide();
			$("#adds").empty();
			shownewbook(title, subjectId);
		}
	}
	function shownewbook(title, subjectId) {
		var id = $("#getnumber").val();
		var ids = $("#getremove").val();
		$
				.ajax({
					type : "post",
					url : 'getSubjectName',
					data : {
						'id' : subjectId,
					},
					success : function(data, status) {
						var j = JSON.parse(data);

						var st = '<div id="'+id+'" style="float:left;"><div class="widget-body" style="padding: 10px 0px 0px; width: 267px; float: left; margin-left: 40px;"><div class="block" style="width: 352px; height: 446px;">'
								+ '<div class="head dblue" style="margin-left: 0px; width: 281px;"><div class="icon"><span class="ico-pen-2"></span></div><h2>'
								+ j
								+ '-'
								+ title
								+ '</h2><ul class="buttons">'
								+ '<li><a href="javascript:removebook('
								+ id
								+ ');"><div class="icon"><span class="ico-cancel"></span></div></a></li></ul></div><div class="data-fluid" style="width: 294px; height: 231px;"><table class="table fTable lcnp">'
								+ '<thead></thead><tbody>';

						st += '<tr><td colspan="2" style="color:green">Remaining Stock is: 0</tr> <td style="width: 72px;"><span style="padding-left: 6px;"><font size="2">Quantity:</font></span></td><td><input name="allotedList['
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
								+ '<tr><td><input type="hidden" name="allotedList['+id+'].bookTitle" value="'+title+'"></td><td><input type="hidden" name="allotedList['+id+'].subjectId" value="'+subjectId+'"></td></tr><tr><td></td><td><div id="errorsmsg'+id+'"></div></td></tr></table></div></div></div>';

						$("#book").append(st);
						$("#getnumber").val(parseInt(id) + 1);
						$("#getremove").val(parseInt(ids) + 1);

						$("#sbmt").show();
					},
					error : function(e) {

					}
				});

	}
	function getsubjectsforclass(sectionId) {
		var classId = $("#classId").val();
		$("#getnumber").val('0');
		$("#getremove").val('0');
		$("#book").empty();
		$("#newsubjectId").empty();
		$("#Subject").empty();
		$("#sbmt").hide();
		$("#selectsubject").hide();
		$("#newsubjectId").empty();
		var url = 'getsubjectsforbook/' + classId + '/' + sectionId;
		$
				.ajax({
					url : url,

					type : 'POST',
					success : function(data, status) {
						$("#Subject").empty();
						var j = JSON.parse(data);
						var st = "";
						var content = '<option value="">Select Subject</option>';
						var length = j.length;
						if (length == 0) {
							st = '<div class="failedmsg">No subjects are assigned to this class for current session.Go to Settings->Manage Subjects and assign subjects.</div>';
						} else {

							st = st
									+ '<div><div class="widget-body"  style="padding: 10px 0px 0px; margin-top: -50px;"><div class="separator"></div><div class="btn-group" style="width: 400px;">'
									+ '</div><div class="block"><div class="head blue"><h4 style="text-align:center">Subjects List</h4></div>'
									+ '<table class="table table-bordered table-primary"><thead><tr><th>Subjects</th></tr></thead><tbody>';
							for (var i = 0; i < length; i++) {
								st += '<tr><td><a href="javascript:showbook('
										+ j[i].id
										+ ')";>' + j[i].subjectName
										+ '</a></td></tr>';
								content += '<option value="'+j[i].id+'">'
										+ j[i].subjectName + '</option>';
							}

							st += '</table>';
							st += '<a href="javascript:subjectofnewbook();"><span class="label label-primary">+Add new</span></a>';
						}
						$("#Subject").append(st);
						$("#newsubjectId").append(content);
					},
					error : function(error, status) {
					}
				});
	}

	function showbook(subjectId) {

		$
				.ajax({
					type : "post",
					url : 'getBookforSubject',
					data : {
						'id' : subjectId,
					},
					success : function(data, status) {
						var j = JSON.parse(data);
						if (j.length == 0) {
							alert("No book has been purchased for this subject in this session.Click on Add New and add new book");
						} else {
							var subjectName=j[0].subjectName;
							var cl = subjectId;

							var flag = '';
							var unq = document.getElementById(cl);
							if (unq == null)
								flag = true;
							else {
								flag = false;
								alert("This Book is already selected");
							}
							if (flag == true) {
								var cont = '<input type="hidden" value="1" id="'+cl+'">';
								$("#uniquebook").append(cont);

								var id = $("#getnumber").val();
								var ids = $("#getremove").val();
								for (var i = 0; i < j.length; i++) {
									var st = '<div id="'+id+'" style="float:left;"><div class="widget-body" style="padding: 10px 0px 0px; width: 267px; float: left; margin-left: 40px;"><div class="block" style="width: 352px; height: 446px;">'
											+ '<div class="head dblue" style="margin-left: 0px; width: 281px;"><div class="icon"><span class="ico-pen-2"></span></div><h2>'
											+ subjectName
											+ '-'
											+ j[i].bookTitle
											+ '</h2><ul class="buttons">'
											+ '<li><a href=javascript:removebookselected('
											+ id
											+ ',"'
											+ cl
											+ '");><div class="icon"><span class="ico-cancel"></span></div></a></li></ul></div><div class="data-fluid" style="width: 294px; height: 231px;"><table class="table fTable lcnp">'
											+ '<thead></thead><tbody>';

									st += '<tr><td colspan="2" style="color:green">Remaining Stock is:'
											+ j[i].remainingQuantity
											+ '</tr> <td style="width: 72px;"><span style="padding-left: 6px;"><font size="2">Quantity:</font></span></td><td><input name="allotedList['
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
											+ ');" placeholder="Price per book"  />'
											+ '<div id="exist"></div></td></tr>';
									st += '<tr><td style="width: 72px;"><span style="padding-left: 6px;"><font size="2">Total Price:</font></span></td><td><input name="allotedList['+id+'].totalamount"'
	+' id="totalPrice'+id+'" readonly="readonly" style="border: 1px solid lightgray;" placeholder="Total Price" value="0" /></tr>'
											+ '<tr><td><input type="hidden" name="allotedList['+id+'].bookTitle" value="'+j[i].bookTitle+'"></td><td><input type="hidden" name="allotedList['+id+'].subjectId" value="'+subjectId+'"></td></tr><tr><td></td><td><div id="errorsmsg'+id+'"></div></td></tr></table></div></div></div>';
									id++;
									ids++;
									$("#book").append(st);
									$("#getnumber").val(parseInt(id));
									$("#getremove").val(parseInt(ids));
								}
								$("#sbmt").show();
							}
						}
					},
					error : function(e) {

					}
				});

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
		for (var i = 0; i <= id - 1; i++) {
			$("#errorsmsg" + i).empty();
		}
		for (var i = 0; i <= id - 1; i++) {
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
</script>
<div class="content">
	<div id="content-header" style="height: 150px;">
		<img alt="Show_settings" src="${img_url}/book1.jpg"
			style="width: 50px; margin-top: -12px;">
		<h1>Purchase Book</h1>
		<h3>Purchase Book for session ${current.sessionDuration}</h3>
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
	<f:form method="POST" action="save-books-purchase"
		commandName="BookPurchaseDTO" onsubmit="return validate();">
		<table
			style="width: 339px; height: 90px; margin-left: 231px; margin-top: -11px;">

			<tr>
				<td style="width: 200px;">Class</td>
				<td><select id="classId" style="width: 250px;" name="classId"
					onchange="getSectionList(this.value);">
						<option value="">Select a class</option>
						<c:forEach var="list" items="${classList}">
							<option value="${list.classId}">${list.className}</option>
						</c:forEach>
				</select></td>

			</tr>

			<tr>
				<td style="width: 200px;">Section</td>
				<td><select id="sectionId" class="validate[required]"
					style="width: 250px;" onchange="getsubjectsforclass(this.value);"
					name="sectionId" class="select">
						<option value="">Select a Section</option>
				</select></td>
			</tr>


		</table>
		<div id="book" style="width: 735px; float: left; margin-top: -1px;"></div>

		<div class="separator"></div>

		<div id="complete"
			style="width: 250px; float: left; margin-top: -9px; margin-right: 23px;">
			<div id="Subject" style="margin-top: 49px;"></div>
			<div id="selectsubject"
				style="display: none; float: right; width: 250px;">
				Subject <select id="newsubjectId" style="width: 250px;"
					onchange="addnewbook(this.value);" name="subjectsId">

				</select>
			</div>
			<div id="newbook" style="margin-top: 25px;"></div>
		</div>
		<div id="sbmt" style="width: 100px; display: none;">
			<button type="submit" class="btn" style="width: 100px;">
				<b>Save</b>
			</button>
		</div>
		<div class="separator"></div>
	</f:form>
	<input type="hidden" value="0" id="getnumber"> <input
		type="hidden" value="0" id="getremove">


	<div id="removedone"></div>
	<div id="uniquebook"></div>
</div>



