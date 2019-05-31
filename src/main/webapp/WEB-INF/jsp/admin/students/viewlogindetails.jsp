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
#msg {
	color: red;
	font-weight: normal;
	font-size: 15px;
	padding: 2px 8px 0px;
	margin-top: 2px;
	margin-bottom: -2px;
}
</style>
<script>
	function showdialogBox(value) {
		$("#appendFeeCategoryId").empty();
		$(".feecategorycreateedit").show();
		$("#appendFeeCategoryIds").empty();
		$(".feecategorycreateedits").show();
	}
	function hidefeecategorycreateedit() {
		$("#feeCategoryNamemsg").empty();
		$("#password").val('');
		$(".feecategorycreateedit").hide();
	}
	function hidefeecategorycreateedits() {
		$("#feeCategoryNamemsgs").empty();
		$("#passwords").val('');
		$(".feecategorycreateedits").hide();
	}
	function getstudentlogindetails(classId) {
		document.getElementById("msg").innerHTML = "";
		var sessionId = $('#sessionId').val();
		var pageno = '1';
		var url = 'getstudentlogindetails/' + classId + '/' + sessionId + '/'
				+ pageno;
		$
				.ajax({
					url : url,

					type : 'POST',
					success : function(data, status) {

						$("#Students").empty();

						var j = JSON.parse(data);
						var st = "";
						var length = j.length;
						if (length == 0) {
							st = '<div class="failedmsg">There are no students</div>';
						} else {
							st = st
									+ '<div  style="margin-top: 51px;"><div class="widget-body"  style="padding: 10px 0px 0px; margin-top: -50px;"><div class="separator"></div><div class="btn-group" style="width: 400px;">'
									+ '</div><div class="block"><div class="head blue"><h4 style="text-align:center">Students Login Details</h4><span>Filter by name </span><input type="text" name="firstName" onkeyup="getFiltered(this.value);" style="width: 168px; height: 20px;background-color:gray;"></div>'
							st = '<table class="table table-bordered table-primary"><thead><tr><th>S.no</th><th>Student Name</th><th>Roll no.</th><th>User Name</th><th>Password</th><th>Action</th></tr></thead><tbody>';
							for ( var i = 0; i < length; i++) {
								if(j[i].transfer.match('YES')){
								st += '<tr><td>'
										+ (i + 1)
										+ '. </td><td><span color="RED">'
										+ j[i].firstName
										+ " "
										+ j[i].middleName
										+ " "
										+ j[i].lastName
										+ '</span></td><td>'
										+ j[i].rollno
										+ '</td><td>'
										+ j[i].username
										+ '</td><td>'
										+ j[i].password
										+ '</td><td><a href="#">'
										
										+'<span class="label label-danger" disabled="true">Change</span></a></td></tr>';
								}else{
									
									st += '<tr><td>'
										+ (i + 1)
										+ '. </td><td>'
										+ j[i].firstName
										+ " "
										+ j[i].middleName
										+ " "
										+ j[i].lastName
										+ '</td><td>'
										+ j[i].rollno
										+ '</td><td>'
										+ j[i].username
										+ '</td><td>'
										+ j[i].password
										+ '</td><td><a href="#">'
										
										+'<span class="label label-success" disabled="true">Change</span></a></td></tr>';
									
								}
							}
							st += '</table>';
							for ( var i = 0; i < 1; i++) {
								st += '<table style="margin-left: 461px;"><tr style="width: 10px;">';
								if (j[i].pageno > 1) {
									var p = j[i].pageno - 1;
									st += '<td style="text-align: left;"><a href="javascript:getNextLogindetails(p)">Previous</a></td>'
								}
								st += '<td style="text-align: center;">&nbsp;&nbsp;</td>';
								for ( var k = 1; k < j[i].totalpage; k++) {
									if (k == j[i].pageno) {
										st += '<td style="text-align: left;">'
												+ k + '</td>';
									} else
										st += '<td style="text-align: left;"><a href=javascript:getNextLogindetails('
												+ k + ')>' + k + '</a></td>';
								}
								st += '<td style="text-align: center;">&nbsp;&nbsp;</td>';
								if (j[i].pageno < j[i].totalpage) {
									var p = j[i].pageno + 1;

									st += '<td style="text-align: left;"><a href="javascript:getNextLogindetails(p)">Next</a></td>';
								}
								st += '</tr></table>';
							}
						}
						$("#Students").append(st);
					},
					error : function(error, status) {
					}
				});
	}
	function getNextLogindetails(pageno) {
		document.getElementById("msg").innerHTML = "";
		var sessionId = $('#sessionId').val();
		var classId = $('#classId').val();
		var url = 'getstudentlogindetails/' + classId + '/' + sessionId + '/'
				+ pageno;
		$
				.ajax({
					url : url,

					type : 'POST',
					success : function(data, status) {

						$("#Students").empty();

						var j = JSON.parse(data);
						var st = "";
						var length = j.length;
						if (length == 0) {
							st = '<div class="failedmsg">There Are No Students</div>';
						} else {
							st = st
									+ '<div  style="margin-top: 51px;"><div class="widget-body"  style="padding: 10px 0px 0px; margin-top: -50px;"><div class="separator"></div><div class="btn-group" style="width: 400px;">'
									+ '</div><div class="block"><div class="head blue"><h4 style="text-align:center">Students Login Details</h4><span>Filter by name</span><input type="text" name="firstName" style="width: 168px; height: 20px;background-color:gray;"onkeyup="getFiltered(this.value);"></div>'
							st = '<table class="table table-bordered table-primary"><thead><tr><th>S.no</th><th>Student Name</th><th>Roll no.</th><th>User Name</th><th>Password</th><th>Action</th></tr></thead><tbody>';
							for ( var i = 0; i < length; i++) {
								st += '<tr><td>'
										+ (i + 1)
										+ '. </td><td>'
										+ j[i].firstName
										+ " "
										+ j[i].middleName
										+ " "
										+ j[i].lastName
										+ '</td><td>'
										+ j[i].rollno
										+ '</td><td>'
										+ j[i].username
										+ '</td><td>'
										+ j[i].password
										+ '</td><td><a href="#">'
										
										+ '<span class="label label-success">Change</span></a></td></tr>';
							}
							st += '</table>';
							for ( var i = 0; i < 1; i++) {
								st += '<table style="margin-left: 461px;"><tr style="width: 10px;">';
								if (j[i].pageno > 1) {
									var p = j[i].pageno - 1;
									st += '<td style="text-align: left;"><a href="javascript:getNextLogindetails('
											+ p + ')">Previous</a></td>'
								}
								st += '<td style="text-align: center;">&nbsp;&nbsp;</td>';
								for ( var k = 1; k < j[i].totalpage; k++) {
									if (k == j[i].pageno) {
										st += '<td style="text-align: left;">'
												+ k + '</td>';
									} else
										st += '<td style="text-align: left;"><a href=javascript:getNextLogindetails('
												+ k + ')>' + k + '</a></td>';
								}
								st += '<td style="text-align: center;">&nbsp;&nbsp;</td>';
								if (j[i].pageno < j[i].totalpage) {
									var p = j[i].pageno + 1;

									st += '<td style="text-align: left;"><a href="javascript:getNextLogindetails('
											+ p + ')">Next</a></td>';
								}
								st += '</tr></table>';
							}
						}
						$("#Students").append(st);
					},
					error : function(error, status) {
					}
				});
	}
	function getFiltered(firstname) {

		var sessionId = $('#sessionId').val();
		var classId = $('#classId').val();

		if ((sessionId == "" || sessionId == null)
				|| (classId == "" || classId == null)) {
			$("#Students").empty();
			document.getElementById("msg").innerHTML = "* This field is required";

		}

		else if (firstname == '') {
			getstudentlogindetails($("#classId").val());
		}

		else {
			document.getElementById("msg").innerHTML = "";

			var url = 'getlogindetailsbyname/' + classId + '/' + sessionId
					+ '/' + firstname;
			$
					.ajax({
						url : url,

						type : 'POST',
						success : function(data, status) {

							$("#Students").empty();
							$("#filtered").empty();

							var j = JSON.parse(data);
							var st = "";
							var length = j.length;
							if (length == 0) {
								st = '<div class="failedmsg">There Are No Students</div>';
							} else {
								st = '<div style="margin-top: 51px;"><div class="widget-body"  style="padding: 10px 0px 0px; margin-top: -50px;"><div class="separator"></div><div class="btn-group" style="width: 400px;">'
										+ '</div><div class="block"><div class="head blue"><h4 style="text-align:center">Students Login Details</h4><span>Filter by name</span><input type="text" name="firstName" style="width: 168px; height: 20px;background-color:gray;"onkeyup="getFiltered(this.value);"></div>'
								st = '<table class="table table-bordered table-primary"><thead><tr><th>S.no</th><th>Student Name</th><th>Roll no.</th><th>User Name</th><th>Password</th><th>Action</th></tr></thead><tbody>';
								for ( var i = 0; i < length; i++) {
									st += '<tr><td>'
											+ (i + 1)
											+ '. </td><td>'
											+ j[i].firstName
											+ " "
											+ j[i].middleName
											+ " "
											+ j[i].lastName
											+ '</td><td>'
											+ j[i].rollno
											+ '</td><td>'
											+ j[i].username
											+ '</td><td>'
											+ j[i].password
											+ '</td><td><a href="#">'
											
											+ '<span class="label label-success">Change</span></a></td></tr>';
									st += '<input type="hidden" id="firstname" name="firstname" value="'+firstname+'"/>'
								}
								st += '</table>';
							}
							$("#Students").append(st);
						},
						error : function(error, status) {
						}
					});
		}
	}
	function showhideData() {
		$("#Students").empty();
		$("#classId").val('');

	}
	function editPassword(id, pageno) {
		$("#appendFeeCategoryId").empty();
		$("#feeCategoryNamemsg").empty();
		$("#myModalLabel").text("Change Password");
		$("#appendFeeCategoryId")
				.append(
						'<input type="hidden" id="admissionNo" name="admissionNo" value="'+id+'"/><input type="hidden" id="pageno" name="pageno" value="'+pageno+'"/>');

		$(".feecategorycreateedit").show();

	}
	function editPasswordbyname(id) {
		$("#appendFeeCategoryIds").empty();
		$("#feeCategoryNamemsgs").empty();
		$("#myModalLabels").text("Change Password");
		$("#appendFeeCategoryIds")
				.append(
						'<input type="hidden" id="admissionNo" name="admissionNo" value="'+id+'"/>');

		$(".feecategorycreateedits").show();

	}
	function updatePassword() {
		$("#feeCategoryNamemsg").empty();
		var flage = true;

		if ($("#password").val() == '') {
			$("#feeCategoryNamemsg").append(
					'<font color="red">This field is required</font>');
			flage = false;
		}
		if (flage == true) {
			var changeId = $('#admissionNo').val();
			var newpassword = $('#password').val();
			var sessionId = $('#sessionId').val();
			var classId = $('#classId').val();
			var pageno = $('#pageno').val();

			var url = 'updatepassword/' + changeId + '/' + newpassword + '/'
					+ sessionId + '/' + classId + '/' + pageno;
			$
					.ajax({
						url : url,

						type : 'POST',
						success : function(data, status) {
							$(".feecategorycreateedit").hide();
							$("#Students").empty();

							var j = JSON.parse(data);
							var st = "";
							var length = j.length;
							if (length == 0) {
								st = '<div class="alert alert-success"><h5 align="center"><font color="red"><b>There are no students</b></font></h5></div>';
							} else {
								st = st
										+ '<div  style="margin-top: 51px;"><div class="widget-body"  style="padding: 10px 0px 0px; margin-top: -50px;"><div class="separator"></div><div class="btn-group" style="width: 400px;">'
										+ '</div><div class="block"><div class="head blue"><h4 style="text-align:center">Students Login Details</h4><span>Filter by name</span><input type="text" name="firstName" style="width: 168px; height: 20px;background-color:gray;"onkeyup="getFiltered(this.value);"></div>'
								st = '<table class="table table-bordered table-primary"><thead><tr><th>S.no</th><th>Student Name</th><th>Roll no.</th><th>User Name</th><th>Password</th><th>Action</th></tr></thead><tbody>';
								for ( var i = 0; i < length; i++) {
									st += '<tr><td>'
											+ (i + 1)
											+ '. </td><td>'
											+ j[i].firstName
											+ " "
											+ j[i].middleName
											+ " "
											+ j[i].lastName
											+ '</td><td>'
											+ j[i].rollno
											+ '</td><td>'
											+ j[i].username
											+ '</td><td>'
											+ j[i].password
											+ '</td><td><a href="#">'
											
											+ '<span class="label label-success">Change</span></a></td></tr>';
								}
								st += '</table>';
								for ( var i = 0; i < 1; i++) {
									st += '<table style="margin-left: 461px;"><tr style="width: 10px;">';
									if (j[i].pageno > 1) {
										var p = j[i].pageno - 1;
										st += '<td style="text-align: left;"><a href="javascript:getNextLogindetails('
												+ p + ')">Previous</a></td>'
									}
									st += '<td style="text-align: center;">&nbsp;&nbsp;</td>';
									for ( var k = 1; k < j[i].totalpage; k++) {
										if (k == j[i].pageno) {
											st += '<td style="text-align: left;">'
													+ k + '</td>';
										} else
											st += '<td style="text-align: left;"><a href=javascript:getNextLogindetails('
													+ k
													+ ')>'
													+ k
													+ '</a></td>';
									}
									st += '<td style="text-align: center;">&nbsp;&nbsp;</td>';
									if (j[i].pageno < j[i].totalpage) {
										var p = j[i].pageno + 1;

										st += '<td style="text-align: left;"><a href="javascript:getNextLogindetails('
												+ p + ')">Next</a></td>';
									}
									st += '</tr></table>';
								}
							}
							$("#Students").append(st);
						},
						error : function(error, status) {
						}
					});
		}
	}
	function updatePasswordbyname() {
		$("#feeCategoryNamemsgs").empty();
		var flage = true;

		if ($("#passwords").val() == '') {
			$("#feeCategoryNamemsgs").append(
					'<font color="red">This field is required</font>');
			flage = false;
		}
		if (flage == true) {
			var changeId = $('#admissionNo').val();
			var firstname = $('#firstname').val();
			var newpassword = $('#passwords').val();
			var sessionId = $('#sessionId').val();
			var classId = $('#classId').val();

			var url = 'updatepasswordbyname/' + changeId + '/' + newpassword
					+ '/' + sessionId + '/' + classId + '/' + firstname;
			$
					.ajax({
						url : url,

						type : 'POST',
						success : function(data, status) {

							$("#Students").empty();
							$(".feecategorycreateedits").hide();

							var j = JSON.parse(data);
							var st = "";
							var length = j.length;
							if (length == 0) {
								st = '<div class="alert alert-success"><h5 align="center"><font color="red"><b>There are no students</b></font></h5></div>';
							} else {
								st = '<div style="margin-top: 51px;"><div class="widget-body"  style="padding: 10px 0px 0px; margin-top: -50px;"><div class="separator"></div><div class="btn-group" style="width: 400px;">'
										+ '</div><div class="block"><div class="head blue"><h4 style="text-align:center">Students Login Details</h4><span>Filter by name</span><input type="text" name="firstName" style="width: 168px; height: 20px;background-color:gray;"onkeyup="getFiltered(this.value);"></div>'
								st = '<table class="table table-bordered table-primary"><thead><tr><th>S.no</th><th>Student Name</th><th>Roll no.</th><th>User Name</th><th>Password</th><th>Action</th></tr></thead><tbody>';
								for ( var i = 0; i < length; i++) {
									st += '<tr><td>'
											+ (i + 1)
											+ '. </td><td>'
											+ j[i].firstName
											+ " "
											+ j[i].middleName
											+ " "
											+ j[i].lastName
											+ '</td><td>'
											+ j[i].rollno
											+ '</td><td>'
											+ j[i].username
											+ '</td><td>'
											+ j[i].password
											+ '</td><td><a href="#">'
											+ j[i].admissionNo
											+ '<span class="label label-success">Change</span></a></td></tr>';
									st += '<input type="hidden" id="firstname" name="firstname" value="'+j[i].firstName+'"/>'
								}
								st += '</table>';
							}
							$("#Students").append(st);
						},
						error : function(error, status) {
						}
					});
		}
	}
