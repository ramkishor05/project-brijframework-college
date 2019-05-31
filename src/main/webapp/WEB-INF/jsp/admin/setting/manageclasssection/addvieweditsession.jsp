<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/css" var="css_url" />
<spring:url value="/img" var="img_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/setting.css">
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>CREATE EDIT VIEW FEE CATEGORY</title>
</head>
<script type="text/javascript">
	function showdialogBox(value) {
		$('#FromYear').prop('selectedIndex', 0);
		$("#appendFeeCategoryId").empty();
		$(".feecategorycreateedit").show();
		$('#submitform').attr('action', 'add-session.html');
		$(".feecategorycreateedits").hide();
		$("#successmsg").hide();
		$("#submitbutton").show()
	}
	function showdialogBoxes(value) {
		$('#FromYear').prop('selectedIndex', 0);
		$("#successmsg").hide();
		$("#submitbutton").show()
		$(".feecategorycreateedits").show();
		$(".feecategorycreateedit").hide();
	}
	function hidefeecategorycreateedit() {
		$('#FromYear').prop('selectedIndex', 0);
		$("#feeCategoryNamemsg").empty();
		$("#sessionDuration").val('');
		$(".feecategorycreateedit").hide();
		$("#successmsg").hide();
		$("#submitbutton").show()
	}
	function hidefeecategorycreateedits() {
		$('#FromYear').prop('selectedIndex', 0);
		$(".feecategorycreateedits").hide();
		$("#successmsg").hide();
		$("#submitbutton").show()
	}

	function editSession(id) {
		$("#appendFeeCategoryId").empty();
		$("#sessionDuration").val('');
		$("#feeCategoryNamemsg").empty();
		$
				.ajax({
					type : "post",
					url : 'getsession',
					data : {
						'sessionId' : id
					},
					success : function(data) {
						var obj = JSON.parse(data);
						$("#myModalLabel").text("Edit Session");
						$("#appendFeeCategoryId")
								.append(
										'<input type="hidden" name="sessionId" value="'+id+'"/>');

						$("#sessionDuration").val(obj.sessionDuration);
						$('#submitform').attr('action', 'update-session.html');
						$(".feecategorycreateedit").show();
					},
					error : function(e) {
						alert('Error: ' + e);
					}
				});
	}

	function checkSessionName(sessionName) {
		$.ajax({
			type : "post",
			url : 'check_session_name',
			data : {
				'sessionName' : sessionName
			},
			success : function(data) {
				var obj = JSON.parse(data);
				if (obj == 'YES') {
					if ($("#sessionDuration").val() != sessionName) {
						$("#successmsg").show();
						$("#submitbutton").hide()
					}
				} else {
					$("#successmsg").hide();
					$("#submitbutton").show()
				}
			},
			error : function(e) {
				alert('Error: ' + e);
			}
		});
	}

	function validatesession() {
		$("#feeCategoryNamemsg").empty();
		var f = $("#FromYear").val();
		if (f == "") {
			$("#feeCategoryNamemsg").append(
					'<font color="red">This field is required</font>');
			return false;
		}
		if (f == "") {
			$("#feeCategoryNamemsg").append(
					'<font color="red">This field is required</font>');
			return false;
		}
		$("#sessionDuration").val(f);
		return true;
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
	top: 111px;
}

