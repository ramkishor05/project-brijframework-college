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
</style>

<script>
	function getnew(radiovalue) {
		$("#monthmsg").empty();
		hideData();
		var st = "";
		$("#monthId").val('');
		$("#installmentName").val('');
		$("#monthname").empty();
		$("#installment").empty();
		$("#appendquaterly").empty();
		if (radiovalue == "quaterly") {
			quaterly();
		}
		if (radiovalue == "13") {
			st = '<input type="hidden" name="month" value="13"id="month">';
			$('#month').val(radiovalue);
			feeAllotementStatus(radiovalue);
			searchbyslipno(radiovalue);
		}
		if (radiovalue == "monthRadio") {
			st = '<select id="month" class="validate[required]" style="width: 250px;" name="month" class="select" onchange="feeAllotementStatus(this.value);">'
				+ '<option value="">Select a month</option>'
				+ '<option value="1" data-original-title="" title="">APR</option>'
				+ '<option value="2" data-original-title="" title="">MAY</option>'
				+ '<option value="3" data-original-title="" title="">JUN</option>'
				+ '<option value="4" data-original-title="" title="">JUL</option>'
				+ '<option value="5" data-original-title="" title="">AUG</option>'
				+ '<option value="6" data-original-title="" title="">SEP</option>'
				+ '<option value="7" data-original-title="" title="">OCT</option>'
				+ '<option value="8" data-original-title="" title="">NOV</option>'
				+ '<option value="9" data-original-title="" title="">DEC</option>'
				+ '<option value="10" data-original-title="" title="">JAN</option>'
				+ '<option value="11" data-original-title="" title="">FEB</option>'
				+ '<option value="12" data-original-title="" title="">MAR</option></select>';
		}
		$("#monthname").append(st);
	}
	function quaterly() {
		$("#installment").empty();
		var content = '<div style="border: 1px solid lightgray; width: 221px; height: 49px; padding-left: 10px;"><label>Choose Installment: </label><input type="radio" required="required" name="installment" id="monthRadio" value="first" onchange="feeAllotementStatuses(this.value);"><lable style="padding-left: 3px; border-right-width: 0px; padding-right: 14px;">1st</lable>';
		content += '<input type="radio" required="required" name="installment" id="monthRadio" value="second" onchange="feeAllotementStatuses(this.value);"><lable style="padding-left: 3px; border-right-width: 0px; padding-right: 14px;">2nd</lable>';
		content += '<input type="radio" required="required" name="installment" id="monthRadio" value="third" onchange="feeAllotementStatuses(this.value);"><lable style="padding-left: 3px; border-right-width: 0px; padding-right: 14px;">3rd</lable>';
		content += '<input type="radio" required="required" name="installment" id="monthRadio" value="fourth" onchange="feeAllotementStatuses(this.value);"><lable style="padding-left: 3px; border-right-width: 0px; padding-right: 14px;">4th</lable></div>';
		$("#installment").append(content);
	}
	function feeAllotementStatus(radiovalue) {

		if ($("#sessionId").val() != '' && $("#classId").val() != ''
				&& $("#feesCategoriesId").val()) {
			$('#month').val(radiovalue);
			$('#monthId').val(radiovalue);
			hideData();
			$
					.ajax({
						type : "get",
						url : 'verifyfeeallotedsectionwise',
						data : {
							'sessionId' : $("#sessionId").val(),
							'classId' : $("#classId").val(),
							'monthId' : radiovalue,
							'categoryId' : $("#feesCategoriesId").val(),
							'sectionId' : $("#sectionId").val()
						},
						success : function(data) {
							if (data == 'yes') {
								$("#fontmsg")
										.text(
												'This category is alloted').css("color","red");
								$("#Allot").hide();
							}
						},
						error : function(e) {

						}
					});
		} else {
			alert("Select All The Fill Above.");
		}
	}
	function feeAllotementStatuses(radiovalue) {
		$("#monthmsg").empty();
		if (radiovalue == 'first')
			$("#monthmsg")
					.append(
							'<div  class="successmsg" style="width: 129px; height: 20px; padding-top: 0px; padding-bottom: 0px; margin-left: -175px; margin-top: 8px;"><font size="2">Mar Apr May</font></div>');
		if (radiovalue == 'second')
			$("#monthmsg")
					.append(
							'<div class="successmsg" style="width: 129px; height: 20px; padding-top: 0px; padding-bottom: 0px; margin-left: -175px; margin-top: 8px;"><font size="2">Jun July Aug</font></div>');
		if (radiovalue == 'third')
			$("#monthmsg")
					.append(
							'<div class="successmsg" style="width: 129px; height: 20px; padding-top: 0px; padding-bottom: 0px; margin-left: -175px; margin-top: 8px;"><font size="2">Sep Oct Nov</font></div>');
		if (radiovalue == 'fourth')
			$("#monthmsg")
					.append(
							'<div class="successmsg" style="width: 129px; height: 20px; padding-top: 0px; padding-bottom: 0px; margin-left: -175px; margin-top: 8px;"><font size="2">Dec Jan Feb</font></div>');

		if ($("#sessionId").val() != '' && $("#classId").val() != ''
				&& $("#feesCategoriesId").val()) {
			$('#installmentName').val(radiovalue);
			hideData();
			$
					.ajax({
						type : "get",
						url : 'verifyfeeallotedsectionwise',
						data : {
							'sessionId' : $("#sessionId").val(),
							'classId' : $("#classId").val(),
							'monthId' : radiovalue,
							'categoryId' : $("#feesCategoriesId").val(),
							'sectionId' : $("#sectionId").val()
						},
						success : function(data) {
							if (data == 'yes') {
								$("#fontmsg")
										.text(
												'This category is alloted').css("color","red");
								$("#Allot").hide();
							}
						},
						error : function(e) {

						}
					});
		} else {
			alert("Select All The Fill Above.");
		}
	}
	function searchbyslipno(radiovalue) {
		hideData();
		$
				.ajax({
					type : "get",
					url : 'verifyfeeallotedsectionwise',
					data : {
						'sessionId' : $("#sessionId").val(),
						'classId' : $("#classId").val(),
						'monthId' : radiovalue,
						'categoryId' : $("#feesCategoriesId").val(),
						'sectionId' : $("#sectionId").val()
					},
					success : function(data) {
						if (data == 'yes') {
							$("#fontmsg")
									.text(
												'This category is alloted').css("color","red");
							$("#Allot").hide();
						}
					},
					error : function(e) {

					}
				});
	}
	function showhideData() {
		if ($("#year").is(':checked')) {
			searchbyslipno($("#year").val());
		}
		if ($("#monthRadio").is(':checked') && $("#month").val() != "") {
			searchbyslipno($("#month").val());
		}

	}
	function hideData() {
		$("#fontmsg").text('');
		$("#Allot").show();
	}

	function validateform() {

		$("#paidAmountmsg").empty();
		var flage = true;

		var m = $("#monthId").val();
		var i = $("#installmentName").val();
		var f = $("#feeAmount").val();
		if ((i == "" || i == null) && (m == 0)) {
			document.getElementById("err").innerHTML = "Select the months or installments";
			return false;
		} else {
			document.getElementById("err").innerHTML = "";
			if ((i == "" || i == null)) {
				$("#installmentName").val($("#monthId").val());
			}
			if ((m == "" || m == null)) {
				$("#monthId").val('14');
			}
		}

		if (isNaN(f)) {
			$("#paidAmountmsg").append(
					'<font color="red">Only Numeric value</font>');
			flage = false;

		}

		else {
			$("#paidAmountmsg").empty();
		}

		return flage;

	}
	function getSectionList(id) {
		$("#sectionId").empty();
		$.ajax({
			type : "post",
			url : 'getsectionlist/' + id,
			success : function(data, status) {

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
	function showAllotedFees() {
		if ($('#classId').val() != '') {
			hideData();

			$
					.ajax({
						type : "get",
						url : 'showallotedfeesbysectionid',
						data : {
							'classId' : $('#classId').val(),
							'sectionId' : $('#sectionId').val(),
							'sessionId' : $('#sessionId').val(),
						},
						success : function(data) {
							$('#sectionwisefees').empty();
							var obj = JSON.parse(data);
							if (obj != '') {
								$("#allotclass").text(
										'Alloted Fees for class '
												+ obj[0].className + ' '
												+ obj[0].sectionName
												+ ' and session '
												+ obj[0].sessionName + '');
								var classwisefee = '<table class="table table-bordered table-primary"style="width: 1059px;">'
										+ '<thead><tr><th>Fee Category</th><th>Month</th><th>Amount</th><th>Delete</th></tr></thead>';
								$.each(obj, function(key, value) {
									classwisefee += '<tbody><tr><td>'
											+ value.feesCategoriesName
											+ '</td><td>' + value.monthName
											+ '</td><td>' + value.feeAmount
											+ '</td><td><a href="javascript:deletesectionwise('
											+ $('#classId')
											.val()
									+ ','
									+ $('#sectionId')
											.val()
									+ ','
									+ value.sectionWiseFeeId
									+ ','
									+ value.monthId
									+ ');"><span class="label label-important">Delete</span></a></td></tr>';
								});
								classwisefee += '</tbody></table>';
								$('#sectionwisefees').append(classwisefee);
							} else {
								$('#sectionwisefees').append(
										"<center>No Data Found</center>");
							}

						},
						error : function(e) {

						}
					});
		} else {
			alert("Select A Class First");
		}
	}
	function deletesectionwise(classId, sectionId, sectionWiseFeeId, monthId) {
		$("#msg").empty();
		$(".successmsg").remove();
		$
				.ajax({
					type : "post",
					url : 'deletefeesectionwise',
					data : {
						"monthId" : +monthId,
						"classId" : +classId,
						"sectionId" : +sectionId,
						"sectionWiseFeeId" : +sectionWiseFeeId,
					},
					success : function(data) {
						var obj = JSON.parse(data);
						if (obj == 'true') {
							$("#msg").addClass("error").append(
									"Alloted Fee Deleted Successfully");
						} else {
							$("#msg")
									.addClass("error")
									.append(
											"Unable To Delete, This Alloted Fee Already Paid By Student");
						}
						showAllotedFees();
					},
					error : function(e) {
						alert('Error: ' + e);
					}
				});
	}
</script>
<div class="content">
	<div id="content-header" style="height: 150px;">
		<img alt="Show_settings" src="${img_url}/sfees.jpg"
			style="width: 50px; margin-top: -12px;">
		<h1>Section-Wise Fee Allotment</h1>
		<h3>Allot Fee to students of same class and section</h3>
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

	<table style="width: 750px; height: 200px;">
		<f:form action="save-allotsection-wisefee"
			commandName="SectionWiseFeeDTO" onsubmit="return validateform();">
			<f:hidden path="monthId" id="monthId" />
			<f:hidden path="installment" id="installmentName" />
			<tr>
				<td style="width: 200px;">Session</td>
				<td><f:select id="sessionId" required="required"
						onchange="showhideData();" style="width: 250px;" path="sessionId">
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
					</f:select></td>
				<td></td>
			</tr>

			<tr>
				<td style="width: 200px;">Class</td>
				<td><f:select id="classId" required="required"
						onchange="getSectionList(this.value);" style="width: 250px;"
						path="classId">
						<option value="">Select a class</option>
						<c:forEach var="list" items="${classList}">
							<f:option value="${list.classId}">${list.className}</f:option>
						</c:forEach>
					</f:select></td>
				<td></td>
			</tr>
			<tr>
				<td style="width: 200px;">Section</td>
				<td><f:select id="sectionId" required="required"
						onchange="showAllotedFees();" style="width: 250px;"
						path="sectionId">
						<option value="">Select a Section</option>

					</f:select></td>
			</tr>

			<tr>
				<td style="width: 200px;">Category</td>
				<td><f:select id="feesCategoriesId" required="required"
						style="width: 250px;" onchange="showhideData();"
						path="feesCategoriesId">
						<option value="">Select a category</option>
						<c:forEach var="list" items="${FeeCategories}">
							<f:option value="${list.feeCategoryId}">${list.feeCategoryName}</f:option>
						</c:forEach>
					</f:select></td>
				<td></td>
			</tr>

			<tr>
				<td style="width: 200px;">Select type</td>
				<td style="width: 250px;"><input type="radio"
					required="required" name="Radio" id="year" value="13"
					onclick="getnew(this.value);">Monthly <input type="radio"
					required="required" name="Radio" id="monthRadio" value="monthRadio"
					onclick="getnew(this.value);">Yearly <input type="radio"
					required="required" name="Radio" id="quaterly" value="quaterly"
					onclick="getnew(this.value);">Quaterly</td>
				<td style="padding-left: 35px; width: 250px;">
					<div id="monthname"></div>
					<div id="installment"></div>
				</td>
			</tr>
			<tr>
				<td style="width: 200px;">Amount</td>
				<td><f:input path="feeAmount" required="required"
						id="feeAmount" placeholder="Enter Amount" style="width: 200px;" />
					<div id="exist"></div></td>
				<td><div id="paidAmountmsg"></div></td>
				<td><div id="monthmsg"></div></td>
			</tr>
			<tr>
				<td></td>
				<td><input type="submit" id="Allot" name="submit" value="Allot"
					style="width: 87px; height: 32px;"></td>
			</tr>
			<tr>
				<td></td>
				<td><div id="fontmsg"></div></td>
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
	<div id="msg"></div>

	<div id="showsectionwisefees">
		<c:if test="${!sectionfeelist.isEmpty()}">

			<div class="span12" style="margin-left: 0px; width: 1059px;"></div>
			<div style="padding: 10px 0 0;" class="widget-body">
				<div class="block">
					<div class="head blue">
						<div class="icon">
							<span class="ico-pen-2"></span>
						</div>
						<h2 id="allotclass">Alloted Fees SectionWise</h2>
						<ul class="buttons">
							<li><a return false; href="#"><div class="icon">
										<span class="ico-info"></span>
									</div></a></li>
						</ul>
					</div>

					<div id="sectionwisefees"></div>
				</div>
			</div>
		</c:if>
	</div>
	<div class="separator"></div>



</div>