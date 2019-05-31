<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url value="/style/theme/images" var="imageurl" />
<spring:url value="/img" var="img_url" />
<spring:url value="/" var="base_url" />
<spring:url value="/css" var="css_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/admission.css">

<script type="text/javascript">
	function namesearch() {
		$("#namesc").css({
			"background-color" : "#b00"
		});
		$("#classsc").css({
			"background-color" : ""
		});
		$("#fathersc").css({
			"background-color" : ""
		});
		$("#categoryscc").css({
			"background-color" : ""
		});
		$("#addressSearch").css({
			"background-color" : ""
		});
		$("#categorysc").hide();
		$("#searches").hide();
		$("#classsc").show();
		$("#namesearch").show();
		$("#students").empty();
		$("#fathersearch").hide();
		$("#addresssc").hide();
		datas();
	}
	function addressSearch() {
		$("#addressSearch").css({
			"background-color" : "#b00"
		});
		$("#classsc").css({
			"background-color" : ""
		});
		$("#namesc").css({
			"background-color" : ""
		});
		$("#fathersc").css({
			"background-color" : ""
		});
		$("#categoryscc").css({
			"background-color" : ""
		});
		$("#fathersearch").hide();
		$("#namesearch").hide();
		$("#searches").hide();
		$("#students").empty();
		$("#addresssc").show();
		$("#categorysc").hide();

		datas();
	}
	function loads() {
		$("#classsc").css({
			"background-color" : "#b00"
		});
		$("#fathersc").css({
			"background-color" : ""
		});
		$("#namesc").css({
			"background-color" : ""
		});
		$("#addressSearch").css({
			"background-color" : ""
		});
		$("#namesearch").hide();
		$("#fathersearch").hide();
		$("#categorysc").hide();
		$("#addresssc").hide();
		
		datas();
	}
	function classsearch() {
		$("#classsc").css({
			"background-color" : "#b00"
		});
		$("#fathersc").css({
			"background-color" : ""
		});
		$("#namesc").css({
			"background-color" : ""
		});
		$("#categorysc").css({
			"background-color" : ""
		});
		$("#addressSearch").css({
			"background-color" : ""
		});
		$("#categoryscc").css({
			"background-color" : ""
		});
		$("#categorysc").hide();
		$("#namesearch").hide();
		$("#students").empty();
		$("#searches").show();
		$("#fathersearch").hide();
		$("#addresssc").hide();
		datas();
	}
	function fathersearch() {
		$("#fathersc").css({
			"background-color" : "#b00"
		});
		$("#classsc").css({
			"background-color" : ""
		});
		$("#namesc").css({
			"background-color" : ""
		});
		$("#categoryscc").css({
			"background-color" : ""
		});
		$("#categorysc").hide();
		$("#namesearch").hide();
		$("#students").empty();
		$("#fathersearch").show();
		$("#searches").hide();
		$("#addresssc").hide();
		datas();
	}
	function Categorysearch() {
		$("#categoryscc").css({
			"background-color" : "#b00"
		});
		$("#classsc").css({
			"background-color" : ""
		});
		$("#namesc").css({
			"background-color" : ""
		});
		$("#fathersc").css({
			"background-color" : ""
		});
		$("#addressSearch").css({
			"background-color" : ""
		});
		$("#fathersearch").hide();
		$("#namesearch").hide();
		$("#searches").hide();
		$("#students").empty();
		$("#categorysc").show();
		$("#addresssc").hide();

		datas();
	}
	function datas() {
		$("#students").empty();
		$("#classId").val('');
		$("#sectionId").val('');
		$("#classById").val('');
		$("#fatherName").val('');
		$("#firstName").val('');
	}
	function ndatas() {
		$("#firstName").val('');
	}

	function getStudentsListsbyclass() {
		var sessionId = $("#sessionId").val();
		var classId = $("#classId").val();
		var sectionId = $("#sectionId").val();
		$
				.ajax({
					type : 'POST',
					url : '${base_url}get-student-list',
					data : {
						'classId' : classId,
						'sectionId' : sectionId,
						'sessionId' : sessionId
					},
					success : function(data, status) {
						$("#students").empty();
						var j = JSON.parse(data);
						var length = j.length;
						var st = "";
						if (length == 0) {
							st = '<div class="failedmsg"><b>There Are No More Students For This Class</b></div>';
						} else {
							st = '<div class="widget-body" style="padding: 10px;"><div class="separator"></div><div class="btn-group" style="width: 1059px;"></div>'
									+ '<div class="block"><div class="block"><a class=" button btn-primary" target="_blank" style="float: right; margin-top: -39px; width: 129px; height: 26px; padding-left: 10px; padding-top: 3px; margin-bottom: -12px; margin-right: 409px;"href="getClassPdf?classId='
									+ classId
									+ '&sessionId='
									+ sessionId
									+ '" target="_blank"><b>Classwise Pdf</b></a><a class=" button btn-primary" target="_blank" style="float: right; margin-top: -39px; margin-right: 564px; width: 137px; height: 26px; padding-left: 10px; padding-top: 3px; margin-bottom: -12px;"href="getClassExcel?classId='
									+ classId
									+ '&sessionId='
									+ sessionId
									+ '"><b>Classwise Excel</b></a>'
									+ '<a class=" button btn-primary" target="_blank" style="float: right; margin-top: -40px; margin-left: -34px; width: 145px; height: 29px; border-width: 1px; padding-left: 8px; padding-top: 2px; margin-right: 247px;" href="getSectionExcel?classId='
									+ classId
									+ '&sectionId='
									+ sectionId
									+ ' &sessionId='
									+ sessionId
									+ '" target="_blank"><b>Sectionwise Excel</b></a>'
									+ '<a class=" button btn-primary" style="float: right; margin-top: -40px; margin-left: -34px; margin-right: 98px; width: 136px; height: 29px; border-width: 1px; padding-left: 8px; padding-top: 2px;" href="getSectionPdf?classId='
									+ classId
									+ '&sectionId='
									+ sectionId
									+ ' &sessionId='
									+ sessionId
									+ '" target="_blank"><b>Sectionwise Pdf</b></a>'
									+ '<div class="head blue" style="height:30px;padding:0.5px 0 0 20px;"><h4>Student Details</h4><span style="color:white;float:right;margin-top: -35px;margin-right: 27px;">'
									+ 'Total no. of Students:'
									+ length
									+ '</span></div>'
									+ '<table class="table table-bordered table-primary"><th>Name</th><th>Father Name</th><th>Mother Name</th><th>Operations</th><th>Operations</th><th>Operations</th><th>Transfer</th><th>Operations</th>';
							for (var i = 0; i < length; i++) {

								st += '<tr><td style="width: 200px;"><a href="show-student-details?id='
										+ j[i].admissionNo
										+ '">'
										+ j[i].firstName
										+ '\t'
										+ j[i].middleName
										+ '\t'
										+ j[i].lastName
										+ '</td><td>'
										+ j[i].fatherName
										+ '</td><td>'
										+ j[i].motherName
										+ '</td>'
										+ '<td><a href="edit-student-details?id='
										+ j[i].admissionNo
										+ '">Edit</a></td>'
										+ '<td><a href="javascript:removeStudentbyclass('
										+ j[i].admissionNo
										+ ')"><span class="label label-important">Cancel Admission</span></a></td>'

								if (j[i].transfer.match('YES')) {

									st += '<td><a href="generate-tc.html?id='
									st += j[i].admissionNo
									st += '"target="_blank"> '
									st += '<span class="label label-important"><font size="2"><b>Generate TC</b></font></span></a></td>'
									st += '<td><a href="generate-tc.html?id='
									st += j[i].admissionNo
									st += '"target="_blank"> '
									st += '<span class="label label-important"><font size="2"><b>YES</b></font></span></a></td>'
										+ '<td><a href="student-overview.html?id='
										+ j[i].admissionNo
										+ '&sessionId='
										+ sessionId
										+ '"><span '
													+'class="label label-success"><font size="2"><b>Overview</b></font></span></a></td></tr>'
								} else {
									st += '<td><a href="generate-tc.html?id='
									st += j[i].admissionNo
									st += '"target="_blank"><span '
												st+='class="label label-primary"><font size="2"><b>Generate TC</b></font></span></a></td>'
									st += '<td>'
									st += '<span class="label label-primary"><font size="2"><b>NO</b></font></span></td>'
									st += '<td><a href="student-overview.html?id='
									st += j[i].admissionNo
									st += '&sessionId='
									st += sessionId
									st += '"><span '
									st +='class="label label-success"><font size="2"><b>Overview</b></font></span></a></td></tr>';

								}

								/* + '<td><a href="generate-tc.html?id='
								+ j[i].admissionNo
								+ '"target="_blank"><span '
										+'class="label label-danger"><font size="2" ><b>Generate TC</b></font></span></a></td></tr>';
								 */
							}
							st = st + '</table></div>';
						}
						$("#students").append(st);

					},
					error : function(error, status) {

					}
				});

	}

	function getStudents(firstName) {
		$("#students").empty();
		var classId = $("#classById").val();
		var sessionId = $("#sessionById").val();
		if (classId == '' || classId == null) {
			$("#students")
					.append('<div class="failedmsg">Select a Class</div>');
		} else {
			var url = 'getStudents/' + classId + '/' + firstName + '/'
					+ sessionId;
			$
					.ajax({
						url : url,
						type : 'POST',
						success : function(data, status) {
							$("#students").empty();

							var j = JSON.parse(data);

							var length = j.length;
							var st = "";
							if (length == 0) {
								st = '<div class="failedmsg"><b>There Are No Students of this Name</b></div>';
							} else {
								st = '<div><div class="widget-body" style="padding: 10px 0 0;"><div class="separator"></div><div class="btn-group" style="width: 1059px;">'
										+ '</div><div class="block"><div class="head blue" style="height:30px;padding:0.5px 0 0 20px;"><h4>Students List</h4><span style="color:white;float:right;margin-top: -35px;margin-right: 27px;">Total no. of Students: '
										+ length
										+ '</span></div>'
										+ '<table class="table table-bordered table-primary"><thead><tr><th>Student Name</th><th>Father Name</th><th>Mother Name</th><th>Class</th><th>Section</th><th>Operations</th><th>Operations</th><th>Operations</th><th>Transfer</th><th>Operations</th></tr></thead><tbody>';

								for (var i = 0; i < length; i++) {

									st = st
											+ '<tr><td style="width: 200px;"><a href="show-student-details?id='
											+ j[i].admissionNo
											+ '">'
											+ j[i].firstName
											+ '\t'
											+ j[i].middleName
											+ '\t'
											+ j[i].lastName
											+ '</td>'
											+ '<td>'
											+ j[i].fatherName
											+ '</td><td>'
											+ j[i].motherName
											+ '</td><td>'
											+ j[i].className
											+ '</td><td>'
											+ j[i].sectionName
											+ '</td><td><a href="edit-student-details?id='
											+ j[i].admissionNo
											+ '">Edit</a></td>'
											+ '<td><a href="javascript:removeStudent('
											+ j[i].admissionNo
											+ ')"><span class="label label-important">Cancel Admission</span></a></td>'

									if (j[i].transfer.match('YES')) {

										st += '<td><a href="generate-tc.html?id='
										st += j[i].admissionNo
										st += '"target="_blank"> '
										st += '<span class="label label-important"><font size="2"><b>Generate TC</b></font></span></a></td>'
										st += '<td><a href="generate-tc.html?id='
										st += j[i].admissionNo
										st += '"target="_blank"> '
										st += '<span class="label label-important"><font size="2"><b>YES</b></font></span></a></td>'
												+ '<td><a href="student-overview.html?id='
												+ j[i].admissionNo
												+ '&sessionId='
												+ sessionId
												+ '"><span '
															+'class="label label-success"><font size="2"><b>Overview</b></font></span></a></td></tr>';
									} else {
										st += '<td><a href="generate-tc.html?id='
										st += j[i].admissionNo
										st += '"target="_blank"><span '
													st+='class="label label-primary"><font size="2"><b>Generate TC</b></font></span></a></td>'
										st += '<td><a href="generate-tc.html?id='
										st += j[i].admissionNo
										st += '"target="_blank"> '
										st += '<span class="label label-primary"><font size="2"><b>NO</b></font></span></a></td>'
												+ '<td><a href="student-overview.html?id='
												+ j[i].admissionNo
												+ '&sessionId='
												+ sessionId
												+ '"><span '
																+'class="label label-success"><font size="2"><b>Overview</b></font></span></a></td></tr>';

									}

									/* + '<td><a href="generate-tc.html?id='
									+ j[i].admissionNo
									+ '"target="_blank"><span '
											+'class="label label-primary"><font size="2"><b>Generate TC</b></font></span></a></td></tr>';
									 */
								}

								st = st + '</tbody></table></div></div></div>';
							}
							$("#students").append(st);

						},
						error : function(error, status) {

						}
					});
		}
	}
	function databycategory(categoryId) {
		$("#students").empty();
		var sessionId = $("#sessionByCId").val();
		
		$("#cclassId").val('');
		var url = 'getStudentsbyfatherNames/' + categoryId + '/' + sessionId;
		$.ajax({
			url : url,
			type : 'POST',
			success : fatherSearch,
			error : function(error, status) {
			}
		});

	}

	function getStudentsbyfatherName(fatherName) {
		$("#students").empty();
		var sessionId = $("#sessionByFId").val();
		var url = 'getStudentsbyfatherName/' + fatherName + '/' + sessionId;
		$.ajax({
			url : url,
			type : 'POST',
			success : fatherSearch,
			error : function(error, status) {
			}
		});

	}
	function fatherSearch(data, status) {
		$("#students").empty();
		var sessionId = $("#sessionById").val();
		var j = JSON.parse(data);
		var length = j.length;
		var st = "";
		if (length == 0) {
			st = '<div class="failedmsg"><b>There are no  Students of this category</b></div>';
		} else {
			st = '<div><div class="widget-body" style="padding: 10px 0 0;"><div class="separator"></div><div class="btn-group" style="width: 1059px;">'
					+ '</div><div class="block"><div class="head blue" style="height:30px;padding:0.5px 0 0 20px;"><h4>Students List</h4><span style="color:white;float:right;margin-top: -35px;margin-right: 27px;">Total no. of Students: '
					+ length
					+ '</span></div>'
					+ '<table class="table table-bordered table-primary"><thead><tr><th>Student Name</th><th>Father Name</th><th>Mother Name</th><th>Class</th><th>Section</th><th>Operations</th><th>Operations</th><th>Operations</th><th>Transfer</th><th>Operations</th></tr></thead><tbody>';

			for (var i = 0; i < length; i++) {

				st = st
						+ '<tr><td style="width: 200px;"><a href="show-student-details?id='
						+ j[i].admissionNo
						+ '">'
						+ j[i].firstName
						+ '\t'
						+ j[i].middleName
						+ '\t'
						+ j[i].lastName
						+ '</td>'
						+ '<td>'
						+ j[i].fatherName
						+ '</td><td>'
						+ j[i].motherName
						+ '</td><td>'
						+ j[i].className
						+ '</td><td>'
						+ j[i].sectionName
						+ '</td><td><a href="edit-student-details?id='
						+ j[i].admissionNo
						+ '">Edit</a></td>'
						+ '<td><a href="javascript:removeStudentbycategory('
						+ j[i].admissionNo
						+ ')"><span class="label label-important">Cancel Admission</span></a></td>'

				if (j[i].transfer.match('YES')) {

					st += '<td><a href="generate-tc.html?id='
					st += j[i].admissionNo
					st += '"target="_blank"> '
					st += '<span class="label label-important"><font size="2"><b>Generate TC</b></font></span></a></td>'
					st += '<td><a href="generate-tc.html?id='
					st += j[i].admissionNo
					st += '"target="_blank"> '
					st += '<span class="label label-important"><font size="2"><b>YES</b></font></span></a></td>'
					st += '<td><a href="student-overview.html?id='
					st += j[i].admissionNo
					st += '&sessionId='
					st += sessionId
					st += '"><span '
					st +='class="label label-success"><font size="2"><b>Overview</b></font></span></a></td></tr>';
				} else {
					st += '<td><a href="generate-tc.html?id='
					st += j[i].admissionNo
					st += '"target="_blank"><span '
								st+='class="label label-primary"><font size="2"><b>Generate TC</b></font></span></a></td>'
					st += '<td><a href="generate-tc.html?id='
					st += j[i].admissionNo
					st += '"target="_blank"><span '
					st+='class="label label-primary"><font size="2"><b>NO</b></font></span></a></td>'
					
					st += '<td><a href="student-overview.html?id='
					st += j[i].admissionNo
					st += '&sessionId='
					st += sessionId
					st += '"><span '
					st +='class="label label-success"><font size="2"><b>Overview</b></font></span></a></td></tr>';


				}
			}
			st = st + '</tbody></table></div></div></div>';
		}
		$("#students").append(st);
	}

	function getStudentsByAddress(addressLine1) {
		$("#students").empty();
		var classId = $("#cclassAId").val();
		var sessionId = $("#sessionByAId").val();
		if (classId == '' || classId == null) {
			$("#students")
					.append('<div class="failedmsg">Select a Class</div>');
		} else {
			var url = 'getStudentsbyaddress/' + classId + '/' + addressLine1
					+ '/' + sessionId;
			$
					.ajax({
						url : url,
						type : 'POST',
						success : function(data, status) {
							$("#students").empty();

							var j = JSON.parse(data);

							var length = j.length;
							var st = "";
							if (length == 0) {
								st = '<div class="failedmsg"><b>There Are No Students of this Name</b></div>';
							} else {
								st = '<div><div class="widget-body" style="padding: 10px 0 0;"><div class="separator"></div><div class="btn-group" style="width: 1059px;">'
										+ '</div><div class="block"><div class="head blue" style="height:30px;padding:0.5px 0 0 20px;"><h4>Students List</h4><span style="color:white;float:right;margin-top: -35px;margin-right: 27px;">Total no. of Students: '
										+ length
										+ '</span></div>'
										+ '<table class="table table-bordered table-primary"><thead><tr><th>Student Name</th><th>Father Name</th><th>Address</th><th>Class</th><th>Section</th><th>Operations</th><th>Operations</th><th>Operations</th><th>Transfer</th><th>Operations</th></tr></thead><tbody>';

								for (var i = 0; i < length; i++) {

									st = st
											+ '<tr><td style="width: 200px;"><a href="show-student-details?id='
											+ j[i].admissionNo
											+ '">'
											+ j[i].firstName
											+ '\t'
											+ j[i].middleName
											+ '\t'
											+ j[i].lastName
											+ '</td>'
											+ '<td>'
											+ j[i].fatherName
											+ '</td><td>'
											+ j[i].addressLine1
											+ '</td><td>'
											+ j[i].className
											+ '</td><td>'
											+ j[i].sectionName
											+ '</td><td><a href="edit-student-details?id='
											+ j[i].admissionNo
											+ '">Edit</a></td>'
											+ '<td><a href="javascript:removeStudent('
											+ j[i].admissionNo
											+ ')"><span class="label label-important">Cancel Admission</span></a></td>'
									if (j[i].transfer.match('YES')) {

										st += '<td><a href="generate-tc.html?id='
										st += j[i].admissionNo
										st += '"target="_blank"> '
										st += '<span class="label label-important"><font size="2"><b>Generate TC</b></font></span></a></td>'
										st += '<td><a href="generate-tc.html?id='
										st += j[i].admissionNo
										st += '"target="_blank"> '
										st += '<span class="label label-important"><font size="2"><b>YES</b></font></span></a></td>'
										st += '<td><a href="student-overview.html?id='
										st += j[i].admissionNo
										st += '&sessionId='
										
										st += sessionId
										st += '"><span '
										st +='class="label label-success"><font size="2"><b>Overview</b></font></span></a></td></tr>';

									} else {
										st += '<td><a href="generate-tc.html?id='
										st += j[i].admissionNo
										st += '"target="_blank"><span '
													st+='class="label label-primary"><font size="2"><b>Generate TC</b></font></span></a></td>'
										st += '<td><a href="generate-tc.html?id='
										st += j[i].admissionNo
										st += '"target="_blank"><span '
										st+='class="label label-primary"><font size="2"><b>NO</b></font></span></a></td>'
										st += '<td><a href="student-overview.html?id='
										st += j[i].admissionNo
										st += '&sessionId='
										
										st += sessionId
										st += '"><span '
										st +='class="label label-success"><font size="2"><b>Overview</b></font></span></a></td></tr>';


									}
								}

								st = st + '</tbody></table></div></div></div>';
							}
							$("#students").append(st);

						},
						error : function(error, status) {

						}
					});
		}
	}

	function removeStudent(id) {
		var classId = $("#classById").val();
		var sessionId = $("#sessionById").val();
		var firstName = $("#firstName").val();
		var url = 'removestudent/' + id + '/' + firstName + '/' + sessionId
				+ '/' + classId;
		$
				.ajax({
					url : url,
					type : 'POST',
					success : function(data, status) {
						$("#students").empty();
						var j = JSON.parse(data);
						var st = "";
						var length = j.length;
						if (length == 0) {
							st = '<div class="failedmsg">There Are No More Students For This Class</div>';
						} else {
							st = '<div class="successmsg"><b>Student Addmission Cancel Successfully</b></div><div class="widget-body" style="padding: 10px 0 0;"><div class="separator"></div><div class="btn-group" style="width: 1059px;">'
									+ '</div><div class="block"><div class="head blue" style="height:30px;padding:0.5px 0 0 20px;"><h4>Students List</h4><span style="color:white;float:right;margin-top: -35px;margin-right: 27px;">Total no. of Students: '
									+ length
									+ '</span></div>'
									+ '<table class="table table-bordered table-primary"><thead><tr><th>Student Name</th><th>Father Name</th><th>Mother Name</th><th>Operations</th><th>Operations</th><th>Operations</th></tr></thead><tbody>';

							for (var i = 0; i < length; i++) {

								st = st
										+ '<tr><td style="width: 200px;"><a href="show-student-details?id='
										+ j[i].admissionNo
										+ '">'
										+ j[i].firstName
										+ '\t'
										+ j[i].middleName
										+ '\t'
										+ j[i].lastName
										+ '</td>'
										+ '<td>'
										+ j[i].fatherName
										+ '</td><td>'
										+ j[i].motherName
										+ '</td><td>'
										+ j[i].className
										+ '</td><td>'
										+ j[i].sectionName
										+ '</td><td><a href="edit-student-details?id='
										+ j[i].admissionNo
										+ '">Edit</a></td>'
										+ '<td><a href="javascript:removeStudent('
										+ j[i].admissionNo
										+ ')"><span class="label label-important">Cancel Admission</span></a></td>'
										+ '<td><a href="generate-tc.html?id='
										+ j[i].admissionNo
										+ '"target="_blank"><span '
										+'class="label label-primary"><font size="2"><b>Generate TC</b></font></span></a></td></tr>';

							}
							st = st + '</tbody></table></div></div></div>';
						}
						$("#students").append(st);
					},

					error : function(error, status) {

					}
				});

	}
	function removeStudentbyfather(id) {
		var sessionId = $("#sessionByFId").val();
		var fatherName = $("#fatherName").val();
		var url = 'removestudentbyfather/' + id + '/' + fatherName + '/'
				+ sessionId;
		$
				.ajax({
					url : url,

					type : 'POST',
					success : function(data, status) {
						$("#students").empty();

						var j = JSON.parse(data);
						var st = "";
						var length = j.length;
						if (length == 0) {
							st = '<div class="failedmsg">There Are No More Students For This Class</div>';
						} else {
							st = '<div class="successmsg"><b>Student Addmission Cancel Successfully</b></div><div class="widget-body" style="padding: 10px 0 0;"><div class="separator"></div><div class="btn-group" style="width: 1059px;">'

									+ '</div><div class="block"><div class="head blue" style="height:30px;padding:0.5px 0 0 20px;"><h4>Students List</h4><span style="color:white;float:right;margin-top: -35px;margin-right: 27px;">Total no. of Students: '
									+ length
									+ '</span></div>'
									+ '<table class="table table-bordered table-primary"><thead><tr><th>Student Name</th><th>Father Name</th><th>Mother Name</th><th>Operations</th><th>Operations</th><th>Operations</th></tr></thead><tbody>';

							for (var i = 0; i < length; i++) {

								st = st
										+ '<tr><td style="width: 200px;"><a href="show-student-details?id='
										+ j[i].admissionNo
										+ '">'
										+ j[i].firstName
										+ '\t'
										+ j[i].middleName
										+ '\t'
										+ j[i].lastName
										+ '</td>'
										+ '<td>'
										+ j[i].fatherName
										+ '</td><td>'
										+ j[i].motherName
										+ '</td><td>'
										+ j[i].className
										+ '</td><td>'
										+ j[i].sectionName
										+ '</td><td><a href="edit-student-details?id='
										+ j[i].admissionNo
										+ '">Edit</a></td>'
										+ '<td><a href="javascript:removeStudentbyfather('
										+ j[i].admissionNo
										+ ')"><span class="label label-important">Cancel Admission</span></a></td>'
										+ '<td><a href="generate-tc.html?id='
										+ j[i].admissionNo
										+ '"target="_blank"><span '
										+'class="label label-primary"><font size="2"><b>Generate TC</b></font></span></a></td></tr>';

							}
							st = st + '</tbody></table></div></div></div>';
						}
						$("#students").append(st);
					},

					error : function(error, status) {

					}
				});

	}
	function removeStudentbyclassonly(id) {

		var sessionId = $("#sessionId").val();
		var classId = $("#classId").val();
		var section = $("#sectionId").val();

		var url = 'removestudentsbyclasses/' + id + '/' + classId + '/'
				+ sessionId;
		$
				.ajax({
					url : url,

					type : 'POST',
					success : function(data, status) {
						$("#students").empty();

						var j = JSON.parse(data);
						var st = "";
						var length = j.length;
						if (length == 0) {
							st = '<div class="failedmsg">There Are No More Students For This Class</div>';
						} else {
							st = '<div><div class="widget-body" style="padding: 10px 0 0;"><div class="separator"></div><div class="btn-group" style="width: 1059px;">'
									+ '</div><div class="block"><div class="block"><a class=" button btn-primary" target="_blank" style="float: right; margin-top: -39px; width: 129px; height: 26px; padding-left: 10px; padding-top: 3px; margin-bottom: -12px; margin-right: 409px;"href="getClassPdf?classId='
									+ classId
									+ '&sessionId='
									+ sessionId
									+ '" target="_blank"><b>Classwise Pdf</b></a><a class=" button btn-primary" target="_blank" style="float: right; margin-top: -39px; margin-right: 564px; width: 137px; height: 26px; padding-left: 10px; padding-top: 3px; margin-bottom: -12px;"href="getClassExcel?classId='
									+ classId
									+ '&sessionId='
									+ sessionId
									+ '"><b>Classwise Excel</b></a>'
									+ '<div class="head blue" style="height:30px;padding:0.5px 0 0 20px;"><h4>Students List</h4><span style="color:white;float:right;margin-top: -35px;margin-right: 27px;">Total no. of Students: '
									+ length
									+ '</span></div>'
									+ '<table class="table table-bordered table-primary"><thead><tr><th>Student Name</th><th>Father Name</th><th>Mother Name</th><th>Class</th><th>Section</th><th>Operations</th><th>Operations</th><th>Operations</th></tr></thead><tbody>';

							for (var i = 0; i < length; i++) {

								st = st
										+ '<tr><td style="width: 200px;"><a href="show-student-details?id='
										+ j[i].admissionNo
										+ '">'
										+ j[i].firstName
										+ '\t'
										+ j[i].middleName
										+ '\t'
										+ j[i].lastName
										+ '</td>'
										+ '<td>'
										+ j[i].fatherName
										+ '</td><td>'
										+ j[i].motherName
										+ '</td><td>'
										+ j[i].className
										+ '</td><td>'
										+ j[i].sectionName
										+ '</td><td><a href="edit-student-details?id='
										+ j[i].admissionNo
										+ '">Edit</a></td>'
										+ '<td><a href="javascript:removeStudentbyclassonly('
										+ j[i].admissionNo
										+ ')"><span class="label label-important">Cancel Admission</span></a></td>'
										+ '<td><a href="generate-tc.html?id='
										+ j[i].admissionNo
										+ '"target="_blank"><span '
									+'class="label label-primary"><font size="2"><b>Generate TC</b></font></span></a></td></tr>';
							}
							st = st + '</tbody></table></div></div></div>';
						}
						$("#students").append(st);
					},
					error : function(e) {
						alert('Error: ' + e);
					}
				});
	}

	function removeStudentbyclass(id) {

		var sessionId = $("#sessionId").val();
		var className = $("#classId").val();
		var section = $("#sectionId").val();

		var url = 'removeStudentbyclass/' + id + '/' + className + '/'
				+ section + '/' + sessionId;
		$
				.ajax({
					url : url,

					type : 'POST',
					success : function(data, status) {
						$("#students").empty();

						var j = JSON.parse(data);
						var st = "";
						var length = j.length;
						if (length == 0) {
							st = '<div class="failedmsg">There Are No More Students For This Class</div>';
						} else {
							st = '<div class="successmsg" style="margin-bottom: 35px;"><b>Student Addmission Cancel Successfully</b></div><div><div class="widget-body" style="padding: 10px 0 0;"><div class="separator"></div><div class="btn-group" style="width: 1059px;">'
									+ '</div><div class="block"><div class="block"><a class=" button btn-primary" target="_blank" style="float: right; margin-top: -39px; width: 129px; height: 26px; padding-left: 10px; padding-top: 3px; margin-bottom: -12px; margin-right: 409px;"href="getClassPdf?classId='
									+ className
									+ '&sessionId='
									+ sessionId
									+ '" target="_blank"><b>Classwise Pdf</b></a><a class=" button btn-primary" target="_blank" style="float: right; margin-top: -39px; margin-right: 564px; width: 137px; height: 26px; padding-left: 10px; padding-top: 3px; margin-bottom: -12px;"href="getClassExcel?classId='
									+ className
									+ '&sessionId='
									+ sessionId
									+ '"><b>Classwise Excel</b></a>'
									+ '<a class=" button btn-primary" target="_blank" style="float: right; margin-top: -40px; margin-left: -34px; width: 145px; height: 29px; border-width: 1px; padding-left: 8px; padding-top: 2px; margin-right: 247px;" href="getSectionExcel?classId='
									+ className
									+ '&sectionId='
									+ section
									+ ' &sessionId='
									+ sessionId
									+ '" target="_blank"><b>Sectionwise Excel</b></a>'
									+ '<a class=" button btn-primary" style="float: right; margin-top: -40px; margin-left: -34px; margin-right: 98px; width: 136px; height: 29px; border-width: 1px; padding-left: 8px; padding-top: 2px;" href="getSectionPdf?classId='
									+ className
									+ '&sectionId='
									+ section
									+ ' &sessionId='
									+ sessionId
									+ '" target="_blank"><b>Sectionwise Pdf</b></a>'
									+ '<div class="head blue" style="height:30px;padding:0.5px 0 0 20px;"><h4>Students List</h4><span style="color:white;float:right;margin-top: -35px;margin-right: 27px;">Total no. of Students: '
									+ length
									+ '</span></div>'
									+ '<table class="table table-bordered table-primary"><thead><tr><th>Student Name</th><th>Father Name</th><th>Mother Name</th><th>Operations</th><th>Operations</th><th>Operations</th></tr></thead><tbody>';

							for (var i = 0; i < length; i++) {

								st = st
										+ '<tr><td style="width: 200px;"><a href="show-student-details?id='
										+ j[i].admissionNo
										+ '">'
										+ j[i].firstName
										+ '\t'
										+ j[i].middleName
										+ '\t'
										+ j[i].lastName
										+ '</td>'
										+ '<td>'
										+ j[i].fatherName
										+ '</td><td>'
										+ j[i].motherName
										+ '</td><td><a href="edit-student-details?id='
										+ j[i].admissionNo
										+ '">Edit</a></td>'
										+ '<td><a href="javascript:removeStudentbyclass('
										+ j[i].admissionNo
										+ ')"><span class="label label-important">Cancel Admission</span></a></td>'
										+ '<td><a href="generate-tc.html?id='
										+ j[i].admissionNo
										+ '"target="_blank"><span '
										+'class="label label-primary"><font size="2"><b>Generate TC</b></font></span></a></td></tr>';

							}
							st = st + '</tbody></table></div></div></div>';
						}
						$("#students").append(st);
					},

					error : function(error, status) {

					}
				});

	}
	function removeStudentbycategory(id) {
		var sessionId = $("#sessionByCId").val();
		var categoryId = $("#categoryId").val();
		var classId = $("#cclassId").val();
		var url = '';
		if (classId == '' || classId == null) {
			url = 'removestudentbycategory/' + id + '/' + sessionId + '/'
					+ categoryId;
		} else {
			url = 'removestudentbyclasscategory/' + id + '/' + sessionId + '/'
					+ categoryId + '/' + classId;
		}
		$.ajax({
			url : url,
			type : 'POST',
			success : fatherSearch,
			error : function(error, status) {
			}
		});

	}
	function databyclasscategory(classId) {
		$("#students").empty();
		var sessionId = $("#sessionByCId").val();
		var categoryId = $("#categoryId").val();
		var url = 'getStudentsbycategory/' + categoryId + '/' + sessionId + '/'
				+ classId;
		$.ajax({
			url : url,
			type : 'POST',
			success : fatherSearch,
			error : function(error, status) {
			}
		});
	}
	function getsection(value) {

		var sessionId = $("#sessionId").val();
		var classId = value;
		$
				.ajax({
					type : "post",
					url : '${base_url}get-student-section-by-class',
					data : {
						"sessionId" : $("#sessionId").val(),
						"classId" : +value
					},
					success : function(data) {
						$("#sectionId").empty();
						var obj = JSON.parse(data);
						var content = '<option value="">Select Section</option>';
						$.each(obj.SectionDTO, function(key, value) {
							content += '<option value="'+value.sectionId+'">'
									+ value.sectionName + '</option>';
						});
						$("#sectionId").append(content);
						$("#students").empty();
						var st = "";
						var j = obj.StudentDTO;
						var length = j.length;
						if (length == 0) {
							st = '<div class="failedmsg">There Are No More Students For This Class</div>';
						} else {
							st = '<div><div class="widget-body" style="padding: 10px 0 0;"><div class="separator"></div><div class="btn-group" style="width: 1059px;">'
									+ '</div><div class="block"><a class=" button btn-primary" target="_blank" style="float: right; margin-top: -39px; width: 129px; height: 26px; padding-left: 10px; padding-top: 3px; margin-bottom: -12px; margin-right: 409px;"href="getClassPdf?classId='
									+ classId
									+ '&sessionId='
									+ sessionId
									+ '" target="_blank"><b>Classwise Pdf</b></a><a class=" button btn-primary" target="_blank" style="float: right; margin-top: -39px; margin-right: 564px; width: 137px; height: 26px; padding-left: 10px; padding-top: 3px; margin-bottom: -12px;"href="getClassExcel?classId='
									+ classId
									+ '&sessionId='
									+ sessionId
									+ '"><b>Classwise Excel</b></a>'
									+ '<div class="head blue" style="height:30px;padding:0.5px 0 0 20px;"><h4>Students List</h4><span style="color:white;float:right;margin-top: -35px;margin-right: 27px;">Total no. of Students: '
									+ length
									+ '</span></div>'
									+ '<table class="table table-bordered table-primary"><thead><tr><th>Student Name</th><th>Father Name</th><th>Mother Name</th><th>Class</th><th>Section</th><th>Operations</th><th>Operations</th><th>Operations</th><th>Transfer</th><th>Operations</th></tr></thead><tbody>';

							for (var i = 0; i < length; i++) {

								st = st
										+ '<tr><td style="width: 200px;"><a href="show-student-details?id='
										+ j[i].admissionNo
										+ '">'
										+ j[i].firstName
										+ '\t'
										+ j[i].middleName
										+ '\t'
										+ j[i].lastName
										+ '</td>'
										+ '<td>'
										+ j[i].fatherName
										+ '</td><td>'
										+ j[i].motherName
										+ '</td><td>'
										+ j[i].className
										+ '</td><td>'
										+ j[i].sectionName
										+ '</td><td><a href="edit-student-details?id='
										+ j[i].admissionNo
										+ '">Edit</a></td>'
										+ '<td><a href="javascript:removeStudentbyclassonly('
										+ j[i].admissionNo
										+ ')"><span class="label label-important">Cancel Admission</span></a></td>'

								if (j[i].transfer.match('YES')) {
									st += '<td><a href="generate-tc.html?id='
									st += j[i].admissionNo
									st += '"target="_blank"> '
									st += '<span class="label label-important"><font size="2"><b>Generate TC</b></font></span></a></td>'
									st += '<td><a href="generate-tc.html?id='
									st += j[i].admissionNo
									st += '"target="_blank"> '
									st += '<span class="label label-important"><font size="2"><b>YES</b></font></span></a></td>'
									
									st += '<td><a href="student-overview.html?id='
									st += j[i].admissionNo
									st += '&sessionId='
									st += sessionId
									st += '"><span '
									st +='class="label label-success"><font size="2"><b>Overview</b></font></span></a></td></tr>';

								} else {
									st += '<td><a href="generate-tc.html?id='
									st += j[i].admissionNo
									st += '"target="_blank"><span '
											st+='class="label label-primary"><font size="2"><b>Generate TC</b></font></span></a></td>'
									st += '<td><a href="generate-tc.html?id='
									st += j[i].admissionNo
									st += '"target="_blank"><span '
									st+='class="label label-primary"><font size="2"><b>NO</b></font></span></a></td>'
									
									st+= '<td><a href="student-overview.html?id='
									st+= j[i].admissionNo
									st+= '&sessionId='
									st+= sessionId
									st+= '"><span '
									st+='class="label label-success"><font size="2"><b>Overview</b></font></span></a></td></tr>';


								}
							}
							st = st + '</tbody></table></div></div></div>';
						}
						$("#students").append(st);
					},
					error : function(e) {
						alert('Error: ' + e);
					}
				});
	}