.feecategorycreateedit-headers {
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
		<h3 id="myModalLabel">Add Session</h3>
	</div>
	<f:form commandName="Session" action="add-session.html" id="submitform"
		onsubmit="return validatesession();">
		<f:hidden path="active" value="true" />
		<div class="row-fluid" style="margin-top: 20px;">
			<div class="block-fluid">
				<div id="appendFeeCategoryId"></div>
				<div class="row-form" style="height: 50px;">
					<div class="span12">
						<span class="top title">Session<font color="red">*</font>
							:-
						</span> <select class="form-control input-sm" name="FromYear"
							id="FromYear" onchange="checkSessionName(this.value);"
							width="200px" id="FromYear">
							<option value="">-Select Year-</option>
							<c:forEach var="i" begin="2000" end="2030">
								<option value="${i}-${i+1}" data-original-title="" title="">${i}-${i+1}</option>
							</c:forEach>
						</select>
						<f:hidden id="sessionDuration" path="sessionDuration" value=""
							style="width: 266px; margin-top: -25px; margin-left: 122px;" />
						<div id="feeCategoryNamemsg"></div>
					</div>
				</div>
			</div>
		</div>
		<div class="feecategorycreateedit-footer" style="float: right">
			<button class="btn btn-primary" data-dismiss="modal" type="submit"
				id="submitbutton" aria-hidden="true">Save updates</button>
			<a class="btn btn-warning" data-dismiss="modal"
				href="javascript:hidefeecategorycreateedit();"
				style="margin-right: 15px" aria-hidden="true">Close</a>
		</div>
	</f:form>
</div>

<div class="feecategorycreateedits">
	<div class="feecategorycreateedit-headers">
		<a href="javascript:hidefeecategorycreateedits();" class="close"
			data-dismiss="modal" style="margin-right: 10px; margin-top: 10px;"
			aria-hidden="true">×</a>
		<h3 id="myModalLabel">Change Current Session</h3>
	</div>
	<f:form commandName="Session" action="changecurrent-session.html"
		id="submitform">
		<f:hidden path="active" value="true" />
		<div class="row-fluid" style="margin-top: 20px;">
			<div class="block-fluid">
				<div id="appendFeeCategoryIds"></div>
				<div class="row-form" style="height: 50px;">
					<div class="span12">
						<span class="top title">Session<font color="red">*</font>
							:-
						</span>
						<f:select id="sessionId" required="required"
							onchange="showhideData();" style="width: 250px;" path="sessionId">
							<f:option value="${current.sessionId}">${current.sessionDuration}</f:option>
							<c:forEach var="list" items="${Sessions}">
								<f:option value="${list.sessionId}">${list.sessionDuration}</f:option>
							</c:forEach>
						</f:select>
						<div id="feeCategoryNamemsg"></div>
					</div>
				</div>
			</div>
		</div>
		<div class="feecategorycreateedit-footer" style="float: right">
			<button class="btn btn-primary" data-dismiss="modal" type="submit"
				aria-hidden="true">Save Changes</button>
			<a class="btn btn-warning" data-dismiss="modal"
				href="javascript:hidefeecategorycreateedits();"
				style="margin-right: 15px" aria-hidden="true">Close</a>
		</div>
	</f:form>
</div>
<div class="content">
	<div id="content-header" style="height: 150px;">
		<img alt="Show_settings" src="${img_url}/class.jpg"
			style="width: 50px;">
		<h1>Create View Edit Sessions</h1>
		<h3>Manage Sessions</h3>
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
	<c:if test="${msg!=null}">
		<div class="successmsg">
			<font color="red">${msg}</font>
		</div>
	</c:if>

	<div class="row-fluid">
		<div class="span12">
			<div class="block">
				<div class="head blue"
					style="border-top-width: 10px; margin-top: 46px;">
					<div class="icon">
						<span class="ico-pen-2"></span>
					</div>
					<h2>Session</h2>
					<ul class="buttons">
						<li><a href="javascript:showdialogBox('Add Class');"
							role="button" id="addcategory" class="btn btn-primary"
							data-toggle="modal">Add Session</a></li>
						<li><a href="javascript:showdialogBoxes('Add Class');"
							role="button" id="addcurrent" class="btn btn-primary"
							data-toggle="modal">Change Current Session</a></li>
					</ul>
				</div>

				<div class="data-fluid">
					<table cellpadding="0" cellspacing="0" width="100%" class="table">
						<thead>
							<tr>

								<th width="25%">Session Name</th>

								<th width="25%">Action</th>
							</tr>
						</thead>
						<tbody>
							<%-- <tr>
								<td><font color="green"><b>${current.sessionDuration}</b></font></td>
								<td><a href="javascript:editSession(${current.sessionId})"><span
										class="label label-success">Edit</span></a>|<a
									href="deletesession.html?sessionId=${current.sessionId}"><span
										class="label label-important">Delete</span></a></td>
							</tr> --%>
							<c:forEach items="${Sessions}" var="list">
								<tr>
									<c:choose>
										<c:when test="${current.sessionId==list.sessionId}">
											<td><font color="green"><b>${list.sessionDuration}</b></font></td>
										</c:when>
										<c:otherwise>
											<td>${list.sessionDuration}</td>
										</c:otherwise>
									</c:choose>
									<td><a href="javascript:editSession(${list.sessionId})"><span
											class="label label-success">Edit</span></a>|<a
										href="deletesession.html?sessionId=${list.sessionId}"><span
											class="label label-important">Delete</span></a></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>

			</div>
		</div>
	</div>
</div>
<!-- Bootrstrap modal form -->
