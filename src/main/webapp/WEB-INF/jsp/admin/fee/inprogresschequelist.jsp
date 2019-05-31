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
	var bankName=$("#bankName").val();
	var accountNumber=$("#accountNumber").val();
	
	document.location.href="change-cheque-inprogress.html?slipNo="+$("#getslipno").val()+"&feePaidStatus="+$("#datatype").val()+"&bankName="+$("#bankName").val()+"&accountNumber="+$("#accountNumber").val()+"";
}
function changeinprogressstatus(value,slipNo){
	$("#getslipno").val(slipNo);
	$("#datatype").val(value);
	$.ajax({
		type : "GET",
		url  :  'getBanks',
		success : function(data, status) {
			
			var j = JSON.parse(data);
			var content = '<select name="bankName" id="bankName" style="width: 240px; margin-left: 80px; margin-top: 59px;" onchange="getAccountNumber(this.value)"><option value="">Select Bank</option>';
			for ( var i = 0; i < j.length; i++) {
				content += '<option value='+j[i].bankId+'>'
						+ j[i].bankName + '</option>';
			}
			content+='</select>';
			$("#bankDetails").append(content);
		},
		error : function(e) {
			alert('Error: ' + e);
		}
	});
	
	
	
	/* var content='';
	        content+='<select name="bankName" style="width: 240px; margin-left: 80px; margin-top: 59px;"><option>---Select Bank---</option></select>'
	        content+='<select name="bankAccount" style="width: 240px; margin-left: 80px; margin-top: 10px;"></select>'
	        */
	
	 if(value=='cancel'){
		$('#popupcancel').show();
	} 
	if(value=='completed'){
		$('#popup').show();
		if (t == true) {
			document.location.href="change-cheque-inprogress.html?slipNo="+slipNo+"&feePaidStatus="+value+"";
		} 
	}
}

function getAccountNumber(bankId){
	
	alert(bankId);
	
	$.ajax({
		type : "GET",
		url  :  'getAccountNumber',
		data:{
			"bankId" : bankId
		},
		success : function(data, status) {
			
			var j = JSON.parse(data);
			alert(j.toSource());
			alert(j.accountNumber)
			var content = '<select name="accountNumber" id="accountNumber" style="width: 240px; margin-left: 80px; margin-top: 59px;" ><option value="">Select Account No</option>';
			
				content += '<option value='+j.accountNumber+'>'
						+ j.accountNumber + '</option>';
			
			content+='</select>';
			$("#bankDetails").append(content);
		},
		error : function(e) {
			alert('Error: ' + e);
		}
	});
	
	
}
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
							id="getslipno">
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
									<th>Mobile No</th>
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
										<td>${StudentFeeSubmissionDetailsDTO.bankName}</td>
										<td>${StudentFeeSubmissionDetailsDTO.mobileNo}</td>
										<td><select id="statusofselect"
											onchange="changeinprogressstatus(this.value,${StudentFeeSubmissionDetailsDTO.recieptNo});">
												<option
													value="${StudentFeeSubmissionDetailsDTO.feePaidStatus}">${StudentFeeSubmissionDetailsDTO.feePaidStatus}</option>
												<option value="completed">completed</option>
												<option value="cancel">cancel</option>
										</select></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						<div id="popup"
							style="height: 300px; width: 400px; border: 1px sloid; border-radius: 5px; background: #F8E0E6; margin-left: 285px; margin-top: -20px; display: none;">


							<!-- <span style="margin-left: 140px; margin-top: 0px;">Are
									You Sure?</span> -->
							<div id="bankDetails"></div>
							<button id="btn1" onclick="getValue();"
								style="margin-left: 115px; width: 50px; background: none repeat scroll 0% 0% green; margin-top: 34px; height: 25px;"
								value="Ok">OK</button>
							<button id="btn2" onclick="hide();"
								style="margin-left: 65px; width: 50px; background: none repeat scroll 0% 0% green; margin-top: 37px; height: 25px;"
								value="Cancel">Cancel</button>



						</div>
						<div id="popupcancel"
							style="height: 100px; width: 400px; border: 1px sloid; border-radius: 5px; background: #F8E0E6; margin-left: 285px; margin-top: -20px; display: none;">


							<!-- <span style="margin-left: 140px; margin-top: 0px;">Are
									You Sure?</span> -->
							
							<button id="btn1" onclick="getValue();"
								style="margin-left: 115px; width: 50px; background: none repeat scroll 0% 0% green; margin-top: 34px; height: 25px;"
								value="Ok">OK</button>
							<button id="btn2" onclick="hide();"
								style="margin-left: 65px; width: 50px; background: none repeat scroll 0% 0% green; margin-top: 37px; height: 25px;"
								value="Cancel">Cancel</button>



						</div>
					</div>

				</div>
			</div>
		</div>
	</div>
</div>