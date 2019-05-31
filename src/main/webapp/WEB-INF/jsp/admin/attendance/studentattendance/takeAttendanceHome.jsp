<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<spring:url value="/" var="baseurl"></spring:url>
<spring:url value="/img" var="img_url" />
<spring:url value="/style" var="style_url" />
<spring:url value="/css" var="css_url" />
<spring:url value="/js" var="js_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/setting.css">
<%-- <link rel="stylesheet" type="text/css"
	href="${css_url}//newAttendance/pikaday.css">
<link rel="stylesheet" type="text/css"
	href="${css_url}//newAttendance/site.css">
<script src="${js_url}/newAttendance/pikaday.js"></script> --%>
<link rel="stylesheet"
	href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
<link rel="stylesheet" href="/resources/demos/style.css">
<script>
	function showPresentStudentByMonth(status, month, sessionId, sectionId,
			classid) {
		$("#attendance").empty();

		$
				.ajax({
					type : "POST",
					url : 'getAttendaceDetailByMonth.html',
					data : {
						'classId' : classid,
						'sectionId' : sectionId,
						'sessionId' : sessionId,
						'status' : status,
						'monthId' : month,
					},
					success : function(data, status) {
						var studentObj = JSON.parse(data);
						
						var content = '<div class="block"><div class="block-title"><h2><div class="pull-right"><a class="btn btn-sm btn-default" role="button"	onclick="window.print()" href="#"><i class="fa fa-print"></i>Print</a>&nbsp;&nbsp;&nbsp;&nbsp; <a class="btn btn-sm btn-danger" role="button" href="/reports-classmonthly?export_format=pdf&amp;class_monthly_class_id=477934&amp;class_monthly_month_year=06-2015&amp;class_monthly_include_notes=1"><i class="fa fa-file-pdf-o"></i> PDF</a>&nbsp;&nbsp;&nbsp;&nbsp; <a class="btn btn-sm btn-success" role="button" href="/reports-classmonthly?export_format=csv&amp;class_monthly_class_id=477934&amp;class_monthly_month_year=06-2015&amp;class_monthly_include_notes=1"><i class="fa fa-file-excel-o"></i> CSV</a></div><strong>V</strong> June 2015</h2></div>'
								+'<div class="table-responsive"><table class="table table-striped table-vcenter table-bordered table-condensed table-hover" id="general-table">'
								+ '<thead><tr><th class="text-left">Student</th><th class="text-center">1</th><th class="text-center">2</th><th class="text-center">3</th><th class="text-center">4</th><th class="text-center">5</th><th class="text-center">6</th><th class="text-center">7</th><th class="text-center">8</th><th class="text-center">9</th><th class="text-center">10</th><th class="text-center">11</th><th class="text-center">12</th><th class="text-center">13</th><th class="text-center">14</th><th class="text-center">15</th><th class="text-center">16</th><th class="text-center">17</th><th class="text-center">18</th><th class="text-center">19</th><th class="text-center">20</th><th class="text-center">21</th><th class="text-center">22</th><th class="text-center">23</th><th class="text-center">24</th><th class="text-center">25</th><th class="text-center">26</th><th class="text-center">27</th><th class="text-center">28</th><th class="text-center">29</th><th class="text-center">30</th><th class="text-center">31</th></tr></thead>';

						$("#attendance").append(content);
						$("#attendance").show();

					},
					error : function(e) {
						alert(e);
					}
				})

	}

	function ShowAttendace(id, value1, selectedDate, sessionId, sectionId,
			classid) {
		$('#absentbtnId' + id + '').removeClass('btn btn-info');
		$('#absentbtnId' + id + '').removeClass('btn btn-primary');
		$('#absentbtnId' + id + '').removeClass('btn btn-danger');
		$
				.ajax({

					type : "POST",
					url : 'getAttendaceDetail.html',
					data : {
						'classId' : classid,
						'sectionId' : sectionId,
						'sessionId' : sessionId,
						'selectedDate' : selectedDate,
						'status' : value1,
					},
					success : function(data, status) {

						var studentObj = JSON.parse(data);
						$('#studentDiv').empty();
						if (studentObj == '') {
							var error_msg = '<div class="alert alert-error" style="width: 339px; border-radius:5px;"><a class="close" data-dismiss="alert">×</a> <strong>Sorry!&nbsp;</strong>Data not found!!  </div> '
							$('#studentDiv').append(error_msg);
						}
						if (studentObj != '') {
							var content = '';
							content += '<div class="container"><table class="table table-bordered" style="width: 425px; height: 150px;">'
							$
									.each(
											studentObj,
											function(key, value) {
												content += '<tr style="height: 10px;"><td><a href="javascript:message('
														+ id
														+ ')"><span class="glyphicon glyphicon-envelope" style="width: 30px;"></span></a>'
														+ value.fullName
														+ '</td><td><button id="persentbtnId'
													+ value.id
													+ '" type="button"  value="P" class="btn btn-primary">Persent</button></td><td><button id="absentbtnId'

													+ value.id
													+ '" type="button" class = "btn btn-default" value="A">Absent</button>'
														+ '</td><td><button id="latebtnId'

													+ value.id
													+ '" type="button" class = "btn btn-default" value="L" >Late</button></td></tr>';

											});
							content += '</tbody></table></div>';
							$('#studentDiv').append(content);
						}
					},
					error : function(e) {
						alert(e);
					}
				});

	}
	function ShowAttendaceAbsent(id, value1, selectedDate, sessionId,
			sectionId, classid) {

		$('#absentbtnId' + id + '').removeClass('btn btn-info');
		$('#absentbtnId' + id + '').removeClass('btn btn-primary');
		$('#absentbtnId' + id + '').removeClass('btn btn-danger');
		$
				.ajax({

					type : "POST",
					url : 'getAttendaceDetail.html',
					data : {
						'classId' : classid,
						'sectionId' : sectionId,
						'sessionId' : sessionId,
						'selectedDate' : selectedDate,
						'status' : value1,
					},
					success : function(data, status) {

						var studentObj = JSON.parse(data);
						$('#studentDiv').empty();
						if (studentObj == '') {
							var error_msg = '<div class="alert alert-error" style="width: 339px; border-radius:5px;"><a class="close" data-dismiss="alert">×</a> <strong>Sorry!&nbsp;</strong>Data not found!!  </div> '
							$('#studentDiv').append(error_msg);
						}
						if (studentObj != '') {
							var content = '';
							content += '<div class="container"><table class="table table-bordered" style="width: 425px; height: 150px;">'
							$
									.each(
											studentObj,
											function(key, value) {
												content += '<tr style="height: 10px;"><td><a href="javascript:message('
														+ id
														+ ')"><span class="glyphicon glyphicon-envelope" style="width: 30px;"></span></a>'
														+ value.fullName
														+ '</td><td><button id="persentbtnId'
													+ value.id
													+ '" type="button"  value="P" class="btn btn-default">Persent</button></td><td><button id="absentbtnId'

													+ value.id
													+ '" type="button" class = "btn btn-info" value="A">Absent</button>'
														+ '</td><td><button id="latebtnId'

													+ value.id
													+ '" type="button" class = "btn btn-default" value="L" >Late</button></td></tr>';

											});
							content += '</tbody></table></div>';
							$('#studentDiv').append(content);
						}
					},
					error : function(e) {
						alert(e);
					}
				});

	}
	function ShowAttendaceLate(id, value1, selectedDate, sessionId, sectionId,
			classid) {

		$('#absentbtnId' + id + '').removeClass('btn btn-info');
		$('#absentbtnId' + id + '').removeClass('btn btn-primary');
		$('#absentbtnId' + id + '').removeClass('btn btn-danger');
		$
				.ajax({

					type : "POST",
					url : 'getAttendaceDetail.html',
					data : {
						'classId' : classid,
						'sectionId' : sectionId,
						'sessionId' : sessionId,
						'selectedDate' : selectedDate,
						'status' : value1,
					},
					success : function(data, status) {

						var studentObj = JSON.parse(data);
						$('#studentDiv').empty();
						if (studentObj == '') {
							var error_msg = '<div class="alert alert-error" style="width: 339px; border-radius:5px;"><a class="close" data-dismiss="alert">×</a> <strong>Sorry!&nbsp;</strong>Data not found!!  </div> '
							$('#studentDiv').append(error_msg);
						}
						if (studentObj != '') {
							var content = '';
							content += '<div class="container"><table class="table table-bordered" style="width: 425px; height: 150px;">'
							$
									.each(
											studentObj,
											function(key, value) {
												content += '<tr style="height: 10px;"><td><a href="javascript:message('
														+ id
														+ ')"><span class="glyphicon glyphicon-envelope" style="width: 30px;"></span></a>'
														+ value.fullName
														+ '</td><td><button id="persentbtnId'
													+ value.id
													+ '" type="button"  value="P" class="btn btn-default">Persent</button></td><td><button id="absentbtnId'

													+ value.id
													+ '" type="button" class = "btn btn-default" value="A">Absent</button>'
														+ '</td><td><button id="latebtnId'

													+ value.id
													+ '" type="button" class = "btn btn-danger" value="L" >Late</button></td></tr>';

											});
							content += '</tbody></table></div>';
							$('#studentDiv').append(content);
						}
					},
					error : function(e) {
						alert(e);
					}
				});

	}

	function message(studentId) {

		$("#showMessage").empty();
		var selectedDate = $('#attendanceDate').val();
		var sessionId = $('#sessionId').val();
		var sectionId = $('#sectionId').val();
		var classId = $('#classId').val();

		$.ajax({
			type : "GET",
			url : 'getStudentData.html',
			data : {
				'classId' : classId,
				'sectionId' : sectionId,
				'sessionId' : sessionId,
				'studentId' : studentId,
				'selectedDate' : selectedDate,

			},
			success : function(data, status) {
				var studentObj = JSON.parse(data);

				$('#showMessage').dialog({
					autoOpen : false,
					resizeable : true,
					title : 'Message',
					modal : true,

					width : 500,
					positon : 'centre'
				});
				if (studentObj.message!=null && studentObj.message!='' ) {

					var content = '' + '<textArea>' + studentObj.message
							+ '</textArea>';
					$("#showMessage").append(content);
				} else {

					var content = '' + '<textArea>' + "No Message Entered"
							+ '</textArea>';
					$("#showMessage").append(content);
				}
				$("#showMessage").show();

				$('#showMessage').dialog('open');

			},
			error : function(e) {
				alert(e);
			}
		})

	}
	function saveMessage() {
		var studentId = $('#studentId').val();
		var selectedDate = $('#attendanceDate').val();
		var sessionId = $('#sessionId').val();
		var sectionId = $('#sectionId').val();
		var classId = $('#classId').val();
		var message = $("#message1").val();

		$.ajax({
			type : "POST",
			url : 'saveMessage.html',
			data : {
				'classId' : classId,
				'sectionId' : sectionId,
				'sessionId' : sessionId,
				'studentId' : studentId,
				'selectedDate' : selectedDate,
				'message' : message,

			},
			success : function(data, status) {

			},
			error : function(e) {
				alert(e);
			}
		})
		$('#message').dialog('destroy');

	}

	function viewMessage(id) {

		$('#message').dialog({
			autoOpen : false,
			resizeable : true,
			title : 'Enter Your Message',
			modal : true,

			width : 500,
			positon : 'centre'
		});

		$('#studentId').val(id);

		$('#message').dialog('open');
	}

	$(function() {
		$('#attendanceDate').datepicker().datepicker('setDate', new Date());
	});
	jQuery(document)
			.ready(
					function() {
						jQuery("#datepicker")
								.datepicker(
										{
											maxDate : "0",
											changeMonth : true,
											changeYear : true,
											dateFormat : 'mm/dd/yy',
											onSelect : function(date) {
												$('#attendanceDate').val(date);
												var selectedDate = $(
														'#attendanceDate')
														.val();
												var sessionId = $('#sessionId')
														.val();
												var sectionId = $('#sectionId')
														.val();
												var classId = $('#classId')
														.val();
												var date = $(this).datepicker(
														'getDate')

												var month = date.getMonth() + 1;
												$
														.ajax({
															type : "POST",
															url : 'getStudentAttendaceBySelectedDate.html',
															data : {
																'sessionId' : sessionId,
																'classId' : classId,
																'sectionId' : sectionId,
																'selectedDate' : selectedDate,
																'selectedMonth' : month,
															},
															success : function(
																	data,
																	status) {
																var studentObj = JSON
																		.parse(data);
																$('#studentDiv')
																		.empty();
																$(
																		'#attendanceId')
																		.empty();
																$(
																		'#attendanceId1')
																		.empty();
																if (studentObj.studentdtoList == '') {
																	var error_msg = '<div class="alert alert-error" style="width: 339px; border-radius:5px;"><a class="close" data-dismiss="alert">×</a> <strong>Sorry!&nbsp;</strong>Data not found!!  </div> '
																	$(
																			'#studentDiv')
																			.append(
																					error_msg);
																}
																if (studentObj.studentdtoList != '') {
																	var dto = studentObj.attendanceDTO;
																	var con = '';
																	con += '<button type="button" style="margin-left: 80px;" onclick=ShowAttendace('
																			+ dto.studentRegistrationNo
																			+ ',"P","'
																			+ selectedDate
																			+ '","'
																			+ sessionId
																			+ '","'
																			+ sectionId
																			+ '","'
																			+ classId
																			+ '"); value="P" class="btn btn-primary" style="margin-left: 25px;">P:<span class="badge">'
																			+ dto.totalPresent
																			+ '</span> </button><button type="button" onclick=ShowAttendaceAbsent('
																			+ dto.studentRegistrationNo
																			+ ',"A","'
																			+ selectedDate
																			+ '","'
																			+ sessionId
																			+ '","'
																			+ sectionId
																			+ '","'
																			+ classId
																			+ '"); class="btn btn-info">A:<span class="badge">'
																			+ dto.totalAbsent
																			+ '</span></button><button type="button" onclick=ShowAttendaceLate('
																			+ dto.studentRegistrationNo
																			+ ',"L","'
																			+ selectedDate
																			+ '","'
																			+ sessionId
																			+ '","'
																			+ sectionId
																			+ '","'
																			+ classId
																			+ '"); class="btn btn-danger">L:<span class="badge">'
																			+ dto.totalLate
																			+ '</span></button>';
																	$(
																			'#attendanceId')
																			.append(
																					con);
																	var dto = studentObj.monthlyAttendance;
																	var con1 = '';
																	con1 += '<span class="label label-default">For Month</span>&nbsp;&nbsp;&nbsp;<button onclick=showPresentStudentByMonth("P","'
																			+ month
																			+ '","'
																			+ sessionId
																			+ '","'
																			+ sectionId
																			+ '","'
																			+ classId
																			+ '"); type="button" class="btn btn-primary"><a href="showPresentStudentByMonth()">P:</a><span class="badge">'
																			+ dto.monthlyP
																			+ '</span> </button><button onclick=ShowAttendaceAbsent(A,"'
																			+ month
																			+ '","'
																			+ sessionId
																			+ '","'
																			+ sectionId
																			+ '","'
																			+ classId
																			+ '"); type="button" class="btn btn-info">A:<span class="badge">'
																			+ dto.monthlyA
																			+ '</span></button><button onclick=ShowAttendaceLate(L,"'
																			+ month
																			+ '","'
																			+ sessionId
																			+ '","'
																			+ sectionId
																			+ '","'
																			+ classId
																			+ '"); type="button" class="btn btn-danger">L:<span class="badge">'
																			+ dto.montlyL
																			+ '</span></button>';
																	/* $(
																			'#attendanceId1')
																			.append(
																					con1); */

																	var content = '<table class="table table-bordered" style="width: 425px; height: 150px;">';
																	$
																			.each(
																					studentObj.studentdtoList,
																					function(
																							key,
																							value) {
																						if (value.attendanceStatus == 'P') {

																							content += '<tr style="height: 10px;"><td><a href="javascript:message('
																									+ value.studentRegistrationNo
																									+ ')"><span class="glyphicon glyphicon-envelope" style="width: 30px;"></span></a>'
																									+ value.fullName
																									+ '</td><td><button id="persentbtnId'
																								+ value.id
																								+ '" type="button" class="btn btn-primary" value="P"'
																								
																								+ '>Persent</button></td><td><button id="absentbtnId'
																								+ value.id
																								+ '" type="button" class="btn btn-default" value="A">Absent</button>'
																									+ '</td><td><button id="latebtnId'
																								+ value.id
																								+ '" type="button" class="btn btn-default" value="L" ' 
																								
																								+ '>Late</button></td></tr>';
																						}
																						if (value.attendanceStatus == 'A') {
																							content += '<tr style="height: 10px;"><td><a href="javascript:message('
																									+ value.studentRegistrationNo
																									+ ')"><span class="glyphicon glyphicon-envelope" style="width: 30px;"></span></a>'
																									+ value.fullName
																									+ '</td><td><button id="persentbtnId'
																								+ value.id
																								+ '" type="button" class="btn btn-default" value="P"' 
																								
																								+ '>Persent</button></td><td><button id="absentbtnId'
																								+ value.id
																								+ '" type="button" class="btn btn-info" value="A"'
																								
																								+ '>Absent</button>'
																									+ '</td><td><button id="latebtnId'
																								+ value.id
																								+ '" type="button" class="btn btn-default" value="L"'
																								
																								+ '>Late</button></td></tr>';
																						}
																						if (value.attendanceStatus == 'L') {
																							content += '<tr style="height: 10px;"><td><a href="javascript:message('
																									+ value.studentRegistrationNo
																									+ ')"><span class="glyphicon glyphicon-envelope" style="width: 30px;"></span></a>'
																									+ value.fullName
																									+ '</td><td><button id="persentbtnId'
																								+ value.id
																								+ '" type="button" class="btn btn-default"  value="P" '
																								
																								+ '>Persent</button></td><td><button id="absentbtnId'
																								+ value.id
																								+ '" type="button" class="btn btn-default" value="A"'
																								
																								+ '>Absent</button>'
																									+ '</td><td><button id="latebtnId'
																								+ value.id
																								+ '" type="button" class="btn btn-danger" value="L" '
																								
																								+ '>Late</button></td></tr>';
																						}

																					});
																	content += '</table>';
																	$(
																			'#studentDiv')
																			.append(
																					content);
																}
															},
															error : function(e) {
																alert(e);
															}

														});

											}
										});
					});
