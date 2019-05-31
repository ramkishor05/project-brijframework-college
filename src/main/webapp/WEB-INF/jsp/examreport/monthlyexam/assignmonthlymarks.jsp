<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/style/datepicks" var="datepicks" />
<spring:url value="/img" var="img_url" />
<spring:url value="/css" var="css_url" />
<spring:url value="/js" var="js_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/admission.css">
<link href="${datepicks}/jquery.datepick.css" rel="stylesheet">
<script src="${datepicks}/jquery.plugin.js"></script>
<script src="${datepicks}/jquery.datepick.js"></script>
<spring:url value="/" var="base_url" />
<link rel="stylesheet" type="text/css" href="${css_url}/setting.css">

<script>
	function getSectionList(id) {
		hideshow();
		$("#sectionId").empty();
		$("#subjectId").empty();
		$("#studentId").empty();
		$("#markstable").empty();
		$("#maxMarks0").val('');
		$("#marks0").val('');
		$("#sub3").hide();
		if ($("#monthId").val() != '') {
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
				},
				error : function(e) {
					alert('Error: ' + e);
				}
			});
		} else {
			alert("please select month first");
		}

	}

	if ('${ROLE}' == 'ROLE_EMPLOYEE') {
		getStudentDataList('${CURRENTSESSIONID}', '${CLASSID}', '${SECTIONID}');
	}
	function getSubjectList() {
		$("#examReport").empty();
		var classId = $('#classId').val();
		var sectionId = $('#sectionId').val();
		var sessionId = $('#sessionId').val();
		var monthId = $("#monthId").val();
		$
				.ajax({
					type : "post",
					url : '${base_url}get-student-subject-list-marks',
					data : {
						'classId' : classId,
						'sectionId' : sectionId,
						'sessionId' : sessionId,
						'monthId' : monthId,
					},
					success : function(data, status) {
						$("#subjectsId").empty();
						var j = JSON.parse(data);
						if (j.SubjectList != '') {
							var subjects = '<br><hr><table class="table table-bordered table-primary"><tr><th>Subjects</th><th>Full Marks</th></tr>';
							$
									.each(
											j.SubjectList,
											function(key, value) {
												subjects += '<tr><td style="width: 200px;"><label>'
														+ value.subjectName
														+ '<label>'
														+ '</td><td style="width: 200px;"><input id="subject'+key+'" class="maxMarks" required="required"'
														+ 'name="subjectMarksDTOs['+key+'].maxMarks" style="width: 150px;" value="'+value.maxMarks+'" />'
														+ '</td><td style="background-color: white"><input type="hidden" value="'+ value.id+'" id="subjects'+key+'" name="subjectMarksDTOs['+key+'].subjectId"/></td></tr>';

											});
							subjects += '<tr><td></td><td><div style="width: 100px; text-align: center; background-color: rgb(238, 238, 238); border: 1px solid lightblue; box-shadow: 1px 1px 1px lightgray; font: 143%/1.2 Lucida console;"><a href=javascript:getStudentDataList('
									+ sessionId
									+ ','
									+ classId
									+ ','
									+ sectionId
									+ ','
									+ j.SubjectList.length
									+ ');>Submit</a></div></td></tr></table>';
							$("#subjectsId").append(subjects);
						} else {
							$("#subjectsId")
									.append(
											'<div class="failedmsg">No Subject Found For This Section</div>');
						}
					},
					error : function(e) {
						alert('Error: ' + e);
					}
				});
	}

	function getStudentDataList(sessionId, classId, sectionId,
			subjectlistlength) {
		var flag = false;
		var maxMarks = document.getElementsByClassName("maxMarks");
		$.each(maxMarks, function(key, value) {
			if ($("#subject" + key + "").val() == ''
					|| !$.isNumeric($("#subject" + key + "").val())) {
				flag = true;
			}
		});
		var monthId = $("#monthId").val();
		$("#subjectId").empty();
		$("#studentId").empty();
		$("#markstable").empty();
		$("#maxMarks0").val('');
		$("#marks0").val('');
		$("#sub3").hide();
		hideshow();
		if (flag) {
			alert("All Subjects Marks must be needed and In Numeric Form");
		} else {
			$
					.ajax({
						type : "post",
						url : '${base_url}get-student-list-marks',
						data : {
							'classId' : classId,
							'sectionId' : sectionId,
							'sessionId' : sessionId,
							'monthId' : monthId,
						},
						success : function(data, status) {
							$("#examReport").empty();
							var j = JSON.parse(data);
							var report = '<br><hr><table class="table table-bordered table-primary" style="width: 1059px;"><tr><th>Student Name</th>';
							var noOfSubjects = 0;
							var s = j[0].subjectDTO;

							for (var i = 0; i < s.length; i++) {
								report += '<th>' + s[i].subjectName + '('
										+ ($('#subject' + i).val()) + ')</th>';

							}
							report += '</tr>';
							$
									.each(
											j,
											function(key, value) {
												report += '<tr><td>'
														+ value.fullName
														+ '<input type="hidden" value="'+value.admissionNo+'" name="subjectMarksDTOs['+key+'].studentId"></td>';
												$
														.each(
																value.subjectDTO,
																function(i, sub) {

																	var maxMarks = $(
																			'#subject'
																					+ i)
																			.val();
																	var subjectId = $(
																			"#subjects"
																					+ i)
																			.val();

																	report += '<td><input type="text" id="'
																			+ key
																			+ 'gain'
																			+ i
																			+ '" name="subjectMarksDTOs['
																			+ key
																			+ '].subjectMarksDTOs['
																			+ i
																			+ '].gainMarks" value="'
																			+ sub.gainMarks
																			+ '" onblur="getMaxCheck(this.value,'
																			+ maxMarks
																			+ ','
																			+ key
																			+ ','
																			+ i
																			+ ')"/>'
																			+ '<input type="hidden" value="'+maxMarks+'" name="subjectMarksDTOs['+key+'].subjectMarksDTOs['+i+'].maxMarks">'
																			+ '<input type="hidden" value="'+subjectId+'" name="subjectMarksDTOs['+key+'].subjectMarksDTOs['+i+'].subjectId"/></td>';
																});
												report += '</tr>';
											});
							report += '</table><div align="center"><input type="submit" value="submit"></div>';

							$("#examReport").append(report);
						},
						error : function(data, status) {

						}
					});
		}
	}
	function getMaxCheck(gain, max, key, i) {
		if (gain > max) {
			alert("Gained marks must be less than max marks");
			$("#" + key + "gain" + i).val(0);
		}
	}

	function checkformarksassign(id) {
		var sessionId = $('#sessionId').val();
		var classId = $('#classId').val();
		var sectionId = $('#sectionId').val();
		var studentId = $('#studentId').val();
		var monthId = $('#monthId').val();
		if (classId == '' || sectionId == '') {
			alert("Fill Above Data First. Please!!");
		} else {
			$
					.ajax({
						type : "POST",
						url : '${base_url}checkformarksassign',
						data : {
							'studentId' : studentId,
							'classId' : classId,
							'sessionId' : sessionId,
							'sectionId' : sectionId,
							'subjectId' : id,
							'monthId' : monthId
						},
						success : function(data, status) {

							$("#appendmsg").empty();
							var obj = JSON.parse(data);
							if (obj == "OCCURE") {
								$("#appendmsg")
										.append(
												'<font color="red">This Subject Marks Assign Previouly. </font>');
								$("#assignbutton").hide();
							} else {
								$("#appendmsg").empty();
								$("#assignbutton").show();
							}
						},
						error : function(e) {
							alert('Error: ' + e);
						}
					});
		}
	}
	function getStudentdetails(id) {
		$
				.ajax({
					type : "post",
					url : 'getstudentsdata/' + id,
					success : function(data, status) {
						$("#Student").empty();
						var j = JSON.parse(data);
						var st = '';
						st = '<div   id="box" style="border: 1px solid; border-radius: 10px; height: 81px; width: 267px; margin-left: 93px; margin-top: -265px;">';
						st += '<table style="width: 530px; margin-left: 10px; margin-top: 7px;"><tr><td><span><font size="2"><b>Name :</b></td><td colspan="3" ><span><font size="2">'
								+ j.firstName
								+ '\t'
								+ j.middleName
								+ '\t'
								+ j.lastName
								+ '</font></span></td></tr><tr><td style="width: 99px;"><span><font size="2"><b>Father Name:</font></span></b></td><td style="width: 369px;"colspan="3"><span><font size="2">'
								+ j.fatherName
								+ '</font></span></td></tr><tr><td><span><font size="2"><b>Roll No:</font></span></b></td><td colspan="3"><span><font size="2">'
								+ j.rollno
								+ '</font></span></td></tr></table></div>';
						$("#Student").append(st);
					},
					error : function(e) {

					}
				});
	}
	function getStudentAssignSubject(studentId) {
		getStudentdetails(studentId);
		$("#maxMarks0").val('');
		$("#marks0").val('');
		$("#markstable").empty();
		$("#sub3").hide();
		$
				.ajax({
					type : "POST",
					url : '${base_url}getsubjectmarks',
					data : {
						'studentId' : $("#studentId").val(),
						'classId' : $("#classId").val(),
						'sessionId' : $("#sessionId").val(),
						'sectionId' : $("#sectionId").val(),
					},
					success : function(data, status) {
						//<ul class="buttons"><li><a class="btn btn-primary" href="javascript:generatePDF();">Generate PDF</a></li></ul>
						var obj = JSON.parse(data);
						var markstable = '<div class="head blue"><div class="icon"><span class="ico-pen-2"></span></div><h2>View Monthly Report</h2><ul class="buttons"><li><a class="btn btn-primary" href="viewmonthlysubjectmarks.html">Edit Data</a></li></ul></div>';
						markstable += '<div class="data-fluid"><table width="100%" cellspacing="0" cellpadding="0" class="table"><thead>';
						markstable += '<tr><th>Subject Name</th>';
						if (obj.MonthDTO.length > 0) {
							$
									.each(
											obj.MonthDTO,
											function(key, value) {
												markstable += '<th style="padding-left: 0px; padding-right: 0px;"><center>'
														+ value.monthName
														+ '</center><div style="width:100%;float:left;"><div style="width:50%;float:left;"><center>Max </center></div> <div style="width:49%;float:left;"><center>Gain </center></div></div></th>';
											});
						}
						markstable += '</tr></thead><tbody>';
						if (obj.SubjectDTO.length > 0) {
							$
									.each(
											obj.SubjectDTO,
											function(key, value) {
												markstable += '<tr><td>'
														+ value.subjectName
														+ '</td>';
												$
														.each(
																value.commonDTOs,
																function(key,
																		value1) {
																	markstable += '<td><div style="width:100%;float:left;"><div style="width:50%;float:left;"><center>'
																			+ value1.maxMarks
																			+ '</center></div> <div style="width:49%;float:left;"><center>'
																			+ value1.gainMarks
																			+ '</center></div></div></td>';
																});
												markstable += '</tr>';
											});
						}
						markstable += '</tbody></table></div>';
						$("#markstable").append(markstable);
					},
					error : function(e) {

					}
				});
		$("#sub3").show();
	}

	function hideshow() {
		$("#appendmsg").empty();
		$("#assignbutton").show();
	}
	function generatePDF() {
		document.location.href = "generatemonthlyexamreprot?sessionId="
				+ $("#sessionId").val() + "&classId=" + $("#classId").val()
				+ "&sectionId=" + $("#sectionId").val() + "&studentId="
				+ $("#studentId");
	}
	function validate() {
		var flage = true;
		var marks = $(".marks");
		var maxMarks = $(".maxMarks");

		var numaricFlag = true;
		var maxminFlag = true;
		for (i = 0; i < maxMarks.length; i++) {
			if (!$.isNumeric($("#marks" + i + "").val())
					|| !$.isNumeric($("#maxMarks" + i + "").val())) {
				numaricFlag = false;
				flage = false;
			}
			if ($("#marks" + i + "").val() > $("#maxMarks" + i + "").val()) {
				maxminFlag = false;
				flage = false;
			}
		}
		if (!maxminFlag) {
			alert("Gain marks not be greater than Max Marks");
		}

		if (!numaricFlag) {
			alert("Max Marks and marks must be in numeric form");
		}
		return flage;
	}
	function getMonth() {
		if ('${ROLE}' != 'ROLE_EMPLOYEE') {
			$.ajax({
				type : "POST",
				url : '${base_url}getMonths',
				success : function(data, status) {
					$("#classId").empty();
					$("#sectionId").empty();
					$("#studentId").empty();
					$("#maxMarks0").val('');
					$("#marks0").val('');
					$("#markstable").empty();
					$("#sub3").hide();
					var obj = JSON.parse(data);
					var classId = '<option value="">select aclass</option>';
					$.each(obj, function(key, value) {
						classId += '<option value="'+value.classId+'">'
								+ value.className + '</option>';
					});
					$("#classId").append(classId);
				},
				error : function(e) {

				}
			});
		}

	}
	function deleteraw() {
		$("#sub3").hide();
	}
