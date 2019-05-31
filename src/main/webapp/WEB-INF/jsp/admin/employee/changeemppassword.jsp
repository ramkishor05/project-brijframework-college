<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<link rel="stylesheet" type="text/css" href="${css_url}/home.css">
<link rel="stylesheet" type="text/css" href="${css_url}/setting.css">
<link rel="stylesheet" type="text/css" href="${css_url}/admission.css">
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/" var="baseurl"></spring:url>
<spring:url value="/img" var="img_url" />
<spring:url value="/style" var="style_url" />
<spring:url value="/css" var="css_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/setting.css">
<style>
.feecategorycreateedit {
	background-color: white;
	border: 1px solid lightgrey;
	width: 450px;
	height: auto;
	border-radius: 6px;
	margin-top: 200px;
	left: 280px;
	z-index: 1;
	position: absolute;
	background-color: white;
	overflow: hidden;
}

.header {
	width: auto;
	margin-top: -10px;
	border-bottom: 1px solid lightgray;
	height: 50px;
	padding: 0 0 0 20px;
	background-color: #eee;
	color: gray;
}
</style>
<div class="content">
	<div id="content-header" style="height: 150px;">
		<img alt="Show_settings" src="${img_url}/cpass.png"
			style="width: 50px; margin-top: -12px;">
		<h1>Change Employee's Password</h1>
		<h3>Update Password</h3>
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
	<c:if test="${! empty msg}">
		<div class="failedmsg"
			style="height: 37px; padding-top: 0px; padding-bottom: 1px; margin-bottom: 0px;">
			<h5 align="center">
				<c:out value="${msg}"></c:out>
			</h5>
		</div>
	</c:if>
	<div class="feecategorycreateedit" style="margin-top: 82px;">
		<div class="header">
			<h3 id="myModalLabel">Change Password</h3>
		</div>
		<f:form commandName="FeecategoryAmountDTO"
			action="change-emp-password.html" id="submitform" method="post">
			<div class="row-fluid" style="margin-top: 20px;">
				<div class="block-fluid" style="margin-top: 2px;">
					<f:hidden path="employeeId"
						value="${FeecategoryAmountDTO.employeeId}" />
					<div class="row-form" style="height: 50px;">
						<div class="span12">
							<span class="top title">Current Password<font color="red">*</font>
								:
							</span> <input type="password" id="password" name="password" value=""
								required="required" maxlength="12"
								style="width: 266px; margin-top: -25px; margin-left: 122px;" />
						</div>
					</div>
					<div class="row-form" style="height: 50px;">
						<div class="span12">
							<span class="top title">New password<font color="red">*</font>
								:
							</span> <input type="password" id="retryCount" name="newPassword"
								maxlength="12" value=""
								class="validate[required,minSize[4],maxSize[20]]"
								required="required"
								style="width: 266px; margin-top: -25px; margin-left: 122px;" />
						</div>
					</div>
					<div class="row-form" style="height: 50px;">
						<div class="span12">
							<span class="top title">Confirm New Password<font
								color="red">*</font>:
							</span> <input type="password" id="confirmPassword" maxlength="12"
								name="confirmPassword" required="required"
								class="validate[required,minSize[4],maxSize[20]]"
								style="width: 266px; margin-top: -25px; margin-left: 122px;" />
						</div>
					</div>
				</div>
			</div>
			<div class="feecategorycreateedit-footer"
				style="float: right; margin-right: 45px;">
				<button class="btn btn-primary" data-dismiss="modal" type="reset"
					style="background-color: #eee; width: 100px; border: 1px solid lightgray; color: gray; margin-right: 68px;"
					aria-hidden="true">Reset</button>
				<button class="btn btn-primary" data-dismiss="modal"
					style="background-color: #eee; width: 100px; border: 1px solid lightgray; color: gray"
					type="submit" aria-hidden="true">
					<b>Change</b>
				</button>
			</div>
		</f:form>
	</div>
</div>