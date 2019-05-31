<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<spring:url value="/" var="baseurl" />
<spring:url value="/style/js" var="words" />
	
<script type="text/javascript" src="${words}/towards.js">
</script>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<script type="text/javascript">
	function showchequenofield(value) {
		$("#paidBymsg").empty();
		$("#feePaidStatusmsg").empty();
		$("#paidAmountmsg").empty();
		$("#chequemsg").empty();
		$("#paidAmountInWordmsg").empty();
		if (value == 'cheque') {
			$("#chequevalue").val('ok');
			$("#cheque")
					.append(
							'<div class="span4">ChequeNo:</div><div class="span8"><input type="text" id="chequeNo" name="chequeNo" onkeyup="emptymsges();"><div id="chequemsg"></div></div>');
		} else if (value == 'cash') {
			$("#chequevalue").val('');
			$("#cheque").empty();
		}
	}
	function emptymsges() {
	
		$("#paidBymsg").empty();
		$("#feePaidStatusmsg").empty();
		$("#paidAmountmsg").empty();
		$("#chequemsg").empty();
		$("#paidAmountInWordmsg").empty();
		converttowords();
		
	}
	function converttowords()
	{
		
		var num=$("#paidAmount").val();
		var words = toWords(num)+"only";
		
		$("#paidAmountInWord").val(words);
		
		
	}
	function formvalidate() {

		var flage = true;
		var regex1 = /^[0-9]*$/;
		if ($("#paidBy").val() == "") {
			$("#paidBymsg").append(
					'<font color="red">This Field Require</font>');
			flage = false;
		}
		if ($("#feePaidStatus").val() == "") {
			$("#feePaidStatusmsg").append(
					'<font color="red">This Field Require</font>');
			flage = false;
		}
		if ($("#paidAmount").val() == "") {
			$("#paidAmountmsg").append(
					'<font color="red">This Field Require</font>');
			flage = false;
		}else if (!regex1.test($("#paidAmount").val())){
			$("#paidAmountmsg").append(
					'<font color="red">Only Numeric value</font>');
			flage = false;
		}
		if ($("#chequevalue").val() == 'ok' && $("#chequeNo").val() == '') {
			$("#chequemsg").append(
					'<font color="red">This Field Require</font>');
			flage = false;
		} else if ($("#chequevalue").val() == 'ok'
				&& !$.isNumeric($("#chequeNo").val())) {
			$("#chequemsg").append(
					'<font color="red">Only Numeric value</font>');
			flage = false;
		}
		var regex = /^[a-zA-Z ]*$/;
		if ($("#paidAmountInWord").val() == '') {
			$("#paidAmountInWordmsg").append(
					'<font color="red">This Field Require</font>');
			flage = false;
		} else if (!regex.test($("#paidAmountInWord").val())) {
			$("#paidAmountInWordmsg").append(
					'<font color="red">String Only</font>');
			flage = false;
		}
		return flage;
	}
