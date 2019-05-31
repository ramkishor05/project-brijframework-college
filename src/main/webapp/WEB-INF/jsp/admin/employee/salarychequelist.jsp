<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<spring:url value="/img" var="img_url" />
<spring:url value="/css" var="css_url" />
<spring:url value="/js/jConfirm-master" var="js_url"></spring:url>
<link rel="stylesheet" type="text/css" href="${css_url}/setting.css">
<script type="text/javascript" src="${js_url}/jquery.jconfirm-1.0.js"></script>
<script type="text/javascript"
	src="${js_url}/jquery.jconfirm-1.0.min.js"></script>
<script type="text/javascript">
function hide(){
	$('#popup').hide();
	$('#statusofselect').prop('selectedIndex',0);
}
function getValue(){
	document.location.href="change-cheque-inHand.html?slipNo="+$("#getslipno").val()+"&Status="+$("#datatype").val()+"";
}
function changeinprogressstatus(value,slipNo){
	$("#getslipno").val(slipNo);
	$("#datatype").val(value);
	if(value=='Cancel'){
		$('#popup').show();
	}
	if(value=='Completed'){
		$('#popup').show();
		if (t == true) {
			document.location.href="change-cheque-inHand.html?slipNo="+slipNo+"&Status="+value+"";
		} 
	}
}
</script>
<div class="content">
	<div class="page-header">
		<div id="content-header" style="height: 112px; width: 1056px;">
			<img alt="Show_settings" src="${img_url}/salary.jpg"
				style="width: 50px;">
			<h2>InHand Cheque List.</h2>
			<h3>InHand Cheque List.</h3>
			<div id="app-back-button">
				<a href="home"><img alt="Back" border="0"
					src="${img_url}/home.png"
					style="margin-top: -6px; height: 40px; width: 40px;"></a> <a
					href="#" onclick="javascript:location.reload(true);"><img
					alt="Back" border="0" src="${img_url}/refresh.png"
					style="margin-top: -6px; height: 40px; width: 40px;"></a> <a
					href="#" onclick="history.back(); return false;"><img
					alt="Back" border="0" src="${img_url}/back.png"
					style="margin-top: -6px; height: 40px; width: 40px;"></a>
			</div>
		</div>
	</div>
	<div class="row-fluid">
		<div class="span12">
			<div class="block">
				<div class="block">
					<div class="head purple">
						<!-- <div class="icon">
							<span class="ico-location"></span>
						</div> -->
						<h2>In-Hand Cheque List</h2>
						<input type="hidden" id="datatype"> <input type="hidden"
							id="getslipno">
					</div>
					<div class="data-fluid">
						<table width="100%" cellspacing="0" cellpadding="0"
							class="table table-hover">
							<thead>
								<tr>
									
									<th>Name</th>
									<th>Date</th>
									<th>Months</th>
									<th>Salary Amount</th>
									<th>Advance</th>
									<th>Fine</th>
									<th>Incentive</th>
									<th>Net Amount</th>
									<th>Paid Amount</th>
									<th>Dues</th>
									<th>Cheque No</th>
									<th>Bank Name</th>
									<th>Type</th>
									<th>Slip No.</th>
									<th>Status</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${employeeCheque}" var="list">
									<tr>
									
										<td>${list.firstName}&nbsp;${list.lastName}</td>
										<td>${list.dateOfPayment}</td>
										<td>${list.month}</td>
										<td>${list.salaryAmount}</td>
											<td>${list.advanceAmount}</td>
										<td>${list.fineAmount}</td>
										<td>${list.incentive}</td>
										<td>${list.netPayableAmount}</td>
										<td>${list.paidAmount}</td>
										<td>${list.dueAmount}</td>
										<td>${list.chequeNo}</td>
										<td>${list.bankName}</td>
										<td>${list.advance}</td>
										<td>${list.slipNo}</td>

										<td><select id="statusofselect"
											onchange="changeinprogressstatus(this.value,${list.slipNo});">
												<option
													value="InHand">InHand</option>
												<option value="Completed">Completed</option>
												<option value="Cancel">Cancel</option>
										</select></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						<div id="popup"
							style="height: 100px; width: 400px; border: 1px sloid; border-radius: 5px; background: #F8E0E6; margin-left: 285px; margin-top: -20px; display: none;">
							<div>
								<span style="margin-left: 140px; margin-top: 0px;">Are
									You Sure?</span>

								<button id="btn1" onclick="getValue();"
									style="margin-left: -141px; width: 50px; background: green; margin-top: 43px; height: 25px;"
									value="Ok">OK</button>
								<button id="btn2" onclick="hide();"
									style="margin-left: 65px; width: 50px; background: green; margin-top: 43px; height: 25px;"
									value="Cancel">Cancel</button>
							</div>

						</div>
					</div>

				</div>
			</div>
		</div>
	</div>
</div>