<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:url value="/style/theme/images" var="imageurl" />
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/img" var="img_url" />
<spring:url value="/css" var="css_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/setting.css">


<script>
	function getSalaryDetails(month) {
		$
				.ajax({
					type : "post",
					url : 'show-salary-paid-details',
					data : {
						'month' : month,
					},
					success : function(data, status) {
						$("#feeDetails").empty();
						var value = JSON.parse(data);
						var st = "";
						var length = value.length;

						if (length == 0) {
							st = '<div class="failedmsg">No salary paid for this month</div>';
						} else {
							st = '<div><div class="widget-body" style="padding: 10px 0 0;"><div class="separator"></div><div class="btn-group" style="width: 1059px;">'
									+ '</div>';
									st += '<div class="block"><div class="head blue" style="width: 1119px;"><div class="icon"><span class="ico-pen-2"></span></div><h2> Salary Payment Details</h2></div>'
										+ '<table class="table table-bordered table-primary"><thead><tr>';
								st = st
										+ '<th>S No.</th><th>Employee Id.</th><th>Name</th><th>Date</th><th>Months</th>';
								st = st
										+ '<th>Salary Amount</th><th>Fine</th><th>Advance</th><th>Incentive</th><th>Net Amount</th>';
								st = st
										+ '<th>Paid Amount</th><th>Dues</th><th>Payment Mode</th><th>Cheque No.</th><th>Bank Name</th>';
										
										st = st
										+ '<th>Type</th><th>Slip No.</th><th>Status</th></tr>';
							for (var i = 0; i < length; i++) {
								st = st
								+ '<tr><td>'
								+ (i+1)
								+ '</td><td>'
								+ value[i].employeeId
								+ '</td><td>'
								+ value[i].firstName+' '+value[i].lastName
								+ '</td><td>'
								+ value[i].dateOfPayment
								+ '</td><td>'
								+ value[i].month
								+ '</td><td>'
								+ value[i].salaryAmount
								+ '</td><td>'
								+ value[i].fineAmount
								+ '</td><td>'
								+value[i].advanceAmount
								+'</td><td>'
								+ value[i].incentive
								+ '</td><td>'
								+ value[i].netPayableAmount
								+ '</td><td>'
								+ value[i].paidAmount
								+ '</td><td>'
								+ value[i].dueAmount
								+ '</td><td>'
							
								+ value[i].paidBy
								+ '</td><td>'
								+ value[i].chequeNo
								+ '</td><td>'
								+ value[i].bankName
								+ '</td><td>'
								+ value[i].advance
								+ '</td><td>'
								+value[i].slipNo
								+'</td>';
						if (value[0].salaryPaidStatus == 'InHand') {
							st = st
									+ '<td><select onchange="changeinprogressstatus('
									+ value[i].slipNo
									+ ',this.value);" style="width: 94px;"><option value="InHand">Inhand</option>'
									+ '<option value="Completed">Completed</option>'
									+ '<option value="Cancel">Cancel</option></select>'
									+ '</td>';
						} else {
							st = st
									+ '<td>'
									+ value[i].salaryPaidStatus
									+ '</td></tr>';
						}
							
							}
						}
						$("#feeDetails").append(st);

					},
					error : function(e) {
						alert('Error: ' + e);
					}
				});
	}
				function changeinprogressstatus(value,slipNo){
					
					document.location.href="change-cheque-inHand.html?slipNo="+slipNo+"&Status="+value+"";
				

			}
</script>


<div class="content">
	<div id="content-header" style="height: 150px;">
		<img alt="Show_settings" src="${img_url}/salary.jpg"
			style="width: 50px; margin-top: -12px;">
		<h1>Paid Salary Details</h1>
		<h3>Show Monthly Paid Salary Details</h3>
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

	<div class="row-form">
		<div class="span2">
			Select Month :<font color="red">*</font>
		</div>
		<div class="span4">
			<select onchange="getSalaryDetails(this.value)">
				<option value="">Select Month</option>
				<c:forEach var="month" items="${months}" begin="0"
					end="${fn:length(months)-2}">
					<option value="${month.monthId}">${month.monthName}</option>
				</c:forEach>
			</select>
		</div>
	</div>

	<div id="feeDetails"style="width: 1135px;"></div>
</div>

