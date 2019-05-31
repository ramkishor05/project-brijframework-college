<%@taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<spring:url value="/js" var="js_url" />
<spring:url value="/" var="baseurl"></spring:url>
<spring:url value="/img" var="img_url" />
<spring:url value="/style" var="style_url" />
<spring:url value="/css" var="css_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/setting.css">

<script type="text/javascript">
	function getPreviousAdvance(employeeId) {

		$
				.ajax({
					type : 'post',
					url : 'getadvancepayments',
					data : {
						'employeeId' : employeeId
					},
					success : function(data) {
						$('#ShowDetails').empty();
						$('#msg').remove();
						var value = JSON.parse(data);

						var employeeDetail = '<div style="text-align: center; height: 33px; background-color: rgb(238, 238, 238); color: rgb(0, 136, 204); border: 1px solid lightgray; border-top-left-radius: 10px; border-top-right-radius: 10px; margin-top: 3px; width: 447px;">'
								+ '<a href="show-employee-details?id='
								+ value[0].employeeId
								+ '" target="_blank">'
								+ value[0].firstName
								+ '&nbsp;'
								+ value[0].lastName
								+ '</a></div><div class="row-fluid"  style="border: 1px solid lightgray; height: 113px; border-bottom-left-radius: 10px; border-bottom-right-radius: 10px;"><div class="span6">';
						employeeDetail += '<div class="block"><div class="data-fluid"><div class="row-form"><div class="span5">Mobile :</div>';
						employeeDetail += '<div class="span7">'
								+ value[0].mobile
								+ '</div></div></div><div class="data-fluid"><div class="row-form">';
						employeeDetail += '<div class="span5">Id :</div><div class="span7">'
								+ value[0].employeeId
								+ '</div></div></div></div></div>';
						employeeDetail += '<div class="span6"><div class="block"><div class="data-fluid"><div class="row-form" style="padding-top: 0px;">';
						employeeDetail += '<div class="span3" style="width: 138px; height: 113px;float:right">'
								+ '<img src="${style_url}/employeeImages/'+value[0].imagename+'"'
				+'style="width: 127px; height: 113px;">'
								+ '</div></div></div></div>';
						$("#employeeDetails").append(employeeDetail);
						if (value[0].dateOfPayment == 'no') {
							var classAssignDetails = 'No advance taken in this session';
						} else {
							var classAssignDetails = '<table class="table table-bordered table-primary"style="width: 1059px;">'
									+ '<thead><tr><th>SL No.</th><th>Date</th><th>Paid Amount</th></tr></thead>';
							for (var i = 0; i < value.length; i++) {
								classAssignDetails += '<tbody><tr><td>'
										+ (i + 1) + '</td><td>'
										+ value[i].dateOfPayment + '</td><td>'
										+ value[i].paidAmount
										+ '</td><td></tr>'

							}
							classAssignDetails += '</tbody></table>';

						}
						$('#ShowDetails').append(classAssignDetails);
					},
					error : function(e) {

					}
				});
	}

	function removeZero() {
		var paid = $("#paidAmount").val();
		if (paid == 0) {
			$("#paidAmount").val('');
		}

	}
</script>
<div class="content">
	<div id="content-header" style="height: 150px;">
		<img alt="Show_settings" src="${img_url}/salary.jpg"
			style="width: 57px;">
		<h1>Pay Advance</h1>
		<h3>Pay Advance to Employees</h3>
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
	<div>
		<f:form commandName="AdvanceSalaryDTO" method="POST" id="validate"
			action="submit-advance-payment">
			<div id="searches" style="height: auto; width: auto;">
				<br> <br> <br>
				<table>
					<tr>
						<td style="width: 200px;">Select Employee</td>
						<td><f:select id="employeeId"
								class=" select validate[required]" style="width: 250px;"
								onchange="getPreviousAdvance(this.value);" required="required"
								path="employeeId">
								<option value="" selected="selected">Select a Employee</option>
								<c:forEach var="list" items="${TeacherList}">
									<option value="${list.employeeId}">${list.firstName}&nbsp;${list.lastName}</option>
								</c:forEach>
							</f:select></td>
						<td></td>
					</tr>
					<tr>
						<td style="width: 200px;">Enter Amount</td>
						<td><f:input path="paidAmount" value="" id="paidAmount"
								style="width: 250px;" maxlength="5" onclick="removeZero();"
								class="validate[required,custom[integer],minSize[1],maxSize[5]]" /></td>
						<td><div id="errmsg"></div></td>

					</tr>

					<tr>
						<td></td>
						<td>
							<div id="subButton" style="width: 60px; float: left; margin-top: 9px;">
								<input type="submit" value="Submit" class="button btn-primary">
							</div>
						</td>
						<td></td>
					</tr>
				</table>


				<div id="alertmsg"></div>
			</div>
		</f:form>
		<div id="employeeDetails"
			style="width: 447px; margin-left: 0px; height: 164px; float: right; margin-top: -146px; margin-right: 109px;"></div>
	</div>
	<hr>
	<c:if test="${! empty msg && msg!=null}">
		<div id='msg' class="successmsg">${msg}</div>
	</c:if>
	<div style="padding: 10px 0 0;" class="widget-body">
		<div class="block">
			<div class="head blue" style="width: 959px;">
				<div class="icon">
					<span class="ico-pen-2"></span>
				</div>
				<h2>Previous Advance Payments</h2>
			</div>
			<div id="ShowDetails"></div>
		</div>
	</div>
</div>