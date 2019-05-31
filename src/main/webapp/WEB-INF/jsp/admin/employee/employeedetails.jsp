<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url value="/style/theme/images" var="imageurl" />
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/" var="baseurl"></spring:url>
<spring:url value="/img" var="img_url" />
<spring:url value="/style" var="style_url" />
<spring:url value="/css" var="css_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/home.css">
<link rel="stylesheet" type="text/css" href="${css_url}/setting.css">
<script type="text/javascript">
	function getEmployee(firstName) {
		$("#alllist").hide();
		$("#failedmsg").empty();
		if(firstName=='')
			{
			$("#alllist").show();
		$("#employees").empty();
			}
		var url = '${baseurl}getEmployee/' + firstName;
		$
				.ajax({
					url : url,
					type : 'POST',
					success : function(data, status) {
						$("#employees").empty();
						var j = JSON.parse(data);
						var length = j.length;
						var st = "";
						if (length == 0) {
							st = '<div class="failedmsg">There are no employees</div>';
						} else {
							st = '<div><div class="widget-body" style="padding: 10px 0 0;"><div class="separator"></div><div class="btn-group" style="width: 1059px;">'
									+ '</div><div class="block"><div class="head blue"><div class="icon"><span class="ico-pen-2"></span></div><h2>Employee List</h2></div>'
									+ '<table class="table table-bordered table-primary"><thead><tr><th>Employee Name</th><th>Login User Id</th><th>Login User Password</th><th>Operations</th><th>Operations</th><th>Operations</th></tr></thead><tbody>';

							for ( var i = 0; i < length; i++) {
								st = st
										+ '<tr><td style="width: 200px;"><a href="show-employee-details?id='
										+ j[i].id
										+ '">'
										+ j[i].firstName
										+ '\t'
										+ j[i].lastName
										+ '</td>'
										+ '<td>'
										+ j[i].userName
										+ '</td>'
										+ '<td>'
										+ j[i].password
										+ '</td>'
										+ '<td><a href="edit-employee-details?id='
										+ j[i].id
										+ '">Edit</a></td>'
										+ '<td><a href="javascript:removeEmployee('
										+ j[i].id
										+ ')">Delete</a></td>'
										+ '<td><a href="change-emp-password-page?id='
										+ j[i].id
										+ '">Change Password</a></td></tr>';
							}
							st = st + '</tbody></table></div></div></div>';
						}
						$("#employees").append(st);
					},
					error : function(error, status) {
					}
				});
	}
    function removeEmployeefromall(id)
    {
    	var url = '${baseurl}removeEmployeefromall/' + id;
		$
				.ajax({
					url : url,
					type : 'POST',
					success : function(data, status) {
						$("#alllist").empty();
						var j = JSON.parse(data);
						var st = "";
						var length = j.length;
						if (length == 0) {
							st = '<div class="failedmsg">Deleted Successfully</div>';
						} else {
							st = '<div class="failedmsg">Deleted Successfully</div><div><div class="widget-body" style="padding: 10px 0 0;"><div class="separator"></div><div class="btn-group" style="width: 1059px;">'
									+ '</div><div class="block"><div class="head blue"><div class="icon"><span class="ico-pen-2"></span></div><h2>Employee List</h2></div>'
									+ '<table class="table table-bordered table-primary"><thead><tr><th>Employee Name</th><th>Login User Id</th><th>Login User Password</th><th>Operations</th><th>Operations</th><th>Operations</th></tr></thead><tbody>';
							for ( var i = 0; i < length; i++) {
								st = st
										+ '<tr><td style="width: 200px;"><a href="show-employee-details?id='
										+ j[i].id
										+ '">'
										+ j[i].firstName
										+ '\t'
										+ j[i].lastName
										+ '</td>'
										+ '<td>'
										+ j[i].userName
										+ '</td>'
										+ '<td>'
										+ j[i].password
										+ '</td>'
										+ '<td><a href="edit-employee-details?id='
										+ j[i].id
										+ '">Edit</a></td>'
										+ '<td><a href="javascript:void(0)" onclick="removeEmployee('
										+ j[i].id + ')">Delete</a></td>'
										+ '<td><a href="change-emp-password-page?id='
										+ j[i].id
										+ '">Change Password</a></td></tr>';
							}
							st = st + '</tbody></table></div></div></div>';
						}
						$("#alllist").append(st);
					},
					error : function(error, status) {
					}
				});
    	
    }
    
	function removeEmployee(id) {
		var firstName = $("#firstName").val();
		var url = '${baseurl}removeEmployee/' + id + '/' + firstName;
		$
				.ajax({
					url : url,
					type : 'POST',
					success : function(data, status) {
						$("#employees").empty();
						var j = JSON.parse(data);
						var st = "";
						var length = j.length;
						if (length == 0) {
							st = '<div class="failedmsg">Deleted Successfully</div>';
						} else {
							st = '<div class="failedmsg">Deleted Successfully</div><div><div class="widget-body" style="padding: 10px 0 0;"><div class="separator"></div><div class="btn-group" style="width: 1059px;">'
									+ '</div><div class="block"><div class="head blue"><div class="icon"><span class="ico-pen-2"></span></div><h2>Employee List</h2></div>'
									+ '<table class="table table-bordered table-primary"><thead><tr><th>Employee Name</th><th>Login User Id</th><th>Login User Password</th><th>Operations</th><th>Operations</th><th>Operations</th></tr></thead><tbody>';
							for ( var i = 0; i < length; i++) {
								st = st
										+ '<tr><td style="width: 200px;"><a href="show-employee-details?id='
										+ j[i].id
										+ '">'
										+ j[i].firstName
										+ '\t'
										+ j[i].lastName
										+ '</td>'
										+ '<td>'
										+ j[i].userName
										+ '</td>'
										+ '<td>'
										+ j[i].password
										+ '</td>'
										+ '<td><a href="edit-employee-details?id='
										+ j[i].id
										+ '">Edit</a></td>'
										+ '<td><a href="javascript:void(0)" onclick="removeEmployee('
										+ j[i].id + ')">Delete</a></td>'
										+ '<td><a href="change-emp-password-page?id='
										+ j[i].id
										+ '">Change Password</a></td></tr>';
							}
							st = st + '</tbody></table></div></div></div>';
						}
						$("#employees").append(st);
					},
					error : function(error, status) {
					}
				});
	}