</script>
<style>
.feecategorycreateedit {
	display: none;
	background-color: white;
	border: 1px solid grey;
	width: 450px;
	height: 266px;
	border-radius: 6px;
	margin-top: 60px;
	left: 220px;
	z-index: 1;
	position: absolute;
	background-color: white;
}

.feecategorycreateedit-header {
	width: 450px;
	margin-top: -10px;
	border-bottom: 1px solid gray;
	height: 50px;
}

.feecategorycreateedits {
	display: none;
	background-color: white;
	border: 1px solid grey;
	width: 450px;
	height: 266px;
	border-radius: 6px;
	margin-top: 60px;
	left: 220px;
	z-index: 1;
	position: absolute;
	background-color: white;
}

.feecategorycreateedits-header {
	width: 450px;
	margin-top: -10px;
	border-bottom: 1px solid gray;
	height: 50px;
}
</style>
<div class="feecategorycreateedit">
	<div class="feecategorycreateedit-header">
		<a href="javascript:hidefeecategorycreateedit();" class="close"
			data-dismiss="modal" style="margin-right: 10px; margin-top: 10px;"
			aria-hidden="true">×</a>
		<h3 id="myModalLabel">Change Password</h3>
	</div>
	<div class="row-fluid" style="margin-top: 20px;">
		<div class="block-fluid">
			<div id="appendFeeCategoryId"></div>
			<div class="row-form" style="height: 50px;">
				<div class="span12">
					<span class="top title">Password<font color="red">*</font>
						:-
					</span> <input id="password" name="password" value="" maxlength="15"
						style="width: 266px; margin-top: -25px; margin-left: 122px;">
					<div id="feeCategoryNamemsg"></div>
				</div>
			</div>
		</div>
	</div>
	<div class="feecategorycreateedit-footer">
		<a href="javascript:updatePassword();"><span
			class="label label-success"
			style="margin-left: 332px; height: 23px; width: 46px;"><b>Change</b></span></a>

	</div>

