<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<script type="text/javascript">
	function getsection(value) {
		$.ajax({
			type : "post",
			url : 'getsectionforclass',
			data : {
				"classId" : +value
			},
			success : function(data) {
				var obj = JSON.parse(data);
				$("#sectionId").empty();
				var obj = JSON.parse(data);
				var content = '<option value="">Chosse sections ...</option>';
				$.each(obj, function(key, value) {
					content += '<option value="'+value.sectionId+'">'
							+ value.sectionName + '</option>';
				});
				$("#sectionId").append(content);
			},
			error : function(e) {
				alert('Error: ' + e);
			}
		});
	}

	function getstudents() {
		$
				.ajax({
					type : "post",
					url : 'getstudents',
					data : {
						'sectionId' : +$("#sectionId").val(),
						'classId' : +$("#class").val()
					},
					success : function(data) {
						$("#stdentsemester").empty();
						var obj = JSON.parse(data);
						var content = '';
						$
								.each(
										obj,
										function(key, value) {
											content += '<div class="row-form"><div class="span3">Student Name:</div>';
											content += '<div class="span9"><lable><a href="javascript:getcategory('
													+ value.admissionNo
													+ ')">'
													+ value.firstName
													+ ''
													+ value.middleName
													+ ''
													+ value.lastName
													+ '</a></lable></div></div>';
										});
						$("#studentsemester").append(content);
					},
					error : function(e) {
						alert('Error: ' + e);
					}
				});
	}
	function emptyMsgDiv() {
		$("#classmsg").empty();
		$("#sectionmsg").empty();
		$("#fromDatemsg").empty();
		$("#toDatemsg").empty();
	}
	function getcategory(studentAdmissionNo) {
		$("#viewedselectid").val(studentAdmissionNo);
		var finetable = '<div class="data invoice">';
		alert(studentAdmissionNo + " " + $("#sectionId").val() + " "
				+ $("#class").val() + " " + $("#fromDate").val() + " "
				+ $("#toDate").val());
		$
				.ajax({
					type : "post",
					url : 'getstudentFeeAllotementDTOs',
					data : {
						"fromDate" : $("#fromDate").val(),
						"toDate" : $("#toDate").val(),
						"studentAdmissionNo" : +studentAdmissionNo,
						"sectionId" : +$("#sectionId").val(),
						"classId" : +$("#class").val()
					},
					success : function(data) {
						var lastDate = '';
						$("#appendtable").empty();
						$("#fineTable").empty();
						var obj = JSON.parse(data);

						var content = '<div class="head green"> <div class="icon"> <span class="ico-brush"></span></div>';
						content += '<h2>View Payed or Unpayed Fee Category</h2>';
						if (obj.unPaid != 0) {
							content += '<ul class="buttons"><li><a href="javascript:showdialogBox();" class="btn btn-primary">Add Discount</a></li></ul>';
						}
						content += '</div><div class="data-fluid"><table width="100%" cellspacing="0" cellpadding="0" class="table table-hover">';
						content += '<thead><tr><th width="25%">Fee Category name</th><th width="25%">Fee Amount</th><th width="20%">Due Date</th></tr></thead><tbody>';

						$.each(obj.studentFeeAllotementDTOs, function(key,
								value) {
							content += '<tr><td>' + value.feeCategoryName
									+ '</td>';
							content += '<td>' + value.feeCategoryAmount
									+ '</td>';
							content += '<td>' + value.dueDate + '</td>';
							lastDate = value.dueDate;
						});
						if (obj.fineAmount != '' && obj.fineAmount != null
								&& obj.fineAmount != '0') {
							finetable += '<table width="100%" class="table"><thead><tr><th width="30%">Fine Name</th><th width="25%">Fine Amount</th></tr></thead><tbody>';
							finetable += '<tr><td>Late fee Fine</td><td>'
									+ obj.fineAmount
									+ '</td></tr></tbody></table>';
						}

						if (obj.feeDiscountDTOs.length > 0) {
							finetable += '<table width="100%" class="table"><thead><tr><th width="30%">Discount Name</th><th width="25%">Discount Amount</th><th width="25%">Action</th></tr></thead><tbody>';
							$
									.each(
											obj.feeDiscountDTOs,
											function(key, value) {
												finetable += '<tr><td>'
														+ value.feeDiscountName
														+ '</td><td>'
														+ value.feeDiscountAmount
														+ '</td>';
												if (obj.unPaid != 0) {
													finetable += '<td><a href="javascript:editfeecategory('
															+ value.feeDiscountId
															+ ')">Edit</td>';
												} else {
													finetable += '<td><a href="javascript:void(0)">Edit</td>';
												}
												finetable += '</tr>';
											});
							finetable += '</tbody></table>';
						}
						content += '</tbody></table></div></div>';
						finetable += '<div class="row-fluid"><div class="span7" style="margin-top: 30px;">';
						finetable += '</div><p><div class="span5" style="margin-top: 37px;"><strong><span>Payable:</span> Rs '
								+ obj.unPaid + ' <em>Indian</em></strong></p>';
						finetable += '<div class="highlight" style="width: 116px"><strong><span>Total:</span> Rs '
								+ obj.totalFee
								+ ' <em>Indian</em></strong></div>';
						if (obj.unPaid != 0) {
							finetable += '<a href="payfee.html?sectionId='
									+ $("#sectionId").val()
									+ '&classId='
									+ $("#class").val()
									+ '&studentAdmissionNo='
									+ $("#viewedselectid").val()
									+ '&fromDate='
									+ $("#fromDate").val()
									+ '&toDate='
									+ $("#toDate").val()
									+ '"><div class="highlight" style="margin-top:-30px;width: 50px;padding-left:140px"><strong>Pay Fee</strong></div></a>';
						} else {
							finetable += '<div class="highlight"><strong>This Duration Fee is Paid</strong></div>';
						}
						finetable += '</div></div></div></div>';

						$("#fineTable").append(finetable);
						$("#appendtable").append(content);
						$("#lastDate").val(lastDate);
					},
					error : function(e) {
						alert('Error: ' + e);
					}
				});
	}
	function showdialogBox(value) {
		$("#appendStudentFineId").empty();
		$(".feecategorycreateedit").show();
	}
	function hidefeecategorycreateedit() {
		$("#fineNamemsg").empty();
		$("#fineAmountmsg").empty();
		$("#fineName").val('');
		$("#fineAmount").val('');
		$(".feecategorycreateedit").hide();
	}
	function submitformvalue() {
		$("#fineNamemsg").empty();
		$("#fineAmountmsg").empty();
		var flage = true;
		if ($("#fineName").val() == '') {
			$("#fineNamemsg").append(
					'<font color="red">this field is required</font>');
			flage = false;
		}
		if ($("#fineAmount").val() == '') {
			$("#fineAmountmsg").append(
					'<font color="red">this field is required</font>');
			flage = false;
		} else if (!$.isNumeric($("#fineAmount").val())) {
			$("#fineAmountmsg").append(
					'<font color="red">Numeric Value Only</font>');
			flage = false;
		}
		if (flage) {
			$.ajax({
				type : "get",
				url : 'addstudentfine',
				data : {
					'fromDate' : $("#fromDate").val(),
					'toDate' : $("#toDate").val(),
					'feeDiscountName' : $("#fineName").val(),
					'feeDiscountId' : $("#feeDiscountId").val(),
					'sectionId' : +$("#sectionId").val(),
					'classId' : +$("#class").val(),
					'studentAdmissionNo' : +$("#viewedselectid").val(),
					'feeDiscountAmount' : +$("#fineAmount").val(),
					'lastDate' : $("#lastDate").val()
				},
				success : function(data) {
					hidefeecategorycreateedit();
					getcategory($("#viewedselectid").val());
				},
				error : function(e) {
					alert('Error: ' + e);
				}
			});
		}
	}
	function editfeecategory(id) {
		$("#appendStudentFineId").empty();
		$("#fineNamemsg").empty();
		$("#fineAmountmsg").empty();
		$("#fineName").val('');
		$("#fineAmount").val('');
		$
				.ajax({
					type : "post",
					url : 'getstudentfine',
					data : {
						'feeDiscountId' : +id
					},
					success : function(data) {
						var obj = JSON.parse(data);
						$("#myModalLabel").text("Edit Fee Discount");
						$("#appendStudentFineId")
								.append(
										'<input type="hidden" id="feeDiscountId" value="'+id+'"/>');
						$("#fineName").val(obj.feeDiscountName);
						$("#fineAmount").val(obj.feeDiscountAmount);
						$(".feecategorycreateedit").show();
					},
					error : function(e) {
						alert('Error: ' + e);
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
	height: 270px;
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


<div class="feecategorycreateedit">
	<div class="feecategorycreateedit-header">
		<a href="javascript:hidefeecategorycreateedit();" class="close"
			data-dismiss="modal" style="margin-right: 10px; margin-top: 10px;"
			aria-hidden="true">×</a>
		<h3 id="myModalLabel">Add Discount</h3>
	</div>
	<form id="submitform">
		<div class="content">
			<div class="row-fluid" style="margin-top: 20px;">
				<div class="block-fluid">
					<div id="appendStudentFineId"></div>
					<div class="row-form" style="height: 50px;">
						<div class="span12">
							<input type="hidden" id="lastDate" value=""> <input
								type="hidden" id="viewedselectid" value=""><span
								class="top title">Discount name<font color="red">*</font>
								:
							</span> <input type="text" id="fineName" name="feeDiscountName" value=""
								style="width: 266px; margin-top: -25px; margin-left: 122px;" />
							<div id="fineNamemsg"></div>
						</div>
					</div>
					<div class="row-form" style="height: 50px;">
						<div class="span12">
							<span class="top title">Discount Amount<font color="red">*</font>:
							</span> <input type="text" id="fineAmount" name="feeDiscountAmount"
								value=""
								style="width: 266px; margin-top: -25px; margin-left: 122px;" />
							<div id="fineAmountmsg"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="feecategorycreateedit-footer" style="float: right">
			<a class="btn btn-primary" data-dismiss="modal"
				href="javascript:submitformvalue();" aria-hidden="true">Save
				updates</a> <a class="btn btn-warning" data-dismiss="modal"
				href="javascript:hidefeecategorycreateedit();"
				style="margin-right: 15px" aria-hidden="true">Close</a>
		</div>
	</form>
</div>
<div class="content">
	<div class="page-header">
		<div class="icon">
			<span class="ico-pen-2"></span>
		</div>
		<h1>
			View Allocated Fee <small>View Allocated Fee</small>
		</h1>
	</div>
	<div class="row-fluid">
		<div class="span6">
			<div class="block">
				<div class="data-fluid">
					<div class="data-fluid">
						<div class="row-form">
							<div class="span4">
								Select Class :<font color="red">*</font>
							</div>
							<div class="span8">
								<font color="red">${msg}</font> <select id="class"
									name="classId" onchange="getsection(this.value);">
									<option value="">choose a Class...</option>
									<c:forEach items="${StudentClasses}" var="studentClass">
										<option value="${studentClass.classId}">${studentClass.className}</option>
									</c:forEach>
								</select>
								<div id="classmsg"></div>
							</div>
						</div>
					</div>
					<div class="data-fluid">
						<div class="row-form">
							<div class="span4">
								Select Section :<font color="red">*</font>
							</div>
							<div class="span8">
								<select name="sectionId" id="sectionId"
									onchange="emptyMsgDiv();">
									<option value="">choose a Section...</option>
								</select>
								<div id="sectionmsg"></div>
							</div>
						</div>
					</div>
					<div class="data-fluid">
						<div class="row-form">
							<div class="span4">
								From Date :<font color="red">*</font>
							</div>
							<div class="span8">
								<input type="text" class="datepicker validate[required]"
									name="fromDate" onchange="emptyMsgDiv();"
									placeholder="Select From Date" id="fromDate">
								<div id="fromDatemsg"></div>
							</div>
						</div>
					</div>
					<div class="data-fluid">
						<div class="row-form">
							<div class="span4">
								To Date :<font color="red">*</font>
							</div>
							<div class="span8">
								<input type="text" class="datepicker validate[required]"
									onchange="emptyMsgDiv();" placeholder="Select From Date"
									name="toDate" id="toDate">
								<div id="toDatemsg"></div>
							</div>
						</div>
					</div>
					<div class="data-fluid">
						<div class="row-form">
							<div class="span4"></div>
							<div class="span8">
								<a href="javascript:getstudents();" class="btn btn-success"
									style="float: right;">Assign Ok</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="row-fluid">
		<div class="span6">
			<div class="block">
				<div class="head">
					<h2>Student view</h2>
				</div>
				<div class="data-fluid" id="studentsemester"></div>
			</div>
		</div>
		<div class="span6">
			<f:form action="save-student-fee-allotement.html"
				commandName="StudentFeeAllotementDTO" method="POST"
				onsubmit="return validateform();">
				<div class="block" id="appendtable"></div>
			</f:form>
			<div class="block" id="fineTable"></div>
		</div>
	</div>
</div>