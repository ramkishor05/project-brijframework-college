<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/img" var="img_url" />
<spring:url value="/css" var="css_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/setting.css">
<script type="text/javascript">
	function validateform() {
		var viewedamount = '';
		if ('${EditFeeAmountDTO.currentAmount}' != '') {
			viewedamount = '${EditFeeAmountDTO.currentAmount}';
		}
		if ('${currentAmount}' != '') {
			viewedamount = '${currentAmount}';
		}
		var discount = $("#discount").val();
		var flage = true;
		/* if (parseInt(viewedamount) < parseInt(discount)) {
			flage = false;
			alert("New Amount not greater than Current Amount");
		} */
		return flage;
	}
</script>
<style>
.feecategorycreateedit {
	background-color: white;
	border: 1px solid grey;
	width: 630px;
	height: auto;
	border-radius: 6px;
	margin-top: 78px;
	left: 215px;
	z-index: 1;
	position: absolute;
	background-color: white;
}

.feecategorycreateedit-header {
	width: 630px;
	margin-top: -10px;
	border-bottom: 1px solid gray;
	height: 50px;
}
</style>
<div class="content">
	<div id="content-header" style="height: 150px;">
		<img alt="Show_settings" src="${img_url}/sfees.jpg"
			style="width: 50px; margin-top: -12px;">
		<h1>Student fee Amount</h1>
		<h3>Edit Student Fee Amount</h3>
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
	<div class="feecategorycreateedit">
		<div class="feecategorycreateedit-header">
			<h3 id="myModalLabel">Change Alloted Fee Amount</h3>
			<c:if test="${! empty msg}">
				<div class="alert alert-success"
					style="height: 28px; padding-top: 0px; padding-bottom: 1px; margin-bottom: 0px;">
					<h5 align="center">
						<font color="red"><b>${msg}</b></font>
					</h5>
				</div>
			</c:if>
		</div>
		<f:form commandName="EditFeeAmountDTO"
			onsubmit="return validateform();"
			action="save-change-fee-amount.html" id="submitform" method="post">
			<div class="row-fluid" style="margin-top: 20px;">
				<div class="block-fluid" style="margin-top: 20px;">
					<div id="appendFeeCategoryId">
						<input type="hidden" value="${EditFeeAmountDTO.classId}"
							name="classId"> <input type="hidden"
							value="${EditFeeAmountDTO.sessionId}" name="sessionId"> <input
							type="hidden" value="${EditFeeAmountDTO.sectionId}"
							name="sectionId"> <input type="hidden"
							value="${EditFeeAmountDTO.feesCategoriesId}"
							name="feesCategoriesId"> <input type="hidden"
							value="${EditFeeAmountDTO.studentAdmissionNo}"
							name="studentAdmissionNo"> <input type="hidden"
							value="${EditFeeAmountDTO.currentAmount}" name="currentAmount">
						<input type="hidden" value="${EditFeeAmountDTO.monthId}"
							name="monthId">
					</div>
					<!-- Main Div -->
					<div
						style="height: auto; width: 600px; border: 1px solid #eee; margin: 0 auto;">
						<div class="block">
							<div class="data-fluid">
								<table cellspacing="0" cellpadding="0" width="100%"
									class="table">
									<tr>
										<td><b>Month</b></td>
										<td><b>Allotted Fee</b></td>
										<td><b>Edited Fee</b></td>
									</tr>
									<c:set var="count" value="0" />
									<c:forEach items="${editFeeAmountDTOs}" var="list">
										<c:choose>
											<c:when test="${monthId==13}">
												<tr>
													<td><c:set var="counter" value="0" /> <c:if
															test="${list.statusVarible=='complete'}">
															<input type="checkbox" checked="checked"
																disabled="disabled" />
															<font color="green">${list.monthName}</font>
														</c:if> <c:if test="${list.statusVarible=='inprogress'}">
															<c:set var="count" value="${count + 1}" scope="page" />
															<input type="checkbox" name="monthIds"
																value="${list.monthId}" checked="checked">
															<font color="blue">${list.monthName}</font>
														</c:if> <c:if test="${list.statusVarible=='cancel'}">
															<c:set var="count" value="${count + 1}" scope="page" />
															<input type="checkbox" name="monthIds"
																value="${list.monthId}">${list.monthName}</c:if></td>
											</c:when>
											<c:otherwise>
												<c:forEach items="${editFeeAmountDTOs}"
													var="EditFeeAmountDTOs">
													<td><c:if
															test="${EditFeeAmountDTOs.statusVarible=='complete'}">
															<font color="green">${EditFeeAmountDTOs.monthName}</font>
														</c:if> <c:if
															test="${EditFeeAmountDTOs.statusVarible=='inprogress'}">
															<c:set var="count" value="${count + 1}" scope="page" />
															<font color="blue">${EditFeeAmountDTOs.monthName}</font>
														</c:if> <c:if test="${EditFeeAmountDTOs.statusVarible=='cancel'}">
															<c:set var="count" value="${count + 1}" scope="page" />
											${EditFeeAmountDTOs.monthName}
						    </c:if></td>
												</c:forEach>
											</c:otherwise>
										</c:choose>


										<td><c:out value="${list.currentAmount}"></c:out></td>
										<td><c:out value="${list.discount}"></c:out></td>
										</tr>
									</c:forEach>
								</table>
							</div>
						</div>
						<hr>
						<c:if test="${count!='0'}">
							<div class="row-form" style="height: 50px;">
								<div class="span12">
									<span class="top title">New Amount<font color="red">*</font>
										:
									</span> <input type="text" name="discount" value="" id="discount"
										class="validate[required,custom[integer]]" required="required"
										style="width: 266px; margin-top: -25px; margin-left: 122px;" />
								</div>
							</div>
							<div class="row-form" style="height: 50px;">
								<div class="span12">
									<span class="top title" style="margin-top: 17px;">Reason For Discount<font color="red">*</font>
										:
									</span> <textArea type="text" name="reasonForDiscount" value="" id="reasonForDiscount"
										class="validate[required]" required="required"
										style="width: 266px; margin-top: -34px; margin-left: 122px;"></textArea>
								</div>
							</div>
							<div class="row-form" style="height: 50px;">
								<div class="span12">
									<span class="top title" style="margin-top: 10px;">By :<font color="red">*</font>
										:
									</span> <input type="text" name="discountGivenBy" value="" id="discountGivenBy"
										class="validate[required]" required="required"
										style="width: 266px; margin-top: -21px; margin-left: 122px;" />
								</div>
							</div>
						</c:if>
					</div>
				</div>
				<c:if test="${count!='0'}">
					<button class="btn btn-primary" data-dismiss="modal" type="submit"
						aria-hidden="true"
						style="background-color: #eee; color: gray; margin-left: 280px; width: 100px;">Proceed</button>
			</div>
			</c:if>
		</f:form>
	</div>
</div>