<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url value="/style/theme/images" var="imageurl" />
<c:url value="/style/theme/images" var="imageurl" />
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/img" var="img_url" />
<spring:url value="/css" var="css_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/setting.css">
<script type="text/javascript">
	function checkname(firstname) {
		hidemsg();
		$('#exist').empty();
		$('#loading').show();
		$.ajax({
			type : "post",
			url : 'check_employee_role',
			data : {
				'roleName' : firstname
			},
			success : function(data) {
				$('#loading').hide();
				$('#exist').empty();
				var j = JSON.parse(data);
				if (j != null) {
					$('#hide').hide();
					$("#exist").append('*Employee Role Name Already Exist')
							.css('color', 'red').css('font',
									'80%/1.2 Lucida Califunia');
				} else {
					$('#hide').show();
				}
			},
			error : function(e) {
				$('#loading').hide();
			}
		});
	}
	function editEmployeRole(roleId) {
		hidemsg();
		$
				.ajax({
					type : "post",
					url : 'getemployeerole',
					data : {
						"roleId" : roleId
					},
					success : function(data) {
						$('#loading').hide();
						$('#exist').empty();
						var obj = JSON.parse(data);
						$('#id').val(obj.roleName).attr('oninput', '').unbind(
								'click');
						$('#appendid')
								.append(
										'<input type="hidden" name="id" value="'+obj.id+'"></input>');
						$("#validate").attr('action',
								'update-employee-role.html');
						$("#hide").text('Update Role');
						$("#hidebutton").show();
					},
					error : function(e) {
						$('#loading').hide();
					}
				});
	}
	function changeform() {
		hidemsg();
		$('#id').val('');
		$("#exist").empty();
		$('#appendid').empty();
		$("#validate").attr('action', 'add-role');
		$("#hide").text('Add Role');
		$("#hidebutton").hide();
	}
	function hidemsg() {
		$(".successmsg").remove();
	}
</script>
<div class="content">
	<div id="content-header" style="height: 150px;">
		<img alt="Show_settings" src="${img_url}/employee_role.jpg"
			style="width: 50px; margin-top: -12px;">
		<h1>Add Employee Role</h1>
		<h3>Manage Employee Roles</h3>
		<div id="app-back-button">
			<a href="home"><img alt="Back" border="0"
				src="${img_url}/home.png" title="Home"
				style="margin-top: -6px; height: 40px; width: 40px;"></a> <a
				href="#" onclick="javascript:location.reload(true);"><img
				alt="Back" border="0" src="${img_url}/refresh.png" title="Refresh"
				style="margin-top: -6px; height: 40px; width: 40px;"></a> <a
				href="#" onclick="history.back(); return false;"><img alt="Back"
				border="0" src="${img_url}/back.png" title="Back"
				style="margin-top: -6px; height: 40px; width: 40px;"></a>
		</div>
	</div>
	<c:if test="${! empty msg}">
		<div class="successmsg">${msg}</div>
	</c:if>

	<br>

</div>
<div id="content">
	<f:form action="add-role" method="post" commandName="roleDTO"
		id="validate">

		<div class="row-fluid">
			<div class="span6">
				<div class="block">
					<div class="data-fluid">
						<div class="row-form">
							<div class="span5">Employee Role Name:</div>
							<div class="span7">
								<f:input path="roleName" id="id"
									onkeyup="checkname(this.value);"
									class="validate[required,maxSize[15],custom[onlyLetterSp]]"
									placeholder="Enter Role Name" />
								<div id="exist"></div>
							</div>
						</div>
						<div class="row-form">
							<div class="span3" id="appendid"></div>
							<div class="span9">
								<a class="btn btn-success"
									href="javascript:changeform(this.value);" id="hidebutton"
									style="float: right; display: none;">Reset</a>
								<button class="btn btn-success" type="submit" id="hide"
									style="float: right; margin-right: 10px;">Add Role</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</f:form>
</div>
<div class="content">
	<div class="row-fluid">
		<div class="span12">
			<div class="block">
				<div class="data-fluid">
					<table cellspacing="0" cellpadding="0" width="100%" class="table">
						<thead>
							<tr>
								<th width="25%">Employee Role Name:</th>
								<th width="25%">Action</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${EmployeeRoles}" var="EmployeeRole">
								<tr>
									<td>${EmployeeRole.roleName}</td>
									<td width="25%"><a
										href="javascript:editEmployeRole(${EmployeeRole.employeeRoleId})"><span
											class="label label-info">Edit</span></a>|<a
										href="deleted-employee-role.html?roleId=${EmployeeRole.employeeRoleId}"><span
											class="label label-info">Delete</span></a></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>
