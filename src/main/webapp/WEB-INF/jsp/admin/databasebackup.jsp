<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<style>
.feecategorycreateedit {
	background-color: white;
	border: 1px solid grey;
	width: 450px;
	height: auto;
	border-radius: 6px;
	margin-top: 78px;
	left: 280px;
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
<div class="feecategorycreateedit">
	<div class="feecategorycreateedit-header">
		<h3 id="myModalLabel">Change Password</h3>
		<c:if test="${! empty msg}">
			<div class="alert alert-success"
				style="height: 28px; padding-top: 0px; padding-bottom: 1px; margin-bottom: 0px;">
				<h5 align="center">
					<font color="red"><b>${msg}</b></font>
				</h5>
			</div>
		</c:if>
	</div>
	<f:form commandName="FeecategoryAmountDTO"
		action="change-password.html" id="submitform" method="post">
		<div class="row-fluid" style="margin-top: 20px;">
			<div class="block-fluid" style="margin-top: 20px;">
				<div id="appendFeeCategoryId"></div>
				<div class="row-form" style="height: 50px;">
					<div class="span12">
						<span class="top title">User Name<font color="red">*</font>
							:
						</span> <input type="file" name="filePath" value="" webkitdirectory directory multiple required="required"
							style="width: 266px; margin-top: -25px; margin-left: 122px;" />
					</div>
				</div>
			</div>
		</div>
		<div class="feecategorycreateedit-footer"
			style="float: right; margin-right: 45px;">
			<button class="btn btn-primary" data-dismiss="modal" type="submit"
				aria-hidden="true">Proceed</button>
		</div>
	</f:form>
</div>