</div>
<div class="feecategorycreateedits">
	<div class="feecategorycreateedits-header">
		<a href="javascript:hidefeecategorycreateedits();" class="close"
			data-dismiss="modal" style="margin-right: 10px; margin-top: 10px;"
			aria-hidden="true">×</a>
		<h3 id="myModalLabels">Change Password</h3>
	</div>
	<div class="row-fluid" style="margin-top: 20px;">
		<div class="block-fluid">
			<div id="appendFeeCategoryIds"></div>
			<div class="row-form" style="height: 50px;">
				<div class="span12">
					<span class="top title">Password<font color="red">*</font>
						:-
					</span> <input id="passwords" name="passwords" value=""
						style="width: 266px; margin-top: -25px; margin-left: 122px;">
					<div id="feeCategoryNamemsgs"></div>
				</div>
			</div>
		</div>
	</div>
	<div class="feecategorycreateedits-footer">
		<a href="javascript:updatePasswordbyname();"><span
			class="label label-success"
			style="margin-left: 332px; height: 23px; width: 46px;"><b>Change</b></span></a>

	</div>

</div>
<div class="content">
	<div id="content-header" style="height: 150px;">
		<img alt="Show_settings" src="${img_url}/stulogin.jpg"
			style="width: 50px; margin-top: -12px;">
		<h1>Students Login Details</h1>
		<h3>Check ClassWise Student Login Details</h3>
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

	<table
		style="width: 700px; height: 0px; margin-left: 231px; margin-top: 0px;">

		<tr>
			<td style="width: 72px;">Session</td>
			<td><select id="sessionId" required="required"
				onchange="showhideData();" style="width: 250px;" name="sessionId">
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
			</select></td>
			<td></td>
		</tr>
		<tr>
			<td style="width: 72px;">Class</td>
			<td style="width: 100px;"><select id="classId"
				onchange="getstudentlogindetails(this.value);" style="width: 250px;"
				name="classId">
					<option value="">Select a class</option>
					<c:forEach var="list" items="${classList}">
						<option value="${list.classId}">${list.className}</option>
					</c:forEach>
			</select></td>
			<td><p class="msg" id="msg"></p></td>
		</tr>
	</table>
	<div class="separator"></div>


	<div id="up">
		<div class="row-fluid">
			<div class="span12">
				<div class="block">
					<div class="head blue" style="margin-top: 18px;">
						<div class="icon">
							<span class="ico-pen-2"></span>
						</div>
						<h2>Student Login Details</h2>
						<ul class="buttons">
							<li><span>Filter By Name</span> <input type="text"
								name="firstName"
								style="width: 168px; height: 25px; background-color: lightblue"
								onkeyup="getFiltered(this.value);"></li>
						</ul>
					</div>
					<div class="data-fluid" id="Students"></div>
				</div>
			</div>
		</div>
	</div>
</div>