</script>
<div class="content">
	<div id="content-header" style="height: 150px;">
		<img alt="Show_settings"
			src="${img_url}/employeeImages/createmonthlyexamreport.png"
			style="width: 50px; margin-top: -12px;">
		<h1>Assing Marks</h1>
		<h3>Makes Report For Monthly Marks</h3>
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
	<br>
	<c:if test="${msg!=null}">
		<div id="successmsg">${msg}</div>
	</c:if>
	<f:form commandName="MonthlyExamReportDTO" method="post"
		action="assign-marks-to-student.html">
		<div id="searches" style="height: auto; width: auto;">
			<table>
				<tr>
					<td style="width: 200px;">Session</td>
					<td><f:select id="sessionId" class="validate[required]"
							required="required" onchange="getClear();" style="width: 250px;"
							path="sessionId">
							<c:forEach var="list" items="${sessionList}">
								<c:choose>
									<c:when test="${current.sessionId==list.sessionId}">
										<option value="${list.sessionId}" selected="selected">${list.sessionDuration}</option>
									</c:when>
									<c:otherwise>
										<option value="${list.sessionId}">${list.sessionDuration}</option>
									</c:otherwise>
								</c:choose>

							</c:forEach>
						</f:select></td>
				</tr>
				<tr>
					<td style="width: 200px;">Month</td>
					<td><f:select id="monthId" class="validate[required]"
							onchange="getMonth();" required="required" style="width: 250px;"
							name="monthId" path="monthId">
							<option value="">Select a month</option>
							<c:forEach var="list" items="${monthList}" begin="0" end="11">
								<option value="${list.monthId}">${list.monthName}</option>
							</c:forEach>
						</f:select></td>
				</tr>
				<tr>
					<td style="width: 200px;">Class</td>
					<td><f:select id="classId" class="validate[required]"
							required="required" style="width: 250px;"
							onchange="getSectionList(this.value);" path="classId">
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
						</f:select></td>
				</tr>
				<tr>
					<td style="width: 200px;">Section</td>
					<td><f:select id="sectionId" class="validate[required]"
							required="required" onchange="getSubjectList();"
							style="width: 250px;" path="sectionId">
							<c:choose>
								<c:when test="${ROLE=='ROLE_EMPLOYEE'}">
									<option value="${StudentClassesDTO.sectionId}"
										selected="selected">${StudentClassesDTO.sectionName}</option>
								</c:when>
								<c:otherwise>
									<option value="">Select a Section</option>
								</c:otherwise>
							</c:choose>
						</f:select></td>
				</tr>
			</table>

			<div id="subjectsId"></div>
			<div id="examReport"></div>



			<%-- div id="sub3" style="display: none; width: 620px; z-index: 1;">
				<TABLE id="dataTable" border="1">
					<tr>
						<th style="height: 32px;">Subjects</th>
						<th>Max Marks</th>
						<th>Gain Marks</th>
						<th>Add More</th>
						<th>Remove</th>
					</tr>
					<TR id="tablerow0">

						<script type="text/javascript">
							var selectedItems = [];

							function addRow(count) {
								var a = "#subjectId" + (count - 1) + "";
								var subjectId = $('' + a + '').val();
								selectedItems.push(subjectId);
								if (subjectId == ''
										|| $("#maxMarks" + (count - 1) + "")
												.val() == ""
										|| $("#marks" + (count - 1) + "").val() == "") {
									alert("Please select all subject ,max Marks, gain marks");
								} else {
									var table = document
											.getElementById("dataTable");
									var rowCount = table.rows.length;
									var row = table.insertRow(rowCount);

									var array = document
											.getElementById("subjectId0").options;
									if (count <= array.length - 2) {
										var element1 = document
												.createElement("select");
										element1.id = "subjectId" + count;
										element1.name = 'subjectMarksDTOs['
												+ count + '].subjectId';

										var cell1 = row.insertCell(0);
										cell1.appendChild(element1);

										for (var i = 0; i < array.length; i++) {
											if (jQuery.inArray(array[i].value,
													selectedItems) == -1) {
												var option = document
														.createElement("option");
												option.value = array[i].value;
												option.text = array[i].text;
												element1.appendChild(option);
											}
										}

										var cell2 = row.insertCell(1);
										var element3 = document
												.createElement("input");
										element3.className = "maxMarks"
										element3.id = "maxMarks" + count + "";
										element3.type = "text";
										element3.name = 'subjectMarksDTOs['
												+ count + '].maxMarks';
										cell2.appendChild(element3);

										var cell3 = row.insertCell(2);
										var element2 = document
												.createElement("input");
										element2.className = "marks"
										element2.id = "marks" + count + "";
										element2.type = "text";
										element2.name = 'subjectMarksDTOs['
												+ count + '].gainMarks';
										cell3.appendChild(element2);

										var cell4 = row.insertCell(3);
										var element4 = document
												.createElement("a");
										element4.setAttribute('title',
												'addmore');
										element4.setAttribute('class', 'btn');
										element4.setAttribute('type', 'button');
										element4.setAttribute('Name',
												'Add more');
										element4.innerHTML = "Add More";
										element4.setAttribute('onclick',
												'addRow(' + (count + 1) + ')');
										if (count <= array.length - 3) {
											element4.setAttribute('href',
													'javascript:incHeight()');
										}
										cell4.appendChild(element4);

										var cell5 = row.insertCell(4);
										var element5 = document
												.createElement("a");
										element5
												.setAttribute('title', 'delete');
										element5.setAttribute('class', 'btn');
										element5.setAttribute('type', 'button');
										element5.setAttribute('Name', 'delete');
										element5.innerHTML = "Delete";
										element5.setAttribute('onclick',
												'deleteRow(this)');
										element5.setAttribute('href',
												'javascript:incLow()');

										cell5.appendChild(element5);
									}
								}
							}
						</script>

						<td><f:select id="subjectId0" class="validate[required]"
								required="required" onchange="checkformarksassign(this.value);"
								style="width: 150px;" path="subjectMarksDTOs[0].subjectId">
								<option value="">Select Subjects</option>
							</f:select></td>
						<TD><f:input class="maxMarks" required="true"
								style="width: 150px;" path="subjectMarksDTOs[0].maxMarks"
								id="maxMarks0" /></TD>
						<TD><f:input class="marks" required="true"
								style="width: 150px;" path="subjectMarksDTOs[0].gainMarks"
								id="marks0" /></TD>
						<TD><a href="javascript:addRow(1);" class="btn"
							onClick="incHeight(1)">Add More</a></TD>
						<TD><a href="javascript:deleteraw();" class="btn">Delete</a></TD>
					</TR>
				</TABLE>
			</div>
			<div id="overlap"
				style="z-index: 2; opacity: 1; height: 37px; width: 610px; position: absolute; top: 329px;"></div>
			<!-- <div
				style="height: auto; position: static; margin-top: 20px; margin-left: 200px">
				<div id="appendmsg"></div>
				<button id="assignbutton" class="btn" type="submit">Assign</button>
			</div> --> --%>
		</div>
	</f:form>
	<div style="width: 48%; float: right;">
		<div id="Student"></div>
	</div>
	<hr>
	<div class="row-fluid">
		<div class="span12">
			<div class="block" id="markstable"></div>
		</div>
	</div>
</div>