<%@taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<spring:url value="/style/datepicks" var="datepicks" />
<spring:url value="/js" var="js_url" />
<spring:url value="/" var="baseurl"></spring:url>
<spring:url value="/img" var="img_url" />
<spring:url value="/style" var="style_url" />
<spring:url value="/css" var="css_url" />

<link rel="stylesheet" type="text/css" href="${css_url}/home.css">
<link rel="stylesheet" type="text/css" href="${css_url}/setting.css">
<link rel="stylesheet" type="text/css" href="${css_url}/admission.css">
<link href="${datepicks}/jquery.datepick.css" rel="stylesheet">
<script src="${datepicks}/jquery.plugin.js"></script>
<script src="${datepicks}/jquery.datepick.js"></script>
<link rel="stylesheet"
	href="${js_url}/fullcalendar/jquery-ui-1.10.4.custom.min.css">
<style>
.appendpop {
	display: none;
	position: fixed;
	z-index: 1;
	margin-top: -15px;
	border: 1px solid skyblue;
	border-radius: 6px;
	margin-left: 130px;
	height: auto;
	width: 800px;
	background-color: white;
	position: fixed;
	left: 148px;
	top: 181px;
}
</style>
<script type="text/javascript">
	function getSectionList(id) {
		$("#tablebody").empty();
		$('#sectionId').val('');
		$
				.ajax({
					type : "post",
					url : 'getsectionlist/' + id,
					success : function(data, status) {
						$("#sectionId").empty();
						var j = JSON.parse(data);
						var content = '<option value="">choose a Section ....</option>';
						for (var i = 0; i < j.length; i++) {
							content += '<option value='+j[i].sectionId+'>'
									+ j[i].sectionName + '</option>';
						}
						$("#sectionId").append(content);
					},
					error : function(e) {
						alert('Error: ' + e);
					}
				});
	}
	function saveAttendanceRecord(title, todate, id) {
		var classId = $('#classId').val();
		var sectionId = $('#sectionId').val();
		$.ajax({
			type : 'post',
			url : 'setattendencerecord',
			data : {
				'id' : id,
				'title' : title,
				'classId' : classId,
				'sectionId' : sectionId,
				'cd' : todate
			},
			error : function(e) {
				
			}
		});
	}
	function getCurrentDateData(currentDate) {
		
		var flag = true;
		var checkTrue = [];

		var allArray = [];
		for (i = 1; i <= $("#EmployeesDTOsLength").val(); i++) {
			allArray.push(i)
			var nameVariable = $('[name="name' + i + '"]');
			$.each(nameVariable, function(key, value) {
				if (value.checked) {
					checkTrue.push(i);
				}
			});
		}
		//var index=[];
		for (i = 0; i < $("#EmployeesDTOsLength").val(); i++) {
			if (allArray[i] != checkTrue[i]) {
				flag = false;
			}
			/* if(checkTrue[i]==undefine){
				index.push(allArray.indexOf(checkTrue[i]));
			} */
		}
		/* var lineNo=[];
		for(i=0;index.length;i++){
			lineNo+=''
		} */
		var classId = $('#classId').val();
		var sectionId = $('#sectionId').val();
		if (flag) {
			$
					.ajax({
						type : 'GET',
						url : 'getstudentcurrentdatedata',
						data : {
							'currentDate' : currentDate,
							'classId' : classId,
							'sectionId' : sectionId
						},
						success : function(data, status) {
							var obj = JSON.parse(data);
							$("#submitData").empty();
							var submitData = '<div class="head blue"><div class="icon"><span class="ico-pen-2"></span></div>';
							submitData += '<h2>Attendance Report For Date &nbsp;&nbsp;'
									+ currentDate + '';
							submitData += '</h2><ul class="buttons"><li><a  href="javascript:hidesubmitdata();">';
							submitData += '<div class="icon"><span class="icon-remove"></span></div></a></li></ul></div>';
							submitData += '<div class="data-fluid"><table width="100%" cellspacing="0" cellpadding="0" class="table">';
							submitData += '<thead><tr><th width="25%">Title</th><th width="25%">Total</th></tr></thead><tbody>';
							$.each(obj, function(key, value) {
								submitData += '<tr><td>' + value.status
										+ '</td><td>' + value.totalAttendance
										+ '</td></tr>';
							});
							submitData += '</tbody></table></div>';
							$("#submitData").append(submitData);
						},
						error : function(e) {
							alert('error in data');
						}
					});
		} else {
			alert("Please Fill Atleast one Rodio button for every Students");
			$("#submitData").empty();
		}
	}

	function hidesubmitdata() {
		$("#submitData").empty();
	}
	function date() {

		$('#admissionDate').datepick(
				{
					dateFormat : "yyyy-mm-dd",
					inline : true,
					onSelect : function(dateText, inst) {
						var date = $(this).datepick('getDate')
						var formatedDate = $.datepicker.formatDate('yy-mm-dd',
								new Date(date));
						getData(formatedDate);
					}
				});
	}
	if ('${ROLE}' == 'ROLE_EMPLOYEE') {
		getDataDateWise($.datepicker.formatDate('yy-mm-dd', new Date()),
				'${CLASSID}', '${SECTIONID}');
	}
	function getData(formatedDate) {
		getDataDateWise(formatedDate, $("#classId").val(), $("#sectionId")
				.val())
	}

	function getDataDateWise(formatedDate, classId, sectionId) {

		$
				.ajax({
					type : 'GET',
					url : 'getstudentdatewisedata',
					data : {
						'currentDate' : formatedDate,
						'classId' : classId,
						'sectionId' : sectionId
					},
					success : function(data, status) {
						var obj = JSON.parse(data);
						$("#tablebody").empty();
						$("#submitData").empty();
						var holiday='';
						if(obj.HOLIDAY!=''){
							holiday='(' + obj.HOLIDAY+ ')';
						}
						
						var tablebody = '<div class="head blue"><div class="icon"><span class="ico-pen-2"></span></div>';
						tablebody += '<h2>Attendance For Date &nbsp;&nbsp;'
								/* + $.datepicker.formatDate('dd-M-yy', new Date(
										formatedDate)) + holiday+'</h2>'; */
										
												+formatedDate + holiday+'</h2>';
										
						tablebody += '<ul class="buttons"><li><a id="admissionDate" href="javascript:date();" class="btn">Calenders</a></li>';
						tablebody += '<li><a href="javascript:getSummuary();" class="btn">Summary</a></li></ul></div><div class="data-fluid">';
						tablebody += '<table width="100%" cellspacing="0" cellpadding="0" class="table"><thead><tr><th width="12%">Roll No.</th><th width="12%">Student Name</th>';
						tablebody += '<th width="12%">Father Name</th><th width="12%">Present</th><th width="12%">Absent</th><th width="12%">Late</th><th width="12%">Leave</th></tr></thead><tbody>';
						$("#EmployeesDTOsLength").val(obj.length);
						$
								.each(
										obj.StudentDTOs,
										function(key, value) {
											//for admin only
											if ('${ROLE}' == 'ROLE_ADMIN') {
												tablebody += '<tr><td>'
														+ value.rollno
														+ '</td>';

												tablebody += '<td>'
														+ value.fullName
														+ '</td>';

												tablebody += '<td>'
														+ value.fatherName
														+ '</td>';
												tablebody += '<td>';

												if (value.studentAttendanceStatus == 'PRESENT') {
													tablebody += '<input type="radio" name="name'
															+ (key + 1)
															+ '" value="PRESENT" checked="checked" onclick=saveAttendanceRecord(this.value,"'
															+ formatedDate
															+ '",'
															+ value.studentId
															+ ')>';
												} else {
													tablebody += '<input type="radio" name="name'
															+ (key + 1)
															+ '" value="PRESENT" onclick=saveAttendanceRecord(this.value,"'
															+ formatedDate
															+ '",'
															+ value.studentId
															+ ')>';
												}
												tablebody += '</td>';
												tablebody += '<td>';
												if (value.studentAttendanceStatus == 'ABSENT') {
													tablebody += '<input type="radio" name="name'
															+ (key + 1)
															+ '" value="ABSENT" checked="checked" onclick=saveAttendanceRecord(this.value,"'
															+ formatedDate
															+ '",'
															+ value.studentId
															+ ')>';
												} else {
													tablebody += '<input type="radio" name="name'
															+ (key + 1)
															+ '" value="ABSENT" onclick=saveAttendanceRecord(this.value,"'
															+ formatedDate
															+ '",'
															+ value.studentId
															+ ')>';
												}
												tablebody += '</td>';
												tablebody += '<td>';
												if (value.studentAttendanceStatus == 'LATE') {
													tablebody += '<input type="radio" name="name'
															+ (key + 1)
															+ '" value="LATE" checked="checked" onclick=saveAttendanceRecord(this.value,"'
															+ formatedDate
															+ '",'
															+ value.studentId
															+ ')>';
												} else {
													tablebody += '<input type="radio" name="name'
															+ (key + 1)
															+ '" value="LATE" onclick=saveAttendanceRecord(this.value,"'
															+ formatedDate
															+ '",'
															+ value.studentId
															+ ')>';
												}
												tablebody += '</td>';
												tablebody += '<td>';
												if (value.studentAttendanceStatus == 'LEAVE') {
													tablebody += '<input type="radio" name="name'
															+ (key + 1)
															+ '" value="LEAVE" checked="checked" onclick=saveAttendanceRecord(this.value,"'
															+ formatedDate
															+ '",'
															+ value.studentId
															+ ')>';
												} else {
													tablebody += '<input type="radio" name="name'
															+ (key + 1)
															+ '" value="LEAVE" onclick=saveAttendanceRecord(this.value,"'
															+ formatedDate
															+ '",'
															+ value.studentId
															+ ')>';
												}
												tablebody += '</td>';
												tablebody += '</tr>';
											}
											//employee only
											else if ('${ROLE}' == 'ROLE_EMPLOYEE'
													&& $.datepicker
															.formatDate(
																	'dd-M-yy',
																	new Date(
																			formatedDate)) == $.datepicker
															.formatDate(
																	'dd-M-yy',
																	new Date())) {
												tablebody += '<tr><td>'
														+ value.rollno
														+ '</td><td>'
														+ value.fullName
														+ '</td><td>'
														+ value.fatherName
														+ '</td>';
												tablebody += '<td>';

												if (value.studentAttendanceStatus == 'PRESENT') {
													tablebody += '<input type="radio" name="name'
															+ (key + 1)
															+ '" value="PRESENT" checked="checked" onclick=saveAttendanceRecord(this.value,"'
															+ formatedDate
															+ '",'
															+ value.studentId
															+ ')>';
												} else {
													tablebody += '<input type="radio" name="name'
															+ (key + 1)
															+ '" value="PRESENT" onclick=saveAttendanceRecord(this.value,"'
															+ formatedDate
															+ '",'
															+ value.studentId
															+ ')>';
												}
												tablebody += '</td>';
												tablebody += '<td>';
												if (value.studentAttendanceStatus == 'ABSENT') {
													tablebody += '<input type="radio" name="name'
															+ (key + 1)
															+ '" value="ABSENT" checked="checked" onclick=saveAttendanceRecord(this.value,"'
															+ formatedDate
															+ '",'
															+ value.studentId
															+ ')>';
												} else {
													tablebody += '<input type="radio" name="name'
															+ (key + 1)
															+ '" value="ABSENT" onclick=saveAttendanceRecord(this.value,"'
															+ formatedDate
															+ '",'
															+ value.studentId
															+ ')>';
												}
												tablebody += '</td>';
												tablebody += '<td>';
												if (value.studentAttendanceStatus == 'LATE') {
													tablebody += '<input type="radio" name="name'
															+ (key + 1)
															+ '" value="LATE" checked="checked" onclick=saveAttendanceRecord(this.value,"'
															+ formatedDate
															+ '",'
															+ value.studentId
															+ ')>';
												} else {
													tablebody += '<input type="radio" name="name'
															+ (key + 1)
															+ '" value="LATE" onclick=saveAttendanceRecord(this.value,"'
															+ formatedDate
															+ '",'
															+ value.studentId
															+ ')>';
												}
												tablebody += '</td>';
												tablebody += '<td>';
												if (value.studentAttendanceStatus == 'LEAVE') {
													tablebody += '<input type="radio" name="name'
															+ (key + 1)
															+ '" value="LEAVE" checked="checked" onclick=saveAttendanceRecord(this.value,"'
															+ formatedDate
															+ '",'
															+ value.studentId
															+ ')>';
												} else {
													tablebody += '<input type="radio" name="name'
															+ (key + 1)
															+ '" value="LEAVE" onclick=saveAttendanceRecord(this.value,"'
															+ formatedDate
															+ '",'
															+ value.studentId
															+ ')>';
												}
												tablebody += '</td>';
												tablebody += '</tr>';
											}

											else if ('${ROLE}' == 'ROLE_EMPLOYEE'
													&& $.datepicker
															.formatDate(
																	'dd-M-yy',
																	new Date(
																			formatedDate)) != $.datepicker
															.formatDate(
																	'dd-M-yy',
																	new Date())) {
												tablebody += '<tr><td>'
														+ value.rollno
														+ '</td><td>'
														+ value.fullName
														+ '</td><td>'
														+ value.fatherName
														+ '</td>';
												tablebody += '<td>';
												if (value.studentAttendanceStatus == 'PRESENT') {
													tablebody += '<input type="radio" name="name'
															+ (key + 1)
															+ '" value="PRESENT" disabled="disabled" checked="checked" onclick=saveAttendanceRecord(this.value,"'
															+ formatedDate
															+ '",'
															+ value.studentId
															+ ')>';
												} else {
													tablebody += '<input type="radio" name="name'
															+ (key + 1)
															+ '" value="PRESENT" disabled="disabled" onclick=saveAttendanceRecord(this.value,"'
															+ formatedDate
															+ '",'
															+ value.studentId
															+ ')>';
												}
												tablebody += '</td>';
												tablebody += '<td>';
												if (value.studentAttendanceStatus == 'ABSENT') {
													tablebody += '<input type="radio" name="name'
															+ (key + 1)
															+ '" value="ABSENT" disabled="disabled" checked="checked" onclick=saveAttendanceRecord(this.value,"'
															+ formatedDate
															+ '",'
															+ value.studentId
															+ ')>';
												} else {
													tablebody += '<input type="radio" name="name'
															+ (key + 1)
															+ '" value="ABSENT" disabled="disabled" onclick=saveAttendanceRecord(this.value,"'
															+ formatedDate
															+ '",'
															+ value.studentId
															+ ')>';
												}
												tablebody += '</td>';
												tablebody += '<td>';
												if (value.studentAttendanceStatus == 'LATE') {
													tablebody += '<input type="radio" name="name'
															+ (key + 1)
															+ '" value="LATE" disabled="disabled" checked="checked" onclick=saveAttendanceRecord(this.value,"'
															+ formatedDate
															+ '",'
															+ value.studentId
															+ ')>';
												} else {
													tablebody += '<input type="radio" name="name'
															+ (key + 1)
															+ '" value="LATE" disabled="disabled" onclick=saveAttendanceRecord(this.value,"'
															+ formatedDate
															+ '",'
															+ value.studentId
															+ ')>';
												}
												tablebody += '</td>';
												tablebody += '<td>';
												if (value.studentAttendanceStatus == 'LEAVE') {
													tablebody += '<input type="radio" name="name'
															+ (key + 1)
															+ '" value="LEAVE" disabled="disabled"  checked="checked" onclick=saveAttendanceRecord(this.value,"'
															+ formatedDate
															+ '",'
															+ value.studentId
															+ ')>';
												} else {
													tablebody += '<input type="radio" disabled="disabled" name="name'
															+ (key + 1)
															+ '" value="LEAVE" onclick=saveAttendanceRecord(this.value,"'
															+ formatedDate
															+ '",'
															+ value.studentId
															+ ')>';
												}
												tablebody += '</td>';
												tablebody += '</tr>';
											}
										});
						tablebody += '<tr>';
						tablebody += '';
						tablebody += '<td colspan="7" style="border: 1 px solid black;"><div id="currentdatedata"></div><center><a href=javascript:getCurrentDateData("'
								+ formatedDate
								+ '") class="btn">Submit</a></center></td> </tr></tbody></table>';
						tablebody += '</div></div>';
						if (obj.StudentDTOs.length > 0) {
							$("#tablebody").append(tablebody);
						} else {
							$("#tablebody")
									.append(
											'<div class="failedmsg">There Are No Students</h5></div>');
						}
					},
					error : function(e) {
						alert('error in data');
					}
				});
	}

	function getSummuary() {
		$
				.ajax({
					type : 'GET',
					url : 'getstudentattendancesummary',
					data : {
						'classId' : $("#classId").val(),
						'sectionId' : $("#sectionId").val()
					},
					success : function(data, status) {
						$("#appendpop").empty();
						var obj = JSON.parse(data);
						var summary = '<div class="row-fluid"><div class="span12"><div class="block" style="margin-bottom: 0px;">';
						summary += '<div class="head blue"><div class="icon"><span class="ico-pen-2"></span></div>';
						summary += '<h2>Student Attendance Summary till current Date</h2><ul class="buttons"><li><a href="javascript:hideappendpop();">';
						summary += '<div class="icon"><span class="icon-remove"></span></div></a></li></ul></div><div class="data-fluid">';
						summary += '<table width="100%" cellspacing="0" cellpadding="0" class="table"><thead><tr><th>Roll No</th><th>Student Name</th><th>Father Name</th>';
						summary += '<th>Total</th><th>Present</th><th>Absent</th><th>Late</th><th>Leave</th></tr></thead><tbody id="tablebody">';
						$.each(obj, function(key, value) {
							summary += '<tr><td>' + value.rollno + '</td><td>'
									+ value.fullName + '</td><td>'
									+ value.fatherName + '</td><td>'
									+ value.totalAttendance + '</td><td>'
									+ value.totalPresent + '</td><td>'
									+ value.totalAbsent + '</td><td>'
									+ value.totalLate + '</td><td>'
									+ value.totalLeave + '</td></tr>';
						});
						//summary+='<tr><td></td><td></td><td></td><td></td><td></td><td></td></tr>';		
						summary += '</tbody></table></div></div></div></div> ';
						$("#appendpop").append(summary);
						$("#appendpop").show();
					},
					error : function(e) {
						alert('error in data');
					}
				});
	}
	function hideappendpop() {
		$("#appendpop").empty();
		$("#appendpop").hide();
	}