</script>
<script>
	function getSection() {
		$('#sectionId').empty();
		$('#studentDiv').empty();
		$('#attendanceId').empty();
		var classId = $('#classId').val();

		$.ajax({
			type : "POST",
			url : 'getSection.html',
			data : {
				'classId' : classId
			},
			success : function(data, status) {
				var sectionList = JSON.parse(data);
				var content = '<option value="">--Select Section--</option>';
				for (var i = 0; i < sectionList.length; i++) {
					content += '<option value="'+sectionList[i].sectionId+'">'
							+ sectionList[i].sectionName + '</option>';
				}
				$('#sectionId').append(content);
			},
			error : function(e) {
				alert(e);
			}
		})
	}
	function getStudent() {
		$('#studentDiv').empty();
		$('#attendanceId').empty();
		var sessionId = $('#sessionId').val();
		var sectionId = $('#sectionId').val();
		var classId = $('#classId').val();
		$(document).ajaxStart(function() {
			$("#loadingmessage").show();
		});
		$(document).ajaxStop(function() {
			$("#loadingmessage").hide();
		});
		$
				.ajax({

					type : "POST",
					url : 'getStudent.html',
					data : {
						'sessionId' : sessionId,
						'classId' : classId,
						'sectionId' : sectionId

					},
					success : function(data, status) {
						var studentObj = JSON.parse(data);
						if (studentObj == '') {
							var error_msg = '<div class="alert alert-error" style="width: 339px; border-radius:5px;"><a class="close" data-dismiss="alert">×</a> <strong>Sorry!&nbsp;</strong>Data not found!!  </div> '
							$('#studentDiv').append(error_msg);
						}
						if (studentObj != '') {
							var content = '';
							content += '<div class="container"><table class="table table-bordered" style="width: 425px; height: 150px;">'
							$
									.each(
											studentObj,
											function(key, value) {

												content += '<tr style="height: 10px;"><td><a href="javascript:viewMessage('
														+ value.id
														+ ')"><span class="glyphicon glyphicon-envelope" style="width: 30px;"></span></a>'
														+ value.firstName
														+ '</td><td><button id="persentbtnId'
														+ value.id
														+ '" type="button"  value="P" class="btn btn-default" onclick="saveAttendance(this.value,'
														+ value.id
														+ ');">Persent</button></td><td><button id="absentbtnId'

														+ value.id
														+ '" type="button" class = "btn btn-default" value="A"onclick="saveAttendance(this.value,'
														+ value.id
														+ ');">Absent</button>'
														+ '</td><td><button id="latebtnId'

														+ value.id
														+ '" type="button" class = "btn btn-default" value="L" onclick="saveAttendance(this.value,'
														+ value.id
														+ ');">Late</button></td></tr>';

											});
							content += '</tbody></table></div>';
							$('#studentDiv').append(content);
						}
					},
					error : function(e) {
						alert(e);
					}
				});
	}
	function saveAttendance(value, id) {
		var attendanceDate = $('#attendanceDate').val();
		var sessionId = $('#sessionId').val();
		var sectionId = $('#sectionId').val();
		var classId = $('#classId').val();
		if (value == 'P') {
			$('#persentbtnId' + id + '').addClass('btn btn-primary');
			$('#absentbtnId' + id + '').removeClass('btn btn-info');
			$('#absentbtnId' + id + '').addClass('btn btn-default');
			$('#latebtnId' + id + '').removeClass('btn btn-danger');
			$('#latebtnId' + id + '').addClass('btn btn-default');
			$.ajax({
				type : 'post',
				url : 'saveAttendance',
				data : {
					'studentId' : id,
					'attendanceStatus' : value,
					'sessionId' : sessionId,
					'classId' : classId,
					'sectionId' : sectionId,
					'attendanceDate' : attendanceDate
				},
				error : function(e) {
					alert('error in data');
				}
			});
		}
		if (value == 'A') {
			$('#absentbtnId' + id + '').addClass('btn btn-info');
			$('#persentbtnId' + id + '').removeClass('btn btn-primary');
			$('#latebtnId' + id + '').removeClass('btn btn-danger');
			$('#latebtnId' + id + '').addClass('btn btn-default');
			$('#persentbtnId' + id + '').addClass('btn btn-default');
			$.ajax({
				type : 'post',
				url : 'saveAttendance',
				data : {
					'studentId' : id,
					'attendanceStatus' : value,
					'sessionId' : sessionId,
					'classId' : classId,
					'sectionId' : sectionId,
					'attendanceDate' : attendanceDate
				},
				error : function(e) {
					alert('error in data');
				}
			});
		}
		if (value == 'L') {
			$('#latebtnId' + id + '').addClass('btn btn-danger');
			$('#persentbtnId' + id + '').removeClass('btn btn-primary');
			$('#absentbtnId' + id + '').removeClass('btn btn-info');
			$('#persentbtnId' + id + '').addClass('btn btn-default');
			$('#absentbtnId' + id + '').addClass('btn btn-default');
			$.ajax({
				type : 'post',
				url : 'saveAttendance',
				data : {
					'studentId' : id,
					'attendanceStatus' : value,
					'sessionId' : sessionId,
					'classId' : classId,
					'sectionId' : sectionId,
					'attendanceDate' : attendanceDate
				},
				error : function(e) {
					alert('error in data');
				}
			});
		}
	}
