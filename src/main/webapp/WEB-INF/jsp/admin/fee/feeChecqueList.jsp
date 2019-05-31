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
	
</script>
<div class="content">
	<div class="page-header">
		<div id="content-header" style="height: 112px; width: 1056px;">
			<img alt="Show_settings" src="${img_url}/sfees.jpg"
				style="width: 50px;">
			<h2>Inprogress Cheque List.</h2>
			<h3>Inprogress Cheque List.</h3>
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
						<h2>In-Progress Cheque List</h2>
						<input type="hidden" id="datatype"> <input type="hidden"
							id="getslipno"> <a href="generate-PDF-fee-paidby-cheque"
							class="btn btn-primary" style="margin-left: 770px;" target="_blank">PDF</a>
					</div>
					<div class="data-fluid">
						<table width="100%" cellspacing="0" cellpadding="0"
							class="table table-hover">
							<thead>
								<tr>
									<th>Student Name</th>
									<th>Father Name</th>
									<th>Class</th>
									<th>Section</th>
									<th>Cheque No</th>
									<th>Amount</th>
									<th>Slip No</th>
									<th>Bank Name</th>
									<th>Bank Account No</th>
									<th>Status</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${StudentFeeSubmissionDetailsDTOs}"
									var="StudentFeeSubmissionDetailsDTO">
									<tr>
										<td>${StudentFeeSubmissionDetailsDTO.studentName}</td>
										<td>${StudentFeeSubmissionDetailsDTO.fatherName}</td>
										<td>${StudentFeeSubmissionDetailsDTO.className}</td>
										<td>${StudentFeeSubmissionDetailsDTO.sectionName}</td>
										<td>${StudentFeeSubmissionDetailsDTO.chequeNo}</td>
										<td>${StudentFeeSubmissionDetailsDTO.netPayableAmount}</td>
										<td>${StudentFeeSubmissionDetailsDTO.recieptNo}</td>
										<td>${StudentFeeSubmissionDetailsDTO.schoolBank}</td>
										<td>${StudentFeeSubmissionDetailsDTO.schoolBankaccount}</td>
										<td><span class="btn btn-primary">${StudentFeeSubmissionDetailsDTO.status}</span></td>

									</tr>
								</c:forEach>
							</tbody>
						</table>

					</div>

				</div>
			</div>
		</div>
	</div>
</div>