</script>
<div class="content">
	<div id="content-header" style="height: 150px;">
		<img alt="Show_settings" src="${img_url}/takeattendance.png"
			style="width: 57px;">
		<h1>Student Attendance</h1>
		<h3>Register Student Attendance</h3>
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
	<c:if test="${! empty msg && msg!='0'}">
		<div class="alert alert-success"
			style="height: 30px; padding-top: 0px; padding-bottom: 0px;">
			<h5 align="center">
				<font color="red"><b>${msg}</b></font>
			</h5>
		</div>
	</c:if>
	<br> <br> <input type="hidden" id="EmployeesDTOsLength" />
	<div class="row-fluid">
		<div class="span6">
			<div class="block">
				<div class="data-fluid">
					<div class="row-form">
						<div class="span3">Class:</div>
						<div class="span9">
							<select name="classId" id="classId" class="select"
								style="width: 100%;" onchange="getSectionList(this.value);"
								required="required">
								<c:choose>
									<c:when test="${ROLE=='ROLE_EMPLOYEE'}">
										<option value="${StudentClassesDTO.classId}"
											selected="selected">${StudentClassesDTO.className}</option>
									</c:when>
									<c:otherwise>
										<option value="">Select a Class</option>
										<c:forEach var="list" items="${classesList}">
											<option value="${list.classId}">${list.className}</option>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</select>
						</div>
					</div>
				</div>
				<div class="data-fluid">
					<div class="row-form">
						<div class="span3">Section:</div>
						<div class="span9">
							<select name="sectionId" id="sectionId" class="select"
								style="width: 100%;"
								onchange="getData('<fmt:formatDate pattern="yyyy-MM-dd" value="${noww}"/>');"
								required="required">
								<c:choose>
									<c:when test="${ROLE=='ROLE_EMPLOYEE'}">
										<option value="${StudentClassesDTO.sectionId}"
											selected="selected">${StudentClassesDTO.sectionName}</option>
									</c:when>
									<c:otherwise>
										<option value="">Select a Section</option>
									</c:otherwise>
								</c:choose>
							</select>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>



	<div class="row-fluid">
		<div class="span12">
			<div class="block" id="tablebody"></div>
		</div>
		<div class="row-fluid">
			<div class="span6">
				<div class="block">
					<div class="data-fluid"></div>
				</div>
			</div>
			<div class="span6">
				<div class="block" id="submitData"></div>
			</div>
		</div>

		<div class="appendpop" id="appendpop" style="display: none"></div>


	</div>