</script>
<div class="content">
	<div id="content-header" style="height: 150px;">
		<img alt="Show_settings"
			src="${img_url}/employeeImages/EmployeeDetails.png"
			style="width: 57px;">
		<h1>View Employees</h1>
		<h3>Search Employee to View Details</h3>
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
	<f:form action="employee-details" method="post"
		commandName="employeeDTO" style="margin-left: 50px;">
		<br>
		<table style="width: 1059px;">
			<tr>
				<td style="width: 200px;">Employee Name:</td>
				<td><f:input path="firstName" required="required"
						id="firstName" onkeyup="getEmployee(this.value)"
						placeholder="Enter First Name" style="width: 300px;" />
					<div id="exist"></div></td>
			</tr>
		</table>
	</f:form>
	<br> <br>
	<hr>

	<div id="employees"></div>
	<div id="alllist">
		<div>
			<div class="widget-body" style="padding: 10px 0 0;">
				<div class="separator"></div>
				<div class="btn-group" style="width: 1059px;"></div>
				<div class="block">
					<div class="head blue">
						<div class="icon">
							<span class="ico-pen-2"></span>
						</div>
						<h2>Employee List</h2>
					</div>

					<table class="table table-bordered table-primary">
						<thead>
							<tr>
								<th>Employee Name</th>
								<th>Login User Id</th>
								<th>Login User Password</th>
								<th>Attendace Report</th>
								<th>Operations</th>
								<th>Operations</th>
								<th>Operations</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="list" items="${allemployees}" varStatus="loop">
								<tr>
									<td style="width: 200px;"><a
										href="show-employee-details?id=${list.id}">
											${list.firstName}&nbsp${list.lastName}</a></td>
									<td>${list.userName}</td>
									<td>${list.password}</td>
									<td><a href="perticular-emp-attendance.html?id=${list.id}">Attendence</a></td>
									<td><a href="edit-employee-details?id=${list.id}">Edit</a></td>
									<td><a href="javascript:removeEmployeefromall('${list.id}')">Delete</a></td>
									<td><a href="change-emp-password-page?id=${list.id}">Change
											Password</a></td>
								</tr>

							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>