</script>
<div class="content">
	<div class="page-header">
		<div class="icon">
			<span class="ico-pen-2"></span>
		</div>
		<h1>
			Fee Allotment <small>Allocate fee to student</small>
		</h1>
	</div>
	<div class="row-fluid">
		<div class="span12">
			<div class="block">
				<f:form commandName="StudentFeeSubmissionDetailsDTO"
					action="save-fee-detail.html" onsubmit="return formvalidate();">
					<div class="data-fluid">
						<div style="margin-left: 130px; width: 700px;">
							<div class="row-form"
								style="border: 1px solid; border-radius: 10px;">
								<div class="span3">
									<img src="${baseurl}img/images.jpg">
								</div>
								<div class="span9">
									<h2 style="font-family: Time Romans">
										Dr. Karamvir Public School <br> <small
											style="margin-left: 70px;">SECTOR-11D,FARIDABAD</small>
									</h2>
									<div
										style="border-bottom: 1px; border-bottom: 1px solid; margin-left: -50px; margin-right: 50px;"></div>
								</div>
								<div style="margin-top: 110px;">
									<div>
										<h5 style="margin-left: 20px;">
											Slip No:-${CommonDTO.receiptNo}
											<h6 style="margin-top: -30px; margin-left: 430px;">Date:-${CommonDTO.currentPaidAmountDate}</h6>
										</h5>
									</div>
								</div>
								<div style="margin-top: 30px;">
									<div>
										<h5 style="margin-left: 20px;">
											Admission No:-${CommonDTO.studentDTO.admissionNo}
											<h6 style="margin-top: -30px; margin-left: 430px;">LF
												No:-${CommonDTO.lFNo}</h6>
										</h5>
									</div>
								</div>
								<div style="margin-top: 15px;">
									<div>
										<h5 style="margin-left: 20px;">
											Name:-${CommonDTO.studentDTO.firstName}&nbsp;${CommonDTO.studentDTO.middleName}
											&nbsp;${CommonDTO.studentDTO.lastName}
											<h6 style="margin-top: -30px; margin-left: 430px;">Father
												Name:-${CommonDTO.studentDTO.fatherName}</h6>
										</h5>
									</div>
								</div>
								<div style="margin-top: 15px;">
									<div>
										<h5 style="margin-left: 20px;">
											DOB:-${CommonDTO.studentDTO.dateOfBirth}
											<h6 style="margin-top: -30px; margin-left: 430px;">Contact
												No:-${CommonDTO.studentDTO.mobile}</h6>
										</h5>
									</div>
								</div>
								<div style="margin-top: 15px;">
									<div>
										<h5 style="margin-left: 20px;">
											Class:-${CommonDTO.studentDTO.className}
											<h6 style="margin-top: -30px; margin-left: 430px;">Section
												:-${CommonDTO.studentDTO.sectionName}</h6>
										</h5>
									</div>
								</div>
								<div style="margin-top: 20px; margin-left: 20px;">
									<table border="1px;" cellpadding="5px;" cellspacing="10px;"
										height="100px;" width="600px;">
										<tr>
											<td>S.No.</td>
											<td>DESCRIPTION</td>
											<td>AMOUNT</td>
										</tr>
										<c:set var="count" value="0"></c:set>
										<c:set var="fromDate" value="0"></c:set>
										<c:set var="toDate" value="0"></c:set>
										<c:if test="${not empty CommonDTO.studentFeeAllotementDTOs}">
											<tr>
												<td></td>
												<td style="text-align: center;">Fee Alloted to Student</td>
												<td></td>
											</tr>
											<c:forEach items="${CommonDTO.studentFeeAllotementDTOs}"
												var="studentFeeAllotementDTO">
												<tr>
													<td><c:set var="fromDate"
															value="${studentFeeAllotementDTO.fromDate}"></c:set> <c:set
															var="toDate" value="${studentFeeAllotementDTO.toDate}"></c:set>
														<c:set var="count" value="${count+1}"></c:set>${count}</td>
													<td>${studentFeeAllotementDTO.feeCategoryName}</td>
													<td>${studentFeeAllotementDTO.feeCategoryAmount}</td>
												</tr>
											</c:forEach>
										</c:if>
										<c:if test="${not empty CommonDTO.feeDiscountDTOs}">
											<tr>
												<td></td>
												<td style="text-align: center;">Concesstion Alloted to
													Student</td>
												<td></td>
											</tr>
											<c:forEach items="${CommonDTO.feeDiscountDTOs}"
												var="feeDiscountDTO">
												<tr>
													<td><c:set var="count" value="${count+1}"></c:set>${count}</td>
													<td>${feeDiscountDTO.feeDiscountName}</td>
													<td>${feeDiscountDTO.feeDiscountAmount}</td>
												</tr>
											</c:forEach>
										</c:if>
										<c:if
											test="${CommonDTO.fineAmount!='null'&&CommonDTO.fineAmount!=''}">
											<tr>
												<td></td>
												<td style="text-align: center;">Fee Fine</td>
												<td></td>
											</tr>
											<tr>
												<td><c:set var="count" value="${count+1}"></c:set>${count}</td>
												<td>Late Fee Fine</td>
												<td>${CommonDTO.fineAmount}</td>
											</tr>
										</c:if>
										<tr>
											<td></td>
											<td>Total</td>
											<td>${CommonDTO.totalFee}</td>
										</tr>
									</table>
								</div>
								<div class="row-fluid" style="width: 655px; margin-left: 5px;">
									<div>
										<input type="hidden" name="sectionId"
											value="${CommonDTO.studentDTO.sectionId}"> <input
											type="hidden" name="classId"
											value="${CommonDTO.studentDTO.classId}"> <input
											type="hidden" name="feePaidDate"
											value="${CommonDTO.currentPaidAmountDate}"> <input
											type="hidden" name="lFno" value="${CommonDTO.lFNo}">
										<input type="hidden" name="studentAdmissionNo"
											value="${CommonDTO.studentDTO.admissionNo}"> <input
											type="hidden" name="recieptNo" value="${CommonDTO.receiptNo}">
										<input type="hidden" name="fineAmount"
											value="${CommonDTO.fineAmount}"> <input type="hidden"
											name="lastDate" value="${CommonDTO.lastDate}"> <input
											type="hidden" id="chequevalue"> <input type="hidden"
											name="fromDate" value="${fromDate}" /> <input type="hidden"
											name="toDate" value="${toDate}" />
									</div>
									<div class="span6" style="width: 300px;">
										<div class="block">
											<div class="data-fluid">
												<div class="row-form">
													<div class="span4">Paid By 	:</div>
													<div class="span8">
														<select id="paidBy" name="paidBy"
															onchange="showchequenofield(this.value);">
															<option value="">choose a Class...</option>
															<option value="cash">CASH</option>
															<option value="cheque">CHEQUE</option>
														</select>
														<div id="paidBymsg"></div>
													</div>
												</div>
												<div class="row-form" id="cheque"></div>

											</div>
										</div>
									</div>
									<div class="span6">
										<div class="block">
											<div class="data-fluid">
												<div class="row-form">
													<div class="span4">Fee Status:</div>
													<div class="span7">
														<select name="feePaidStatus" id="feePaidStatus"
															onchange="showchequenofield(this.value);">
															<option value="">choose a Status...</option>
															<option value="cancel">CANCEL</option>
															<option value="completed">COMPLETED</option>
															<option value="inprogress">INPROGRESS</option>
														</select>
														<div id="feePaidStatusmsg"></div>
													</div>

												</div>
												<div class="row-form">
													<div class="span4">Amount:</div>
													<div class="span7">
														<input type="text" id="paidAmount" name="paidAmount"
															onblur="emptymsges();">
														<div id="paidAmountmsg"></div>
													</div>

												</div>
											</div>
										</div>
									</div>
								</div>
								<div style="margin-top: 20px;">
									<div>
										<h5 style="margin-left: 15px;">
											In Words Rs. <input type="text" id="paidAmountInWord"
												onkeyup="emptymsges();" name="paidAmountInWord"
												style="width: 520px;">
										</h5>
										<div id="paidAmountInWordmsg" style="margin-left: 101px;"></div>
										<button class="btn btn-success" type="submit">Save
											Fee</button>
										<!-- <a class="btn btn-success" href="#">Generate PDF</a> -->
									</div>
								</div>
							</div>
						</div>
					</div>
				</f:form>
			</div>
		</div>
	</div>

</div>

