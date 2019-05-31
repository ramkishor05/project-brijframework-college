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
						$('#msg').empty();
						var value = JSON.parse(data);

						if (value.length == 0) {
							var classAssignDetails='No advance taken in this session';
						} else {
							var classAssignDetails = '<table class="table table-bordered table-primary"style="width: 1059px;">'
									+ '<thead><tr><th>SL No.</th><th>Date</th><th>Paid Amount</th></tr></thead>';
							for (var i = 0; i < value.length; i++) {
								classAssignDetails += '<tbody><tr><td>'
										+ (i + 1)
										+ '</td><td>'
										+ value[i].dateOfPayment
										+ '</td><td>'
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
	
	
</script>
<div class="content">
	<div id="content-header" style="height: 150px;">
		<img alt="Show_settings" src="${img_url}/takeattendance.png"
			style="width: 57px;">
		<h1>Classes Assign</h1>
		<h3>Classes Assign To Teacher</h3>
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

	<f:form commandName="AdvanceSalaryDTO" method="POST" id="validate"
		action="submit-advance-payment">
		<div id="searches" style="height: auto; width: auto;">
			<br> <br> <br>
			<table>
			<tr>
					<td style="width: 200px;">Select Employee</td>
					<td><f:select id="employeeId" class=" select validate[required]"
							style="width: 250px;" onchange="getPreviousAdvance(this.value);" required="required"
							path="employeeId">
							<option value="">Select a Employee</option>
							<c:forEach var="list" items="${TeacherList}">
								<option value="${list.employeeId}">${list.firstName}</option>
							</c:forEach>
						</f:select></td>
					<td></td>
				</tr>
				<tr>
					<td style="width: 200px;">Enter Amount</td>
					<td><f:input path="paidAmount" value="" id="paidAmount"
							style="width: 250px;" maxlength="5"
							class="validate[required,custom[integer],minSize[1],maxSize[5]]" /></td>
					<td><div id="errmsg"></div></td>

				</tr>

				<tr>
					<td></td>
					<td>
						<div id="subButton" style="width: 654px; float: left;">
							<input type="submit" value="Submit">
						</div>
					</td>
					<td></td>
				</tr>
			</table>


			<div id="alertmsg"></div>
		</div>
	</f:form>
	<hr>
	<c:if test="${! empty msg && msg!='0'}">
		<div id='msg' class="successmsg">${msg}</div>
	</c:if>
	<div style="padding: 10px 0 0;" class="widget-body">
		<div class="block">
			<div class="head blue">
				<div class="icon">
					<span class="ico-pen-2"></span>
				</div>
				<h2>Previous Advance Payments</h2>
			</div>
			<div id="ShowDetails"></div>
		</div>
	</div>
</div>