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
<title>CREATE EDIT VIEW CLASSES</title>
</head>
<script type="text/javascript">
	function formSubmit() {
		var flag = false;
		if (parseInt($("#maxFineAmount").val()) >= parseInt($("#fineAmount")
				.val())) {
			flag = true;
		}else{
			alert("Max Fine is not less than  fine Amount");
		}
		return flag;
	}
	function getFineforSession(sessionId)
	{
		$
		.ajax({
			type : "post",
			url : 'getFinebysessions',
			data : {
				'sessionId' : +sessionId
			},
			success : function(data) {
				var obj = JSON.parse(data);
				
				$("#fineAmount").val(obj.fineAmount);
				$("#maxFineAmount").val(obj.maxFineAmount);
				$("#fineId").val(obj.fineId);
				
			},
			error : function(e) {
				
			}
		});
		
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
</style>
<div class="content">
	<div id="content-header" style="height: 150px;">
		<img alt="Show_settings" src="${img_url}/class.jpg"
			style="width: 50px;">
		<h1>Create View Edit Fine</h1>
		<h3>Manage Fine</h3>
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
	<c:if test="${!empty msg}">
    <div class="successmsg">${msg}</div>
	</c:if>
	<div class="row-fluid">
		<div class="span6">
			<div class="block">
				<f:form commandName="Fine" action="fine.html" method="post"
					id="validate" onsubmit="return formSubmit();">
					<div class="row-fluid" style="margin-top: 20px;">
						<div class="block-fluid">
						<div class="row-form">
								<div class="span4">
									Select Session<font color="red">*</font>
								</div>
								<div class="span8">
									<f:select path="sessionId" class="form-control input-sm"
									id="sessionId" x-data-toggle-x="tooltip" required="required"
									title="Specify the session of the student" onchange="getFineforSession(this.value);"
									data-original-title="Specify session">
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
								</f:select>
								</div>
							</div>
							<div class="row-form">
								<div class="span4">
									Fine name :<font color="red">*</font>
								</div>
								<div class="span8">
									<f:input path="fineName" value="Late Fee Fine" readonly="true" />
								</div>
							</div>
							<div class="row-form">
								<div class="span4">
									Fine Amount/Day :<font color="red">*</font>
								</div>
								<div class="span8">
									<f:hidden path="fineId" />
									<f:input path="fineAmount" id="fineAmount"
										class="validate[required,custom[integer],minSize[1]]" />
								</div>
							</div>
							<div class="row-form">
								<div class="span4">
									Max Fine Amount :<font color="red">*</font>
								</div>
								<div class="span8">
									<f:input path="maxFineAmount" id="maxFineAmount"
										class="validate[required,custom[integer],minSize[1]]" />
								</div>
							</div>

						</div>
					</div>
					<div class="feecategorycreateedit-footer" style="float: right">
						<button class="btn btn-primary" data-dismiss="modal" type="submit"
							id="submitbutton" aria-hidden="true">Save updates</button>

					</div>
					
				</f:form>
			</div>
		</div>
	</div>
</div>