</script>
<body>
	<div id="content_wrapper">
		<div id="side_bar">
			<div id="sidebar_news_area"></div>
		</div>
		<div id="content">
			<div id="content-header">
				<img alt="Show_settings" src="${img_url}/sfees.jpg"
					style="width: 50px;">
				<h1>Student Attendance</h1>
				<h3>Take Attendance of student</h3>
				<div id="app-back-button">
					<a href="#" onclick="history.back(); return false;"><img
						alt="Back" border="0" src="${img_url}/back1.png"
						style="margin-top: -22px;"></a>
				</div>
			</div>
			<%-- <div id="box">

					<table>
						<tr>
							<td><label for="sel1">Class Name:</label></td>
							<td><label><select name="className" id="classId"
									class="form-control"
									style="margin-top: -26px; margin-left: 100px; width: 200px;"
									onchange="getSection();">
										<option>-Choose Class-</option>
										<c:forEach items="${classList}" var="list">
											<option value="${list.classId}">${list.className}</option>
										</c:forEach>
								</select> </label></td>
						</tr>
						<tr>
							<td><label style="width: 90px;">Section :</label></td>
							<td><label><select name="sectionName" id="section"
									style="margin-top: -26px; margin-left: 100px; width: 200px;"
									onchange="getStudent();">
										<option>-Choose Section-</option>

								</select> </label></td>
						</tr>
						<tr>
							<td><label for="datepicker">Date:</label> <br> <input
								type="text" id="attendanceDate"></td>
						</tr>
					</table>
				</div> --%>
			<input type="hidden" id="attendanceDate">
			<div class="span4" style="float: left;">
				<div class="block" style="width: 299px;">
					<div id="searches1"
						style="height: 233px; width: 365px; border: 1px solid lightgray; background-color: rgb(238, 238, 238); border-radius: 5px;">
						<div class="data-fluid">
							<div class="row-form"
								style="padding-bottom: 13px; padding-top: 30px;">
								<div class="span4">Session :</div>
								<div class="span8">
									<select id="sessionId" class="validate[required]"
										name="sessionId"
										style="width: 190px; margin-top: -27px; margin-left: 82px;"
										name="sessionId">
										<option value="1">2015-2016</option>
										<option value="2">2014-2015</option>
									</select>
								</div>
							</div>
							<div class="row-form">
								<div class="span4" style="margin-top: 13px;">Class :</div>
								<div class="span8">
									<select id="classId" class="validate[required]"
										onchange="getSection();" name="classId"
										style="width: 190px; margin-top: -28px; margin-left: 81px;">
										<option value="">Select a Class</option>
										<c:forEach items="${classList}" var="list">
											<option value="${list.classId}">${list.className}</option>
										</c:forEach>
									</select>
								</div>
							</div>
							<div class="row-form">
								<div class="span4" style="margin-top: 14px;">Section :</div>
								<div class="span8">
									<select id="sectionId" class="validate[required]"
										style="width: 190px; margin-top: -30px; margin-left: 80px;"
										onchange="getStudent();" name="sectionId">
										<option value="">Select a Section</option>
									</select>
								</div>
							</div>
						</div>
						<div class="separator"></div>
					</div>
				</div>
				<div id="datepicker"
					style="width: 223px; margin-left: -1px; margin-top: 15px;"></div>
				<div id="attendanceId" style="width: 372px; margin-left: -45px;"></div>
				<div id="attendanceId1" style="width: 372px; margin-left: -45px;"></div>
			</div>
			<div style="width: 430px; margin-top: 36px; float: right;"
				id="studentDiv"></div>
			
			<div id='loadingmessage'
				style="display: none; float: right; margin-top: 48px; margin-left: -100px; width: 103px; height: 107px;">
				<img src='${img_url}/ajax_preloader.gif' />
			</div>

		</div>

		<div class="extender"></div>


	</div>
