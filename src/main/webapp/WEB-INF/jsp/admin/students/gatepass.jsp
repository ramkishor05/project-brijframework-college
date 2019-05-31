<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/style" var="styleurl" />
<spring:url value="/css" var="css_url" />
<c:url value="/style/theme/images/back.png" var="backurl" />
<spring:url value="/img" var="img" />
<spring:url value="/img" var="img_url" />
<c:url value="/style/theme/images/" var="StudentDetailLogo" />
<link rel="stylesheet" type="text/css" href="${css_url}/admission.css">
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>


<script>
	function showselectform(value) {
		$("#gatePassDetails").empty();
		$("#previousDetails").empty();
		$("#studentData").empty();
		$("#leavingWith").val('');
		$("#reason").val('');
		$("#gatePasses").hide();
		if (value == 'unique') {
			$("#uniquevalue").val('');
			$("#unique").show();
		} else {
			$("#unique").hide();
		}
		if (value == 'searches') {
			$("#sectionId").val('');
			$("#studentId").val('');
			$("#searches").show();
		} else {
			$("#searches").hide();
		}
	}

	function getSectionList(id) {
			$("#gatePassDetails").empty();
			$("#previousDetails").empty();
			$("#studentData").empty();
			$("#leavingWith").val('');
			$("#reason").val('');
			$("#gatePasses").hide();
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
					$("#studentId").empty();
					var j = JSON.parse(data);
					var students = '<option value="">Select Student</option>';
					for (var i = 0; i < j.length; i++) {
						students += '<option value='+j[i].admissionNo+'>'
								+ j[i].fullName + '</option>';
					}
					$("#studentId").append(students);
				},
				error : function(e) {

				}
			});
		}
	}

	function getStudentsGatePassbyId(studentId)

	{
		$.ajax({
			type : "post",
			url : 'get-student-admissionNo',
			data : {
				'studentId' : studentId,

			},
			success : function(data, status) {

				var j = JSON.parse(data);
				getStudentsGatePass(j);

			},
			error : function(e) {

			}
		});
	}
	function getStudentsGatePass(admno) {
		getPreviousDetails(admno);
		$("#gatePassDetails").empty();
		$("#studentData").empty();
		$("#leavingWith").val('');
		$("#reason").val('');
		$("#gatePasses").hide();
		$("#admno").val(admno);

		$
				.ajax({
					type : "post",
					url : 'get-student-gatePass',
					data : {
						'id' : admno,

					},
					success : function(data, status) {

						var student = JSON.parse(data);
					
						var studata = '<fieldset  12px;"="" margin-bottom:="" -4px;="" margin-top:="" 60px;="" margin-left:="" 541px;="" width:="" 110px;="" height:="" style="width: 625px; margin-bottom: 25px;"><legend style="color: gray;">Student Details</legend>';
						studata += '<table style="width: 530px; margin-left: 10px; margin-top: 7px;"><tr><td style="width: 123px;"><span><font size="2"><b>Name :</b></td><td colspan="2" style="width: 182px;"><span><font size="2">'
								+ student.firstName
								+ '\t'
								+ student.middleName
								+ '\t'
								+ student.lastName
								+ '</font></span></td><td rowspan="3"><img src="${img}/studentImages/'+student.imageName+'"'
					+'style="width: 127px; height: 124px;"></td></tr><tr><td><span><font size="2"><b>Father Name:</font></span></b></td><td style="width: 369px;"colspan="3"><span><font size="2">'
								+ student.fatherName
								+ '</font></span></td></tr><tr><td><span><font size="2"><b>Mother Name:</font></span></b></td><td style="width: 369px;"colspan="3"><span><font size="2">'
								+ student.motherName
								+ '</font></span></td></tr><tr><td><span><font size="2"><b>Student Id:</font></span></b></td><td ><span><font size="2">';
						if (student.studentId == '')
							studata += '-';
						else
							studata += student.studentId;
						studata += '</font></span></td><td style="width: 79px;"></tr><tr><td><span><font size="2"><b>Mobile No:</font></span></b></td><td colspan="2"><span><font size="2">'
								+ student.mobile
								+ '</font></span></td></tr></table></fieldset><hr>';
						$("#studentData").append(studata);
						var parent = '<table style="width: 644px;"><tr><td>Father</td><td>Mother</td><td>Guardian</td></tr><tr><td><img style="width: 143px; height: 124px;"'
						+'src="${img}/parentImages/'+student.photo1name+'"></td><td><img src="${img}/parentImages/'+student.photo2name+'"'
						+'style="width: 143px; height: 124px;"></td><td><img src="${img}/parentImages/'+student.photo3name+'"'
						+'style="width: 143px; height: 124px;"></td></tr><tr><td>'
								+ student.fatherName
								+ '</td><td>'
								+ student.motherName
								+ '</td><td>'
								+ student.guardianName
								+ '</td></tr></table>';
								
						$("#gatePassDetails").append(parent);
						$("#gatePasses").show(); 
					

					},
					error : function(e) {

					}
				});
		
	}
	
	function getVaildate()
	{
		var flag=true;
		var parent=$("#leavingWith").val();
		var reason=$("#reason").val();
		if(parent=='')
			{
			$("#leavemsg").append('<span><font size="2" color="red">Select Accompanied By</font></span>');
			flag=false;
			}
		if(reason=='')
			{
			$("#reasonmsg").append('<span><font size="2" color="red">This field is required</font></span>');
			flag=false;
			}
		if(flag==true)
			{
			$("#submitform").submit();
			document.location.href="generate-gatepass";
		
			}
		
			
	}
	
	function getPreviousDetails(id) {
		$("#previousDetails").empty();
	
		
		$
		.ajax({
			type : "post",
			url : 'get-previous-gatePass',
			data : {
				'id' : id,

			},
					success : function(data, status) {
						
						var j = JSON.parse(data);
						var st = "";
						var length = j.length;
						if (length == 0) {
							st = '<div class="failedmsg">No Previous Details found</div>';
						} else {

							st = st
									+ '<div><div class="widget-body"  style="padding: 10px 0px 0px; margin-top: -50px;"><div class="separator"></div><div class="btn-group" style="width: 400px;">'
									+ '</div><div class="block"><div class="head blue" style="width: 335px; margin-top: 66px;"><h4 style="text-align:center">Past Details</h4></div>'
									+ '<table class="table table-bordered table-primary"><thead><tr><th>Date</th><th>Time</th><th>Accompanied By</th><th>Reason</th></tr></thead><tbody>';
							for ( var i = 0; i < length; i++) {
								st += '<tr><td>' + j[i].leavingDate
										+ '</td><td>' + j[i].leavingTime
										+ '</td><td>' + j[i].leavingWith
										+ '</td><td>' + j[i].reason
										+ '</td></tr>';
							}
							st += '</table>';
									}
						
						$("#previousDetails").append(st);
					},
					error : function(error, status) {
					}
				});
	}
