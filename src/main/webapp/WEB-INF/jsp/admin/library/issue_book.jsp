<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:url value="/style/theme/images/back.png" var="backurl" />
<c:url value="/style/theme/images/admission_page_logo.jpg"
	var="StudentAddLogo" />
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/style/datepicks" var="datepicks" />
<spring:url value="/img" var="img_url" />
<spring:url value="/css" var="css_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/admission.css">
<link href="${datepicks}/jquery.datepick.css" rel="stylesheet">
<script src="${datepicks}/jquery.plugin.js"></script>
<script src="${datepicks}/jquery.datepick.js"></script>
<link rel="stylesheet" type="text/css" href="${css_url}/setting.css">
<script type="text/javascript">
	$(document).ready(function() {
		$('#issue_book').hide();
	})
	function getSectionList(id) {

		$.ajax({
			type : "post",
			url : 'getsectionlist/' + id,
			success : function(data, status) {
				$("#sectionId").empty();
				var j = JSON.parse(data);
				var content = '<option value="">Select Section</option>';
				for (var i = 0; i < j.length; i++) {
					content += '<option value='+j[i].sectionId+'>'
							+ j[i].sectionName + '</option>';
				}
				$("#sectionId").append(content);
				getsubjectList(id);
			},
			error : function(e) {

			}
		});
	}
	function getStudentList() {

		var sessionId = $('#sessionId').val();
		var classId = $('#classId').val();
		var sectionId = $('#sectionId').val();
		if (sessionId == '' || classId == '' || sectionId == '') {
			alert("Fill Above Data First. Please!!");
		} else {
			$.ajax({
				type : "post",
				url : 'get-student-list',
				data : {
					'classId' : classId,
					'sectionId' : sectionId,
					'sessionId' : sessionId,
				},
				success : function(data, status) {

					var j = JSON.parse(data);
					var content = '<option value="">Select Student</option>';
					for (var i = 0; i < j.length; i++) {
						content += '<option value='+j[i].admissionNo+'>'
								+ j[i].firstName + '</option>';
					}
					$("#studentId").append(content);

				},
				error : function(e) {

				}
			});
		}
	}

	function getStudentDatabyId(studentId) {

		$.ajax({
			type : 'post',
			url : 'get-studentdatabyId',
			data : {

				'studentId' : studentId,
			},
			success : function(data, status) {
				var j = JSON.parse(data);
				if (j.length == 0) {

				} else {
					$("#classId").val(j.classId);
					$("#sectionId").val(j.sectionId);
					getStudentFeeDetails(j.admissionNo);
					getIssuedBookToStudent(studentId);
				}

			},

			error : function(data, status) {

			}
		});

	}

	function getStudentdetails(id) {
		$("#issueBook").empty();
		$
				.ajax({
					type : "post",
					url : 'getstudentsdata/' + id,
					success : function(data, status) {
						$("#Student").empty();
						var j = JSON.parse(data);
						var st = '';
						st = '<div  id="box" style="border: 1px solid; border-radius: 10px; height: 110px; width: 541px; margin-left: 0px; margin-top: 4px;">';
						st += '<table style="width: 530px; margin-left: 10px; margin-top: 7px;"><tr><td><span><font size="2"><b>Name :</b></td><td colspan="3" ><span><font size="2">'
								+ j.firstName
								+ '\t'
								+ j.middleName
								+ '\t'
								+ j.lastName
								+ '</font></span></td></tr><tr><td><span><font size="2"><b>Father Name:</font></span></b></td><td style="width: 369px;"colspan="3"><span><font size="2">'
								+ j.fatherName
								+ '</font></span></td><tr><tr><td><span><font size="2"><b>Class:</font></span></b></td><td ><span><font size="2">'
								+ j.className
								+ '</font></span></td><td style="width: 79px;"><span><font size="2"><b>Section:</font></span></b></td><td style="width: 140px;"><span><font size="2">'
								+ j.sectionName
								+ '</font></span></td></tr><tr><td><span><font size="2"><b>Mobile No:</font></span></b></td><td colspan="3"><span><font size="2">'
								+ j.mobile
								+ '</font></span></td></tr></table></div>';
						$("#studentDetails").append(st);
						getIssuedBookToStudent(id);

					},
					error : function(e) {

					}
				});
	}

	function getIssuedBookToStudent(studentId) {
		$("#issueBook").empty();
		$
				.ajax({
					type : "post",
					url : 'getIssuedBookByStudentId.html',
					data : {

						'studentId' : studentId

					},
					success : function(data, status) {

						var j = JSON.parse(data);

						if (j == 0) {
							var st = '<div class="failedmsg">No Previous Details found</div>';
						} else {

							var st = st
									+ '<div><div class="widget-body"  style="padding: 10px 0px 0px; margin-top: -50px;"><div class="separator"></div><div class="btn-group" style="width: 400px;">'
									+ '</div><div class="block" style="width: 334px;"><div class="head blue" style="width: 500px; margin-top: 66px;"><h4 style="text-align:center">Previous Issued Books</h4></div>'
									+ '<table class="table table-bordered table-primary"><thead><tr><th>Book</th><th>Issue Date</th><th>Subject</th><th>ISBN</th><th>Return</th></tr></thead><tbody>';
							for (var i = 0; i < j.length; i++) {
								st += '<tr><td>' + j[i].bookName + '</td>'
										+ '<td>' + j[i].issueDate + '</td>'
										+ '<td>' + j[i].subjectName + '</td>'
										+ '<td>' + j[i].isbn + '</td>'
										+ '<td><a href="javascript:returnBook()">Return</td></tr>';
							}
							st += '</tbody></table></div></div>';
						}

						$("#issueBook").append(st);

					},
					error : function(e) {
						alert('Error: ' + e);
					}

				});

	}

	function getStudentFeeDetails(id) {

		var sessionId = $('#sessionId').val();
		var classId = $('#classId').val();
		var sectionId = $('#sectionId').val();
		$("#studentAdmissionNo").val(id);

		if (classId == '' || sectionId == '') {
			alert("Fill Above Data First. Please!!");
		} else {
			$
					.ajax({
						type : "get",
						url : 'get-student-fee-payment-details',
						data : {
							'studentAdmissionNo' : id,
							'sessionId' : sessionId,
						},
						success : function(data, status) {
							var obj = JSON.parse(data);

							var studentDetails = '<div style="text-align: center; height: 33px; background-color: rgb(238, 238, 238); color: rgb(0, 136, 204); border: 1px solid lightgray; border-top-left-radius: 10px; border-top-right-radius: 10px; margin-top: 3px; width: 710px;">'
									+ obj.StudentDTO.fullName
									+ '<input type="hidden" id="fullName" value="'+obj.StudentDTO.fullName+'"></div><div class="row-fluid"  style="border: 1px solid lightgray; height: 113px; border-bottom-left-radius: 10px; border-bottom-right-radius: 10px;"><div class="span6">';
							studentDetails += '<div class="block"><div class="data-fluid"><div class="row-form"><div class="span5">Mobile No :</div>';
							studentDetails += '<div class="span7">'
									+ obj.StudentDTO.mobile
									+ '</div></div></div><div class="data-fluid"><div class="row-form">';
							studentDetails += '<div class="span5">Roll No :</div><div class="span7">'
									+ obj.StudentDTO.rollno
									+ '</div></div></div></div></div>';
							studentDetails += '<div class="span6"><div class="block"><div class="data-fluid"><div class="row-form" style="padding-top: 0px;">';
							studentDetails += '<div class="span3" style="width: 138px; height: 113px;float:right">'
									+ '<img src="${img}/studentImages/'+obj.StudentDTO.imageName+'"'
									+'style="width: 127px; height: 113px;">'
									+ '</div></div></div></div>';
							$("#studentDetails").append(studentDetails);

						},
						error : function(e) {

						}
					});
		}
	}

	function getsubjectList() {

		var classId = $('#classId').val();
		classId1 = classId;
		$.ajax({
			type : "post",
			url : 'getSubjectList.html',
			data : {
				'classId' : classId,

			},
			success : function(data, status) {

				var j = JSON.parse(data);
				var content = '<option value="">Select Subject</option>';
				for (var i = 0; i < j.length; i++) {
					content += '<option value='+j[i].subjectName+'>'
							+ j[i].subjectName + '</option>';
				}
				$("#subjectId").append(content);

			},
			error : function(e) {
				alert('Error: ' + e);
			}

		});
	}
	function issueBookToStudent(BookName, SubjectName, admissionNo, bookId) {
	
		
		var classId = $('#classId').val();

		$.ajax({
			type : "post",
			url : 'issueBookToStudent.html',
			data : {
				'BookName' : BookName,
				'SubjectName' : SubjectName,
				'admissionNo' : admissionNo,
				'classId' : classId,
				'bookId' : bookId,

			},
			success : function(data, status) {

				var j = JSON.parse(data);
				
				

			},
			error : function(e) {
				alert('Error: ' + e);
			}

		});

	}
	function newIssueBook(bookName, bookId, admissionNo, isbnNo,subjectName) {
		
		$('#issue_book').hide();
		var classId = $('#classId').val();

		$.ajax({
			type : "post",
			url : 'newIssueBook.html',
			data : {
				'bookName' : bookName,
				'bookId' : bookId,
				'admissionNo' : admissionNo,
				'classId' : classId,
				'isbnNo' : isbnNo,
				'classId':classId,
				'subjectName':subjectName,

			},
			success : function(data, status) {
				alert("a");
				$('#issue_book').dialog('destroy');
				getIssuedBookToStudent(admissionNo);
				getBookBySubjectIdAndClassId(subjectName);

			},
			error : function(e) {
				alert('Error: ' + e);
			}

		});

	}
	
	

	function viewBooksDetails(bookName, bookId, admissioNo) {
		
		$('#issue_book_table tbody').empty();
		$('#issue_book').dialog({
			autoOpen : false,
			resizeable : false,
			title : 'Issue Book',
			modal : true,
			
			width : 700,
			positon : 'centre'
		});
		$
				.ajax({
					type : "post",
					url : 'viewSameBooks',
					data : {
						'bookName' : bookName,
						'bookId' : bookId,
						'admissioNo' : admissioNo,

					},
					success : function(data, status) {

						var j = JSON.parse(data);

						for (var i = 0; i < j.length; i++) {
							var st = '';
							st += '<tr><td>'
									+ j[i].bookName
									+ '</td>'
									+ '<td>'
									+ j[i].subjectName
									+ '</td>'
									+ '<td>'
									+ j[i].isbn
									+ '</td>'
									+ '<td><a class="btn" type="submit" style="float: right; margin-right:0px;" href=javascript:newIssueBook("'
									+ j[i].bookName + '",' +bookId
									+ ',' + admissioNo+','
									+'"'
									+ j[i].isbn
									+'","'+j[i].subjectName+'")>Issue</a></td>'
									+ '</tr>';
							$('#issue_book_table tbody').append(st);

						}
						st += '</tbody></table></div></div>';
						
						$('#viewDetailsForIssue').empty();
						$('#viewDetailsForIssue').append(st);
						$('#viewDetailsForIssue').show();
						

					},
					error : function(e) {
						alert('Error: ' + e);
					}

				});

		$('#issue_book').dialog('open');
	}

	function getBookBySubjectIdAndClassId(subjectId) {
		$('#subjectDetailsDiv').empty();
		var admissionNo = $("#studentId").val();
		var subjectName = $("#subjectId").val();
		var classId = $('#classId').val();
		$
				.ajax({
					type : "post",
					url : 'getSubjectDetails.html',
					data : {
						'subjectName' : subjectName,
						'classId1' : classId

					},
					success : function(data, status) {

						var j = JSON.parse(data);

						var st = st
								+ '<div><div class="widget-body"  style="padding: 10px 0px 0px; margin-top: -335px; margin-left: 442px;"><div class="separator"></div><div class="btn-group" style="width: 400px;">'
								+ '</div><div class="block"  style="width: 462px;"><div class="head blue" style="width: 462px; margin-top: 66px;"><h4 style="text-align:center">Previous Issued Books</h4></div>'
								+ '<table class="table table-bordered table-primary"><thead><tr><th>Book</th><th>Quantity</th><th>Remanning Qty</th><th>Action</th></tr></thead><tbody>';
						for (var i = 0; i < j.length; i++) {
							if (j[i].remainingQuantity > 0) {
								st += '<tr><td>'
										+ j[i].bookName
										+ '</td>'
										+ '<td>'
										+ j[i].quantity
										+ '</td>'
										+ '<td>'
										+ j[i].remainingQuantity
										+ '</td>'
										+ '<td><a class="btn" type="submit" style="float: right; margin-right:0px;" href=javascript:viewBooksDetails("'
										+ j[i].bookName + '",'
										+ j[i].libraryBookId + ','
										+ admissionNo + ')>view</a></td>'
										+ '</tr>';
							}
						}
						st += '</tbody></table></div></div>';

						$('#subjectDetailsDiv').empty();
						$('#subjectDetailsDiv').append(st);
						$('#subjectDetailsDiv').show();

					},
					error : function(e) {
						alert('Error: ' + e);
					}

				});
	}