</script>
<body onload="loads();">
	<div class="content">
		<div id="content-header" style="height: 150px;">
			<img alt="Show_settings" src="${img_url}/student_profile.jpg"
				style="width: 74px; margin-top: -15px;">
			<h1>Student Profile</h1>
			<h3>Search Students and Manage Profile</h3>
			<div id="app-back-button">
				<a href="home"><img alt="Back" border="0"
					src="${img_url}/home.png"
					style="margin-top: -6px; height: 40px; width: 40px;"></a> <a
					href="#" onclick="javascript:location.reload(true);"><img
					alt="Back" border="0" src="${img_url}/refresh.png"
					style="margin-top: -6px; height: 40px; width: 40px;"></a> <a
					href="#" onclick="history.back(); return false;"><img
					alt="Back" border="0" src="${img_url}/back.png"
					style="margin-top: -6px; height: 40px; width: 40px;"></a> <a
					id="namesc" class="btn btn-success" href="javascript:namesearch();"
					style="width: 101px; height: 25px; display: block; margin-top: 79px; padding-top: 5px; margin-right: -136px;"><b>Search
						By Name</b></a> <a id="fathersc" class="btn btn-success"
					href="javascript:fathersearch();"
					style="width: 151px; height: 26px; border-top-width: 1px; display: block; margin-top: 80px; padding-top: 3px; margin-right: -27px;"><b>Search
						By Father's Name</b></a><a id="classsc" class="btn btn-success"
					href="javascript:classsearch();"
					style="margin-right: 5px; display: block; width: 118px; height: 26px; margin-top: 80px; border-top-width: 1px; padding-top: 3px;"><b>Search
						By Class</b></a> <a id="categoryscc" class="btn btn-success"
					href="javascript:Categorysearch();"
					style="margin-right: 5px; display: block; width: 118px; height: 26px; margin-top: 80px; border-top-width: 1px; padding-top: 3px;"><b>Search
						By Category</b></a> <a id="addressSearch" class="btn btn-success"
					href="javascript:addressSearch();"
					style="margin-right: 5px; display: block; width: 118px; height: 26px; margin-top: 80px; border-top-width: 1px; padding-top: 3px;"><b>Search
						By Address</b></a>
			</div>
		</div>
	</div>
	<br>
	<br>
	<hr>

	<!-- **************************Search By Class & Section********************************** -->
	<div id="searches">
		<f:form action="student-details" method="post"
			commandName="studentDTO">
			<br>
			<table style="width: 1059px;">
				<tr>
					<td style="width: 200px;">Select Session :</td>
					<td><select name="sessionId" class="form-control input-sm"
						id="sessionId" style="width: 250px;" x-data-toggle-x="tooltip"
						title="Specify the session of the student" onchange="datas();"
						data-original-title="Specify session">
							<c:forEach var="list" items="${sessionList}">
								<c:choose>
									<c:when test="${current.sessionId==list.sessionId}">
										<option selected="selected" value="${list.sessionId}">${list.sessionDuration}</option>
									</c:when>
									<c:otherwise>
										<option value="${list.sessionId}">${list.sessionDuration}</option>
									</c:otherwise>
								</c:choose>
							</c:forEach>
					</select></td>
				</tr>
				<tr>
					<td style="width: 200px;">Select Class :</td>
					<td><select id="classId" class="validate[required]"
						onchange="getsection(this.value);" style="width: 250px;"
						name="classId" class="select">
							<option value="">Select Class</option>
							<c:forEach var="list" items="${classList}">
								<option value="${list.classId}">${list.className}</option>
							</c:forEach>
					</select></td>
				</tr>
				<tr>
					<td style="width: 200px;">Select Section :</td>
					<td><select id="sectionId" class="validate[required]"
						style="width: 250px;" onchange="getStudentsListsbyclass();"
						name="sectionId" class="select">
							<option value="">Select Section</option>
					</select></td>
				</tr>
			</table>
			<div class="separator"></div>
		</f:form>
	</div>

	<!-- **************************Search By StudentName********************************** -->
	<div id="namesearch">
		<f:form action="student-details" method="post"
			commandName="studentDTO">
			<br>
			<table style="width: 1059px;">
				<tr>
					<td style="width: 200px;">Select Session :</td>
					<td><select name="sessionId" class="validate[required]"
						style="width: 300px;" id="sessionById" x-data-toggle-x="tooltip"
						title="Specify the session of the student" onchange="datas()"
						data-original-title="Specify session">
							<c:forEach var="list" items="${sessionList}">
								<c:choose>
									<c:when test="${current.sessionId==list.sessionId}">
										<option selected="selected" value="${list.sessionId}">${list.sessionDuration}</option>
									</c:when>
									<c:otherwise>
										<option value="${list.sessionId}">${list.sessionDuration}</option>
									</c:otherwise>
								</c:choose>
							</c:forEach>
					</select></td>
				</tr>
				<tr>
					<td style="width: 200px;">Select Class :</td>
					<td><select id="classById" class="validate[required]"
						onchange="ndatas()" style="width: 300px;" name="classId"
						class="select">
							<option value="">Select Class</option>
							<c:forEach var="list" items="${classList}">
								<option value="${list.classId}">${list.className}</option>
							</c:forEach>
					</select></td>
				</tr>
				<tr>
					<td style="width: 200px;">Enter Student Name :</td>
					<td><f:input path="firstName" required="required"
							id="firstName" placeholder="Enter Student's Name"
							style="width: 300px;" oninput="getStudents(this.value)" />
						<div id="exist"></div></td>
				</tr>
			</table>
			<div class="separator"></div>
		</f:form>
	</div>

	<!-- **************************Search By FatherName********************************** -->
	<div id="fathersearch">
		<f:form action="student-details" method="post"
			commandName="studentDTO">
			<br>
			<table style="width: 1059px;">
				<tr>
					<td style="width: 200px;">Select Session :</td>
					<td><select name="sessionId" class="validate[required]"
						style="width: 300px;" id="sessionByFId" x-data-toggle-x="tooltip"
						title="Specify the session of the student" onchange="datas()"
						data-original-title="Specify session">
							<c:forEach var="list" items="${sessionList}">
								<c:choose>
									<c:when test="${current.sessionId==list.sessionId}">
										<option selected="selected" value="${list.sessionId}">${list.sessionDuration}</option>
									</c:when>
									<c:otherwise>
										<option value="${list.sessionId}">${list.sessionDuration}</option>
									</c:otherwise>
								</c:choose>
							</c:forEach>
					</select></td>
				</tr>
				<tr>
					<td style="width: 200px;">Enter Father Name :</td>
					<td><f:input path="fatherName" required="required"
							id="fatherName" placeholder="Enter Father's Name"
							style="width: 300px;"
							oninput="getStudentsbyfatherName(this.value)" />
						<div id="exist"></div></td>
				</tr>
			</table>
			<div class="separator"></div>
		</f:form>
	</div>
	<!-- ****************Category sEARCH*************************** -->
	<div id="categorysc">
		<f:form action="student-details" method="post"
			commandName="studentDTO">
			<br>
			<table style="width: 1059px;">
				<tr>
					<td style="width: 200px;">Select Session :</td>
					<td><select name="sessionId" class="validate[required]"
						style="width: 300px;" id="sessionByCId" x-data-toggle-x="tooltip"
						title="Specify the session of the student" onchange="datas()"
						data-original-title="Specify session">
							<c:forEach var="list" items="${sessionList}">
								<c:choose>
									<c:when test="${current.sessionId==list.sessionId}">
										<option selected="selected" value="${list.sessionId}">${list.sessionDuration}</option>
									</c:when>
									<c:otherwise>
										<option value="${list.sessionId}">${list.sessionDuration}</option>
									</c:otherwise>
								</c:choose>
							</c:forEach>
					</select></td>
				</tr>
				<tr>
					<td style="width: 200px;">Select Category :</td>
					<td><select name="categoryId" class="validate[required]"
						style="width: 300px;" id="categoryId" x-data-toggle-x="tooltip"
						title="Specify the category of the student"
						onchange="databycategory(this.value)"
						data-original-title="Specify session">
							<option value="">Select Category</option>
							<c:forEach var="list" items="${StudentCategorys}">
								<option value="${list.studentCategoriesId}">${list.studentCategoriesName}</option>
							</c:forEach>
					</select>
						<div id="exist"></div></td>
				</tr>
				<tr>
					<td style="width: 200px;">Select Class :</td>
					<td><select name="cclassId" class="validate[required]"
						style="width: 300px;" id="cclassId" x-data-toggle-x="tooltip"
						title="Select Class" onchange="databyclasscategory(this.value)"
						data-original-title="Specify session">
							<option value="">Select Class</option>
							<c:forEach var="list" items="${classList}">
								<option value="${list.classId}">${list.className}</option>
							</c:forEach>
					</select>
						<div id="exist"></div></td>
				</tr>
			</table>
			<div class="separator"></div>
		</f:form>
	</div>

	<!-- ****************Address sEARCH*************************** -->
	<div id="addresssc">
		<f:form action="student-details" method="post"
			commandName="studentDTO">
			<br>
			<table style="width: 1059px;">
				<tr>
					<td style="width: 200px;">Select Session :</td>
					<td><select name="sessionId" class="validate[required]"
						style="width: 300px;" id="sessionByAId" x-data-toggle-x="tooltip"
						title="Specify the session of the student" onchange="datas()"
						data-original-title="Specify session">
							<c:forEach var="list" items="${sessionList}">
								<c:choose>
									<c:when test="${current.sessionId==list.sessionId}">
										<option selected="selected" value="${list.sessionId}">${list.sessionDuration}</option>
									</c:when>
									<c:otherwise>
										<option value="${list.sessionId}">${list.sessionDuration}</option>
									</c:otherwise>
								</c:choose>
							</c:forEach>
					</select></td>
				</tr>

				<tr>
					<td style="width: 200px;">Select Class :</td>
					<td><select name="classId" class="validate[required]"
						style="width: 300px;" id="cclassAId" x-data-toggle-x="tooltip"
						title="Select Class" onchange="databyclasscategory(this.value)"
						data-original-title="Specify session">
							<option value="">Select Class</option>
							<c:forEach var="list" items="${classList}">
								<option value="${list.classId}">${list.className}</option>
							</c:forEach>
					</select>
						<div id="exist"></div></td>
				</tr>
				<tr>
					<td style="width: 200px;">Address :</td>
					<td><f:input path="addressLine1" required="required"
							id="addressLine1" placeholder="Enter Some Part Of Address"
							style="width: 300px;" oninput="getStudentsByAddress(this.value)" />
						<div id="exist"></div></td>
				</tr>
			</table>
			<div class="separator"></div>
		</f:form>
	</div>
	<hr>
	<div id="students"></div>