<!-- 	<div id="attendance" style="display: none">
		<div class="block" id="block1">
			Table Styles Title
			<div class="block-title">
				<h2 style="width: 99%">
					<div class="pull-right">
						<a class="btn btn-sm btn-default" role="button"
							onclick="window.print()" href="#"><i class="fa fa-print"></i>
							Print</a>&nbsp;&nbsp;&nbsp;&nbsp; <a class="btn btn-sm btn-danger"
							role="button"
							href="/reports-classmonthly?export_format=pdf&amp;class_monthly_class_id=477934&amp;class_monthly_month_year=06-2015&amp;class_monthly_include_notes=1"><i
							class="fa fa-file-pdf-o"></i> PDF</a>&nbsp;&nbsp;&nbsp;&nbsp; <a
							class="btn btn-sm btn-success" role="button"
							href="/reports-classmonthly?export_format=csv&amp;class_monthly_class_id=477934&amp;class_monthly_month_year=06-2015&amp;class_monthly_include_notes=1"><i
							class="fa fa-file-excel-o"></i> CSV</a>
					</div>
					<strong>V</strong> June 2015
				</h2>
			</div>
			END Table Styles Title

			Table Styles Content
			Changing classes functionality initialized in js/pages/tablesGeneral.js
			<div class="table-responsive">
				<table
					class="table table-striped table-vcenter table-bordered table-condensed table-hover"
					id="general-table">
					<thead>
						<tr>
							<th class="text-left">Student</th>
							<th class="text-center">1</th>
							<th class="text-center">2</th>
							<th class="text-center">3</th>
							<th class="text-center">4</th>
							<th class="text-center">5</th>
							<th class="text-center">6</th>
							<th class="text-center">7</th>
							<th class="text-center">8</th>
							<th class="text-center">9</th>
							<th class="text-center">10</th>
							<th class="text-center">11</th>
							<th class="text-center">12</th>
							<th class="text-center">13</th>
							<th class="text-center">14</th>
							<th class="text-center">15</th>
							<th class="text-center">16</th>
							<th class="text-center">17</th>
							<th class="text-center">18</th>
							<th class="text-center">19</th>
							<th class="text-center">20</th>
							<th class="text-center">21</th>
							<th class="text-center">22</th>
							<th class="text-center">23</th>
							<th class="text-center">24</th>
							<th class="text-center">25</th>
							<th class="text-center">26</th>
							<th class="text-center">27</th>
							<th class="text-center">28</th>
							<th class="text-center">29</th>
							<th class="text-center">30</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td class="text-left">Vasim Akram</td>
							<td class="text-center">A</td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center">P</td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
						</tr>
						<tr>
							<td class="text-left">Sruti Baniya</td>
							<td class="text-center">P</td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center">A</td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
						</tr>
						<tr>
							<td class="text-left">Sweety Dalal</td>
							<td class="text-center">T</td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center">A</td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
						</tr>
						<tr>
							<td class="text-left">Rohan Punk</td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center">T</td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
							<td class="text-center"></td>
						</tr>
					</tbody>
				</table>
			</div>
 -->
			<!-- END Table Styles Content -->
			<div id="attendance" style="display: none"></div>
		</div>


	</div>
	<div id="showMessage" style="display: none"></div>
	
	<div id="message" style="display: none;">
		<div>
			<textarea cols="1" rows="1" name="message" id="message1"></textarea>
			<input type="hidden" id="studentId" name="studentId">
			<button type="button" class="btn btn-primary"
				onclick="saveMessage();">Submit</button>
		</div>
	</div>

</body>