</script>
<div class="span4">
	<div style="width: 299px;" class="block">
		<div
			style="height: auto; width: 340px; border: 1px solid lightgray; background-color: rgb(238, 238, 238); border-radius: 5px; margin-left: 0px; margin-top: 50px;"
			" id="searches1">
			<div class="data-fluid" style="height: 319px;">

				<div class="row-form">
					<div class="span4" style="margin-left: 0px; width: 75px;">Session
						:</div>
					<div class="span8">
						<select name="sessionId" onchange="getClear();"
							class="validate[required]" id="sessionId"
							style="width: 190px; margin-left: 44px; margin-top: -27px;">
							<option value="${current.sessionId}">${current.sessionDuration}</option>
							<c:forEach var="list" items="${sessionList}">
								<option value="${list.sessionId}">${list.sessionDuration}</option>
							</c:forEach>
						</select>
					</div>
				</div>
				<div class="row-form">
					<div class="span4" style="width: 75px; margin-left: 0px;">Class
						:</div>
					<div class="span8">
						<select name="classId" onchange="getSectionList(this.value);"
							class="validate[required]" id="classId"
							style="width: 190px; margin-left: 44px; margin-top: -27px;">
							<option value="">Select a Class</option>
							<c:forEach var="list" items="${classList}">
								<option value="${list.classId}">${list.className}</option>
							</c:forEach>

						</select>
					</div>
				</div>
				<div class="row-form">
					<div class="span4" style="width: 75px; margin-left: 0px;">Section
						:</div>
					<div class="span8">
						<select name="sectionId" onchange="getStudentList();"
							class="validate[required]" id="sectionId"
							style="width: 190px; margin-left: 44px; margin-top: -27px;">
							<option value="">Select a Section</option>
						</select>
					</div>
				</div>
				<div class="row-form">
					<div class="span4" style="width: 75px; margin-left: 0px;">Student
						:</div>
					<div class="span8">
						<select name="studentId" onchange="getStudentdetails(this.value)"
							class="validate[required]" id="studentId"
							style="width: 190px; margin-left: 44px; margin-top: -27px;">
						</select>
					</div>
				</div>
				<div class="row-form">
					<div class="span4" style="width: 75px; margin-left: 0px;">Subject
						:</div>
					<div class="span8">
						<select name="subjectId"
							onchange="getBookBySubjectIdAndClassId(this.value);"
							class="validate[required]" id="subjectId"
							style="width: 190px; margin-left: 44px; margin-top: -27px;">

						</select>
					</div>
				</div>
				<div class="row-form">
					<div class="span4" style="width: 80px; margin-left: -10px;">Student
						Id:</div>
					<div class="span8">
						<input type="text" oninput="" name="studentId" id="studentId"
							style="width: 190px; margin-left: 44px; margin-top: -27px;">
					</div>
				</div>

				<div class="span8" id="studentDetails"
					style="width: 710px; height: auto; margin-bottom: 0px; margin-left: 440px; margin-top: -323px;"></div>
				<div id="subjectDetailsDiv" class="block"
					style="margin-top: 47px; display: none;"></div>
				<div id="issueBook" style="height: auto; width: 400"></div>
				<div id="subDetails"></div>
			</div>
			<!-- <div class="span8" id="viewDetailsForIssue"
				style="width: 710px; height: auto; margin-bottom: 0px; margin-left: 440px; margin-top: -323px;"></div> -->
			<input type="hidden" id="studentAdmissionNo"
				name="studentAdmissionNo"> <input type="hidden"
				id="neededMonthId"> <input type="hidden"
				id="paidAmountInWords" name="paidAmountInWord">
			<div class="separator"></div>
		</div>
	</div>
</div>
<div id="issue_book">
	<table class="table table-bordered table-primary" id="issue_book_table">
		<thead>
			<tr>
				<th>Book</th>
				<th>Subject</th>
				<th>ISBN No.</th>
				<th>Action</th>
			</tr>
		</thead>
		<tbody>
		</tbody>
	</table>

</div>