</body>














<%-- <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url value="/style/theme/images" var="imageurl" />
<spring:url value="/img" var="img_url" />
<spring:url value="/" var="base_url" />
<spring:url value="/css" var="css_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/admission.css">

<script type="text/javascript">
	function namesearch() {
		$("#namesc").css({
			"background-color" : "#b00"
		});
		$("#classsc").css({
			"background-color" : ""
		});
		$("#fathersc").css({
			"background-color" : ""
		});
		$("#categoryscc").css({
			"background-color" : ""
		});
		$("#categorysc").hide();
		$("#searches").hide();
		$("#classsc").show();
		$("#namesearch").show();
		$("#students").empty();
		$("#fathersearch").hide();
		datas();
	}
	function loads() {
		$("#classsc").css({
			"background-color" : "#b00"
		});
		$("#fathersc").css({
			"background-color" : ""
		});
		$("#namesc").css({
			"background-color" : ""
		});
		$("#namesearch").hide();
		$("#fathersearch").hide();
		$("#categorysc").hide();
		datas();
	}
	function classsearch() {
		$("#classsc").css({
			"background-color" : "#b00"
		});
		$("#fathersc").css({
			"background-color" : ""
		});
		$("#namesc").css({
			"background-color" : ""
		});
		$("#categorysc").css({
			"background-color" : ""
		});
		$("#categorysc").hide();
		$("#namesearch").hide();
		$("#students").empty();
		$("#searches").show();
		$("#fathersearch").hide();
		datas();
	}
	function fathersearch() {
		$("#fathersc").css({
			"background-color" : "#b00"
		});
		$("#classsc").css({
			"background-color" : ""
		});
		$("#namesc").css({
			"background-color" : ""
		});
		$("#categoryscc").css({
			"background-color" : ""
		});
		$("#categorysc").hide();
		$("#namesearch").hide();
		$("#students").empty();
		$("#fathersearch").show();
		$("#searches").hide();
		datas();
	}
	function Categorysearch() {
		$("#categoryscc").css({
			"background-color" : "#b00"
		});
		$("#classsc").css({
			"background-color" : ""
		});
		$("#namesc").css({
			"background-color" : ""
		});
		$("#fathersc").css({
			"background-color" : ""
		});
		$("#fathersearch").hide();
		$("#namesearch").hide();
		$("#searches").hide();
		$("#students").empty();
		$("#categorysc").show();

		datas();
	}
	function datas() {
		$("#students").empty();
		$("#classId").val('');
		$("#sectionId").val('');
		$("#classById").val('');
		$("#fatherName").val('');
		$("#firstName").val('');
	}
	function ndatas() {
		$("#firstName").val('');
	}

	function getStudentsListsbyclass() {
		var sessionId = $("#sessionId").val();
		var classId = $("#classId").val();
		var sectionId = $("#sectionId").val();
		$
				.ajax({
					type : 'POST',
					url : '${base_url}get-student-list',
					data : {
						'classId' : classId,
						'sectionId' : sectionId,
						'sessionId' : sessionId
					},
					success : function(data, status) {
						$("#students").empty();
						var j = JSON.parse(data);
						var length = j.length;
						var st = "";
						if (length == 0) {
							st = '<div class="failedmsg"><b>There Are No More Students For This Class</b></div>';
						} else {
							st = '<div class="widget-body" style="padding: 10px;"><div class="separator"></div><div class="btn-group" style="width: 1059px;"></div>'
									+ '<div class="block"><div class="block"><a class=" button btn-primary" target="_blank" style="float: right; margin-top: -39px; width: 129px; height: 26px; padding-left: 10px; padding-top: 3px; margin-bottom: -12px; margin-right: 409px;"href="getClassPdf?classId='
									+ classId
									+ '&sessionId='
									+ sessionId
									+ '" target="_blank"><b>Classwise Pdf</b></a><a class=" button btn-primary" target="_blank" style="float: right; margin-top: -39px; margin-right: 564px; width: 137px; height: 26px; padding-left: 10px; padding-top: 3px; margin-bottom: -12px;"href="getClassExcel?classId='
									+ classId
									+ '&sessionId='
									+ sessionId
									+ '"><b>Classwise Excel</b></a>'
									+ '<a class=" button btn-primary" target="_blank" style="float: right; margin-top: -40px; margin-left: -34px; width: 145px; height: 29px; border-width: 1px; padding-left: 8px; padding-top: 2px; margin-right: 247px;" href="getSectionExcel?classId='
									+ classId
									+ '&sectionId='
									+ sectionId
									+ ' &sessionId='
									+ sessionId
									+ '" target="_blank"><b>Sectionwise Excel</b></a>'
									+ '<a class=" button btn-primary" style="float: right; margin-top: -40px; margin-left: -34px; margin-right: 98px; width: 136px; height: 29px; border-width: 1px; padding-left: 8px; padding-top: 2px;" href="getSectionPdf?classId='
									+ classId
									+ '&sectionId='
									+ sectionId
									+ ' &sessionId='
									+ sessionId
									+ '" target="_blank"><b>Sectionwise Pdf</b></a>'
									+ '<div class="head blue" style="height:30px;padding:0.5px 0 0 20px;"><h4>Student Details</h4><span style="color:white;float:right;margin-top: -35px;margin-right: 27px;">Total no. of Students: '
									+ length
									+ '</span></div>'
									+ '<table class="table table-bordered table-primary"><th>Name</th><th>Father Name</th><th>Mother Name</th><th>Operations</th><th>Operations</th><th>Operations</th>';
							for (var i = 0; i < length; i++) {
								st = st
										+ '<tr><td style="width: 200px;"><a href="show-student-details?id='
										+ j[i].admissionNo
										+ '">'
										+ j[i].firstName
										+ '\t'
										+ j[i].middleName
										+ '\t'
										+ j[i].lastName
										+ '</td><td>'
										+ j[i].fatherName
										+ '</td><td>'
										+ j[i].motherName
										+ '</td>'
										+ '<td><a href="edit-student-details?id='
										+ j[i].admissionNo
										+ '">Edit</a></td>'
										+ '<td><a href="javascript:removeStudentbyclass('
										+ j[i].admissionNo
										+ ')"><span class="label label-important">Cancel Admission</span></a></td>'
										+ '<td><a href="generate-tc.html?id='
										+ j[i].admissionNo
										+ '"target="_blank"><span '
										+'class="label label-primary"><font size="2"><b>Generate TC</b></font></span></a></td></tr>';
							}
							st = st + '</table></div>';
						}
						$("#students").append(st);

					},
					error : function(error, status) {

					}
				});

	}

	function getStudents(firstName) {
		$("#students").empty();
		var classId = $("#classById").val();
		var sessionId = $("#sessionById").val();
		if (classId == '' || classId == null) {
			$("#students")
					.append('<div class="failedmsg">Select a Class</div>');
		} else {
			var url = 'getStudents/' + classId + '/' + firstName + '/'
					+ sessionId;
			$
					.ajax({
						url : url,
						type : 'POST',
						success : function(data, status) {
							$("#students").empty();

							var j = JSON.parse(data);

							var length = j.length;
							var st = "";
							if (length == 0) {
								st = '<div class="failedmsg"><b>There Are No Students of this Name</b></div>';
							} else {
								st = '<div><div class="widget-body" style="padding: 10px 0 0;"><div class="separator"></div><div class="btn-group" style="width: 1059px;">'
										+ '</div><div class="block"><div class="head blue" style="height:30px;padding:0.5px 0 0 20px;"><h4>Students List</h4><span style="color:white;float:right;margin-top: -35px;margin-right: 27px;">Total no. of Students: '
										+ length
										+ '</span></div>'
										+ '<table class="table table-bordered table-primary"><thead><tr><th>Student Name</th><th>Father Name</th><th>Class</th><th>Section</th><th>Operations</th><th>Operations</th><th>Operations</th><th>Operations</th></tr></thead><tbody>';

								for (var i = 0; i < length; i++) {

									st = st
											+ '<tr><td style="width: 200px;"><a href="show-student-details?id='
											+ j[i].admissionNo
											+ '">'
											+ j[i].firstName
											+ '\t'
											+ j[i].middleName
											+ '\t'
											+ j[i].lastName
											+ '</td>'
											+ '<td>'
											+ j[i].fatherName
											+ '</td><td>'
											+ j[i].className
											+ '</td><td>'
											+ j[i].sectionName
											+ '</td><td><a href="edit-student-details?id='
											+ j[i].admissionNo
											+ '">Edit</a></td>'
											+ '<td><a href="javascript:removeStudent('
											+ j[i].admissionNo
											+ ')"><span class="label label-important">Cancel Admission</span></a></td>'
											+ '<td><a href="generate-tc.html?id='
											+ j[i].admissionNo
											+ '"target="_blank"><span '
											+'class="label label-primary"><font size="2"><b>Generate TC</b></font></span></a></td>'
											+ '<td><a href="student-overview.html?id='
											+ j[i].admissionNo
											+ '&sessionId='
											+ sessionId
											+ '"><span '
											+'class="label label-success"><font size="2"><b>Overview</b></font></span></a></td></tr>';

								}

								st = st + '</tbody></table></div></div></div>';
							}
							$("#students").append(st);

						},
						error : function(error, status) {

						}
					});
		}
	}
	function databycategory(categoryId) {
		$("#students").empty();
		var sessionId = $("#sessionByCId").val();
		$("#cclassId").val('');
		var url = 'getStudentsbyfatherNames/' + categoryId + '/' + sessionId;
		$.ajax({
			url : url,
			type : 'POST',
			success : fatherSearch,
			error : function(error, status) {
			}
		});

	}

	function getStudentsbyfatherName(fatherName) {
		$("#students").empty();
		var sessionId = $("#sessionByFId").val();
		var url = 'getStudentsbyfatherName/' + fatherName + '/' + sessionId;
		$.ajax({
			url : url,
			type : 'POST',
			success : fatherSearch,
			error : function(error, status) {
			}
		});

	}
	function fatherSearch(data, status) {
		$("#students").empty();

		var j = JSON.parse(data);

		var length = j.length;
		var st = "";
		if (length == 0) {
			st = '<div class="failedmsg"><b>There are no  Students of this category</b></div>';
		} else {
			st = '<div><div class="widget-body" style="padding: 10px 0 0;"><div class="separator"></div><div class="btn-group" style="width: 1059px;">'
					+ '</div><div class="block"><div class="head blue" style="height:30px;padding:0.5px 0 0 20px;"><h4>Students List</h4><span style="color:white;float:right;margin-top: -35px;margin-right: 27px;">Total no. of Students: '
					+ length
					+ '</span></div>'
					+ '<table class="table table-bordered table-primary"><thead><tr><th>Student Name</th><th>Father Name</th><th>Mother Name</th><th>Class</th><th>Section</th><th>Operations</th><th>Operations</th><th>Operations</th></tr></thead><tbody>';

			for (var i = 0; i < length; i++) {

				st = st
						+ '<tr><td style="width: 200px;"><a href="show-student-details?id='
						+ j[i].admissionNo
						+ '">'
						+ j[i].firstName
						+ '\t'
						+ j[i].middleName
						+ '\t'
						+ j[i].lastName
						+ '</td>'
						+ '<td>'
						+ j[i].fatherName
						+ '</td><td>'
						+ j[i].motherName
						+ '</td><td>'
						+ j[i].className
						+ '</td><td>'
						+ j[i].sectionName
						+ '</td><td><a href="edit-student-details?id='
						+ j[i].admissionNo
						+ '">Edit</a></td>'
						+ '<td><a href="javascript:removeStudentbycategory('
						+ j[i].admissionNo
						+ ')"><span class="label label-important">Cancel Admission</span></a></td>'
						+ '<td><a href="generate-tc.html?id='
						+ j[i].admissionNo
						+ '"target="_blank"><span '
						+'class="label label-primary"><font size="2"><b>Generate TC</b></font></span></a></td></tr>';
			}
			st = st + '</tbody></table></div></div></div>';
		}
		$("#students").append(st);
	}

	function removeStudent(id) {
		var classId = $("#classById").val();
		var sessionId = $("#sessionById").val();
		var firstName = $("#firstName").val();
		var url = 'removestudent/' + id + '/' + firstName + '/' + sessionId
				+ '/' + classId;
		$
				.ajax({
					url : url,
					type : 'POST',
					success : function(data, status) {
						$("#students").empty();
						var j = JSON.parse(data);
						var st = "";
						var length = j.length;
						if (length == 0) {
							st = '<div class="failedmsg">There Are No More Students For This Class</div>';
						} else {
							st = '<div class="successmsg"><b>Student Addmission Cancel Successfully</b></div><div class="widget-body" style="padding: 10px 0 0;"><div class="separator"></div><div class="btn-group" style="width: 1059px;">'
									+ '</div><div class="block"><div class="head blue" style="height:30px;padding:0.5px 0 0 20px;"><h4>Students List</h4><span style="color:white;float:right;margin-top: -35px;margin-right: 27px;">Total no. of Students: '
									+ length
									+ '</span></div>'
									+ '<table class="table table-bordered table-primary"><thead><tr><th>Student Name</th><th>Father Name</th><th>Mother Name</th><th>Operations</th><th>Operations</th><th>Operations</th></tr></thead><tbody>';

							for (var i = 0; i < length; i++) {

								st = st
										+ '<tr><td style="width: 200px;"><a href="show-student-details?id='
										+ j[i].admissionNo
										+ '">'
										+ j[i].firstName
										+ '\t'
										+ j[i].middleName
										+ '\t'
										+ j[i].lastName
										+ '</td>'
										+ '<td>'
										+ j[i].fatherName
										+ '</td><td>'
										+ j[i].motherName
										+ '</td><td>'
										+ j[i].className
										+ '</td><td>'
										+ j[i].sectionName
										+ '</td><td><a href="edit-student-details?id='
										+ j[i].admissionNo
										+ '">Edit</a></td>'
										+ '<td><a href="javascript:removeStudent('
										+ j[i].admissionNo
										+ ')"><span class="label label-important">Cancel Admission</span></a></td>'
										+ '<td><a href="generate-tc.html?id='
										+ j[i].admissionNo
										+ '"target="_blank"><span '
										+'class="label label-primary"><font size="2"><b>Generate TC</b></font></span></a></td></tr>';

							}
							st = st + '</tbody></table></div></div></div>';
						}
						$("#students").append(st);
					},

					error : function(error, status) {

					}
				});

	}
	function removeStudentbyfather(id) {
		var sessionId = $("#sessionByFId").val();
		var fatherName = $("#fatherName").val();
		var url = 'removestudentbyfather/' + id + '/' + fatherName + '/'
				+ sessionId;
		$
				.ajax({
					url : url,

					type : 'POST',
					success : function(data, status) {
						$("#students").empty();

						var j = JSON.parse(data);
						var st = "";
						var length = j.length;
						if (length == 0) {
							st = '<div class="failedmsg">There Are No More Students For This Class</div>';
						} else {
							st = '<div class="successmsg"><b>Student Addmission Cancel Successfully</b></div><div class="widget-body" style="padding: 10px 0 0;"><div class="separator"></div><div class="btn-group" style="width: 1059px;">'

									+ '</div><div class="block"><div class="head blue" style="height:30px;padding:0.5px 0 0 20px;"><h4>Students List</h4><span style="color:white;float:right;margin-top: -35px;margin-right: 27px;">Total no. of Students: '
									+ length
									+ '</span></div>'
									+ '<table class="table table-bordered table-primary"><thead><tr><th>Student Name</th><th>Father Name</th><th>Mother Name</th><th>Operations</th><th>Operations</th><th>Operations</th></tr></thead><tbody>';

							for (var i = 0; i < length; i++) {

								st = st
										+ '<tr><td style="width: 200px;"><a href="show-student-details?id='
										+ j[i].admissionNo
										+ '">'
										+ j[i].firstName
										+ '\t'
										+ j[i].middleName
										+ '\t'
										+ j[i].lastName
										+ '</td>'
										+ '<td>'
										+ j[i].fatherName
										+ '</td><td>'
										+ j[i].motherName
										+ '</td><td>'
										+ j[i].className
										+ '</td><td>'
										+ j[i].sectionName
										+ '</td><td><a href="edit-student-details?id='
										+ j[i].admissionNo
										+ '">Edit</a></td>'
										+ '<td><a href="javascript:removeStudentbyfather('
										+ j[i].admissionNo
										+ ')"><span class="label label-important">Cancel Admission</span></a></td>'
										+ '<td><a href="generate-tc.html?id='
										+ j[i].admissionNo
										+ '"target="_blank"><span '
										+'class="label label-primary"><font size="2"><b>Generate TC</b></font></span></a></td></tr>';

							}
							st = st + '</tbody></table></div></div></div>';
						}
						$("#students").append(st);
					},

					error : function(error, status) {

					}
				});

	}
	function removeStudentbyclassonly(id) {

		var sessionId = $("#sessionId").val();
		var classId = $("#classId").val();
		var section = $("#sectionId").val();

		var url = 'removestudentsbyclasses/' + id + '/' + classId + '/'
				+ sessionId;
		$
				.ajax({
					url : url,

					type : 'POST',
					success : function(data, status) {
						$("#students").empty();

						var j = JSON.parse(data);
						var st = "";
						var length = j.length;
						if (length == 0) {
							st = '<div class="failedmsg">There Are No More Students For This Class</div>';
						} else {
							st = '<div><div class="widget-body" style="padding: 10px 0 0;"><div class="separator"></div><div class="btn-group" style="width: 1059px;">'
									+ '</div><div class="block"><div class="block"><a class=" button btn-primary" target="_blank" style="float: right; margin-top: -39px; width: 129px; height: 26px; padding-left: 10px; padding-top: 3px; margin-bottom: -12px; margin-right: 409px;"href="getClassPdf?classId='
									+ classId
									+ '&sessionId='
									+ sessionId
									+ '" target="_blank"><b>Classwise Pdf</b></a><a class=" button btn-primary" target="_blank" style="float: right; margin-top: -39px; margin-right: 564px; width: 137px; height: 26px; padding-left: 10px; padding-top: 3px; margin-bottom: -12px;"href="getClassExcel?classId='
									+ classId
									+ '&sessionId='
									+ sessionId
									+ '"><b>Classwise Excel</b></a>'
									+ '<div class="head blue" style="height:30px;padding:0.5px 0 0 20px;"><h4>Students List</h4><span style="color:white;float:right;margin-top: -35px;margin-right: 27px;">Total no. of Students: '
									+ length
									+ '</span></div>'
									+ '<table class="table table-bordered table-primary"><thead><tr><th>Student Name</th><th>Father Name</th><th>Mother Name</th><th>Class</th><th>Section</th><th>Operations</th><th>Operations</th><th>Operations</th></tr></thead><tbody>';

							for (var i = 0; i < length; i++) {

								st = st
										+ '<tr><td style="width: 200px;"><a href="show-student-details?id='
										+ j[i].admissionNo
										+ '">'
										+ j[i].firstName
										+ '\t'
										+ j[i].middleName
										+ '\t'
										+ j[i].lastName
										+ '</td>'
										+ '<td>'
										+ j[i].fatherName
										+ '</td><td>'
										+ j[i].motherName
										+ '</td><td>'
										+ j[i].className
										+ '</td><td>'
										+ j[i].sectionName
										+ '</td><td><a href="edit-student-details?id='
										+ j[i].admissionNo
										+ '">Edit</a></td>'
										+ '<td><a href="javascript:removeStudentbyclassonly('
										+ j[i].admissionNo
										+ ')"><span class="label label-important">Cancel Admission</span></a></td>'
										+ '<td><a href="generate-tc.html?id='
										+ j[i].admissionNo
										+ '"target="_blank"><span '
									+'class="label label-primary"><font size="2"><b>Generate TC</b></font></span></a></td></tr>';
							}
							st = st + '</tbody></table></div></div></div>';
						}
						$("#students").append(st);
					},
					error : function(e) {
						alert('Error: ' + e);
					}
				});
	}

	function removeStudentbyclass(id) {

		var sessionId = $("#sessionId").val();
		var className = $("#classId").val();
		var section = $("#sectionId").val();

		var url = 'removeStudentbyclass/' + id + '/' + className + '/'
				+ section + '/' + sessionId;
		$
				.ajax({
					url : url,

					type : 'POST',
					success : function(data, status) {
						$("#students").empty();

						var j = JSON.parse(data);
						var st = "";
						var length = j.length;
						if (length == 0) {
							st = '<div class="failedmsg">There Are No More Students For This Class</div>';
						} else {
							st = '<div class="successmsg" style="margin-bottom: 35px;"><b>Student Addmission Cancel Successfully</b></div><div><div class="widget-body" style="padding: 10px 0 0;"><div class="separator"></div><div class="btn-group" style="width: 1059px;">'
									+ '</div><div class="block"><div class="block"><a class=" button btn-primary" target="_blank" style="float: right; margin-top: -39px; width: 129px; height: 26px; padding-left: 10px; padding-top: 3px; margin-bottom: -12px; margin-right: 409px;"href="getClassPdf?classId='
									+ className
									+ '&sessionId='
									+ sessionId
									+ '" target="_blank"><b>Classwise Pdf</b></a><a class=" button btn-primary" target="_blank" style="float: right; margin-top: -39px; margin-right: 564px; width: 137px; height: 26px; padding-left: 10px; padding-top: 3px; margin-bottom: -12px;"href="getClassExcel?classId='
									+ className
									+ '&sessionId='
									+ sessionId
									+ '"><b>Classwise Excel</b></a>'
									+ '<a class=" button btn-primary" target="_blank" style="float: right; margin-top: -40px; margin-left: -34px; width: 145px; height: 29px; border-width: 1px; padding-left: 8px; padding-top: 2px; margin-right: 247px;" href="getSectionExcel?classId='
									+ className
									+ '&sectionId='
									+ section
									+ ' &sessionId='
									+ sessionId
									+ '" target="_blank"><b>Sectionwise Excel</b></a>'
									+ '<a class=" button btn-primary" style="float: right; margin-top: -40px; margin-left: -34px; margin-right: 98px; width: 136px; height: 29px; border-width: 1px; padding-left: 8px; padding-top: 2px;" href="getSectionPdf?classId='
									+ className
									+ '&sectionId='
									+ section
									+ ' &sessionId='
									+ sessionId
									+ '" target="_blank"><b>Sectionwise Pdf</b></a>'
									+ '<div class="head blue" style="height:30px;padding:0.5px 0 0 20px;"><h4>Students List</h4><span style="color:white;float:right;margin-top: -35px;margin-right: 27px;">Total no. of Students: '
									+ length
									+ '</span></div>'
									+ '<table class="table table-bordered table-primary"><thead><tr><th>Student Name</th><th>Father Name</th><th>Mother Name</th><th>Operations</th><th>Operations</th><th>Operations</th></tr></thead><tbody>';

							for (var i = 0; i < length; i++) {

								st = st
										+ '<tr><td style="width: 200px;"><a href="show-student-details?id='
										+ j[i].admissionNo
										+ '">'
										+ j[i].firstName
										+ '\t'
										+ j[i].middleName
										+ '\t'
										+ j[i].lastName
										+ '</td>'
										+ '<td>'
										+ j[i].fatherName
										+ '</td><td>'
										+ j[i].motherName
										+ '</td><td><a href="edit-student-details?id='
										+ j[i].admissionNo
										+ '">Edit</a></td>'
										+ '<td><a href="javascript:removeStudentbyclass('
										+ j[i].admissionNo
										+ ')"><span class="label label-important">Cancel Admission</span></a></td>'
										+ '<td><a href="generate-tc.html?id='
										+ j[i].admissionNo
										+ '"target="_blank"><span '
										+'class="label label-primary"><font size="2"><b>Generate TC</b></font></span></a></td></tr>';

							}
							st = st + '</tbody></table></div></div></div>';
						}
						$("#students").append(st);
					},

					error : function(error, status) {

					}
				});

	}
	function removeStudentbycategory(id) {
		var sessionId = $("#sessionByCId").val();
		var categoryId = $("#categoryId").val();
		var classId = $("#cclassId").val();
		var url = '';
		if (classId == '' || classId == null) {
			url = 'removestudentbycategory/' + id + '/' + sessionId + '/'
					+ categoryId;
		} else {
			url = 'removestudentbyclasscategory/' + id + '/' + sessionId + '/'
					+ categoryId + '/' + classId;
		}
		$.ajax({
			url : url,
			type : 'POST',
			success : fatherSearch,
			error : function(error, status) {
			}
		});

	}
	function databyclasscategory(classId) {
		$("#students").empty();
		var sessionId = $("#sessionByCId").val();
		var categoryId = $("#categoryId").val();
		var url = 'getStudentsbycategory/' + categoryId + '/' + sessionId + '/'
				+ classId;
		$.ajax({
			url : url,
			type : 'POST',
			success : fatherSearch,
			error : function(error, status) {
			}
		});
	}
	function getsection(value) {

		var sessionId = $("#sessionId").val();
		var classId = value;
		$
				.ajax({
					type : "post",
					url : '${base_url}get-student-section-by-class',
					data : {
						"sessionId" : $("#sessionId").val(),
						"classId" : +value
					},
					success : function(data) {
						$("#sectionId").empty();
						var obj = JSON.parse(data);
						var content = '<option value="">Select Section</option>';
						$.each(obj.SectionDTO, function(key, value) {
							content += '<option value="'+value.sectionId+'">'
									+ value.sectionName + '</option>';
						});
						$("#sectionId").append(content);
						$("#students").empty();
						var st = "";
						var j = obj.StudentDTO;
						var length = j.length;
						if (length == 0) {
							st = '<div class="failedmsg">There Are No More Students For This Class</div>';
						} else {
							st = '<div><div class="widget-body" style="padding: 10px 0 0;"><div class="separator"></div><div class="btn-group" style="width: 1059px;">'
									+ '</div><div class="block"><a class=" button btn-primary" target="_blank" style="float: right; margin-top: -39px; width: 129px; height: 26px; padding-left: 10px; padding-top: 3px; margin-bottom: -12px; margin-right: 409px;"href="getClassPdf?classId='
									+ classId
									+ '&sessionId='
									+ sessionId
									+ '" target="_blank"><b>Classwise Pdf</b></a><a class=" button btn-primary" target="_blank" style="float: right; margin-top: -39px; margin-right: 564px; width: 137px; height: 26px; padding-left: 10px; padding-top: 3px; margin-bottom: -12px;"href="getClassExcel?classId='
									+ classId
									+ '&sessionId='
									+ sessionId
									+ '"><b>Classwise Excel</b></a>'
									+ '<div class="head blue" style="height:30px;padding:0.5px 0 0 20px;"><h4>Students List</h4><span style="color:white;float:right;margin-top: -35px;margin-right: 27px;">Total no. of Students: '
									+ length
									+ '</span></div>'
									+ '<table class="table table-bordered table-primary"><thead><tr><th>Student Name</th><th>Father Name</th><th>Mother Name</th><th>Class</th><th>Section</th><th>Operations</th><th>Operations</th><th>Operations</th></tr></thead><tbody>';

							for (var i = 0; i < length; i++) {

								st = st
										+ '<tr><td style="width: 200px;"><a href="show-student-details?id='
										+ j[i].admissionNo
										+ '">'
										+ j[i].firstName
										+ '\t'
										+ j[i].middleName
										+ '\t'
										+ j[i].lastName
										+ '</td>'
										+ '<td>'
										+ j[i].fatherName
										+ '</td><td>'
										+ j[i].motherName
										+ '</td><td>'
										+ j[i].className
										+ '</td><td>'
										+ j[i].sectionName
										+ '</td><td><a href="edit-student-details?id='
										+ j[i].admissionNo
										+ '">Edit</a></td>'
										+ '<td><a href="javascript:removeStudentbyclassonly('
										+ j[i].admissionNo
										+ ')"><span class="label label-important">Cancel Admission</span></a></td>'
										+ '<td><a href="generate-tc.html?id='
										+ j[i].admissionNo
										+ '"target="_blank"><span '
										+'class="label label-primary"><font size="2"><b>Generate TC</b></font></span></a></td></tr>';
							}
							st = st + '</tbody></table></div></div></div>';
						}
						$("#students").append(st);
					},
					error : function(e) {
						alert('Error: ' + e);
					}
				});
	}
