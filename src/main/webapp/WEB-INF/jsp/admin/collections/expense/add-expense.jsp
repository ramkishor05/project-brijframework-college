<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:url value="/style/theme/images" var="imageurl" />
<spring:url value="/img" var="img_url" />
<spring:url value="/css" var="css_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/setting.css">
<script>
	$(function() {
		$("#startDate").datepicker();
	});

	$(function() {
		$("#endDate").datepicker();
	});
	function getEmployeebyRole(role) {
		$("#cityid").val('');
		$("#employeeList").empty();
		$
				.ajax({
					type : "post",
					url : 'get-employee-by-role',
					data : {
						'role' : role,
					},
					success : function(data) {

						var j = JSON.parse(data);
						var st = '<div class="widget-body" style="padding: 10px;"><div class="separator"></div><div class="btn-group" style="width: 1059px;"></div>'
								+ '<div class="block"><div class="head blue" style="height:30px;padding:0.5px 0 0 20px;"><h4>Employees</h4></div>'
								+ '<table class="table table-bordered table-primary"><th>Name</th>';
						for (var i = 0; i < j.length; i++) {
							st = st
									+ '<tr><td style="width: 200px;"><a href=javascript:addEmployee("'
									+ j[i] + '");>' + j[i] + '</td></tr>'
						}
						st = st + '</table></div>';
					
					$("#employeeList").append(st);
					},
					error : function(e) {
						$('#loading').hide();
					}
				});
	}
	function addEmployee(name)
	{
		$("#cityid").val(name);
	}
	function restAmount() {
		var total_balance_amount = parseInt(document.getElementById("balance").value);
		var spend_amount = parseInt(document.getElementById("spend").value);
		if (isNaN(spend_amount)) {
			alert("Amount is Not Valid");
		} else {
			if (spend_amount > total_balance_amount) {
				alert("Rest Amount is Greater Than Total Amount");
			} else {
				document.getElementById("balance").value = parseInt(total_balance_amount
						- spend_amount);
			}
		}
	}
</script>

<div class="content">
	<div id="content-header" style="height: 150px;">
		<img alt="Show_settings" src="${img_url}/expense.jpg"
			style="width: 50px;">
		<h1>Add Expenses</h1>
		<h3>add new expense</h3>
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
	<c:if test="${msg!='0'}">
		<div class="alert alert-success"
			style="height: 28px; padding-top: 0px; padding-bottom: 1px; margin-bottom: 0px;">
			<h5 align="center">
				<font color="red"><b>${msg}</b></font>
			</h5>
		</div>
	</c:if>

	<f:form action="add-Expenses-details" method="post"
		commandName="expenseDTO" style="margin-top: 63px; margin-left: 86px;">
		<br>
		<table style="width: 800px;">
			<tr>
				<td><br></td>
			</tr>
			<tr>
				<td style="width: 200px;">Select a Role:</td>
				<td><f:select path="roleName" style="width: 300px;"
						onchange="getEmployeebyRole(this.value);" required="required"
						class=" validate[required]" id="courseId">
						<option value="">--Select Role--</option>
						<c:forEach var="list" items="${rolelist}">
							<f:option value="${list.roleName}"> ${list.roleName} </f:option>
						</c:forEach>
					</f:select></td>
			</tr>
			<tr>
				<td><br></td>
			</tr>
			<tr>
				<td style="width: 200px;">Employee Name:</td>

				<td><f:input path="employeeName" id="cityid"
						class="validate[required,maxSize[2]]" required="required"
						placeholder="Enter Employee Name" style="width: 300px;" />
					<div id="exist"></div></td>

			</tr>
			<tr>
				<td><br></td>
			</tr>
			<tr>
				<td style="width: 200px;">Expense Amount:</td>

				<td><f:input path="expenseAmount" id="spend" pattern="\d+"
						required="required" class="validate[required,maxSize[1]]"
						onchange="restAmount()" placeholder="Enter Spend Amount"
						style="width: 300px;" />
					<div id="exist"></div></td>

			</tr>
			<tr>
				<td><br></td>
			</tr>
			<tr>
				<td style="width: 200px;">Purpose Details:</td>

				<td><f:textarea path="purposeDetails" id="id"
						placeholder="Enter Purpose Details" style="width: 300px;" />
			</tr>
			<tr>
				<td><br></td>
			</tr>

		</table>
		<div class="separator"></div>
		<div class="toolbar bottom tar" id="hide" style="width: 460px;"
			id="hide">
			<div class="btn-group">
				<button class="btn btn-success" type="submit">Add Expenses</button>
			</div>
		</div>
	</f:form>
	</div>
	<div id="employeeList"  style="width: 253px; float: right; margin-top: -343px; margin-right: 86px;"></div>