</script>

<div class="content">
	<div id="content-header" style="height: 150px;">
		<img alt="Show_settings" src="${img_url}/gates.png"
			 style="width: 126px;">
		<h1>Gate Pass</h1>
		<h3>Generate Gate Pass</h3>
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




	<div>
		<input type="radio" name="radiabutton"
			onclick="showselectform('unique');"> By Student's Id <input
			type="radio" name="radiabutton" onclick="showselectform('searches');">
		Class Wise
	</div>
	<br>
	<div id="unique" style="display: none;">
		<table>
			<tr>
				<td style="width: 195px;">Enter Student Id</td>
				<td><input type="text" id="uniquevalue" style="width: 250px;"
					onkeyup="getStudentsGatePassbyId(this.value);"></td>
			</tr>
		</table>

	</div>
	<div id="searches" style="height: auto; width: auto; display: none;">
		<table>
			<tr>
				<td style="width: 200px;">Session</td>
				<td><select id="sessionId" class="validate[required]"
					onchange="getClear();" style="width: 250px;" name="sessionId"
					class="select">
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
				<td style="width: 200px;">Class</td>
				<td><select id="classId" class="validate[required]"
					style="width: 250px;" onchange="getSectionList(this.value);"
					name="classId" class="select">
						<option value="">Select a Class</option>
						<c:forEach var="list" items="${classList}">
							<option value="${list.classId}">${list.className}</option>
						</c:forEach>
				</select></td>
			</tr>

			<tr>
				<td style="width: 200px;">Section</td>
				<td><select id="sectionId" class="validate[required]"
					onchange="getStudentList();" style="width: 250px;" name="sectionId"
					class="select">
						<option value="">Select a Section</option>
				</select></td>
			</tr>

			<tr>
				<td style="width: 200px;">Students</td>
				<td><select id="studentId" class="validate[required]"
					onchange="getStudentsGatePass(this.value);" style="width: 250px;"
					name="studentAdmissionNo" class="select">
						<option value="">Select Student</option>
				</select></td>
			</tr>

		</table>
		</div>
		<div>
		
			<div  id="previousDetails" style="float: right; width: 348px;"></div>
		
		<div id="studentData" style="width: 632px;"></div>

	<div id="gatePassDetails"
		style="float: left; width: 590px; margin-top: 46px; margin-left: 67px;"></div>
		
		
		</div>
		<div id="gatePasses" style="float: left; display: none; width: 598px; margin-left: 88px; margin-top: 59px;">
		<table style="width: 1059px; height: 200px;">
			<f:form action="save-gatePass" id="submitform"
				 commandName="gatePassDTO" target="_blank" method="POST">
				<tr>
					<td style="width: 200px;">Gate Pass No.</td>
					<td><input id="gatePassId" maxlength="35" name="gatePassId"
						readonly="readonly"
						style="width: 245px; border: 1px solid lightgray;" value="${gpno}"></td>
					<td></td>
				</tr>
				<tr>
					<td style="width: 200px;">Date</td>
					<td style="width: 272px;"><input id="leavingDate"
						maxlength="35" name="leavingDate" readonly="readonly"
						style="width: 245px; border: 1px solid lightgray;"
						value="${dates}"></td>
					<td style="width: 79px;"></td>
					<td></td>
				</tr>
				<tr>
					<td style="width: 200px;">Time</td>
					<td style="width: 272px;"><input id="leavingTime"
						maxlength="35" name="leavingTime" readonly="readonly"
						style="width: 245px; border: 1px solid lightgray;"
						value="${times}"></td>
					<td style="width: 79px;"><f:hidden path="admissionNo" id="admno"/></td>
					<td></td>
				</tr>
				<tr>
					<td style="width: 200px;">Leaving With</td>
					<td><select id="leavingWith" class="validate[required]"
						style="width: 250px;" name="leavingWith" class="select">
							<option value="">Select Accompanied By</option>

							<option value="Father">Father</option>
							<option value="Mother">Mother</option>
							<option value="Guardian">Guardian</option>

					</select></td>
					<td colspan="2"><div id="leavemsg"></div></td>

				</tr>
				<tr>
					<td style="width: 200px;">Reason/Remarks</td>
					<td><f:input id="reason" maxlength="50" path="reason"
							 required="required" style="width: 250px;" /></td>
					<td colspan="2"><div id="reasonmsg"></div></td>

				</tr>
				
				
				<tr>

					<td></td>
					<td><a href="javascript:getVaildate();"><span class="btn btn-success" style="margin-top: 10px;">Submit</span></a></td>
				</tr>
			</f:form>
		</table>
</div>
		<div class="separator"></div>
	</div>
	<hr>

	