</script>
<body onload="loads();">
	<div class="content">
		<div id="content-header" style="height: 150px;">
			<img alt="Show_settings" src="${img_url}/student_profile.jpg"
				style="width: 74px; margin-top: -15px;">
			<h1>Student Profile</h1>
			<h3>Search Students and Manage Profile</h3>
			<div id="app-back-button">
				<a href="home"><img alt="Back" border="0"
					src="${img_url}/home.png"
					style="margin-top: -6px; height: 40px; width: 40px;"></a> <a
					href="#" onclick="javascript:location.reload(true);"><img
					alt="Back" border="0" src="${img_url}/refresh.png"
					style="margin-top: -6px; height: 40px; width: 40px;"></a> <a
					href="#" onclick="history.back(); return false;"><img
					alt="Back" border="0" src="${img_url}/back.png"
					style="margin-top: -6px; height: 40px; width: 40px;"></a> <a
					id="namesc" class="btn btn-success" href="javascript:namesearch();"
					style="width: 101px; height: 25px; display: block; margin-top: 79px; padding-top: 5px; margin-right: -136px;"><b>Search
						By Name</b></a> <a id="fathersc" class="btn btn-success"
					href="javascript:fathersearch();"
					style="width: 151px; height: 26px; border-top-width: 1px; display: block; margin-top: 80px; padding-top: 3px; margin-right: -27px;"><b>Search
						By Father's Name</b></a><a id="classsc" class="btn btn-success"
					href="javascript:classsearch();"
					style="margin-right: 5px; display: block; width: 118px; height: 26px; margin-top: 80px; border-top-width: 1px; padding-top: 3px;"><b>Search
						By Class</b></a> <a id="categoryscc" class="btn btn-success"
					href="javascript:Categorysearch();"
					style="margin-right: 5px; display: block; width: 118px; height: 26px; margin-top: 80px; border-top-width: 1px; padding-top: 3px;"><b>Search
						By Category</b></a>
			</div>
		</div>
	</div>
	<br>
	<br>
	<hr>

	<!-- **************************Search By Class & Section********************************** -->
	<div id="searches">
		<f:form action="student-details" method="post"
			commandName="studentDTO">
			<br>
			<table style="width: 1059px;">
				<tr>
					<td style="width: 200px;">Select Session :</td>
					<td><select name="sessionId" class="form-control input-sm"
						id="sessionId" style="width: 250px;" x-data-toggle-x="tooltip"
						title="Specify the session of the student" onchange="datas();"
						data-original-title="Specify session">
							<c:forEach var="list" items="${sessionList}">
								<c:choose>
									<c:when test="${current.sessionId==list.sessionId}">
										<option selected="selected" value="${list.sessionId}">${list.sessionDuration}</option>
									</c:when>
									<c:otherwise>
										<option value="${list.sessionId}">${list.sessionDuration}</option>
									</c:otherwise>
								</c:choose>
							</c:forEach>
					</select></td>
				</tr>
				<tr>
					<td style="width: 200px;">Select Class :</td>
					<td><select id="classId" class="validate[required]"
						onchange="getsection(this.value);" style="width: 250px;"
						name="classId" class="select">
							<option value="">Select Class</option>
							<c:forEach var="list" items="${classList}">
								<option value="${list.classId}">${list.className}</option>
							</c:forEach>
					</select></td>
				</tr>
				<tr>
					<td style="width: 200px;">Select Section :</td>
					<td><select id="sectionId" class="validate[required]"
						style="width: 250px;" onchange="getStudentsListsbyclass();"
						name="sectionId" class="select">
							<option value="">Select Section</option>
					</select></td>
				</tr>
			</table>
			<div class="separator"></div>
		</f:form>
	</div>

	<!-- **************************Search By StudentName********************************** -->
	<div id="namesearch">
		<f:form action="student-details" method="post"
			commandName="studentDTO">
			<br>
			<table style="width: 1059px;">
				<tr>
					<td style="width: 200px;">Select Session :</td>
					<td><select name="sessionId" class="validate[required]"
						style="width: 300px;" id="sessionById" x-data-toggle-x="tooltip"
						title="Specify the session of the student" onchange="datas()"
						data-original-title="Specify session">
							<c:forEach var="list" items="${sessionList}">
								<c:choose>
									<c:when test="${current.sessionId==list.sessionId}">
										<option selected="selected" value="${list.sessionId}">${list.sessionDuration}</option>
									</c:when>
									<c:otherwise>
										<option value="${list.sessionId}">${list.sessionDuration}</option>
									</c:otherwise>
								</c:choose>
							</c:forEach>
					</select></td>
				</tr>
				<tr>
					<td style="width: 200px;">Select Class :</td>
					<td><select id="classById" class="validate[required]"
						onchange="ndatas()" style="width: 300px;" name="classId"
						class="select">
							<option value="">Select Class</option>
							<c:forEach var="list" items="${classList}">
								<option value="${list.classId}">${list.className}</option>
							</c:forEach>
					</select></td>
				</tr>
				<tr>
					<td style="width: 200px;">Enter Student Name :</td>
					<td><f:input path="firstName" required="required"
							id="firstName" placeholder="Enter Student's Name"
							style="width: 300px;" oninput="getStudents(this.value)" />
						<div id="exist"></div></td>
				</tr>
			</table>
			<div class="separator"></div>
		</f:form>
	</div>

	<!-- **************************Search By FatherName********************************** -->
	<div id="fathersearch">
		<f:form action="student-details" method="post"
			commandName="studentDTO">
			<br>
			<table style="width: 1059px;">
				<tr>
					<td style="width: 200px;">Select Session :</td>
					<td><select name="sessionId" class="validate[required]"
						style="width: 300px;" id="sessionByFId" x-data-toggle-x="tooltip"
						title="Specify the session of the student" onchange="datas()"
						data-original-title="Specify session">
							<c:forEach var="list" items="${sessionList}">
								<c:choose>
									<c:when test="${current.sessionId==list.sessionId}">
										<option selected="selected" value="${list.sessionId}">${list.sessionDuration}</option>
									</c:when>
									<c:otherwise>
										<option value="${list.sessionId}">${list.sessionDuration}</option>
									</c:otherwise>
								</c:choose>
							</c:forEach>
					</select></td>
				</tr>
				<tr>
					<td style="width: 200px;">Enter Father Name :</td>
					<td><f:input path="fatherName" required="required"
							id="fatherName" placeholder="Enter Father's Name"
							style="width: 300px;"
							oninput="getStudentsbyfatherName(this.value)" />
						<div id="exist"></div></td>
				</tr>
			</table>
			<div class="separator"></div>
		</f:form>
	</div>
	<!-- ****************Category sEARCH*************************** -->
	<div id="categorysc">
		<f:form action="student-details" method="post"
			commandName="studentDTO">
			<br>
			<table style="width: 1059px;">
				<tr>
					<td style="width: 200px;">Select Session :</td>
					<td><select name="sessionId" class="validate[required]"
						style="width: 300px;" id="sessionByCId" x-data-toggle-x="tooltip"
						title="Specify the session of the student" onchange="datas()"
						data-original-title="Specify session">
							<c:forEach var="list" items="${sessionList}">
								<c:choose>
									<c:when test="${current.sessionId==list.sessionId}">
										<option selected="selected" value="${list.sessionId}">${list.sessionDuration}</option>
									</c:when>
									<c:otherwise>
										<option value="${list.sessionId}">${list.sessionDuration}</option>
									</c:otherwise>
								</c:choose>
							</c:forEach>
					</select></td>
				</tr>
				<tr>
					<td style="width: 200px;">Select Category :</td>
					<td><select name="categoryId" class="validate[required]"
						style="width: 300px;" id="categoryId" x-data-toggle-x="tooltip"
						title="Specify the category of the student"
						onchange="databycategory(this.value)"
						data-original-title="Specify session">
							<option value="">Select Category</option>
							<c:forEach var="list" items="${StudentCategorys}">
								<option value="${list.studentCategoriesId}">${list.studentCategoriesName}</option>
							</c:forEach>
					</select>
						<div id="exist"></div></td>
				</tr>
				<tr>
					<td style="width: 200px;">Select Class :</td>
					<td><select name="cclassId" class="validate[required]"
						style="width: 300px;" id="cclassId" x-data-toggle-x="tooltip"
						title="Select Class" onchange="databyclasscategory(this.value)"
						data-original-title="Specify session">
							<option value="">Select Class</option>
							<c:forEach var="list" items="${classList}">
								<option value="${list.classId}">${list.className}</option>
							</c:forEach>
					</select>
						<div id="exist"></div></td>
				</tr>
			</table>
			<div class="separator"></div>
		</f:form>
	</div>
	<hr>
	<div id="students"></div>
</body> --%>